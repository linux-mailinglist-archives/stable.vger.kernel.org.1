Return-Path: <stable+bounces-69248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C1B953B16
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 21:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2CC6283B95
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 19:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB5C78685;
	Thu, 15 Aug 2024 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IqL+wmkl"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9057C5A7AA
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751346; cv=fail; b=r8wjemHka13bzbQ1IljFLj8hE+ka2LBt7jqb131+WsFGbKRBK7n+k3H8NBz74WwDrbYvn5yjfwsjJxaQagA/fViUVj53v6OzzCwczFBOX4p0H6OC2pr2Xuzpd6dqr9oHQ/HAfrG5iEu1z/ESGdD4OYdYTrZ1RkDdUYrTE4xbx8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751346; c=relaxed/simple;
	bh=7IGAdRPkJqoUPsL7JW/WH/JNRFRqyW6MqJNRj2H40Co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPyb6rnNBB+dFZeBR/5UI8cAOIZym2ejxpwnH8fEnqHY0kyUs4tVtLIdVQQ6KjG75S5aXT2wGcFlo/vXwNEzO20ppA3FZICaa9eea1j2wG/I2XF8/rRU3j16oeliUTAK4YqYGMjDLPKpsaclG3abJMfupJo1YWJxM2NwB/jYA4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IqL+wmkl; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXVTzehgxOBtW0unw8dBMxIkv/y/VaywjCM+50QOKrCI7q3WEPw/V/EZ577IA9yPmlqyGX8zV8UunwQVyYSmF0aNZ0507DGNhMIOrxTnosGFGVy670rChL52ffNSgDbSPWq45vkrZhNq0vEauiav0cK31U7+u0/0X6WwNhY9gBeXn/3yAMvYekmu6/1d5EcPx5dSNkmQUDAkVWemqlIFRCEH8I5wLfUMOGC77Erc/wzkKqs4gEr/2feI2Lf8Ofqi/G+18q5csSPueHh6LwMPH+orhMjBlZGW2eHKXRtL4ELcAQsGwErZT/Q9LK0nTJrudv/Htg6ntN16yUzkQNUjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9KeYive6rHVlChMBl+4IGMttDYZeODOuIfR9vw6EQQ=;
 b=w3DizZM0XgX5LJDZDd0+DbtEbzXAbcLgYD4n7disHzhSN5ZawVxmaKf9jieDgBssgBSS0l4E6ih77MLrLIU9ufwPmcOdQ2ujmZEBcyOw2in7eK22NrjQE05o7lgQ13l1nvEEjgcGIfvE9WeDZbO8Kq1PxiRt4u2T3bskuAs5gO2CU6IJQwz151sHJg4KITb+FPSxLCh3RNEHIF+9LfnxQNkGdfADMzvGMEKt0bWCpP/qPc1JPIIEaS+aH54v9B9RK4i5fo5BFABL10ldQbOZklN/i6v66U4gpvhhSDQZpuO5uvZUrTDyA/fTCWgZUq3ukVZ3sLhlk22qdx9++QAGgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9KeYive6rHVlChMBl+4IGMttDYZeODOuIfR9vw6EQQ=;
 b=IqL+wmkleArVCOmWSWJU2Gk+3hGvItQGNN9NSFvI/lDPfAmIsKdEpwAs2MicOWIl9kEeATllG76/U/JvUzQAMtWOED66R+uHjePEu0faib7CbUoQ4y+w6QNpptUluNI/FrQdrWlM5vdrq/HS7H1jRgjZK4qm76IPu+/ssIU/lsg=
Received: from SA1PR05CA0007.namprd05.prod.outlook.com (2603:10b6:806:2d2::9)
 by PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Thu, 15 Aug
 2024 19:48:59 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::83) by SA1PR05CA0007.outlook.office365.com
 (2603:10b6:806:2d2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.7 via Frontend
 Transport; Thu, 15 Aug 2024 19:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 19:48:59 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 14:48:59 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <stable@vger.kernel.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.4.y] drm/amdkfd: don't allow mapping the MMIO HDP page with large pages
Date: Thu, 15 Aug 2024 15:48:40 -0400
Message-ID: <20240815194840.2074881-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024081204-stylist-bobsled-3424@gregkh>
References: <2024081204-stylist-bobsled-3424@gregkh>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|PH8PR12MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: eba01ea2-1781-4d9d-9cb6-08dcbd634e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kUTWbcStf1MMEbdjjsQJKVp9MkzxsUQcan5/XnB9GnT9Mr9/U7ocyBFlmEOA?=
 =?us-ascii?Q?2oE0OYKURioSa424DbAZFTdRUS8XKNjqDNEPulS25oKWTctGHDulWzbBXX+c?=
 =?us-ascii?Q?VWSRjS6AL9ZkiXQ+TZMhiKYzielBrUqaPpJxnd75AYvQfRNPq8p2BAPBAxcm?=
 =?us-ascii?Q?RBOZc0WfEQDTm5m7FA5WAuAfrDFffooJbIeiKw9/1wzhjIszcjoDqPdwZt8F?=
 =?us-ascii?Q?Py1ELAq64mf0xJIcldRNtD48qlbK+c1JZRTkQqNRc8PdbVyDBo/cO81uTs8a?=
 =?us-ascii?Q?2ccLVgq/V0pRGbuA+kEDvFjxljSwhEv049eLwB3CL9iRlqJRYgorUrxeau2j?=
 =?us-ascii?Q?pTCq2X7i9/pDiwn75m1h4fjk/RYDGpXGaFHwKiEd0uHECbQSKnx3kJw6ngja?=
 =?us-ascii?Q?VJvNnNTPb4N9ykxeHeCR9IsGbs/9GjcFLgfWWMkMRiiQt3D6AnkWvkRXSNcw?=
 =?us-ascii?Q?SALnIodXFoj4eTnUFsOE00EpXVfcHXoG1AUOLq+zlPrPTb9GwrXz80WokK2d?=
 =?us-ascii?Q?Sf17cXPcR4Wa41mso1HA+nKdL5Lvjhw/gYfC2srpuPloQRqMoJY9G0j0e5VS?=
 =?us-ascii?Q?N6VzMzjuczWHaQv7knzJF1tPL5pXt3Ch1tZomOWac2bPWHkic1T0XJTUxFYJ?=
 =?us-ascii?Q?K1KNCw+5lcsqQGc+b8QQcwtMR9PBt5ZcbhP6TjrVZbSGJuAr9+S1dXv2JSEv?=
 =?us-ascii?Q?T0sGI268UGKDZ3v4K/XSHGnUKyvzhG0a9ds3lD0lXKWMpZG8SM1CemrcxEBj?=
 =?us-ascii?Q?mbpwNHUUpc8UrFyKWjQZAz8aL9vYe0SrsvqB12SG49FAVyiy3KlG8hkiMd0o?=
 =?us-ascii?Q?+TNkpNIFEG2FQaFVvxWG3SQnvnbj0BY/wUmwbrSEyJOmB6CuFmPl49qAPMhS?=
 =?us-ascii?Q?UKR/eml0RxzsF0rZyf3Nb20T4+3WDlDgmM0qyb97ot2RD/Glbcjp0U5R8xsD?=
 =?us-ascii?Q?dAmjqHr4EI5oGUQY4xwmNxUUNxf/mhJr+22FSY0cmrO8kOjyJs/cKJ7n5p6j?=
 =?us-ascii?Q?KjieP9pGsH9J4rq84+LZpK5KyfC4jYxz8aQB9ORHoii6WBQRKjo2L6ninD1v?=
 =?us-ascii?Q?gjP71YYVrB7Tbf/X/6J4l6NBvX/4xUfwIkt4b+jMStoyjdgp+7MenlILN+HF?=
 =?us-ascii?Q?Cn9zHmUlznZj0Ge+8fg9Lt8Sd+MHDxVsWS0J0+YjYE0Z1xONPdAe7x3Qwhrp?=
 =?us-ascii?Q?nQ4Z/FmgyPyCIiDhb5yRW6g3k0WoV5KGHu58rp1jJAZR2x5V0E8hps1KtplD?=
 =?us-ascii?Q?YUNUzwRaHTk5ptJTwsD6Jz0zyEyhnWXGgP9KVSLCg61zCj83Ukz7pimQoEj1?=
 =?us-ascii?Q?CyNk++isaAuHXZPVEb2Zeqw9MpWSS4lsgeO5SkXP3j17zMkvYxElS5z4omtc?=
 =?us-ascii?Q?rsqRWMsmC6pAAbvTYcWne88W4VpDsVSWiyGM+Mg17Faar6xq8OMANcp8qOUq?=
 =?us-ascii?Q?G7SUd7tEYmWHqP9mv+Slj5ydUN3P4Gu7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 19:48:59.4663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eba01ea2-1781-4d9d-9cb6-08dcbd634e74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110

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
index 990ffc0eeb6b..b99e6b2e0aca 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1278,7 +1278,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 		if (args->size != PAGE_SIZE)
 			return -EINVAL;
 		offset = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->kgd);
-		if (!offset)
+		if (!offset || (PAGE_SIZE > 4096))
 			return -ENOMEM;
 	}
 
@@ -1872,6 +1872,9 @@ static int kfd_mmio_mmap(struct kfd_dev *dev, struct kfd_process *process,
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
 		return -EINVAL;
 
+	if (PAGE_SIZE > 4096)
+		return -EINVAL;
+
 	address = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->kgd);
 
 	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
-- 
2.34.1


