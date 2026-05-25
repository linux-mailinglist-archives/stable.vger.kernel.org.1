Return-Path: <stable+bounces-254084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAtUFwLnE2o6HQcAu9opvQ
	(envelope-from <stable+bounces-254084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:06:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2055C5C630E
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 08:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9E353007669
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925FC346ACE;
	Mon, 25 May 2026 06:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gXVcIBmZ"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ADF13D53C;
	Mon, 25 May 2026 06:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689212; cv=fail; b=sAyx6dyZ5xyyhuBPpILAV4wD2p9sgE87MXu62d0vrNXS2PqAHNDu4UAfL+EkNykaP6o1QspvVMsR0Q5odN16INQZk2y7pRLzgL1jSWBpR6yCv9mmxWlF+LJByKvZP91vmNduuZ9mKH3c5fmVPy5KfRnDsAVza5g/15+USqsnqB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689212; c=relaxed/simple;
	bh=TY6SGJViF3IgQ/GK7EU3bTY1nvuX5+6Ubnt+OBZ5nzQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=lRpS31BgL53aULc7NSn5Ej4Hc810aCIWddXouzWzINDKn7yaY6aLvl6RwxDnR0PzuGbPcg65rLNgEw7+kp/GKMePAW83b5xcb63i5rgfSd06kj4y+8gLyllT5IIGBuDXv8l+PZtpYcWXVhOx2h5t1s8lipg3vUNTLLG7pbIab/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gXVcIBmZ; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wh6Bry7XNHK6UCMIfktoJfpO+WCPeocitn5d+SXDPDP96hOTxXy487dgyKidajkPiI13Rp2r8tTemfxCNtg+yCE+iIJsgce0zUlOpHQiJqkcHwaGIBswJvEDn38z0ScIQ4H8qYP7epakEzGi/Cbft9WdgRtJuidr4EEOVc9ifdyfGtm/07k0t+ysPbX3ShLI4N75mkL7lrN2FD1xDOckO/mk9tlRBzOEWY6QLHeOuINJ6GIUMeAjPc49r110tA2WfMrj+Al17bLXyqJxE2RuPC7uQa1Z+gjDo8a0HBg7wGzUNtAKRdl5dOfpnL9ur0x7uStx/H7oDb73vCEX9yDa+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqXaEK3CuAye+Vr6ndRPgSREboT8UYlljOIsi8BU9FI=;
 b=IKWterkaJTPxXCRMsh1A88je1UW5fsRZmuo9LD5KUsC7Gaim3cc94uZo9ohVhWm5VuUEx62MCIoReAlSR6hwx0so/BQxtquZ1xIGeG+8h8O30PAzNNrwYpKW7fnJh6w1js+z4Xw54KYVw0eoCS9hLnp2LD+maMB+a97qDodao3Ngylg73ausQ3BluIOKI/HKY4XJH+CQfLIX4gZjdVvK8OB2iCyht2L6kJ7UGCywwYVLWvmj4bm3M+SsnxEi9yVNrAd7bgZW9cFyMFA9ED2AC4T5laq/wJjE0Sq8CjkYDW9qsoWSUZX9OUseGMTkddjqE9xMfxQQ5tttlOCRTlSJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqXaEK3CuAye+Vr6ndRPgSREboT8UYlljOIsi8BU9FI=;
 b=gXVcIBmZYoGRDfymGcf6kKvoP+6/BkaPJd6xY69UT9LN5CIUcHy23x5o8MeHrFhM8mwGXe+dbq0Zt44IB2okcFUs2UK3lXLymWhbgSNgkVYsd+T6ARrxErW3QzEme75Hft9Q8MzJvECXHnxHiIS/zjNMQCMsL1athgnEVykVpwaerkvYbcHIxt8pPy4YItxyoWl8gACkcRC7+JSsfuhJkNtz1ePvLsaqPd1lqI5iFrhJvvzVEoYecg0D1mvxAJg79LyC7Q0SU/09gK57ehxZHF3RyvSoWz3jPBtUWxXmMTh00Wd0pJhxtBgYCFeVn/Lqhzw+VxTL2FCEe3WfM6EAdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV1PR04MB10725.eurprd04.prod.outlook.com (2603:10a6:150:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:06:47 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%5]) with mapi id 15.20.9891.019; Mon, 25 May 2026
 06:06:46 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH 0/2] device property: fix child iteration issues with
 secondary fwnodes
Date: Mon, 25 May 2026 14:09:18 +0800
Message-Id: <20260525-fixes_fwnode_iteration-v1-0-a12903fb2919@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI7nE2oC/x3LQQqAIBBA0avErBPMUKKrRIjlWLOxUKlAuntDy
 w//VciYCDOMTYWEF2U6IkfXNrDuLm4oyHODkspIrbQI9GC24Y6HR0sFkytMxOKCUX4wXS81MD4
 T/ifbaX7fDwmZViZoAAAA
X-Change-ID: 20260525-fixes_fwnode_iteration-baf62d861305
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779689386; l=1515;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=TY6SGJViF3IgQ/GK7EU3bTY1nvuX5+6Ubnt+OBZ5nzQ=;
 b=wO1diJDe7cmf9H/SFiG5dmX1CbB7/tVIIMHBU5MmaUwnnv4hdiVQ0hE0yFC3Cn2bdiyw2eFbr
 C1N6HydvflODjEfdCUArE6o3/HmZ71FBje/A4Fm6pCQEUFtthZS8Gk4
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GV1PR04MB10725:EE_
X-MS-Office365-Filtering-Correlation-Id: f11ade3e-94b5-4362-0193-08deba23cd88
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|18002099003|56012099003|38350700014|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
 l56jT7rSmVD9K/rql8xBtxDzj/xPRxTRVkeo9PMJLbgcKOFa6VMpm1y4sRdn7ltBhIkrohsqTm78EQ3i6SKNgHh8aUUQOC3aLRSMa55On/zVsysS0P1IHEO1f4TYbJbdCKI/xucdMwLv6TnGtuiFGf8oCV5YjkNwdowMgTx5HIJSHr/PaTAy9kte1UIkNnLnaODBbq2HadHS49+vAwau9nmXv64Juq+AIobjXmqopXCzZ28wXSNapQhlbZvcKo0NjluR+7JHAFMS1XBLUFe2Z6Wr6kgkEe0yxgyGgkjPKyBXKs8iIONaWFFRQw6ADthh7K8xFIvAKIzEbj5YnAzwTaK7ycIT9aUUa9vIMC5E564CgRBjRJy1oEBCjrdl6BajlHJHGmcqxKuYQsFQPXyQxvRdcDWq/10/BmSq48d+lpn1grESkxVfJMptNs/qGzLgnUISB4lAVZ9jxdPm32QsACK9kq6A+eGp0O5LWOagUxSUb+gkpqettCGteWVtQ3yCANi5YqAVUrRsU/lCtkHS1TIo+rJrL8cq8HZ3ZiMlI5suenymaeHy1UNJL3OBcY9yhrmYFrYlHTgN7dIGZ+f1YgcrAudITfE/rwlbwJjvdBL5Hf0aa+xkeHPGlUrqWt1B3bcDjX9vbVJ6IuE7SLLPMseIJYxjjbMdVv9Cg9Xt8MpLXG06JdI0BWpxOpHPB86Xjv24MpkzPoRSXyMo6iAilwwZu3nvqkY/MBmNlZWWyZfI0n5PRAZtVMGeTrWxvhGf
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(18002099003)(56012099003)(38350700014)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y2pMc0dvSjl5MnR6aTd1WEdWWUwwcHVwa1VSTGxrQzk4SVFYeWJySmdZOWcw?=
 =?utf-8?B?OVdBTEhpNzhzQ29mRkJqdm5rUnRIemFvYnN3Tlc2UnBGRFZXZDIwSGpLL2xD?=
 =?utf-8?B?QTFLSis2c2R2RlVqVjVYUVlZVWZYOEMrc0F0R0gxWkFzbjhYRXVRMnlObytK?=
 =?utf-8?B?Z2pxODh6ZW9tUmxlbFdEajlsWlZ5MzdMZno3K2pwb29TYVlZMnlZcDZJbEJ4?=
 =?utf-8?B?d05hdmNGQkNFNmVWaHlzU1RFaFJTYUluMlAwTDBmR3YyS001RGdKekVNQTVx?=
 =?utf-8?B?S0hPd2d5cnBkV21peFQwNlNRalRhQTBSL1diTUhpeGlEMjQvK2szTFdlclJL?=
 =?utf-8?B?ZFloQTREaFlTNzVkNks2MFo0ZVIyR1dxVURGRC8rZnZLTytNTkVvNGdhU3U0?=
 =?utf-8?B?OEJFMmgwMGIvVFJGOFZnNkphd2YxMG04UjdjblpjWU9YTG1HYjJGTHRZd3Jp?=
 =?utf-8?B?M3FEUkVYWlVDUTd5cjRvcDA0dm9CVFhXck14b2ZSalhrMWdlbi9WMU9xb1lF?=
 =?utf-8?B?UnNiZWJWemRmay91czhWUHdTUXpqcEpodlp1UEV2cmhBeFFEM2dGdC9wY0xm?=
 =?utf-8?B?ZTNkSW1Ld3lmRTVkZFJaeUtTanEvM0ZpTDMvNTNwdFpjSzUrcXVaanVtajd4?=
 =?utf-8?B?TTl4a3BBOWNzNDJBVjI4SDZldVNsaEduUy9MSklmU0xybVpPM0RsdWU3MGdM?=
 =?utf-8?B?R3JtZURUaVJBMkZoMmhXTGdEOG9lSmlwZGo3eVloaHBkUDc1d1JyVWdLSU45?=
 =?utf-8?B?UU04VEZaSUpKKzJZTXJ0a2Y3SUZCL0dnek1LWnJsd0VwTitNN0JUWEVjYTNH?=
 =?utf-8?B?citSTHRzUTJjRk8rRGR0R3BvSWJwZzFQRnljV3RlK2FWVFAzOThtT0M4QUF6?=
 =?utf-8?B?OHRCWEFGMlpOb1RLRzNjVVhUQ3BUWlN5TllTdW0zZkZNLzhBdmZHR3JOTXJR?=
 =?utf-8?B?NTFQWk1vRmRabVJsY0VzOXU1NjYzRnBvbGpxak5ubWRicEVwekx3eDVYekVW?=
 =?utf-8?B?MW9ncDVVcHRlejIrVzZOcE9xR3dVbmp1NkFycHJZSm1oa3RVcE16bWxNcmVU?=
 =?utf-8?B?ai9SRUxISjIrK205NVJDVXc4MzByZkNlRXRYK3RONUF5blpRKy9uem9RQTQx?=
 =?utf-8?B?bUcwaGNQOTJWZzh0WjJqQzJjTXZtSVkwdkdoVFdUakN3NjJyMG9XUU9TMTBx?=
 =?utf-8?B?dE11TklMalprZ21paEIyQUg0Q0xtUzVQYWp4d2Z2djNKWFZJMmx4RzRDSVcv?=
 =?utf-8?B?eXJDZzJYT1N2ZVFWR1VCRnNidzVvS0N1eDMrTWxoN2I4YlpJb0cwMEhacmJI?=
 =?utf-8?B?TkZQS2VWRkhLNlZXSDdHUkFjQ0o0RFhJS010V283bW1hU28yNVJDSVVNd2NX?=
 =?utf-8?B?NUxqUXJaZFU2SzZxNHNNb00yWk9XblFVVVJjbCtFNmxTQm9lYXJBQklxbFdG?=
 =?utf-8?B?K3pwVHNkWlpKWHQ5MkFnZWQveldPbmF6d3laNTNFUStUTVdwUjkyTjM0UWNm?=
 =?utf-8?B?Q0NPOGNSOENPK3V6MkhNZlR1Nmg2ZzZycnlUVTBKdHB0RXM1YjZNY2ZLMHJq?=
 =?utf-8?B?OE80ZjVrbU1wbEVqcHhVbjFVSktFTXdWekM0K1hCY2NTQ0U2dHpWSlBNZzJv?=
 =?utf-8?B?SC83NEpPNGFyYkk0bHQvY1U3RVFYTGFJYUFvU0dFTHM4SWx4WC8ySXZuWDBt?=
 =?utf-8?B?VjMxMXUzdXVONkNSSkEyZC9CMmVGWkp0YlZJaXFPT3plLzVDcis2Ymg5UG9u?=
 =?utf-8?B?dXpFOTZPYUVkMEpwb2lweFkwK0R4eXZ5VE5laitkVlhoSCtoakJrcnlTVzJv?=
 =?utf-8?B?NGJmdVlXNVNiT0VjVHZRUG8xNm40MWhtdXFtQ3BoSndxRDJ6a1ZnM1VrdDlS?=
 =?utf-8?B?VTBqUVJ2WlpJek5aM200WHJDKzExQlEyaDUzWFN3M0JQRDFVa0lEblh1c2ps?=
 =?utf-8?B?cEZQOGhWcmYxYllPeUliaTB3a2M5MkRPWjF3Rm5Kb3lxS0tWSnVVbnhLWmV0?=
 =?utf-8?B?bWlOT0QybE04UkZVTFc4OW1jMUhjSWJEeUsvODl3cFFOVFo1N2VDUGRjY0Ev?=
 =?utf-8?B?UWJJWWpEYmQ3YVJxdit1N3BYUnJJYk5jTitTYzloTnZXV05BYVgwMFdYQVJB?=
 =?utf-8?B?NmpDV000dy9mWnp0WVJrOGhOOFUvRm5nZnFhQXhUdTM5WEtQTW1MR2tFdjB4?=
 =?utf-8?B?cmJuZUhtWHFkcnBJV1dhRjhIVEN5aGtKZHZoc0pPSDYydzlzMGxETllIWG83?=
 =?utf-8?B?S3FBL3UwVGUwTkN0YjI5am54eFRlL3VKd1ZQMEhIYmlPcEFMM0w1K0p3ZXM1?=
 =?utf-8?B?Ymx2NXk2SkRER3U2cVpQRllNMEhJemRyNkxZT3h5aE5OMnVEcjFMUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11ade3e-94b5-4362-0193-08deba23cd88
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:06:46.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJgM+YdQVtan5h2ZEMypBfzeWcmGALYayLiVN7TS+8CaHSHr5qg4U2j38fOuQDmgU7t5th7V3dPZ8dlJ6jdsTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10725
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254084-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,gmail.com,linuxfoundation.org,kernel.org,ideasonboard.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xu.yang_2@nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2055C5C630E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes two issues in the fwnode child iteration logic when
a secondary fwnode is present.

The first patch addresses a refcount imbalance in
software_node_get_next_child(). When a software node is used as a
secondary fwnode, the iteration code may incorrectly decrement the
refcount of child nodes that do not belong to the software node
hierarchy. This results in refcount underflow and possible use-after-free.

The second patch fixes an infinite loop in
fwnode_for_each_child_node(), caused by improper handling of iteration
state across primary and secondary fwnodes. When iterating over children
from both primary and secondary fwnodes, the code may incorrectly
resume iteration from the primary fwnode even when the current child
belongs to the secondary, leading to repeated traversal and a loop.

Both issues are triggered when mixing different fwnode types through the
secondary mechanism, and stem from incorrect assumptions about ownership
and traversal context of child nodes.

---
Xu Yang (2):
      software node: fix refcount leak in software_node_get_next_child()
      device property: fix infinite loop in fwnode_for_each_child_node()

 drivers/base/property.c | 26 ++++++++++++++++++++------
 drivers/base/swnode.c   | 14 +++++++-------
 2 files changed, 27 insertions(+), 13 deletions(-)
---
base-commit: c1ecb239fa3456529a32255359fc78b69eb9d847
change-id: 20260525-fixes_fwnode_iteration-baf62d861305

Best regards,
-- 
Xu Yang <xu.yang_2@nxp.com>


