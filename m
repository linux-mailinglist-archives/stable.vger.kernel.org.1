Return-Path: <stable+bounces-241145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JeHJHAz7WnxggAAu9opvQ
	(envelope-from <stable+bounces-241145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 23:34:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB07D467DE1
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 23:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 800373037414
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 21:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C41311583;
	Sat, 25 Apr 2026 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NT9KMxzr"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011054.outbound.protection.outlook.com [52.101.52.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CFA313E38;
	Sat, 25 Apr 2026 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777152732; cv=fail; b=sLSWY88DrBKGyDtOgZ28YuiJrgRUnBfEMups20eww5IBkQCzTf6xQFIf0n8/S7NXm5obqdMmYx8DHEAkdGsmcgDOqH2nNEIcqY+9RMt9hOXZnNF4dD9DV9+IiN8pTk1D1rbdE5Z9MizJOu+AvMhH41mpT7vUFZJj4BAyoISy4fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777152732; c=relaxed/simple;
	bh=CTF2y/5ioGQlIRo9R5Z0PMKvIJdTYn59jObyD1pJ/Jw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7HnXFPZk9y/rbSz/2h8mdtfZAgEluApdaANOTU2xJ/URZMs2IMU2jQ9UqHNJNrpFSV9UmLgY5gPaiV/s3B52xwHKfNOuE2XCZnJ0glSURuC0q3VJr9QQALx4nHWkVig5kFk9jbrg/DrDvZokWjsTe01m2grYeGVpfCi2EJOISQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NT9KMxzr; arc=fail smtp.client-ip=52.101.52.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTiH3To38SzrKpOnLqY797aiHbjUFKSqn074d7SvOp6qtbtMfeamkA/GdyAKA8aPr8rpRiKbRg+zzfaexvEn+5bseO41VYs4v3nQPeVKs1WogHjVf/vcadLME1rpL+uj4ZUAnrS/cb7Lw6CT8cv4P+HkuQmI6gJ+LICcPLUctYYaJ5gHU8BGOHx9vl+d2enHy4hUODXHPSSt/q284ICtxKpeIV6LyCNSxdUbwE3NOE2FYQUVfTv3I1A6/WUVqmt/AtPokEhJ3xG2a/n5RRyjBpsgW2Lc3vNpVUISAMdXRmDi8rDjnzQnn7m3HrsWMHs9LXNQ5lZZk5kakhD20bMDGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsmBk7AVMZKoolSAXqNFoqZ6S03NDdHxUBEru/dAKqI=;
 b=s2S+Y6AvKYMwB3NhwSmKiQ+qX/+6/ZhxQQHaiIf8TUnsFgCExhNhgB1qBj+gdC2/6CB2Ep5xBSZYs785pdlVSYOEfV/ZDWKixnTC0f4Q0jrD5DLf8vIRmOHn+zQCopbHdb50no4RnLYmded0oMne52i+Rkd7AtyWffIlCLUb4YrXBtYrL6ebZkcmtr8fVeO2zkcg8xxeojVrQd3WLZQKPk0s1/mlYrR2TFOVby7WBLMbJrnwLR6yDQV+LIR4IK7+U+OF1kOpktsb5MtoSxIlPJ7vL9Gm+9hpWFAELu68Kyj8M5w/kgwg0MkAI5tiAylFHKoni5voxxD6CBrYVUkqIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsmBk7AVMZKoolSAXqNFoqZ6S03NDdHxUBEru/dAKqI=;
 b=NT9KMxzrnAS5zjamxKy1Y+NaQwa4fSQ5DR2KAqSm3nYBu7fv+ADh2b6KxaIdvOOlz5lDqbsRvhsjo9CXV15T0BtqN7N7jqD+hJ3qs5SZx0D10+fosFFuD/aA4/izy93AJo1OE9k1Nb4tKOGXEmDEKlzccSZQt1NCsK+0yOwGbl/0uObZJ9xyh1G63WiRjyDD2sy/Ya6SqT66ypwAIQNvyr//C73zwaIq04hwyaNjNXBYQXDrwLlkgZIaj0woQfJUTuGcM+lbFxRhmspc6p9h/CpenxRfa19X6yhG9/vVTZMGmrOPip6NMPXsLyfytlAjEKkmaxGdmAySKDbzntRSkQ==
Received: from MW4PR03CA0177.namprd03.prod.outlook.com (2603:10b6:303:8d::32)
 by CH1PPF9C964DBFE.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 21:32:03 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:303:8d:cafe::82) by MW4PR03CA0177.outlook.office365.com
 (2603:10b6:303:8d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Sat,
 25 Apr 2026 21:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Sat, 25 Apr 2026 21:32:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 14:31:53 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Apr
 2026 14:31:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 25 Apr 2026 14:31:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v3 5/5] iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()
Date: Sat, 25 Apr 2026 14:30:50 -0700
Message-ID: <aed9a303844d1635fff48100baf210d9251c2004.1777150307.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|CH1PPF9C964DBFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 0beffdb9-9d7b-47fe-60dc-08dea312178f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Srw+Rd8+S+0HMIP21HROsXHsgP+Is31Izk6fDsRPfDAqo6f6MCRzeCBWv2WAbgo0QBOXGsTkU5smo3JPpMJ7pX0IMVK1Ryw/2eeHBD+h36lTGSG//EuZ+r6iYDBDOZnOuFm8QTw60yvoEMRatvOIkZkjHrfH23k6vAqlRuswPHWjGu8sIgt+yW61ln6ZE0CUvLNpnavkzImEckEignqvzQn7CAkTMGGG4L6IZaBXM8bQ0LR6mxIN2BkqMK0sYFNY3Uk9/M6L7JJp9UZupH2iJlUvT88Y96lwQP77owu2L37oflPOJlj1zvphJGHRHip9Ufzoi+t1DMO6yVm7FobHiu6ZhL3ZYKcXZPl3xxQ5dFXkBCFYmDenXqSeL3E5hBlYHlFoM2oQqaPGxbRf1+fTgyVE/DTFv56fxJcBMcsPyw56lLrM839AN7QTgTjfJK0SBsJX+342BhyNWXOF8XNjMmE2eUySW8Y26LlTHlxYESodL6wdO8z8ekTGSxr3XlqlseB00WehiJCS9Jr4qH9v54lR+42A7QLYQ0xhTDN/CiajYbpogt/fdjBRUN54V9okLWYMY/WaxFM8v9Go+c8BS5o5O7oQ3sHn9QaEdYtdwXnJKXGttV1vCq5C1Y67klCBDp2/raejl4Q3/eXG0r1bH2tFxunk4sCiY9H+2f9mWdwEUqjnj0hdaDDoyX7zJCsPf5Gf3Mu9o4fBaT3brF0gJw4huauYMBMDdwFX7NYiYzhcwMG94uvdPNgYr2QB7U3KgNZjkizwAmZjoUtKLM9pDg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QNr2Nd2BOmItgkCl/XEownLG+Iw7uXaZpj5KBUTJ9DbmYltzks+GgR2BoEePqYriXy/E6qLtapIcFHo3Myr7RYB4BqbNVY0tEjlH+9q7tbda6RV1ahKTQnF5sY4zbb6OoRYyFtyc4eUplD7Y0Bnsujq1NkHfeaobDV48ueGsh4oW3g0f+xtz7ckFFBtrUMmGxlhATstBpmi3zrH6c+2M+a7Pt876LYyhSHu6WiDtS08yd04LkNxs11/MzeIBI3HLw4iSN+YJwQOoXuXwKdND3GxQP3WSHBKjWicwkWHEI587j6eE7iAhPeqyminZ3eO/qV0x4UzrXPQjre1qRx3kCdIARi2BT1XIAAneL2XyCajSWQ/+R4ST77/aSenOB5MzhC0MMZj8LNQf1t5m2pu4vfYiBUMdTcyGPzffj/oRracPldpA32BQg+hfMIezdm8/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:32:03.2382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0beffdb9-9d7b-47fe-60dc-08dea312178f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF9C964DBFE
X-Rspamd-Queue-Id: EB07D467DE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241145-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
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
index f0ab0b640a3bb..35aceb22d5c89 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5288,6 +5288,36 @@ static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
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
@@ -5502,6 +5532,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
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


