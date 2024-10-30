Return-Path: <stable+bounces-89354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FE79B6B41
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 18:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08C71F2222A
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 17:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF9B1BD9FE;
	Wed, 30 Oct 2024 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vMnPQNLY"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3611BD9DD
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310407; cv=fail; b=T2K5BWfoKt5cSBSiPRfe8rJzJr5eRy/swlXznZPuUR4w3iq4kERL8Lzw0a7UMY/5slTDpbRZx8sZeJThw8zBwSSKa5oHn5bz9caTySa8xOdYcFT05QBsUduZXWb+COGAljk8fQf2r40wX0vBCiF+TohO2Jm1LmXWohLjEsxww8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310407; c=relaxed/simple;
	bh=4xPKXaXZ6URHV5WtU8h2gkxuMXfv+/y1vHJlcwYqtAY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YYtp//capPxLCsL6ZuoG8EalcNv2fC29HBHrUr486XpyluOVZAl4AT7gmCtA8jCvJT5mAierDD2k421qgF7w2yefheQZGFF1jSza0bTYCruWxCx003kWk6Nqg8DIYLlYxoeHhuvYJgs34grfhsbgwLtXJoP4Lia45c713VZhxWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vMnPQNLY; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKJnXFx9xHQa4F91u0uoTpDk9Q0btnMgiR2f6/iqbOCTArK0+2741tk74sXYA0SVpGII8g4c8hO3eshzvzFdx/1hIObpjZxY2+wRe4Rn6hrvG3wjq2uVUS8d7RIEyTp7HFkcs8DVvJGlB712hPebTw8Wp8tm8F3zxuVRA1NN0aN7RYff4Q8ls6Us+vNZC5vKUeykzb9AWe6aPeyY5YcdI29/vEnDLsDIcOD2eIKe6m6QdEjhVqNXS5xIBd1PnhK5B4IuP/lSUA/1NJp8HzaOjiD+nyJwYT0Yd650bjxsqdXWHbfvnx0MwrJ9MWTj9ui3ILaviz/jkHz6KVKDTU7MRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoXQe3D4g/7Se0Ohh31OsY4ew08xd4d07V13V4i+FnM=;
 b=HOPCrmeYCjHsxjpvxkmRulKu6opWkgo92M3XEY5YxS+5QpZpXakjnna7ump1hUIeJMCQeijaVMBx+TZUPpjPoJacZOFH+EAlRJrh1BDROjSWcocNdXAKlgF8LLTUZLhtEStkBeqaekZDnuyfDBiCV61wfilTWU4ARkXNFMpeCSvdWybHdfO1+YJ3pHs5oRriZ168SSvBFxdc7frOjkIrn0n2WfhkB9rO4UBYmOUGxU+gtfYRX3OKC4A64Yxu3ZQ4CXmWXt48xVZPv+VF9PD1KJKuPE/2XL/oXXu4XhkFM64lHpTPhRkTTVyh9s+WSPNWJhF9tfMTEVa+hCEAB+bopQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoXQe3D4g/7Se0Ohh31OsY4ew08xd4d07V13V4i+FnM=;
 b=vMnPQNLYH43naxDCRx+McQGZkOavsyH0nRC5Ma8qjaWrlxYLaY3JoRK2BY1S+ci55TphoWy06mSZ3c7Fb1B/u3Wljg/DJZfdRqMNwleHkDRMtxaVimovX/ftBPdO5dUXQkwvrJqSaLnrbcn+c8NWT9l7nYaCmMXrzIpAm/nnYiE=
Received: from PH7PR17CA0032.namprd17.prod.outlook.com (2603:10b6:510:323::22)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 17:46:42 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::aa) by PH7PR17CA0032.outlook.office365.com
 (2603:10b6:510:323::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 17:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 17:46:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 12:46:40 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: <Frank.Min@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix random data corruption for sdma 7
Date: Wed, 30 Oct 2024 13:46:27 -0400
Message-ID: <20241030174627.3215411-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b99f9a-4ef1-4e61-d58d-08dcf90ad03a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?odayQmcwyMhzvmYbQJ6R7+CS2qizhidM/PCKQ26/hg616R+58G4L9NUDNBvL?=
 =?us-ascii?Q?0ADPCVQTAnQUo6OttFo+RRlEgEqjsWNntrzSwlZFMTwP+blybbWLvDn0zQpR?=
 =?us-ascii?Q?f1GNvlgGYgf9uRHkbxAeFyP5/U+WbMIxPGOEf6OBXF3bbB8MEl3TzU+ILhB/?=
 =?us-ascii?Q?qZWpWhk71Rnh2m6pPy4s/3aR8fvemiALVXd9mzSqzQ0tyr/GjVEpuVAWq9G3?=
 =?us-ascii?Q?vNuSt8XPAqCvNpNe8p73xAnPIYZz7x866wRNLIiU1ZepKY0yf8FXFkSDzjh7?=
 =?us-ascii?Q?0M3TPruvSj/NvAjDNZOT4UUOSzipv+o6g06OJjJGx1JgCSyuzUm0adHWhZj+?=
 =?us-ascii?Q?mr93QkDREpNPrS2UllWlSKvQVSeGo4NPNEkHcs7CUyjkCZ6QhvzkFHzHcJ1Y?=
 =?us-ascii?Q?tjmOWB4Ovi8v9t+zSW3wsE5hF9UmMscNOGBwtvv0jK94NS1BKOgkyPgK5lS1?=
 =?us-ascii?Q?N/bACU7Nco0VIj3y0Hndx/gqFx8vr14JFNWyOs3+U8fZureoswO8OqEYeU2y?=
 =?us-ascii?Q?G4W1s0lRfDOFuISPHHkoobbfSEB7Bn31EzXZ4m8hG7koyaX0yJaig4+7AdPs?=
 =?us-ascii?Q?KMGq+3MksCpl5quCh5xLR/cI2Pa/qYKZmvnTcfsib56yqb4SID+lF/PVn5C6?=
 =?us-ascii?Q?Sd5TIA+DHc96xz0Wz+1L+LAxqVqK3brEB4ZlS/UOQ/nWrDmH9k0JEHmSXNVX?=
 =?us-ascii?Q?W/kvEn2TxVHZLpJBWRKR+oQ28v9Al7wnCQqC9Q4dWjDU4J3P3U65iAfRTz/o?=
 =?us-ascii?Q?yPMZcSlRmGqVdiDBTcypd7FHwT/mzsWnt4SJlgp1/eQLAIC0EAduzbozy+ma?=
 =?us-ascii?Q?dKTnG4yIn1qhUERpZZUFkZcbj6ZDmY4IRl3P6Mptsnog5futHMmUt7HvbtBW?=
 =?us-ascii?Q?xWxNB90tlJm/dGsC6UtUcRXEbWSqktrh0yfLmoS/Tic6NfrRLIAGQzy6FKIN?=
 =?us-ascii?Q?bgHKrvYpLecLUH6MkGGdkgBLfAQ7l7NeqWiltkJCRTkRlIgdJMCxc2vQ3BTT?=
 =?us-ascii?Q?8PVnCY4iAw+GAylRsax+W8kiVEL7dBKCaCWLcHPorNhAQ11twyFFdPqXYnzz?=
 =?us-ascii?Q?pPX9jFqVjbbeaNkmTpdQ+UZp+4y7192eOCvEOQtWkb32o0fsTTobd9e0UOfi?=
 =?us-ascii?Q?x9W4Uacx5l2kiVqL0vCvWd9WHrwukHB2w/u5i1DTAVGZ6HF1Pc4njben6+cl?=
 =?us-ascii?Q?it8HBGP0sdveTzYeHniA9euFaNGN6eY7dudaYsuGhTKgJYhLcadg2v+paaUc?=
 =?us-ascii?Q?Izx3XXzU6jfcREFjPKy6bm6hpTFQy/HieFov9F29cKrAuEfznJRAtqMswxXq?=
 =?us-ascii?Q?LVDFZrFpI5S9+a60gzajzDCC7SYP+gJYTxnp7vnhnBXHRqXcItWYSmXaN1ec?=
 =?us-ascii?Q?uttw1mfXG5k+ka9mJdyBlzg8KZ1SV9vaDrXwmr/zaKiB+sjbWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 17:46:41.6867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b99f9a-4ef1-4e61-d58d-08dcf90ad03a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112

From: Frank Min <Frank.Min@amd.com>

There is random data corruption caused by const fill, this is caused by
write compression mode not correctly configured.

So correct compression mode for const fill.

Signed-off-by: Frank Min <Frank.Min@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 75400f8d6e36afc88d59db8a1f3e4b7d90d836ad)
Cc: stable@vger.kernel.org # 6.11.x
(cherry picked from commit 108bc59fe817686a59d2008f217bad38a5cf4427)
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 403c177f2434..bbf43e668c1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -51,6 +51,12 @@ MODULE_FIRMWARE("amdgpu/sdma_7_0_1.bin");
 #define SDMA0_HYP_DEC_REG_END 0x589a
 #define SDMA1_HYP_DEC_REG_OFFSET 0x20
 
+/*define for compression field for sdma7*/
+#define SDMA_PKT_CONSTANT_FILL_HEADER_compress_offset 0
+#define SDMA_PKT_CONSTANT_FILL_HEADER_compress_mask   0x00000001
+#define SDMA_PKT_CONSTANT_FILL_HEADER_compress_shift  16
+#define SDMA_PKT_CONSTANT_FILL_HEADER_COMPRESS(x) (((x) & SDMA_PKT_CONSTANT_FILL_HEADER_compress_mask) << SDMA_PKT_CONSTANT_FILL_HEADER_compress_shift)
+
 static void sdma_v7_0_set_ring_funcs(struct amdgpu_device *adev);
 static void sdma_v7_0_set_buffer_funcs(struct amdgpu_device *adev);
 static void sdma_v7_0_set_vm_pte_funcs(struct amdgpu_device *adev);
@@ -1611,7 +1617,8 @@ static void sdma_v7_0_emit_fill_buffer(struct amdgpu_ib *ib,
 				       uint64_t dst_offset,
 				       uint32_t byte_count)
 {
-	ib->ptr[ib->length_dw++] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_CONST_FILL);
+	ib->ptr[ib->length_dw++] = SDMA_PKT_CONSTANT_FILL_HEADER_OP(SDMA_OP_CONST_FILL) |
+		SDMA_PKT_CONSTANT_FILL_HEADER_COMPRESS(1);
 	ib->ptr[ib->length_dw++] = lower_32_bits(dst_offset);
 	ib->ptr[ib->length_dw++] = upper_32_bits(dst_offset);
 	ib->ptr[ib->length_dw++] = src_data;
-- 
2.47.0


