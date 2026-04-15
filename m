Return-Path: <stable+bounces-238219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELrGD9YC4GltbgAAu9opvQ
	(envelope-from <stable+bounces-238219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 23:27:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD99E4082A3
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 23:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A91B3032773
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF17638F954;
	Wed, 15 Apr 2026 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DfOCmzD7"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB4231D39A;
	Wed, 15 Apr 2026 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776287907; cv=fail; b=GuzEVINczZmYtW3VDPnNbVMZlUxcYoLhaHU3wWj6+9xeOTdkF+1GXcAG9tgqDYPMtyji3fMPKJ5v4Tj6QvPyfjcSYEyLyxtsHAxK4xqJ+I1m9zijETU+oLVXa6HbxZcOVYYdf2+6Qd5xe40LSqyq8OE40+XnX645OFGrU0BJ9Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776287907; c=relaxed/simple;
	bh=WxAHp2LK0oKGFPv8oKZ6hQddC5Rj57KYE/DpO4ZIGWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0ofKAl5BySr5jFFrCY5O38NoF3U+4RF8TNdZ/XkjeFKJJeZiLL+jnXerhzQphxl4p46U0sSM5i7+MSYGBd9UXD4ZWmxGJWpTIfzIAE0+Gn/kTn7uIm0CampbHuir/idwhTGO6g+80xNN+r8Aa+vRDlfomLZqDjKoJno+SgJEk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DfOCmzD7; arc=fail smtp.client-ip=52.101.61.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7zgZ6hVIUsN73+4IdwZeVgiyPNX0CFwcTHOYo1ZfnX9QkquZnN+YiVitG929FG0PTo0ZQiv2cEGkliW/L8NEs8P33499/8WPtvOEcfxybONAc538lItD34r3ByHcshjYu681ReEIKh+7zCKFihUzEjWlYF99nDRMs3G3k9sxfPGZ8EJpU+BDTQHV0YzkPR+F9kU9shU6jAPsZx9+LBoGYcUIYgOgqufN46aXSonj2Yghv569Aoy82k/aDEznTLtUA2DJvko5eYgIPM2CbVwGliAGrH1L7JNFOxZeA1vJnlOBs8yOrbrhhkUm5v48FXF91ZFP7IyINC7zv6VHZTTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPxpQbB7JZxa2PE+YOZXSFP1jbj7njwoqftfubF3zAg=;
 b=npDC6aJg0iB+onXSgot9MMczOK6O1KDqNTXJLE94He5rG+gg8iIa3Hco2Ov/+PDJT142Cl83BMVK0+55tEfSpMsLy74nbL8VWSBKQTRopiTALcsepjK9HTftpfCn5K9w6w7YysIR4LDfpWymWv2aGF9nD9HolbxvieTfjvCcPeJNfXMT8FTNe7UCPainYIxKbXGSZFbttvmxIQ6hPxaiFRVBFtjrpFjEhE2JVKvYsAWvbRQRVfHCgWK3PGcf4PssFBikRWiHsvHo5vT9rF7eADQa16uGP/Fg1HaNfa9/IheKIhmz5grSXrIrcxrXAWDf3MBTdjeJ61SC15AAFHW87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPxpQbB7JZxa2PE+YOZXSFP1jbj7njwoqftfubF3zAg=;
 b=DfOCmzD7UmkiS7jPo3VORkZojV+nm7up8APKZavF9Fkeaxs9w/QoTfIkln8W6Ihw90gaBDgSkaV1GrSc4fx+eedAdCNKLbaPq6szzBSCaB1VufBvLb6Z1qIj0maFOqETimQKmrruYVlDl+RliVmk8nCk+DAOyBXHvMfhdu6HIJlhS+f9kq1q387eJ1GK0RsmgeXYdfLYVqpwWJPnO22eyQ5GscAXCJfMrxPite+hXfM1Gci9/laf/1LGjI01YZGONsxWt0olHeBWrpwXIHaKAvBloj7BRxDiSv+SyKJPwEKURRS403xhSUgpNgofQl5J/PQgKZwoNxYpQ/HmKIffwQ==
Received: from BLAPR03CA0047.namprd03.prod.outlook.com (2603:10b6:208:32d::22)
 by PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 21:18:16 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:32d:cafe::2f) by BLAPR03CA0047.outlook.office365.com
 (2603:10b6:208:32d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47 via Frontend Transport; Wed,
 15 Apr 2026 21:18:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 21:18:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 14:17:54 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 14:17:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Apr 2026 14:17:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <baolu.lu@linux.intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v2 2/5] iommu/arm-smmu-v3: Implement is_attach_deferred() for kdump
Date: Wed, 15 Apr 2026 14:17:37 -0700
Message-ID: <7637d66c0f6c1fb16da4b5c9c4cec71752cf4d23.1776286352.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|PH8PR12MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c815406-5013-4352-c403-08de9b348257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NQ3yJVR1TrjJRgs1XfKRmXJRUrh89ft9yRtZ14iEx0rhf2yNs2+ktaJpvLprCfryHcwlwBrc+xtiQRETweKEZibXeDCiOZZLVM3HG/0T5VbZwYD3gPZJXhBftILtABdq+B0rrhNbi7x4+33z6Q2k2tWEz2nc4CVmpi+PZhA6wIXHyGEp4L1kh3qW3CiawRevLSyg0h7QCof3qFNI9FWaIZJFPvX7YiD1LIPrMPq6P4ewDcmwUzELCwtlboey705GL+hsmJCRiYLG44dCRoopH+3CUkH40ok+nTC+RWQRCZbW8X9b46SM/BGjyD8agg6QAiN1O3qC5uAi6AIN0ECDxXxUdNsW1HJ/j8YmkiRxems17s89cP40KV/kCbGQnZY6f/EwYF15z2wiImcQ5vy+C9cYKUyMiQaVulDOresqQfqekTmqrbmWDxgpYUsEIAavXOFSxTa1a+fFBClxa4uVhdcSYZ1snqGKXysDsDuPdPc6yt2OcOrh1IPuK/XIbZhHELAc1fVxtMgTnUYdeL9crgzv5SOeJc2fmWjVSxDIvavAxyebtoEC9msCZ/evVvXwVB+AZdQ4xdqrE5KdU/Nh6d+D5SMYTm/BD9/xL0a+jVgXaUiAcBwReJ8Z6fas+B9pSXZaME95pwcQmjpov84IRSrpvijjldXOCvqBvLncH2RN2R5R214tXu6FpZ6y/sYrk5NjlVRN56Obv8m/UtGVls1AFg1AgqyGf6u7qUdtUn6zD8pOJRQ6qiPM3tNjPuvGcdeOZid344nGqC7Qx67gkQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nycnXApbwFYH78FegydzRePgO0QMVM5i+QzwRRUII7xDHg/7q/9Jee2mDGgRNbCmW3JUhmFH7Ix/WMXqclQLNsK6VkyVXYHAjtLF9UpkfKvpYEfDTbQtapyYCmCOxmdl+g8BGwbRv1ZJ23fORWYVtAlDTzpSIsMom1Gwwsi/Ca8QGToGxHsr7Y+xn346/qa0t6kKZZYzJf3UhGezFqCLytrfCMLxEav7Vyq5Qj2TOqe2IVTQnFITDxBPWYMiVuLmm2nbuWswoSP78QnNlvFiThCgB7YabjmJh+JABesoMjSguiJ6FhEvrOOgfuJ6XpLMOgRxofklmPL3cLA6Mfo4HlGDqiTRbjGXVthYjb1zBg5ziwGAdaKVVKhLG2G0xqauyM8iswlUC1xP90XUZ6c8YJVdMcBGxVoEhTOXUIxeT2VUlj26sO8QVP3WgpuVlHJb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 21:18:15.8690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c815406-5013-4352-c403-08de9b348257
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6939
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238219-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AD99E4082A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Though the kdump kernel adopts the crashed kernel's stream table, the iommu
core will still try to attach each probed device to a default domain, which
overwrites the adopted STE and breaks in-flight DMA from that device.

Implement an is_attach_deferred() callback to prevent this. For each device
that has STE.V=1 in the adopted table, defer the default domain attachment,
until the device driver explicitly requests it.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 28 +++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9a45f17200a21..d9d543eb8cecf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4212,6 +4212,33 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 	kfree(master->build_invs);
 }
 
+static bool arm_smmu_is_attach_deferred(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
+	int i;
+
+	if (!(smmu->options & ARM_SMMU_OPT_KDUMP))
+		return false;
+
+	for (i = 0; i < master->num_streams; i++) {
+		u32 sid = master->streams[i].id;
+		struct arm_smmu_ste *step;
+
+		/* Guard against unpopulated L2 entries in the adopted table */
+		if ((smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) &&
+		    !smmu->strtab_cfg.l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)])
+			continue;
+
+		step = arm_smmu_get_step_for_sid(smmu, sid);
+		/* If the STE has the Valid bit set, defer the attach */
+		if (le64_to_cpu(step->data[0]) & STRTAB_STE_0_V)
+			return true;
+	}
+
+	return false;
+}
+
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 {
 	int ret;
@@ -4374,6 +4401,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc_sva       = arm_smmu_sva_domain_alloc,
 	.domain_alloc_paging_flags = arm_smmu_domain_alloc_paging_flags,
+	.is_attach_deferred	= arm_smmu_is_attach_deferred,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-- 
2.43.0


