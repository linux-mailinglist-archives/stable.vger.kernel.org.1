Return-Path: <stable+bounces-114725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B936A2F9B0
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 21:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FE83A19B4
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 20:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A96B25C71A;
	Mon, 10 Feb 2025 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TvcHakXu"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8783625C6EE
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217857; cv=fail; b=Z8bEyi30ZDoMX0BLg5Z4906bIAx9fDKF49NNu/xXw2nzFlYlbH35L3+rpmHFXA8xfpHYqzFY24aD73TDM7sU3t4UcoOuZeutGQmwvmWDOaXTj0M/YBdAswZ0pCL00dF9g7NPVCIvrz+vbLQ+R3SowghFfbkQQxM6uQalTTmS6WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217857; c=relaxed/simple;
	bh=InZJ+ATN/bvAN3yPTN17z1VElK9uid1FmFYNfdeYBjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcnxoOx/OiJ+CReufE9cGNMmZTjjAOVKYNliznkaZBWaSFVJesiG/rBkP/J55WgLMHLjjzMf6h43UHI2DgUXjHV57WS8PfEUk0bmmxi1fYgBlK5ZBMVTUQ64f5G5MCmnRz0dvFulYPbOG4u8D0f4tKuI9Lt7rFDsx8SfuJGbPMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TvcHakXu; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6tdCEIwC2KGnMXlTCLp+uNjBj/nCcpmwlXSY94/8ZF+Z9VxGAV4ki3gWJNjQoe4qlh4ujrxjmWLnMgb36Ck8srR5eBxCrv3UaV9wuaUQ7m9CjnKAtix5yanvXxTKtPdWjO+VQsvhXewExzufcN0dSPDO34Sekz8sAKg6lrUJMPjnhhAYuOPdo/jgSW4Mdxi8Ux/AHih4wDm0S7K83tByVW+tQvP2x1EHmoaFxURlV84mSm41YqAnSOIfSHtxt4/tnY6lnFAqG00vwMsQpc0nkkQ3sVUJx3lAWlhDBN3IQit/HeQHtWXfmZ+6g9WB727wQuAP20USP8uY5xtx0jT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcWD+dnfrJ1YIsp1Up9QnBjnXU1p7zlcAk7UHYcmACs=;
 b=f4l17hgXbDgFwA0KD6CUNOBq99yo3eEUqZQBBlwVQJcsZsBNLZnlXjalCb0WazAh32uQKuS0CVkwPV2ZasOf2RS/+4JvT9yDkQgzeGI8jYzOQL+xOYvor163ywSwZz2xGcrg3OhwZse+Wxcis9pG5hdnjYkOLeqkzy59hr49tArb2ZjBvRlKT4xFeDHIqUadmF8tTGw2VCFWdju2ne38eAKoQ9RuH1IcE84r5WltbWacw57qF6blDbNyvDrhW4w9F3HxXIJHb5RqJPTiSYgXAkedRVCxxtI1XojaqTouWfZJkQQiz9ZkLYobwAyZXB0NeXBqgPtE8Cmk6vtrGFebEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcWD+dnfrJ1YIsp1Up9QnBjnXU1p7zlcAk7UHYcmACs=;
 b=TvcHakXufXwvuPXcgF+xzH8ELW0+fAKt9mzlkHEud3SQ+omXxj4nPP9CNlz8sQV7pTB0GywrEPOXNYq9IJsfHL5TcVXVZNk2oLd1jOANNxuswTJlD6a/NGgrUacxr0Jq5oqI9LpqLhp4KP1kr+a09WJJee8W9/XxI5hMyGiy/qZNgRVvKgN0e5n8sNqGLgg9iAUuFRUgb7F6g5IWFifLhLS/K5eg7vK5owlHH2oUySqPL+lpFSftiPbKHeD8GdQTe2wPQgTYaKnugzi7At8lirvjSjvuniSHoOhiyYMYFiShhIEDcW4v4YDsoovEZN49elVSOtezoSssYVj23xw2+A==
Received: from BL1PR13CA0415.namprd13.prod.outlook.com (2603:10b6:208:2c2::30)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 20:04:11 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::3e) by BL1PR13CA0415.outlook.office365.com
 (2603:10b6:208:2c2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10 via Frontend Transport; Mon,
 10 Feb 2025 20:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 20:04:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 12:03:53 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 10 Feb
 2025 12:03:53 -0800
Received: from build-bgriffis-jammy-20250118.internal (10.127.8.9) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Mon, 10 Feb 2025 12:03:52 -0800
From: Brad Griffis <bgriffis@nvidia.com>
To: <stable@vger.kernel.org>
CC: Sumit Gupta <sumitg@nvidia.com>, Ivy Huang <yijuh@nvidia.com>, "Brad
 Griffis" <bgriffis@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, "Thierry
 Reding" <treding@nvidia.com>
Subject: [PATCH 6.1.y] arm64: tegra: Fix typo in Tegra234 dce-fabric compatible
Date: Mon, 10 Feb 2025 20:03:25 +0000
Message-ID: <20250210200325.2521529-1-bgriffis@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025021013-rearrange-cavalry-69c3@gregkh>
References: <2025021013-rearrange-cavalry-69c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 288b954d-6f80-4205-2854-08dd4a0e154e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LyY9x5W4Z8GXpMJOx8VAJV1pZHnq4xGFU/vnd/iYMW/vouexXd1yhILwm8Mo?=
 =?us-ascii?Q?ePt519fZ+BSszRCoSsJFshUIdNZVHGcgGGNNXek5dz5mrFcWITI/sXHNw7KL?=
 =?us-ascii?Q?ykV/v54crCSgcK6Itzb1/wrKUg7CPLc30/a+XyXJettl4M82Ca9jTTAf5gaC?=
 =?us-ascii?Q?YzPdn0YkrJQdNANIjawulPKpKzYQqTVsxLXf8FUMHV6QLv7pQsTP0l6F00q7?=
 =?us-ascii?Q?8yEZq7OjcTqIFcf/Ut0GwCoxnEO0hcoWlrXWCkTI6a5hz0otuPeTJ0C/Z5yD?=
 =?us-ascii?Q?tu93wH5LQbAxa8n3HJQFGLuvvJxNXpqvXg2NPnKI2w+AoO3Nm6TmCBVEgyXx?=
 =?us-ascii?Q?8w0UjZw63LN9gBtzFEjwDz20RfytVNMg0HRQ9OS1vYPGquvPNxVJnYJtkA3d?=
 =?us-ascii?Q?ezmx/r70ch4J0e4Sam4N9TzhMgoWbO/8gqRBfudA2EOGkDv3vGP/XTg9LNUW?=
 =?us-ascii?Q?/yMzdTQTwNonqEA2F4rHaDhUM5kfclt8BXnd0gTOFVSWgq4Do+h0+kwyHbB2?=
 =?us-ascii?Q?iZB4NR72wX5IIvV5Zx92G+UKEgZtuqyv4nuB57lPRBs0d3cuBBGyWd9gH45Z?=
 =?us-ascii?Q?XzZFHlklrQAnynnJHVoTBU69dzdOkYK8GFWfO/J1HuCGDVXun926IbHxJRzz?=
 =?us-ascii?Q?2xdGw6QH8F5aCbx96ejOAC577RNEAER2v64Jc2E1t6gQ/ApCp/YpeWehu6gC?=
 =?us-ascii?Q?xT5RFzm2Rp94tzDwCRJAeYIYMXI6DfEItIQHIJZtEhcJOlRQSROzk3HMy2RH?=
 =?us-ascii?Q?hS9n0on/OO/eQKOm0P5s0HBUFjtO31h+POyKeMhpdAKmCbMnz8A4KAvQ7ZWK?=
 =?us-ascii?Q?pllBeKIiwyExKDHqf7I15+vFkMT1p5A8S1Mwcsm0TNbZ1Crw7DsVeMq2TZs0?=
 =?us-ascii?Q?g8rZHx8wHFKTni4cmIxMNCZSQJoKycX4VZ4q3qk/sQE1Dja1v5Fffk+UAyEJ?=
 =?us-ascii?Q?IqQ0UpiobnPoIeWDIUutii9Qqu70Y6g+7dkQ87axN9RURrEzz2/wPy/0wcTa?=
 =?us-ascii?Q?OsYBY4NS0U1ToaFc+2kYAvh0anVRiQdplwkGPZCqIZAPMxc300tQ0cPY4UoZ?=
 =?us-ascii?Q?UoEC7pJaHZndap2VOQ50HA4RrhdORds6kSsuj1OoRFl5073wzei3r0Azjz0o?=
 =?us-ascii?Q?UokinpOwlVyiiAXvyO89wrnXAWnlp+tkWfrwdcY7ivOSU+2cp5COKYQztNR/?=
 =?us-ascii?Q?DoNwShO1tCUro7Add6hQ57LDUZ2PA4PODV/tAR9xInYYU+FzbzDoNg21KJLa?=
 =?us-ascii?Q?MR5ZCcFmOHlDNLEV2ZjEsHqkYk8fg8uGhoz83pJBssnzRJuFLd2lRKxLZxZu?=
 =?us-ascii?Q?OYHMQgN/UuocEmMVNRX985FiEF7I9/HkSPfH9XR1lenAb0+xU/++AWoho906?=
 =?us-ascii?Q?0JfmmFfwtk4tQAm6rV5jmqM0YCUOvAyhFLDqAIWKGTMOASC65Ivbb9gkzZE/?=
 =?us-ascii?Q?gXei+vI1fzkB7iKa9QmPHdzPAEcUMBlVqsanexX7oqp0UuyvfOr4ogcV6TH4?=
 =?us-ascii?Q?xkiGdo19A0fJA1M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 20:04:10.1888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 288b954d-6f80-4205-2854-08dd4a0e154e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040

From: Sumit Gupta <sumitg@nvidia.com>

The compatible string for the Tegra DCE fabric is currently defined as
'nvidia,tegra234-sce-fabric' but this is incorrect because this is the
compatible string for SCE fabric. Update the compatible for the DCE
fabric to correct the compatible string.

This compatible needs to be correct in order for the interconnect
to catch things such as improper data accesses.

Cc: stable@vger.kernel.org
Fixes: 302e154000ec ("arm64: tegra: Add node for CBB 2.0 on Tegra234")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Ivy Huang <yijuh@nvidia.com>
Reviewed-by: Brad Griffis <bgriffis@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20241218000737.1789569-2-yijuh@nvidia.com
Signed-off-by: Thierry Reding <treding@nvidia.com>
(cherry picked from commit 604120fd9e9df50ee0e803d3c6e77a1f45d2c58e)
Signed-off-by: Brad Griffis <bgriffis@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 6598e9ac52b8..0ddb69225ca8 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -1558,7 +1558,7 @@ bpmp-fabric@d600000 {
 		};
 
 		dce-fabric@de00000 {
-			compatible = "nvidia,tegra234-sce-fabric";
+			compatible = "nvidia,tegra234-dce-fabric";
 			reg = <0xde00000 0x40000>;
 			interrupts = <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>;
 			status = "okay";
-- 
2.34.1


