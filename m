Return-Path: <stable+bounces-202705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EAFCC3438
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D003300672B
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B0B396DA7;
	Tue, 16 Dec 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jJkRBm9n";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="BZdQVyxw"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AAB396577
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 13:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765891883; cv=fail; b=sYLjIxafSkRB23JOOzjR9bBvAYD57oI3f4xd9VhZWZodFtUNb+5/OzG8CwTa2P5CWP3/zBpARNyy0VeMUG97M8g3E6ElKAPTciOASOEYaSOlcYcStJ2OwVeSxc3QL6hJuQQuk+eig128sT41mxXV0TVd4eaMrCAnxBQpDQ7N7Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765891883; c=relaxed/simple;
	bh=B1l3ytdqaMQN0NSJJ0V8Fsz6PT6vvI6g/QrVS30j8bA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZwSFYitEi0V9ESrmxDlsd0J+izXgOsyle+y+x3ufYTL37RmP74l2BPsKwVxn6ssq1vYY4jCVddHLwNAL18thdjusAvZzSuPrcLSpeOxFsL6CDW5s0kWc5SvE+lYyoHYTp2aH9MnViLHyW1/kFgZ/rDmlHGK5ER9W15ni2FinP8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=jJkRBm9n; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=BZdQVyxw; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG5mxnW332091;
	Tue, 16 Dec 2025 07:31:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=QbkQqtrLN3MAlKNx
	B4v/hkFWBU7oOJXgUFCuSNmFxg0=; b=jJkRBm9nRiR93ALoB0c71XfaFkthHTaC
	Y5JWYfYQL75dS8vlhRfEIIHhIP8M3nZWe+71LOSXXIlVYdDtuymXE2Mjj41D90fQ
	GIVyfzoeqmiuXyECxuFVtRvGY+9g2EW/rkhELNrL9Lf/pMP5rzbxYsaR1myz7pM1
	A9k52c0abRTgyFbmczWjpLhD7G9t9+n5NrkfG8pg09w677BgdTnakjXOKGpbzA1+
	YZli+voNN/ZCC99pVmnOao9MBRzyO6gpg7UUYUVojWtsw2nsr2tyFu9AgopFsET9
	8/Q+FvvsbYc2WDEbYQSHNWrJ6vMLPGfggW4EaxvHeuacr0/B3wGMyQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11023103.outbound.protection.outlook.com [40.107.201.103])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4b15ejbcw4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 07:31:11 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KB9llJd4bx2taOpYfNZEZ9qQ5qqGIz9kGtlwBqBUE6OLcfAccqiJyqt+9mATQMs5dGOw5WaGO8GdgkORhwim9i72bzdrwOsM2tEIggqNVp/OiMsCl5CnwJ5ZbVNGZeTMqrpOFmv48Csn9cj7bYwBZX3PUV17ekSqGIBy1Jjei2PVcxNDF2OAlSnhTLDDJ5SPu80izz3yhE4/1viDK1CSJlozKPwZWsjnE1BZxLMUEpe5rgQcEUBykDBhnLV46wc9O4Ot+ZMlfNAimCfgPbhJQbs4QSNUwJpQfkYfAo2ZXn7xnoPkMk3VgCr/shBMRMwbKxVdlw4G6hbDEmwrjMEj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbkQqtrLN3MAlKNxB4v/hkFWBU7oOJXgUFCuSNmFxg0=;
 b=Nk009Tabosus0F2CzYLvaNryrbeyQTCP5hVQk6vWwGDnmnyOKaKDsI7hG9F+NKrDaleLD6C3Tr+EQWT2M/9cOGjMPrBord5wZyTrecWQZ7NGokKJV47U83oTJowLcJ113BpkCku2EbYZQMgF01hnjefMlrwUyAYpH7xHGTQ5uGV1jLpXSub+ju9YfwnIxfdV18ya5KCbdgHRDaQFpsNzuIE8DJTnDXcs/7cAEus4rDc5O/V8KqnhAgR3Ln0JWIDjfA2NkGBNXBIyW+V+TSqI+sar9QsksKZYPOc2tnIxcolx2MG59NKiIH0dgctusamrHrjcT6le0MyMGTMrQfmaHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbkQqtrLN3MAlKNxB4v/hkFWBU7oOJXgUFCuSNmFxg0=;
 b=BZdQVyxwgBFcAfuQ0HlJ72LtVDXDCrA4k0ooTHQe23mZIcTAjRkKBgCnWyZh+9geDGTlsy788O5dH/8EsvvToDsUSpjZYYjKqjVCtXZF5z8hlTzG2XGFU2jeUyF31d5PW7JvYddM+KqumMw78oYFnQVX1xAKnpecQDJGKsmulas=
Received: from BL0PR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:91::32)
 by BLAPR19MB4532.namprd19.prod.outlook.com (2603:10b6:208:293::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 13:31:08 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::82) by BL0PR05CA0022.outlook.office365.com
 (2603:10b6:208:91::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 13:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Tue, 16 Dec 2025 13:31:07 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 3EA06406542;
	Tue, 16 Dec 2025 13:31:06 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 1D70B820247;
	Tue, 16 Dec 2025 13:31:06 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: stable@vger.kernel.org
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, patches@opensource.cirrus.com
Subject: [PATCH] Revert "gpio: swnode: don't use the swnode's name as the key for GPIO lookup"
Date: Tue, 16 Dec 2025 13:30:55 +0000
Message-ID: <20251216133055.121459-1-ckeepax@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|BLAPR19MB4532:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5ed35a10-d97b-4d0b-3f61-08de3ca75e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XHAK3JXVV8i/m4t9Xc6xfbLdn3fI0i2vMR2EVjWlPA7moNoagz9bKYVP72IC?=
 =?us-ascii?Q?HmZjMWVcxyX5dpr6HimQHXEvB0YhaYfZ7Tc2gO27zRxpVTQLfFk6EOn/FMcc?=
 =?us-ascii?Q?LNYgagIn7sk9vrxdBoaD4SYKetndW1QFQ0kXrR72fkh1TahDpq2WCIDlIyHc?=
 =?us-ascii?Q?pgBIb8Qy4ltj2CPLGhDqu1yHgB0GqBO0lGLYtWEl9WSWmzr8N4xKVcC8DIa6?=
 =?us-ascii?Q?RUGR9geqLjs5u3YN6Y7xMZzlBMKiG3ZxlDVu4Sn5yKh4vdWWWKj9pbu/a0KQ?=
 =?us-ascii?Q?bc70crfjpvOdFcoguuRWw5GG4FvOOjyhrvNQKhKVeswvm3hVzNy7f7gDekCq?=
 =?us-ascii?Q?TGxCuAZCpH0g0fPOhruDecwrcFs9MkR1P/eYjE+fT1FenEdGw4XDLwPO/Zhy?=
 =?us-ascii?Q?kP7bvJqwcyOSZTPI8ZyasSaXRkgbLz/s+iWK35xhJ4Uu8xiC8SI2CVRiIl+z?=
 =?us-ascii?Q?wyzWzMmAgO0wPVmGetMxwSoiG/SZTMWqMU/2qUiTz8FNEWP/8a2Mzq3Tx1LP?=
 =?us-ascii?Q?D16D5MOb6tBWYczA8PfXW9EC16tQvRZq+7Ud7IxzJ5XliMDE6YfwfH3P8lo3?=
 =?us-ascii?Q?qYE2Fiyk79wO3Y5aI3oPX2YqqHk3IiwoFdCVrXMWegba3dMgj3OVpUTJacsz?=
 =?us-ascii?Q?S+7nmy848bmZRtuibTDBSU9qjiXj137PKSueDibV3E7pNSy+7a3TaTVNl91m?=
 =?us-ascii?Q?rmU/a02+Pm8iqHDk68TPh+ubLNTl6ku/SzBaWSi17nXMvX5//6Hw/Dkkn/fS?=
 =?us-ascii?Q?2SZpzxam5Nv3cDU7ykEl1oT5uSXak5CXyJtQXu0S2Jl87vlQg5o4c5vNZw7C?=
 =?us-ascii?Q?nVtpr0sx/4mOUmFzYzMAS9eX1xC4Qs8R9I9xWUIvGyrWRiHLUBHrBjNcMHl9?=
 =?us-ascii?Q?pgl+iTJkBPADPd7dcXLVfHNhyzZwt3mPWwVjfO4D0lyPWgLcmy0TlLncBSFR?=
 =?us-ascii?Q?H+ZhsPeSVihNMpAxCkeWckCfpURrFGWvIwIlaxE00vvZepN1zU+oHHnrsncj?=
 =?us-ascii?Q?OTB76bh0PZE54jrcnmf2PnCaIE9zO6CAwDpplxxLhsEAAQBee4gRfdqnGGUR?=
 =?us-ascii?Q?tESAkr/NnBSMQEp7DUI5rQuUiDOn6PUCVb54n4Agiy+bMGnQ38lw28WyC6ET?=
 =?us-ascii?Q?ahZugxB6ePuezs9JeUlrOP+5r1AF1+1WN+td5HxuHFlUBmmVoSAYUU1Ipy+m?=
 =?us-ascii?Q?ZA0DYjoKSBXmR8FeJL3Uhk22A0bE6c3AN1ZBQJyUkWtY6WDRuy0j+sJ4JOkk?=
 =?us-ascii?Q?eSPd8TFkkbjhOFmYM1yieu4Hmb5RMIG4Pdi6fFBhIE1heCWLN0kRuBVw4eyL?=
 =?us-ascii?Q?XQ/hSmzAnJWH/s8mHk0cOOHwJO7u0uICo5dhXDPWGiNqLGqnRRI/a1r6G1PJ?=
 =?us-ascii?Q?hvvtchtI2I1nQixnxIFcE5zVboTPMFP5mTPN/Jq9C1yfy2wK2rwL9qWHsMKZ?=
 =?us-ascii?Q?dMOk4Fyl+xNwjTO4Txw8ib7nSYtdcNgbwFQ1rkYNSGM9xvZIJ/XsGkHWwcfg?=
 =?us-ascii?Q?ja1tXruywnTtEDCMmrb3RAMVrHq58zlWDqk7EvSYkXvpT4p6lGfAadT9XT4o?=
 =?us-ascii?Q?6EgrNd3G5v5VxDm14/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 13:31:07.4273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed35a10-d97b-4d0b-3f61-08de3ca75e88
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4532
X-Authority-Analysis: v=2.4 cv=ZZUQ98VA c=1 sm=1 tr=0 ts=69415f1f cx=c_pps
 a=eQHPyw/ew0TrMIARq4pImA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=O_mYIUxG9PxvoMOS:21 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=w1d2syhTAAAA:8
 a=NEAV23lmAAAA:8 a=1LwIm-yovOpG0Fd6MUkA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDExNSBTYWx0ZWRfX9JvgqmC1lDIt
 ph0dsxpgbVQ34KXQBGR7MWIaUauvWR1Zh7vs4HsiUdtH5CoCmeTBv4IAmkJoQrOU6g7qmgVem6n
 x7buP6vZlbV+3yv5xBBwVDP3GxLRFu+964+sylSgmczkAD9u6AUSqqN07WNWx8FQKUo3KBQU/VJ
 SsYk5478lY6/xIVlnL74wr1sldgUu+mUOvYoMoZTaR4jEAsuxu/xeHpmBaiFolcRZKwBhl7MWfX
 gy4RZ4Cshjwcqwl1R87Wek7ulGngn0GjvKwSFfDpDxckUXRPGFYtdXK+zZW8c+yMMbuvOM0aufP
 sNOdNbwSBp5jXk/PYx1pbrXTOsgBrVALb4xHUVjIfzNcPS5/gSLOAj76y0PQMRWAEaBwuBen0n/
 tHxzHslQbxCzXUslG0zG0vpqWo1sfQ==
X-Proofpoint-ORIG-GUID: Kkv3ri9vse9iVrKABvMzTa-Tj15rj4b0
X-Proofpoint-GUID: Kkv3ri9vse9iVrKABvMzTa-Tj15rj4b0
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

CC: stable@vger.kernel.org # 6.18
Link: https://lore.kernel.org/linux-sound/20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org/ [1]
Link: https://lore.kernel.org/stable/20251125102924.3612459-1-ckeepax@opensource.cirrus.com/ [2]
Closes: https://github.com/thesofproject/linux/issues/5599
Closes: https://github.com/thesofproject/linux/issues/5603
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

This fix for the software node lookups is also required on 6.18 stable,
see the discussion for 6.12/6.17 in [2] for why we are doing a revert
rather than backporting the other fixes. The "full" fixes are merged in
6.19 so this should be the last kernel we need to push this revert onto.

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


