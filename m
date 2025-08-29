Return-Path: <stable+bounces-176728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48109B3C335
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 21:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F2E46198B
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 19:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D32221543;
	Fri, 29 Aug 2025 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n58h4ZjN"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65700244669
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496242; cv=fail; b=D8VTjUQ0KVR0lyMPDUFjG/fKPcWD5iRPKHNd8syI3OUxTe30SDU3MNEa5IFruyg4wsyzywBWKS272qsGOYpHqsK0KU9kv2plVTMAUyYMz08QuCzxewfcGgWKDg1/+T3/u4w2gt8CqdAFfbSyKzFwxIouah/8OSNV7LT6mAfB8u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496242; c=relaxed/simple;
	bh=ucac72Pq/MxeLmY9YiErJHOqQ286bc/4JKgLDSrlRTs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C6TECxaUxsZV3YivvJ+zSIVJMU0/u5UcMlxbBBMtE+oHTTrS8gl+GT54wxiRXK5vtlpccrHdxPz0Dk2MsnVlXhk/iFeOeg46oU6mziqKmf35obdyTQ5S6cWgY3AoHXJebZmr4nToSu2p88sOsLhil8c6Ik879iH6Wx/s50BRua0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n58h4ZjN; arc=fail smtp.client-ip=40.107.96.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3N1OOo9lAq90wrWnZFhaTM4H6ttIy76oY8GY6asFUUAaetW5/IIQ4vXR1V2vfi6jQXCsI8CFa9KyRLQ7JLiWkW7SR+zxlasfLC3NLjXyoTzDiJB+wjqxEVbi5Hdmil+oucrCARrx3UiPQyNcqcecmWQkaFIQa+riaE0Y/WZLWcgi3N53ug9jHQ9wKS2vORJXsjvQn6WNiSAU98jWUrW3rrxVfgSrM3r9Nd4tKqf1SQfOAVzwrO05yY/17DUEJpyi2Zx9U7nSuWt6mBMmMNOWmNCO1cYBumbjgws08SPmQaH+jyESjxZIeD4tJ1J6sfeIP7MUBYzyy2K4sK1o6Dlvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4TEuGAztE+9Oj9auNOE6BzjnYsM1o8kcKZGooUIm7Q=;
 b=ojNlLrElC4kabcMvIKa+Jx9vbfybPqfPINKzbkbUF7sokK3RvAlFS+TB5r+00sqj2nHwHe9if9PUxsBkfXKgeYUC6GEH2a3Cv21bDGwCKBleF1KY7kb2NHWs6Ej5gcCJgba1WzUP8vJcLOpwkvastFTDuyxhG5CGGr3TuAIL+PpWD96zz7ODQCknrQh+j4guBzwkPy1/0JJmd4zzzG+GbklffASIN5whxUfcCOYT3qMeX4T2MBBjsRZHVgJsUw+D7OyZTa4nZrvaOc79vMOYhg1qQGJR4c2wxVS8THDtOSIwJtv00LttMyeb/BfjxFnOEmPrPcgGwqaxNOltFc2DwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4TEuGAztE+9Oj9auNOE6BzjnYsM1o8kcKZGooUIm7Q=;
 b=n58h4ZjNCuklTi+O7K2nJcULHbcQScGRIrvnYNMx0Rr4P25SVKOiCJpDZIRWz38NcLAmx954mk+1ppV4F171EGUpCaMRbimOlzNcrj7bcOyIJNa0tCGtFFXaIDF5tXJEJ+YqUJL/WadgQ6zvZksx1GpWlGQxAQwYrAPbG9d/LlI=
Received: from BN9PR03CA0116.namprd03.prod.outlook.com (2603:10b6:408:fd::31)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Fri, 29 Aug
 2025 19:37:09 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::5a) by BN9PR03CA0116.outlook.office365.com
 (2603:10b6:408:fd::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.16 via Frontend Transport; Fri,
 29 Aug 2025 19:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 19:37:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 14:37:06 -0500
Received: from tr4.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 29 Aug
 2025 12:37:05 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: Avoid extra evict-restore process."
Date: Fri, 29 Aug 2025 15:36:52 -0400
Message-ID: <20250829193652.1925084-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf81478-51e7-43f9-8af2-08dde733714d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pzduSPwS4Cn7Yjer/3wgygMepksdFkMoOeaW9p6Aul3DEME4LKJ6eyqX1ux8?=
 =?us-ascii?Q?tTSNgkHdWF/1a/zhz8IJ4z4+iXcgFQYnoPN0zlARjcfSQ9XVqRBqEpbD8pdQ?=
 =?us-ascii?Q?ublIo0Ej7BT17Uiua1RYamJcEmuSSrHHgWclNmscvx3Ip3PK42dCXyMN41Sr?=
 =?us-ascii?Q?XwzQIOu8DF/KYCWCOiUQ6X6aig/2UasH669H//I7XInY05z5RXr8flw+G7AW?=
 =?us-ascii?Q?GAeCKV46kTPMnkR7nC+0QG2iGXoTyiyhRlgdbzvzbchVpccFiomdHbejr7B2?=
 =?us-ascii?Q?YNAlOoSOk1yWdB5ODSWl1tj13aHL+mlW6Fi31rA2syagY95T3BwAqSAcbhE4?=
 =?us-ascii?Q?KaMqZqIXeILzqtXU/Ft7jTyUqJGjg4ncISgZhCpdGN40FYCsfMQn6uP0v0YZ?=
 =?us-ascii?Q?VQdrmT7kRXT2P0biGmKlXGJ+mpiVM26AajIhrdbCBjdmPXq+hf6tuPPoqxkh?=
 =?us-ascii?Q?OCkFA8UYvUbOR7haxgfzlrLIY6VIIDIBBchQCP2OgPXmf30DdAFISm+M8ypn?=
 =?us-ascii?Q?Vozl9PA4UO8v7N8KVEEl8xBpqx7sdSG/ikDVcD5Gc7EWGejHhIsKcWtwX75O?=
 =?us-ascii?Q?tdnsQ6mzySigNbsYPgXMRzDKk08Iejgao6/rJDtVWABj23Hq7ZfhsX7RkOIe?=
 =?us-ascii?Q?seZIbCklwWYnpPhR0xhKLqpioLlOIXSbG/whht7ZuIBpmc5CuIYURNdf2wQp?=
 =?us-ascii?Q?96/pT01yQoik8i3CWuSu6hZGFfQH/PtpH+M9QXjRX0mv4YYuUxw4ZN2xzd7e?=
 =?us-ascii?Q?Hq7h3JRVpGuL0FWk24eW7uQnOmWelCWqOghFaUKDyLw95EKeA/sEu8qWyiT5?=
 =?us-ascii?Q?+RoAwLbGVyFMywDeIliUH9pNgk8kBEfdsmLJghfUNOT3yUR531WyWgA//EL+?=
 =?us-ascii?Q?ZUJQBH2RqeExBCQV3MUmZC7dL0vXKj93K3/nqS+FhyVf6cTwetjsG48oNoIC?=
 =?us-ascii?Q?vWXrTu9p26jaf4oLAtCInfPY4Zr5WSuZw/AukBDxWdi73jmjBP3iQtcApUO/?=
 =?us-ascii?Q?YLxBUvbi30/MFdR7RvA/DlrlZp4gl58Jm7WCYCW5OE+S8Ozh+zHulbtGif8G?=
 =?us-ascii?Q?pWbet71B1AadwMoMj9fmyort4EU4nzutvWWzuwmKEbEIW+r/coPc8kpylxSd?=
 =?us-ascii?Q?HA1ryX9uk8Nf8IYCWEkBWzer7b8ZE6ZuVrfwRvVFzqcwp5i0i48Xkb9EDg5f?=
 =?us-ascii?Q?D/q2Yw9YN6qpnzY82WyK5eaTWQnZ3QvAXVpuVpIe7LD+snhN6ptmv9hM2T9R?=
 =?us-ascii?Q?T6qQhnrsIMNKatfDQxTTm0H5SAKaqkNW1pb1WY+nA9PJigj06xU66fkYzs7e?=
 =?us-ascii?Q?YpuhYggRrOiMSd2IKimYpO249M5uj/ieV3ufgkthhpw1ppcbHazrS87e4kaG?=
 =?us-ascii?Q?eg1+xLJUlpZuf2Cj8sgVgsjoOwD70Hlyvi206qSkyhyIfCHQQ6tjsuoCWG2M?=
 =?us-ascii?Q?VfP0smjHMJ72EXNmZiAUd0paeXXok2weyPIPUQOOwkIJzJc+agJmPOgWhh11?=
 =?us-ascii?Q?TetqNjTV9dxcy1EwtX5wcf3Cv7smINtBvf/4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 19:37:08.6310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf81478-51e7-43f9-8af2-08dde733714d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599

This reverts commit 71598a5a7797f0052aaa7bcff0b8d4b8f20f1441.

This commit introduced a regression, however the fix for the
regression:
aa5fc4362fac ("drm/amdgpu: fix task hang from failed job submission during process kill")
depends on things not yet present in 6.12.y and older kernels.  Since
this commit is more of an optimization, just revert it for
6.12.y and older stable kernels.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1.x - 6.12.x
---

Please apply this revert to 6.1.x to 6.12.x stable trees.  The newer
stable trees and Linus' tree already have the regression fix.

 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0adb106e2c42..37d53578825b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2292,11 +2292,13 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
  */
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
 {
-	timeout = drm_sched_entity_flush(&vm->immediate, timeout);
+	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
+					DMA_RESV_USAGE_BOOKKEEP,
+					true, timeout);
 	if (timeout <= 0)
 		return timeout;
 
-	return drm_sched_entity_flush(&vm->delayed, timeout);
+	return dma_fence_wait_timeout(vm->last_unlocked, true, timeout);
 }
 
 static void amdgpu_vm_destroy_task_info(struct kref *kref)
-- 
2.51.0


