Return-Path: <stable+bounces-114921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519C1A30EEE
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 15:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0252A3A7F97
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396CA2512EC;
	Tue, 11 Feb 2025 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xARWJ7LU"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED5E2512E1
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285979; cv=fail; b=FbkW4n+5e+uPJvX5d7iPdy3w0ck3wloZzpNFsuD+bBy5NtNaJt6qMoVn8SsGV7hdn1nR85eE9W2PdoZz5esBTRgmq/xJWxdaiikjDNpcVFDExDye3VBPsgrRtjPZBOp6SXVeXoKBgfw2JXq/FZYnvcj6noiVOxfDZY1pWFd8IJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285979; c=relaxed/simple;
	bh=JJbBnV/ByGsWYouhK6LQvuykRS3su+2zBfAeL6pcmLE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W1AohiMrhTH/tLvSPSRZOyl30lwKlLhX64VoIUbpDFUyfHjoQpX2XOIz6iQetvqsh8MuLK07k2jVroqzCj5tqQWz5JWc1wvQZoO9TtDFejFA5cUCF0K2Y3ZtxKG06u5tbafZ3zEhOPpDpMneobvUgQ/ai+fQ9y84blc90XpDOVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xARWJ7LU; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1pO4V/UddYm+cmNlYrIvd66HP+cVJpaoigWvHgyK0hDbk8DrPDU48dMwdt381HBRTWs0cd+GSVVFyqQ7Qfic5u5jz/ssHu//H3b96nq57nJZS+4eS0ql51WfFgfLErXGy7n5QlrDsztm9Fm2BUuoCavOPRCWILWuEvw+mQJq8yLXGt2JvoSIyB2MmfB57uXuFLvvgtGsu5k4RWtRXQx4FFgiz9CsgqDFYx58uLS7s7u7R4HNFo6BWYcrcgCIEEtPXz0Jfi2PnJMRgJiIUcyx33qRjiSJFFbcxbhUgT/pA9f9thLGVG6NLidbuLK79Md2af2y0JCE7r0+ZEQZTT6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+7D2ueN5smI/ajCqjSTnyZQHMsgJwYQIYI9yvFMr5s=;
 b=pPcR26n7mbJtVqGV+8KXT5f723LHdFtd9P//QLAYTXgzZWCNHdniVuIWG1xTt4WhUrAHvqrSCo7zM71OkNBOgIDb68aYMwswxX+BLD+La4UWBgknjER/KVO+Z316nt5Aqz2i0VfKdFElKyPWAiJZcrx/ZtwSAcHJC3WKYX8R7hJ53ziD97s2hww0LlQgLzAxlsr+r9i2Fmazi6Pgbe0eo7v75dZJ+T+PhCYD1Erw+8LC2nBzeEafSUeRKSa6O8gNU+SehrmP9lMtlIP+RFSYEQhohrQGTAVsbfnbHjUlQe093zZXdnA96lNGKr9OZ0miNw//80aLSQtnTTiDGQOW6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+7D2ueN5smI/ajCqjSTnyZQHMsgJwYQIYI9yvFMr5s=;
 b=xARWJ7LUIJ19rfFVuCeRYbD/ENbB0TM+T+n1quEQSdFGzeKb+o0xHWHBx9myuzMuMtHIpvqO2OzS6vkkAEihKa6FbymjJg27jHxh2r/y4sn+6Mym6G7fxZlcm271hxeigW6q6ZZ0GrTCre1BJ3C0wJXcQKbbkH0sARzqMdBV7KE=
Received: from BN9PR03CA0877.namprd03.prod.outlook.com (2603:10b6:408:13c::12)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 14:59:31 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::28) by BN9PR03CA0877.outlook.office365.com
 (2603:10b6:408:13c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Tue,
 11 Feb 2025 14:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 14:59:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 08:59:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Pierre-Eric Pelloux-Prayer
	<pierre-eric.pelloux-prayer@amd.com>, Yang Wu <harico@yurier.net>, "Mingcong
 Bai" <jeffbai@aosc.io>, Daniel Wheeler <daniel.wheeler@amd.com>, "Aurabindo
 Pillai" <aurabindo.pillai@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] Revert "drm/amd/display: Fix green screen issue after suspend"
Date: Tue, 11 Feb 2025 09:58:43 -0500
Message-ID: <20250211145843.1350590-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: b3804aae-85cf-4e12-cac1-08dd4aacb063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?55Dq5FSGcJyViUaYJj4et4u/iuUnxQg6dQl9/fHyOwZSDtTjiEtzU1rUSNKA?=
 =?us-ascii?Q?8pyqGXPeBCxbeUsYvxN88N31iDzQL4qod+wZqvLlKVCi8/V3Wq/FmzZ7bsym?=
 =?us-ascii?Q?3Jpaaj+OPF386t4J3buw+Fg1NsExWF7qht7+PGPCx4TNUtJrRnQdRFvGgp6R?=
 =?us-ascii?Q?3LNu5X9kx6oEKkPSA+aWjVrsFZFigwW5P74+T63yVRMl0RQgJ68XuQqCe90a?=
 =?us-ascii?Q?iABgzm3rOOQFf97fIaUE+b83qetuwi4ABTmmuVmDl48tTYVlDnyxarwt1fqY?=
 =?us-ascii?Q?xuAMc2adGnlZpNqEVWjukLkbusjAaKtiyWQUInTaehCDsRex24Y7Rh6gQU2d?=
 =?us-ascii?Q?937q1fkRx0YU6kBYWsphVBGnt2eeCz2UBXDvRn0afvxccu+r9brGOKZ5Oe3m?=
 =?us-ascii?Q?idXv1dXzKwDFjvtu71CtmmAakQmOAO9cQOWqiXIKHDkvVIWvwpE87zaoFZXL?=
 =?us-ascii?Q?20tSgVcfEP/j0VjhWZsI/tRWe5JUa6NttQjrIYneLEy1m0wfPa/DzSyG/xsm?=
 =?us-ascii?Q?WQziSUTwkyZcRZ+lmI0UUhjxSh6KmDC+Qp8Jr27AcVkiG77jDFTR7XYxCC7u?=
 =?us-ascii?Q?dhzN8ehkBrC3dqeLyRNIpj1fwSzyvncKJpZ4sBivSlsNjWGXuIV19sJ4Y1UJ?=
 =?us-ascii?Q?gyUnfxhejBC/wPV5x3NgoGlzVxFygx2G/+pAsVI9Q3WJ30C8JQqw4PORqw6n?=
 =?us-ascii?Q?0PKV00cbMfJfzJm7NrwghamW2eWegBTxfS7shu3Y6A5gjYFZNe7D1bMx56O6?=
 =?us-ascii?Q?fk7VflxGU9N8UrD8wQ16pUHTHbJxzs69huTNIqBi8U+zRADfvnOd6TWRCB3W?=
 =?us-ascii?Q?xbUzjfiOl11XmYWgX8XyEvIS1rENYEZERoHtUZwySw4nmzq+ajmyhSZUjJOp?=
 =?us-ascii?Q?0630vbIHV40uqRszM6TektMdVBRzf8Pvm7oWPsXx/SxZ8hKEuEya/+Q4qETo?=
 =?us-ascii?Q?NjF0gwlxgEnrFgDLGwxPRc/iBSfawebCI0GautAtxN36sjutwGCIlxddg0z7?=
 =?us-ascii?Q?djAdVHcRQzh/gfzEPgE1LF0wTwjjBNKsVxOZwydSvTeoc0bDzonwnYDGpNJq?=
 =?us-ascii?Q?+XUnU4fnbFJirXq/NAxyJjIF/25jgg2nMpC1XK3c6a2ASTlMb+FMTUy4LGuG?=
 =?us-ascii?Q?zj13jFmjLXtkwfirr1IFzxdoJjPHncIhVQ8Rfb63iQj/KknZDsr8McnFnNMb?=
 =?us-ascii?Q?Xitw5jxPU6oApCp87aRcX0TXyI3EyHuhcQuwGYxpZkbB0L0eRLz554947PDJ?=
 =?us-ascii?Q?yZXibFdPgH8iwLkSK9Al8mzf4yWU/9wNIURkWHa0hK1GHhpJagECgH7YhJuT?=
 =?us-ascii?Q?d1rguQPgfhhObU153fum3VTni+gziYguzOy9ekbG7miSMuAnyVinPPwyBEJS?=
 =?us-ascii?Q?/Zub28kKb7rvdmF4OPSV3P3nYqV352n0f+qMQ/Zv6Olfz4OeIxNSMa6pjlUn?=
 =?us-ascii?Q?OjHw8Q3oVNU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 14:59:30.9701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3804aae-85cf-4e12-cac1-08dd4aacb063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This reverts commit 87b7ebc2e16c14d32a912f18206a4d6cc9abc3e8.

A long time ago, we had an issue with the Raven system when it was
connected to two displays: one with DP and another with HDMI. After the
system woke up from suspension, we saw a solid green screen caused by an
underflow generated by bad DCC metadata. To workaround this issue, the
'commit 87b7ebc2e16c ("drm/amd/display: Fix green screen issue after
suspend")' was introduced to disable the DCC for a few frames after in
the resume phase. However, in hindsight, this solution was probably a
workaround at the kernel level for some issues from another part
(probably other driver components or user space). After applying this
patch and trying to reproduce the green issue in a similar hardware
system but using the latest kernel and userspace, we cannot see the
issue, which makes this workaround obsolete and creates extra
unnecessary complexity to the code; for all of this reason, this commit
reverts the original change.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3960
Reported-By: Yang Wu <harico@yurier.net>
Tested-by: Yang Wu <harico@yurier.net>
Suggested-by: Mingcong Bai <jeffbai@aosc.io>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 04d6273faed083e619fc39a738ab0372b6a4db20)
Cc: stable@vger.kernel.org
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++------
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 22 +++++++------------
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |  3 +--
 3 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 53694baca966..8224a290dac5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5522,8 +5522,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 			    const u64 tiling_flags,
 			    struct dc_plane_info *plane_info,
 			    struct dc_plane_address *address,
-			    bool tmz_surface,
-			    bool force_disable_dcc)
+			    bool tmz_surface)
 {
 	const struct drm_framebuffer *fb = plane_state->fb;
 	const struct amdgpu_framebuffer *afb =
@@ -5622,7 +5621,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 					   &plane_info->tiling_info,
 					   &plane_info->plane_size,
 					   &plane_info->dcc, address,
-					   tmz_surface, force_disable_dcc);
+					   tmz_surface);
 	if (ret)
 		return ret;
 
@@ -5643,7 +5642,6 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	struct dc_scaling_info scaling_info;
 	struct dc_plane_info plane_info;
 	int ret;
-	bool force_disable_dcc = false;
 
 	ret = amdgpu_dm_plane_fill_dc_scaling_info(adev, plane_state, &scaling_info);
 	if (ret)
@@ -5654,13 +5652,11 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	dc_plane_state->clip_rect = scaling_info.clip_rect;
 	dc_plane_state->scaling_quality = scaling_info.scaling_quality;
 
-	force_disable_dcc = adev->asic_type == CHIP_RAVEN && adev->in_suspend;
 	ret = fill_dc_plane_info_and_addr(adev, plane_state,
 					  afb->tiling_flags,
 					  &plane_info,
 					  &dc_plane_state->address,
-					  afb->tmz_surface,
-					  force_disable_dcc);
+					  afb->tmz_surface);
 	if (ret)
 		return ret;
 
@@ -9068,7 +9064,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			afb->tiling_flags,
 			&bundle->plane_infos[planes_count],
 			&bundle->flip_addrs[planes_count].address,
-			afb->tmz_surface, false);
+			afb->tmz_surface);
 
 		drm_dbg_state(state->dev, "plane: id=%d dcc_en=%d\n",
 				 new_plane_state->plane->index,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 495e3cd70426..83c7c8853ede 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -309,8 +309,7 @@ static int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdg
 								     const struct plane_size *plane_size,
 								     union dc_tiling_info *tiling_info,
 								     struct dc_plane_dcc_param *dcc,
-								     struct dc_plane_address *address,
-								     const bool force_disable_dcc)
+								     struct dc_plane_address *address)
 {
 	const uint64_t modifier = afb->base.modifier;
 	int ret = 0;
@@ -318,7 +317,7 @@ static int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdg
 	amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(adev, tiling_info, modifier);
 	tiling_info->gfx9.swizzle = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier);
 
-	if (amdgpu_dm_plane_modifier_has_dcc(modifier) && !force_disable_dcc) {
+	if (amdgpu_dm_plane_modifier_has_dcc(modifier)) {
 		uint64_t dcc_address = afb->address + afb->base.offsets[1];
 		bool independent_64b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_64B, modifier);
 		bool independent_128b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_128B, modifier);
@@ -360,8 +359,7 @@ static int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct amd
 								      const struct plane_size *plane_size,
 								      union dc_tiling_info *tiling_info,
 								      struct dc_plane_dcc_param *dcc,
-								      struct dc_plane_address *address,
-								      const bool force_disable_dcc)
+								      struct dc_plane_address *address)
 {
 	const uint64_t modifier = afb->base.modifier;
 	int ret = 0;
@@ -371,7 +369,7 @@ static int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct amd
 
 	tiling_info->gfx9.swizzle = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier);
 
-	if (amdgpu_dm_plane_modifier_has_dcc(modifier) && !force_disable_dcc) {
+	if (amdgpu_dm_plane_modifier_has_dcc(modifier)) {
 		int max_compressed_block = AMD_FMT_MOD_GET(DCC_MAX_COMPRESSED_BLOCK, modifier);
 
 		dcc->enable = 1;
@@ -839,8 +837,7 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			     struct plane_size *plane_size,
 			     struct dc_plane_dcc_param *dcc,
 			     struct dc_plane_address *address,
-			     bool tmz_surface,
-			     bool force_disable_dcc)
+			     bool tmz_surface)
 {
 	const struct drm_framebuffer *fb = &afb->base;
 	int ret;
@@ -900,16 +897,14 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 		ret = amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(adev, afb, format,
 										 rotation, plane_size,
 										 tiling_info, dcc,
-										 address,
-										 force_disable_dcc);
+										 address);
 		if (ret)
 			return ret;
 	} else if (adev->family >= AMDGPU_FAMILY_AI) {
 		ret = amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(adev, afb, format,
 										rotation, plane_size,
 										tiling_info, dcc,
-										address,
-										force_disable_dcc);
+										address);
 		if (ret)
 			return ret;
 	} else {
@@ -1000,14 +995,13 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	    dm_plane_state_old->dc_state != dm_plane_state_new->dc_state) {
 		struct dc_plane_state *plane_state =
 			dm_plane_state_new->dc_state;
-		bool force_disable_dcc = !plane_state->dcc.enable;
 
 		amdgpu_dm_plane_fill_plane_buffer_attributes(
 			adev, afb, plane_state->format, plane_state->rotation,
 			afb->tiling_flags,
 			&plane_state->tiling_info, &plane_state->plane_size,
 			&plane_state->dcc, &plane_state->address,
-			afb->tmz_surface, force_disable_dcc);
+			afb->tmz_surface);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index 6498359bff6f..2eef13b1c05a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -51,8 +51,7 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 				 struct plane_size *plane_size,
 				 struct dc_plane_dcc_param *dcc,
 				 struct dc_plane_address *address,
-				 bool tmz_surface,
-				 bool force_disable_dcc);
+				 bool tmz_surface);
 
 int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 			 struct drm_plane *plane,
-- 
2.48.1


