Return-Path: <stable+bounces-70246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C58E95F5A6
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 17:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B461F22C93
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 15:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA59E49631;
	Mon, 26 Aug 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2PfJKZl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C73E1940BC
	for <stable@vger.kernel.org>; Mon, 26 Aug 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687727; cv=none; b=ECHSk6r4prdYLpWfvSUdvnr825vX0OEVcWg35blXMMdG8eJqaT1pH9gB5onzOQZy10PKLSHMt6DOs61NVkGplsu59oPBVZnEl1YgYEx1nxaMAZbE3ST1ILYEv2kQhRDmHWAnoLwGtaZZo1Qqy29I5IsVnmdPwH7SkcSr99Jm+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687727; c=relaxed/simple;
	bh=49Pxp0npz+CP2r2AxhdPOTmENVEHFAiDo6gw1YUE/Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WodBU/zxRCLX5R4uHPILWydPyEPzI1tVx0Z+7r2bp1odrSDo0Zqi5Rwjv+tDiIcGb/I4eFY76dwujxUPE9PVVsCH4xuu/6ozIGhtuZw32dP5PH4J566RuG73hVUgAcGR5PVumv1ifZkWa5T6MJ9KC2qaKsO/+Vfvq9ZJiX/Z6z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2PfJKZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8541FC52FF8;
	Mon, 26 Aug 2024 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687727;
	bh=49Pxp0npz+CP2r2AxhdPOTmENVEHFAiDo6gw1YUE/Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r2PfJKZl6SWEGf+Nhm0niHLq/x2vQtNDJiwnXf94H/gUqHIfhmIMy5BGnPPrCUSHW
	 HeHMH+3xEXZ1+FaCHgSDGTsFi4icOjdA76v2yFy5yD0jFqbG7yp+xeLGGYSa7Kog00
	 XNS9ulanUtB/qLeO4lCoYyOqxCXaAPD6wp+xB6t+VGGnYd2qDf+TdYCQ1Ssu6VwNEd
	 7MgleCUorO4pztnsXkBv4+bdmSFm6tm4gTUBDGw/rGmANmPsb2Byh3LMExD3fnL0ta
	 rVwF9+Ky5J8oqE0rFEtFuaRTsBWBsM1FwHm7xCgKizz+Uosyum9DBS21v+VscnqKc2
	 e9AJOO3CCqAhA==
From: Mario Limonciello <superm1@kernel.org>
To: stable@vger.kernel.org
Cc: Boyuan Zhang <boyuan.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ruijing Dong <ruijing.dong@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 2/2] drm/amdgpu/vcn: not pause dpg for unified queue
Date: Mon, 26 Aug 2024 10:55:19 -0500
Message-ID: <20240826155519.2030932-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826155519.2030932-1-superm1@kernel.org>
References: <20240826155519.2030932-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Boyuan Zhang <boyuan.zhang@amd.com>

For unified queue, DPG pause for encoding is done inside VCN firmware,
so there is no need to pause dpg based on ring type in kernel.

For VCN3 and below, pausing DPG for encoding in kernel is still needed.

v2: add more comments
v3: update commit message

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 7d75ef3736a025db441be652c8cc8e84044a215f)
Adjusted for fuzz with a backport.
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index cb4318974e7c..e2475f656ff2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -472,7 +472,9 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 			fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
 		}
 
-		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
+		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+		    !adev->vcn.using_unified_queue) {
 			struct dpg_pause_state new_state;
 
 			if (fence[j] ||
@@ -518,7 +520,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 	       AMD_PG_STATE_UNGATE);
 
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)	{
+	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
+	    !adev->vcn.using_unified_queue) {
 		struct dpg_pause_state new_state;
 
 		if (ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC) {
@@ -544,8 +548,12 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
+
+	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (ring->adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
-		ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC)
+	    ring->funcs->type == AMDGPU_RING_TYPE_VCN_ENC &&
+	    !adev->vcn.using_unified_queue)
 		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
 
 	atomic_dec(&ring->adev->vcn.total_submission_cnt);
-- 
2.43.0


