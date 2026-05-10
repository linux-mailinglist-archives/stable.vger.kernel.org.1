Return-Path: <stable+bounces-245077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CyYM1/3AGoFPAEAu9opvQ
	(envelope-from <stable+bounces-245077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 23:23:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA2050674D
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 23:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A42D3001D72
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 21:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8F733FE12;
	Sun, 10 May 2026 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lw5AgOD2"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494E833F394;
	Sun, 10 May 2026 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778448211; cv=fail; b=dzN2rQSVWynvlbfqp9V0AY9zHSbZMUfrrFZy5Tfjy54+MMsaXz6QNZ7S6zwkTGJOP81ULMVtOSnV3iVxV2wJQ7Yf/ssmC1NTD5XG4jb2KGtP9/MvZJaEN/A8brVd2ug+oeS1XJhR1x6gH5MSP/TnZV31WRNPbQwPDu6dD+sMkhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778448211; c=relaxed/simple;
	bh=WYK/T9Go5IfJyCZ/FjTGApYiK7a/VktAUzTflCb/0UQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C6J9+O4PntYTtwk36Pg5DiM3hP6DSzLQk1DSFeLmDA7dvcl+JKM5Nl3msvfHPSYwBDaJbM6j1jk0CzaCdwp8mdB8LCF2FFsNf2OPPS4S0Vw80p6LW4J2fIRMHCz5rJ+nJiffKq1IOlifO86AkkbPuTZNIFmUWT4OyKiSzoAWNB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lw5AgOD2; arc=fail smtp.client-ip=40.107.209.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtuQHHIakmDO85zTqmf9LQZvXboY4ClpNyculcXFLcUPBQa79AjBuocaDEoabCwnIAzmHbU4lVPM713A83a7bHyTUbUaoPRy5vI1CYVXkAL9bVLghyq7+EHhi1yKB4Op3RjbavB/fkE7UD/f/wqCnedLsnAkphf4v8BzyhI9z9BP3ug68mKpKaXx+98ujimrfUgI98/EgCCRHg4HOQ8YRg94h2TlkbrnSSNXCiyFmPuXelQHOdjvcVsnoMVlkI8ABrD0PpVu+sNXEIrKhW64Ycf4qmcFQPgmIxtJRjbQJLLntCIiNDZRpjQGurkcOGmibuVrtpldsYB+PQrZdLsQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtAOu0eFA23o05V5CRmaq8PrJpQx9XPRwAfVORuS8Yo=;
 b=ORsrQ9hVy8Z+xM84CDY5HVBPFwu5l+hZiQwVv0djRmZZ9exVPFqzTN1QlCb31D088Fy9CNUYJ0or0Ho4guIjbLHXj+uDYXigJ6WpavvHH00wsJkzvYNg5wT8KH5NihU8QtTvTN3lUZBIURbheuLuRiIAFTX7L07x9UGLlawaiWnkNYgRXjqVmuvR27jTWnVLfy/6bQFlvpbyRXBOCuNaqCufrFDgFvcxbqxcZS7jnXp2ALCfix41SdcGjN2TWjN57uLRZw/XjMnmDfcrBZBoKnUqB+JQcyXbuzsTRBdy2zaHyry61hFB74L+dltXYNSCQ0dnYUKnSZZObBv1ZDskiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtAOu0eFA23o05V5CRmaq8PrJpQx9XPRwAfVORuS8Yo=;
 b=lw5AgOD2B0wfcoWJIJ01fNUnbBnzI6YdCeVYIKkiQxvUOrJEYm/Z+61qiX/csjl0EESX9wfhx6ZzVJ0LedZLONn0zxWxFG7QUP1e+q0Yb9u4LEvh0YRqpDFb8inK0vs0Z7d3fga6n+Fo5Ts05IpRZko8QTx3Ykdo8ebLc8nf6ya0dXuLVTO/2raZTpLzLyGhqQANHGpRMlwCynM/lRwjJoSnNev9p8lMo+sS0OCRq78yizm3MMRDuaJsqZ5cTeX75gIlruz0BjrczbpcgCRZUkF1StvDICMhSsJsmjWcjpeRcS9ncQQK6hEm0TWkvbjHG3IaF75uQp+bROmI+fR9Hw==
Received: from MW4PR04CA0337.namprd04.prod.outlook.com (2603:10b6:303:8a::12)
 by DM3PR12MB9286.namprd12.prod.outlook.com (2603:10b6:8:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 21:23:23 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::52) by MW4PR04CA0337.outlook.office365.com
 (2603:10b6:303:8a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.22 via Frontend Transport; Sun,
 10 May 2026 21:23:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 21:23:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 10 May
 2026 14:23:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 10 May 2026 14:23:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 10 May 2026 14:23:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v5 0/6] iommu/arm-smmu-v3: Fix device crash on kdump kernel
Date: Sun, 10 May 2026 14:22:59 -0700
Message-ID: <cover.1778416609.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|DM3PR12MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ca889c-3c3d-420b-5193-08deaeda5df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ZnEctmjsMOzQIOntJUTQEQVxRQHt3Q4f4u3gvxxy5Urrb59BDbfyuZU8JVEIJaXxJxJ0Ltrs6988YrFwT5tr4obWZxcJcD9+BzMg0C6K5q/4ozxudmJiZpd5nWT65KmPKA31QipXcoq7aIxo2Ega615O4vnXkYwlQIEvpQwONqFk9Laqpyhg6rZ7UrskPaCvqyncsR7xzDUomvWMxtX8k8QBPv6h5/WO6ptvC416m7CA7eSxte7HvlsI6Y6JeVJb0lRDvprQ4ZHO8rip96fPToTd2wqnJCcshgDIl7e6VW2m1fchwFWfEf8JApGqBU9mOSzOyOkI2jDYj8u9KAKAP/k4JCm+PVazLOCLpEoOzmxNiHKgw6Xc/1XHzt4f1OCQWMFbwyQ7yN5TQOCRpm03fff8OpQh+5Kd5uHjgvPlTPpIuCir2YgygNd5GkXs+QPXbisAV8n+y94p+XZ8qkXDRwvx5htKlh4Gwnj9ReyjY9M9PO/3fkdb91wLeDgmf1R0aOGagnhZOc4Epya3LhbOyxGD2iY5g52IMs/91V0t4ulQqvf0kYfHCixcmlhJ5TOm9K2wzIqSfdcpgYedXaxXYb2cj/usYuowwyq2VYOvlFisYlD3oiKNrUl+Uts6TVACuBt29XpuLQvNNZ0Ssiy4bRfj12EZiwGiZUF/px+R3D6v1xNS0QeN3+EqWRpHbzwo0LuPwzB0lK8f/mIKGxIdR9e12aEGe62yx5MRXmvAuTg3WoZH7RGXkWnRJnXbgmEG
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aNM+SX3RjGd8UHlEXufyi988XssveuMwO/uV1yYw4qW5x1W9XTYf/6OxgTdxkro/TDK91UlrtWl3SB7WcPgUdd9A3Qtr1c4nDtGY262KuLsrrnOBbg7iHWAg/3aFD/L/YUqwXiARP2DchcQ8m1n9p9UtT3GdmJ1ExZAtGwnnImF/KzTutDDdRAkQMITJAOYlZOEoqBEeakJvoV73cgcLQjyCcmJw3Gb902oMzVNHmwWp+yLpCfs9z3CSm5BDNaXnGCpjfHd5O2/RrOAQ2C3S/A/wqAuawU5uzddNWUWODvu1zBOJk/xRVkAmqvb1houlrEX2ZsgPYxEnVQm4NVxRGbgCz8b6u/RavI4Bna+N/lTt6VF7zRN9+YtN4Ep/YClrLhEdrsb3hwCG37JyVCHwwaz1mRPU4TiELb7sTFBNGm0xeHG8gx/Q5lwfUshh3Na0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 21:23:23.4618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ca889c-3c3d-420b-5193-08deaeda5df5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9286
X-Rspamd-Queue-Id: 6AA2050674D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245077-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

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
 - Skip EVENTQ and PRIQ setups including interrupts and their handlers
 - Memremap the crashed kernel's stream tables into the kdump kernel [*]
 - Defer any default domain attachment to retain STEs until device drivers
   explicitly request it.

[*] For verification reason, this series only fixes coherent SMMUs.

For non-ARM_SMMU_OPT_KDUMP_ADOPT cases, keep a status quo since the commit
3f54c447df34f ("iommu/arm-smmu-v3: Don't disable SMMU in kdump kernel"):
full reset followed by driver-initiated reattach, potentially rejecting any
in-flight DMA.

Note that the series requires Jason's work that was merged in v6.12: commit
85196f54743d ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_strtab_cfg").
I have a backported version that is verified with a v6.8 kernel. I can send
if we see a strong need after this version is accepted.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_kdump-v5

Changelog
v5
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
 * Keep eventq/priq disabled v.s. enabling-and-disabling-later
 * Check KDUMP option in the beginning of arm_smmu_device_reset()
 * Validate STRTAB format matches HW capability instead of forcing flags
v1:
 https://lore.kernel.org/all/cover.1775763475.git.nicolinc@nvidia.com/

Nicolin Chen (6):
  iommu/arm-smmu-v3: Add arm_smmu_kdump_adopt_strtab() for kdump
  iommu/arm-smmu-v3: Implement is_attach_deferred() for kdump
  iommu/arm-smmu-v3: Suppress EVTQ/PRIQ events in kdump kernel
  iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
  iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
  iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 473 +++++++++++++++++++-
 2 files changed, 450 insertions(+), 24 deletions(-)

-- 
2.43.0


