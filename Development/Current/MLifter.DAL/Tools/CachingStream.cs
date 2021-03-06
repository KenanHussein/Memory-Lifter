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
using System.IO;
using MLifter.DAL.Interfaces.DB;

namespace MLifter.DAL
{
	/// <summary>
	/// Stream that copy his content into the local db before closing/disposing.
	/// </summary>
	/// <remarks>Documented by Dev05, 2009-03-30</remarks>
	internal class CachingStream : MemoryStream
	{
		private int MediaId;
		private Guid ExtensionId;

		private bool saved = false;

		private IDbMediaConnector MediaConnector;
		private IDbExtensionConnector ExtensionConnector;

		/// <summary>
		/// Initializes a new instance of the <see cref="CachingStream"/> class.
		/// </summary>
		/// <param name="buffer">The buffer.</param>
		/// <param name="id">The id.</param>
		/// <param name="connector">The media connector.</param>
		/// <remarks>
		/// Documented by CFI, 2009-03-30
		/// </remarks>
		public CachingStream(byte[] buffer, int id, IDbMediaConnector connector)
			: base(buffer)
		{
			MediaId = id;
			MediaConnector = connector;
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="CachingStream"/> class.
		/// </summary>
		/// <param name="buffer">The buffer.</param>
		/// <param name="id">The id.</param>
		/// <param name="connector">The extension connector.</param>
		/// <remarks>Documented by Dev02, 2009-07-06</remarks>
		public CachingStream(byte[] buffer, Guid id, IDbExtensionConnector connector)
			: base(buffer)
		{
			ExtensionId = id;
			ExtensionConnector = connector;
		}

		/// <summary>
		/// Saves to db.
		/// </summary>
		/// <remarks>Documented by Dev02, 2009-07-06</remarks>
		private void SaveToDb()
		{
			if (saved || !(MediaConnector == null ^ ExtensionConnector == null))
				return;

			saved = true;

			Seek(0, SeekOrigin.Begin);

			if (MediaConnector != null)
				MediaConnector.UpdateMedia(MediaId, this);

			if (ExtensionConnector != null)
				ExtensionConnector.SetExtensionStream(ExtensionId, this);
		}

		/// <summary>
		/// Closes the current stream and releases any resources (such as sockets and file handles) associated with the current stream.
		/// </summary>
		/// <remarks>Documented by Dev05, 2009-03-30</remarks>
		public override void Close()
		{
			SaveToDb();

			base.Close();
		}

		/// <summary>
		/// Releases the unmanaged resources used by the <see cref="T:System.IO.Stream"/> and optionally releases the managed resources.
		/// </summary>
		/// <param name="disposing">true to release both managed and unmanaged resources; false to release only unmanaged resources.</param>
		/// <remarks>Documented by Dev05, 2009-03-30</remarks>
		protected override void Dispose(bool disposing)
		{
			SaveToDb();

			base.Dispose(disposing);
		}
	}
}
