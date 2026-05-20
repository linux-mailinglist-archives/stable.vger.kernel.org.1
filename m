Return-Path: <stable+bounces-249806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMKWG3qRDWpyzgUAu9opvQ
	(envelope-from <stable+bounces-249806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:48:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4BC58BF00
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EFDD301A41E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2456E351C2A;
	Wed, 20 May 2026 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eyRntQOG"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013061.outbound.protection.outlook.com [40.107.162.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA93D9DB5;
	Wed, 20 May 2026 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779274071; cv=fail; b=EXLXlxT1XhLulY6rDAX3ZJk7QqHN+qwdmPO8btCY1+ev/KyDFITOMSfx85pW/ndPPrJlwJxow8S//pkpPNctCcmF3O3broPUIBZ1xrJq2fyMriTxD342fZCQIGFn8kdvQ389OX99IKmHwQCQ3D+0TT/PmeP1ebm/AtFcdOM5AnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779274071; c=relaxed/simple;
	bh=l8mHSMtu+4tOs47meNnr37w0ctERxsFf2h+j1u+R3LA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dF5wrqhtpcp40hqzH3xsTCV0a8kXwF/pW5BGXHrdYaAtVQTRPSQbcqq+0X4Rq32rErWhl5l8xiaQpWuBETfbtHSncNG47HIGbFs1CcKAyOunEeJaXxWW/+goRbVHo4NVE0UsfyVpGGgy3sY9hO+jDOZqfSqu/c9tF7RpdDJv7I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eyRntQOG; arc=fail smtp.client-ip=40.107.162.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhsCgLhslpeljjA4T5NH1wnbGJw3CQeJlR/K5pyRjXDfnw3Q9JeltIJhGtFwmNIADDD793ZA7mr0dCi8zzn3uLolJJEqpX3ZVItIo7oKUj71fuIQwNx78/SK+VJ5zoTcb5EwCga+y2BEn1U27MTo/OcQZOTb4RVDGlnAtbmQ5wCAHzuOCkkt2iHibggEQyZ2YzCJ0rYscnNcUAVYwjAA/59CWrjzS3bFLOnGoPulXA7icbEzWDpRI0re0hr/SXe7L8tfRe7a6CrbPgHEn9MdepeLNLthQMZzhFdHbYgPsppTD2iXAnL6IwiUs28v8+ITf/j/5re0zV3vL7NYRJArRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bPkgtBw7pHz1RCyCy8XVIPDe9AAjeZUk8Y64p7ixIw=;
 b=gELbuzs4m/c5OHZ2Yfsi6OcCR+6Tu4v0aaomTwAdkPDZAGhDXrGZN7B0dNSGmb07R+oKE8kqvfj2DaZE06arH40nBBrPqmUuv9lnALg58tavJ4/xF2Yi22Y93qrMeMUe+5huk1sYyFmdKDkauAqAMTrKg8nwXykIBlIiPhJVROMfaCDNZ8wBAS/tW0m71gv6lBZEgZFZtEiAH6LWhQi77yqmFo73EqukTLdVzWHepNRjeGlkufIq2Sv74mIItDNcnPswNTUlaAA3+i7ZzlQJcO/I415xQeADXk9GSpPPwjvmXVJDf4k23isPKg3wdlGu/82cz2sZmf0Xp/UiLugrOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bPkgtBw7pHz1RCyCy8XVIPDe9AAjeZUk8Y64p7ixIw=;
 b=eyRntQOGq8DhP/1B5Gr5e80jiPBvnTKD0cbO41qvQx7jBsA/mDUj8BKK+4UYa4AcaWe76KJXuJOfH0PvJsDojHzv4YgnnkCg9L+F0iYC/I1aFNzJksMObsb2D6EruCK4soY3BFsMaR5hPZrdvz0sgbjwhavFhgOhLvqfmrbbrrfNlPpzEfkASvmi/FA4sGl0ZFCZXRbR/u1SfrxW6sEmw+c4cEqlHxm5AAB5+O9tRcqPMzGkPiAbnHuhXwAEXa242B86mhxpGZltnJj05dK32vWQjHW8C99Eftnm24APJD9viNZMabXeJjwHUpvNTBzY+g0XWFVfQXgcHBicftBXsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by DU4PR04MB12274.eurprd04.prod.outlook.com (2603:10a6:10:62b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 10:47:47 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 10:47:46 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	carlos.song@nxp.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] i2c: imx: fix clock and pinctrl state inconsistency in runtime PM
Date: Wed, 20 May 2026 18:49:39 +0800
Message-ID: <20260520104939.2897110-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::12) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|DU4PR04MB12274:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e1c3d4-9df7-460f-14c3-08deb65d3a86
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|7416014|56012099003|18002099003|38350700014|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	iY0+jEYZ0eevQKBWGLzjxd7A20iEONFikJfTDsOkmuMSy/s1/uMcT/tfCq3C3Pqqo/GlfzfpQVzIfxRfSBz5lrVal7mVl1EKUKQ73tbz6u9ysUzc41ljBkYQHKouxR50vIJHzxuPXVevMzq665/jkD6OkTYhfdmaXTYXJmQbassRfdfIErK+ff9PRk/CEW3Pk3GFq9ykREa2vNbBIFxX5M4zBb/nC50OaLa9WHDzdLhMLFKodD8TrrWwypkGOqoKLIXySxRu2f5w1Vrgb9YXnWsvoeXTFu8nsfa7/jhzM/LWCG2v9Go0s9UxXG1nn1gV1eYLOwgd7z0T/5D+7QgiLh5RsNMIIhkuP12diHiK67uwvyxrHov9TGdf5MIZWMDyinFbwbf8srA1RpIY9NRhacjT9l/5vZuekA8xXvxarTiBThNjO7d1c7mGaCPf81cEZLB2szIYQBkk5B1eqe6xFvbcScyEyDfTUVdv7BtujZ9cQavhXGx9hqRPFA7yP2bheD3/tDKBRvFBXtNRpdaKmpkjW1xnOLeSQz7VmDwIEmgo6Q57iaX6kOm2hwygVLhrzam7qnszIwKIEhhX4G0ko6JbpqemsNh3FbmPGBQj8tMgHste119/kTqugYC3w/lRhvd+otLbvZUGJ4pi9HFvFcvzT0yZjDzQs3oCkd+GJ/0kfOqjpmkxMB5bX65KQxOezyZ9HZCaCrlNujOUvn2xZLKTrfqsUYddGBkUQZai4YN19oNwO+8jz4I9KyV/vPeN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(7416014)(56012099003)(18002099003)(38350700014)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vfikyWLI+a3kcwZs6DfTTvG4qfITv4ooDPPWbZ/Y6M8paOi4b12crZMY8z0W?=
 =?us-ascii?Q?N1Vb4Bo3Lbemu3vf65xkO3f0V+bF96tC74qZlpCPFafGnk7JiP0eGh1XBoDj?=
 =?us-ascii?Q?eeISj+O7JGyf5dNrT/pA5C6vWYvsQeaPzJ3Sq+k5q+PjCp1MCQZX65M7oSbq?=
 =?us-ascii?Q?DQnsPALq/6OGTjwxAGqnMw7DdLWZeMbWw1qkeNPXVSR9XaVDHE5CZs6xz+jd?=
 =?us-ascii?Q?XL73q8w7bsJM+RcWqiIRFa9oDeTkv3UwoJRyXm3benDKgviGP+VDs1v63XO4?=
 =?us-ascii?Q?wn/iJZiSojWWzdVImNhJlZQE4ZMGnUEAm7e8wdONAXkvJD8umAHdGEoY+foZ?=
 =?us-ascii?Q?++TIshk5N/95paulEVYZQ505J1KL3cp+CI/v5CqSsKPXlP91nk/nacipn6HQ?=
 =?us-ascii?Q?cC9HDlP8/vDeDZXiLpzXkbVjQGj+xHIL1ip3zYSuQ6HYHUcj9+R1QeaaVB++?=
 =?us-ascii?Q?m5Vu8Jx4SwRsva4Gb3IfP88JCb+w4kD8lrqsyW0/uC5M7yIOFZNUE7Qf0u6x?=
 =?us-ascii?Q?X/eNkcLNQj9poEPeHMTpAwF+8Lg1rUUYLCDplaK4qRA4Xv/P+tDANwSidX0N?=
 =?us-ascii?Q?rymQW20jOVdT++LvAjollxvyeygJee7auN5z4VPBGpVfX/YrFeVcowFCwpPE?=
 =?us-ascii?Q?xvEeJKs7cqII23AdUxXCpr2GBbP9ZrAtdtBILLhtV1u0B3tdDhtX3vBqiIAA?=
 =?us-ascii?Q?vApbS+ac8Lp9tfJtfNXvY7nx6iHin5RopPE8gTPT6Wt0w0tkGh6OJlMnmOqv?=
 =?us-ascii?Q?Q19/0CFMqnL3oN7uaur0VCt1c1nh5S8mbwELFf1IYKHz+P2XBQmJtCCYpyRz?=
 =?us-ascii?Q?YFgXF0zyVASweAM+9b6BRGRHTUpn6BoLhdAQWsOD8/6l1Olxtgqo/86OodMJ?=
 =?us-ascii?Q?P95DAjXqbeOp5wFW52P5gX4lCygzaObpsnkwf85fjBhUwuHsRTraPlvC6jOl?=
 =?us-ascii?Q?wM0ZSzt4d1smNCgE6L8AcaTinqkDL9gyat5vEZaG5KyroAEkYt/ouIisDY92?=
 =?us-ascii?Q?m8BLJgXHAKsA2XIOYRw2KJJ2AK7OGwsT4jyh2ZfBx/vXx/KD/FYuHNpn6oxf?=
 =?us-ascii?Q?TW+nA3NDT8z+ZnmBujI8Wp14xqUhZCfZysTjbOL71TLiqfVO1PVEyyVCAunT?=
 =?us-ascii?Q?7WlbuCR5w3KMgJHrWHFtGpjGTFYvPePToP4Khy3oyjRD77I4nhvyI9TuKuI2?=
 =?us-ascii?Q?Tbrzpemon5D1zZogn7HRof6b8Xa4o7DCbHhEiHAqNghY7tcTSGuvoilbpkGM?=
 =?us-ascii?Q?30fzyd2qGOkQFt81Nxp8EPZq5dBtWIuk0CKNLerTIdwQiZL6lFmgoZkTClP5?=
 =?us-ascii?Q?HzXoxHS3H655i2j3rHZ5FIhAr6j4RbUu6i2nEt81jnJwIQJx3rK75SLZ+yfi?=
 =?us-ascii?Q?eRpB5HYD2X5tiN7t3GXSqVL8uu2nrm9kE7upI6TavR8lWIrsOlJRDumDGO0n?=
 =?us-ascii?Q?KKVO3RixSzhR5aCS0StNNYva5LqzacZG44X5z/8jW0b3QeYfA9bYGIZ7dok1?=
 =?us-ascii?Q?A+a/Qyk7+KNohFYxP91UbeMt/6hKIpkv8FHOS+D0b0g7RwtUdRT8RPCL6jZh?=
 =?us-ascii?Q?mn4iTh58Qui8Tte+s4Jz6+fC9IOc9rycxtq+Hc0F1FsrEW6E+wCkQZ9d9n2k?=
 =?us-ascii?Q?MvAanV8prHpTFWHZzgUmZ3UZmE2+hxZDA3T2UZVha2GZgjzAFqigAtCJYQhD?=
 =?us-ascii?Q?/Hbz/nWSxpwV6+xAYTxxB6bcj7zbV1z0OH0obPVZg3Rrm4mtirNrlt3aYjoL?=
 =?us-ascii?Q?Q11aJXc/Xw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e1c3d4-9df7-460f-14c3-08deb65d3a86
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:47:46.8178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQgsf6k5KyA7bIDUnlFO0refBcQYVItOxXC3E3AxHp7hZFlrzxmBSqPf5HkNsZoyxRJ9G3EGYeXLW2vPcCDpQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12274
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249806-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 0B4BC58BF00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Song <carlos.song@nxp.com>

In i2c_imx_runtime_suspend(), the clock is disabled before switching
the pinctrl state to sleep. If pinctrl_pm_select_sleep_state() fails,
the runtime suspend is aborted but the clock remains disabled, causing
a system crash when the hardware is subsequently accessed.

Fix this by switching the pinctrl state before disabling the clock so
that a pinctrl failure leaves the clock enabled and the hardware
accessible.

In i2c_imx_runtime_resume(), restore the pinctrl state back to sleep
if clk_enable() fails to keep the two consistent.

Fixes: 576eba03c994 ("i2c: imx: switch different pinctrl state in different system power status")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/i2c/busses/i2c-imx.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index d651ade86267..54fd5d0e4056 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1892,9 +1892,15 @@ static void i2c_imx_remove(struct platform_device *pdev)
 static int i2c_imx_runtime_suspend(struct device *dev)
 {
 	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pinctrl_pm_select_sleep_state(dev);
+	if (ret)
+		return ret;
 
 	clk_disable(i2c_imx->clk);
-	return pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
 }
 
 static int i2c_imx_runtime_resume(struct device *dev)
@@ -1907,10 +1913,13 @@ static int i2c_imx_runtime_resume(struct device *dev)
 		return ret;
 
 	ret = clk_enable(i2c_imx->clk);
-	if (ret)
+	if (ret) {
 		dev_err(dev, "can't enable I2C clock, ret=%d\n", ret);
+		pinctrl_pm_select_sleep_state(dev);
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int __maybe_unused i2c_imx_suspend_noirq(struct device *dev)
-- 
2.43.0


