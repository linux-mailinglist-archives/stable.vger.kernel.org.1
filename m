Return-Path: <stable+bounces-43136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDEE8BD4C8
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0931F225D2
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 18:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1DA15886B;
	Mon,  6 May 2024 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yQqaf+JG"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678C8494
	for <stable@vger.kernel.org>; Mon,  6 May 2024 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021069; cv=fail; b=oZfOpmxPENLtwGPmMmCGFWxy0f+fI0m4nX3SODzRCGRnIUQtyOk7uXY8xR1Npv6iwcRHkh+jjmqQRHxDv+Y6RepEAszYsHLrt0ovFMsGSjRwXfMmmx0EXaburtEr6Lb4MggfjzgWE38TAWYk/IQCTHhYgmvwcNZ0VeFk78j6bYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021069; c=relaxed/simple;
	bh=a0cYB3JY2aF+6y9KjStWtHWZmfOjmNa2/furGWsNkbU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e2j/AIPt9+9cEE43+yry8oJt2HUC0xV4v9DLLWT9yBmQcbM/Z9NahV5Hwojb/qLZfpRrkQVqh8WZ0ttj8/91UHnDbHR16HFV7j5WFy5We0VjgpRuGiBKuU16mk5IRPqPz6/GFbXR/1NyYsEAAEiINWWLZwjHpmYNyiB+7eOQb50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yQqaf+JG; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBMfrXJ23NKOKZMewG8OyxMtsbvf6St9BfeHuIeo4mTUn77WpY9PA9rVDZRSUezZOA7n6wxp6w7qomc9fm7f0C1Sy42AB0WG5v77ty/rkIe00mRaODcvE0vtw4fZLWt3ufLF1cUyKZocjzrSYjmTYasQHcpNPsQGX0fkVJFM5Y++x5oKMon9yZDei/CRZmS84X+bprZU3UIXSWUXzfS9lUzGnBl5tK1lxI9CJUkZhAPYSKgKVbunD381LU2g8aKWZzSuvCU+dcWrfFbpW9DQ3tKm2/5kQx1Eop20SRGPsF+KlOtMj3mlyqKPO1WgycejMCuG7VSyvO6Xe67Khz90Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+SoE3tRlIZmPCKsBHlgOdNO5LevtgbTQDCD5dM/mGE=;
 b=Kg9HhdG6tNTRMwti8YCAlMHzqUfaLbnHnSaYgfOw2sD/dFs50dnvKltyDqSDPQlG9iiDcIDug12R+gCM3wGiicUN9NE+AwfyWTqNW5IWnxx233xqVqe/6Hg920pNA/Rxk9Pk1LBuOMgNBCFr0I9wGxAvB93S/9gHLybzo2rvxgVkIjUIVL3tc18cjhxI0EY5D3wIhZnG7K5VmIGxCp3fqh6p4/ouUKat6Ia/1MNvl4i8s/TUIWQJJJtiyIlEmbaECh614ZmP15tqQU/yRtnf9jDitli7Cxk0XkmuUpWKLP7ZU0/ezsIGB/tSto8oEGYWTNbP5fg1G6cph0wuhQIVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+SoE3tRlIZmPCKsBHlgOdNO5LevtgbTQDCD5dM/mGE=;
 b=yQqaf+JGNJop+ueIyyFbio4RwgUFyo+QFzMetf4cvX8K76PXyu4bnwwX3hIer/QxhvxxgngHI+bUUZMEVj18vVqwHhKtVbzUSEPE64X8wRJ7GPtrz6rFcWJ6cs6Nzdb3rqPfrjkEPs5gJgfFKqAP0geYiTRuJy94nL1YXaf4mD8=
Received: from PH7P220CA0114.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::8)
 by CH0PR12MB8550.namprd12.prod.outlook.com (2603:10b6:610:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 18:44:23 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::b9) by PH7P220CA0114.outlook.office365.com
 (2603:10b6:510:32d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 18:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 18:44:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 13:44:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Felix Kuehling
	<felix.kuehling@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amdkfd: don't allow mapping the MMIO HDP page with large pages
Date: Mon, 6 May 2024 14:44:04 -0400
Message-ID: <20240506184404.1668364-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CH0PR12MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a87f40a-cf1a-494f-ebd3-08dc6dfc8bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jgY2Aj70NgVbIeEya9dbZLdSffQyj3y5lk1mLbx4TZO9wYl1AjUnN88cBw/8?=
 =?us-ascii?Q?feb3YQQPw/fm2kkrjQTZG9wX6VSnwtBJOkODxA3jqFW8jGylZNeTlNNJ9nxV?=
 =?us-ascii?Q?PmvUccE75XWqLKoNIsKpyYCvPYynTWqnsFVutX2/AoUUmuSBRxxow7FJzlHF?=
 =?us-ascii?Q?uQJkOdtdqhH7gFsEO1DwnRjwvJ/gN9b/9xaTDytHb00gVN5AqEnN07DgMjwA?=
 =?us-ascii?Q?Prm5Ut1yGUYSC0tWKQ8oWlPeJKtKsCiNdwAv4RhXIYLoIVp26HWdUfJFI9rH?=
 =?us-ascii?Q?hjq0b8tvz+i8UsdanZKQvNXRC4XxYC+l6osEoBBE+BmOS9Po80Nk2zLDeuyS?=
 =?us-ascii?Q?ZC3tvVksyCcqWNa1M/eVEtiFDL+Rr6fe1wf2atm4qwep6kVMONUYRqFatdAS?=
 =?us-ascii?Q?tiQjKDgmg2L426WyI3hZHGxc4rJWPGaAjveNsXlvIBcBBkCVN12h00eAIAIX?=
 =?us-ascii?Q?OpGblRdIFcHxa6AdQBmSpubknzjn0o1WXbUbqKZmMeHe03GFMiMNYdpEm2Ta?=
 =?us-ascii?Q?sEJkgCRW8yVBIYCg1xSOhxDPPWArohmqNA8Eica+sOF4AEJuf2/cNOe0SeSG?=
 =?us-ascii?Q?Z5wLzo/k4Se7szbYRkCpwRvxfKjQzwGymDB13YI/xbakxV+eOa2rO5nmCxIw?=
 =?us-ascii?Q?VutYujl7+p9D+E4gX6LhznKnCTUC2VWkMpaX/iZcpmF7YjCydNXwSuuJw97I?=
 =?us-ascii?Q?A/d0iSdxJbjDsU3WroUkHICU+fUD0Omu8m88j1yc81A36BzTdNI5hnsynOvW?=
 =?us-ascii?Q?VzbjE35GzvXNCMeNkvkxfp3xW2GB4VSf87ShIf17QAZ2eSAnSq1S/Jh7gt4q?=
 =?us-ascii?Q?BfsXEUo5NhYVxvNkYGXy01Flnj1rg5QKjrNBwWEJrpaX78hfVWYLyx19Ed1u?=
 =?us-ascii?Q?Z9fqkQg/FykjdpuBD6P3AX6M5eodrRKoYCzxUfbbLvXW4rYJRqMnb3oQlX81?=
 =?us-ascii?Q?UbNaz3VRy/PIjk2s/PA8adMGC4SqrjUKjVh4dpSdjiMusy67lmAJZUAboLT/?=
 =?us-ascii?Q?sF5wEVyiVESPFKT1BfGGltJeY6aaF3tSDTFbUj7qrEKyk9HFzod1uml3VUeh?=
 =?us-ascii?Q?4ztZovLDLwVIXE45W1N5xhnClLUoXYlMsmfCmHOHZZR27RzLmM2dsvWMbN/5?=
 =?us-ascii?Q?Wf7nfx3p7HpphFbUi+CyUXZy2jGM8H+jqxfGQ9+jtImOkQtMuDmN3jWYNt79?=
 =?us-ascii?Q?5HBVTaugRH+a4BZMfvWp5jS8AInPnM1/jwpf1bz56ABvq3ZNdC+BgMPE2Xq1?=
 =?us-ascii?Q?hbdxveXgx6eExnVl4UpGoBnVbguYrrnlC/biEslRbYImHFjSjW+6odmpS436?=
 =?us-ascii?Q?rmtxQuUpFG04MjKFAZHw/AzHxHlPpNZnfbYMReu8M77XvoNJNHq/TmNgUabP?=
 =?us-ascii?Q?F2OVvRvZO4UCwcekXZVdNuqJmJ9U?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:44:22.1553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a87f40a-cf1a-494f-ebd3-08dc6dfc8bb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8550

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
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 6b713fb0b818f..fdf171ad4a3c6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1144,7 +1144,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 			goto err_unlock;
 		}
 		offset = dev->adev->rmmio_remap.bus_addr;
-		if (!offset) {
+		if (!offset || (PAGE_SIZE > 4096)) {
 			err = -ENOMEM;
 			goto err_unlock;
 		}
@@ -2312,7 +2312,7 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
 			return -EINVAL;
 		}
 		offset = pdd->dev->adev->rmmio_remap.bus_addr;
-		if (!offset) {
+		if (!offset || (PAGE_SIZE > 4096)) {
 			pr_err("amdgpu_amdkfd_get_mmio_remap_phys_addr failed\n");
 			return -ENOMEM;
 		}
@@ -3354,6 +3354,9 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
 		return -EINVAL;
 
+	if (PAGE_SIZE > 4096)
+		return -EINVAL;
+
 	address = dev->adev->rmmio_remap.bus_addr;
 
 	vm_flags_set(vma, VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
-- 
2.44.0


