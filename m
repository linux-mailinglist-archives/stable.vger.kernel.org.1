Return-Path: <stable+bounces-69247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA16A953B13
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 21:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C398287734
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 19:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D79762EF;
	Thu, 15 Aug 2024 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O+g5QZiO"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FD85A7AA
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751298; cv=fail; b=FwXjrAEHQ3sL6ePaY7/iQCZVglsFmz+vGLaN6/8oVYP/fOXyQwGG3Oot9CNZPaswTz3w+h2Y3hkRgajvOAkCPf8oaO06s8lGKUfVS0RIIwZi5Sr32gaUfJ340ZMWXlnEIP2+p9XL0PVKaDQja35U7Y0M2etCCEJYs8N19qb0FSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751298; c=relaxed/simple;
	bh=3v2MSPQrQN0ZdesuhPrrBplj+Zl2++boLDCzTsTI7uQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DReJm9ayihtJdhgSYQBrjxqMuRW2XHCH01WID1ilGNbZTEUxblGymx/F7x6KisE3HgJC9OqKuvEC90xHDmcS1rdff7fdZ3qCl4mX33up1dxW6sL68zwjaBehqU6gC2aAriSkGpjOFhWheyQqyvsfUPZYF4Gtu12R7XZBa2bR+hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O+g5QZiO; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jO4EIQjH/CoeK0ZCpTLWOYU2pR7sY5osUOGwpowAsRas492hSXS/8cfrpRrMyNyhCRdC9dpNh9k3ASprBynYZhKAZZ27EIRFpEoA9Klt49d2lol0lxrCHrra0v1Gb94dtomQ+JZ4zRKAfcg1I5hrn8QcOlurOaQB6MBP9BQcGkJYlLHBJwfo/IHAHYFctPdQ/cVTxXheOBR9yFm0qwKvI68EgS5TE3Y22339wA+Sn3BejVG5D3cKlpbPLOofM76GvEAq9hfDFX6hKykas/a+tRIl5iwQEOIPRMEA7HmlVY/FTjF/hLkhwBgchZGMj3wWR25bUvAJcpLxfTXSna3ECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrqJkOz/ns/qodSgd4Yz8KnwjMmXoZE+v1yqI71zN7s=;
 b=bvZUaHF7zhSPGr0HOmka0D1eQtGZ3aBRCWI+91uj/Fd4hBbwSjyF6g5YMXi+RiCYQjn8GInBDqOQHP1nYZBX1lJvzIA6/8kA922me3egJi8G7y3DxyXXw/EdCeBdAzuZu4qRCWQiSJLqZBDevOunu2hijfp9pLhLAVcS3dQjj3QGX8AZEH7eVWEteBfH9x001sJo0EPjLkqzxRLo6t/YBhzsRQ+TVLvfvg6hgTPN+1yzWN3S2b/jlw4Y6uCHm0F3zlqgdIpo0rjYCq2KE+lQMLjQ8Wf6owAD1QtZSJ/6Sb5Tim7P9zUpe4KWwgom394GuylGPtG73odLbNX7GQpM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrqJkOz/ns/qodSgd4Yz8KnwjMmXoZE+v1yqI71zN7s=;
 b=O+g5QZiOND69h7RjFAVQYtwwUqbR+eAzhgaajzB2t8e1OtntYnwOn671rIgjO3e8MSEqVkQEA3c5DmDNIxgFhb0C/6IbEKYR2RIwaM4FUcuA+Ytpj9IGWSRgSPa6xKzv6pbpPzZxUMCz3sTSjOgankElaoQ82V4MxKgxaJOMUWs=
Received: from SA0PR12CA0025.namprd12.prod.outlook.com (2603:10b6:806:6f::30)
 by DS7PR12MB8369.namprd12.prod.outlook.com (2603:10b6:8:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 19:48:14 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:6f:cafe::81) by SA0PR12CA0025.outlook.office365.com
 (2603:10b6:806:6f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 19:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 19:48:13 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 14:48:13 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <stable@vger.kernel.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.10.y] drm/amdkfd: don't allow mapping the MMIO HDP page with large pages
Date: Thu, 15 Aug 2024 15:47:58 -0400
Message-ID: <20240815194758.2074691-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024081203-dreadlock-trodden-9b5f@gregkh>
References: <2024081203-dreadlock-trodden-9b5f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DS7PR12MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: c30dbc3a-7818-4e0a-5ce4-08dcbd633358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E4DPs+KL6qQ4ToOfKrW/n45U4l/QKEbYVp2fYCIdGOVk1V5kRXsFW2lqcDFn?=
 =?us-ascii?Q?6usvcTETQWV3RwUmI9QPdSbv2X0fcnOOyJDeUwKJmf90aXfasx0KYad40xNg?=
 =?us-ascii?Q?AX2PK16OE6xJj20C3dC8070xSb5PKXVrc3EV2RaKihtX19zI8jvJbbYDgy6B?=
 =?us-ascii?Q?kv4HsN/fu6iHVdcoimBv343+7YRZFuPAgXTUAC30j2tXVrGyw5KPILuteOaq?=
 =?us-ascii?Q?mjvi6ka0nBlSP0zZq5cpLNM+5ZesBUhjhjpTFXVilA/CEy60mO7KITeVP6W+?=
 =?us-ascii?Q?Mj6Orh8qAt/OHXfSELeWt4WOHmWB01srBosEtMiF98g7siWIs7jIXaJrMxdi?=
 =?us-ascii?Q?3CMZet0uCvsOVhhSpETD9KpDvHIs0QVEXdMtqbztK6nF1cOBoK8JIAN2HYSO?=
 =?us-ascii?Q?XkACS6PqC76FezuApxpc4kAse2NiTvbPKMyrzebj8UF6uQfn6GQj9ZhlfR5H?=
 =?us-ascii?Q?//7o1xySqf5Lhsp1YQivxKRpe5EFg9hoCmxWRqZPpmwzcDmgTGPyP7tx4f6M?=
 =?us-ascii?Q?sQblkX40tKTH239IaqAGp+xM5wIpXLi+qTuFoYW4KL07+nQFAfCb7B0uj5cN?=
 =?us-ascii?Q?ZwIAR6OAmKPCJJaiw6ADDXMUZKl8x61TgwuSc3IHBIK+U772hTCbpKDtkov8?=
 =?us-ascii?Q?jZKMzHBCPDjbgI1r6sjJTbvAXADpYOYHl/ki7T+DS3WQKZlLx2M+VzVMClpR?=
 =?us-ascii?Q?6FSSxBNL1NrcILn+lbC4YTLMG43+8axK3a1r01hnGKoMyNE5DJ/KB+Xc+Wew?=
 =?us-ascii?Q?ECyqQ8OMexe16dHDzo3vjKWkcpQjf6HL/CQUPBYeZ92VC+K6UYrVIge7WnvG?=
 =?us-ascii?Q?5hzsVgYfrXnVQGqzcMIIpMkdMQFhcubtJSDwdsKaeWa70GbwyOBg7LcIAOqG?=
 =?us-ascii?Q?wPfUrDkP36nZ8AOb/0hgV3A7vuvF5dyFTUZDD0QkiTDTk3BmSRpaf0PpN1wp?=
 =?us-ascii?Q?JDGkb7lfIdUP0E/FuZx7hyABD3miqy72hXXQXlGb/HzGha+dykaudGKbKzcQ?=
 =?us-ascii?Q?k0WHkMsMArnPBr4uWbV+je9eJL+f3f5dWDg88+hb/UH+lrYj1p5JG3V94XAi?=
 =?us-ascii?Q?DG51rUz4Z4HeJ5KljGF0ZBPs7wcqm/XTHcMjG3uUHo4gLouW3PsacbBFn/0e?=
 =?us-ascii?Q?Iaiuwr26k3opul5xBxSfk5hD9kmnemBINOC53ayc3BKIZ4aqv8BluitYaLf1?=
 =?us-ascii?Q?cQPbUFNxkYwLdKU4qpigLN6HK4H2RCuMEO0l10Cvto83Od8IJDI2WAIyx6eH?=
 =?us-ascii?Q?iTgPHp8446W7C6hTLFM6/hGdTtFDLeX8RNt9pV8L/7/wWjM9vDVPIc3rEtsk?=
 =?us-ascii?Q?1Ak3goVcBWplo1FZARMkUbtXfRdcpY+HFdqmZyxO8u2RByhgDjLIsU4iqsRu?=
 =?us-ascii?Q?arKQp4GA9P4CcG2PA+lney5Txr4OspK6BF5rEVHz7I6gIhz79WXqcZWpEcyu?=
 =?us-ascii?Q?M66QXPFZI72+BsH1mTpkA8RBDSQ/nxFX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 19:48:13.9827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c30dbc3a-7818-4e0a-5ce4-08dcbd633358
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8369

From: Alex Deucher <alexander.deucher@amd.com>

We don't get the right offset in that case.  The GPU has
an unused 4K area of the register BAR space into which you can
remap registers.  We remap the HDP flush registers into this
space to allow userspace (CPU or GPU) to flush the HDP when it
updates VRAM.  However, on systems with >4K pages, we end up
exposing PAGE_SIZE of MMIO space.

Fixes: d8e408a82704 ("drm/amdkfd: Expose HDP registers to user space")
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
(cherry picked from commit 24e82654e98e96cece5d8b919c522054456eeec6)
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 799a91a064a1..9a444b17530a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1311,7 +1311,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 			goto err_unlock;
 		}
 		offset = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->kgd);
-		if (!offset) {
+		if (!offset || (PAGE_SIZE > 4096)) {
 			err = -ENOMEM;
 			goto err_unlock;
 		}
@@ -1969,6 +1969,9 @@ static int kfd_mmio_mmap(struct kfd_dev *dev, struct kfd_process *process,
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
 		return -EINVAL;
 
+	if (PAGE_SIZE > 4096)
+		return -EINVAL;
+
 	address = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->kgd);
 
 	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
-- 
2.34.1


