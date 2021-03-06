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
namespace MLifter.Controls
{
	partial class LearningModulesForm
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing)
		{
			if (disposing && (components != null))
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LearningModulesForm));
			this.MainHelp = new System.Windows.Forms.HelpProvider();
			this.learningModulesPageMain = new MLifter.Controls.LearningModulesPage.LearningModulesPage();
			this.SuspendLayout();
			// 
			// learningModulesPageMain
			// 
			this.learningModulesPageMain.BackColor = System.Drawing.Color.White;
			resources.ApplyResources(this.learningModulesPageMain, "learningModulesPageMain");
			this.learningModulesPageMain.FirstUse = false;
			this.learningModulesPageMain.GeneralConfigurationPath = null;
			this.learningModulesPageMain.MinimumSize = new System.Drawing.Size(780, 530);
			this.learningModulesPageMain.Name = "learningModulesPageMain";
			this.learningModulesPageMain.SelectedLearningModule = null;
			this.MainHelp.SetShowHelp(this.learningModulesPageMain, ((bool)(resources.GetObject("learningModulesPageMain.ShowHelp"))));
			this.learningModulesPageMain.ShowStartPageAtStartup = true;
			this.learningModulesPageMain.UserConfigurationPath = null;
			this.learningModulesPageMain.LearningModuleSelected += new MLifter.Controls.LearningModulesPage.LearningModuleSelectedEventHandler(this.learningModulesPageMain_LearningModuleSelected);
			this.learningModulesPageMain.CancelPressed += new System.EventHandler(this.learningModulesPageMain_CancelPressed);
			this.learningModulesPageMain.NewLearningModulePressed += new System.EventHandler(this.learningModulesPageMain_NewLearningModulePressed);
			// 
			// LearningModulesForm
			// 
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Inherit;
			this.BackColor = System.Drawing.Color.White;
			resources.ApplyResources(this, "$this");
			this.Controls.Add(this.learningModulesPageMain);
			this.MainHelp.SetHelpKeyword(this, resources.GetString("$this.HelpKeyword"));
			this.MainHelp.SetHelpNavigator(this, ((System.Windows.Forms.HelpNavigator)(resources.GetObject("$this.HelpNavigator"))));
			this.MinimizeBox = false;
			this.Name = "LearningModulesForm";
			this.MainHelp.SetShowHelp(this, ((bool)(resources.GetObject("$this.ShowHelp"))));
			this.ShowIcon = false;
			this.ShowInTaskbar = false;
			this.SizeChanged += new System.EventHandler(this.LearningModulesForm_SizeChanged);
			this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.LearningModulesForm_FormClosing);
			this.ResumeLayout(false);

		}

		#endregion

		private LearningModulesPage.LearningModulesPage learningModulesPageMain;
		private System.Windows.Forms.HelpProvider MainHelp;
	}
}
