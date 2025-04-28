Return-Path: <stable+bounces-136906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2963CA9F503
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 17:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9D516CC81
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518AD149C64;
	Mon, 28 Apr 2025 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ydtadeex"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A5727A11F
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855763; cv=fail; b=Ls+L/l4EtHsHgCRtvqyeyXI53de4s2fRO/8CmqM8fmmM4rjL8I2aZCA4w55LhbKhXuxX3B1R6AtD8zirM1QkSc1wOma1g9Mh2wmpHHYlBemt4ymG7rYA5vw+QBnY4bBtBlg/214gxRd7WggPsLlVc3XKhZY/ZcUHpbJNeJthFgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855763; c=relaxed/simple;
	bh=4CBAHnSk3V9qgLp7xlMvB8l1avQXgG/+7GN/jGCLT3o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fI5T8+Qf6pWuMKsXAZ398RCPqIJcJEB55t/cnHPU89DK8Oo2YekNa26FkK57UtNEdqes9RHIm5Q5ougJxlOJle/v1pX1aF62E2u527bscWpIN3OnRnGxSBFiHdSg/JucL0Pa95s6oHpzqfflh5euFQfinGYL0I2SzzsUGmM1gV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ydtadeex; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSuVSjFP0OR1Dm2YWFZuL6Po7cMghotox8uqPHAbXOoD7kIVPUuVtMAQZPQs3qhOqvAH000NoqNvMNNSTqLi/ubcTaHd6BPT2OWW9gDa8ZCm6P3X91ja27QgqSjv/xHDW0yk8YUGbi0wJ0MMAM2dQ4tJdskgk9HBNhCLNo61jm8kITfZ1yz38IM9yCU2+8IRSXX3fQ3c80vg6nUIqKfYO/HjK0AcYOLvZvLwe3DxNdY0qC+ahoZ8g0EpK/QjTY8OBTerrQuIRikdqyhD4tmMJWK1naWM1zxSO7gO8ZO0zaU5a0rU9zgZiU1iBTb4zD03bIMvFhsqKSEKXa1LsU8e4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaXwi6MOp9+q4ZzHu9SR7UPDSlrYf03nRQf+K/OU5M0=;
 b=DqxJkxrs/SBQVVc4aNYBCWgVMgXdxveW70WbefOX4rBhUmMMWnlgTaCuNA++VL47C572VVw8I575ugwzr5LyyEFQ3J1D3KvW2ah+neGZhXNkUSiAQe2QECyhZ1lNG9VF4NylluONEl4NJ9bYe8e3KGJA+/cKdyQ0UdtABt7FJioy7KWNnxgqk//mziwAbnEv5XbEcdpq92s7jywOPIUfvzWk+DfyS3zppmu4F1ndCL++6kdiE0OM1oDQ4dvHzxu7mY2r7IM87lI08Ggq2VX82iYm2RlixI7QTrumjxW2ibOGz4tX2dxheLpEAezavUWcsWJaMUOYdAEB1CC1VMmNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaXwi6MOp9+q4ZzHu9SR7UPDSlrYf03nRQf+K/OU5M0=;
 b=ydtadeexh04LHBjFvh1Uk5qdarLmbDzjjVaM5pNO2cvQIBF8hGw/WY+IWQqefD5t4XXbs8NY5718A2MH0m5VK0BkqYydp6gJX08PEMMTBNFW11edmoyGm5vpb+P9kG04rJFjuXVD3oEkaS77DmE79x8THSmaWLQtweOP/+Lvhb4=
Received: from BYAPR07CA0087.namprd07.prod.outlook.com (2603:10b6:a03:12b::28)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Mon, 28 Apr
 2025 15:55:47 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::91) by BYAPR07CA0087.outlook.office365.com
 (2603:10b6:a03:12b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 15:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 15:55:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 10:55:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Denis Arefev <arefev@swemel.ru>, <stable@vger.kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: check a user-provided number of BOs in list
Date: Mon, 28 Apr 2025 11:55:13 -0400
Message-ID: <20250428155513.915888-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: bd695168-787f-46f9-9d51-08dd866d2455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emNrMTdQSksyUFdSTTh4aGVyRk4zdWh1bkpCMElyc2owODU5L21HWDEzUWZm?=
 =?utf-8?B?djQ4N20xZHpsOTJNUC9zNkE0OXoxMWxCNDRKZDhqVjR6V1BqeFRxY0tNL2wr?=
 =?utf-8?B?WkhTUlJZTXpqK1p4azdTdnNJbFBBQ1ZNakZXc2IrZ3ZPZVN4eUhRSGFlbjBB?=
 =?utf-8?B?aE0rODdzNWxKSDRucEZhQ29VTE1jNWVFRUpvSEQrQi84Nk50Qm80K1dpWGNF?=
 =?utf-8?B?My92Szl1YkxMU2hFUm9lQzd3Sm5RWFZFUEZMRHZOSVFlRytGNStNbElUZ0pu?=
 =?utf-8?B?WHMybjVkL2g0Y2JENkNrQ2pMWE8rbG5GVFdSTTFMUjJacEJla2hsLzl6WWx2?=
 =?utf-8?B?NDJ4eVl5ZDVBZDlxNHd0WWY2RFUveitrbkIzdTA5T2RVTFYzb2p5ckdtU3N0?=
 =?utf-8?B?VDNkNjVKeXExN1ozZHBoRmliSmFRYk5kVGVRV1lMbUpjbGVQMHNhT2lUWnEr?=
 =?utf-8?B?d1Fhd0I4NmdZL1ZpWGhzU0lVeHM4eFVxbVB3b2pGZ0RTWDVJU05IUXQ3QzFR?=
 =?utf-8?B?SDV2OTZ3YmtKOEI5dEdBTHZQTnppeml4ZlVXL1NiaGV6OTk1OE12eDVpZ01m?=
 =?utf-8?B?dDdKKzQ5ZDJvL0FiMmR3VG1TUnZ0YkpmNGVLSTlkNmZYbUgyczIzWnBwQzNH?=
 =?utf-8?B?aVFXalZXNXQvVVZUQ1ZrUnVsYkIxMTluV3JHSk1IUXZ1MnlqMGp5VTB0WjBF?=
 =?utf-8?B?eWVOV2RQWGVnYm0xV1VhZlM3ZSt2SUlFcVZhTnMrbVVNTE1pUzBDSEo2SkI3?=
 =?utf-8?B?M3J6bGtMMDl6bFFDYTZybU9EWFVhSlJTRHpIYlpaaHhNd1daZmZDRmM0ZEht?=
 =?utf-8?B?Mmt4dHIxYjJQOTh6UWd5QmJabWh6TEdoWHV6REhMRXVLVUN5VllPcnhkakRr?=
 =?utf-8?B?eGF5N2ZKN3BGbDdqUFhXR0NWZGhQZ21MR2hvcDJkaytBSWlOak1iZWNJSmVq?=
 =?utf-8?B?NW5BVFNJcVlnSTQyRTVzT3h3Y2NYb20wTkR1bGVWeERvYVZpdS9KNGVqdDFQ?=
 =?utf-8?B?L0s5c3cxZEhtMWpqNy8rQmt1UFVqcVl3UkplaDFqd3R1bzM5dUg5VDBncjFu?=
 =?utf-8?B?bGxTaytlL015eU5ta3BKOXFwWlE4K09Ra1V6dFpOLy90bE44RXB5eVZ2TjVm?=
 =?utf-8?B?MUFMWnluako0SllMMU9BOU1MQ2lXNU12NEdHdVd5ajFnVGZYdWdnYTlLbGFG?=
 =?utf-8?B?dG1XdzJpaHRqUERSUUU1MWFEeDVUaGUrL3hmRlNiWnlRMXRQZm5DYVAvZklq?=
 =?utf-8?B?bTB1RU1MTG1IektER2d6YnpCK3cvdGFVQnk2bHFqaG9oeGJWdllrRndGb0ti?=
 =?utf-8?B?Qkd0SE9hWGRFdm5acHIvdDF6SEpuTDR1K3pPRlp3WSsxTlY5dFpVLzlXdGFY?=
 =?utf-8?B?N1BUeGNDeEFxT1NQTnYydzQ4b3R3dTBLczlkaWNpUE55bGJIdlNLNms5SlJi?=
 =?utf-8?B?bWpBVG5DZDlkOHFtZCtxUlNZaGdrU1E4N3VBejBJWGpmYytIbm9VZkxKOEdN?=
 =?utf-8?B?ZXVEeENkTVZYRGZUQ1BER3pZY0NwSTRmSW9WR29pUHg3SjZrYklaT0VLVnlz?=
 =?utf-8?B?RUxZcWxMUkEwK0ZlM2pPcTB1R2NwTUxSYlNacnFOc3pRYktISVlYOG1OQUpW?=
 =?utf-8?B?RXBvUHluR1ZEWkpnTTNHa3ZuUllNMndyUGhwK0o4bzhTaENKa1FmRDg4Vm90?=
 =?utf-8?B?QjhLeUZESTVQOXRBdS9iZ0lCeGt4WmhwRDlpRGlkOTBlb3hMcXM1ckhtbSt0?=
 =?utf-8?B?U2x0UzArdTMwRGdlUytmaU4xSlJhY2VmZGU4WXRXcFVOVGRsV1Btd3Fzck5x?=
 =?utf-8?B?MWVzejJHcU84ZG0zTFk3c2NoeGVwcDRyVWNxMVJycTc3ci9ZY0tyMGFYWDVG?=
 =?utf-8?B?M1FKbXdacTI3emhHWU85TUh3UGNrZy9GSU9Ga0dmMllVTnJpd0dkNmdnUnl4?=
 =?utf-8?B?NnBIMFdsek5NRzBESmFXNG1iT3psRFUwbUJISTlyZjRQbkxqWkJUNXV2ODAy?=
 =?utf-8?B?NlgzaFpHbEZVTUJHRkVmL1RzejI4eFpLSkpvSENKa1JpR29relQvWVRtakhD?=
 =?utf-8?Q?0Cnsma?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:55:47.4199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd695168-787f-46f9-9d51-08dd866d2455
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069

From: Denis Arefev <arefev@swemel.ru>

The user can set any value to the variable ‘bo_number’, via the ioctl
command DRM_IOCTL_AMDGPU_BO_LIST. This will affect the arithmetic
expression ‘in->bo_number * in->bo_info_size’, which is prone to
overflow. Add a valid value check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

v2: drop 0 check as a BO list of 0 is valid (Alex)

Fixes: 964d0fbf6301 ("drm/amdgpu: Allow to create BO lists in CS ioctl v3")
Cc: stable@vger.kernel.org
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Denis Arefev <arefev@swemel.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 702f6610d0243..81875df6295bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -189,6 +189,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 	struct drm_amdgpu_bo_list_entry *info;
 	int r;
 
+	if (in->bo_number > USHRT_MAX)
+		return -EINVAL;
+
 	info = kvmalloc_array(in->bo_number, info_size, GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-- 
2.49.0


