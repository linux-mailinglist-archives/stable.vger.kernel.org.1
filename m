Return-Path: <stable+bounces-241827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULn6Iy+y8WmwjgEAu9opvQ
	(envelope-from <stable+bounces-241827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:24:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F232849069A
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 09:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3927E3048743
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCB13A5436;
	Wed, 29 Apr 2026 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pKAoFF9Y"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747063A453D;
	Wed, 29 Apr 2026 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447331; cv=fail; b=fjvJEkRiGiQfaCEaRDCH5yuaamZefUjvpVbbUVMNRXHi6JEnRb8NRmH8i4x+XOL8UwPiWyTeq/3majMG1yjqyLY6OuyEUqlCXv0nfJei4//83cUwNr/ouYGDCUpgBml1soayZ9E2FyCqMZu44pHOwQGSU+qcqJNKlYMnTT5XH+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447331; c=relaxed/simple;
	bh=0zzm41FemGGb28yUkHpL4qLL6M1gzbaG96Tvu6nh0rI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z3fg/8Db4+J+jzp4MPwu2nkAFXoEGw6dHXICjwyNRZZbyEY13PZd85tscsaWiUW0OiCUtoOOZ9GbmabgbN3KFXnJMwCtWVmlico8DBvO2c7CoM+2G8ei8XER9M6d+B3uLYHlPbHrFBtBQNskI+0dL4dMs2WLH1mt9W6AC4SSESc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pKAoFF9Y; arc=fail smtp.client-ip=40.107.209.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lryGzq/c9yEGZTyh/AIGA8ivmJN2zGR4RHT/xN9KVs0NWE3LbL83+7kdaCz/Wz2Pez7/vFRYjoZBuKDzQZFOksy/iQVa5O3W5lN44VcK2S3cruGiD4diUwxg9CNudS8N3f114j1FGxDxrN7L7x2bzo9oSrNwMTlV/S1XDKSdQE+ONQgBlAVORwxx5xeTx0eqcDd9HM9WNrEsem1Z1foKel/746r73ALMpGwa1XDScU0YC7T5vLVJiftUuPDwcwkUIiOWVfBckuIg/DrV7xtSvq7RGa6s0P+tzYxAp9VqTaTSMNRhdITmKJjY6yBx00Td+38aR2mJkFYu5CAs+dPSkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9IlEr6pYQvyNPvGYt1tlhkkSp3UOmFPneHGTVKjpvM=;
 b=sg5WuhdSPWz40Utm0I7PYymFHCaWuQDHvbgt/EyY86BZxD4mDGIsoFcWx7nEYQZvX4Jucb3bPC28cHOSa/3n2IHE+Y9AGO57mT5AJtnTDRaYS1k2HPbdVjK4CUPuqfB+OPdEl+3zhIN4aP2x/HnV2oJ9K2gxZOFcD2SmsFycvJYzxszl9WwP0yOWGMFOrV0C/2Vwmrh2a8oYY+rqTp156KnxJ8DXsJFEnELNXVdhsKj1OXARMQ3u0OGNEdQQrhMjCDShTcAjZeWqqBg4B5BIYjLF0Pka47tmHu8shRZGh5+yqvplnSJOCbXokFr2ceHVWFr5XP/piu1GyaFg0lt1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9IlEr6pYQvyNPvGYt1tlhkkSp3UOmFPneHGTVKjpvM=;
 b=pKAoFF9YEcxh3XjSL6iMehrZBp4xrRq/vAltVI8+13pmY/d8CnNbYHqkKCIyAph3vPUcihGJeDJrd3praSIrx27Ul4THMC8xCuq32gFjkUrs7dyxK9sKbDg9gUnqg1ibEBpgLiCugv/dR4toAFSHk0OPoHzgBI5SfyXhQGOjzUFMGe2aDlrq0PRJgr9vA2cnFvEdc03G/ClYPs6TNEpMr8jVzHdaqBQE4fggAyPqlYCRRRTpVwSydy5QB1QLjzbNuFascC/XK6MU+ksGzsj2ABLKWYLdumANcX9dzXBmFmZOOrCq+Fjwhsaxy2oBcALvhQWmJn/M5yurlkSPEbbVjQ==
Received: from DM6PR07CA0086.namprd07.prod.outlook.com (2603:10b6:5:337::19)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 07:22:00 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:5:337:cafe::91) by DM6PR07CA0086.outlook.office365.com
 (2603:10b6:5:337::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Wed,
 29 Apr 2026 07:22:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 07:22:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 00:21:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 29 Apr 2026 00:21:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Apr 2026 00:21:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v4 0/5] iommu/arm-smmu-v3: Fix device crash on kdump kernel
Date: Wed, 29 Apr 2026 00:20:48 -0700
Message-ID: <cover.1777446969.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 9903a2f5-fcb7-4e6d-0a01-08dea5c0010b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Jz2LF0se94T8bnBALS0lCqGE4mby+XED0gdq5pfi4ckqiSpcJMsh8sQYgLRf4hgGMALRT4wn4m04Yif+qpdQj6IvX58tsqkPIFdoveJk6sFN6AnY/bRTmFKUkIUMbQ1Ng+p5hUpen2gcOcv+iLYr3i4Ohkd8UQEJsv/mE3kr2doQB+7F6L5c+TKMJtOerjlQ/U1YPeXz/ppGrZg1txT6QLhYPf70aQRIdfggAlkjaycADjXLTbPXojI5elIO8HSViYiT+fERfr7XhMxmPDW+BxpjK+JoGMh1ujL5ctOxsACebNF9SYZOX33adDx9SfR1V6lHzfdSpLgazeCJm0TsYN2LtRqzYrSICJjVl28Lu0mH5alkTMugtAd81puB+b2qwHQht5jy/5O1X0YIKzl5r9lj4o41F9ue9XoK72bdMB5cSl9q+lWdZWXHpHphZ1ShCtnEq3OvZaQa5qR+DY3YXX3YFgzzw7jmhF2+kg5AxlTVbscCZvd+u7lO7YvyuhhfmfNF/FugE20gTLWnLUHXULFFxI2frYBdpQl+9PpntNpLQ29JDRYLRGjIZ/28BqU3qhd+5Me/5W0mwCtylDqTdgcm5PSqe7NFuz998ugBgF9KKbrv73H8hfRHBVm1znQeEYtddeClykNvc7IAKXoj8VqvHwcWsETUG/rWKibXzjIv8u2JKaH6V3IxuM1gkTJJy80jDxbKFnT6Q10pWgErZT9MHmcQj6wj7F6ui3grcXWCfyXJPMkf0ycnAdKdMN38Eg1t8SczOD6DJ4aU+bY9AA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8C8RHLBaxfbfkLfjoC0J9YmpwMh1CSINzgxr1kpke5nKdmqgeyAlMhynjDy36LiTYpttIRAJOqP4ol43oZfLkP0wKtF75xy5N7RiKCF3jsYxWFLGXs4v1qn6oKXPT0mnm8we15bCqYGJXVB0bUY9AVSJaByKMB9BYbvXPhAaalrXcLmbcwPH54WvIXR3TO2i+io1R4obemYDzI8qEE8HhJGDOA30YGKLU1RezVEVxb+H2jiNTCLgBCNARgnLqczVFJDoostlW3aks4VUmoghz9x1+gjMs1cRs29AfAQqs7du9BZKAZlxIlv9M+ANqWil/mClHRVlvOrwjNCRb17KRb7j9vHq8cLJuRWlv81muhAkAAonM39bIDo71LMIKmu7EHSMuJmHWILq4KpTqAki6zamJ0jyh0jg2R/ao6bGEo0FM3pEADEDcWf8HFe+Y9bg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:22:00.1473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9903a2f5-fcb7-4e6d-0a01-08dea5c0010b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557
X-Rspamd-Queue-Id: F232849069A
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
	TAGGED_FROM(0.00)[bounces-241827-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]

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
https://github.com/nicolinc/iommufd/commits/smmuv3_kdump-v4

Changelog
v4
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

Nicolin Chen (5):
  iommu/arm-smmu-v3: Add arm_smmu_kdump_adopt_strtab() for kdump
  iommu/arm-smmu-v3: Implement is_attach_deferred() for kdump
  iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in kdump kernel
  iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
  iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 475 +++++++++++++++++++-
 2 files changed, 452 insertions(+), 24 deletions(-)

-- 
2.43.0


