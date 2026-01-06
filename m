Return-Path: <stable+bounces-205119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C315BCF92D4
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 224023024E66
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 15:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB373A1E67;
	Tue,  6 Jan 2026 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PuR15Do0";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="lqlGPaNt"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9FB78F2E
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714820; cv=fail; b=VZiCV/xkqI8ywJHlcVA0uqsznWt/ly/uD57G2huLvtof0BWlfcXs3SBLxIqvsBv1Wv2OmMj/xWoGyjmQs4CIxSKhkFP6ktODbjXzL9YJc+6Tr6ZEGdmZilYxMlYgUQ22x9a4TA4eAjYl+URVxro2V0B5UPwNB6n6dwhLw6qzLVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714820; c=relaxed/simple;
	bh=CicXw0gXIE2RmJngkZ/oB26rrq719C0LS0wjxfaQa5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RAnOe1IHCTdpJWOpR3ahl9bN97thneHR+q51SDanNTFfymB/Q2Tg4i9rS/PWiEWNoQIv3mdKQG59AWBR58vgfNR9DsM4oVBJZdkWSnMfe76AsVgfjQwy4HqzsTu7lQRGJjmLsYsBiT9lIQncvnL5M8LKGJJubZ7Ve5i+RiG4kQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PuR15Do0; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=lqlGPaNt; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6066h3NQ467585;
	Tue, 6 Jan 2026 09:53:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=mSUQ3ntG69KKD7DA
	64SA144Bb+IXqt2dbeKHAa1N4qE=; b=PuR15Do02Jjiw3DW7CGhVYdM2Ya4jVrw
	dhc4/yROFPTgnc7XInU8HSj9mZLUMRhSygoZ0g1Vc6XgB0Fh7EOemMMxHAl21NpK
	uhLlwitWd8BHMDdgin2hlCRB3+YERf4hUmclW17ryB95UZPV9l6gUneibkkvAofA
	9CBETNwNCjzODfTvPW9H0BxsS88JsXObGVLpTO1rG1vs27n5I3hAwmmEtxQYI+uM
	QDnUibNFTKKm0+XhDVMN0IagXEmcoPU2DG9yeW9SkY7828QIzclO2bs4E3QYxBEV
	OyS4g3ytttsMcMP/Llfw84ZDsGolCp9SIwb8o5B1RaUwAnDrq89FWA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020095.outbound.protection.outlook.com [52.101.201.95])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4bf0dnu5w4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Jan 2026 09:53:35 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tbyN4tTsbuYFhhnu33FOX+WYxzl4RU4mSum74eRrO2c36GdoEuL3KQggz7l7BhZhWYcfdUNHZMy1n6Gn186+jpW/dMGt0Y+10fsnRoRiso151R6foQgAbR0cg9fQLYqMLd29KvRiCYCwTn8UQQS3PLChdlPUN/JqAndu8tXNmb+bPOIDps9JF3TOPpWvdk/DL+PmPqdCiziXbV59mygBR9VtladBqqHSBpRuQ/2YLgk1z0BOk2QQoZhFVExMsovG2zyaBwDVM7XhqCUDyCRLRw8GObqc+GMJCOhKWgIDm76qx9zb2b8uioUSEPm9snuWQvtP3N/opfKF7iGFrqh4QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSUQ3ntG69KKD7DA64SA144Bb+IXqt2dbeKHAa1N4qE=;
 b=Xv8/djsuGRQG4qj5L+mtGWhRjMaWonXJA50XfN926yiG0rDbeLgLY1WuPoE62p3zuahoZ54N91Ng3LR09sSH9aK0v+ylZ1GJ6CSSzpkiMTTqginks5OHa78RyzCkqblHBkl4AHkU66Bl5Jj292emOstCPRT3vWZPd0KdiA0Tatvmx3aDeGw+wYv+kgx8e3ZD7982fn1Qnkn3uTrHX1rkyvn934vnQR8Rc+xuAVT7tAXRlDrnCBMw7GejuPYWeGogcqL69aJb/bISSS0cb9QU1nOhhk7poLkLI+loUGBTTDYB4zbh3r2+eAxNQJh8xuezo9mzeat/Z4UyiHocaGim9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSUQ3ntG69KKD7DA64SA144Bb+IXqt2dbeKHAa1N4qE=;
 b=lqlGPaNtNFTRrX1lbwA/09F5mq09YI5pLNnuaJnKraWGRPj5FsA5+IGIAky9e4xuQ7yLQV5K+15u1DV6oGue7dSoLCHEDSAY+SL7LUTaa7vdZ4ZQhwDyjweut2HkVtNEOzGLQW5nj4F8jVdeUcBSlW+UC9WLbDx8FZ5GiDUT5aA=
Received: from MN0PR02CA0004.namprd02.prod.outlook.com (2603:10b6:208:530::11)
 by LV8PR19MB8796.namprd19.prod.outlook.com (2603:10b6:408:259::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 15:53:32 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::22) by MN0PR02CA0004.outlook.office365.com
 (2603:10b6:208:530::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Tue, 6
 Jan 2026 15:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Tue, 6 Jan 2026 15:53:30 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 6837140654A;
	Tue,  6 Jan 2026 15:53:29 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 50863820249;
	Tue,  6 Jan 2026 15:53:29 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: stable@vger.kernel.org
Cc: linusw@kernel.org, brgl@bgdev.pl, patches@opensource.cirrus.com
Subject: [PATCH v2] Revert "gpio: swnode: don't use the swnode's name as the key for GPIO lookup"
Date: Tue,  6 Jan 2026 15:53:21 +0000
Message-ID: <20260106155321.1499887-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|LV8PR19MB8796:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a5d83b6a-437f-4bab-ed78-08de4d3bbd29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|61400799027|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o0PcUz9OffhI8W1a5P5Nw+vXBBn6FhHNIAiCL/eFyxMUz8i5bUAmCv837kGQ?=
 =?us-ascii?Q?ovQCAPYDM69tW6OUdtAutMZ+EYMSK+5q0wTWPE3VKunHSaS0PfKpHdQeDZjG?=
 =?us-ascii?Q?WE7IOdtHSuWrPqhss+RV4fjs7llsVVg97ohnv01MVvjianJxPfPk7BC/M2R7?=
 =?us-ascii?Q?hgEceyKQSKQ8aGhDOGuL+Q4Yw8bPcxg82IWUnd6Ghh/VpuHSdtP2FJqUrdih?=
 =?us-ascii?Q?Jboipr2NmRcjakFSVrGF8N3SE72N5Ta4d/PKY8iTdm/EUfrMWbuQiIAaYFrJ?=
 =?us-ascii?Q?AY3mjt9NNurdNhK2Pa+F6dK5aZ0/MvDVZUZhX/gWGZkS66ykxD6jS1HfyG9s?=
 =?us-ascii?Q?qsrSkM3i85IbRFDjJTxKmOmo1GEhIBNfaV4VMflCG/QSW/QhHGADV1NwRHGh?=
 =?us-ascii?Q?wecJFRyc7HpbC4nznD0+QB1KLVaY0i3WvDMd5uzHG5kp2rIot35ylSrGxs7k?=
 =?us-ascii?Q?e4eRh5Wsl4OeYlD4YUTANCjL5lwsjQMbtQKfJu2Sg2HzPWIC8VBTbzz/J6xW?=
 =?us-ascii?Q?FbLfHjtqzgho1FLtWJSNTk8fOoTj7tqns6bIyxoIM5alP6nMsf7w48AEADne?=
 =?us-ascii?Q?wSj9MM2SJ/Q254a4KpTkKh+8drgjSZJ0YCcebGnz5oRS7OzIp+uiO4IrN8RM?=
 =?us-ascii?Q?1yD95KBZdfCgV1OOd2Ym1p322nHbgQTU0yvQIf1WwcH181eyIbAllAJ/FBx/?=
 =?us-ascii?Q?GCjPca6IH16Gqtssaz8woRbxohdYwo6jS4/OyeZp6RImbOmL2aJhDyGKkZ/6?=
 =?us-ascii?Q?LvPbJOuVpEWe6OtK/+KujgKkSlHrCkby9k6fcBys4cVdcAtgwyw2kSU+LffD?=
 =?us-ascii?Q?kDrJ3e+Fw6KwuBtFtl86j9uY3ifPTwU+MqTkWkCk8vEkwxoBIcTtYmOstXEo?=
 =?us-ascii?Q?n0DSAc7UgoS30YR0hjS2KUyf6P4dM7eucxo4HUjotVbF0tWjlKjYerNO8Hco?=
 =?us-ascii?Q?rnPu1JlupG1/TGT6KIwXhPhZYBtuIt4SJ2SYVau9y7YW4fn11t0NGrbAc3Th?=
 =?us-ascii?Q?vGl41xcfy8jzN/dhFycRrj65Q4Mht5zowpzxHn6Y9+53dAWdYFMzX8jcNK/O?=
 =?us-ascii?Q?VORHkVQuHxXFDCTPHXAw0MHMH6Ksb3CfYazGX1uGuwEu4vqNh8RKruld6kcA?=
 =?us-ascii?Q?1CDinYLOQo7T7752gaT3cRfuGtB5EM3LT41SvUt9KGOWzv8rMfDLZLMKXOrI?=
 =?us-ascii?Q?chz1uxzF6upyg+QaWG+EowCVhj+tV88rBHioJIekE/tOgyMf5Ebv5sctKDru?=
 =?us-ascii?Q?UwKrE/7OGRj8y+VuOmFn0den0587NfKGq9l7WhZPiOT94EIkAAapURbKnLlo?=
 =?us-ascii?Q?oiWc1ZSIy8CAajE7njWC4VBPzTl4Duk3Vq4sRzrW9oburx74z48cxpLjaH89?=
 =?us-ascii?Q?LCHqnnqRepQpeY3W4lilpxIPjDXLP/muROzlKN5SXAq/+2+LaKq5EdWHIakV?=
 =?us-ascii?Q?q15lSvxJvitl//oKy74ukxYSs+YKql9rlpdDZW4ZjAhhYC+lNLHphNlujpLm?=
 =?us-ascii?Q?kfOiIaNEaDanyrjxSe8pRC+eFUooYPo/5oo4MDXthW4gJnUerr8amaNZ9FIT?=
 =?us-ascii?Q?XKVsTfcOR81LcNqFkrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(61400799027)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 15:53:30.3181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d83b6a-437f-4bab-ed78-08de4d3bbd29
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8796
X-Proofpoint-GUID: vrZHVITCyTXnKzeMgsKXQsolaBeC7Ynh
X-Proofpoint-ORIG-GUID: vrZHVITCyTXnKzeMgsKXQsolaBeC7Ynh
X-Authority-Analysis: v=2.4 cv=FscIPmrq c=1 sm=1 tr=0 ts=695d2fff cx=c_pps
 a=kIUNUHS17e34GyAlH7lOBA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=O_mYIUxG9PxvoMOS:21 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=NEAV23lmAAAA:8
 a=w1d2syhTAAAA:8 a=1LwIm-yovOpG0Fd6MUkA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEzOCBTYWx0ZWRfX342xhgi4jkFX
 FaiCNTwCdqINszM4ekvi+yZPWZsmNXfjU3+jB3zmY4Jh0LO2enF0TYnr3iLZLHBVve3MZlgOi7w
 Zp2ouBTDyIsaTk94VxN4WqPDP47ryjmFwREd7TlonK9/M+5Z0eJP9NzhwjwWfIoNubyLvOssbmX
 6p0A7a1RSiJ6vTP1gum3iR6XtAzv7BtIq0ao1yrHXNs8VRO9kyXIN0mpGf5U6wUNLrqOizoDZZH
 eVHkcEcpOC5Uy/sgnCPEWj+ZLnI8woSMlMrnwW494Of06Fj/0bUn+ACdx5CzgjnlJV7EFw0T8wX
 xrqUnE5tKs+l4UvauhaLjc2/Ek5/S2tP9IzMCmEIaGiB0ikC6MbogLC2EibfsAkhdlCtVki/o3N
 C4VPhoXuwpmSZnJex+BKHBkjzi2pHv0aVkCu4Ba/lfbKD7B/4fRnq46pcs0Ch5FUB2ChIhYkRjx
 dXR8C6y2fCDzBSa7YYg==
X-Proofpoint-Spam-Reason: safe

This reverts commit e5d527be7e6984882306b49c067f1fec18920735.

This software node change doesn't actually fix any current issues
with the kernel, it is an improvement to the lookup process rather
than fixing a live bug. It also causes a couple of regressions with
shipping laptops, which relied on the label based lookup.

There is a fix for the regressions in mainline, the first 5 patches
of [1]. However, those patches are fairly substantial changes and
given the patch causing the regression doesn't actually fix a bug
it seems better to just revert it in stable.

CC: stable@vger.kernel.org # 6.18
Link: https://lore.kernel.org/linux-sound/20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org/ [1]
Closes: https://github.com/thesofproject/linux/issues/5599
Closes: https://github.com/thesofproject/linux/issues/5603
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Corrected commit ID to match 6.18

 drivers/gpio/gpiolib-swnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index e3806db1c0e07..f21dbc28cf2c8 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -41,7 +41,7 @@ static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
 	    !strcmp(gdev_node->name, GPIOLIB_SWNODE_UNDEFINED_NAME))
 		return ERR_PTR(-ENOENT);
 
-	gdev = gpio_device_find_by_fwnode(fwnode);
+	gdev = gpio_device_find_by_label(gdev_node->name);
 	return gdev ?: ERR_PTR(-EPROBE_DEFER);
 }
 
-- 
2.47.3


