Return-Path: <stable+bounces-69246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA44953B12
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 21:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21424282D27
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 19:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3C1762EF;
	Thu, 15 Aug 2024 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="csi6qd4Q"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F5B5A7AA
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751257; cv=fail; b=hnnttAlak57mfNNUWT8jZ6GreFsZgPc8b++wZAAlH9GdeE1O56lruXPl/aLBOwKUiXEWZoZUftO2bOzneDj11AQu+y46dnmZFqUZg/OwsQUaIjygxl73zQSOIhnBqWaKE44cg8wDLLaMQKLOHuapwzJVw5UeJqv10NXKYWYYtds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751257; c=relaxed/simple;
	bh=KSB1tLalkipiHtR5QRRkCZrYLmFE9tkkXjFCjI0UaUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K10rAD66VwV2vBJ1pXJvmJDe0b61pCe76z3Wf51pADJAxo21sSIXx27nN2zy+1LHN7Ak+xnexH6zLjNWW5LMnvMaQDIYbQbVyvGI1XZpqmgGFM3d/EE2GXKR2r/UPFOAR7GmuDBxnXJ4F3P3HNA5PBhIX1E8ar8VOcEk2HH/VwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=csi6qd4Q; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwUsMls2spwteToz4jFFjm9ZAre7gIAm9Rv0hgRyDVK3GUyogarE/Fk9w4sQPma7xTgbCeF1v6uE3YdNpFLT4J6bG47k34gvpRZKQ8SQk/bJCrazXRX606QT3wtC1iWw5KUjW0PcEYrEHaJtXNgVRpENzY59Ax2xeQUPqXZyO8gTUXQBOZ8zSisLA8f3dIQwfRCQY5At7U5PrtlFEKnQHPE6nsgXjvcTlAC0p9QcPMq+nmy3rEqwUS4lUcnAnI/oqj0xnQRCHowPBB1pItRmCSueit9Y88dg9oshXNyvKIv0ebTvWH8pbPCemwrETJzqn4o4G3vkKYHi6/uvDzrUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdfKUKWNXeqZ7uRu4vnKJsMNUltfljrzoMLkCHdDPD4=;
 b=jvPzn5l4Fc8YPMs45JA9FT4fmzRguVaSHbJYvUx/qAZmA8SH9OFvyheJVxPeqGhG9ppWGU26+VDfN7sPvfRxakpqwItm2gCZCZNhQ7cA40oLTRGJTjbUSDUTDQDQTRSTYWsjlfRdWS0Ja1rEAC3k9OboxDQeRO+wGjYGk5b3zJtZGuDLl+OuF24PERhdmI+URGXXbkh5Ix1mLTh779GCahVQ+9gF00XSoCvnVfG6xzZ53w20QacGA7rfT+Rw6GE1BjhndzpGJqOH7+8vWUZd9ZM+Ske6U7g+jUba5Db3aP5GpYJFp/hDs9Ujt74i1PHdY/x9ewdv65cs5w40HnJ15Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdfKUKWNXeqZ7uRu4vnKJsMNUltfljrzoMLkCHdDPD4=;
 b=csi6qd4QsZ4X3GK+o3qEuRnuJ//1/fHc4kT6Ks1BYFk7cIrMfrQ44Vj+vJcLKYBxXIkFKKsvlNac1T4mvH2a/6TYPS7V07sI8D9jRgy6goZyXm0CHOPhs8HFax7gMCO0Vb1t332HWsihnTPO/FRESRpc+l0ql81fpEE2ebAF+Vo=
Received: from SN7PR04CA0090.namprd04.prod.outlook.com (2603:10b6:806:121::35)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 19:47:29 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::51) by SN7PR04CA0090.outlook.office365.com
 (2603:10b6:806:121::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 19:47:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 19:47:29 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 14:47:28 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <stable@vger.kernel.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15.y] drm/amdkfd: don't allow mapping the MMIO HDP page with large pages
Date: Thu, 15 Aug 2024 15:46:29 -0400
Message-ID: <20240815194629.2074349-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024081202-hastily-panic-ee65@gregkh>
References: <2024081202-hastily-panic-ee65@gregkh>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e203001-c9be-4bcd-65ee-08dcbd6318bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E7YqgAM6UjmSavKYeAVZX485KC+rPB63VuaBvMJIXUxxiznGB6CI01YGW4oq?=
 =?us-ascii?Q?auLbPkxMZJkaXFrVsYaUqUkHxS2BEc9NbCeOAfJcB9KVZ0oKTNIIrNB6DgKo?=
 =?us-ascii?Q?C3MjDlnhGmrAyQDBL/NmTDHklssKmjHpD2+d78mTGVN6j6HA74kWZS3g3XXR?=
 =?us-ascii?Q?K+Ov8bvCE31nKoet8B4Tl1AT0uBvDQkN8bahx30tyb7hyT55+bYLVGfEqH04?=
 =?us-ascii?Q?HfHcsiVvzOutBMHVX01DrwpfXIzEJ//9f0VWKLKPy00rczbhlE0EWcf0HQh+?=
 =?us-ascii?Q?MPLLXKZ5/yAy+uxF/SpKeir7FL5wjzLOXuBhZw+H1JzTmaKZrCbzKn7ZDFWf?=
 =?us-ascii?Q?RzHpZrWG5c4sh0LIIdzgNvsHat7jeUjvyhzxP4PJ2XBzKf2Dzpou3NY5xpKa?=
 =?us-ascii?Q?DAz7yqsnVDapqNYxU9lZZcAVe9RZZCG4mIka+rYD2ystHkTXjAVmZIFsmHpL?=
 =?us-ascii?Q?bbk0Ei729a3yp9tnV7vaCXb0fgXKdR53TJtS/Ol9S6xqXynlQawKDMyCxKck?=
 =?us-ascii?Q?z81LKrpcCsbXhKF7JngqEM5nj86SXCNhDvGkIoUQYegg+lCSpPS8rcuEkGM+?=
 =?us-ascii?Q?X2A36QP/mPhnpFcSaNpm5MGgCpVrla2v9KI50ioqojuAsDjHoE4CdWrMUiUa?=
 =?us-ascii?Q?YxaC71wbIl1SynAdYwfi2adyMPg2GQUjfM151Qv8KcAiGqH8nneakUP7dKo6?=
 =?us-ascii?Q?n0uB19WYE7XlZltX6Bwz1nPBtpF9MsWUg8By3YMh8mNyHMvezms59xOFpvfA?=
 =?us-ascii?Q?JWtqC4KjNqctmr+aHoTN3RuVbqBnQriWrLkJeQiBUOSsYH/LEDAyXihr5aVZ?=
 =?us-ascii?Q?tJkmXALAZbD+G6MvXkpKa18EQhtbilVBW9NaOV1fOHD8OMgcSErF+damZhZM?=
 =?us-ascii?Q?jgRj7SZqnGSoJzCjxS50qHuJfBO4D0D7igXHasU5TRWKVWDQXq6cRK9kDtNQ?=
 =?us-ascii?Q?pX+WXN5kOjYH4SofeuyN8rppZpZqyxY/zZNjrhXeYVpk4QGRGyPdbTTOyo3x?=
 =?us-ascii?Q?k4QxceBCSHiaNOYuNWf82xNXsj8awCKpKgRBWW0+Pe/G7Kx3RYfSxQWIG9XA?=
 =?us-ascii?Q?MXW0IDstvRYBuRSustVGcypJqY9AcxFOEiJMIh2Lnz48C7HTVhhml8XtQIow?=
 =?us-ascii?Q?9zieiQ98DKtvzVCY+crIw8YxC3RAwuPWj8rDn1cCJukOUiFVL24ObGUR/wZB?=
 =?us-ascii?Q?jEKh7bRVEesbEtt0mQQ2pMwi0g3MT2sI3QDS7Dovog8qSjWz29DDfuYXR6mS?=
 =?us-ascii?Q?vqagoIxkZU3dtj5Ui4SaJt8INJVEucbtKpQCXetTl4DfPdkIj6yS7apvZ4jW?=
 =?us-ascii?Q?00CrLr/0svKzegtLFva3IflvvyRzaOJ/Hq+UrTamYenElrBAH/5Et9ilMHcR?=
 =?us-ascii?Q?YPvH07Gw7wI+3En059e4uUugARUCKsYK+eIvoY4aZUrzQiarbtBPFd9Jduvg?=
 =?us-ascii?Q?AyS4JD3gpw/9bhlTB9uVeAdiNkMQXv+0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 19:47:29.3242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e203001-c9be-4bcd-65ee-08dcbd6318bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712

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
index 88f9e1aa51f8..34c466e8eee9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1290,7 +1290,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 			goto err_unlock;
 		}
 		offset = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->kgd);
-		if (!offset) {
+		if (!offset || (PAGE_SIZE > 4096)) {
 			err = -ENOMEM;
 			goto err_unlock;
 		}
@@ -2029,6 +2029,9 @@ static int kfd_mmio_mmap(struct kfd_dev *dev, struct kfd_process *process,
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
 		return -EINVAL;
 
+	if (PAGE_SIZE > 4096)
+		return -EINVAL;
+
 	address = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->kgd);
 
 	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
-- 
2.34.1


