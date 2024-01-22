Return-Path: <stable+bounces-12773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D4B837307
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B421F28B17
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0AF4652F;
	Mon, 22 Jan 2024 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vEOlUGjB"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5401A4652A
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952811; cv=fail; b=eBz599g7W3aPIAb1MZ171e7ngd4ujQccNC4z47FqDdCro+ay70zpgOD1fd2wUezJQCeBANvfZIMxYYEipUyZf2hxHsxLVdeMzjfrGnA0Xh4fMkJ5ZTCluBKvX/cPYcZfGSwQPu9ixtdb+KLD/H66A4q7ERLYR9DuSHUyD3858kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952811; c=relaxed/simple;
	bh=lpzKhlUbu6qAkhADpFHBJnfCk+NAlZBSOSgm1mdg+Ig=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cG+Tnobem0r3Jftn50mx1M5euq87l8qWlv4fDDRVYHxwF+9IXMWOwFeSq18JHPgIUW++Zda2i5VMRbi3553BjElBXy/qGR2puZJ0diakjkQm0wOZQSaS+F89jqoraKVa6XYngMVt+9n0Cp2QDLvaUr77PxRmnMXo61Z6LQ97D+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vEOlUGjB; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1cBDwoS5G+f297eL6EyG+aIFhzS1kM8f9aJNjBKvAND1veQsRiB2sgJWY3QC2CDq42mWOjvBomgLhYRUQbFlVjZpqM3kB45FXh4PDBWEv1/wJlNF4K+ZdwV8jVeu3iO8+bfanbaSNpdMyJbwro3313FLNL7bG1/wk4ETVYl5t+GlJFUROcM4jdK2mGI6gxMpk0nl5zRgCBVzfKzQYomI+bxCqvmk7IirMKHHJyh9zfrXL9mWBJ50tUxpD+Xm8MGSnZ/R/lUUTZLwUHJ+0czz1grKUi/FFc3SSphX44+WaCuvocL+YaYa8+FSPuMuPj27lGOvaSV6ZWAeBUEA5pwSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USgADulE3wSQc4Nade+dXJBxnelr+xCIXR7bSzf7AUs=;
 b=cM40CRHDmKds86TosK0WpMdZyAsBK1EOn1tZYpDlp9Z8J5y07wEmGDwEDR9LDlN7owzkKsgEqdPI3S1RC+/amkQ91RoNqCTposddjO0A+NoAVOmoN0dGWiTXcPp/uin2wYO3X+mMBreMOC42PAPxcOzzt8318mYKaVcVl01dlh5DDJxKryumP+7DVK2DUccJVHAg4vLJE/WXOIwk3O6ifPDxBYFSue38nAm6IrY/NBdOgSv0ltzG2Ws79tOulK/JWoXegTndGCpxB+ZcoZ7mBgZvmaROinu5qtRkP8/dIRcE2kiS/LfGffJGJSg50gOX6RHr+A5ZE87Se67iJvKuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USgADulE3wSQc4Nade+dXJBxnelr+xCIXR7bSzf7AUs=;
 b=vEOlUGjBrMMEi6exF3ZiS5zqANuAwAzarDvQU5cTF7ZDkWs0Xx9VHahJcRjKJ8h6/LMTqkhtLEMPWVWW07BMGmPN6IeQdZsvXxt008m3Qf7QzIUAExFnHmRxB4HIwFjCotEzfvT20JTy3+AaUl9051vhvL145kMy9QOJT955gF0=
Received: from CH0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:610:b0::33)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 19:46:45 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::ed) by CH0PR03CA0028.outlook.office365.com
 (2603:10b6:610:b0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31 via Frontend
 Transport; Mon, 22 Jan 2024 19:46:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 19:46:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 13:46:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/2] drm/amdgpu/gfx10: set UNORD_DISPATCH in compute MQDs
Date: Mon, 22 Jan 2024 14:46:29 -0500
Message-ID: <20240122194630.1537295-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|BL1PR12MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: 0136101a-e389-42bd-23bc-08dc1b82dd6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MrE4ZGJBGxx9nOlgLCOfnU406iB5nEh4Y41qf8PzAUo0mDytyUSnw551nkpuR6rJzftVSvJuClb1tbwnGcWIrxHtZ0auUDe+VbJMfvFHomvE9ua3sF0CyrHIJze+wMm74ZtCfv1BzBf3vOgNhhCKyWry/BZcvzONAinXk1psQV8mi6Pc1snCHuR+OOpmxRu7MEILWg7he/1rGf1Qo5MfmsoaYq2+9iz99X3XM9TvXGAGCNuONHi8AW5+kWIlJ4hTrUSC0Dms6cC0KjQdZn3e13hNOKewgM3yCD5CgKIGDgCQWP9/vwy6z4mtwBTB0r51j1wc9GF3ThssTJppSUe5P+etW5I550pHQ5ACMVw41UnNqL7zoqTzB3E5N7drHkP+kinHuAVv+C/Q/BbBrPbYtb8tThe2hRCmCculbVTXmXMWKhpphiGadcWj2RGON9XbPkkXR/OuRZrpFrNWlNgZBJ/EQj0WCYcDeYsfqJ40BDJPzf55lRZ7/toHc4Nc8i3XBNQTMgnqxGPo6seUF66j6M1zxRFGlSx347g8iYwrfIZ7v9SVvkNXK4GEzFhYqqsXCnBZx1KuTGB6DgdoX6WYFEHv1xzxWNvCUhREXAM4A2qxYR5ODwFxm3IjZg1viO3ZxnREjRlhi5TNiWeek99PJGIfwZH/+pSgDN73Kg8E165wUtMllVTTmdDFuESvH+nuzWLmvvPYr+ZYleQWGmnjdH861FUfws0mDm8MbKkTepfwVlTk7BGUOnSe6+WyJCBr/Z1SJvREftGFx0BVqyH0qw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(40470700004)(46966006)(47076005)(26005)(1076003)(426003)(83380400001)(16526019)(336012)(2616005)(356005)(36860700001)(41300700001)(8676002)(82740400003)(8936002)(6916009)(54906003)(316002)(5660300002)(70206006)(7696005)(6666004)(2906002)(4326008)(81166007)(70586007)(478600001)(36756003)(86362001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 19:46:45.3627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0136101a-e389-42bd-23bc-08dc1b82dd6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207

This needs to be set to 1 to avoid a potential deadlock in
the GC 10.x and newer.  On GC 9.x and older, this needs
to be set to 0.  This can lead to hangs in some mixed
graphics and compute workloads.  Updated firmware is also
required for AQL.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c           | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 420c82b54650..be4d5c1e826f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6589,7 +6589,7 @@ static int gfx_v10_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 #ifdef __BIG_ENDIAN
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, ENDIAN_SWAP, 1);
 #endif
-	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 0);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
 			    prop->allow_tunneling);
 	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 8b7fed913526..22cbfa1bdadd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -170,6 +170,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
+	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
 	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
 
 	m->cp_hqd_pq_base_lo = lower_32_bits((uint64_t)q->queue_address >> 8);
-- 
2.42.0


