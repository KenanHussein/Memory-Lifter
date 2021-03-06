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
using System.Xml;
using System.Xml.Serialization;
using System.Drawing;
using System.ComponentModel;
using System.Text.RegularExpressions;

namespace MLifter.Components
{
    /// <summary>
    /// Dictionary which could be (de)serialized.
    /// </summary>
    /// <typeparam name="TKey">The type of the key.</typeparam>
    /// <typeparam name="TValue">The type of the value.</typeparam>
    /// <remarks>Documented by Dev05, 2007-08-10</remarks>
    [Serializable]
    public class SerializableDictionary<TKey, TValue> : Dictionary<TKey, TValue>, IXmlSerializable
    {
        private bool keyIsAtomic = false;
        private bool valueIsAtomic = false;
        private XmlSerializer keySerializer;
        private XmlSerializer valueSerializer;

        /// <summary>
        /// Initializes a new instance of the <see cref="SerializableDictionary&lt;TKey, TValue&gt;"/> class.
        /// </summary>
        /// <remarks>Documented by Dev05, 2007-11-08</remarks>
        public SerializableDictionary()
        {
            if (TypeIsAtomic(typeof(TKey)))
                keyIsAtomic = true;
            else
                keySerializer = new XmlSerializer(typeof(TKey));

            if (TypeIsAtomic(typeof(TValue)))
                valueIsAtomic = true;
            else
                valueSerializer = new XmlSerializer(typeof(TValue));
        }

        /// <summary>
        /// This property is reserved, apply the <see cref="T:System.Xml.Serialization.XmlSchemaProviderAttribute"></see> to the class instead.
        /// </summary>
        /// <returns>
        /// An <see cref="T:System.Xml.Schema.XmlSchema"></see> that describes the XML representation of the object that is produced by the <see cref="M:System.Xml.Serialization.IXmlSerializable.WriteXml(System.Xml.XmlWriter)"></see> method and consumed by the <see cref="M:System.Xml.Serialization.IXmlSerializable.ReadXml(System.Xml.XmlReader)"></see> method.
        /// </returns>
        /// <remarks>Documented by Dev05, 2007-08-08</remarks>
        public System.Xml.Schema.XmlSchema GetSchema()
        {
            return null;
        }

        /// <summary>
        /// Generates an object from its XML representation.
        /// </summary>
        /// <param name="reader">The <see cref="T:System.Xml.XmlReader"></see> stream from which the object is deserialized.</param>
        /// <remarks>Documented by Dev05, 2007-08-08</remarks>
        public void ReadXml(XmlReader reader)
        {
            bool wasEmpty = reader.IsEmptyElement;
            reader.Read();

            if (wasEmpty)
            {
                return;
            }

            while (reader.NodeType != XmlNodeType.EndElement)
            {
                reader.ReadStartElement("item");

                TKey key;
                if (keyIsAtomic) //Shorter version, but works only for simple types (int, string, enum, Color, Font, ...)
                    key = (TKey)GetValue(typeof(TKey), reader.ReadElementString("key"));
                else
                {
                    reader.ReadStartElement("key");
                    key = (TKey)keySerializer.Deserialize(reader);
                    reader.ReadEndElement();
                }

                TValue value;
                if (valueIsAtomic)  //Shorter version, but works only for simple types (int, string, enum, Color, Font, ...)
                    value = (TValue)GetValue(typeof(TValue), reader.ReadElementString("value"));
                else
                {
                    reader.ReadStartElement("value");
                    value = (TValue)valueSerializer.Deserialize(reader);
                    reader.ReadEndElement();
                }

                this.Add(key, value);

                reader.ReadEndElement();
                reader.MoveToContent();
            }
            reader.ReadEndElement();
        }

        /// <summary>
        /// Parses the specified string read form the XML and returns the value
        /// it represents as the specified type.
        /// </summary>
        /// <param name="type">The type.</param>
        /// <param name="value">The value.</param>
        /// <returns></returns>
        /// <remarks>Documented by Dev05, 2007-08-08</remarks>
        private object GetValue(Type type, string value)
        {
            if (type == typeof(string))
            {
                return value;
            }
            else if (type == typeof(bool))
            {
                return Convert.ToBoolean(value);
            }
            else if (type.IsEnum)
            {
                return Enum.Parse(type, value, true);
            }
            else if (type == typeof(Color))
            {
                //Regex regEx = new Regex(@"A=(?<AV>\d{1,3}),\s*R=(?<RV>\d{1,3}),\s*G=(?<GV>\d{1,3}),\s*B=(?<BV>\d{1,3})");
                //Match match = regEx.Match(value);

                //if (match.Success)
                //    return Color.FromArgb(Convert.ToInt32(match.Groups["AV"].Value), Convert.ToInt32(match.Groups["RV"].Value),
                //        Convert.ToInt32(match.Groups["GV"].Value), Convert.ToInt32(match.Groups["BV"].Value));
                //else
                //{
                //    regEx = new Regex(@"\[(?<NAME>\w+)\]");
                //    match = regEx.Match(value);

                //    if (match.Success)
                //        return Color.FromName(match.Groups["NAME"].Value);
                //    else
                //        return Color.Empty;
                //}

                return GetFromInvariantString(type, value);
            }
            else if (type == typeof(DateTime))
            {
                if (value.Length == 0)
                {
                    return DateTime.MinValue;
                }
                else
                {
                    return DateTime.Parse(value);
                }
            }
            else if (type == typeof(TimeSpan))
            {
                return TimeSpan.Parse(value);
            }
            else if (type == typeof(Int16))
            {
                return Convert.ToInt16(value);
            }
            else if (type == typeof(Int32))
            {
                return Convert.ToInt32(value);
            }
            else if (type == typeof(Int64))
            {
                return Convert.ToInt64(value);
            }
            else if (type == typeof(float))
            {
                return Convert.ToSingle(value);
            }
            else if (type == typeof(double))
            {
                return Convert.ToDouble(value);
            }
            else if (type == typeof(decimal))
            {
                return Convert.ToDecimal(value);
            }
            else if (type == typeof(char))
            {
                return Convert.ToChar(value);
            }
            else if (type == typeof(byte))
            {
                return Convert.ToByte(value);
            }
            else if (type == typeof(UInt16))
            {
                return Convert.ToUInt16(value);
            }
            else if (type == typeof(UInt32))
            {
                return Convert.ToUInt32(value);
            }
            else if (type == typeof(UInt64))
            {
                return Convert.ToUInt64(value);
            }
            else if (type == typeof(Guid))
            {
                return new Guid(value);
            }
            else
            {
                return GetFromInvariantString(type, value);
            }
        }

        /// <summary>
        /// Gets the object from the invariant string.
        /// </summary>
        /// <param name="type">The type.</param>
        /// <param name="value">The value.</param>
        /// <returns></returns>
        /// <remarks>Documented by Dev05, 2007-08-13</remarks>
        private object GetFromInvariantString(Type type, string value)
        {
            TypeConverter converter = TypeDescriptor.GetConverter(type);
            return converter.ConvertFromInvariantString(value);
        }

        /// <summary>
        /// Converts an object into its XML representation.
        /// </summary>
        /// <param name="writer">The <see cref="T:System.Xml.XmlWriter"></see> stream to which the object is serialized.</param>
        /// <remarks>Documented by Dev05, 2007-08-08</remarks>
        public void WriteXml(XmlWriter writer)
        {
            foreach (TKey key in this.Keys)
            {
                writer.WriteStartElement("item");

                if (keyIsAtomic)    //Shorter version, but works only for simple types (int, string, enum, Color, Font, ...)
                    writer.WriteElementString("key", GetString(typeof(TKey), key));
                else
                {
                    writer.WriteStartElement("key");
                    keySerializer.Serialize(writer, key);
                    writer.WriteEndElement();
                }

                if (valueIsAtomic)  //Shorter version, but works only for simple types (int, string, enum, Color, Font, ...)
                    writer.WriteElementString("value", GetString(typeof(TValue), this[key]));
                else
                {
                    writer.WriteStartElement("value");
                    TValue value = this[key];
                    valueSerializer.Serialize(writer, value);
                    writer.WriteEndElement();
                }

                writer.WriteEndElement();
            }
        }

        /// <summary>
        /// Gets the string representing the given object.
        /// </summary>
        /// <param name="type">The type.</param>
        /// <param name="value">The value.</param>
        /// <returns></returns>
        /// <remarks>Documented by Dev05, 2007-08-13</remarks>
        private string GetString(Type type, object value)
        {
            if (type == typeof(string))
            {
                return (string)value;
            }
            else if (type == typeof(bool) || type.IsEnum || type == typeof(DateTime) || type == typeof(TimeSpan) ||
                type == typeof(Int16) || type == typeof(Int32) || type == typeof(Int64) || type == typeof(float) || type == typeof(double) ||
                type == typeof(decimal) || type == typeof(char) || type == typeof(byte) || type == typeof(UInt16) || type == typeof(UInt32) ||
                type == typeof(UInt64) || type == typeof(Guid) /*|| type == typeof(Color)*/)
            {
                return value.ToString();
            }
            else
            {
                return GetInvariantString(type, value);
            }
        }

        /// <summary>
        /// Gets the invariant string of the object.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <returns></returns>
        /// <remarks>Documented by Dev05, 2007-08-13</remarks>
        private string GetInvariantString(Type type, object value)
        {
            TypeConverter converter = TypeDescriptor.GetConverter(type);
            return converter.ConvertToInvariantString(value);
        }

        /// <summary>
        /// Works out which types to treat as attibutes and which the treat as child objects.
        /// </summary>
        /// <param name="type">The Type to check.</param>
        /// <returns>true if the Type is atomic (e.g. string, date, enum or number), false if it is arrayList compound sub-object.</returns>
        /// <exception cref="ArgumentNullException">Thrown if <i>type</i> is null (Nothing in Visual Basic).</exception>
        public static bool TypeIsAtomic(Type type)
        {
            if (type == typeof(string) || TypeIsNumeric(type) || type == typeof(bool) || type == typeof(DateTime) ||
                type == typeof(TimeSpan) || type == typeof(char) || type == typeof(byte) || type.IsSubclassOf(typeof(Enum)) ||
                type == typeof(Guid) || type == typeof(Color) || type == typeof(Font))
            {
                return true;
            }

            return false;
        }

        /// <summary>
        /// Returns true if the specified type is one of the numeric types
        /// (Int16, Int32, Int64, UInt16, UInt32, UInt64, Single, Double, Decimal)
        /// </summary>
        /// <param name="type">The Type to check.</param>
        /// <returns>
        /// true if the specified type is one of the numeric types
        /// (Int16, Int32, Int64, UInt16, UInt32, UInt64, Single, Double, Decimal)
        /// </returns>
        public static bool TypeIsNumeric(Type type)
        {
            if (type == typeof(Int16) || type == typeof(Int32) || type == typeof(Int64) || type == typeof(float) ||
                type == typeof(double) || type == typeof(decimal) || type == typeof(UInt16) || type == typeof(UInt32) ||
                type == typeof(UInt64))
            {
                return true;
            }

            return false;
        }
    }
}
