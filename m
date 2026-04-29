Return-Path: <stable+bounces-241831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOhbFp+y8WmwjgEAu9opvQ
	(envelope-from <stable+bounces-241831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:26:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AC44906F1
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FAA93096D3D
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218DC3A7589;
	Wed, 29 Apr 2026 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rrDvVQIq"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7553A6403;
	Wed, 29 Apr 2026 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447337; cv=fail; b=QPCojNsWLeJNfPPYrbj35NPTwY6q9X+8PQHYqn/AX2lZMWdy586/dt/JqAFuO/ZTx8jB18+fPP/j/C8OPDtzF3OVxh2e7NvpqJQ5FpX0+NgrkBkS6eGhBOibT+EYOdunpYr3YOD/m7rE3M7JJNzN0+dIDJaQC/tJcwpdVzo2/+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447337; c=relaxed/simple;
	bh=iBfWYZCWwAz1vHCp5vseAafhqIhGTiaPi7Lzj9YdQCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eu4aGz3Zw0vx4CC9rsHllT2I+FO95IgT7kOGyiEZKXNfggJfZiujjNSSqgQiQLkWj8ic+GY9kIz5yjW36CKfoxA0bBsyMMwq5anlkp5HHqVeH1YEme1d7ZaWZY88FYCv2z90wtDqHYLXpZNE29zkNn6TFxM2M8N0zQZQ96S2b+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rrDvVQIq; arc=fail smtp.client-ip=52.101.48.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWg0OQgzX347cTF7FvIPKZiFgpSgYl6s3ZUT2Pn4WvYmEWLqFsRlctfLOCIUo5i9k7ONEfQtvOaPFpz1WLx74Q8P+ljvyAzIOw5YHJFoIQR5E7S4mipJQcngwOCwZiach65wXuKun7aa/V2JsRemQ4q/W8c5McPIJgTRrAT6Mz9pHi5OmfqdRTF9fDSiCvYM95Dp2k3QTmWRvDI/pVxZJlXPdfBTD0Nz27jnITQH11WkUjH3oWEORZhjJdtFJG1Zr1MkXVbMZ308p97JN8Qx/RPTjaL7g+I59tR49/KF76rs8h1ACq/qVVYM8n6Xn6MPtsarwbKwM3luM8vDeCScGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/YgeRMPs1947BIjmWAPT2oWeN++jyT+HkpDryUX+TY=;
 b=SBhoz1swXPG0vnrcgT4Gn6xC5smmkBu0MG8mVjhtbtAD/OEyWsBK+qajxHtUB/MepgHsJ7u+CO7lr0VfMfPLj/D1kJYjFmUupBoYRqLgxCY6VoCWrY3VPzKNuDY5kpgbZMGSaTvTKkiti/5uByuZTqVlw8hBAL4BaoMuv5EsOUYTF/ihdWsoB2aCxP36w1IWRrCqt3pgiI0oi4reMxNZ8uQP8W3MH6UB/a9tmtfRD/2p5K2nxes4LpVPnVTI9TaADDqIixqL6KPFEnLyKs7MCFLYNPEmqHJ+U7rxScN1QmAXgZBG4wunf+Jjc4qftRO/g9BvJowVsY2DkvdINCn5jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/YgeRMPs1947BIjmWAPT2oWeN++jyT+HkpDryUX+TY=;
 b=rrDvVQIqiFQG0l7cIHmuqFzUFUuJgRZWal6BwzloqXzkKYgoAM3M+J9I9s0ToHrcMjmU/Loq9NLIuWfxe7Vxv0kEMZc4k07G1ebiAbUjHYw3m9qFmRHJuOOsYfIkIn2rNH6REkP4wIcKOXfr/iFSVxG78BAD3bzZY2q/pxjaC7LAcs1KwUZwtA6Y6sCmSNyr1rwl6dC2U1PLsEBgxZZJiFOhlccoejRraEmB2ZVkNUn89QvdcZC+gM0WNfKQO4pknRYtDt9U8UAiEHvNPIE30CbbdLZfcho4MXZzzaL4mbxDzTYUF+7n33viqp6JbvvKly3X7XOSEf4Zkl6EUXUGYw==
Received: from DS7PR03CA0270.namprd03.prod.outlook.com (2603:10b6:5:3b3::35)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 07:22:07 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::21) by DS7PR03CA0270.outlook.office365.com
 (2603:10b6:5:3b3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 07:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 07:22:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 00:21:54 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 29 Apr 2026 00:21:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Apr 2026 00:21:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v4 5/5] iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()
Date: Wed, 29 Apr 2026 00:20:53 -0700
Message-ID: <bb1aa2d0d1fabadb76dfef9ea9cf44f4a96c65be.1777446969.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777446969.git.nicolinc@nvidia.com>
References: <cover.1777446969.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 28bcec21-9d7e-4d03-17d3-08dea5c00569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	F++yRXvsKp9LTDNFFI7TJAi2z9c8eblampBZV47bcnj9j8cY1AclUMWfXtovW46lkzOEtoUhQj2+2qxtnIGRhXQiXXzgb9xIyRsU+Pe6xuV70SRftdldKPAq0YrCz4jR6VHvH+Bg7lqnG3j65781VsTg5GtlRkA0uC4fioCMr9C9cAkPbEL0jvaqe9Izln9pFehaArSI2DoeAqwFli+H74XmwXAoQJ1mXgvO/Gug8v+DArt2sVSM0VmGE91LWmSMCijVglYkwwjkJitAdMCzTDXjynfdARy1hFo+QZaklMkZVFV2cumg6G2KvxPMe9tfWIJygh5S7f+s46rhyY+mIbC3638Yv5vfB6eky6p73+RFtdjbUwPrdx4AtYskOT1CplstQy5oOlo3q7y6oSleYSKit9thJOhepF6uvC5USU76RXSrGWAOs66ksEwXj1F00mW43HfRbTZCWhroNYrUDjxMgD0mrTJRpZM+D5ZMfYsykoimB/A24uUDrxZMzE7QDnsAOODI2PNb2ZDg185X9M3vNLmVnlnbgLHm4As8gGvGL19EIGx63sK55WBpweIpY2pNc7LzjWhXkDnJ1kaeE9wDuZUvEVnTjS4qu/aBnEHWrRXILIosEF8ah+v14SwXsqkcunTgNDN0yKDvC/jYQ708QVpM9Ns1l7wRNDfmgXySbV2mPzXIzeue9xfn/CkJXA5urQcr+C50mLfEQzv7QbDQFXsGQ9tpYjEvmo2DlA6Ry1X744oqW8m/sHesgYzoYzHsMu3hPpV3ipBn0v8VjQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PzHFUxtfp3HUzEU8brc3Dha8o2AdEllYYEyWSN4S6N0/UczVl59Ph02AMZi0D/fsR9Apm3Ff0NIaRWbmF7OHC99wjT3+xgV8EEKr43btODlVizC1kVTiY3FQTzh4aF5+MFme63g1RV55I1Vh4ZZquKBgTpt9DLujgj9SK9lFeE/k844S2G6IDkhhb0/bR1amolfydCPPljYzeSKOkn7tOdjWFbvPY6xUY5g0rg8evF/YzZrdif0AVLHrK7LOrLwzeU6Xm7939oRBKzfNmkHoIyoksw7NWeyEZWnEQpMuvnr1GcEV6HHoVxEa75cncENCGwjcO1V7Qs19+NQpfDsS774lfmt4x1m2C2Vn9lC9YlllkP70aEWFNX2SrwCPQ/cY/x4OYKh6RWZd81KdL0dkKUr7bhPFDPqbM0ZHdHxYEPshOpkHUCWrEZnuL+GNYFyT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:22:07.4746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bcec21-9d7e-4d03-17d3-08dea5c00569
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
X-Rspamd-Queue-Id: C7AC44906F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241831-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]

arm_smmu_device_hw_probe() runs before arm_smmu_init_structures(), so it's
natural to decide whether the kdump kernel must adopt the crashed kernel's
stream table.

Given that memremap is used to adopt the old stream table, set this option
only on a coherent SMMU.

And make sure SMMU isn't in Service Failure Mode.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 34 +++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f9332cf0b28a6..18e0d97cec401 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5402,6 +5402,36 @@ static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
 			  hw_features, fw_features);
 }
 
+static void arm_smmu_device_hw_probe_kdump(struct arm_smmu_device *smmu)
+{
+	u32 gerror, gerrorn, active;
+
+	/*
+	 * If SMMU is already active in kdump case, there could be in-flight DMA
+	 * from devices initiated by the crashed kernel.
+	 */
+	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_SMMUEN))
+		return;
+
+	/* For now, only support a coherent SMMU that works with MEMREMAP_WB */
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY)) {
+		dev_warn(smmu->dev,
+			 "kdump: non-coherent SMMU can't adopt stream table\n");
+		return;
+	}
+
+	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+	active = gerror ^ gerrorn;
+	if (active & GERROR_SFM_ERR) {
+		dev_warn(smmu->dev,
+			 "kdump: SMMU in Service Failure Mode, must reset\n");
+		return;
+	}
+
+	smmu->options |= ARM_SMMU_OPT_KDUMP_ADOPT;
+}
+
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
 	u32 reg;
@@ -5616,6 +5646,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	dev_info(smmu->dev, "oas %lu-bit (features 0x%08x)\n",
 		 smmu->oas, smmu->features);
+
+	if (is_kdump_kernel())
+		arm_smmu_device_hw_probe_kdump(smmu);
+
 	return 0;
 }
 
-- 
2.43.0


