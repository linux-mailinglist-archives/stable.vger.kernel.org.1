Return-Path: <stable+bounces-241826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENyFC6yx8WmwjgEAu9opvQ
	(envelope-from <stable+bounces-241826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:22:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 222C549061A
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1727E300FCDC
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADF13A542E;
	Wed, 29 Apr 2026 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EJCNe+OV"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26F33A4F33;
	Wed, 29 Apr 2026 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447330; cv=fail; b=ekDje9+5oj3WH8x7ejyqLlLA3WUbGaL8x8gRgXX63+z87p8/DAbsd5jqOrUEJkT8jPU72Vn54P2R+PMKmKm3VrhktOcBoW3qT79RspoStleBADIs+wtGWnIcP36gDVIxJKBH/CgGMH++DJ9IaIMZtXn4amZ/KLMuBevbnDP22Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447330; c=relaxed/simple;
	bh=odaaHMre8bRq2gMrPLCjJb3SiKpkIKNumWlzxeepjkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hx9tfVbda7obmIRYXnKiWxMbYFmarsULkUKk7bEoYc3ycqPD+eCE7qYbTyktLgxAGJ8yFQPCY5Yj7f0GqBz7/ASETj9r2LjCTwGdr4fsVARl7SP2ew7ZZUZp4K8d2EMQ/umrTSE5BX21iF/c1wFzIZD4KkrngoOZ1Nu3uWxONaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EJCNe+OV; arc=fail smtp.client-ip=52.101.85.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgWO18Mlje6ucbTgVTmEgUBSUyWjDOxyZgynYUvpYMLcL6X2xoW++3KknOgqrYnlH8Ow28NrfMmOfYuDCE0dKr/vY8kM5ZWxbelHfRsefukJLQReqs4L0TEruG+ebGuePuwj2fPMaFLPjamL8bPypMB6LzUcDUIXNKr43shWp9Vi46D3Ep4FmcSUODp1Kx8ClgMux/sC89nTpOqPEKw0lnKAO3DPy0CZPf5evTga5mkV2/hLKKw3nUtfBkfnq0hNvIK21OmC61XskzoOuDwHSxbAzz8pcIb5a19jOgzDSPJx4HR9HyW29HvfbYXsFgw84qT85bx7+RCMj4xygC2Dmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Fnfjx1z1Zz3cE6gs6SGNHRFy6N3IvamefkyfWB1TZw=;
 b=jl8bWcMZjQps2I5saPdmP0IrXkG/d0d5zTTglAwtCCCULtGM8371ZCyLnysNrWir/NSj6sr+ui/Ym5ccq3LDfNCPmWKVUuIv7fNs2LAY/Dv5J5bddiC2f9oFGSi4k6FMij5vFxXzSDhtOUg1lzZPOjN1Cv9XX4mCFpS3+CfJ000qi7hP8J0CRfTP+6lvt1m+r3eATGV2aAMQUKXa/ISnoqybBsSKOTckeRMWzw4e9C15ZJZQG14YzBcJ6B/+awMDRSb9D8hIuGfDyPvlTW+9gOInJDsvtCKz5UILBbGqp5kFE+i5S98ROUZHSivtC/oSNBIBn9GnwbkYCLxltIg2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Fnfjx1z1Zz3cE6gs6SGNHRFy6N3IvamefkyfWB1TZw=;
 b=EJCNe+OVC3BfwtcO8y47jCi6LrYBnbjpSXUcnPT3KHyUXWWYNPWWJ3AzglI1oq9u4nlZDMIsurSyc6fcvReDUCZKPJ0mhgU1r2+IKV8UxePIoJlT3gXUcsfj8KJHbF5rw+qfOvzkTNj8Ij8qyriXz9F+WyVGwKzmpfouuGrGHGfbtxXamfBCrbWY3Ul3+1SgXnguTvPGdowucCvj8LlSBQ3TAGSOzhjwbKfUfkyMgy+LdB08mAHiZPvrlAGwzmoeYf4fJ2w6kehApf/gGg2qLDpw2QHwaYgO9KLWzJTZlK1ZX3GOhe9g/O99W7eRxBt1uAiDsHo/tyR1XJF//ZFdZg==
Received: from DS7PR05CA0005.namprd05.prod.outlook.com (2603:10b6:5:3b9::10)
 by BL1PR12MB5899.namprd12.prod.outlook.com (2603:10b6:208:397::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 07:22:00 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::14) by DS7PR05CA0005.outlook.office365.com
 (2603:10b6:5:3b9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 07:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 07:21:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 00:21:52 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 29 Apr 2026 00:21:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Apr 2026 00:21:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v4 3/5] iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
Date: Wed, 29 Apr 2026 00:20:51 -0700
Message-ID: <25398d02373e7592d0555e7da9dbf33b3e83983a.1777446969.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|BL1PR12MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b137e43-220f-4832-47a2-08dea5c000c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	l+Wv/9YaebU3PpVhJzz3STgbrTQ3rrvmpuLPhDIHr4534F8Y4Z8I2eiWimLqVcQbZdxTY5vw/vDqQPRtEwL2lvPQ24QNpNtx8WA3NxSi3go56nP0mtKJhScofxwGkifvYtajcrs6DDNMeCim4+EyujijwGvHTRqHFBNYAGevWP9CxcVsgj79Vo9cP4BZC5Muco3fadvpcQjbjHceKbZuSfcicvVhZ0782dA+fJNy4Ar6bLDJAgFcl3+rNPv+N90FZQj4sQMFeXjQjULkrnRsk0Tdkv+DXxCmzTcD8sv/HRLulDRzTbd0fKwHr9JBek14uy/rseTajnXTZnsI+NW0OQBY2w6M1U8pSx9OSnTqWvWHNjjXNHiD2Lw+N6Xb1iemsuKvl3SxrytR61U14vBlv4Y1sFMFlqXKNE89WTXk+NBuK4WxMGYMxns/dgGAT3mg5Aj1MxE0+2AEUhKVhuw+QFgsk3Hjp6SjqRozp7KV/Mi3cZ94XgFhg5F8SZcJdtPl4xK4ivAxc+84WfLefFBsA8h1mcOJd5fPvwlpvEROTu3AuSaYBhWPAG1cpqSV3DnpAS2icNZKMEwsnW5KTT8tD/47pIWXtzL2gfJCh926B7iygI0oxGMVBUKEJoBovs9QxZ3Wlh/sgF+5eONUD2dpRpN/0uRjRU5g3qqrTHFzbpE5UtRsBJzqbpg02ZXvW2P8uH4CI7AFs13Sr3Xkt5Amu4SMN3Zh1+bhQPQtYpHc7c2RILBOwPAGaO1dG+q9SgvnxqnPE2+a6ApxUJcQuYanEw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W1Hq7hNScsHU+KM2kHsYvn+R++2qEpvik9WNmvzPdcbiVlPo2Pngt8BizGtY82krbsWOHUR6wUX9qEDWFGMaqdz9Cl+x0ye3IMmY7fNDawI34ET2gPdpILU+UtsG5zQYL1N3leg11fs8iHWykgr9JxAG4W8uXgLPIotT1f2M9e1JSu7hXkEx4xstlf3kwIrWjSVL36igZK3ZklPcTTv/5H7l9Da3nchh//SQBUY4yF4VmaGFR4ExydWO3Hu63KSkotqjry6CKGMDakTt11otMmP4EF+88HNfuFSHT9aM8rvOu+G2hQHst0gHvBBg50IGYmte2TVvV55jl9SJLytyWGQ6+4S2MWQXfEgyUNumPNi6qwOudR7KeOI9t1mQHAJfZf8ZjsZTLYDjimzUJYrqaYQnQX0RApDCC7qX/l3UebTtmChbVhwpNXyKRHU0VKnY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:21:59.7109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b137e43-220f-4832-47a2-08dea5c000c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5899
X-Rspamd-Queue-Id: 222C549061A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241826-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]

In kdump cases, the crashed kernel's CDs and page tables can be corrupted,
which could trigger event spamming. Also, we cannot serve page requests.

Skip the EVTQ/PRIQ setup entirely rather than enabling then disabling them.

Skip the IRQ setup and guard their thread functions as well.

Also add some inline comments explaining that.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 66 +++++++++++++++------
 1 file changed, 48 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 27b84688bcc99..17d5e1395e245 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2363,6 +2363,14 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
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
@@ -2431,6 +2439,14 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
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
@@ -5055,7 +5071,10 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
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
@@ -5081,7 +5100,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	} else
 		arm_smmu_setup_unique_irqs(smmu);
 
-	if (smmu->features & ARM_SMMU_FEAT_PRI)
+	if (!is_kdump_kernel() && (smmu->features & ARM_SMMU_FEAT_PRI))
 		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
 
 	/* Enable interrupt generation on the SMMU */
@@ -5191,21 +5210,35 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	cmd.opcode = CMDQ_OP_TLBI_NSNH_ALL;
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 
-	/* Event queue */
-	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
-	writel_relaxed(smmu->evtq.q.llq.prod, smmu->page1 + ARM_SMMU_EVTQ_PROD);
-	writel_relaxed(smmu->evtq.q.llq.cons, smmu->page1 + ARM_SMMU_EVTQ_CONS);
-
-	enables |= CR0_EVTQEN;
-	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
-				      ARM_SMMU_CR0ACK);
-	if (ret) {
-		dev_err(smmu->dev, "failed to enable event queue\n");
-		return ret;
+	/*
+	 * Event queue
+	 *
+	 * Do not enable in a kdump case, as the crashed kernel's CDs and page
+	 * tables might be corrupted, triggering event spamming.
+	 */
+	if (!is_kdump_kernel()) {
+		writeq_relaxed(smmu->evtq.q.q_base,
+			       smmu->base + ARM_SMMU_EVTQ_BASE);
+		writel_relaxed(smmu->evtq.q.llq.prod,
+			       smmu->page1 + ARM_SMMU_EVTQ_PROD);
+		writel_relaxed(smmu->evtq.q.llq.cons,
+			       smmu->page1 + ARM_SMMU_EVTQ_CONS);
+
+		enables |= CR0_EVTQEN;
+		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
+					      ARM_SMMU_CR0ACK);
+		if (ret) {
+			dev_err(smmu->dev, "failed to enable event queue\n");
+			return ret;
+		}
 	}
 
-	/* PRI queue */
-	if (smmu->features & ARM_SMMU_FEAT_PRI) {
+	/*
+	 * PRI queue
+	 *
+	 * Do not enable in a kdump case, as we cannot serve page requests.
+	 */
+	if (!is_kdump_kernel() && (smmu->features & ARM_SMMU_FEAT_PRI)) {
 		writeq_relaxed(smmu->priq.q.q_base,
 			       smmu->base + ARM_SMMU_PRIQ_BASE);
 		writel_relaxed(smmu->priq.q.llq.prod,
@@ -5238,9 +5271,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
-	if (is_kdump_kernel())
-		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
-
 	/* Enable the SMMU interface */
 	enables |= CR0_SMMUEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
-- 
2.43.0


