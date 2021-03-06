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
namespace MLifter.Controls.Wizards.Print
{
    partial class BoxSelectionPage
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(BoxSelectionPage));
            this.radioButtonAll = new System.Windows.Forms.RadioButton();
            this.radioButtonNumbers = new System.Windows.Forms.RadioButton();
            this.radioButtonPool = new System.Windows.Forms.RadioButton();
            this.textBoxNumbers = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // radioButtonAll
            // 
            resources.ApplyResources(this.radioButtonAll, "radioButtonAll");
            this.radioButtonAll.Checked = true;
            this.radioButtonAll.Name = "radioButtonAll";
            this.radioButtonAll.TabStop = true;
            this.radioButtonAll.UseVisualStyleBackColor = true;
            // 
            // radioButtonNumbers
            // 
            resources.ApplyResources(this.radioButtonNumbers, "radioButtonNumbers");
            this.radioButtonNumbers.Name = "radioButtonNumbers";
            this.radioButtonNumbers.TabStop = true;
            this.radioButtonNumbers.UseVisualStyleBackColor = true;
            // 
            // radioButtonPool
            // 
            resources.ApplyResources(this.radioButtonPool, "radioButtonPool");
            this.radioButtonPool.Name = "radioButtonPool";
            this.radioButtonPool.TabStop = true;
            this.radioButtonPool.UseVisualStyleBackColor = true;
            // 
            // textBoxNumbers
            // 
            resources.ApplyResources(this.textBoxNumbers, "textBoxNumbers");
            this.textBoxNumbers.Name = "textBoxNumbers";
            this.textBoxNumbers.TextChanged += new System.EventHandler(this.textBoxNumbers_TextChanged);
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.label1.Name = "label1";
            // 
            // BoxSelectionPage
            // 
            this.Controls.Add(this.label1);
            this.Controls.Add(this.textBoxNumbers);
            this.Controls.Add(this.radioButtonPool);
            this.Controls.Add(this.radioButtonNumbers);
            this.Controls.Add(this.radioButtonAll);
            resources.ApplyResources(this, "$this");
            this.HelpAvailable = true;
            this.Name = "BoxSelectionPage";
            this.TopImage = global::MLifter.Controls.Properties.Resources.banner;
            this.Controls.SetChildIndex(this.radioButtonAll, 0);
            this.Controls.SetChildIndex(this.radioButtonNumbers, 0);
            this.Controls.SetChildIndex(this.radioButtonPool, 0);
            this.Controls.SetChildIndex(this.textBoxNumbers, 0);
            this.Controls.SetChildIndex(this.label1, 0);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.RadioButton radioButtonAll;
        private System.Windows.Forms.RadioButton radioButtonNumbers;
        private System.Windows.Forms.RadioButton radioButtonPool;
        private System.Windows.Forms.TextBox textBoxNumbers;
        private System.Windows.Forms.Label label1;
    }
}
