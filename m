Return-Path: <stable+bounces-196879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2E2C847D4
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 11:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F300345008
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 10:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592EC3019B5;
	Tue, 25 Nov 2025 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XabUiJC8";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="uN6deiFA"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F93019C2
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066581; cv=fail; b=ETpp5z+EgO/HBLiH0Wy3SIB//Od2jUWmkiJAVokMohgpWrdJ0EWR7OVg2ifjW4cwxNay1052l2YjtOvf/kFhyTREgmKW2pcfooneUBaEKzBPsWsUn7LCFSp7X6xwzoeEV8AqwydvYPlHY6/1oWeAZaz66pB38HetOtA/J4zOq08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066581; c=relaxed/simple;
	bh=TRkl3+hqvkFCX1Zsam72l7ZeTlcfPeDWIMUNQLIyQZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=liHjud9P8UPKZ9b5flucbqqi6ZoJ0RwRgdG5r4dDmvYHTb2CwVXOClvxzI0mIGubpj4ge7/+4H7S6RavJqCbN+0Z15ZBumqR7msb/Anipy1Yy9q/drahigA5h2cQpbj+2F2jwaZJ/RDjfG1Xu6lEQcldrV39/S0roIHjewq9kWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XabUiJC8; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=uN6deiFA; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP4KSmT3312533;
	Tue, 25 Nov 2025 04:29:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=s48orkO2+uv4e7tR
	esnDZjLHzUK/+cD/YBFYhA2EHPE=; b=XabUiJC8N2jucxXm+XtWATcT4X4KTDVn
	EO/mLj20jXs6lRupVpNDHghKdlbmVoJjNzLLefl8rYjraMYPVZg6Wxl4MHXeCpFL
	u/BTD5HwZ/roFAaNrhhShL2QP/Jv/DOOnIQT7lJNCfUpy0rYJvy89OpNp83EfwwG
	5LWdpJdxbY386xoxuLuArtoqNq8Ys0h75NadjH47l8XIfRqTpbp1GQBZWUTnqWJu
	eq5d/1qp1ww1IEODTMctB/E3pX6IVqQxNrwT52/ONOBQz/mSRlG2vcWTKSsE39gS
	Rc9p5S8FmPNjQNVBREM5fjha8+ZtWvzh+ZYfTgZOigYznF7kF/0A7w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020138.outbound.protection.outlook.com [52.101.46.138])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4akbf1au8p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 04:29:33 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALlI2MlTtwjwR2sGU5Bqk8FS9BiOLvSjJBZPzc9QmokG/v+sHMMrT8YLskxgggQCTWL9nWN6UJSC3Yv9fZsQmS+JubgeaqkTrfzASCmBJRw+8V68ztCWf0Fx/QqFhxRcsw5BwmTBCAoLdSwLwVsp4skssV+2flotwc0vI2hM57KX5TKNBS7+fPJT1Fw42iCGAlD04hT7hDM0GSXc7hqiakSSdA/J3iyTETHW0xv7l8IIzHuXMrewPRsgb3LSV4uMjEqMAj+R/E27iK2wF44kJcN/82rjguRFR38R/cVY7MlVGY9jrUM7mR0yNiJR9o0rwg2WdYbb9XMfdfRIDmY7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s48orkO2+uv4e7tResnDZjLHzUK/+cD/YBFYhA2EHPE=;
 b=K6ML9nQ0GdZ1ND3C7K7ZQ4PXBIMEL/Kb4uWH1UPBDRWsJs1J/9YNnNEf69VrLRL/7h7NkX9BAsVCRIhmBGRCBGsdBuDZFNcb1LjvyBzzOllA5/XGLxHMWKJR6L+hc7WjRWRsLioXKeuIYnEf2mEhGQ/g252rrGYhzoyT34Ds/3fuJPE7VnfoeiQB3MHEP0CEPwnLL1Hx5DsIDmT+zt824/nk/yTE49iQJvTslurfbA3UwALC+97RIt/IBK69SWJimQMW+c6ztUXSbPU251GsL+ZI+RhjFT/+7y3N+Gmu2IhQxFsCmehI334mUxxjc7Wv86BqwJI25CJAPdVp0kKX4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s48orkO2+uv4e7tResnDZjLHzUK/+cD/YBFYhA2EHPE=;
 b=uN6deiFAilNhKKbwpWWflthq7K5oJ8G0x0H3Jf9W5iOjhrmSFtV+fvWTbyMuMTEwVHUoLWsooFzJyoB4+I6p8V++bg4cK2ENMgI2Yclw1Ht4WLfBnYDhz6S8BjcJqy+edzcJpIEjM9SW2k7Crn5B34UBFf6l7dIu9RaFmOV2npo=
Received: from BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::8)
 by CY8PR19MB7226.namprd19.prod.outlook.com (2603:10b6:930:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 10:29:30 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::e0) by BL1P222CA0003.outlook.office365.com
 (2603:10b6:208:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 10:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Tue, 25 Nov 2025 10:29:29 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 438BC406540;
	Tue, 25 Nov 2025 10:29:28 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 27F3E82024D;
	Tue, 25 Nov 2025 10:29:28 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: stable@vger.kernel.org
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, patches@opensource.cirrus.com
Subject: [PATCH] Revert "gpio: swnode: don't use the swnode's name as the key for GPIO lookup"
Date: Tue, 25 Nov 2025 10:29:24 +0000
Message-ID: <20251125102924.3612459-1-ckeepax@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CY8PR19MB7226:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9b82616f-b229-4e15-177e-08de2c0d83ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3oevzuYgXmPesXQO1Bb5j1ks8a5kA8bLBZKGPcPyXnlOkyxlMM/R9yXV2nOB?=
 =?us-ascii?Q?dbGlTYS1cOP1Lm0joKm0aL/9XEkHjnTO5PGfWsWp2/dZge4bAN+B38FFmhb5?=
 =?us-ascii?Q?D3NTREX5ppCdcL5jcvD1dGhgSvKYO+tzuXJB7RFtIDbhFS+rgu2rT53P5dKj?=
 =?us-ascii?Q?hM9m1gK+rHSTFzqhFBN/+sdVydPqoxQNNYqA0+YjinZN4P0n/XV/YAXhz+60?=
 =?us-ascii?Q?Z9dUJT6bsXy87j1XhqMCLYMOkwCLSwLzNfzAYz3UHOdd7kjYd9/hTe7CuBuf?=
 =?us-ascii?Q?pmck5pGMta8wngORcodrU8J9lCXkzwhtV148O9XyHm3vUIc+rlhpuyP3tT4a?=
 =?us-ascii?Q?+utRHeTul9OAwMIbaxywk2qn5H/Gmvxp23b0d5uj7YLaLGar7v5Zs0DtZnkr?=
 =?us-ascii?Q?Mzi11iVvxBAHinHZlcqiI+XNr7bT9YKCAZ5Eiqzf8huR1ygETOvuv5y5O84A?=
 =?us-ascii?Q?m1cVR59NE1WHTO9tAHqWCIkrqYQwtdKiodPhHoQ1MtgukCDRdzWs2rtO25HA?=
 =?us-ascii?Q?YjdyLtvOp05sz4j16QnQ7A8J7EdDGBmW57GF4pJo1PaQ39fH5QJMjQaPlSxy?=
 =?us-ascii?Q?TTO+fNMlYwNqYJab1i7mU9HfbW4AMASvHS0kzTAsj4g/V1YnsxBGHC9O0W71?=
 =?us-ascii?Q?OlUY6pPJgZ7bnWGp/S7v/ifpMFN9dKiTGsfH76SwhmeyXPdB633Vcxuper60?=
 =?us-ascii?Q?zH0cn/CuuCUF3wg+QvyZWbY+oKKP/YtYXUlMkAoGa77ozjV89R4k9cICislA?=
 =?us-ascii?Q?8BFApSF4tGshiITEqmk4FNJqWZsvZ7QhqKKoxuwSe8x6lnMSrK2XQTa8vtPE?=
 =?us-ascii?Q?00WWVORJ+dBh1k5H+RqXdg9yFzMcgWE57p06bGTu53osHW7M8C9zsMWmuqLp?=
 =?us-ascii?Q?D8rpBO7Iwy/Z9gCJAf6ghaaCfIBGDZMpxvL/xra1UEk81G07UXwc2BnBXUcj?=
 =?us-ascii?Q?fjSSE3LrQ5xVx/NoNH2bmhO+CMDEVv0hFleYbzdmngceY8/IeH/cwwTyWXK6?=
 =?us-ascii?Q?EoC8n1pqTRmATYEoP7ijtSVn3sgEaIKFftqPnf9ZfrDUwj39qLrL1EUAeLOc?=
 =?us-ascii?Q?XFe4ARYPU0HgQ8ZrWbGJDuiHQl2llooqzp2umE3NgkGcRhz1ldgM0G1k/hja?=
 =?us-ascii?Q?END8fTZv+kM3tRf0rtyrZoH9p3bVobP0PYupvJo4OGYhkodcj5BQdwQQXrkx?=
 =?us-ascii?Q?PDqOIPzs1UczNjoRq9zpdMlEmDiWhenNBJoxxjN0Zv91h5EYJCuZf1gWvtQ4?=
 =?us-ascii?Q?2MVKnx6wiaBkJnRQy2I+1yWhaU1JCBR4PDVlMTIWI1wTnxgkWqJfyQhe/U6I?=
 =?us-ascii?Q?w0kLhgkbq0DpqOqlie22KnzBN0/S/CgQz57hu2m6e25pskNAC5WMjtXJSvVO?=
 =?us-ascii?Q?BqSF/O0qIHnnBPC61d+gcl5VUKJ/NzS36GeUi59c6t6frRNnr8jvHFO45qRP?=
 =?us-ascii?Q?ndCYaW20kd5mWz268DS65+gMVNqMjsWbq05cbBSNtNcLg+Wspzoh22CmQ62+?=
 =?us-ascii?Q?Idig1AG6nLVrByILPKFtoAIyYLREaKDMlkufx6AthXbTBU+nPKWd72wobNUu?=
 =?us-ascii?Q?qPGJnjhVlcGz9PeDXRU=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 10:29:29.0751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b82616f-b229-4e15-177e-08de2c0d83ef
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7226
X-Authority-Analysis: v=2.4 cv=caHfb3DM c=1 sm=1 tr=0 ts=6925850e cx=c_pps
 a=FoMG50TuxTqJTEtiCMANQg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=O_mYIUxG9PxvoMOS:21 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=NEAV23lmAAAA:8
 a=w1d2syhTAAAA:8 a=1LwIm-yovOpG0Fd6MUkA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA4NiBTYWx0ZWRfX0ruyPfxx0+2q
 zpKBKz3safsSasWdLvQi1/UxCO5S59rJ267LHiw2Nl5p5cDfkMOhVWEeOalM+KKIfLq0f2hBHqj
 9pkFX9ylZH73cRr3tiv3O63Tr+hpXifB9TQ3qm9YCgLIlpKPcNmMEYkWqpU8u2/HZW4+Vm0QLH+
 oAuFLCRb/hP6Y8kCPK1+F8Nh7122uISLParJ3ro7BUrlKvS5raANefj/bn+xFnZD1lWHgQF4Vz7
 ocBdjoBtV9dgva4PexRZZjYfocU+uAoMLCtEW4h01rw6TyXLlcANgG6oXoJA4RgWae9wDjjYepD
 a1SGLEcgCCAXiutTy0m0At2mvLFAldiW3a9xn9wlpt+gM2QgsWjGxviLyojNFJ+g5oE3vauvxxJ
 G+txsGAFn+5feKHLrllwu8KvLKLUgQ==
X-Proofpoint-GUID: QwKbGl6kiXFa8XSHXB3vozMPzTqVLbjm
X-Proofpoint-ORIG-GUID: QwKbGl6kiXFa8XSHXB3vozMPzTqVLbjm
X-Proofpoint-Spam-Reason: safe

This reverts commit 25decf0469d4c91d90aa2e28d996aed276bfc622.

This software node change doesn't actually fix any current issues
with the kernel, it is an improvement to the lookup process rather
than fixing a live bug. It also causes a couple of regressions with
shipping laptops, which relied on the label based lookup.

There is a fix for the regressions in mainline, the first 5 patches
of [1]. However, those patches are fairly substantial changes and
given the patch causing the regression doesn't actually fix a bug
it seems better to just revert it in stable.

CC: stable@vger.kernel.org # 6.12, 6.17
Link: https://lore.kernel.org/linux-sound/20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org/ [1]
Closes: https://github.com/thesofproject/linux/issues/5599
Closes: https://github.com/thesofproject/linux/issues/5603
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

I wasn't exactly sure of the proceedure for reverting a patch that was
cherry-picked to stable, so apologies if I have made any mistakes here
but happy to update if necessary.

Thanks,
Charles

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


