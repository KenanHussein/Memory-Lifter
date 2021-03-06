/***************************************************************************************************************************************
 * Copyright (C) 2001-2012 LearnLift USA																	*
 * Contact: Learnlift USA, 12 Greenway Plaza, Suite 1510, Houston, Texas 77046, support@memorylifter.com					*
 *																								*
 * This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License	*
 * as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.			*
 *																								*
 * This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty	*
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more details.	*
 *																								*
 * You should have received a copy of the GNU Lesser General Public License along with this library; if not,					*
 * write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA					*
 ***************************************************************************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;

using MLifter.BusinessLayer;
using MLifter.Controls;
using MLifter.Components;
using MLifter.DAL;
using MLifter.DAL.Interfaces;
using MLifter.DAL.Tools;

namespace MLifter.GenerateTestData.BL
{
    /// <summary>
    /// TestDataGenerator class
    /// </summary>
    /// <remarks>Documented by Dev03, 2008-11-28</remarks>
    internal class TestDataGenerator
    {
        private LearnLogic m_learnLogic;
        private ConnectionStringStruct m_connectionString;
        private Random rand = new Random((int)DateTime.Now.Ticks);

        internal event TestStatusEventHandler TestStatusProgressChanged;

        /// <summary>
        /// Initializes a new instance of the <see cref="TestDataGenerator"/> class.
        /// </summary>
        /// <param name="connectionString">The connection string.</param>
        /// <remarks>Documented by Dev03, 2008-11-28</remarks>
        internal TestDataGenerator(LearnLogic learnLogic)
        {
            m_learnLogic = learnLogic;
        }

        internal Dictionary CurrentDictionary
        {
            get
            {
                return m_learnLogic.User.Dictionary;
            }
        }


        /// <summary>
        /// Takes care of data access errors.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="exp">The exp.</param>
        /// <remarks>Documented by Dev03, 2009-03-02</remarks>
        private void DataAccessError(object sender, Exception exp)
        {
            throw exp;
        }

        /// <summary>
        /// Generates the test data.
        /// </summary>
        /// <param name="learningModules">The learning modules.</param>
        /// <param name="sessions">The sessions.</param>
        /// <param name="cardsPerSession">The cards per session.</param>
        /// <remarks>Documented by Dev03, 2008-11-18</remarks>
        internal void Generate(List<int> learningModules, int sessions, int cardsPerSession)
        {
            UserInputSubmitEventArgs e;

            TestStatusEventArgs args = new TestStatusEventArgs(sessions * cardsPerSession);
            ConnectionStringStruct css = m_learnLogic.CurrentLearningModule.ConnectionString;
            foreach (int id in learningModules)
            {
                m_connectionString.LmId = id;
                for (int i = 0; i < sessions; i++)
                {
                    css.LmId = id;
                    m_learnLogic.OpenLearningModule(new LearningModulesIndexEntry(css));
                    m_learnLogic.User.Dictionary.Settings.SelfAssessment = false;
                    for (int k = (i * cardsPerSession); k < (i * cardsPerSession) + cardsPerSession; k++)
                    {
                        m_learnLogic.OnLearningModuleOptionsChanged();
                        Card card = m_learnLogic.Dictionary.Cards.GetCardByID(m_learnLogic.CurrentCardID);

                        if (GetRandomBool())
                            e = new UserInputSubmitTextEventArgs(0, card.CurrentAnswer.Words.Count, card.CurrentAnswer.Words.Count, true, card.CurrentAnswer.Words.ToString());
                        else
                            e = new UserInputSubmitTextEventArgs(5, 0, 5, false, string.Empty);
                        m_learnLogic.OnUserInputSubmit(this, e);

                        if ((k % 10) == 0)
                        {
                            args.Progress = (k + 1) * (i + 1);
                            UpdateStatusMessage(args);
                        }
                    }
                    m_learnLogic.CloseLearningModule();
                }
            }
        }

        private void UpdateStatusMessage(TestStatusEventArgs args)
        {
            if (TestStatusProgressChanged != null) TestStatusProgressChanged(this, args);
        }

        private bool GetRandomBool()
        {
            return (rand.Next(2) == 0);
        }
    }
}
