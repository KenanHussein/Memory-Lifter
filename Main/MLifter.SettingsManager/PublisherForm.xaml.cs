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
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using MLifter.Generics;
using System.Data.SqlServerCe;
using MLifter.DAL.DB.MsSqlCe;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using System.Security.Cryptography;
using System.Diagnostics;
using MLifter.BusinessLayer;
using MLifterSettingsManager.DAL;

namespace MLifterSettingsManager
{
    /// <summary>
    /// Interaction logic for PublisherForm.xaml
    /// </summary>
    public partial class PublisherForm : Window
    {
        private string lmFile;

        /// <summary>
        /// Initializes a new instance of the <see cref="PublisherForm"/> class.
        /// </summary>
        /// <param name="learningModulePath">The learning module path.</param>
        /// <remarks>Documented by Dev05, 2009-05-22</remarks>
        public PublisherForm(string learningModulePath)
        {
            InitializeComponent();
            lmFile = learningModulePath;
        }

        /// <summary>
        /// Handles the Click event of the buttonCancel control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
        /// <remarks>Documented by Dev07, 2009-05-20</remarks>
        private void buttonCancel_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        /// <summary>
        /// Handles the Click event of the buttonPublish control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
        /// <remarks>Documented by Dev07, 2009-05-20</remarks>
        private void buttonPublish_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                labelStatus.Content = "Please wait. Saving module...";
                IsEnabled = false;
                System.Windows.Forms.Application.DoEvents();

                //open dialog to save published LM
                System.Windows.Forms.SaveFileDialog saveDialog = new System.Windows.Forms.SaveFileDialog();
                saveDialog.FileName = lmFile;
                saveDialog.Filter = "MemoryLifter Learning Module (*.mlm)|*.mlm";
                if (saveDialog.ShowDialog() == System.Windows.Forms.DialogResult.OK)
                {
                    if (!Publisher.CopyLM(lmFile, saveDialog.FileName))
                    {
                        MessageBox.Show("Cannot copy the LM to the selected folder, please try again!", "Error!", MessageBoxButton.OK, MessageBoxImage.Error);
                        return;
                    }
                    if (!Publisher.DeleteUserProfiles(saveDialog.FileName))
                    {
                        MessageBox.Show("Cannot delete existing User Profiles, please contact the Development Team!", "Error!", MessageBoxButton.OK, MessageBoxImage.Error);
                        return;
                    }

                    MessageBox.Show("LM was succesfully published!", "Success!", MessageBoxButton.OK, MessageBoxImage.Information);
                }
            }
            finally { IsEnabled = true; labelStatus.Content = null; }
        }
    }
}
