Return-Path: <stable+bounces-238216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id B/FgMKcA4GlKbgAAu9opvQ
	(envelope-from <stable+bounces-238216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 23:18:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E36384081F3
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 23:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B7DA3025E28
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CA838E13D;
	Wed, 15 Apr 2026 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bYtMt0E5"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CD93161AB;
	Wed, 15 Apr 2026 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776287900; cv=fail; b=dpJka/5KLTA8XxZOQIbj+eVGk3Pr2vU0MkThS8KOUALsByZUAYPDg+m3X0zHgH1Lp1krGqgbgFuxPk5lxpFLHaPkP6Kf4KUwCKDGhOHw40YDpCFoKB9SYot0IifJAwZFRlCe7mJz4zjeMDh57I2vomLaTnlDBiPO5MQGwsO6jic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776287900; c=relaxed/simple;
	bh=TPRbVPa1R7/RoURujd/ImV50H4ue8GA6fTG6EXLSigw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=goBLQPmZK4qWOTdB0I0f/v0S2vl1eAg+SCagTsR9ptMAhNkDbRgkgRUwc6K8IYDgGVxHEN3DySzpljcoJ9/X0gR91yXtHLtynt0Wn+UFOE4bL7q+VnxE8e7RFHQjM1X4ERmoOCwlyeDDZlBXtO80FuF8Dcp+/rluZx7d3+09SMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bYtMt0E5; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNaOagFVjHGMVQCT7CHMX9F/v2O1HIBoqm1Q6qaSUcz8PTEG+qQTAMNyCxGptUgMLaTj6aGup7jF8jNTX814CqqAGdATcTYUKYzf/Yt+ouvaCRD6goswIna0HOQrLoWPrMfYWuv7RIDUpAq3uOOeBAo7J5nmz8/cosOUqjqno0zQE5DIapiZhi1KsGjSILU4OjUzkq61KsSVGgYavAXOsFwF9sgNqvs3C08wZssMM0IqBKzUaww8uv1gkeE6wkbC0eHHH1vpHb0DIA2QVRz+TNI/W/P7xEDMF7wA5Sx/b4Z/wQ3p2tfGwiMCO+bTQzEdYfN+nui56eGsKOP1yO6KaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJUg2oSl7uW9qZjMRPwQuDAa6bd8jlY92RQFRP0xF5I=;
 b=CjA5P822BZwVfOlsR8NVdEvN2GFppJfbZhINeYl31//x20+I9v+8S1ULhTqE4xDEr9uh7s27AjDaJ0Y5ckaio122PL67yAQ+iqhhqKWbQPcqp8XOubcJCXrJpCwI7jZ/htmIaDVIo5ibdmtGCRnrJGDlDSVrp/PxyKsVdHm4XLxIu1ZNA/lNB3oRftr+d17EOWF3rDWXcP/tO8lWO3bxSgRAlR6soTQD/yHvyK1Wy/Vuce2zisQeA8Q8eS38Bmq/GwyeS4h0D40ADF9k14EoQ0lT2QYvlZ/KSoMZHKAyCsiZRmp62+UfoAvo5BUpmBQuAta/Ys9gQJ1NkVqzAJ5bjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJUg2oSl7uW9qZjMRPwQuDAa6bd8jlY92RQFRP0xF5I=;
 b=bYtMt0E5w0KGe9Q651Wmw9w1lx5WCBuf1yrZCejgV5oD04DgM868juzwsEOgjTkG6GCMT0jw4Of2ieINEIzqg/kOGhsupp2M+6pLP1UdxjnWKa0yIDJJ/zQ0CzLi45hjIXjBYzSbKTJXWfWtlLE89V+CcmcmJO8jtLxmkGYilVN2f4Z2Z5jjoWX8Qm/+fu3WyexEQFN5EWbFiIPgHgEb+5XSWBUPaIfYMxChQCJFygTnPZvPyZD/V9qjm/4OVAnCcA7bhNpNfTSJbniHaKVSLqU1HiQIodZO6H44/DyJ5T3AQaITTZJys8/arsFbyuqSYaPTI3oYo8pLkrhZkq9qVw==
Received: from SJ0PR05CA0158.namprd05.prod.outlook.com (2603:10b6:a03:339::13)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 21:18:14 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::94) by SJ0PR05CA0158.outlook.office365.com
 (2603:10b6:a03:339::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 21:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 21:18:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 14:17:56 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 14:17:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Apr 2026 14:17:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v2 4/5] iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
Date: Wed, 15 Apr 2026 14:17:39 -0700
Message-ID: <b7949f2cb5667a88b5f15608e684d31315554c55.1776286352.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776286352.git.nicolinc@nvidia.com>
References: <cover.1776286352.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 66af1474-2507-4665-2a9d-08de9b348144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0TuC2oOSFn9GRnBN32Uaq+CXfYY4Y+ssTEbPjMzDpFyJ0u+1L7PaDqrGZX2/brvOvguMWJw9h45qrcolMiOtT4FeiR+R/D+sey9MpkwpgePz3SrKgFpfpUHTZQJy+V7FPZEJvZyVrn3uNf3342A1gyv0xQXDjZDRGjHubPtpl3VYnUwv6mVgzEDUf7TcR0ikYa+x8v8WiA5s8qnzapz5gavuiBwzuaZUY2GBV3R5x/vBhMXaXAZjd0LrJMZwSfa+U6+FGxD10AzkJLCHl+8ux3BhSSacz1QYiMg3gycH7AP7oLeCKV1K+9ZkV3UligRcUO16Ysf+nsyAW04mSUHiglEh2/AFLBmepY/nNQmgEx5l0Ppvt3HtaTOOHE4LG5K5h09MkjIY5SDux9Bj8niPIHOSuZtgGJHxrzlYJ0q6qmmLwhzwaMXmVM+3nyNsJ5be+cIrPTWn1Ejvj7gYTec3q4KnLBC6/4JbrJqarVufprPeKUqY6jfA6hu3+Ln1IT0Q0GQwBXNCRFbSd2ni1t8qSsQWEQoMRYBbtJ/xbQL41szebgMvN4Rkls/73W2uu0Yvd/XWUCJ+9PwNhwpHgUHuA3aHxf9MWt0OB7ezbr54lAxFYhkwE+bjN/uwWUOh91VUB2DkSfFUc2Bg9Jq51khT1VDmcRmMQ2Z81hngc7P3SH66GXlqRCEyiJ4DHuOlNhrIJXA54sOTCCgpc6pb53erwMZTSrfM2EY6QOiRf4dKrOOw3LGH3wVQfKIXK6gvvfaI9yGomzMhi9vS8dD4el+bhA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C77NX6kJ9QV6nxkp/wH+Dgn/LLl6joEx6rkNHFWsfgqsvXPVHHggTbxvYbyEaQvACZHcYrPp4iE/BDdVKGhfu161QWHByCimCsLi+s8RwFTbcx90FYJd9/DquTowkG/hgMqzci05Qq7/SUVlwUN4adDpf13b4cfwTDbM8PwUK8o1XCvegc1yZjRBT437rrDu+GN+wjW0ALK6tUVkZbwA9cs67TD5BqkC4eBj8A33HIOn3BPXVor0Ulat86I0cUIV7gH0TfynYmaRLK/DPpXpbMf0ktyNEZKwGtrkLuyTW7AvJbtsSTGJ9n8HetdzsIkK1Qp3dlPYFjnd05Ao39RBRyr0w2s7y5RYMGttrfatB265e2O5ksdFaUAWfvrvxL+CGJbzxRT8KF7NwKtLGm9iT/J0DH5s30qwMy4jxkxWxOPKb/Tqjxoxdv/lXiFZ1zWT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 21:18:14.1558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66af1474-2507-4665-2a9d-08de9b348144
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238216-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E36384081F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In kdump cases, the crashed kernel's CDs and page tables can be corrupted,
which could trigger event spamming. Also, we cannot serve page requests.

Skip the EVTQ/PRIQ setup entirely rather than enabling then disabling them.

Also add some inline comments explaining that.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 43 +++++++++++++--------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b2c34713bf9f2..12cd148a99dc6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5023,21 +5023,35 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
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
@@ -5070,9 +5084,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
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


