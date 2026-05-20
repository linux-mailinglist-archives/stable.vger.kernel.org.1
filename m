Return-Path: <stable+bounces-249787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKosN8V5DWqfxwUAu9opvQ
	(envelope-from <stable+bounces-249787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:07:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BE858A66C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3D50300B2B0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA243B4EA0;
	Wed, 20 May 2026 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qXZEOqXj"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0E3B52F4;
	Wed, 20 May 2026 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268033; cv=fail; b=fz/QxGFtIvM8Lx886tMbEbUs4OA3CMAC6N0lnxTY6oaR2204f+tObWJcLRSPKlL4WC7Bau6R4bFmvorMbZ7Bsi8Laf9oE0uISYVCYnBcR2XjCFNVOvgCcNp2wDBSxBZErA8k6KkScQoo+m8smI7hq7F0HGN/GvFts8lpKZgV+VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268033; c=relaxed/simple;
	bh=NjMe62FLOQBSSGKY0sdk/UDXhWNAfm320t5C7pNpypk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TwH2kfjnuiqFsexxUla73vyzj2cQm9fRlwNmNj+PAS2nujZ0nmfPxcUIqPpTa71VCY8CVrOR5aauzWSY9AgiyqAa7cOOlXsiZP2JvkOTWKHVLiHAVTCwrH0T6t69sY3P2z8jjuDX9XflUCn/OP4dEoIaf5gDWVRVpDBkeweJyWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qXZEOqXj; arc=fail smtp.client-ip=52.101.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEUHyYLMTN3HIyO4y3tp/DHXKCOp1/QNbr7g7ZthekyuQRijo5jJ5BZxIV/uxzD+GC+rLiC6J8Gpbg3B25lPEfP+9+RF7NdjlpxRJNVhoTgWxrfZEDC32ro/T60le5s3kbgtU2P20Vn2VC37utsrdRLixDznLpT1rhIFOoh9iRohpFCWdj4pyUumN4nPasczrXdftLexCrUiV98w2yu1aUUl4bhHjdXFxSyIZyW7NjimLCZNDy9ROLtflrlpF+SZpCV01jbsDPpfKTF4ZNxauk5DUokiuj0d8r54LhZkv5sLO6KcxhNyWEW8QY0AfxT9MWW7evFBfF/0inj35J8g1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4CtjOiTU9R5m2IeMHe81HPmmTfZeKtiWDS2pfNRvvw=;
 b=rBVE/2Fbva6ol0ncbRIsHJTXr/hhmToF9v0UNKFNSRBot2N7MomXUSG0HvhN7owpSqbVB+yl7Ol8TuxL2RsEocTJVdc1BPb4XMfCkJ/ZoiPxAvJypd0Uhvsv8Bzd6bjtJR5SoIlS6Pl/A9v0vxy90DFdeF2Mmcr2KiYRWgNomSr0TIgnsjD7IlFXyPGSVjHIwlc/ombc3/5/2mAPtft+XH+q+Qyu+e3XfJ5qR5RSkZhrgIGdP/7bFMHsr10RZIA9M0KriGGBSxGKZCs82p37qhlVfA9KsoIPYtstZYOhfaYUj2nJEIeBIoEauzwBtCLykNE41yoURq1HMjW3qxb2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4CtjOiTU9R5m2IeMHe81HPmmTfZeKtiWDS2pfNRvvw=;
 b=qXZEOqXjHRqRbZnslGawfOUY1RrV0/l+jtXZ6Hq5k+QsnsHTSfjTBEnH4Whd7bH3TrI+OtNqxhwS/coJwd0zmPLNkhje+TKz4d549OS8Ip0FLKB6vQCqPwOI2I0djdxY44jDJyOA+tBjzYwtUNZMb1J2933faiGREgeP+60oG47FA5kAh0chXJwvDxi8OqrrxEPFWhQhf8rp7r8+4kCFIPG+IsWo9Q8nIPd83YcDms0o562o+ba5vpdpPHRhVbD1pnQj7yaD5IhgwU/0SYJvLyYuUaMyVjzSNB5LRbXAIGUZKfKrBc0HsYYtMGdK6l4he6SevTEUo2r0pvEbF1IKTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Wed, 20 May
 2026 09:07:07 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 09:07:07 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: aisheng.dong@nxp.com,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	carlos.song@nxp.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PACTH v2] i2c: imx-lpi2c: mark I2C adapter when hardware is powered down
Date: Wed, 20 May 2026 17:09:10 +0800
Message-ID: <20260520090910.2879570-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:295::9) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b02370-fe1f-4540-f822-08deb64f2ac7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014|11063799006|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yxdOX2MhVZ3bJjykbrjUIs+1EAQqg0Ge5Gc7BFafxyyN2wO64pXbmsiL0vwgkHubNL5L1x9XR1rZF1Ahp/4BfvOLNAzAz813L134OgxSJe8WWxPmta28LM7ae3z//GyY9W3F0sbQ6jTqC3D9wu1mDRdIn3tgBMturvvo0bgLhCvLBt+JFMnCnZuYm8d6rcseqoyL5goW9pcwayJgfemZeig2W9Kzj1s9T9QobdynTzN2ugnJSDe7Jm8hTb0i2gUGiEZtSam4UY4HWaq1+xo1PJDocrL7rQxWGbfgnxCe7rBsgD/BlZh04Q5TrMLIRLeuRP19raztyMhSuhSrb37TWtY1XpPVtdCCPAyktRDrkr7CzSQPY5vRjfPuZcqDqxT6jRNlIJT9E1VUKnNTYpmIHhmRwYPoHBSyfAiZmFQxQBqQsoSN29RphlaTiQfB0FYS04jZ8qMlLmAiijW3As/B7dSFNWt3a7TPJgUmRRYKAVPYRz+9HRvP1fas/HwG3xQXU+FKla8DlAc8PbvdILOJCi/UJBOUGmycXbea318w59Tdua2rVTR7PNoXAGVqcO2cBvaARVdpEuvcvGuVlOODBNpHCdyc+SgCVPyydy2WKyTazJaEqeRyUr0EiPub55iWGhsYAYLUF4uvDNEANVT5PsIul4h5wyOfjuK5CDoRbjv2APQfcZYo4GFZpqLPRTy6oceuYNHQ3vwzUGQ8PZLL0kUOf7tWIwsD4kTYnWgGmTK1f1wkpKqozp9mN2HnUG5c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014)(11063799006)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I7pM9xpeE+3b8Gw/CD07rLJK71uoOYgxV2dmS1BAUdTjXDMEZ/h8pU1yuHA5?=
 =?us-ascii?Q?TEKFy3tDd8z4dzrOL0S77ZT0ZzHhYP053FDuGkreRTOTTrcgn9PKLVNOSvhH?=
 =?us-ascii?Q?qSb6/TUV6S74co7g+ZVfq1f+fdi5Zu3v2ywJzf0uhh+cG2Qka9gGbe+xnZ8P?=
 =?us-ascii?Q?dAvj1KDSYOVhNlvOWwNvL/H1Jc/TU9zpUy0mqGAD23YmRsGLoB7uh24R1MQC?=
 =?us-ascii?Q?6uxGPcWC2YdprzwBjT49h2e9F0r+8loGFk+A6o99UR8OBlb8UyultOXqZGdk?=
 =?us-ascii?Q?4+ek72Df2am/kyEe1VE6qQtVTQ706+CRXR9gxb0l83KSC74DzEkaNA/h3Gpm?=
 =?us-ascii?Q?YFJiS99HvSZ2kGkU3Pn7MZBQIxO/R3d0Vwc7eQyrZO8GnvkZwKvH7zNVmKQs?=
 =?us-ascii?Q?b8LTedUw3K9rehlh/IGCBvwm0Ed23BOP7DY7jul2N+InltOlv4f3Es82D5Lg?=
 =?us-ascii?Q?He0VKLdq8FXvMRr1VjKcN5X8/uqVAWlwrGT1bYhs3CBPIvNf5/FrQtoie7KJ?=
 =?us-ascii?Q?r0BYgcBd5faXp83Y2l9Iu22xJCTONXO77a1dD9vA9+nSHiWg3A9JlqrNVK74?=
 =?us-ascii?Q?WVSDbIfAjYPsZRE4/3ACAsX3rrognrtOlsoayS+kPUuWDNghZPn4IqcXdOn2?=
 =?us-ascii?Q?sPYCzatBjREIuyrjRVCA2H0arfz/QHb3UQ+yOKxi6MRvGYzF8Be+3lHKcPtS?=
 =?us-ascii?Q?gO9XKiz8ecqennu5dl4GaKeCzcjqAP/Hj01DX8xaSognJfyMzRREzh1fam1n?=
 =?us-ascii?Q?7OIHbrf7qoEyxyhoGbiCatYUdMO6fjsjKjonurQVGX82do35U4hTjyIbOfPu?=
 =?us-ascii?Q?RwQMrTSH+oxH35Hrty/dpXSm4b/OvMpSA7unhBRVREjRaHgJCN6isYOQ2+vK?=
 =?us-ascii?Q?G/2tm3m98c6wWWOdpkHgKAWxAyKD7za93V8IayzqS1CiAtcc1EcDki1lmKx2?=
 =?us-ascii?Q?oZ6aaPICFu10oQOrbCbo9F0nuZ+wjweO/i5cP0I5dZPxDYmxTfEJIo1tT9+K?=
 =?us-ascii?Q?KRZ19uHnl6jYAwnFTRke5qcPimUE7Xlpdwst8LavI15SOHQNFKDtlnjVpyoP?=
 =?us-ascii?Q?A1Hc0G1S5PfDQ6BhdhLZqtRZeVxj0iAoJa5+7Ig4SV8ZdXyW/V4hMjsS/w7Z?=
 =?us-ascii?Q?+ohKJvOFR9/5yLDPLin5lAwrU1m4MirgHCeURaRSXQaZp9IpeR93/XK+MmMC?=
 =?us-ascii?Q?ADGWNNTtZoCyxDdY+xaPlnxfpX9pBZDeG+ViclV81yMZzr8f6ZGZBusSdWpG?=
 =?us-ascii?Q?dvbxIRb8TJxEzpH1Lw9r7uymopSwHwBF2ApiPjRPlGaPWdwC0b6hbxGwIu6Q?=
 =?us-ascii?Q?9lDKQiEhV5odvLmhj2D634Q+1yxLfdq9nycCpLYRHb0LCyor5R2JOjplJy1Z?=
 =?us-ascii?Q?dHPHuUdUK84ay28EfSG3X8wKr/Jjw6kcLzGtJVsUu5lbrDuZpjzN9kuurpyM?=
 =?us-ascii?Q?2nN0OytyOW1DCwImoO4ca0JG70/94nXOW1A8RSnUE0vwOUk8wnIeSONLkFLv?=
 =?us-ascii?Q?oeDKtBpQVIxOWmKZOP7VrL/mk4UqjIE6Z6v72X7Umzu/DqT51NU4qackQtO+?=
 =?us-ascii?Q?ul4lSoT2P0F3REFeZ+ax7v/Ea0Us/i3NM542aYx636Td4DSbxfVDu6v5XtUf?=
 =?us-ascii?Q?nNNDq7R9I57NxKZRd6fx71V08zuBoz2cR9WjM3KcGWYjf3kz69bZmG2a9QIs?=
 =?us-ascii?Q?5VBXbmIOfRANp4S/PR2CxMHN6Xd4G2VYjQz7qafwd3nn4WKt2+U0Hw12Hgs9?=
 =?us-ascii?Q?XzilZMQwkw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b02370-fe1f-4540-f822-08deb64f2ac7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:07:07.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GWUJsbxFRRiCtxwZiiUWtWXt8gbXI0bxPpTsNdLEXbeqLG/ttmDb+Yi5P7FVMrpGHgLjDB3Gbd4o5pCeNG1wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249787-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[nxp.com,kernel.org,pengutronix.de,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,oss.nxp.com:mid,nxp.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 19BE858A66C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Song <carlos.song@nxp.com>

Mark the I2C adapter as suspended during system suspend to block further
transfers, and resume it on system resume. This prevents potential hangs
when the hardware is powered down but clients still attempt I2C transfers.

Fixes: 1ee867e465c1 ("i2c: imx-lpi2c: add target mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Change for v2:
  - Call i2c_mark_adapter_suspended() before pm_runtime_force_suspend()
    to prevent potential deadlock if a transfer is active during suspend.
  - Roll back with i2c_mark_adapter_resumed() if pm_runtime_force_suspend()
    fails.
---
 drivers/i2c/busses/i2c-imx-lpi2c.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index a01c23696481..01ee38131ef2 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -1635,7 +1635,18 @@ static int __maybe_unused lpi2c_runtime_resume(struct device *dev)
 
 static int __maybe_unused lpi2c_suspend_noirq(struct device *dev)
 {
-	return pm_runtime_force_suspend(dev);
+	struct lpi2c_imx_struct *lpi2c_imx = dev_get_drvdata(dev);
+	int ret;
+
+	i2c_mark_adapter_suspended(&lpi2c_imx->adapter);
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret) {
+		i2c_mark_adapter_resumed(&lpi2c_imx->adapter);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int __maybe_unused lpi2c_resume_noirq(struct device *dev)
@@ -1655,6 +1666,8 @@ static int __maybe_unused lpi2c_resume_noirq(struct device *dev)
 	if (lpi2c_imx->target)
 		lpi2c_imx_target_init(lpi2c_imx);
 
+	i2c_mark_adapter_resumed(&lpi2c_imx->adapter);
+
 	return 0;
 }
 
-- 
2.43.0


