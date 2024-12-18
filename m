Return-Path: <stable+bounces-105084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7529F5B24
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 01:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546BD7A3CEB
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 00:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4B4F50F;
	Wed, 18 Dec 2024 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aiqhBxCD"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A0E8488;
	Wed, 18 Dec 2024 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480525; cv=fail; b=QiuHAlE9rpVCCaG/UglX+PmPriq9ETgkFPCN0jNLNezLUBKHW3C+c1iTQtZgr106/KWJTd7Jvk2S97q/1lkamWTzIcHhaLI5DBJAFeJFJFxsmO5gPbclKPEngeiYxi2uC9QFKt8QLye42Az2cVTzBpNckYv7v7oWacwfXu+ncPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480525; c=relaxed/simple;
	bh=p0LQw4OwYWSNt7VNxvWfW5zOZtErwA+T9KcwcSzDNS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjATXdPM/7319mGnroDwBu2DqxWh0/3Yo8POsT+Yrl3gib/NJEhdhw+wC2epkQqTliHnJ5xh0WCrFeFEDvU+vL6EAAfHf3if1VLFaNY4EGOmzNYh8i1b+5KCyVbAoPLfWEt7kxli6PSb14affzNQCGRACv0G2NNBd9RmEeG2mX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aiqhBxCD; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ug/D2hwKZs4Pr5jBonHy+XqaaQ+uxdHa8gAMuKcE84FdL90jRRxYTJ6D5XXoohE30NjVWD9ba/j3cE8UoWkqLOGJ3fUnOrlvKhQ2TiHse1g7iFrxxl7s4v6WdRo/EWJQNC+1tGCl58Nhy8d/Ti9Bb5022/BRTXSLdMON4B2Fw/A3teJi86kQTICyrBkcgcdnucr3ynv+M5zepG7otJmQSZIa0Nlz03zq3eYDXoNO4dHrzqYJkXcaPZyuAqXpxWRDw9fSWuXTZb43EDp6aBPRi3XJUGAEl3CumMo+sW4IQXYQyrP7VDVfQewajQFeJNAKDOVKNhxcBHKo9MJ/UT7JvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MJrz26HlcMHi/IrzbI4FcP1CGSbUbFL7gWqyB1waLE=;
 b=XpcHuxPYB3ReOpmNWHRS1Y+uy/2VVX7eu6Q42EDsXXpzZXZDeGRj+rpOqV61WzXYdeIAadXGNEo1Zkarwh0BfiSpY6EwIR1UxvcteoS/MxBb4tmB3UWT5tdLbCepXaowHKGTbvHLTSFACWKpsgoUdqSbE61VKtebnyLoarNB73Zz0Hotz51v+dx+ZJFz+jVj5w41Ebt+ixGKO53e3LXVoq72SBwiaxw16XFjKrb2dtHSkUhVoGcgZ+DEChWsEJGkLdmvbu2b27UWHqGVSA6t3Qms7gY0ZqDZcuyM3pgp3oTBlT+F77IQJVRlQu57Rok7nyWF1QOqtFchPUjWnnjMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MJrz26HlcMHi/IrzbI4FcP1CGSbUbFL7gWqyB1waLE=;
 b=aiqhBxCDZ13qPzcLvX+5v3AqxuL35zJANIPYpnxW3Hk8nESV+vqC+VNnczq0cmTIwUhSZDql8ljWyMN7wGAFjXqciwtEpP0u1Q0zUp2PidC/yNc+vIY9oGvOuqwCE5BKKdYJh1sq/LngO0u3ila1KhOF9yNb/EDV+linwvO67OZw4lshIQszs2KwkOhMGRErTSdPMX/zT3zecvitqAOPSZh0SW1arK4DvIobLlAqANTLRh7tyl3ogPgMv2HHjUUUMxRMi38fWLJCm0vjNUzqYiEnWld2plyN7a7Kd/hdi7hl7s1qXvSoqENhat5R5y1/bJOofvzqzXnI+j7mJ3QKcg==
Received: from DM5PR07CA0102.namprd07.prod.outlook.com (2603:10b6:4:ae::31) by
 SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 00:08:40 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::bb) by DM5PR07CA0102.outlook.office365.com
 (2603:10b6:4:ae::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Wed,
 18 Dec 2024 00:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 00:08:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 16:08:33 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 17 Dec 2024 16:08:33 -0800
Received: from build-yijuh-20240916T020458116.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Tue, 17 Dec 2024 16:08:33 -0800
From: Ivy Huang <yijuh@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Brad Griffis
	<bgriffis@nvidia.com>
CC: Sumit Gupta <sumitg@nvidia.com>, <stable@vger.kernel.org>, Ivy Huang
	<yijuh@nvidia.com>
Subject: [PATCH v2 1/2] arm64: tegra: fix typo in Tegra234 dce-fabric compatible
Date: Wed, 18 Dec 2024 00:07:36 +0000
Message-ID: <20241218000737.1789569-2-yijuh@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241218000737.1789569-1-yijuh@nvidia.com>
References: <20241218000737.1789569-1-yijuh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ddb6a3-ddc9-404b-3006-08dd1ef8206d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5GS84vlXNTEl5CRGa+al2RxA1wccXA+aRvJjjStaZIQIYHRInCKUe85PHTLp?=
 =?us-ascii?Q?Imzgelt+NCOTIkI2sqiPQ6N8ymVqtLv6EvoV+6pZ2ApZfqcVqt0B8Vt4AOk3?=
 =?us-ascii?Q?ponmJKCFJ2sB7oScZKfTutILPxCgmwxugnWt+IxSQ680zBPu3lpIzew33Mm9?=
 =?us-ascii?Q?RwYSAjpycn/00lLDQ9pYT8MWDFK5zpCct2jyyJAgB3o6MvJV8mjILYmEGwC4?=
 =?us-ascii?Q?rNfG5a8L5pYShik9aEbnBkm5fLjAiuhxlxo2hhvRcgEexDCuqmmvAhlaOBeS?=
 =?us-ascii?Q?rzSM1+c/J1J7eMMRMyNIoGEl8hzpOmtiYexHf/+KT4T65WQLIzocViw4Z89K?=
 =?us-ascii?Q?HPA6eDYS0a5Nh+mLsiipTwsN/l/YckAfQUq5QFn/1GA3zXAlDBoZeBhnj+Qt?=
 =?us-ascii?Q?vX9/QQbPALuSxnCdyV+Ug1kfH4Zwbm2H+4LT8hmLwASrOweb5A54VORrf9wO?=
 =?us-ascii?Q?U5/S17mDQi5Cml3JZ7sAatizU7gt6i9VQq7uUhUTnIMZFopPnuHBjXAMOFmP?=
 =?us-ascii?Q?EdlfDbm13PitdA5CCbrzCBryTRG81SlvpoYbkNTNJPqpKqmEvyg7WYARpc+Y?=
 =?us-ascii?Q?Xh1SUHlf1kNzLreUkTjfbpw6Yk9A31zGKSxiqm2OhUEdC8KBResiE4yaAprT?=
 =?us-ascii?Q?vakOahPzL8GKUC8WfYVviw/0S7vKfUQTKjDEP0GIlNOAA+eatrPTuAvo6qmt?=
 =?us-ascii?Q?QIIrM6z3i/tAjjEWsitK5WrDAgrlR0YbB5YYIlXPhUUSrpW/HuIHRUSwXqiT?=
 =?us-ascii?Q?B7m4R7o6uaZFtkDeeHNVVgm5mhHq5htw9uLCu6iMVgVRX5knw9N1CX/qj49I?=
 =?us-ascii?Q?Lwy+Yvy+MtcGJuORhmCpTjvO1PRXWd3VN6FVbaLf8ILkfDSJuwITXCKEUnGa?=
 =?us-ascii?Q?X8wabFpPakE1eSqe1CPE0HSI6AOpgPM0fSt+kJZQLQ8CfcfPh90SGGYNSoeM?=
 =?us-ascii?Q?v4Rk1mAd3BOJdLbjG/TgCLwI1HBLXUz69QUh0nM4MubHEjMC36u7nVdMST3i?=
 =?us-ascii?Q?OZ77EU1YTbmsQDweMBWohCszsT8FkVvSgjqLwK+UbxfC4ZJ4YR4Rpt8I0P7B?=
 =?us-ascii?Q?qptmZZFxsMmTiCSmJHQT2M6mrRTQmCeXHPqgApxJNJ62yYMhz8Okcx+oZZ7E?=
 =?us-ascii?Q?xcJVMXqHHfJLafrxu2YO62A22lnyJEWQPY4Gj1IJcWqEGKMY+5xlXhbJWfyk?=
 =?us-ascii?Q?RhN7KTXHVXd0rpRuGpofEzy73Ak4wW4MmktnllPQpLhXUSw06sdexDzmHzaO?=
 =?us-ascii?Q?OwdTPRLv7xNPKndbZe8VBhl5bL9TS9pn3Srw1Up5Ec3gJgIaIpEQBsETapYy?=
 =?us-ascii?Q?VOz7E8DnJkqcU8Qp5cNBIffKm/kZawPAQEGPWNPPhcIWkceYmroZDjLXF83P?=
 =?us-ascii?Q?q5PUyea0r1jhAS08YX0cqKviCeWcOufrLnJSOPTCoaI09GxOTeHB10mvM1JI?=
 =?us-ascii?Q?gX3mfSZYkvLuMP3nJyVulELiG6KY367iEBUHkKKM6rGR7tIYuCqwoiSlBSYK?=
 =?us-ascii?Q?os7INmVV4sVTCGg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 00:08:39.9821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ddb6a3-ddc9-404b-3006-08dd1ef8206d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941

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
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 984c85eab41a..d08faf6bb505 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -3995,7 +3995,7 @@ bpmp-fabric@d600000 {
 		};
 
 		dce-fabric@de00000 {
-			compatible = "nvidia,tegra234-sce-fabric";
+			compatible = "nvidia,tegra234-dce-fabric";
 			reg = <0x0 0xde00000 0x0 0x40000>;
 			interrupts = <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>;
 			status = "okay";
-- 
2.25.1


