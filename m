Return-Path: <stable+bounces-192726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD3C40028
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 14:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8753F34D516
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 13:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87D81C84A1;
	Fri,  7 Nov 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cMTVIoIY"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BBA4A1E
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520463; cv=fail; b=mdvj5c/u1gIMLRrdwEBiE+1E2h38wZvG1JGzKzyL8GS98ROzhgoZXvsh6pixfM3OyrE3yGpob8fxumN65rdVDGhab2wVv1hLXqmx5rpdFmmjNkkZYPxUNJDITjN0JTtm/CqL687Zgui4qN8Pj/uQtTG9yDCsraUR8mjlpqaBJvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520463; c=relaxed/simple;
	bh=8Kj1uzizJDsS7xyS+BPNbM9vfqy7XtZSCX30+gxv32o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JFo10gQMD3uJEzKFdfefGKCZQPgf5dx/A8JPblFCUrBRXlIxU6pQlxD0j7TTA5tq5OtpqG6jfqF56flF1aCl3IP4mZtJgeAuASJtovhX+vTMn7tp4vEHW6Wh8xDKrQPf+fb+9+y59h8B+ZB+LAU5N6r1dYaPMJI1Zgdb59Laezk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cMTVIoIY; arc=fail smtp.client-ip=52.101.69.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zsrn/a/GORApsqNyj/qEvxRMvcnl/XpRk/n9O8ZbKZJ5mSWcKYXrQPxbEtBjf0L+8QyXDbinCreIJLX0fhc9pwxqwLE+jpZLMnkRm1rHNZ/YeWifmVD/9Q6Padt5Y4myF4F11Q7wlADFd5GrLK6+dt8ZcZ25gCHSf2e17hgIQOzXAWWRJ8c/6LvKDov/t9HNW9vbXu+xGitcSf6nyIMsehR921t6KXaf3nQhbu5KvXDI4jqtpnHJllIqKSlshwGhXTfHGLHWMKwVtZpvj4O5gYOaAEG9pG1WSyYIOPjtNWTaPWsMCUA7D1TjBjs/sFCrFM8s/Vk23hbBvgibOaSP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Kj1uzizJDsS7xyS+BPNbM9vfqy7XtZSCX30+gxv32o=;
 b=dcd1OfdXAo7tcsUCaDmbnSz1WoN0HbiM3IU264Juahf9c17ZGn+kGpPhJ9vqge3D1dZ51NlGqgE1QsKwGr2CzR8g6Mck/TJ71T8xMxKhL9hDa0ueOa+mZvT+AHz3Jq0mlOsJkZBPeWKZ0PTzMCwkdf8ZRgrsDzsyB0KLQbixP/CsvSQ86uNarzZ7Q3URqH5kCyp9Ae1WTZuLFUWIe+Eo/iU0o4g9/Bc0lRQ0sTWIdtvxFI3vnNie8h5Fk+G9hmG7RLgNUAdX6tDyVlVBaRj3z4/M074lXOUxa7B0mr/ZQ/Gv4au1tyXsLfuPn45pWQVD0pITlzjh0v/wU4vluKKXMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Kj1uzizJDsS7xyS+BPNbM9vfqy7XtZSCX30+gxv32o=;
 b=cMTVIoIYhe892NGaF4HWaZe6jAQRBYCMoz5oIl4Z1STX9gJVu18WsBUDxCRjCWKaiHVB47Utt6yijV3yxibhHzgp2e2BsQQ0ZrJxMgdAUarOx8hyxbfG3RWwmuUJGbVutGZRTtlJDdtfvCRgQIjt/XmXuJ69J2Zy3gMMp5pE5w8idBkAgFXfrFzr4dO5hby1SlL2yHH4B27uE8MFYekjEEGt0niDAilsQKwNYP6DxLPbHsRNw90/8xjm+iH9812QWpRnPbefs3FN2Lux4rC7gi31YORis9EyaDXD5UCbCP6Yn+Y04hn/jpZJ7vbWalde3XgZG8co3J4OMHw/zl/r7Q==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB8PR10MB3815.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:160::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 13:00:54 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9275.013; Fri, 7 Nov 2025
 13:00:54 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "681739313@139.com" <681739313@139.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>
Subject: Re: [PATCH 6.6.y] net: dsa: improve shutdown sequence
Thread-Topic: [PATCH 6.6.y] net: dsa: improve shutdown sequence
Thread-Index: AQHcT5RKM98L2Fix9UW61fSwKvth/7TnLe4A
Date: Fri, 7 Nov 2025 13:00:54 +0000
Message-ID: <7634154b6210d41e80ebc10ad1892ecf35f531bd.camel@siemens.com>
References: <20251107031155.3026-1-681739313@139.com>
In-Reply-To: <20251107031155.3026-1-681739313@139.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB8PR10MB3815:EE_
x-ms-office365-filtering-correlation-id: 39ff3bb5-a3e6-4e55-a10b-08de1dfdaf7b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T3UzQ3ZiK0JVZXdKek9OcmZ0c3Q1NnBqU1plNVF2aTFXQ0l2WWt1V2JWOXpX?=
 =?utf-8?B?cEx3ZmN3RXhiRityS1lyYXFFL24rbmx0TTZiL29PejdvdkdXME9ySnZGdlpm?=
 =?utf-8?B?aDFPeXVvWXRvN1JRMXpVb1VvVjNJQlF5R2c0TWhhcXN3bHVoNEkzSXZUakZ2?=
 =?utf-8?B?MFBoUDdkQzNRSTJUV2FVaTBYZ2dFcjRyVElZM0cvRUovT2NLU2RINHkyVzBB?=
 =?utf-8?B?c1h6aENJbjJHMW95djlDYi9LSHVUTXE3aFpXMkVMN3AzRTFPakxBSHVabmNm?=
 =?utf-8?B?cFRHSHRJTy9SRStnRTBRL0E2Z0JIWjAzMFVZc3VBYU52dXJ2NEVFYk5SaWl3?=
 =?utf-8?B?RnV6NWFsRlpSdllIMzdrZjRiMnBUMEdDSzd0SDJYZkJRWGxCMXZ6elpya000?=
 =?utf-8?B?YS9FTWZERWJJRnBzTXNwMzVXdzFXTnhVYW1wdFB3ZzZPUmpMYkRPNGNSOEoz?=
 =?utf-8?B?NXk2cS94R1BxYkxOZTUzMW9mZTM2QWtHZUJBRFlUSk8yNTZ5WDY4Yks5S3Zn?=
 =?utf-8?B?ZWVJQ1FTaktFODZ6RWFxQ0tkQ0ZMU2FmZ3RRNkFOUWJFR3h2dlRxenIxRDl5?=
 =?utf-8?B?UjZTVlFhRXpTejlKdk1TRlZPUEpQRnNZdm5iQ2w5RTYrS2NpWENTVWRBc1ow?=
 =?utf-8?B?dm9pdGZJMXF5cndyaU5mVEI2aHRzSll4MDI3TnNnNXdpSW9ZR0RJNFd3Qm9Y?=
 =?utf-8?B?OWhVTmZkTXdsTGJwendWMktvZHh4STZ6T3kzOFdjVHVLUFZwTzJSeHJYdVFl?=
 =?utf-8?B?QUR3VUxWM0huSk85YkVsQVJjRlM3U24vSHcyR2JiOVYzcit0b0YxYlBXZ3ht?=
 =?utf-8?B?bVJORmRoV1EzaUFjcUNDYnByczFJcXlVSi9CeTBrT1pYT0RkaGRNZFpVaGRu?=
 =?utf-8?B?eHJHRUxTMnZUSExHSjhRSE1wcFQ2YzdHL3h0b0V1NWZJQTRhZjB3U3hwOS92?=
 =?utf-8?B?T2VGUlByNXFrM1NsOEZ0YmNXS2MzaEM2eUZib0ZZdFhxMG5Ha21iNFk3bWFG?=
 =?utf-8?B?YWIycU01UzFTbmdNa240STVLbk9MdVNicVp2bjBzWjZrelp0a1haeDR0ZUFG?=
 =?utf-8?B?c2VtQlRnQzdsZk9JRGNwcEg1blNxRk5ZQ0JSODRmbVl4N1VSc2plYktvditI?=
 =?utf-8?B?MDNRQzdLM3BVVnMzZWlVZjZRUGZsZ1NUY05IcnZWV2RzTkZxa1BCWHVTb3Zy?=
 =?utf-8?B?YXlZSXQ3eEdoMUxrVDNtb21wNjByeHltMnpNVHQ3M1JaaHhUN1plTi95K3ps?=
 =?utf-8?B?K0syWHJmbWplTmVXMVZFYzB0eXFSbHVDODVycEJjMXZReDJ2ZnUxbUN0WFd4?=
 =?utf-8?B?OFJyVW5DYWJDS1prekV3ZzJXNGc1RzRJcnAyQVpzdzFkdmZvbWFvN1EwRFkv?=
 =?utf-8?B?aFdlbXpyQ0lUYmtBM0dHaFYzdkUxNnRZTHBQT3FxdStONjFNb1g0Yzhpck4z?=
 =?utf-8?B?RmN2K1ZaTEozWFkyWWhWdEI2QXNRRStaS3YzRzBIcHFvZ08ybGNDU2VlTk5N?=
 =?utf-8?B?c3lYcmJPOStvdjB3NG9zdVZuZ2hrYUtmR0xQbTZ1ZExSWjAzMXI0bXJhUFBL?=
 =?utf-8?B?N3g3ZDZOaUc0NW0xQVY2aEJWUDRSc0RYUUxJNktoWWI3OFV3UnVNdmQrb2l5?=
 =?utf-8?B?Z2N5VWptSFhkUTBRcTRlVElBSG80RURBeHpUMWU5WnBKRUdjdUdjUUExeENn?=
 =?utf-8?B?MmZLTmhtd0ZDNE5LWkNOeitqY2d3RkdIOWxNdnlmSFRPNzgzZUUzbFZaY3FN?=
 =?utf-8?B?TlJjOFJPSVNtbVM2KytVeUt2VFBaQk1EZVdEa3dITE9adEF2Um9OcmpvKzRI?=
 =?utf-8?B?UDlXdGlPQXBwMEpSbm5nN1lmdmRWVmNzNDFsTEF6cGY4eDhPQjFBZkxzRXVK?=
 =?utf-8?B?QWpER3d4SUExVmliU3gwRkRXbEVVNUo0N050ZlpjeEdURE9zdXkvaE9nZERL?=
 =?utf-8?B?dk8rYmk2MW4xeFBjY0NCbUdJK0xPS2ZTeGFRV1FZTmFLdk1JREJvaCt2SU5E?=
 =?utf-8?B?d3hITzNVOFJ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1oyRVIrUk1pQ0ZGNGllQnI1dW1abFJUQkdtNXZmbHQ0TlhydmdZRjh4WnJY?=
 =?utf-8?B?L3U0LzNJSWRBMmZLTXg3UjlyeWhoRDV6QldhWUpMMkdvK21mMUF4bGlaZkZa?=
 =?utf-8?B?SmRDMnFEdXpxTGo3R0F0SW93eFVzUFVYRS83Vi8rWnJhaHJVd0ZwS0RNZVJm?=
 =?utf-8?B?UFAyRVV1RWt6c015U1ZYMm9Jd0pySGFQMWkzdjIxd1NJYkUzU1QwZDRRRmM0?=
 =?utf-8?B?N1VkRWgrK21qajFodkxqdVdiNmZDcVN2UUN2NmJhMVl2amhFOVd0dm9xZEJH?=
 =?utf-8?B?MFZGU3JDQkI2NEt5dE1ZYXpVUjVwVDR2VC80NG1EMTFPOTdWSW1tOGlvRDhE?=
 =?utf-8?B?ZU9DTENsckc3TzcybmtpTzVVczZpcmVQRmVvdFJ5dE4ya0pyVWREMlJSaE1G?=
 =?utf-8?B?NzJVWDQ5d2VTK05FU1JLNnNhby9QdnB2L3pTWVNwTElVN092V2gxL25lazh1?=
 =?utf-8?B?eGhnSkZwbnUwdFRJWUxlNU1zSTFtZFpBc0JpbitDTmowTXVEc0VwUFdrWVdw?=
 =?utf-8?B?a0tSbG1SLy9pcDd1T3F5K2JhY28xK0NmaW41R2tzbWlidEE2WEUyVTA3U0NJ?=
 =?utf-8?B?S09TWWtaWWo2cFduYzRpOCszR3IrVitsTVcyTXRxTU9JU1JoOE8vcGhmK1Q3?=
 =?utf-8?B?WEtSUlFFMCt3U1hHYVFud0ZKbXdlMjdjUThESUpxL3NJQXNxVjRGbVRxZWQ0?=
 =?utf-8?B?d1RVZnBZTDVISlhCaWQ5UUwzS245eVFHTG05aWx2V0dDeFZZVjFMSGswY2Yx?=
 =?utf-8?B?czl1Q29tQ3dlMWNBaHZDRFBEYWc0TVBXOEd2dWw4bFV1NDM2MFI0OVhhVzE5?=
 =?utf-8?B?RU42NUVpWHZOZWJpbTVFZjV3aTV0MEdSeUJGbm1UMm00OVI2ZVZwUFhEZFBm?=
 =?utf-8?B?bW4xM0ZldTBtZUxZam5yMERFZ25CUUswYk1qdFpJZHRtaUlFYmk5Q2xMRFlm?=
 =?utf-8?B?K0cyMWFybmtnS0U4ZVNrVUVNNlNpSHdjeSs3RTlDWVRuMmNxdGJSSFlDL09x?=
 =?utf-8?B?bmNIYnUwZHNsVUEvVUF2N2RNa0cxZ1dXcFFYL0VMdkQwRXVDRmFMWFp0c1hU?=
 =?utf-8?B?Y3RGQ2tUYjhFVkRrdTk5U3lYb1N4b3lFdy8xUnpuSUdGd0VyL1hRblBBbFdY?=
 =?utf-8?B?bHlFQTc3bTNZRnBpYWdpNzVFM1RaV1lmdERkVnNtQ3E2dzJKSHhXSUtJaHBv?=
 =?utf-8?B?VXl1d1hMWHVTWThYM3pDM0hTTTdrR2k5TTZKVXhYUnpwZmlIQmMvRHNMaHN0?=
 =?utf-8?B?TjFoTm5RdzlTYWxrZXE4UEtmbzkrWXpRR3d6aFlzMDNlelNxdm5UdXhuSm5B?=
 =?utf-8?B?Q3pZenR6QmdkSXFuSk9zMWdzWTZFdDcrcGFsdTVrSmVpalJ6cG5ZVTVpSlFP?=
 =?utf-8?B?cDE0K1JGYXphTGlwTUhxSndPc3U4aE1aU1lMT0pnajdDNTFjYzgxZ0UxVEVS?=
 =?utf-8?B?d1U3QTdLMjJ6M3U2MVF3RmptQzFlelpNaEZ2U01GQksyT2FjRFljMUh3RlV5?=
 =?utf-8?B?SnBPZjdseUVnYlNWSWlmQno3aUxBcG0weS81eldJY1hFYzdBSTY0WDhiUFBI?=
 =?utf-8?B?R0VhdllXU1Y2MndDR3hHY2hxZmpiSUl2UDc4Z2dld1Y2K1JWL3A4QXk1VDB4?=
 =?utf-8?B?ZlRxTG0yOHAzRDkvYk5SNWhVbkhJbDZQeWc0QStoRkkwcVlkSXpwVllTZFVP?=
 =?utf-8?B?d0x1TGNieVpPdUgxQnRndjNkbHlzRFd0UUVvMVI4L2RWeU56a0RxU2ZCKzJ0?=
 =?utf-8?B?SGhieno5NzdKMHlSNm9kR29Za1FuT3JlWFB2NGVUWHBPMENoVG4wYnJHWmZD?=
 =?utf-8?B?b2ltTjgzRjRkN29LdVBOMU90ZnhUVUtJQVZlSHJrZ2w2ZTYvbTBTYjZYYmdy?=
 =?utf-8?B?WWJWRWxXSUJIeFYyemxFa08vY01zRGJRNmRqWmNPOC9VR3lNVng0dDBxUzBv?=
 =?utf-8?B?a2lnUE11TzhSSlY1V3pWT0pyWENUaFJOenBRVEdqZkMzN0MrTW5oZDYydElw?=
 =?utf-8?B?cHZtdGlDVHFHR1lVOVF1UzBFVXJMUEdiUWRod0NZQkY4YyttZHdKOUpOZzhk?=
 =?utf-8?B?OUpyMTdFRllRaFJEcFFoeCtlZzNZSjB4Qm5xMmk1M3JkdWR4M2dtWENiejhr?=
 =?utf-8?B?eStiaXNXUUtjRVkwRDV5TkI4aEgzWnR5S1RYT3IwWEtuRkx1UWhISnpZazVM?=
 =?utf-8?Q?j+dEBzS1gNqNHlCPjrtj5b8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7EB7DA12F38DE43A47D0F3B05820D3E@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ff3bb5-a3e6-4e55-a10b-08de1dfdaf7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 13:00:54.0769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aki9colRJfffe8vbJZnWyGCoPAMnAvbO+UD5CdtVmGhWIngpSk8wEdn58O/hA2hFNi/7do3bsG5M+v9WdfJ2QheWFOismfXilOIJJuNS5jM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3815

T24gRnJpLCAyMDI1LTExLTA3IGF0IDExOjExICswODAwLCBSYWphbmkgS2FudGhhIHdyb3RlOg0K
PiBGcm9tOiBWbGFkaW1pciBPbHRlYW4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiANCj4g
WyBVcHN0cmVhbSBjb21taXQgNmMyNGEwM2E2MWEyNDVmZTM0ZDQ3NTgyODk4MzMxZmEwMzRiNmNj
ZCBdDQo+IA0KPiBBbGV4YW5kZXIgU3ZlcmRsaW4gcHJlc2VudHMgMiBwcm9ibGVtcyBkdXJpbmcg
c2h1dGRvd24gd2l0aCB0aGUNCj4gbGFuOTMwMyBkcml2ZXIuIE9uZSBpcyBzcGVjaWZpYyB0byBs
YW45MzAzIGFuZCB0aGUgb3RoZXIganVzdCBoYXBwZW5zDQo+IHRvIHJlcHJvZHVjZSB0aGVyZS4N
Cj4gDQo+IFRoZSBmaXJzdCBwcm9ibGVtIGlzIHRoYXQgbGFuOTMwMyBpcyB1bmlxdWUgYW1vbmcg
RFNBIGRyaXZlcnMgaW4gdGhhdCBpdA0KPiBjYWxscyBkZXZfZ2V0X2RydmRhdGEoKSBhdCAiYXJi
aXRyYXJ5IHJ1bnRpbWUiIChub3QgcHJvYmUsIG5vdCBzaHV0ZG93biwNCj4gbm90IHJlbW92ZSk6
DQo+IA0KPiBwaHlfc3RhdGVfbWFjaGluZSgpDQo+IC0+IC4uLg0KPiDCoMKgIC0+IGRzYV91c2Vy
X3BoeV9yZWFkKCkNCj4gwqDCoMKgwqDCoCAtPiBkcy0+b3BzLT5waHlfcmVhZCgpDQo+IMKgwqDC
oMKgwqDCoMKgwqAgLT4gbGFuOTMwM19waHlfcmVhZCgpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLT4gY2hpcC0+b3BzLT5waHlfcmVhZCgpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLT4gbGFuOTMwM19tZGlvX3BoeV9yZWFkKCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAtPiBkZXZfZ2V0X2RydmRhdGEoKQ0KPiANCj4gQnV0IHdlIG5ldmVyIHN0b3Ag
dGhlIHBoeV9zdGF0ZV9tYWNoaW5lKCksIHNvIGl0IG1heSBjb250aW51ZSB0byBydW4NCj4gYWZ0
ZXIgZHNhX3N3aXRjaF9zaHV0ZG93bigpLiBPdXIgY29tbW9uIHBhdHRlcm4gaW4gYWxsIERTQSBk
cml2ZXJzIGlzDQo+IHRvIHNldCBkcnZkYXRhIHRvIE5VTEwgdG8gc3VwcHJlc3MgdGhlIHJlbW92
ZSgpIG1ldGhvZCB0aGF0IG1heSBjb21lDQo+IGFmdGVyd2FyZHMuIEJ1dCBpbiB0aGlzIGNhc2Ug
aXQgd2lsbCByZXN1bHQgaW4gYW4gTlBELg0KPiANCj4gVGhlIHNlY29uZCBwcm9ibGVtIGlzIHRo
YXQgdGhlIHdheSBpbiB3aGljaCB3ZSBzZXQNCj4gZHAtPm1hc3Rlci0+ZHNhX3B0ciA9IE5VTEw7
IGlzIGNvbmN1cnJlbnQgd2l0aCByZWNlaXZlIHBhY2tldA0KPiBwcm9jZXNzaW5nLiBkc2Ffc3dp
dGNoX3JjdigpIGNoZWNrcyBvbmNlIHdoZXRoZXIgZGV2LT5kc2FfcHRyIGlzIE5VTEwsDQo+IGJ1
dCBhZnRlcndhcmRzLCByYXRoZXIgdGhhbiBjb250aW51aW5nIHRvIHVzZSB0aGF0IG5vbi1OVUxM
IHZhbHVlLA0KPiBkZXYtPmRzYV9wdHIgaXMgZGVyZWZlcmVuY2VkIGFnYWluIGFuZCBhZ2FpbiB3
aXRob3V0IE5VTEwgY2hlY2tzOg0KPiBkc2FfbWFzdGVyX2ZpbmRfc2xhdmUoKSBhbmQgbWFueSBv
dGhlciBwbGFjZXMuIEluIGJldHdlZW4gZGVyZWZlcmVuY2VzLA0KPiB0aGVyZSBpcyBubyBsb2Nr
aW5nIHRvIGVuc3VyZSB0aGF0IHdoYXQgd2FzIHZhbGlkIG9uY2UgY29udGludWVzIHRvIGJlDQo+
IHZhbGlkLg0KPiANCj4gQm90aCBwcm9ibGVtcyBoYXZlIHRoZSBjb21tb24gYXNwZWN0IHRoYXQg
Y2xvc2luZyB0aGUgbWFzdGVyIGludGVyZmFjZQ0KPiBzb2x2ZXMgdGhlbS4NCj4gDQo+IEluIHRo
ZSBmaXJzdCBjYXNlLCBkZXZfY2xvc2UobWFzdGVyKSB0cmlnZ2VycyB0aGUgTkVUREVWX0dPSU5H
X0RPV04NCj4gZXZlbnQgaW4gZHNhX3NsYXZlX25ldGRldmljZV9ldmVudCgpIHdoaWNoIGNsb3Nl
cyBzbGF2ZSBwb3J0cyBhcyB3ZWxsLg0KPiBkc2FfcG9ydF9kaXNhYmxlX3J0KCkgY2FsbHMgcGh5
bGlua19zdG9wKCksIHdoaWNoIHN5bmNocm9ub3VzbHkgc3RvcHMNCj4gdGhlIHBoeWxpbmsgc3Rh
dGUgbWFjaGluZSwgYW5kIGRzLT5vcHMtPnBoeV9yZWFkKCkgd2lsbCB0aHVzIG5vIGxvbmdlcg0K
PiBjYWxsIGludG8gdGhlIGRyaXZlciBhZnRlciB0aGlzIHBvaW50Lg0KPiANCj4gSW4gdGhlIHNl
Y29uZCBjYXNlLCBkZXZfY2xvc2UobWFzdGVyKSBzaG91bGQgZG8gdGhpcywgYXMgcGVyDQo+IERv
Y3VtZW50YXRpb24vbmV0d29ya2luZy9kcml2ZXIucnN0Og0KPiANCj4gPiBRdWllc2NlbmNlDQo+
ID4gLS0tLS0tLS0tLQ0KPiA+IA0KPiA+IEFmdGVyIHRoZSBuZG9fc3RvcCByb3V0aW5lIGhhcyBi
ZWVuIGNhbGxlZCwgdGhlIGhhcmR3YXJlIG11c3QNCj4gPiBub3QgcmVjZWl2ZSBvciB0cmFuc21p
dCBhbnkgZGF0YS7CoCBBbGwgaW4gZmxpZ2h0IHBhY2tldHMgbXVzdA0KPiA+IGJlIGFib3J0ZWQu
IElmIG5lY2Vzc2FyeSwgcG9sbCBvciB3YWl0IGZvciBjb21wbGV0aW9uIG9mDQo+ID4gYW55IHJl
c2V0IGNvbW1hbmRzLg0KPiANCj4gU28gaXQgc2hvdWxkIGJlIHN1ZmZpY2llbnQgdG8gZW5zdXJl
IHRoYXQgbGF0ZXIsIHdoZW4gd2UgemVyb2l6ZQ0KPiBtYXN0ZXItPmRzYV9wdHIsIHRoZXJlIHdp
bGwgYmUgbm8gY29uY3VycmVudCBkc2Ffc3dpdGNoX3JjdigpIGNhbGwNCj4gb24gdGhpcyBtYXN0
ZXIuDQo+IA0KPiBUaGUgYWRkaXRpb24gb2YgdGhlIG5ldGlmX2RldmljZV9kZXRhY2goKSBmdW5j
dGlvbiBpcyB0byBlbnN1cmUgdGhhdA0KPiBpb2N0bHMsIHJ0bmV0bGlua3MgYW5kIGV0aHRvb2wg
cmVxdWVzdHMgb24gdGhlIHNsYXZlIHBvcnRzIG5vIGxvbmdlcg0KPiBwcm9wYWdhdGUgZG93biB0
byB0aGUgZHJpdmVyIC0gd2UncmUgbm8gbG9uZ2VyIHByZXBhcmVkIHRvIGhhbmRsZSB0aGVtLg0K
PiANCj4gVGhlIHJhY2UgY29uZGl0aW9uIGFjdHVhbGx5IGRpZCBub3QgZXhpc3Qgd2hlbiBjb21t
aXQgMDY1MGJmNTJiMzFmDQo+ICgibmV0OiBkc2E6IGJlIGNvbXBhdGlibGUgd2l0aCBtYXN0ZXJz
IHdoaWNoIHVucmVnaXN0ZXIgb24gc2h1dGRvd24iKQ0KPiBmaXJzdCBpbnRyb2R1Y2VkIGRzYV9z
d2l0Y2hfc2h1dGRvd24oKS4gSXQgd2FzIGNyZWF0ZWQgbGF0ZXIsIHdoZW4gd2UNCj4gc3RvcHBl
ZCB1bnJlZ2lzdGVyaW5nIHRoZSBzbGF2ZSBpbnRlcmZhY2VzIGZyb20gYSBiYWQgc3BvdCwgYW5k
IHdlIGp1c3QNCj4gcmVwbGFjZWQgdGhhdCBzZXF1ZW5jZSB3aXRoIGEgcmFjeSB6ZXJvaXphdGlv
biBvZiBtYXN0ZXItPmRzYV9wdHINCj4gKG9uZSB3aGljaCBkb2Vzbid0IGVuc3VyZSB0aGF0IHRo
ZSBpbnRlcmZhY2VzIGFyZW4ndCB1cCkuDQo+IA0KPiBSZXBvcnRlZC1ieTogQWxleGFuZGVyIFN2
ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+IENsb3NlczogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzJkMmUzYmJhMTcyMDNjMTRhNWZmZGFiYzE3NGUzYjZi
YmI5YWQ0MzguY2FtZWxAc2llbWVucy5jb20vDQo+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbmV0ZGV2L2MxYmY0ZGU1NGU4MjkxMTFlMGU0YTcwZTdiZDFjZjUyM2M5NTUwZmYuY2Ft
ZWxAc2llbWVucy5jb20vDQo+IEZpeGVzOiBlZTUzNDM3OGYwMDUgKCJuZXQ6IGRzYTogZml4IHBh
bmljIHdoZW4gRFNBIG1hc3RlciBkZXZpY2UgdW5iaW5kcyBvbiBzaHV0ZG93biIpDQo+IFJldmll
d2VkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNv
bT4NCj4gVGVzdGVkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBz
aWVtZW5zLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgT2x0ZWFuIDx2bGFkaW1pci5v
bHRlYW5AbnhwLmNvbT4NCj4gTGluazogaHR0cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjQwOTEz
MjAzNTQ5LjMwODEwNzEtMS12bGFkaW1pci5vbHRlYW5AbnhwLmNvbQ0KPiBTaWduZWQtb2ZmLWJ5
OiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+DQo+IFsgTW9kaWZpY2F0aW9uOiBVc2lu
ZyBkcC0+bWFzdGVyIGFuZCBkcC0+c2xhdmUgaW5zdGVhZCBvZiBkcC0+Y29uZHVpdCBhbmQgZHAt
PnVzZXIgXQ0KPiBTaWduZWQtb2ZmLWJ5OiBSYWphbmkgS2FudGhhIDw2ODE3MzkzMTNAMTM5LmNv
bT4NCg0KZm9yIHRoZSBhYm92ZSBzdGFibGUgYWRqdXN0bWVudHM6DQpSZXZpZXdlZC1ieTogQWxl
eGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0t
DQo+IMKgbmV0L2RzYS9kc2EuYyB8IDcgKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvZHNhL2RzYS5jIGIvbmV0L2RzYS9k
c2EuYw0KPiBpbmRleCAwNzczNmVkYzhiNmEuLmM5YmYxYTlhNmM5OSAxMDA2NDQNCj4gLS0tIGEv
bmV0L2RzYS9kc2EuYw0KPiArKysgYi9uZXQvZHNhL2RzYS5jDQo+IEBAIC0xNjEzLDYgKzE2MTMs
NyBAQCBFWFBPUlRfU1lNQk9MX0dQTChkc2FfdW5yZWdpc3Rlcl9zd2l0Y2gpOw0KPiDCoHZvaWQg
ZHNhX3N3aXRjaF9zaHV0ZG93bihzdHJ1Y3QgZHNhX3N3aXRjaCAqZHMpDQo+IMKgew0KPiDCoAlz
dHJ1Y3QgbmV0X2RldmljZSAqbWFzdGVyLCAqc2xhdmVfZGV2Ow0KPiArCUxJU1RfSEVBRChjbG9z
ZV9saXN0KTsNCj4gwqAJc3RydWN0IGRzYV9wb3J0ICpkcDsNCj4gwqANCj4gwqAJbXV0ZXhfbG9j
aygmZHNhMl9tdXRleCk7DQo+IEBAIC0xNjIyLDEwICsxNjIzLDE2IEBAIHZvaWQgZHNhX3N3aXRj
aF9zaHV0ZG93bihzdHJ1Y3QgZHNhX3N3aXRjaCAqZHMpDQo+IMKgDQo+IMKgCXJ0bmxfbG9jaygp
Ow0KPiDCoA0KPiArCWRzYV9zd2l0Y2hfZm9yX2VhY2hfY3B1X3BvcnQoZHAsIGRzKQ0KPiArCQls
aXN0X2FkZCgmZHAtPm1hc3Rlci0+Y2xvc2VfbGlzdCwgJmNsb3NlX2xpc3QpOw0KPiArDQo+ICsJ
ZGV2X2Nsb3NlX21hbnkoJmNsb3NlX2xpc3QsIHRydWUpOw0KPiArDQo+IMKgCWRzYV9zd2l0Y2hf
Zm9yX2VhY2hfdXNlcl9wb3J0KGRwLCBkcykgew0KPiDCoAkJbWFzdGVyID0gZHNhX3BvcnRfdG9f
bWFzdGVyKGRwKTsNCj4gwqAJCXNsYXZlX2RldiA9IGRwLT5zbGF2ZTsNCj4gwqANCj4gKwkJbmV0
aWZfZGV2aWNlX2RldGFjaChzbGF2ZV9kZXYpOw0KPiDCoAkJbmV0ZGV2X3VwcGVyX2Rldl91bmxp
bmsobWFzdGVyLCBzbGF2ZV9kZXYpOw0KPiDCoAl9DQo+IMKgDQoNCi0tIA0KQWxleGFuZGVyIFN2
ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

