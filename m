Return-Path: <stable+bounces-250923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEhVN8TqDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:09:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CAA592FF4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02B7A3096A86
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3743F54DD;
	Wed, 20 May 2026 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sALuAYdt"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D43EAC83;
	Wed, 20 May 2026 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296655; cv=fail; b=WwQwKX7NNTDZXHfpN2szD6VS4B2zC3De+AuZwbej5pUOL4ozNReZIyxnVPE864EbNODymOnCVTBCRqJberrtZJSue6T5U6PneU+Wpcs7gmUDz5Ns8qxdT1PkTuzMmSAsBBtOeTFF0p2s9wQcbmZyFU5K3IG5CYV8hCkQj2Pct8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296655; c=relaxed/simple;
	bh=lfyVWnmML4YCloGYcyaCsgJHYX71mNVt98cl3W+1JIg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jWCUTe0quOV0t16nKF2X41B2FxTFeuGEShEmKx35+EYBfkvQpDDolIQaCliJakpsJiDSuDbeEKZTYSxzdOWVfFGrIcSqP8VpkSiz1kwZJ8FD/GDUi3e8YB23G7aa9cpBeukoFUk/ZBY62H1bTTaimj9d2Y1Nhs6FGYdh3OT1AjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sALuAYdt; arc=fail smtp.client-ip=40.93.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hn9HQ5RhJgsZ4srLWFttBiw/f3SIesEHle+AA8xLOso6Kky9YQJfzY/hw1OLitpCagdFB3h8jrdmnxyEDHDOGoL2Lmc42H2oVRNCwKs+J4ZB3CmT2+ABAvgYPcn78QqpYPqGaShx2aIMdLu9cA3+L0LwkVr6/yosn31I7y2qfBNUtp9XzOZ5ROdLGFBgS0jPDlNM+f02qha26LGcc9NUA3TkNS3+KsK6i0t/VE85x4w/trQ10qMMatS/uiXS8n2c+Gtgfy3Bgg8xQqWorHPJN155vnNSS0PMFfso8hami819uQByoAha4IAlOL7cRJyKDqPeSbYrSFArqwYXyPuepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPoJjrJY2Es5JcSpoxglm1Z8kr4s9kW2XU+17UAKCic=;
 b=bmRMWWrtgELItZRDPnz1p11ccdtxzkIGDobYNUR3dwXws+RpZl8aS2tjuVZRC2G2irTzmhYUPARrFXgt9j/iU3gw5OIHAwsUmD3BnNCqkUgt9X/1n/9BbwQVQTRTkjezDh1AGMB96Wc75Agt7Jq6AXr2McWkOemyRwhL56KOQYr1Kx61PaFHJly9yoYJpBKREP7HAm8Ivx4Hd4/SaASZBC18CHy8xsHpOgRtT6pOE+hpb9JABhZ7V/zNr6OzbcxC5L+o3rO7+sPUv2Nw45+Rq5t9ugqJCXSRTCtykKs4LKyImvgTRmAhNf3ajuDijt9K6MoVo/uhvovTVCSVtI3gTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPoJjrJY2Es5JcSpoxglm1Z8kr4s9kW2XU+17UAKCic=;
 b=sALuAYdtWNbGAIfWu8qcdQ7UIM7wdGmcgQYrz2/2CcG8aulTY6HRWpbiRXrO9DE7OKLj2iYkDrYMF2+hAmyAm32Nd5c8zYOn4ccv5sP8Q6JQXi3dOPo/16DpyfPofSqxc7bBgl+Ng7GK3rQTPQkskt/yYfxpYtELbO8mdBWKcfpvNLGYk2fCGyf1CC+BXODeyx3DehDF/IeRN9ROad4Ror1afTUZU/INO6MqgtGybrQXl5ftF9dqUN6WBLCxnc+W/z65z2ElNx1oOJoD/w91yB84gq8eHV8ki3GkcsEislpQsU5SUtNUocjCD9e7AW0p+ukHZSj8rvY74tvK+9yJTw==
Received: from SJ0PR05CA0183.namprd05.prod.outlook.com (2603:10b6:a03:330::8)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 17:04:03 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::8d) by SJ0PR05CA0183.outlook.office365.com
 (2603:10b6:a03:330::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Wed, 20
 May 2026 17:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 17:04:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 20 May
 2026 10:03:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 20 May 2026 10:03:43 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 20 May 2026 10:03:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v6 0/7] iommu/arm-smmu-v3: Fix device crash on kdump kernel
Date: Wed, 20 May 2026 10:03:17 -0700
Message-ID: <cover.1779265413.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: b410b576-c04a-4f6d-803b-08deb691cb7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|18002099003|56012099003|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	DziTGipnpU9O/8xEHT50ZeRcHWYVMwHu1ODF1AugCHz9wZhoIW/c7g6EKbLf4k9wi/w8eU/2c3Sdp5O0SlPx8noCCIC1uGHEBArWp88/TLRn1G2CrdqPa0Qt+mzD88UjCNd0QqPS503/JvKpGL4fR+dUxfFWFM9wDQlbb5fXGUjJAXoYjLfot8gj+/nOvjm25vSTOe0/1ep4XEKHIlNAQTb9afuTcVmQRbeTU04LNQ1F6QiCwxOXdC7/sEhsJk/vam3EG34xzumwOLztOU04BMwk43dzZpRP9WI5xyGN0Ln46f2GtP+CLSPkI7MoGGfGgjpgU+7q0Q0AgvkrRmsoFHeBuzJe8lwfNKSAHk1tTYD+9aLS2vi1ziNt3xZk6aMrCZkk+JPICVM/0fuTHKqLTCfYumyzDX2i2pugKswIbSblZ/gqsf/NkfnRolGuFuwsLw9TYq/e+UeGsrljGPrLjMApU+Vw6eZALTqk9Gu8SiWc8D9rnGVE2WPQ4W6Cof+g42kkMS+SLP1hh0aiTzI1G4n+9iTXRzZv1ZCXj10vyh+Qr0yHxrbylB8O1sWezrZKvKNDV/ldDSZvFtVoIlruW9+eM/032lSz9kycLwM3DWYI6zyt1JcMX1ZXz+e5fKwdZ9GuVPjwi41hmzyuBuXAK3GrZlJADO9c6LVkNjPZpXdAW0HobwO0dT2cIhgD4fndJlsV4VEtJgpC9u7AQ8EdQmcz2petdjxoqmY2AP1erkg=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(18002099003)(56012099003)(11063799006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7RRZMAc3iPIODdwXWfaqiSlsIlBYzV0Eua8pjwD6vQ5iA1skp3t/sBive7JUiM8pxF4MLk1OAluViOyzPmgayGLnr1ig3IyHqzqAGCqEM9lg7i2MTJq+6y6IVnwVaJ4E0JvyxsqdJJMJCeqjz/G2zKTurV9UcuJwP3hjLVWKsMgbLoa5lYPdmvNY6eabrWu/CZZ9gKWB0amlz4KKB5jFx1uscngd0GtfgtAzPyNeu6EW0I3Pwc3oYdLvg9Lv+OcTGlDTIcCleuG5ncrVwWfub1Msm9Zn9t+nBFq+lhifCX/9Ass3SaU5Rrl51Y0ih8DXgy1L49esOdvtNlj5kBN3CeTt7fApb+z1bvCglGVwXO9ylHtwqKlcEthw2WI02id7XyoUdKEUyHh98OrAabv0RJufKVBob9vrD+on/ItU45cNNwfn6wJunv/cwy9kkZYh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 17:04:03.3501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b410b576-c04a-4f6d-803b-08deb691cb7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597
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
	TAGGED_FROM(0.00)[bounces-250923-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 88CAA592FF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
https://github.com/nicolinc/iommufd/commits/smmuv3_kdump-v6

Changelog
v6
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 470 ++++++++++++++++++--
 2 files changed, 426 insertions(+), 45 deletions(-)

-- 
2.43.0


