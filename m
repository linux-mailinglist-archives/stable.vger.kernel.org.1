Return-Path: <stable+bounces-114181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9EDA2B529
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 23:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3492718887AF
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 22:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF80A225A49;
	Thu,  6 Feb 2025 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uOiLaBGd"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA823C380
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738881229; cv=fail; b=NX94nZSJmT0PWPWBwyjfx11UPWgJVelVcZOZ+J2Eu2Y79pQc+6+86kMf/9r86b70Mv5CPuj6gaeckCaoY18Wvrelh/b66LHdnnZ2VInaNl3ckaPo03QL52naKubQve+rLa/w2Jkup6ImiuJxQX7lMCxN6vbO7KLkgYA6VPMojmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738881229; c=relaxed/simple;
	bh=yX7y2V2uukYOBW+jG1H1wzgRx2+YYp3N6CYaomSa2Iw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qfsq6EmzoL1FGW0+OcKaCpVv3FjpLW+uAz7DzlAoJiUovoZUw5WBdc3fjbsnwBX2ZbPhB/Z0bOpsQfzTtPQAvZNFui8JXwoFE4DNW97O3Z+GHokmSxBsO0cFRyyUPO4vfX5fneV1jm2ifDFMbe7yscSfPjVuiMr6YZlHz6IqeFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uOiLaBGd; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOEVxJKq+35b2uIHu2hvb+4Ki/Gi5IPi9DSiRuOVtutQJJ1XECTyijmeM0n/Sq+SqiwafmwcGvCZn58i4nuKpzUIWJZoKgmS11ApMqMxTsHFlpPGf5zZDdfmkQcsDBm4bwaED167GzQjEpiwp7TxBdbDGcRDuBByNwW0FLdIELy1+Yeh4U3HUXnD+5n3gJCMhi9GCW83ZTbydFykPmNFfPoTiT41tpAguOeFpDnonNpD+Ucs0mqRJdBAj8zBgYBd3AUI6HT0MZp3R4csOi8wTry/Jki2BeKuhnHFAq3f1hHWYqNxuFiQVmcA6s9f9Z6GscBGc0dD0Ut/aB5yJDl31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1UZTBhTJcYQ/yaszOUWOtN/NL5tW5Jf7Q9g46+SmIc=;
 b=Ni+aXDnukGesmOSHDb/lwdhLu2y8CW25cSDTak5GvsgrC0l8GrFJ4yUVJPKuefMwiQGBwsbTZmQ51C9lCgxDdjFV6xLcZR+n2vrvME+KJ11Fb8uu8KTOIN0ndz3qvOnD1M7EWuFevkryzc/Nn34gIWDObH/79E5m/I68pk6yIUwqCMI6JBfbZLAslcd2wzA1noooAaWLRzwYHq9CLQ+b3WQtX7jqkoc6U81ZXuA1/1gSfTREdhORzOFQZByTwxA3ty/cuElYw0qxGjgdTKErx49TTaR7T+j7xE+rafbTapAjfosqN4YZ886ioSCxQg7keMhm3oGE+qta/Ns4X5k60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1UZTBhTJcYQ/yaszOUWOtN/NL5tW5Jf7Q9g46+SmIc=;
 b=uOiLaBGdGu9w5e8Tl1KRbegZ8Jok9vbRyuTaIztIuoZEPLrFPUjz69PnkwcS8ZYiCE+122FA2MRU11wquDvPV7oZODSfJUAamq7TNyHo6anVuxiHoy7Zio6YbvUgx5bdMw12gjhi+Xhmt4A0OZhH00Octpikv63+JsUUzlu7GyihB6IW2BwvLpKvGF5gYFetcIw87zR6jvjv9Ld9USULP8ZvltFcj+IQVqqX9B4SK2kh0aslKyz+O88Hy30ELhJulNEr0y+eFlCttVF8qIH69kK86T++AeBF2Lq9u17K/zQrjPh9YvtyNTD1oe0luAtSqcQPuBFtwBZCI0pCRSvS1w==
Received: from BL1PR13CA0124.namprd13.prod.outlook.com (2603:10b6:208:2bb::9)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 22:33:45 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::60) by BL1PR13CA0124.outlook.office365.com
 (2603:10b6:208:2bb::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.6 via Frontend Transport; Thu, 6
 Feb 2025 22:33:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 22:33:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Feb 2025
 14:33:34 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Feb 2025 14:33:34 -0800
Received: from build-yijuh-20230530T223047391.nvidia.com (10.127.8.10) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14
 via Frontend Transport; Thu, 6 Feb 2025 14:33:34 -0800
From: Ivy Huang <yijuh@nvidia.com>
To: Ivy Huang <yijuh@nvidia.com>
CC: Ninad Malwade <nmalwade@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH] arm64: tegra: delete the Orin NX/Nano suspend key
Date: Thu, 6 Feb 2025 22:33:30 +0000
Message-ID: <20250206223330.3691327-1-yijuh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 1483ae9f-7e52-43f0-9b7e-08dd46fe50e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XmjWotPVdCkYbU0Y3Dg2/BjWiac/6QilSLaszs2wE4UJe1eF1DC2KfX/V2BL?=
 =?us-ascii?Q?BUXAZ5b9QuhAvn6GeKlpyKuykS3XoI6qsQ1Ou9SpeXWim9GHzQOOwNMiq3LY?=
 =?us-ascii?Q?+ViiVdsKmR+e0bTVQWh7We8X2eUi0Wm8Vq6R2K1WVeZod6DMzrMDFxgwsj7p?=
 =?us-ascii?Q?HjzouK9ip1Qs2X4D8DT7QjVkxgWr7O+N0p9gzT3FH26TZkyaXMiCwluf0Sua?=
 =?us-ascii?Q?tYa5vGJfRRWFYusSWpPdeOSgjUHkFnOWsuMAaw9CBSmsW9nx0gd6MqJ1WC0E?=
 =?us-ascii?Q?og4YzY6Keg2RrVV60ZEAhb5THapSFFTkFpEEvWu2V1KNjIpYyADkXiUlrinv?=
 =?us-ascii?Q?69qWSNSMVx48s4bN96fLJvm5ziVo8YjXHURXV+Sl5rtXf5YBDCd7WrKhoK4F?=
 =?us-ascii?Q?Gp2SunKHBrXvTlX1v68fiYvjOrpQCxGdQWpyPN6YY2Ob4LbSu85QmxTrnB6e?=
 =?us-ascii?Q?iChnDgqwA4RmYd/Yti6/fqZCfwlb/LC1dLseKj6/uNpxyS5Q3b31ETCU0wWF?=
 =?us-ascii?Q?wEMGKiW3O+cMcq/EF0rrAd81k5ob3jkkNmwcyWejqO/BrsvwkVSbwhCVJ3Ns?=
 =?us-ascii?Q?gX5mlmDq0Ie44gf8k925QyYPqHBYsfpaDyAjOZsiTeTcc+lisNwrkGTd89b4?=
 =?us-ascii?Q?gAZSnGPuOId9jK+mpL3qRHlsmcptMj8ZkzfwxBNdRn1eNL2Plt2sl/clMqQN?=
 =?us-ascii?Q?h9GJU2gCUDC0Kpp055+A+fdgIPVtqQovoF98YMFLAbhKwH/sVsaMWIGV0up/?=
 =?us-ascii?Q?+nVOwtEBaPIBzd39Gy3b5q1aWDsV8f17CoB63kJ3Nhxhh6WrNnnf2SVoc7Ny?=
 =?us-ascii?Q?SvKSDPFP4VBTU2EB5fXgcbXFA9YQpLrTQO9OJZ/9NUyEuh8jMpn/quaH4hoI?=
 =?us-ascii?Q?W09yy/aT3+vlDsWKLzWPpb2lPWUCtZTMQ/ykHQ3qgh9Qmd8O1CridB1QNhiX?=
 =?us-ascii?Q?CfmuQNLFFyCrE5/B4ANxjgRofOU3g4PklGzDJvqwqMdmigGfcmYC1D6oZBU2?=
 =?us-ascii?Q?H/cQVJVIdtunarvWFMa0LnsPTxH+Yst/MWA61iHizrMbJCtJVaQclbR7xQEM?=
 =?us-ascii?Q?ROoLC83zP7n9TYRwMRLMBETnhZ09K2zMIEgiOsTTAA9LqMkdxGYuarQGbiyr?=
 =?us-ascii?Q?UFPwTfHgkW0EXkVfpkyv5ENPcD6l6Ak9HYf3RH0fxWVGtgCgQk5cjG7P27to?=
 =?us-ascii?Q?P7ez6IaJtJ+hisUzVoCGrFp6dZ+vNl3OqNPunOINAIWSJ/nnJKdbJ6H1vHxT?=
 =?us-ascii?Q?W1RezEL5s35N6eiaTQw5UW2K1JK/uzxDAsEW9DCXloZqMmiS5cfei/Mc9e+V?=
 =?us-ascii?Q?4vteIomCojtaVzvxFLfMhujfayadUFM56QaLMOXat+f5UDvUjPUQLw6MxXL3?=
 =?us-ascii?Q?eVDW40z9mOx5iX8BzuTYzRM2Ug8Rxm+MuisXWHwZNtS5NpOn9SXkBLGyJlr1?=
 =?us-ascii?Q?hvzJkjEpvqCvSzkYIgm9M7cDgjMUW3PEqvoj07J4naPi6tM8ztaYEY93L8Dp?=
 =?us-ascii?Q?/yFH0b+ZXNjPvhA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 22:33:44.7884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1483ae9f-7e52-43f0-9b7e-08dd46fe50e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

From: Ninad Malwade <nmalwade@nvidia.com>

As per the Orin Nano Dev Kit schematic, GPIO_G.02 is not available
on this device family. It should not be used at all on Orin NX/Nano.
Having this unused pin mapped as the suspend key can lead to
unpredictable behavior for low power modes.

Orin NX/Nano uses GPIO_EE.04 as both a "power" button and a "suspend"
button.  However, we cannot have two gpio-keys mapped to the same
GPIO. Therefore delete the "suspend" key.

Cc: stable@vger.kernel.org
Fixes: e63472eda5ea ("arm64: tegra: Support Jetson Orin NX reference platform")
Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>
Signed-off-by: Ivy Huang <yijuh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi
index 19340d13f789..41821354bbda 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3768-0000+p3767.dtsi
@@ -227,13 +227,6 @@
 			wakeup-event-action = <EV_ACT_ASSERTED>;
 			wakeup-source;
 		};
-
-		key-suspend {
-			label = "Suspend";
-			gpios = <&gpio TEGRA234_MAIN_GPIO(G, 2) GPIO_ACTIVE_LOW>;
-			linux,input-type = <EV_KEY>;
-			linux,code = <KEY_SLEEP>;
-		};
 	};
 
 	fan: pwm-fan {
-- 
2.17.1


