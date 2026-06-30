Return-Path: <stable+bounces-269889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hY0TEjVfQ2ogXgoAu9opvQ
	(envelope-from <stable+bounces-269889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 08:16:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FAD6E0A69
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 08:16:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ueTbP6mK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269889-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269889-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52783300E3AB
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 06:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20783E3141;
	Tue, 30 Jun 2026 06:16:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B83E00B9;
	Tue, 30 Jun 2026 06:16:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800176; cv=fail; b=qEqfwnErh8zCZ4tnZhgjhnflqyZTbL8w5EasRTU2k1ji8AQnzlQ10KDPOf4rWR1ZcFNT8xxVP7ikQA0+sgIHxSLUokE9W9CJCycUZpV5dE7pC9cTWHECpRB6dyxImWbrPHC6aqrFntt3CAiPYFNqZCqQRXvLk2KfchBK8GFWxwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800176; c=relaxed/simple;
	bh=kUaKrtX16Goc0dsJ1/dkPrjXwd/cbw3a6GenOc4oNtA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F2wyT8R/C98Ia0VxteyMv6wqNYBxgL6Jz6AARzosQ2ey0Atp1E4cyb0ovSbJgreoOSXBBGqjduVQ5XOAbM/sqnl3BmmAuSRT+88maPWNrXMorGP2nzh24C1uc16Ew38qU7SGOcgSj7po70DO3AHOyrUxQXGMXxok7s7SKyE6bsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ueTbP6mK; arc=fail smtp.client-ip=52.101.46.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haUiO/k/thfs39B4lTuADOXcfbh0k5IR4rC+X1uFTuV9iRJVfMND6/nAF/y0vNY66kP5nJKof2BLRkoLVDdItFWN6KvM1ibDr8zKcDIQtcvkIfZ/CPlwSXo1hygsYYW0I6agrV8GyI+jl8Ex/GFfd0eikZ4eOsiVqfeWGnpwDGPG3WIoFGSrAWqq7JsW2fNZU1k76H7akudehI84rGwjwmoGTeQrfkCRE13ClqWZBATvFuX5QROqc+h+YsxLqI+k/7TPNF2yEBAKgXHE0RmuodPjHZPPPqCejpxmB8Bh/dqfW6w9hRjq2YmqOU/MIOPzaSihGcv+cYmHk3yeOdY7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODjFiAhIfbPYBIARe0nrwOOhgJEognYGBG4bSmfWNbo=;
 b=eW86ey0pkFqXSEfSApn5iJDQ4CTXhfSuNOCbCrrdRNeXW6TAAnd9KlmJjzWk/+FgiIzXYy0DulIhDNN79fOpQi2qFPV7fg10/vk9MIOt4W+YLK+DdsR0ZB+sWLCdXEVhx37Y3T+1Wt87qXeJQpNc9iytLwEAJ8SavTCAUYJRj9qz5MxwLb/Fogx/JbNgJ3hCptG4cHFos+xGjgYRflxJYlTfoG9GAy+mGzzFjx+LlVeER0YJSQuiWaYKNMp3o4ewYxaShTGcaiMeZu9+OGqlhnmMXtBV6d8X+QVYojWzGNWqNA3wlxrZWU0Wx3hoKUO7MFpdJyOASeZ48332xV2SkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODjFiAhIfbPYBIARe0nrwOOhgJEognYGBG4bSmfWNbo=;
 b=ueTbP6mKdk3KAR60+yDcwesUWJLHdLTg+fPs6IP63rPn8LtUeLRRgxAhcKRxfyMZKqPRWlmfdh2Zc/LELOvRVMcxciyfbpr61BB6mkeqTfcwACQlZv617mKzXqL+s3jHguF1+/13BQEIMRO5HSBdr/uWNMa9/C1PiqB74WOB4PN5cnXJwE2CiU9y9xdfJF9mCVWTRVnYgCDdWjdkxFrGMEp/l4XsjQg7z6Oor77yvHzg82ApQS0CnvLa3T/CUx9fztJTiDUjYYtSFKdOTHmZm3Y9eDYuY7jDGELnnaWFwf7O6lEGVejZtGWbeARHor2HLk2XUZKa6XY/rxyfB5ZZ3A==
Received: from CH0PR03CA0116.namprd03.prod.outlook.com (2603:10b6:610:cd::31)
 by BL4PR12MB9536.namprd12.prod.outlook.com (2603:10b6:208:590::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:16:08 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::a) by CH0PR03CA0116.outlook.office365.com
 (2603:10b6:610:cd::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 06:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 06:16:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 23:15:53 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 23:15:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 23:15:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump kernel
Date: Mon, 29 Jun 2026 23:15:33 -0700
Message-ID: <cover.1782799827.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|BL4PR12MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: 3967c6db-4638-4f62-a13f-08ded66f135f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|23010399003|6133799003|5023799004|18002099003|11063799006|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	Y9OHUtu8gBeFWNSloDHPBxY8G3Mc6XWF0XfMeqLkEzPp/ctG6sC/73nZaSavz17rbs57NHs/WxwOQ8q8SfHVJg2ft2K2y4M97nvcMiuAACfPOie6ZyG2kLcT7Wb8xWVGObHOAZXA7iXJHVzwHOkm72Wz8vlM+KV6j0DCAfSUVI0h6fNhVdCyviVul3EV4nJK8Tlcy1I1eujey1jODeRfmSl7tDpX7/c7XOPi1hFS5klwZwrl9qoi+a/Ye15xvCLZT5MwStEpQdoEgWeNPy3MHfdnqukzNbjoiH42rHgeq1MTkPyoZLfRdz/YeD0dDC7VjxvfVdHozADuRcBksB3ZzQuQKby8PjHi4zq+VSYyTVbdpayp+JOU7E4RQzjWVy5SA1MLAi0T5JFMZ1DENt0QDTN9y/r8o4fI2ylttMMAIbrRDLOlVXjHuM/sKCvQJH07lezlSIM7aIEEHULKHnc8MrGBHhp8TyNdK/JQCRloZjEQ/zcfXgMDd/Pxgn0mYGHLgcIXGHiuhzUERln3DwG8XO3QF4OzLC/ECRT5xTGM/3FjICiEAtht2mg36CL1ShyJy+efvbO30jQHlBrKOHwbpAlJd/wjY4yoxxMO2z2reFUEDDfc1PaI+bRuDovYvZgdWWlRI6uT/am5gVsjYXnAuQN4NDhEiJLQZqdnw98rBvm8fsYzFuOb4G+YA062zp+S5c8rbbRrB34Wp+R6sVoVTQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(23010399003)(6133799003)(5023799004)(18002099003)(11063799006)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VZX2FlZGX5viGXbtscW4Fy+F/DURKsoCe/3QC2vOLbeLJaz1ReB7PpAKiWu9rmZpj6GcUKwUFtciWxo36q5xmzItbHSbh4exx1sYDnZbXJCKaUWKJXLB00S1Cv/FlTgZ+BKBxTDEQDoVEVUwUAGEIqkpgWPqglLfRQWyU4y0Wzui/BS8pRhGll5iNxI/n7L7GuyicbF4FrSAIIo+CZyRG1LuQNCzm3EfzVHGLiqt4xRNYxRivZGcITNxjZ9MIYg4Fd8pDobAYroAmCPb6Se9DEfg41hJ/aIKlakoHTPg7jotS302lGPIqWXJ46NyNjsC1Wq+s2zttzo6CbaZKro2weyoo9qtaILlnPzeefI+G1kax5FjyRJQFrZ/syLPmlDSwsEKJQ2ECkeZTm3kBQQTide8UXqdc/FoSa6/X21VLA2Buc/IGRKMhI/RGGvmI0nH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:16:08.6302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3967c6db-4638-4f62-a13f-08ded66f135f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9536
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269889-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:will@kernel.org,m:robin.murphy@arm.com,m:jgg@nvidia.com,m:joro@8bytes.org,m:praan@google.com,m:kees@kernel.org,m:baolu.lu@linux.intel.com,m:kevin.tian@intel.com,m:miko.lenczewski@arm.com,m:smostafa@google.com,m:linux-arm-kernel@lists.infradead.org,m:iommu@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jamien@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98FAD6E0A69

When transitioning to a kdump kernel, the primary kernel might have crashed
while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
and setting the Global Bypass Attribute (GBPA) to ABORT.

In a kdump scenario, this aggressive reset is highly destructive:
a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
   PCIe AER or SErrors that may panic the kdump kernel
b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
   the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.

To safely absorb in-flight DMA, the kdump kernel must leave SMMUEN=1 intact
and avoid modifying STRTAB_BASE. This allows HW to continue translating in-
flight DMA using the crashed kernel's page tables until the endpoint device
drivers probe and quiesce their respective hardware.

However, the ARM SMMUv3 architecture specification states that updating the
SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.

This leaves a kdump kernel no choice but to adopt the stream table from the
crashed kernel.

In this series:
 - Introduce an ARM_SMMU_OPT_KDUMP_ADOPT
 - Skip SMMUEN and STRTAB_BASE resets in arm_smmu_device_reset()
 - Skip EVENTQ/PRIQ setup including interrupts and their handlers
 - Memremap the crashed kernel's stream tables into the kdump kernel [*]
 - Defer any default domain attachment to retain STEs until device drivers
   explicitly request it.

[*] For verification reasons, this series only fixes coherent SMMUs.

For non-ARM_SMMU_OPT_KDUMP_ADOPT cases, keep a status quo since the commit
3f54c447df34f ("iommu/arm-smmu-v3: Don't disable SMMU in kdump kernel"):
full reset followed by driver-initiated reattach, potentially rejecting any
in-flight DMA.

Note that the series requires Jason's work that was merged in v6.12: commit
85196f54743d ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_strtab_cfg").
I have a backported version that is verified with a v6.8 kernel. I can send
if we see a strong need after this version is accepted.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_kdump-v7

Changelog
v7
 * Rebase v7.2-rc1
 * Add Reviewed-by from Pranjal
 * Reword the linear stream table adoption comment
 * Use dev_dbg for the stream table adoption message
 * Document why the lazy L2 adoption uses devm_memremap()
 * Drop redundant FEAT_COHERENCY checks in the adopt functions
 * Use feature bit instead of STRTAB_BASE_CFG in adopt cleanup
 * Skip CR0_ATSCHK update in adopt mode to retain the crashed policy
 * Restore FEAT_2_LVL_STRTAB if the cleanup action fails to register
v6
 https://lore.kernel.org/all/cover.1779265413.git.nicolinc@nvidia.com/
 * Rebase v7.1-rc3
 * Add Reviewed-by from Jason
 * Replace dma_addr_t with phys_addr_t
 * Drop arm_smmu_kdump_phys_is_corrupted()
 * Skip threaded IRQ handlers for EVTQ and PRIQ
 * Bypass arm_smmu_rmr_install_bypass_ste() in kdump case
 * Drop devm_ for adopt-time allocations; set up cleanup function via
   devm_add_action_or_reset()
v5
 https://lore.kernel.org/all/cover.1778416609.git.nicolinc@nvidia.com/
 * Add Reviewed-by from Kevin
 * Drop READ_ONCE on lazy-attach L1 read
 * Split "Skip EVTQ/PRIQ setup" into two patches
 * Tighten kdump probe comment and dev_warn message
 * Use MEM + BUSY in arm_smmu_kdump_phys_is_corrupted
v4
 https://lore.kernel.org/all/cover.1777446969.git.nicolinc@nvidia.com/
 * Rebase v7.1-rc1
 * s/arm_smmu_adopt/arm_smmu_kdump_adopt
 * Revert alloc/memremap/fmt on fallback
 * Reorder patches to avoid bisect regression
 * Use IRQ_NONE for spurious evtq/priq entries
 * Cap linear log2size by kdump's allocation bound
 * Defer clearing FEAT_2_LVL_STRTAB on linear adopt
 * Add arm_smmu_kdump_phys_is_corrupted() validation
 * Defer l2 stream table memremap till master inserts
 * Re-validate L1 desc on master insert with READ_ONCE
v3
 https://lore.kernel.org/all/cover.1777150307.git.nicolinc@nvidia.com/
 * s/OPT_KDUMP/OPT_KDUMP_ADOPT
 * Do not adopt if GERROR_SFM_ERR
 * Retain CR0_ATSCHK beside CR0_SMMUEN
 * Clear latched GERROR bits (e.g. CMDQ_ERR)
 * Assert ARM_SMMU_FEAT_COHERENCY in adopt functions
 * Add STE.Cfg check in arm_smmu_is_attach_deferred()
 * Fix validations on return codes from devm_memremap()
 * Sanitize crashed kernel register values in adopt functions
 * Drop unnecessary l2ptrs guard in arm_smmu_is_attach_deferred()
 * Don't enable PRIQ/EVTQ irqs and guard the irq functions for combined
   irq cases
v2
 https://lore.kernel.org/all/cover.1776286352.git.nicolinc@nvidia.com/
 * Add warning in non-coherent SMMU cases
 * Keep eventq/priq disabled vs. enabling-and-disabling-later
 * Check KDUMP option in the beginning of arm_smmu_device_reset()
 * Validate STRTAB format matches HW capability instead of forcing flags
v1:
 https://lore.kernel.org/all/cover.1775763475.git.nicolinc@nvidia.com/

Nicolin Chen (7):
  iommu/arm-smmu-v3: Add arm_smmu_kdump_adopt_strtab() for kdump
  iommu/arm-smmu-v3: Implement is_attach_deferred() for kdump
  iommu/arm-smmu-v3: Do not enable EVTQ/PRIQ interrupts in kdump kernel
  iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
  iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
  iommu/arm-smmu-v3: Skip RMR bypass for kdump adoption
  iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 467 ++++++++++++++++++--
 2 files changed, 422 insertions(+), 46 deletions(-)

-- 
2.43.0


