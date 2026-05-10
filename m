Return-Path: <stable+bounces-245075-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJZJNVb3AGoFPAEAu9opvQ
	(envelope-from <stable+bounces-245075-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 23:23:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F971506737
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 23:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 446673008086
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 21:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8FE33C187;
	Sun, 10 May 2026 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KLjZxg6Q"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348531F9BB;
	Sun, 10 May 2026 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778448209; cv=fail; b=trld8BFZxfv0dFzGKcP8vm/dmDC4jU6Ks7H2XUoJr/dpRxcsjIuKziflHMoqzWNX/jEoqhGTpzNAUk8H8BxHcMZdhYoySrmE/wEOupbU3roRtGcBY+fkvC7bXsgTpxI+ExsKXK4lpZwyzNhUhu8JgXqjNLM2ZCWxemsE2LKxvJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778448209; c=relaxed/simple;
	bh=orTsSzy7vw1B+36FELMmIg17PXvR65e1FWmkR4paKlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Djbx0h5G1mMQoTrjcuN6Tef37SLGF73p7CEqENWWQcbR1BCxOfcTWituEeyqWO241n4Lg0PU6SGuFP3W1NWoe52ErXTGHwq1cBjkUAFZNy+Q/EyIZWnf/uHIXBPDjd9ge+1mM7Qsse1pmIV0uEKU46xxKJa5vjmll1b2BTSw22U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KLjZxg6Q; arc=fail smtp.client-ip=52.101.43.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUPN3tCe7gZCir7K76KqtEUGUyb8qZEURzI9WTe6YAhjFKvW9b12J1uMqNVl1EY5o7DOQRTVX+QDFvXhjmj4jKQ03dLUXhKEjFFMyPM1xcFI4plAvrA1Ey97raQSA62m0lTZi49ewUAAaJkN38dBdJ1XnquCnUTmjzPRVrhYiTEvWuEYDVOchoiQyUan4dOQkhLNO7AWvygxZQXFU0x+8eqzwuiDq1t+wtxuOiX5789HvNmCcnUFruT9b5F6Yi0IM0UAXhiDB9vENxz4w+TtKiqt1tvcPMo/OuXvZfhEkBaGdpyT686WhPqV7zi9sH3vQnih0K8cgVfFfFzg8jO0BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXF7/VnoFyjuP/yln8XBDFi+P1RESZRxh0nlAC/WRtM=;
 b=OeI3DoI2MH/qM9j3UaXC8xNOZ0TqSsz2eogC1O7aieXymMxgjoLEM1vyKtzgQtuPlbOFyHX20tqGg1mSJu27UBvy3MR0I0pWniMBBx1A/FONFGnybY0gAoMcUKV1ueAhGxTvFs+qwrr6n4ERqR4L1fNuDMS7A6MfN3AvpkJjQO5UNULwBaWtQ+e00jcgp9FGlUL9EmpHz/AKcZKCDiso/AdweScRvgVel9WJgGhnJ2A1XfWc3tNw1g7YpFGvhT/0UvPbtSoa9ZrXWH8/SJyRzVoB76XFMJUS568x0axkClDsIzP5hWWRU2Zv3ht5YtV76KiCI7RwuF/lPhQJ14iRYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXF7/VnoFyjuP/yln8XBDFi+P1RESZRxh0nlAC/WRtM=;
 b=KLjZxg6Qtutu6qfmIvJ7Pw40a/5pJjWaNqh3+fhlQ1TAQmVlgg4SXHPR2/7YkIHhx8GynbmRu7RLgjmj5v7331IH+zVmLA3T1be++IuQhOhmLKGc2iAYKd7aC77LT91J+TvX0UMNDnhrex1Z68Pev+JjRnFkM0Irh2cP2wsc0XdLab2e0jHdR/6Ti9hznBl/KF5z13F9uvaPguquaEV937XlQyVJx9c4Xe2CSdFxKxVKoec4KVrF8AfnV8EL/CZBstMRpwFsqJdzPJjX7tGx9DSsxtZnFQWDS9z7jDpV1dz38X25CuEegNJVsYqfvqzHVlfFot4Agzra9gLSAlzBag==
Received: from BL1PR13CA0186.namprd13.prod.outlook.com (2603:10b6:208:2be::11)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 21:23:23 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::1c) by BL1PR13CA0186.outlook.office365.com
 (2603:10b6:208:2be::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.14 via Frontend Transport; Sun, 10
 May 2026 21:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 21:23:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 10 May
 2026 14:23:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 10 May 2026 14:23:14 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 10 May 2026 14:23:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v5 3/6] iommu/arm-smmu-v3: Suppress EVTQ/PRIQ events in kdump kernel
Date: Sun, 10 May 2026 14:23:02 -0700
Message-ID: <6e5828f3288aed6f9e9f4e0ca54e7fbd9f439274.1778416609.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778416609.git.nicolinc@nvidia.com>
References: <cover.1778416609.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb94f07-4085-4892-1e46-08deaeda5da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aaV897NE9K4IWIavoxdOA4drbCDAA/XHcl5OfMhjvtxtbEQSNYDw57l80nK8tjPDVHgg0VIlJwJoXYhlwObY37oU0HmjaEpkJ0D/O234b/+YDwIA+G0QZzmiorF/RUINmzetm+9E4mH7q0NHqbOGJTcl39tsWJ6zBNpCardkbrg2xGZ4wJHTHxwm99wcTQuUZf53FVjYL8Rdz7fYWbakCllAE3kAg/WhHiN/tH3BVfg37uPHB4d/2bPbHedc1c4ftaPQB9SFnrm8BTZnn0/pXZU+GRgr8s1vch/aB9UvvUx0qp6kZ+/TDqaczuB+tE9ZzzElCRMJgfdq7TJcGjD+jTxkQg06aj9f+bKkok3I0UMixX0qnOHc4bnRJuXf9ej1oOwnXE7OwqyR0wJd1LMWRyroJAhx4DrzF1nrS3EIgDaog92a72bQdrDGNYJU9xExNwwa06OLmR7xOFwFFt8NddmQoMXbqJUO8OTlt4zaf4NfTV/hIs92pchYsRfE3/N2DaiO6RToeo1qgfvvJ+QeCkIgsqxQJv6k9XK7lYrUnteKYLaDvteK6LKjq/rXMrei546jq1NHR52aYElR5yViuD47PfSCS9utgYVZhpbtotgDzzkj7fRQIAOCMzbAY3Eq8Ru0v59gUHRlR+yjTPautbQenAw86Ao+1mRuqD/cQpIbRzntfs5GJy92STYj1dn+KfIXSYXIh/COX9kqHK5JQT1tBFBca6KqM/dwpiY5U3o=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2G+Wk/IAvbRi6BATfPdAqvIGcLliC4Ha5LFKbNkUrKVXXI8uu/pHARrnGTP7pXbQd2AyowZ/0l4D/HOj9O99EX3NMgUCBABUPuD5uvczG+thiOMPA0BlcDxHDQt0oC+dbmIP5vknk8WNPmK3yCJhBfsjE+SDpzSmW9lwBeWRfr1hQFNQ3GqqyLRA6pvYXuQ6lJWcgQXs0MDEIG7m2zXurhkDqe5QDJm1CSP7kHLbOYrGevi2FVEQHqn/ahJ1G8HG6PB72ergVR+FMi2kbp6ALzihqSNlCeujhXwCI8wWFViaYRNygsdpWMy1KDIdPLDhekWDqiRgP76E0MRbO2wioFBrP7Te4vjUDFcmCFcDKdujVtE28TNKh4RiCiv+1NRmPFgVxO+SZCppNVCnGSvJ9YqwqCH8n+Xaqrat2QXMQMC/xz/csI/X50BX9vOMvJ8C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 21:23:22.8478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb94f07-4085-4892-1e46-08deaeda5da5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956
X-Rspamd-Queue-Id: 4F971506737
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245075-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

In kdump cases, the crashed kernel's CDs and page tables can be corrupted,
which could trigger event spamming. Also, we cannot serve page requests.

Skip the IRQ setup for EVTQ/PRIQ in arm_smmu_setup_irqs(), and guard the
thread functions against being entered via a combined-IRQ delivery while
the queue is disabled.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 23 +++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 579c8af82d6b6..ebb0826d74541 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2364,6 +2364,14 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 
+	/*
+	 * A combined IRQ might call into this function with the queue disabled.
+	 * E.g. kdump, where stale HW PROD vs SW CONS would drive a bogus drain
+	 * and a CONS write to a disabled queue.
+	 */
+	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_EVTQEN))
+		return IRQ_NONE;
+
 	do {
 		while (!queue_remove_raw(q, evt)) {
 			arm_smmu_decode_event(smmu, evt, &event);
@@ -2432,6 +2440,14 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	struct arm_smmu_ll_queue *llq = &q->llq;
 	u64 evt[PRIQ_ENT_DWORDS];
 
+	/*
+	 * A combined IRQ might call into this function with the queue disabled.
+	 * E.g. kdump, where stale HW PROD vs SW CONS would drive a bogus drain
+	 * and a CONS write to a disabled queue.
+	 */
+	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_PRIQEN))
+		return IRQ_NONE;
+
 	do {
 		while (!queue_remove_raw(q, evt))
 			arm_smmu_handle_ppr(smmu, evt);
@@ -5056,7 +5072,10 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 {
 	int ret, irq;
-	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
+	u32 irqen_flags = IRQ_CTRL_GERROR_IRQEN;
+
+	if (!is_kdump_kernel())
+		irqen_flags |= IRQ_CTRL_EVTQ_IRQEN;
 
 	/* Disable IRQs first */
 	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
@@ -5082,7 +5101,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	} else
 		arm_smmu_setup_unique_irqs(smmu);
 
-	if (smmu->features & ARM_SMMU_FEAT_PRI)
+	if (!is_kdump_kernel() && (smmu->features & ARM_SMMU_FEAT_PRI))
 		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
 
 	/* Enable interrupt generation on the SMMU */
-- 
2.43.0


