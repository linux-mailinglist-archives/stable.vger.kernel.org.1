Return-Path: <stable+bounces-235344-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGDLDPpd12kCNAgAu9opvQ
	(envelope-from <stable+bounces-235344-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 10:06:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D023C7763
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 10:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D1FA3006801
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 08:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED6C38CFE4;
	Thu,  9 Apr 2026 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OUfR/Fbh"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE9238C42C;
	Thu,  9 Apr 2026 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721957; cv=fail; b=afUhuItXGdLHXSP8vdy9/gJRGy/qqiU/ZqaHxx6mGTfgzvCYfTnp2wmkbMkNLo6ZG8VBbnM3r6gSOupC9q6Fw9DnyzQw4uXy2QB0be39VNZH7fiJu7FG4vshGiE6jNVmevuELuCSKjSjql5opeAMb/kufb+xuLVGi2bS7v5n38I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721957; c=relaxed/simple;
	bh=RAuKp2fxqzkqua2UXBKqerCqfDzu+u31Ymlft76bDbI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=duyywQkRu8P4lmuuoEdeyxWmhdjdUxtNP/9LVE5UiFb3o+HAtgmrCz9SdOUMJU4joJz6P4BvsnLcXNtnUjtjbP+kDEJXiRj91gvzqLAoQADO1q3xgIe5kfVg5CFRGlZB5fy/eBaEJu4OJxKgs1cWrnzQAAZJ1yKvjo/J85TZ7XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OUfR/Fbh; arc=fail smtp.client-ip=52.101.65.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PK7nZdY+IbkeCUPuk+SsnywgobIXE9/qfJcaDLVCPpWqMcYBe3PeRctdX4D1YW4HzO7/ga+AEz2xH9PAsEML0RFZ3yFGkTkc2usQrx9W3nemaJ5+k5c13Vv3/3xcukF8C+PZLH33z0bIPVg4QY4Ekn6ZICD9ijTrIqTpv5XEtjk1VbKkozg9nQBQMC+Z9n0qDL83wvxYs5gKH4/AxZvMa0VEWVavVm3indjIWNXX6nzBFPNmQLWdsnLlH32V6HMYrRz05rB4RJk6h+KXxjpEtKDmj1Davhgedn1mzUBW//Cvxk0oEJdY14dE/nm5qUktr+CwU1KxDqW5BsLrntN+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUjoLERTwebMFVmPgUCtZPv0EQFHSUDtCq/F/cIODVw=;
 b=Uea15oPPMSnJV+poszZyWYglaioNAyHC0pKE0i+WHi/87wVj9d32ucKgrcFk6T0gLmf0PFiRGwR4UuZSyU9G/cb8ErbRMlzjvTwWLMZhng15+d+uMdhM+vC8F4YURZcJgaBUNYoWrhuPMpEojcF6sApPJCGnIB/nsbCj+zG7502C4Pf5bnSXAFsS5W7gvYTeiCTylmmIQZh1VmVvo+ed7OyMJf1FVGVvdIETMiTbM9Of2ivOKsNwW0+jTT+lgdLZ+O6feN1UzwgZ6np99nxMabvCOOJ5B7Zs68ECCcFKdNf2MNI8pns8i2pXsrOhBjugiDu/XkDem7azNUUZxyOZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUjoLERTwebMFVmPgUCtZPv0EQFHSUDtCq/F/cIODVw=;
 b=OUfR/FbhRJD9YECwAOlvEjVqgpciIMoQPJR4vfB0y4w2sUBD77DRQQ/2Jl2D3aPB/1EromrMPelujBYAd+fHMy5ISkRyyDoCr6GurnH1AAB7na/ecF0BczLutZ8bzcFSKi1MxGr1z+2dDAFvlYO7PHeoC4/5bNMtb9jW71IOjcECyFKDw6Qwm3qkmwcinXCO2aZeOsATZRAhg7zjCXVj7aNfu7sb/in8fb1kpGMd8wqfEr7PVQF77FDUqPbR5RMQ5+8WnZcwiqgTSBQtlMxY/7x/vWE52ErHJEdNsPYZKTCdU5kmkC56rZswey95yShbwsKn+YvIowEMaZUnAhgptg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB12452.eurprd04.prod.outlook.com (2603:10a6:10:609::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 08:05:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 9 Apr 2026
 08:05:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Apr 2026 16:07:17 +0800
Subject: [PATCH v3 1/2] pmdomain: imx: Fix i.MX8MP power notifier
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-imx8mp-vc8000e-pm-v3-1-3e023eaa245b@nxp.com>
References: <20260409-imx8mp-vc8000e-pm-v3-0-3e023eaa245b@nxp.com>
In-Reply-To: <20260409-imx8mp-vc8000e-pm-v3-0-3e023eaa245b@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB12452:EE_
X-MS-Office365-Filtering-Correlation-Id: 4428cb17-4dca-4d26-3455-08de960ed1f5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|52116014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	h3SHCdcGU4GTgTtuJoXznUkoyZSPITmurME9GOroAulwsJ4ILkEefNNQMk2hLF0cWsHhYmyrVPEWdyeVbh5QwyAzvnuaBuWP5aGCnXWV7CZcbNwc3w5ie8x2s7r99MQeOfNW/E2INdCYpoQysxHIwqh7lsED4lDPFPwg/7FsSvDE1CBCtIjc5iy8B9efVwvtb2WVc7GBbGiP4SLu6n9HeHEAhtqwOHmNILYephZ/9gZltDBy07ttn5i6SH+DLKWju/mUYnZdIZzhncJ5oqXguE37U8Y6YQ50008EZ41Kk0XL7MwkNA0Q1JddxxIAo+L05zoET32FKBrMW/dvBHZY45d5TeDgnV1BjnliTKKVdjxLL9d4GmmppbNDV0v9PuEdB1CGrbEPq3aQuTvqjWZZqIUlfOWGmJBsKJV1/Y8Z86lHG0tinjLxieROHZU5EBzjYy8cTlNRy9SKGimmdL3LDvs+444RG8EbvFWwac1PpsHu6t76CDPFo4fT768SE+1AvRin6qAnWeeifEhjamySm08ZE1iBIzL0r3UnzP8RHTgoH2FvK8hHB7u6v0hA0Pp4GvrY1edkLzxU+3dwv42hqjzg9yzmCIRRqumPPeraHBWcVErLSGzkysSyAvINF0JGcTcJGHsbDFPFtkF8sAI1pRd0T2jx0X4N+bG3tNuR9T4Po2F82LtBrBAVUYuP1uQghGv8TNaacZFJja5835TdkNug1/1Sj7XFneOV0BDzUEMq0mfbvPR4eTrpP4er9vSmrPAuVFl/1lR6o84jIXkGdF4OHK7FQfJ0jJc7ThAdcWw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(52116014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGwwNnNWb3JTYW1ZQVIrb3ZNSUJLNjVsZ0YyMTN3MktIN29KVXByL1RRRnNU?=
 =?utf-8?B?TzBMejhUMXdld25EeWpDT2tPZmhuQnNEQ3hqTjFoVW9pMXZ2L05OUTFrdHFO?=
 =?utf-8?B?UFFWWjBGRDdOMENudEplNkF3QzFuWEdKTndkWmtDWWZrbThKVlMxdm1FVDZw?=
 =?utf-8?B?dERicG1kZERmdHpIVDZCNy8yckFmT2Zhald1ME84azh4Y2ROemF6UE5yd05E?=
 =?utf-8?B?TnptWExnVU9WZ2ViT2ErRVNSRmNJWjlKcHNSUFA0SlRCM1lCNnpnSys2YXo5?=
 =?utf-8?B?dG8zWThreU9XSitWY1MxZVFMYWlZeVBPMVAzSjdrRm9oVFhYWFlwZGliL1Zj?=
 =?utf-8?B?azFuN09yY1V5bXdYa3ZOMG1xNlJFN0pMU2d0enJBSFhIVXV6eWIvc1dzcXha?=
 =?utf-8?B?RUI0eFg4QXZBZ0F5QVlMYjErbjErTmtFYjF1dE1xTFFmbC92Q3ZjaExQWDN6?=
 =?utf-8?B?d2ZmWlE2TkcybVhrVTIwMDErZFFSbXlQN1hpcVhYNEhIVk55SE9IaUcyODNC?=
 =?utf-8?B?OVRYMlJhUkRpKzdFWTk4bnRDZ0ZYWUhyU1UzbzFQT0N0VzlXT0hlSUswNEdm?=
 =?utf-8?B?L0N3MDRKeTIyMGl2dDR2WUhEMFMxY1ZYSDhxQ1ovL0x6Zkp2U0o0bmdOMTB6?=
 =?utf-8?B?SXIrRjNqYXFYaEVTbVErdjFKS2MwQmFPbVVvcnpROXZSZE1kNmJKQXJsQnNC?=
 =?utf-8?B?NmkrWG9yUkFJYUh2VmtKVTBnV3dqVkppNVlNWkhrMC9uNXRMZCtBdWVwNVdC?=
 =?utf-8?B?Tnh4aUlwM2xzSm5tbWtWc0JCa0RBRTdUUzI3andGcXJBVlM2U3BhYnlEUUph?=
 =?utf-8?B?ajlNNExmWDVZeXkwRnB4QnQzUzRveEREdlJKVVZ2TXdrTXl4dC82OUtzQkRK?=
 =?utf-8?B?aFRRNjduK3BkV3MvWjcyVXB6Tjc1d3owd1NObGpIcXJVZmpON1pDQVdZeEt1?=
 =?utf-8?B?N25nV0J6RjM0ajBXc0dlbzVoM3JEVUVYUmsvbEhPenYyZTlJQ1RENTNQTUpt?=
 =?utf-8?B?dnczYXVYMkduZ01pOHk1KzQ1eE1LVDJ0Mm5pS3ZETTg3M0FSUWEvQXJTc20y?=
 =?utf-8?B?L3FUR3BFNEViSURUOUNpZHQyamlkb3hxSEJ5c0pqRXVyU1RsUXppUXoyZU1K?=
 =?utf-8?B?ZWJRUnI0MEU1WmxNNWUrTU9hcW50c2F1dVc0VlE0YkJTT1RhUnJ1R2s5amQr?=
 =?utf-8?B?bjJpNzRHT2J2TE1Id2NTM1N0VG9BSG81cGMxR0hNemUzMXVPMkJrVXU5cjBD?=
 =?utf-8?B?a0V5NDdWbjZTVVZzeGlEbnpwYzRveks1S1gvbjNIY2U5aGswYVgvWDdxYitq?=
 =?utf-8?B?UDFvc0JqQTNyaUZlbnZya1BYYWMxSUd1akpTemMrQys5anBzenhQVkdRdlJZ?=
 =?utf-8?B?b3ArL1cvRnp0UlRqVjFEczRSdnljd1AybnYwR0I3YkFWWmE2UCtRZG82aG5C?=
 =?utf-8?B?R2k1OHJlTElOY3VoSTNxNlFBVW5kVG9sQkJRanJIQ0hGazFuZ0lTdmVDUnZX?=
 =?utf-8?B?bG1pNDR0MlZHc2JPZzFRUFM3TUFwRG50ekcwQWNhRUc5VVVvdW9VdkpWRzMw?=
 =?utf-8?B?Qjk0ZFRTRTBNSnFyaVRjTkpVNmVhc3c1SHQwNFBoRlFHU1RRSUl5QnZTaG5y?=
 =?utf-8?B?c2lKY0pwRzFRTmZ0dis3WUErVnpzMGVHYXpEdHNBNDBmZUU2bndKT1UvaFNl?=
 =?utf-8?B?cEJsSmJzZGRYckNvZWxHTkN4eDRxVEVNaDdwOVM2dFpuOW8vTTd4bzNkQlRS?=
 =?utf-8?B?K0V0aTNLN0hvSjNEMFdBODJEYTZGNUV5V1RnNEkwQ1dDMkhuK1JUTzBIREdS?=
 =?utf-8?B?V1BLYnBJV3Z6QWxxdTU3VjBLUXcyZTE0aVJURmRibWx4U0pLRFR0OUk5a21z?=
 =?utf-8?B?alhvMTZ4NnBWbVBBQS9VN2YzNVpYaGNqaFR0bVRGUGxRTU45ZHZkL1V3TVc2?=
 =?utf-8?B?L0ZWQVAvQXVJdHBaNGYrbndnS3FJTWY0MjBYcmdDNFhyN1NoSkFubm0rU3NC?=
 =?utf-8?B?WWhSVGU1WUV6SHNKSy9VZ0F6QzBUOVlBOGJ3cnZySzMvTWNYMVQrTkRDTnJ6?=
 =?utf-8?B?aUpzUnlUaGVYUmJWclNXdThkRGpTSW5pc0VkVHlQTkZvMng0MGVuMVk1WEhv?=
 =?utf-8?B?M0JCM1lWcnBJOEZzMlp2bXhrdEJYSDFXUFlLUzZKMW9WZVBuM1FTZmxSUDQw?=
 =?utf-8?B?VmFnZ1VLUkEwL1FwRmFubGd4eXByeENPb0tKUHFmSlJZYndXSHhQekVpQ09n?=
 =?utf-8?B?eFBHaDNLUDRCN0oraGFJTHhXOXRvYjZEcTBUSlg5YnhPWmJFbktPdmFmay9V?=
 =?utf-8?B?TFN4THZzeUV5UzhzeEppTlIzc2RCSDk3TS90WUJSZEVPUkVVb3NmQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4428cb17-4dca-4d26-3455-08de960ed1f5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 08:05:53.1137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCdsBvDw+uO2PxQtXyuwkBUjIXxqoxQr4+eSFap2w2ibPE6P2P/NZhTg1SmGcD3plrxs5xQaVs/3gYW23vJqgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB12452
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235344-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32D023C7763
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Peng Fan <peng.fan@nxp.com>

Using imx8mm_vpu_power_notifier() for i.MX8MP is wrong, as it ungates
the VPU clocks to provide the ADB clock, which is necessary on i.MX8MM,
but on i.MX8MP there is a separate gate (bit 3) for the NoC. So add
imx8mp_vpu_power_notifier() for i.MX8MP.

Fixes: a1a5f15f7f6cb ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
Cc: stable@vger.kernel.org
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 19e992d2ee3b845bc9382bcd494a5d96f9c6ac44..e13a47eeed75d7189aa15370a7bee4cceb05a1d6 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -514,9 +514,34 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[]
 	},
 };
 
+static int imx8mp_vpu_power_notifier(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
+						 power_nb);
+
+	if (action == GENPD_NOTIFY_ON) {
+		/*
+		 * On power up we have no software backchannel to the GPC to
+		 * wait for the ADB handshake to happen, so we just delay for a
+		 * bit. On power down the GPC driver waits for the handshake.
+		 */
+
+		udelay(5);
+
+		/* set "fuse" bits to enable the VPUs */
+		regmap_set_bits(bc->regmap, 0x8, 0xffffffff);
+		regmap_set_bits(bc->regmap, 0xc, 0xffffffff);
+		regmap_set_bits(bc->regmap, 0x10, 0xffffffff);
+		regmap_set_bits(bc->regmap, 0x14, 0xffffffff);
+	}
+
+	return NOTIFY_OK;
+}
+
 static const struct imx8m_blk_ctrl_data imx8mp_vpu_blk_ctl_dev_data = {
 	.max_reg = 0x18,
-	.power_notifier_fn = imx8mm_vpu_power_notifier,
+	.power_notifier_fn = imx8mp_vpu_power_notifier,
 	.domains = imx8mp_vpu_blk_ctl_domain_data,
 	.num_domains = ARRAY_SIZE(imx8mp_vpu_blk_ctl_domain_data),
 };

-- 
2.37.1


