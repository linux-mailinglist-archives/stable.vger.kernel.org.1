Return-Path: <stable+bounces-235343-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGSNLRBf12kCNAgAu9opvQ
	(envelope-from <stable+bounces-235343-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 10:10:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AF93C78B8
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 10:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA9013098E42
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 08:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F2B38B7DD;
	Thu,  9 Apr 2026 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BTUA/lRo"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EFA389E18;
	Thu,  9 Apr 2026 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721954; cv=fail; b=glbJsnpag6KTovTKlJdl5dnVnRnrf2uf2D5hse89FDJgjBjEBhHCnG/hl38TyyDv2SJnnsPft9rnzg8hNJUWWNeXJ8ma8F+prhuzWX43ol5gcSM3U9B+O16SntYa9oxE8rykkJ0SLTUJAXBdJkyZumOGCvU6DFUhx2BmSF28tEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721954; c=relaxed/simple;
	bh=9klMf2+KGXnPwjvJL94JsZvUftKLyyHgrlxSZi0LGbM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=jhTipTo74vPrT4ZcLvjGfVf+k2QA4CXy5GSovBel71OwGoOfmja6ktQ24Gk3Gf3hEfcsofsb4D2xUmeCUDlMPZHPeJqupJF3sOniOaWmR225e3yAvxiH6Z/u0alFoh6pZAXqV9KB2xy/P3lmRSbPB+WcSDcZE75D/tg4+oX64YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BTUA/lRo; arc=fail smtp.client-ip=52.101.83.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMBfxxUH61s+tEk4qeQEm0k+hLb/0TnsV81jjdnmaN+qSJheXGavqChrKHvZGfOhaO5nHWXveAFGDpkwzRGaQT7PYir8i5pQFpu4vCJKI0ulUic11zxTvQUkshIIVtbbVCFWl82w054oCtNZwcPkc//A5tFBvJu/GafcglReZDFv+oB0zqTFAhgMc0pQD3s5L5DRFMduk1bvns5frCXNqlYS3wex9auZ3lQ7JroO/4xUmvRnSbo5AOX45BhMq6cXIldlp/Zk9aG+cMsiRdSIg5sjxRrG7bF/kcmrsGVBwjRkuz3bT0I1P6dwZLMKQIb9MjnFjvTgPyKQuf1H9JozjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKwkFtscm7EMC0jAN7VxSi96POIkm3nwl4WNzfzdG5A=;
 b=F0HamwQ2Pa+UNUPFJtOOJCOVaJXU7Ox+hFoN+FIuHFTtRnKcNFZznCn88Zu5ayxUOiY7H6Yir8YnXHrkNZW33VmeiGWRRmXxWvFEqhDuXtVdl3chcoi87QJk8WtvMBq5V8okcIOtZY2cWxNcpCfj/iXChabqLmUD54QqzGBBBMTENI3eItmUX9Fvlqc2LzinZlvMCVQWNvmAIMVyLXxLmTuex1plMBy/15PR+nvzGsFYQw8fU/dlhs44Chxly62BeP8uzaimIyl7qztJgH7Gp9WwMrNjkfDA692t5bwwwKxGLxEqXnhjVlJelX1ocYHyS/Xeu34/N1/IF8er/VnSrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKwkFtscm7EMC0jAN7VxSi96POIkm3nwl4WNzfzdG5A=;
 b=BTUA/lRoob3UdSIV2YaO6X/lcsMUpdsGNYrpACCJ0ZDwN8gKJqLlvfti1C0qyoQ1WNtZC9lmHpXz4WQdiGg0AyF19nl++/SwyZH1TRWxypDfUqDrCT53fnuWVygwegQpNkhD3MjwrzZWtiuEIJ0NBzep0HYaq3G/i5sl64N2s03zihiovGfbuMSoYItgRqDiuarjkLjESusZ2dkaZsSlYF2RoN7qK3keoRgqSZrw9B6g1N1uUnqqv7GFY8Mu+X17/l8gHEyE1CPpFAmUKNZjeJH/yrGevQjDgQCFiCBsLEWsZ2HanztXYQaUOYi0vGHGX9APKqwaXJxDZ1B+EkCN2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 08:05:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 9 Apr 2026
 08:05:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 0/2] pmdomain: imx: Fix i.MX8MP VC8000E power up
 sequence
Date: Thu, 09 Apr 2026 16:07:16 +0800
Message-Id: <20260409-imx8mp-vc8000e-pm-v3-0-3e023eaa245b@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADRe12kC/32NsQ6DIBRFf8W8uTTwBKWd+h9NBwtY34ASaIiN8
 d+LLi5Nx3OTc+4CyUVyCa7VAtFlSjSNBepTBWboxpdjZAsDcmy4QM3Iz9oHlo3mnDsWPJPYatd
 YqZ9KQvFCdD3Ne/P+KDxQek/xs19ksa3/alkwwRojWiGVMG2Nt3EOZzN52FoZDx9/+1j83qJSH
 bfqovThr+v6BWd7nU3wAAAA
X-Change-ID: 20260128-imx8mp-vc8000e-pm-4278e6d48b54
To: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-ClientProxiedBy: MA5P287CA0245.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS4PR04MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d536e10-9478-4542-4b92-08de960ecf58
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|52116014|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	mpwtrjf6kjn1z4q4RU6ji3VLovQ9oPFuTMUtONZC+LqXK8fK60hPYtwN/V5qHHHXrNZoUfhBjEzQXGo7PZWoeaAmCiGUofZ3PRVjhQ5V9lAT216w89dyof/33cxpgM6mi2dM7+Sf06NLETCdTSqMK8o4sY5feJHLLpTb/4pI9e5Mv/7k1dB2liNoMdvzQTbJG/3ST+IcYom9MVcry6sMAxWsTf43HMVzs9MxusRfYCjZVRvICBL9108FTlA9NovdiOdVEmMsthNLbZXjuroneg75aHxbzYDc/h8Qm75qr6EEMukVXqF7Goxj0D689oGsA2vRkCdU0X6gRiy/q7bO8FuOeHKAtAjdz2eGPGB3gTiATlnsNv4o9vBE8kkB6f+1xajqg3G0+lRZ3RwmCW3mqKpGT9qIROx53zChjlvwtIA1LH8QhxHpiA9e98xxKGjn71ek/D45wyLFXmomJT1uTNuuuXv7z7NaSGsr/GeZo0Rh6Yuq+vr8ocKKPGp+z7naBfI/Pj+R63G9WNUlKN7oHRcG9lXmFUaE+RXuuMgOlrDA0roJ0pDc1ZLwYuJuPaqLf30XHWBy8MNREm0dp9Ly+rIgnzTvZG7ROPPtV9DO7BOE3NUbHCsJbW7nbFjus2uYgjkGVIvIZIqczCrHV79JUX8QVHQWnI3ED4oDTCfTfxCcCRkhbOaRCw++g+Cm6wInDvHAvdIRGw/5W+4wqcFCOIaWaGsqGxzxxlpi6W858tw1/qkEvBPwG4+f8o8RfbzedNyDTfbMD6MhQJjRnga/puWdk+5yuGXEKZEOYrySARzujHtsx7Z13K/qwyx4fyNn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(52116014)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2dDSkdYNU55d3BXYjh0WUcraUlWVG52VU9MVHhXeW5KMDZKM1dYUUhvZlN1?=
 =?utf-8?B?Y0ozak80R0JxMWhjR3hhRk8rUU9yV21GUFNpTG1sd1EraThxQk90ckR6ZTRU?=
 =?utf-8?B?dUlHcHd0KzRkS1paajFiRUJ4NTB5OFVwV293Zk9iaXMwRXhSNHRVUU5wRVlJ?=
 =?utf-8?B?b2hBZ241Z20xRFdyQkszUm5KbisyaENCRCszQ0RldFdTM1MxRVNrRUQ1SC9j?=
 =?utf-8?B?STN4UnpXRUZIWlhWN21sWDVpNU9hcEpkWmVrVHhCeXFNSzZDT055WHNMY0hu?=
 =?utf-8?B?WmhEZFhGdE9Qbi9RdG1ucTJsWjJxcDNMUEhreXJUdm1OekhHMkovVnY3M2po?=
 =?utf-8?B?UER4emFnQXkzdC9KVUxncmZUV2NPWng3YXpVd1liaHExbTlLZ2Fham83ZGlS?=
 =?utf-8?B?YzdPb0ExRVpxZ0NqVkRaSU43c3hjTVNHR0Qzb0hWTmhZWU1QdzM4NEt0Yys2?=
 =?utf-8?B?M3p5bDdrNnViQS8yKy9JQXNmei8rakFBcFpDaU1HUTBCUzMzaUsrMTZaUVdx?=
 =?utf-8?B?N1R6b1RIR24weVFIVUt4TUI2dXY1QjZhZGg4YXorUWdxR1FuV0RIMjdPOHps?=
 =?utf-8?B?bnNJRGdsRVZxbEJYZWNkUUJudFFJTUkwMlE3MWFXSXVJaHYwdFM1T0VETEJs?=
 =?utf-8?B?Rm1VL29aZldaOHl2Q3FBMUljMFBodVl4b3dzYzh1UUNjeGdCRm80RWlGN1Zm?=
 =?utf-8?B?UC8xeDNvd2pTVzZmRkM3T1Jmd2VBTXFqdURjeHJtUndUcUs3bUVkdCtZTllR?=
 =?utf-8?B?NVEzM21jd01ReDhBdnF2UTBMYjF0MGxkNnoyeU9EbE1sdUVERlZkeWorZmtS?=
 =?utf-8?B?clpsTVlBREdReU5nSmFvemdBclRNN2t1cDdCRXpGc1VlekY4b3lyNW8yTEwz?=
 =?utf-8?B?WXB5Q2ZKSVhUZ1QrYVhWdHo2Y2dkYVV6SkZwS2tmTjhDRHJJVXNPRUVLdUxm?=
 =?utf-8?B?dnRrcmc5ZHk1c2tTVkQ4d0lvMU9WUkZYNnhvSERPa2Q0ZGU5ZFhjRW1EV1JJ?=
 =?utf-8?B?djJqSTh3aDhVTXhrbnRwK1JBUnZmdXpzV01uWkExclJlYXRqcWVnME1JWjg3?=
 =?utf-8?B?ZU9Dd2pkb0grSTVkOVNqdHZtMi96Sytha1VTRnZMaGhlVjV2UjAxbEJ0SWg1?=
 =?utf-8?B?bC9pcENUYXMxS0lpSlltaEhqbkdkUHQwNmYrVXFVTjJxd3lndFJEbUhrbFg1?=
 =?utf-8?B?Q2dyNHloRld1TkVpb1VZZ2VWZDRFNzdLdkhnMzBYczVMZElMbEFYbjNDVzN5?=
 =?utf-8?B?LytoeHc1VTErWHNBV0FJc3lsUWVRMEFNcExveXhKR2VnOVptWFBwbnA5d0cy?=
 =?utf-8?B?eWNDeVVCSDE3djlkTWtQZ3lNblF4QTZESkEyaytkZXg4UmFiMVBwLzlDNXUv?=
 =?utf-8?B?cm54RHFVeG13ejZURHFUbFljQU5oVTNEZEFxU0dkL1BKWGxQZnhEd3l0RE1V?=
 =?utf-8?B?TGhidDJKRlNOWEkwUGUxUDZqM1hBeEQwK3EyVVZXeWxVK2VCMVViRHd1azFy?=
 =?utf-8?B?Q1piRFp6ZlVEd25kdTFlaUVkbVZiQTZIUGZjWmRhNTFSMzVZMzQzWEhCazJJ?=
 =?utf-8?B?QVJ1Y0NRUUZqck5nMW9DTHNDd216ZmpIdHlXcHBPZGhkZVFjS3JHNzRlQmpD?=
 =?utf-8?B?dE5DTHFPZ3lKeTJ6TFl1cHFqVHREMjFzT2lINEtpd1p6dXJIVUhMN2lPZDln?=
 =?utf-8?B?VHRvU0hTaWFoUTJFMjd3Y1VWeDhnY1hZMDV3T3hpbEYxUVZtcTJFckswSXN3?=
 =?utf-8?B?U3lBQTlrdis2ZkpBVEFCWkorZjhnbnRqQWtHZ0dYclgrQkJDb21HdiswYkR5?=
 =?utf-8?B?a05qcGF6dm5zUXdLbEpyaElMM2pCQXZSTXo1UzZxVWVycHZnYWMvaG9UMVNY?=
 =?utf-8?B?bU1URHNLUmFWMGEzbFB2K3lYUS9WdWVuekFzaSs0cy9pTWluUWhVMHpMblBn?=
 =?utf-8?B?OEtXSlhKaFV6b3ROK1BHY2hMWFhhUkdGd242eXVqcUJrRG5iWlZEZ1NlZHFi?=
 =?utf-8?B?d2tRUUdhUEgxSllrOGZ3ZW9lZXJpWlZGcGt0QjZFOUFkeFM5SEJBVGVLYzZZ?=
 =?utf-8?B?bHJlWXZaT24ycUZZMUhBMjdPVklVblZYZzl2MkZ4ampkRmd2RmFtQTFYOC96?=
 =?utf-8?B?NlR3S3A1MGpRMjRKamFxUlpFcVpsQ1ZydFM0YkN0NzJpckhucEZlOW95bXA4?=
 =?utf-8?B?eU82OUxaZVlQK3VtbjV3UFlpZ2dqTHZKbHg4SzhUY1dmNjMwRUJjVGxtT3I1?=
 =?utf-8?B?MU1EWHE3MVliamphcktjblJNbXVCSWI0V1ZzanZWT0wwSlJjN3h6WktER2tR?=
 =?utf-8?B?YXlCZFVPS3lNUmJJekdWZlZrMWV1U2w2azVSMGhQem03bkxHY1Zmdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d536e10-9478-4542-4b92-08de960ecf58
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 08:05:48.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8rUipCXGoEdm2s1tmpgfrHvKweQjBdpQP1pkfeTIb7884lvtIkA1/DLHpSpeoT8VSEC4vOCpsBiXj4XOwYKLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235343-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,nxp.com:email,nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28AF93C78B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is an errata for i.MX8MP VC8000E:
    ERR050531: VPU_NOC power down handshake may hang during VC8000E/VPUMIX
    power up/down cycling.
    Description: VC8000E reset de-assertion edge and AXI clock may have a
    timing issue.
    Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
    both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
    VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
    de-asserted by HW)

This patchset is to fix the errata. More info could be found in each
patch commit.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Separate power up notifier fix into patch 1
- Link to v2: https://lore.kernel.org/r/20260228-imx8mp-vc8000e-pm-v2-1-fd255a0d5958@nxp.com

Changes in v2:
- Add errata link in commit message
- Add comment for is_errata_err050531
- Link to v1: https://lore.kernel.org/r/20260128-imx8mp-vc8000e-pm-v1-1-6c171451c732@nxp.com

---
Peng Fan (2):
      pmdomain: imx: Fix i.MX8MP power notifier
      pmdomain: imx: Fix i.MX8MP VC8000E power up sequence

 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 45 +++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)
---
base-commit: b3ab9a7b9b32806b1b68c4fe7d5298702195eb3a
change-id: 20260128-imx8mp-vc8000e-pm-4278e6d48b54

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


