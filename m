Return-Path: <stable+bounces-235501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDVyFGIC2Gm2WAgAu9opvQ
	(envelope-from <stable+bounces-235501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:47:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A4F3CF195
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 603A4301CDA8
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 19:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B8433B6FC;
	Thu,  9 Apr 2026 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qL6rjepe"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2782D7804;
	Thu,  9 Apr 2026 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764055; cv=fail; b=FQG6xl/qf9wsQCqKFHiA0FEueZ+OkCNhMWDJB3P5oiJ+jJB3iZ/5D5vrebTTvxKEsckgkzVkdSkuAkOBM55fopLDCIcGSADgJC1P77e6Os/McWtlsBmLAc0DldQUED0c+KLSTatCI//j53yA435dXXXXI/fZYxgidZA8jT++8MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764055; c=relaxed/simple;
	bh=lCJKOAz75H6T6OqmTLuhIUjizdYCxlPp9Qu4nLya3hE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r+p6Y0u3yYZ6WUrPqtN3NvRrCEQ46s6Tjb5vjdoDAmD0sd/UjxYH6RpSEO273d4ntit8qgJac6CrsgJWsecd6CyHf3li/a+LMULo/LuRcmR/oi6hc0YTWYMHNi6k+5J9H7ksE5HE6JJJJaQSJuORYLWrVZnnVIMxxkbreEnMXyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qL6rjepe; arc=fail smtp.client-ip=40.93.198.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fR/SJncJXyGJDztMw/ZGb6/5w6P3ejNCBNuW9marIfd1DW86hF+nuB+8WqSPIzpRiIOarMqueHgI20x+PUmnyQ7NmYIU3HmsKQHpLTZwCHSRzJs2H2qWRjxgmirADAk/XIZ7NH+qZsDvHg4CcGxTRMYdnzijgEr/0ZaL6lfpQn9CnIluuuniRtpGQQ+nDMWagB55WwOkyTK9RmrUegeh7w1BRfUIb8Burn+0mVysCemDKiCY1tVoMfnVkzTNDF3Kw7lHHpReOI3lG2mj7qXECpV5RAix68BDwsKigRCyOpzmTi6o7ydYjKDkoOYGIklUf+7wuWzSAqjumnrzA2Pw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIgbzUipeuXrejx/n1+eqDJI1QuSppHL0+80bUAt+qc=;
 b=KyHFNKAcfDvH6RLGU+K20jMgD2CcSqMMxUXtD/dKgX1bvgRGnNVU8r3PEcoW8SzxXHwU1Wn3jaLccnDVh5QH8llFPnehRJrFZG891akhIx9QRQxSSDrr9xCyYLrjlNOLRDg4Qip/y1jbHrlfP5jQfszU2xPx+6FC/DjtHvoh8CGGpnAcWj4wWf0gvmMHk28szF52BkuG+HnZC9Oxao3cxIS1l2kbc4bcvlbjZo2hWU1Sg7k0EG5KSdya9wfeccByyl/Onvnje2ch+viVb6S5kfJBonKJ7DL7AQSlq+F+PUSGbHG9njqXcdLLa1k7Q3HTgp8PDv0QudlbxCIyUZbO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIgbzUipeuXrejx/n1+eqDJI1QuSppHL0+80bUAt+qc=;
 b=qL6rjepeja9yCsKo2C3P5BkkwNclD1BhTmzfsFg+ajgaUtvCheeKbZaduO26Lv8Ja1OBs/k87TfMh9TDhxYianBLi0gekm9HdjNWkNgs1hyPBoCDYJ5USDjYwACfabZSzV8/WbuX5DAO4rGqtGP/11YVfMDaCpG1zlsG+2M8JkGZ0j+ZXelVQv/trWlUh6kcnQflJIQ0LUvPtZDIr5s59qsm96enP0oj25ZWVBhue5MULVZc1AqPIUFZvOuvSxv+s/Ez52VY+UZS3H9LBu8fbWyT0zQ90NIvjYRu/c/cpgNziApxViwErSnkPQPsuHYFDpe9TJHEZzm4v3+mV6TzQg==
Received: from SJ0PR05CA0203.namprd05.prod.outlook.com (2603:10b6:a03:330::28)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 19:47:26 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::3d) by SJ0PR05CA0203.outlook.office365.com
 (2603:10b6:a03:330::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Thu,
 9 Apr 2026 19:47:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 19:47:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 12:47:09 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 12:47:08 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 12:47:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <jamien@nvidia.com>, <joro@8bytes.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH rc v1 0/4] iommu/arm-smmu-v3: Fix device crash on kdump kernel
Date: Thu, 9 Apr 2026 12:46:49 -0700
Message-ID: <cover.1775763475.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: ef21bf16-a864-4c41-f02c-08de9670d3bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|1800799024|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	RUrvPWsTlikyxvpzMrKbIiB+IZ2/nFu73ta0KCUzal4FatunUETss+Go2Hk7Qf6x/a2WvQvn2oIf8f/9yu6n2cFpItOpsiKBrQNZa7GCj/YeffpdAUG4MC5798t0+pvBMLMNkifQfVj0buCtBdZBZ2avf6d+viIbnCkKm7IEe545WOIgADb9nSvZP1XoWrTzGZIz+v5qgEJDgJ8ABm/NfR15LcWOVZ5Eute84kinUOjY5fPk2v9XBrDjksPhsOyHEe2q75Kn0GJOeuwqEIzLNtk4Xoil4GFRVTngypHjk7ZDq5rzn88tZE0Q2LWlMfIM8TGoyeZ/4MTZvfydOTUiLNweHOwNisuUBs4lmx+gt/K37qIi075KZ4t2XPGQzlTjWgoCObM9HDgJwRAKqOjvbrozDwWN9I+j+DE/1gfCRjpx9RKUSNowZWODMRxX3ZoYahRb3+fB4NN0FY0Y4UEDdQYh8NsbDV1nvTKiQhfJHKzHh8LYU4CSevhGBh4y10tzPJ6/pTh0uOfUOd1N6YbEiXqZnJRP3fQVUD9G5JDmmO6vtSnVZ4T9QDSTeEFRrnwhV15H3oea5eCrSR+0r4pnYJSi6wgBjhKITul6uG5pJV6nTDYy+2n5pGsu1/Q/q4swRYnNIfIuAXdTOIgmGsa781nItvwtVmSC8d3r1Stb2l3p2Y1OUrsG/ZfwB6Kk823xPFr2MsahW5Uzd6E3jIQV+bGPMJ/bByeEkLE3Q4trRNYuhMEkyH/1CGfSsX4eFjo6aJOQyv7peK0ydu67PgNM2w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(1800799024)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ydUKGYi7z52fcyrSN55qnLcymtFiFrOUZ1yD4TPVXA/t2ElfX1yKgu4aEQI6DcKA3TD8/G1wpl2yG93Nx8h+z1uSAozOHJ7B+q76lOrrwKBge2fBh9M5eqoF0+jwWIGD292nu/LlyYRtBSkv/fy18eG7H/C8qRNd1bmT4CippqmcdGZ2qVI3ZCtPfzs+zjCdJUzfCE3bg01qbjJBJVkpM4gRcD909HCCAhh5UhCvSOhYhsvh2ZF7lnut1+A1m0HTePw/0JqfNpAinCXL61HdhYgkIf2Vwou22/eKx6xepnuPF0RVmju/hspiZvgxJ7dWvI3SdIRLscJlL82YEtY8FMAZtgOoaxYN6gdLHXDsZYenf2VQWaZittbvNPpIp7WQewTghOxOv3gsZeJWj22ig51ZuLYUR4Ly3pEge1x5YJdPqJObvsVwDp1XOuldlBXI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 19:47:26.5806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef21bf16-a864-4c41-f02c-08de9670d3bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
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
	TAGGED_FROM(0.00)[bounces-235501-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolinc@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C2A4F3CF195
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
 - Introduce an ARM_SMMU_OPT_KDUMP
 - Skip SMMUEN and STRTAB_BASE resets in arm_smmu_device_reset()
 - Map the crashed kernel's stream tables into the kdump kernel [*]
 - Defer any default domain attachment to retain STEs until device drivers
   explicitly request it.

[*] This is implemented via memremap, which only works on a coherent SMMU.

Note that the entire series requires Jason's work that was merged in v6.12:
85196f5 ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_strtab_cfg").
I have a backported version that is verified with a v6.8 kernel. I can send
if we see a strong need after this version is accepted.

This is on Github:
https://github.com/nicolinc/iommufd/commits/smmuv3_kdump-v1

Nicolin Chen (4):
  iommu/arm-smmu-v3: Add arm_smmu_adopt_strtab() for kdump
  iommu/arm-smmu-v3: Implement is_attach_deferred() for kdump
  iommu/arm-smmu-v3: Retain SMMUEN during kdump device reset
  iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP in
    arm_smmu_device_hw_probe()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 176 +++++++++++++++++++-
 2 files changed, 174 insertions(+), 3 deletions(-)

-- 
2.43.0


