Return-Path: <stable+bounces-256562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBGBJ6BTGWqYvAgAu9opvQ
	(envelope-from <stable+bounces-256562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:51:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BC55FF82C
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4F7F300F94C
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB99C34B68F;
	Fri, 29 May 2026 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MN18HeO/"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013005.outbound.protection.outlook.com [52.101.83.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443413321A2;
	Fri, 29 May 2026 08:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044657; cv=fail; b=edjuwc4SsguKBps32tNLpkCLZVts3ZSRW7ewUZDIyuZ95W4RcNros3ZQkza0CTo2J/5Cx/0zh3A04lvjT6dOtltlGS3deSXnFCQEzwsgiK6c6GYHwUayH9qJHPKxHkGNgIktYLmRrCxHbhM3L/9qlTelqrHTzCNNAH0DSjKP/iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044657; c=relaxed/simple;
	bh=VW1Bp8ssIIyavl95MO5YhWqnb4a99Gpu0GV269D3oe0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WhIVXsDI9MBFj/yXImsjDRI7q+xmVMWzLi8t5AFfwHcR3Dyxf5rbWA6AAPrKfWIanfp6q4CMN8SVfMBY76ZoHPKn2w7y4UEG1LCK6b5Eys1qf113tehRTA8KJoNpCFdLuMAG1x2jyqGHGHhqVLqGgJ1lt9aOBs3VyjmUL38Bt8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MN18HeO/; arc=fail smtp.client-ip=52.101.83.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2AbZcprGNDPpDkEzHQCOsfusnCDOXB2q91ID5pcInBZ6gQcxEQwddWjmspwskDdlKVFKgIeiZswumNTR2B/GuZgOTxPGBtq7ghRyWzPLrofWda+N6PCmOfbeEEddjAJ7ni7/24uQA+FAxd67YE8ODeEhwbbeBTW3rUmPsG0TPfVGoSMxlaqx7toUjVCI8Oxk0nUh8qwH4PLJCwyDuybsNneAWQLUithzDXmiLFHcqCDN4f27aPeiGJ/kQgHvUcKJ0K0NhVb9vTNPmdEWNtQfRIgyiDVV++8mY5ggtVONRJkLBHno/ApwVOah1akgY6EGl36AuXSNAE/95EnPzeCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oq8/tGUi72BajpVWW4PkpB2phs/PpBWbG1ELBTV2vLU=;
 b=R5bLASwGzv4SuV2HxF6Be1LrP2yBSEk7vRKHgzYMhLCHnZcA96lLYzAY5fsDj+/R+zvTRdH+5eOp43xtE012iQuxO0ShnzrwVUz7QyO/Gl/4gPm5pHevvBw8HA1u0ekwiF2GW9FwXhGa7CM2ZCdrADgBbx1pwZxSn10LoKwvpx0OKGkJrKJ+JndDkJQSJ7NlxezwkggcD3wubhfiROik1FwXCFUvAzvaaSkD6yBd85yh8gR77DelemrsbG1edw4z9m3KHFMghASNCTH1wODYtfYkoKcsko35aSkxvSvNk5OTfVpaIXmRvKu9KVWaePx7mT640KJVfrk1qvYbg1vMQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oq8/tGUi72BajpVWW4PkpB2phs/PpBWbG1ELBTV2vLU=;
 b=MN18HeO/TjHl5kYJM6IfFqKv3J6acTG5bBmnS96/9jJObuV2zt1o7lS7iJDUK4Cig2xkrD+YxgyIsMu0DAxBcppeILO6/BeGnOnGZcZGSzbVu3jOuZV8P0qjukp573gFCLHA1rBP0y2r7vO/eQLdJw7mEiJn4KY/OxHL9w928xDvqdo2WB9bjjjxKu+Wu8rUNeYEf6dse3v4SUBAYeL6WsYuBverKkbPEEIB+9RJ0EN2FOGuoKCxePwyFE/rXU36KES8pdeVp+d/UYMyzWrUUNUdmPv9RoxZMzTctIpiuQ2edKGmQgOJ71n/1+AYpRMixPvR3sGub1HxRWwdwmR24Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by GVXPR04MB11665.eurprd04.prod.outlook.com (2603:10a6:150:2c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Fri, 29 May
 2026 08:50:52 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9870.023; Fri, 29 May 2026
 08:50:52 +0000
From: Chancel Liu <chancel.liu@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: fsl_sai: Fix 32 slots TDM broken by integer shift UB in xMR write
Date: Fri, 29 May 2026 17:50:20 +0900
Message-ID: <20260529085020.3727790-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0024.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::6) To AM9PR04MB8353.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ef::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8353:EE_|GVXPR04MB11665:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb48f98-1fcf-467e-a4b3-08debd5f629c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|19092799006|38350700014|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	6NkF/g/kaSKYYkI/YmT0gZ0RH1CgEMUyvvV3GiFQ0vyxYlh9gnUWY8uMRJsRr1o5M/Qml8Nu5eJce60xqOSG0HjT9E4xQuy5iz3+LnUEc/cRx4nE9p0jwmDL1L3rn7wyiyhPuq1D3HZX54fMx/6N6mjoIwGrLdHLbuHX2JLC7qtPiDiL3S1qeSYeMy1kEtTQuQKJq4N6+VZYXci2jUJ1y7Lz0VOVJKBHiGIw9ZSGnNxMf2QyZNxJTwGwv+5SM5436cU2MH4FYU2uWdSc1PIGpCsCNhiV/sM2NdXvsVLv/hXzqolyT3W3VHkEON794Gh4cWFeKpY7LWFH9u1+apoTPVySsUj3K2TAk+LaWioHe4d16baW74ZPPB0cnWzahHN50zqSTg+f+Min18cNkyjbUuMbheEONxB6ONS2TShaND1rLqxgxewHm24dTC8CAQ82dGL74BNPlZIRmQSwUfzmjNVe7f1Xy8wgYxLut8e4pUdA4tr8flJ1tiFt2ili0as23NYCCAqvlW7Zz/HOcN6w/q0ONwPHykc1Qb07/Yazvjx8lKLEyNk3o84DvXPmkJqssRCD3bigrt7CMVOfe+NOiV3MCFmKLe++7wTb3/Az5id2kgAsC2+1/4kWjw4+lSgHI7fDG8XtPsiL8HaVC+7vKtXt+5mgFXx9zIRIXrg/RQ++WRNsP5qUFP8G+zGRQuaHpYKBCPBMgqVTiPzEDsb+sHiQbuSR0quSINAjRBU4of74gZgtBsucgpnf+YGD0pf+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(19092799006)(38350700014)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RxRENxFVic8oehysuswU7hb1ncXIRfZ3eiNUpMyW0gHU5ZuiXN6cpi+0whmW?=
 =?us-ascii?Q?ecJbPurMDRDhXbp/VUr9bmtpkdiBuL63TEXVsJDDWqiWp5kwnlgZvhU5aJ3V?=
 =?us-ascii?Q?K1l1r8VMpjipXjT+LbZvuehok0po+TOsiIaQiyPlZx1/9zFkPCxKtILXQgDK?=
 =?us-ascii?Q?ppzDOPr4b4+UziZNPdLpwaTba3kgWScg0Vc+x2NJjk3ATyunnXkTaMzzfDvq?=
 =?us-ascii?Q?NziBpmuz3N5VUE51Qm2yVZNazu4ruWE0XWqvgOH9jTrZUrQe+sx4OZ8sP4eI?=
 =?us-ascii?Q?0Q0DwClnJ4qX7LmcgjsfVJoC2/fcQWv+gOwMRkYlKOSIvH2HtXw0RcfC8qHt?=
 =?us-ascii?Q?bmbTX818xCjN/hxs7F/sCDGqUUQh4KiUl5Je/3dm/VNoZES2pEKqTP1l5/Sv?=
 =?us-ascii?Q?f4VgJwucXTN4Aa7pN7JNvfwZS7IPsKJT2Yoq62AGOT4jWqodQJ4xm6rVVrMt?=
 =?us-ascii?Q?Rh80l/WL6AjrDxnwI0bIxRsPaI750b5X9LCHemT86y16JqLplL0vROYZ9Zhx?=
 =?us-ascii?Q?8YNs/T6S6Xn5efZ1RQzFlrD7/CTPxliPwnuUvHWpCeLdsZCRINrDbpuj4wbS?=
 =?us-ascii?Q?J7Yu7JqPwgeqxY2hYgDD9H+I0TgqTw6zE6NWAtARCuDCGDBt8frfIm5+YtDw?=
 =?us-ascii?Q?RZO9APi248Xp57iHc1Oo2LyKEfGCXWjtPs2QyP1B9fnGo3TeLEN//ewPL/v+?=
 =?us-ascii?Q?7HlnVSUe6PdknX4CGGUqv4nSiZjPig/aRJv2ibejEzl71ZbKcj3T7CdtZnEZ?=
 =?us-ascii?Q?AcEaV9+dCf+jEYuLdxhsINJo2bWPQ3gSu3d7JQLkx6JTF2Z5gYKHsMQW0nHs?=
 =?us-ascii?Q?6eGbJEF9l6bsWHBc6paRoIxtQlnVvnA2f3CHqUDMh7dAQqGk8gY5KS5C1gg7?=
 =?us-ascii?Q?08ZVIfshyKg03nP/ZUJ6fLfXvYow4um/pEvQ3JGwariEeLQZuJVFIe6uG+89?=
 =?us-ascii?Q?fJO78QmQG1VT3b1HauhUoWpmFGtFkuuA/exmqL8TPsNXObj0V9b2/XPAFeM4?=
 =?us-ascii?Q?asSjBgywkbVhN5qrr17pY8DHocdd/Jos35XVHx4pao/uvwNyTJO6iFF978Qx?=
 =?us-ascii?Q?D+w1Bb2Xid+hD8gfegKy7VALNOXyaKobGgkB02EMXL8pFuRKDqbKCHpmJiVj?=
 =?us-ascii?Q?gOI2bzXqV/clV9ts4FEOTe313s3FleDZA0tVUa4NDZRLQESPVYQEqhHwKzxp?=
 =?us-ascii?Q?TmfzRnJ548i8S2sSFo+WBVvP9KYAm4DrFwc2GZnBiLsSzWrkL0oyFWgpBiEO?=
 =?us-ascii?Q?Ago2N0JTq9XpvxI1cM6kFHLD5G3aX4cSEClmog4okItVuuYqZRQJBHRjSn6P?=
 =?us-ascii?Q?NXcj1eWGe7NtTS3HJx4rOgWtAWR1Hr2/W1S0/X9tcv+lqDN2v8ng9GLIrm1M?=
 =?us-ascii?Q?RoI9iViVL+AC8TRFuhTVW+HQoK/1MgvJFJi7y7lnEJvQWugvlDAz/vNnbnpB?=
 =?us-ascii?Q?dU41X1KP61zrklIknYN/6XaXRvdsKE2lFDzsz/OdDIgKmwT3S7RtTs5wIUiR?=
 =?us-ascii?Q?zsH5TjGvDKvsYy78emsC8A8syP58veYBeDxdDEyRPvJZJbLvWAg38ZbSt7jD?=
 =?us-ascii?Q?IkyuS61jrMyR7Kl/NxlJdbyr24o4h+c8iu/XTyRL/w9nMgwZMtwidEbIUVV7?=
 =?us-ascii?Q?32BXMetX4dRhDO8jcSfNj5bWSZV1MKYLIj7j5Dt5up+oGgam88BVBOoimIMG?=
 =?us-ascii?Q?qNWNPIRMlyG89Fm4REmqrRvbGjFJACTzI8S7X9UxeEI/69kCzSh68oGP70Tc?=
 =?us-ascii?Q?D8S8t6Ir+Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb48f98-1fcf-467e-a4b3-08debd5f629c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 08:50:52.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoZ/6mt0ofO3BOhQN8OIRQO6hOsj0ubD0+bYG7nO9hVP4Xtqt7kkK2iq4lODRa+P+1Oz7eFdgNiN7lwge0ai1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11665
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,perex.cz,suse.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256562-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chancel.liu@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: 19BC55FF82C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When configuring 32 slots TDM (channels == slots == 32), the xMR
(Mask Register) write used:
~0UL - ((1 << min(channels, slots)) - 1)

The literal '1' is a signed 32-bit int. Shifting it by 32 positions is
undefined behaviour which may set this register to 0xFFFFFFFF, masking
all 32 slots.

Use 1ULL so the shift is carried out in 64 bits. For 32 slots this
produces a zero mask after truncation to the 32-bit register:
~0ULL - ((1ULL << 32) - 1)
  = 0xFFFFFFFFFFFFFFFF - (0x100000000 - 1)
  = 0xFFFFFFFFFFFFFFFF - 0xFFFFFFFF
  = 0xFFFFFFFF00000000
  -> Truncates to 0x00000000
Behaviour for fewer than 32 slots is unchanged.

Fixes: 770f58d7d2c5 ("ASoC: fsl_sai: Support multiple data channel enable bits")
Cc: stable@vger.kernel.org
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index d6dd95680892..821e3bd51b6e 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -797,7 +797,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 				   FSL_SAI_CR4_FSD_MSTR, FSL_SAI_CR4_FSD_MSTR);
 
 	regmap_write(sai->regmap, FSL_SAI_xMR(tx),
-		     ~0UL - ((1 << min(channels, slots)) - 1));
+		     ~0ULL - ((1ULL << min(channels, slots)) - 1));
 
 	return 0;
 }
-- 
2.50.1


