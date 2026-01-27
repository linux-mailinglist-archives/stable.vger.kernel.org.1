Return-Path: <stable+bounces-211727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHU2F3tgeGmbpgEAu9opvQ
	(envelope-from <stable+bounces-211727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 07:51:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 037B09083B
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 07:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 499D33006158
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 06:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A8132B9BC;
	Tue, 27 Jan 2026 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uDWW8fwR"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396B3225791;
	Tue, 27 Jan 2026 06:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769496695; cv=fail; b=n1YePC/Rupmns/Dgkp0Ct+Va3PUaD4jnKJBht07FtlFPO/HEshfsiCFGDdJXYPB1F4QRsKIRuFUhfYeFXsEaNUvZl1E1m3OWau9em6wR0jCLLoH4q9fllQNgT5tQMloGNZwBp0i1/AGmv1Y2lMzyMgcOeLdSjolTZIzXTHhjtPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769496695; c=relaxed/simple;
	bh=P47D2i2TSnhRNRSCcmQyuqWoTrl2iRVkGzNLonhI3oA=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=F+BYLjWApsVSmstP+RAE79Ma8VV1NIxdnvcr2FcvfLyuaAbbk07tNChiQoEtYPioObIgZNQgblBRo9soh1u6yU3f3H8hodo93GKpUjIGijMv+I6swqKb5rGApgzYixe58+3goEH7xA8FKricBE8pRfnYwWeGkgP9hmiikEt7DJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uDWW8fwR; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu+6uuL3WtomvskDrwNrYGgEo4ZYU3gkTAIhSYW2RoX/dNLWWqx1Yf4oIfJ1gFhseQTQ9yIQHQSrARMv0CiyoIbrq0yWiPWUCxDIMFc5wy1ViDCTj4AHSxwfrPEMW7E/OXHHME1uKymebBiKSVtgrLSJvr63NDikxoyXDcOlSBEIBirZS27prRVCw5z+8NA3f6HafvMg9MZSl3C2PITb4mzRcAHDe9NQODmiSi8+3W7Lqa01fKkEvyzmZm1cK06ShjkfY5XvB9YLpFiwVEQP9Ps0y+1HLthZPH9fGG2ShNPWXU0vKXiiVqJd49ALoSOi+AS8WToNC9257IpkcMDLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QMKlB4tLI01l8kFU3FEcJcnkrWPyFhbg1Ada7plQao=;
 b=RDM7c24qMygQ9RkTRSIlo4kNWQoZmonw4AMV+jX9yLw44m6CeROt8/N2c4gNxvPC9La/+cHKD03dspqdBXbl0m01NwUbltWUi4KGore7HRZAfMtd4L2T5Xu2lfv3Gj9LsKFeysh1j01+iTdPAtUloQswsRxgVK9c+F6H43a01u1pjlbhvuDBxXasb0mE2nVgQQlIpMhmFHYD6ZbY642zEH7xgSkFlZIh3ysjmt8VkfjD9zKUTUoPyu6tHBsVy3pfCCeWIYpujtFGve7MDwug8q/H9i/7umt0LxaMixNAGTFkU5u9UPsXOLxZw3xhUTQOcgE3mX5HKMab7sfuS0avvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QMKlB4tLI01l8kFU3FEcJcnkrWPyFhbg1Ada7plQao=;
 b=uDWW8fwREUf134Pw/7PCp7zRECjicV10T+4zTR9b8y1s+wlS7N94P+UhljESp4tp6devr6W4OOg3YwsyzVpDpzYPLoto6PDnvZYVEnb9VfGZ4CX6o2qrWyhfadngI0YejMvHKMAisvgwlv7OCxWsc0mm9pMMH5DWhOjyxZp1bgdIalFl6Ld7j9d87i7rfpo9CsgBMNhAMBeTlZ+NgTDpvxSobsAYcvC8btjMx7nqyOY/TSPmdaVnkZWeIOUHHi5venEPBJVdGN4TE3ifVWyZ1MZ4S2mxBYBCMdcbD35/nre5Yix/wXXDIBmhUhznkMqzuDe2uducG9xr2Xqs84HDyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7938.eurprd04.prod.outlook.com (2603:10a6:20b:24e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 06:51:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 06:51:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 27 Jan 2026 14:51:06 +0800
Subject: [PATCH v2] remoteproc: imx_rproc: Not report loaded resource table
 when none
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-imx-rproc-fix-v2-1-7288fcf74385@nxp.com>
X-B4-Tracking: v=1; b=H4sIAFlgeGkC/3WMQQ7CIBAAv9Ls2TWwJVQ9+Q/TQ4Nbu4dCA4ZgG
 v4u9u5xJpnZIXEUTnDrdoicJUnwDejUgVsm/2KUZ2MgRVZpIpS1YNxicDhLQSZl5wtbNsMArdk
 iN338HmPjRdI7xM+xz/pn/52yRo29dc6a3l4no+6+bGcXVhhrrV+faefdqAAAAA==
X-Change-ID: 20260122-imx-rproc-fix-e206f8e6e477
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Iuliana Prodan <iuliana.prodan@nxp.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, Frank Li <frank.li@nxp.com>
Cc: linux-remoteproc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: e1dac046-bc1e-42c2-d4a8-08de5d70808c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWhjcTR0Z2pUWkJCMjVraU90WHE1WndlUEtNb2Q4TWpRMjlOMmZhVmIzNmZk?=
 =?utf-8?B?MUxiYnpieFo1ZWhGbVQ4VDFCMEZSU3hzbU5XdVUrN0REWEpKOWM5ZVZlMi9r?=
 =?utf-8?B?VFdZKzZ3QVg2dk1naHo5OXJpM1RtbVo3elJYZ0lMc0wrOFJiNHNqOEJ4WjdS?=
 =?utf-8?B?c0VhVTlBWE5aNmxCUmk0S0hkQy9WQWxKQUNsV01PWWZsTHd4TkxtcWFvdi9t?=
 =?utf-8?B?VnJUL1ZydVlJbFBoOEhMR1Jra2VPajRoNWNPV0RxdzVQblRvNEl3RDV4QXJ1?=
 =?utf-8?B?WjNrei9QdjZBbU1VRnRTdkEwZm1Od0lteFNkSGZUNUo4YzVCV3JPOWhjUFBF?=
 =?utf-8?B?VW1uK25oSWpsMGV5UVZZUG1jSFVvL2JFMDIzMlYvR3BadDYxUmx6amV6SHFU?=
 =?utf-8?B?MHc0ZXc1S3ZXNHE2SHdjcHU0NkhlSGZIQzMvc3pYK1ZXZTcxSlVpck5sUWl2?=
 =?utf-8?B?eGo5TCtiNmREb3FZUHduaVFrK1F6dXBRamFnZGRpZ1NwVnd0NDBIYm5TbTU3?=
 =?utf-8?B?LzZBR3Z6RWRtL2t5cm1ObjdqSU9CVUJGMndxRUpuczlyMEJMdHVHNFdNbFJX?=
 =?utf-8?B?aGI1ZExuUXFlUmJ3cGxGRHpEYXZPVm1ydEhDV3VHTm9vRWJYSjFSeWZXSzJs?=
 =?utf-8?B?dlBTRXo0UmFnRUt5b1dOdVFRakRIZUQ5dEJUc3dVbzFIZ284S3didDh6MXJn?=
 =?utf-8?B?TENLRlpUMGQzQjZhMlRkWUtKRlBlY2Z0b0NURjFVbk9HRW5FN2lieFdmenMr?=
 =?utf-8?B?QkZYTkYwVitpdWkvaTNYZWtzdm4xYy9HN3VmSFpFNXM1M1NqUjUzSStaeThp?=
 =?utf-8?B?TFJnc21SL0RaRklRUnp5YUlrbVpyb1dlLzJLMjJ3a1FqdUxhSkhyOUh1dnM3?=
 =?utf-8?B?RjVkRmZXZ0t0T0xJRWEwMGNJRlh2aTE3djd6TVpLK2tDc3dPaWpWQkJsdXdz?=
 =?utf-8?B?UXBHN3pwN0JwVXEySys0citlSUxRZmJNbEJXTlAyQkEyNDlXbmo2NWtHa01O?=
 =?utf-8?B?YXF3ZTlwOHk5TzNjd1R3S2FURTd1NEJPM05tNjdrbis0dHI1OU9tUGlLM1JQ?=
 =?utf-8?B?T3JURFNVVTA2VkQrcWNVY3d0Qis3V244Y29FSWRnWkFPNjhhMC9kZVVmNklx?=
 =?utf-8?B?UW5xQlcrNGM4Y1d3a1VnVTZmUkZDUFh4bDV4bzVoaG5Fejh0V2RVR2hRcWZt?=
 =?utf-8?B?cGlkRWRoU01ESG1xWDJubmhZR3IwMmlBNlVRMkJiSDNyZUxUR0k1Y3dRYW5G?=
 =?utf-8?B?QmNTNlhQM2hZT29KRGEvR3ZJU0F5eXJuQ1hVaFVsVDh6RkNIVzFlc1Yxd1RN?=
 =?utf-8?B?YjcydWh5aThyMUIyTitGRjlZUVlUejRwdlQ4ZDA3UXExREFwekE0Y01OWVp1?=
 =?utf-8?B?eFlrL0ZuenoxUU1xY3dHZEJFbm9XUlMrZFlLRnUrTnNreUNkV1dqbHp3L3RS?=
 =?utf-8?B?NXI0YnZJOUhNUUpvSVhqMlBpWmdva3RsS2UwNnRGNGlYZWV1YUhERnRkSjdu?=
 =?utf-8?B?akVIVHZnOU5XMWx0MXhGTkxzZWovZ0ZySmJPa3p6NDRHUk5oVXg0L3dUbWJq?=
 =?utf-8?B?R2hjTElsUU5tS0cvVEFURWNaYjk4R1RFRitIVWU4QVFQSzRWdE1DdnZvQnQv?=
 =?utf-8?B?emtvT3ZXSGtraWJMMnAwbUlPdU5OZEp6RjExb25sSzJQLzNIU3dFWW5IYzJa?=
 =?utf-8?B?a2lHVTcvcldmZEpPOUlaa3pWellvTW55MFJORkFPbkIxTHhGM2FzcW5lZldj?=
 =?utf-8?B?cWc0d2ZjY1hhNVZsWXZFeDdvaFcrTllFOTV3UElPMXZDYXFyK0pQRndJRkdz?=
 =?utf-8?B?N29xK1Q5VTA5SFhYMnJ4cllERFIyaGRWWmtLWkI2RjJhVmMxbW5NMGZOWUtS?=
 =?utf-8?B?MDdoeGxNUkNOWkVVM0xMUlpFT1EzTFBtRnkwL0I0VSt2Z2NBOXMxY3prMG5U?=
 =?utf-8?B?MnFIY1hwc2xKN1hyYnVHRUY0dDN5MXpLNW9NKzBLaGVXRWpDSHBwTUVsVUFt?=
 =?utf-8?B?WXkxc2ZkSDhGMk9lNkRHOFNUc2k4L280UkJnazZOd1Mrb1JzcmpsaUZiTThy?=
 =?utf-8?B?WnpCaHJmYXpkOWg0MURnajkvSy9NbkYrTWJMeFgwbFlnQW9BanBRMTBvMnpX?=
 =?utf-8?B?ak1XUWhnQjJSS2txMjRFR0p3c04zOVVUQTRteE1LSmpLNkRMR2xBVEg4WEFB?=
 =?utf-8?Q?+VYHzbvDRkAa5eEZPaMph78=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmsvVGlVSDVKNkN1SURnbk5LVXJlNDJ4cnFHUFUyN0hlYzRPc3Jmdms1T3pv?=
 =?utf-8?B?clVYdjBySk45clpoWGN3L3Q2RGZRRHY1dEJjYnZkMk1kUXl4ZkJIeFd4RlpO?=
 =?utf-8?B?TER1c0U4dFpLMVZOd1BlbzVVRU81VXhselM5dkhzb3BmNE9DbWZVVEtQN0pa?=
 =?utf-8?B?dTFZaytHeUNkZUZ0S2hiTmdHd0k2K1JTamh4YklmMW5DeXp5dkk0eldBUFg5?=
 =?utf-8?B?Qm96TkM0V2xyb3lGVEhEaDFsaWpxbU1zVSttemlRRUFhTjdKUHRBamN2c0g1?=
 =?utf-8?B?S29yYm1udUdZakYzcTd6MXlqb29EVGFmQVhJbDZVZ0NSaE45c0lzd1FZaHpu?=
 =?utf-8?B?b0NwVkZpZXpNQTFDc2w5Qmh4dlFZMlFxOUgzRnV3c2JZYXpONlg2bmR1cVVY?=
 =?utf-8?B?K00zQWlrUFdRREc2czJSbWg2aHM2QWZ4OFd0a3E4US82K3RNbWNNWGtJc2ZP?=
 =?utf-8?B?aGVuenorQmlNSXhFME5rZWtIL0t0NE9MVHliR3pGNTVsdHVXak1Yc0k2SHh6?=
 =?utf-8?B?YjY3TnhvR0ZqYys2T1BVeDU4ak5HempqUlVPanZIbkpmbkNiTTJTTHNRb2s0?=
 =?utf-8?B?eTVva0d5aU9sRVhxdnlqeStwZVdKMUN1czYyUlJxMWs5T1BOMUdLdFMwNWYw?=
 =?utf-8?B?TU9vOFBEQ2JLMDJTNmxMcWNuNmNVcXFjclBURjVEdk5kQnZ5aGJqaVF5NEJw?=
 =?utf-8?B?akh3N3dsNkVRWjBQRURKcEhnY3NLYkNXYzFFaEF0WTZqK2pwM0Z0blVxc21L?=
 =?utf-8?B?M0E5ZTBkVitFaG4wZU1BMHc2bVJ5MGlrb3BPRnZEOEVkbGdXanNoa3AwblEv?=
 =?utf-8?B?WUZmY1FLM1FWUkVhWmdUMFQwTkZNU1VxTkdWQmU0dzVBeHp4cDY4c2cyWnBU?=
 =?utf-8?B?WGVXc21lK2N4ZmJDdlFtbCt6U2VXb3FORVhjR3FOWkFJTDlwa1VaYU9jOFh6?=
 =?utf-8?B?bTE1QndJT1hSVUtqY3gyNjJNSGJJcGEzRkNYQzN0N2Fudng2a0Q2NFVjK1pN?=
 =?utf-8?B?M2F2ejhuSWduMkgrWmtOSTV3KzRrakl4dW8vR0gySjkvYXVTOFVSaEtiM0t5?=
 =?utf-8?B?S0tNZk1XU0JBRHdiVEVVVjJGTEVaRTRhc2tiQ0dscFJleVZXbnNBalUramRE?=
 =?utf-8?B?Ynl3K25lNVBWL3ZUOEhWeU5ZS2toOE5FZGR5SXFVTHRNK24xUnZtbDVpOGxz?=
 =?utf-8?B?YzhMakgxTWJPYW9iY3FaQ3lVWWJVNHNXdHlZcElBVFFTK00yZFJnZnhTc3Q1?=
 =?utf-8?B?L21YL0RqNFlRcWF3aTVoL1dhS0RqTzdkbkFIMmpKb1MvY3k4aUdHazl3R2Ri?=
 =?utf-8?B?NUYwZ0lucFJpaXQwTkF3NWIrOWI2OVgwL2FtT2tZa3hJR1dpQVNGTUd4MHJY?=
 =?utf-8?B?WXluNVlrVHEvbUJGYlNWZUUrK3RoVXo3VkhzejVCZU9zOTZZczRQRlBzeWM0?=
 =?utf-8?B?VnQ3OHJ0WU0wRFN6QWJiSURNTzArODZPSEhLbGdvYWRUZUlidHBaSWNpdy9F?=
 =?utf-8?B?T3o5R2h5OEhYODlQa1FjOWZ1cm41bGN2ZFk0N0lEWEhUVll5NTFDcTNZZndJ?=
 =?utf-8?B?eWpDOEMzT21GbENyMVB0Ry9BRkh2NXdGMjUxRnlBcm9jTmZmL1k1MUpIazhl?=
 =?utf-8?B?bGdpY0JVdnJ0ZGQ5a0xFbFNUOS9yanBFa2FoV0ZTUlJpamNiT1Rmbkk3ZElv?=
 =?utf-8?B?aElSNitoK2tiaGh2a2tBV0pKaXpoSUNJWmhTOWp4bDRWbGdmRXZsMDJCR0FE?=
 =?utf-8?B?Uzk3OWI1LzZQRWhOTm0wQWxYK3lLR3k0Sm5LRmkvSjhrcUJUbkVxS3Nxb3BK?=
 =?utf-8?B?V0xhWXhNd3UzS1dkZzJaazlzeGVFRmowOUEwbyt0Y3hFWlRKTzl5ZVlmTVg3?=
 =?utf-8?B?MmlBR0N5K29sMlYySmp5YWtzdjdBV3gyRXVxaXVONkRQSG14ZGlBVFFjTEtQ?=
 =?utf-8?B?L2ZLMkFUSGV5ekpVUkNRckovVzAwZVlYb1pZUEJxWFlMZmttYTdDSEE0Qk9Z?=
 =?utf-8?B?a3Q4TEkvbXB3aWxFNUE4ZmJwOTd3MytVUEFKdDRaZUk3RU9vSjNWcTVzenU5?=
 =?utf-8?B?U1VHYkpUcUxzeUkxU3E3bi8wZG0vN21jd2FhNVVUcWtFZzBsUG00ZXp1eHdP?=
 =?utf-8?B?MFhCYS91RWRwSjFQMWZNUTdCR1pRaytMSG1FM29hSDFFV2VhZmY3amZrb2xQ?=
 =?utf-8?B?QkdIWTliR0lMM2gySUZPalNVL09ROWxzVXFidEJ2VUVzUzNTN2RaN0ZMZkRD?=
 =?utf-8?B?TERnUE5kYjRwY3FYQURubDkranVoZTE4SlduNDVOSnV0T3JYamE1TzE4bGRS?=
 =?utf-8?B?NXdZdHlFYWRVTFBObWV1QjZ6ZGpld0NTTmF2STA3bjVNSFFPQ1V5dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dac046-bc1e-42c2-d4a8-08de5d70808c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 06:51:30.9336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NYkvrU523WYke9GzYZ5zSTpejbt4TEUZ6RoY2aiqLULTjswQLId1H1nPuGO59wOka7tlRtLbb2v/D+mmAIGsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7938
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,linaro.org,pengutronix.de,gmail.com,nxp.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211727-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@oss.nxp.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 037B09083B
X-Rspamd-Action: no action

From: Peng Fan <peng.fan@nxp.com>

priv->rsc_table is not NULL if the DT has a "rsc-table" entry, indicating
that _if_ there is a resource table in memory, that's where it should be.
Function imx_rproc_elf_find_loaded_rsc_table() is buggy so the narrative
about a previously running FW with a valid resource table can be dropped.

In this case rproc->table_ptr is NULL because the current firmware does
not contain a resource table, but the remoteproc core still interprets the
non-NULL return value as a loaded resource table and attempts to memcpy()
from rproc->cached_table, leading to a NULL pointer dereference and kernel
panic.

Fix this by returning NULL from imx_rproc_elf_find_loaded_rsc_table() when
there is no cached resource table for the current firmware. This ensures
that a loaded resource table is only reported when a valid table_ptr
exists, which matches the remoteproc core expectations.

This issue can be reproduced by:
  1) start a firmware with a resource table
  2) stop the remote processor
  3) start a firmware without a resource table

With this change, starting a firmware without a resource table no longer
causes kernel dump.

Fixes: e954a1bd1610 ("remoteproc: imx_rproc: Use imx specific hook for find_loaded_rsc_table")
Cc: stable@vger.kernel.org
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Per Mathieu, Check rproc->table_ptr, update commit log
- Include R-b from Frank
- Link to v1: https://lore.kernel.org/r/20260122-imx-rproc-fix-v1-1-36cc64369a40@nxp.com
---
 drivers/remoteproc/imx_rproc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 375de79168a1c8d11b87ac1bd63774a3feac106d..f5f916d6790519360f446f063e09d018c5654953 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -729,6 +729,10 @@ imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *
 {
 	struct imx_rproc *priv = rproc->priv;
 
+	/* No resource table in the firmware */
+	if (!rproc->table_ptr)
+		return NULL;
+
 	if (priv->rsc_table)
 		return (struct resource_table *)priv->rsc_table;
 

---
base-commit: e3b32dcb9f23e3c3927ef3eec6a5842a988fb574
change-id: 20260122-imx-rproc-fix-e206f8e6e477

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


