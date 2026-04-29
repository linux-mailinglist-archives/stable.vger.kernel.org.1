Return-Path: <stable+bounces-241830-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGpjLVOy8WmwjgEAu9opvQ
	(envelope-from <stable+bounces-241830-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:25:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC184906CD
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B615A3065A70
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480383A6418;
	Wed, 29 Apr 2026 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T7irpQqZ"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF03A4F23;
	Wed, 29 Apr 2026 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447334; cv=fail; b=JBmh27HdXl6PMt2d1ZvtSyWqN8tAcbhnRwaxIR2JKdpG4q1UbIl05mcQa0qq5qWgv3Lc/EdKVCRd1SqCwaINSx4PYt4xkk9xT0B8fDKksyaSwRNZkvyJtA0eCQeicB8NX5N94do8jFUKRwot7v+BeNgg1xJFXnPpXbiCbtVDk/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447334; c=relaxed/simple;
	bh=ElTa6CJ3BHxvJnQUU6jimrmmSnS2NmBRdUhOB+9hBgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvNtSthqE8fShXTwyTeQC7WZ7iwTu4eMWUoCeycCv2DJQpdm3Lj923ULR6cw/XT47sAfhFzZXwex/18dD4hoa+K9/S6g/hv2T+H2JH9LSySxHYTnClDRERXNx+YsxbQojqPQEOzKFjiH06gL4l8gVRes5hMlvNT+hEW7rVbBuN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T7irpQqZ; arc=fail smtp.client-ip=40.107.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZNIRKBuSJqsyl/QKIROdWg1KjTFoXwXxCBYW4Zh/63GNO7pWw/LklMwbrdGYBlhk1RuLfrC0T4jQhhH/HGJ7CV/xftgCfwk0zPhUP1lpFFcqclQvYtnD9dKuJsKXMyVOeBD71bojShb99sAhx4CtE3D7CvOOlyj5SqzHvPIkucDHRq/9PRUIIzQRoEAKXbPcQMJauN5nkuvf3hzZzApzaAEMz0tMr5BXXv7rXM/cghvuY/AAxUoANLrk1H4HDBTcQkEeHFHRgIbXGdNu45zj8XI0f4WXyWVGQhuFTbuthcTKjyfbVpQF7B+lprnxgcA+EDomdLn7sXtfiSlcSwbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPaiU4Ut7qTxEGojwPbSXgxXu9sWpKZyZev37AOEnwM=;
 b=qMr8K+83fucEOi4uykTBEcMAWhpOn0lfyYA2KHk/sIpplPcg6gdXu9hgYokKnRY+aX6U/t7l8ngUNbTDcn+ARTdAL8hywn5ll8TAB6QZLlzktHKfthbUQofmfIDo9+qdkXF/h9dZq846jV8z+0z1q4HFa8uajWiQL6VGtLW6SsGGyko7eEX9NhMJzVTV7gPHAC0Iywp/BZ94ZEX+UVFhpgkrQRkoks9WpumktX3MqP4wUBZQFjBm+0wgzaRio2glOYeN85+FBs1t3PAsnJhPAbBYtYG87WV3b45p1MbSI/Ub+3B2McSkp1RJx3KQ6rY06Oywkkw9qfnLEH5EuvkUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPaiU4Ut7qTxEGojwPbSXgxXu9sWpKZyZev37AOEnwM=;
 b=T7irpQqZ6cZF3EVC0zupGIkYKgoWteknhhoI+ZJv7VjJmo5CLpHcc2UUt82tTKXrO1f8EzqzyCmM7to7Ez/+2I/OD+Dge8S28mlqsxEdspajshaBZkQosC1ItCRipInZpXeeeoJXwxRZn0hOeD9rWXOPdju7KhizNETOdPSnYwaR2hngi/AhvXC8FRkSm1G2nJBG3lNOuXLtgHqyrzNK4pqoDvjw7x4FXd8iJ/qXMeWEBiC5CrMjID0Q6yASumdpJS0zL6VNeBKxwmuMmjt7HhZKhNtW5sjtwWkS4QFebccFExewgY3W3fipdi/VZ8QNzKTB/48EGNdecJBjOHvZiw==
Received: from DS7PR05CA0010.namprd05.prod.outlook.com (2603:10b6:5:3b9::15)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 07:22:01 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::44) by DS7PR05CA0010.outlook.office365.com
 (2603:10b6:5:3b9::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.16 via Frontend Transport; Wed,
 29 Apr 2026 07:22:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 07:22:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 00:21:53 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 29 Apr 2026 00:21:52 -0700
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
Subject: [PATCH rc v4 4/5] iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
Date: Wed, 29 Apr 2026 00:20:52 -0700
Message-ID: <38bbcaae651ccc3adcc78e232bdb5ce217c86693.1777446969.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4d5ff7-0f35-40bf-0f1f-08dea5c00171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mJATnY6Cx71dD94nm/gQVvtzTFdKPo+SukFdMsyvT6qdmXMqQfh4w0XyBgfVQBOf3Xua+VNoHWXIAuL1nAlSUSmMTHs3XSQ5j3KbcrR4GK534858qnOu8PlaEh5/d8ha/b0sGDNGtdOPkqzh7HGUoRJugpB1vBx+XAyqTNE/AbeJ3g9X0Emj6sZ+TDEyEU7sUA8Wf50oH6fxZ0e/h5KBn59gAEGEfGBBI0b9g9eIzytqFMtZooyoe+LpmuNwNwOX+KQmsnlSjoKTQLBllOXFtMm5/HDCZZ9S5keUWhSDywLB5nyBuuGtSul+LK+4Xs8dJXOHyrhgOIH5CCJfXCnKW1v1K0lJpcdnzAdiULIkjIawIoasbii6vLhkMVcW7RmmeLVs/SsyEokpuTqLbYRNoR0Tah5J9bs6bh02QIUptNLOEqgChNtqnRmvRP78vSoZ/CnI05cIzjPOqk5ldOTshDp78QH/Gj/MfoisNuJ1Bl60QvRgvHZichx4UbAjIKewbHy5UE/JRyc5SmSojgjPyoVt2QNP9+ADGh9ThSKuQd1dX0NDA7uIdkYJQybuODt3fXzyk1AVyycPcwQHUYpWh+wXsrCeTYPPA4Rj7twR/ieONiTorNrfGoPc0rQF9yFQetwZbf7L4X5hgL/7457asglvTVyK1tA3JgxB79D+/E3BMORE3wy2Pqy9QR4K5LTKGGA+K2CZ37LyBXyjefSWhQ9hIwiZUcsLjPwpHjwAwRP0jJfCzRMEmAe7RsaUpJYFXp89E42WuFyZkwRC89kHfA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4ObH+Ma7yLn7Dp5mNjVZUMXM8l206O7L4uReoAGdBmUcb/5EqAIeprrT6yh0FSqq8LxVT80mA0ZUW2Fj+FMgsXguukaBH27aN8QeEfbPUO7hlW+aI+bCv6EMzQKIbo0gMrYiERiGlq397D49Mox7w1pWesC8BzVrkkrv5l33KVFTpJIa07SH7NLR8oW6Qxq7+2Dn8e6rcfjdwWA1ZyIfunLWXNpVhxPecjTamF0UTdg/5TQUwe0XFMuvtwSzV/5GyRKXu3WlGjkGeOJYXob1364Rr8HZz8DzphyMsDjVYOrnygx/c8QR+5ms9Y4duC4+/weBDALXjU7H9iL/W++s2CWU7avjUjkC8SdkGxYzHoanj6Pb+lFuOIWlyHRfdMbwza1fXVkHtZUPnkYqIaH6Wcvo84QyKbUsX1dqDUwpyhA4MZ5GUcDNzR7rkuHyISkO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:22:00.8239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4d5ff7-0f35-40bf-0f1f-08dea5c00171
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107
X-Rspamd-Queue-Id: 3DC184906CD
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
	TAGGED_FROM(0.00)[bounces-241830-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

When ARM_SMMU_OPT_KDUMP_ADOPT is detected, do not disable SMMUEN and skip
the CR1/CR2/STRTAB_BASE update sequence in arm_smmu_device_reset(). Those
register writes are all CONSTRAINED UNPREDICTABLE while CR0_SMMUEN==1, so
leaving them intact lets in-flight DMAs continue to be translated by the
adopted stream table.

Initialize 'enables' to 0 so it can carry CR0_SMMUEN in kdump case. Then,
preserve that when enabling the command queue.

Clear latched gerror bits if necessary.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 47 +++++++++++++++++++--
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 17d5e1395e245..f9332cf0b28a6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5150,11 +5150,28 @@ static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	int ret;
-	u32 reg, enables;
+	u32 reg, enables = 0;
 	struct arm_smmu_cmdq_ent cmd;
 
-	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
+
+	/*
+	 * In a kdump case (set when CR0_SMMUEN=1 and !GERROR_SFM_ERR), retain
+	 * CR0_SMMUEN to avoid aborting in-flight DMA, and CR0_ATSCHK to carry
+	 * on the ATS-check policy.
+	 *
+	 * According to spec, updating STRTAB_BASE/CR1/CR2 when CR0_SMMUEN=1 is
+	 * CONSTRAINED UNPREDICTABLE. So, skip those register updates and rely
+	 * on the adopted stream table from the crashed kernel.
+	 */
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+		dev_info(smmu->dev,
+			 "kdump: retaining SMMUEN for in-flight DMA\n");
+		enables = reg & (CR0_SMMUEN | CR0_ATSCHK);
+		goto reset_queues;
+	}
+
+	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	if (reg & CR0_SMMUEN) {
 		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
 		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
@@ -5184,12 +5201,36 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	/* Stream table */
 	arm_smmu_write_strtab(smmu);
 
+reset_queues:
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+		/* Disable queues since arm_smmu_device_disable() was skipped */
+		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
+					      ARM_SMMU_CR0ACK);
+		if (ret) {
+			dev_err(smmu->dev, "failed to disable queues\n");
+			return ret;
+		}
+	}
+
+	/*
+	 * GERROR bits are latched. Read after queue disabling so that unhandled
+	 * errors would be visible. Ack everything prior to re-enabling the CMDQ
+	 * as a stale CMDQ_ERR would halt the CMDQ and new command will timeout.
+	 */
+	if (is_kdump_kernel()) {
+		u32 gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+		u32 gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+
+		if ((gerror ^ gerrorn) & GERROR_ERR_MASK)
+			writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+	}
+
 	/* Command queue */
 	writeq_relaxed(smmu->cmdq.q.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
 	writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
 	writel_relaxed(smmu->cmdq.q.llq.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
 
-	enables = CR0_CMDQEN;
+	enables |= CR0_CMDQEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 				      ARM_SMMU_CR0ACK);
 	if (ret) {
-- 
2.43.0


