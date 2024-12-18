Return-Path: <stable+bounces-105085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C621E9F5B21
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 01:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1101629A4
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 00:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ABD1E4A4;
	Wed, 18 Dec 2024 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ULMxA162"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703531BDC3;
	Wed, 18 Dec 2024 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480527; cv=fail; b=DPZBmfyKEOD8Tq2PS48iFhDe1yPfGpWlko4VzFGkoBV/urTJgU1Tids0040ywXba5IahL5iI20s0lS0w/RsxSXzu94OyQBQAiidYkwfr5f+g1zKXkx/cbSL5iwaO4nPhY5OAQPYhNz7JWajd8j5JlntEZV75TG/4z9Do3/e4Eo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480527; c=relaxed/simple;
	bh=jlF1gHlt4Sisaf0cHZ9DQceZLVknmM00S1QALtdzGr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzXDIEAOvPZt8WKXsbA+XetKOEhro0BlOH1KaTYFKs9qP0NIpCEAHeobxzBvJmByLcnO2TcLuBGK2S2cKmKNNvc7yJLraP0Oxhgz3/ni2gEtE6e8ujYC9ERsmihSmdPXzLZYr3EuuyHPojzglMDJ3pZYMxOj/Di94LdIpsTELAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ULMxA162; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+R1kiuexTgUt1H7J84s8wTpxF6GCBaXeOsVwwXH3U/7VsO5i5xPmcvJRpN76UqHLj8iDVB/dM8XZ/fKlyr11jSxpLFjTtvfsnLtm3dquRP8LmbcsxEqIHftbf3qZYq8/voPMD0nxf4iMZa2j5JHh/ZQDNWAL0q9MWK3gb8CUapFSIm1kNbBwujE9/0VnLmolhvBxL4/5t5BTYqsBitRQh9+NWL7VT1nABzlI7Ovmu9SSb0axUU0UIdahtdiAmb3tvm8NFa632FBirMDPxlCe1nSakN0Z5qctadwyBGhatDNHLTxY0eaqtMCTCskyobz4yYqLs7XDGUgUXdlCLrdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXJxqf0WDpUJ5o1s34uUD64XyfsfRJaQRMObXBjPj4U=;
 b=dmzq2faeSwZ6AnGq+n3tpS/XsVagYakmZsxZVQjBozoK3OdvqAfwkB+4F7EME4asrgk2CsA6rtp2lpWaQ6/9AF81+N/usti2vqfU1a3t9c5df+jtGl3uMaVtBJ6u/0lIj7KovVR4QgGbrkPjWyuXv2N6BzT+gsEE+4YItt2LtXoifsVAUwezDdmoayN10AoFLhFkBYyizag8JmX8b3uv44VI4RKY/hfyABFYM4O/PxiiTeZiT4puHvcJ0Gb3Xpx4x8KnC6hY+qnZdZK51A3FhAc2Sc1DsxzPpbO55Z8fAw4bxgOeEFFGhdEQ3vJ/vDu3ev6gevfzs7S0uVb+W7yjsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXJxqf0WDpUJ5o1s34uUD64XyfsfRJaQRMObXBjPj4U=;
 b=ULMxA162NscmiIMyv0HfT7tyJP5bHOoaiwrjSjepxjJxDNZMCXhe8GdTAx5mYIjRYMgYjSq6WYOJZdv42kDaA7hleWri+4xw5+DJcYrcrZ7hRSu7/rK2+MHItNB0uifTgPwWOHMQ/wDOmhTnx8zaJm4gWMzLCKQgUPrw1ICe3G4Fhda0h4EfmTx/wk2JgrsNCxJ63D/QLQzkcSh5LmYyyJXk7IcFrmiWUCMIVrNQX+aZjNQbxXQsvi+VvbExufj+Hw5dlZ3R5mUFpwMahcG3seApVnObidaShCHazxHduOksArYMDtfHGFjMXogj3M16gAdVUGkvNDJrC05xcbploQ==
Received: from BYAPR11CA0043.namprd11.prod.outlook.com (2603:10b6:a03:80::20)
 by IA1PR12MB8538.namprd12.prod.outlook.com (2603:10b6:208:455::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 00:08:42 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::9d) by BYAPR11CA0043.outlook.office365.com
 (2603:10b6:a03:80::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Wed,
 18 Dec 2024 00:08:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 00:08:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 17 Dec
 2024 16:08:41 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 17 Dec 2024 16:08:41 -0800
Received: from build-yijuh-20240916T020458116.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Tue, 17 Dec 2024 16:08:41 -0800
From: Ivy Huang <yijuh@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Brad Griffis
	<bgriffis@nvidia.com>
CC: Sumit Gupta <sumitg@nvidia.com>, <stable@vger.kernel.org>, Ivy Huang
	<yijuh@nvidia.com>
Subject: [PATCH v2 2/2] arm64: tegra: disable Tegra234 sce-fabric node
Date: Wed, 18 Dec 2024 00:07:37 +0000
Message-ID: <20241218000737.1789569-3-yijuh@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|IA1PR12MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 1215522b-5e0a-48a7-fccb-08dd1ef82190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NYusabuXpnL+6EhIXJ9XcH5tZwx3txHBlwWrjSPWcktH7B9D44he+8LBsUDb?=
 =?us-ascii?Q?6mobYU/egc2kzGz+yDyur04k54UV56jRwD1djX0i4L/CiA3Fbnr5MC+DNJbc?=
 =?us-ascii?Q?T5uvjeaLidA9ab8OOn9RNo6B6BLcnST1FOkJdRrpLP2n/9+uP04VLewZh6SQ?=
 =?us-ascii?Q?W0T3ttx0asTSqm9U7be1yHVFTuHNC+5IgN5H8q4bUqXtl7uf6+4zOz0Du1+h?=
 =?us-ascii?Q?yLuuLGpMOmlx+xZ0pWqf2T4Kxb7bf7LK8KQ5CGUjZ6kJAQ6Gu2jjZ9rFHzCv?=
 =?us-ascii?Q?wL6WntogZhfame8U1LhtIFhiSGkNnNPmNjD6CJ+Co4mMqrlherh0MQvtC0UU?=
 =?us-ascii?Q?9mwRF99FAKoG7eTKN6er7kyLyMgulTsXGLLCzqxCi5YcQg2u2q4TQXUsxbNn?=
 =?us-ascii?Q?2dTTGE1/ygaCccp3Hqojnoyl9i4CPX1D8odmSBi2HMt7m6v2gnKktxPlEIEI?=
 =?us-ascii?Q?fZIB3knUrOlLUOn98t3R+pI1hn7ulCmxcU5dCjxyvOIWrxtQEsix999bsGKC?=
 =?us-ascii?Q?/S0N4g+vXMuuIawRSIxQhmrnAHMS8l4soW3AiZbI4AchEjohPgrfbZ4fKncD?=
 =?us-ascii?Q?I+MBFQV6ebZBqqIU2T0v9o+LnNPK8v1VQDRT/D3OUE+fCY0naePvoH2xeXre?=
 =?us-ascii?Q?naUucDMm90/yEhrtYXjmCKY72FYXq0+ZALockgPkCFPKGjP5X2y5N9ccSz5v?=
 =?us-ascii?Q?WL85yKg/Q1oJjRQGkMTXJkHZuAZMc0GxyI77u4O6tlBoYct0pSkHLocA2Jyy?=
 =?us-ascii?Q?DZ6p50jjABGqQKF8ysWKLsuzozPQzENErVQoYQkJiMFWR1MdOEqs3sWWrsg/?=
 =?us-ascii?Q?Hnb5Mm1M+h6aaxQbxOKPAzXTXxNJ9I/YxJuvCtLrQwp/SYwjlJxEhYdw8a6+?=
 =?us-ascii?Q?pvL3/3I814j9TvWTGUzbWACnSEgiE07GK685UZip7x4PY69luI0jlg2l7tk2?=
 =?us-ascii?Q?1Z7OaFlXQzNfGH+BwLAuf4Dt/cOUEkhh6S0CHIneIBRHIrHqvUQjm0sVP+DT?=
 =?us-ascii?Q?gIaMcj1unWen78krLkR6ciaqjGHnX3APeLaDeWqqV+SrTFoOg+cUEXS3DI34?=
 =?us-ascii?Q?PiwR+hD8Um92UH43Po9P1neT9pBQDMgIfR71x+nl9yXoJHbTgspFt+m+GGgn?=
 =?us-ascii?Q?I1z9ZqJb3dM3taQvBSOS1AGMyEgKlxAEMBDWE9/484jdBd0tJZpIz+bXIl7q?=
 =?us-ascii?Q?lcF29rw+aWhI2J949mUUmueS9sPWAZY+RS4CuKRn3oNiEI70yiyTQ5FAOVgA?=
 =?us-ascii?Q?ALVnLQur9jo2Y9ws5wfmRNk0AKE+mvyiXecbf7GTt929Vop37F3DfLWE33h6?=
 =?us-ascii?Q?qPbQfANISRbBSIMsYhr9h+wbCSe8XFOBIxoeMC9KG3wFEWKv7XPmJwL8LHIp?=
 =?us-ascii?Q?gMaYiMEJQ3IHZFa9RU/YtB5ZtgSc98T6WO+Nx7ihmZcTzslUtiA1CNKhCfUp?=
 =?us-ascii?Q?CyuwrEZV/R/Y7WXE2xIHl0FkJB+YOH55gwNNYKTNL8Z2Q3WJgyaEnm5Wu6/m?=
 =?us-ascii?Q?KKL47KgNnChl/ig=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 00:08:42.0038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1215522b-5e0a-48a7-fccb-08dd1ef82190
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8538

From: Sumit Gupta <sumitg@nvidia.com>

Access to safety cluster engine (SCE) fabric registers was blocked
by firewall after the introduction of Functional Safety Island in
Tegra234. After that, any access by software to SCE registers is
correctly resulting in the internal bus error. However, when CPUs
try accessing the SCE-fabric registers to print error info,
another firewall error occurs as the fabric registers are also
firewall protected. This results in a second error to be printed.
Disable the SCE fabric node to avoid printing the misleading error.
The first error info will be printed by the interrupt from the
fabric causing the actual access.

Cc: stable@vger.kernel.org
Fixes: 302e154000ec ("arm64: tegra: Add node for CBB 2.0 on Tegra234")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Ivy Huang <yijuh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index d08faf6bb505..05a771ab1ed5 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -3815,7 +3815,7 @@ sce-fabric@b600000 {
 			compatible = "nvidia,tegra234-sce-fabric";
 			reg = <0x0 0xb600000 0x0 0x40000>;
 			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
-			status = "okay";
+			status = "disabled";
 		};
 
 		rce-fabric@be00000 {
-- 
2.25.1


