Return-Path: <stable+bounces-241144-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gjOhJE8z7WnxggAAu9opvQ
	(envelope-from <stable+bounces-241144-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 23:34:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0C5467DD2
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 23:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A6F8302F58E
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 21:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C2B31815D;
	Sat, 25 Apr 2026 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="il9K1w10"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6A3314A9E;
	Sat, 25 Apr 2026 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777152725; cv=fail; b=Lqff2mjoXx7jC9F5Ptx0FQqaL5BlZWK3kMEOg8cxjFjjWwTOTK8Q1a+fUHpHBAjO83cnlX3jyQ42ya6nvb/b7QUQ4SVa7T2K3czPFH4jwN4+hW67GQm+kUauw8ltMPR6mVX96mETO4A7O+eKsbtEmWZU8wZ4GL4vRvkBcMCEwLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777152725; c=relaxed/simple;
	bh=rTZrKwF5oXs1CXRI/eMXonHW8Cx/fVqFnkE/Cs5vgsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHGldwchnV+fLCRq7fXxgRBq0HGeF+XklWSf1eqL854M5OqBluwfppoluHvPz/nJqpFWmttIbNbJ+2pRCxubZ2z4B4zHwfO9ECLFF+Lx6oSa3S9r6L/r2kS3wi9VHpzLudd7CAICL2HiciRsBECVReYRKR8hpzrqP5BNecef7mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=il9K1w10; arc=fail smtp.client-ip=52.101.193.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5vPuRGUfrvEQjZZQSEpfJeOgVyK2AS05bnWMwO16dNOB6OCe+IZLv2KFcHOiNin1tK7WIaRKqNpQsH0ZZihinc/MyhyYME5/Z3aCtsB00zkesjDZzjjY9MmdijGuL6Hqm+t/S7NKxWPJj5NOl1XBsJqR4wyF12X+BCqRxghReY5Kp+6nI2Q24Gs9Qb58rviuUbld/wRlOxOyKLt/XHs95h18rpyODdT1ONOLyA2oPyP45UN5lLKngwC7Vz/V7lb4SvTeDbcmCdkM1PtvI50dHHNV/86LOVj2UCE6gCQgVbPB349qXobBTGdC2YWr9GVfNqfO9NWJmVElE4DIVaqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j536gDwbdTDnML8mY1afSJtVbeWrSZaRZohu4yn4QcI=;
 b=Guu0nZmHsvodK3iBZYVdP8diG4rYbIUkQxMyyJ1AHOIfvR7JdQXUD8NprQuRPlkNnzi7Ym0SPL1LyQ086x4pjG7jtLp5knbu8FkG65sOvWiG6L9M21L8OIc+GmFAwzfJZtQcqMaCNjac/sNoTTGRO3En3ZWz556K+I2QrVp/oJtIlpkjyaNz/tbHzw4NmhhxjPSa6KsyTPD1JxHm1Q6BmKLB+9nua47YHI2i4OeoDKEszO5KNxdq+IqbodTa/TirV9ns1BTL3pT5z+Y7H+DTcLSka6UEGJvDRsfrBHzBNgUeYoB5znQZragOSXt45PaqyWVn9eP0oaBAdmoWoUzvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j536gDwbdTDnML8mY1afSJtVbeWrSZaRZohu4yn4QcI=;
 b=il9K1w10h//NaMMjnP+NdxSs3+owqtHKJupFBIzGC6/ZnSOVMr2beaM8NFM/l17Gb/pf6YfQsXko8eZixPGP4cJ8UeYUxoD77i7BAzsVvBDa9w5EswfamA//KZNVcS+Hr+td0WVXzwoT4kpnbdyz+2SajAF6uD8ndzqhZz1jxrH0jLpyQtzPqC1w5mHIdPy30XrErlfm2sp85NCRmlRqc9YvpUleFEsviNUM817/sYdJILwiJQai6oxiHO4Z7nBmqPtWJuZIU+GHKCtN0Mthtlq+vWWui/KWQGOAOCqR3U2YvPKQueNTN2nANpXTMaJYoPw0s2fTnM08I/fZW3KdSg==
Received: from PH0PR07CA0029.namprd07.prod.outlook.com (2603:10b6:510:5::34)
 by SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Sat, 25 Apr
 2026 21:31:57 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:510:5:cafe::72) by PH0PR07CA0029.outlook.office365.com
 (2603:10b6:510:5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Sat,
 25 Apr 2026 21:31:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW1PEPF0001615D.mail.protection.outlook.com (10.167.249.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Sat, 25 Apr 2026 21:31:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 14:31:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 14:31:47 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 25 Apr 2026 14:31:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v3 4/5] iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
Date: Sat, 25 Apr 2026 14:30:49 -0700
Message-ID: <37c1575e3013fd4e86bb57ab0653a4c7b0a61b0a.1777150307.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777150307.git.nicolinc@nvidia.com>
References: <cover.1777150307.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|SA1PR12MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: e6feaea7-4c64-4adb-1055-08dea31213f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AKm1MPH/LG6L6iEI/uD2zfPrnHDoagMkenI+8ZK2qEGNjzCYpStHvR9dZfa8SnYBM7xBH98CHZhbWI+drKR6kIifCxT7jzQ89LFzfX3sJz4JvyOOiA9WPijWuFfiUaMTkUJ/SRGTUa2UOBWzpMJPIhi1D0fIwQbC2vA9IZDDEI4INOGWkr+E9oW2GBEk0VHPLjbTmRKKm+GNmQm5x9wLYzYaLdjAQ7vwOA6Y2VxZcmdLFlDNmvqlVyGw++E1UDjot1FbwXgNThmYX3zD0xHZm1thpYlYMQX1HBQC1hzr7WT+IE3BxfQpfWzrvYiZncdso3+eeXyE7XGZ5h2mm6KEfPMmSp7VPCgYHJ50Y+217yCJBjAApTQ3MTATngcF/YRnncYSCaWQEvKYcNE0F+23zKf0rk+L9z1jhDSJPJ1s4++q7clmlzHK8xGnidPU6ZI4J85KYQ3q/SD2GH/GyEjuBdNuyldFuXVCXfEDCwzrnRo9DjEtpQIG4agx69u9MUGvqF9PUcEHOZvDiy+rEzRIMaW+P3k8FBShrZOXby6Tn5isT01M2FbDds3xVlw+8/pdHAl0pqnMdr5mSYh21xGfxu+0AruvHlVzf7oV/eAJcgGWfdvANYEAvBnaG9WWIm/cplskZL14D6RfBqTdOGEML54SpUhFubqdX9/M0FK/U2AmLtzcf4uq8yVdK8f0+uWXC3G/zBNP+xO7Oqy9KTREd00gD0qGO2TA/8UO6++f1lo9dZCBXuVFx3uGDjIgBlteWKFVdDfefVtVsp5aF8PN5A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9bEgtq+bnp+0fHUgsXUxRDX76rXWnTZYpcDzxjIasN30R6KWvroMt8YgyBVoY3upW3nPnIn3WB2e1nOztmYw36aJyk31gURk7XptB167NbuhGwfiCu/fU5L5BDqQWR1L3g29nVPCSzRrUEJUgmpvCH61gBztW56S4adxKgU74PB7BvJtGN9RLAnQYrhO162SyQ2nDAqca1B8vd8Q0cI7T5VfLDkKDGhV6itA9dG7YGgoLLqSDe9tTgWnzKdoDeFyucwOIjGZDbSNYnF8wRHqK8pxHMFW58/uS9guCxLlf+DZvIHDGJ7p04qYxMswnJby1Zj2uv42NdqxPuiiXXS8xn7ZJQYIAoKM8o4OBmUeMoQZHjxHDWudju9a8CAIq9jMl6CPyFaSZ9WZxBMgaj6mY1ErzphPceXM0yxrWQ7a8vKlB/4yf2Q4VlGhH/eohA60
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:31:57.1726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6feaea7-4c64-4adb-1055-08dea31213f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872
X-Rspamd-Queue-Id: 0C0C5467DD2
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
	TAGGED_FROM(0.00)[bounces-241144-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,intel.com:email];
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
index b6aade469a6b6..f0ab0b640a3bb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2269,6 +2269,14 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 
+	/*
+	 * A combined IRQ might call into this function with the queue disabled.
+	 * E.g. kdump, where stale HW PROD vs SW CONS would drive a bogus drain
+	 * and a CONS write to a disabled queue.
+	 */
+	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_EVTQEN))
+		return IRQ_HANDLED;
+
 	do {
 		while (!queue_remove_raw(q, evt)) {
 			arm_smmu_decode_event(smmu, evt, &event);
@@ -2337,6 +2345,14 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	struct arm_smmu_ll_queue *llq = &q->llq;
 	u64 evt[PRIQ_ENT_DWORDS];
 
+	/*
+	 * A combined IRQ might call into this function with the queue disabled.
+	 * E.g. kdump, where stale HW PROD vs SW CONS would drive a bogus drain
+	 * and a CONS write to a disabled queue.
+	 */
+	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_PRIQEN))
+		return IRQ_HANDLED;
+
 	do {
 		while (!queue_remove_raw(q, evt))
 			arm_smmu_handle_ppr(smmu, evt);
@@ -4941,7 +4957,10 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
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
@@ -4967,7 +4986,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	} else
 		arm_smmu_setup_unique_irqs(smmu);
 
-	if (smmu->features & ARM_SMMU_FEAT_PRI)
+	if (!is_kdump_kernel() && (smmu->features & ARM_SMMU_FEAT_PRI))
 		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
 
 	/* Enable interrupt generation on the SMMU */
@@ -5118,21 +5137,35 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
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
@@ -5165,9 +5198,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
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


