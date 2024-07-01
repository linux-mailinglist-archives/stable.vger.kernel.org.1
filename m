Return-Path: <stable+bounces-56173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513D991D537
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840D11C206AA
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ED12A8D0;
	Mon,  1 Jul 2024 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daCzQRcL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8472A1D1;
	Mon,  1 Jul 2024 00:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792849; cv=none; b=vBcnYbNgQQXtuqwAJJC3tifXW7mVuAkLe2IajhTciJpDq6vi4j6DgszmxrTDV+CKf2HKvF38sx7PLEGceoEHTpqCBdUFuieA2ofaAOBSU0nCa2UkH6f4ZZlzQAtc22H0lfeS+6NwnJvqNCKllVBnDkAmDLlyFFtoUGefIS7LHgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792849; c=relaxed/simple;
	bh=pvMxiY/XNGX91tZAIWaqZymMs0iEKDv2y91fdMZLYDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAZlqgiTyd6Bl2vQps12BZk+OYCkho8zTAq3Hzfg4ecOk0tR40Mhct1npV4OZ4GAUlyos1tPBRjI5Gd+gm8ko+bSQC2+9wBwmr5ACOFv/6f/gBhBGe4I/oEC9z9at3QgX0NszNeq+QVud6aO1xOg7zgfS6JCUu7zjFOzQfopwYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daCzQRcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCAEC2BD10;
	Mon,  1 Jul 2024 00:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792848;
	bh=pvMxiY/XNGX91tZAIWaqZymMs0iEKDv2y91fdMZLYDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=daCzQRcL3uyGWstq0y0OPmQBrMB++rr2nAwmMM2N6lf+Y0l+K0ijuElXyxc1+Igr8
	 SmKWGJRxOwsP9o19YqwlDOVR9jkNi/txeny9Kt7Jx14NOaeqCkOnVGP5X8JKGRUrnB
	 LZW6JiMLHDy0M8qh9jmDYLd7HYgh6lqu9//EVagFopzqthTXJeKqFaga1o9Kv7SVwQ
	 gCvS0R8WzXfhpJLL2QTe7Y/Dmg/THaMZxT7peedg236glqfn7/1xrOx7xT6UrhUNII
	 xPfLhKbiYloeVM2miB6bIb5fSKgfQpcovbY1RyL+q5SKzGmYvLRiuOYDXRgA8BbujJ
	 CWaXIsBl0CR2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	lijo.lazar@amd.com,
	Hawking.Zhang@amd.com,
	tao.zhou1@amd.com,
	Mangesh.Gadre@amd.com,
	kevinyang.wang@amd.com,
	victorchengchi.lu@amd.com,
	mukul.joshi@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 10/12] drm/amdgpu: Indicate CU havest info to CP
Date: Sun, 30 Jun 2024 20:13:29 -0400
Message-ID: <20240701001342.2920907-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001342.2920907-1-sashal@kernel.org>
References: <20240701001342.2920907-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.36
Content-Transfer-Encoding: 8bit

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

[ Upstream commit 49c9ffabde555c841392858d8b9e6cf58998a50c ]

To achieve full occupancy CP hardware needs to know if CUs in SE are
symmetrically or asymmetrically harvested

v2: Reset is_symmetric_cus for each loop

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index af46823e43367..caa04d897c2de 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4290,9 +4290,10 @@ static u32 gfx_v9_4_3_get_cu_active_bitmap(struct amdgpu_device *adev, int xcc_i
 static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 				 struct amdgpu_cu_info *cu_info)
 {
-	int i, j, k, counter, xcc_id, active_cu_number = 0;
-	u32 mask, bitmap, ao_bitmap, ao_cu_mask = 0;
+	int i, j, k, prev_counter, counter, xcc_id, active_cu_number = 0;
+	u32 mask, bitmap, ao_bitmap, ao_cu_mask = 0, tmp;
 	unsigned disable_masks[4 * 4];
+	bool is_symmetric_cus;
 
 	if (!adev || !cu_info)
 		return -EINVAL;
@@ -4310,6 +4311,7 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (xcc_id = 0; xcc_id < NUM_XCC(adev->gfx.xcc_mask); xcc_id++) {
+		is_symmetric_cus = true;
 		for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 			for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
 				mask = 1;
@@ -4337,6 +4339,15 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 					ao_cu_mask |= (ao_bitmap << (i * 16 + j * 8));
 				cu_info->ao_cu_bitmap[i][j] = ao_bitmap;
 			}
+			if (i && is_symmetric_cus && prev_counter != counter)
+				is_symmetric_cus = false;
+			prev_counter = counter;
+		}
+		if (is_symmetric_cus) {
+			tmp = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_DEBUG);
+			tmp = REG_SET_FIELD(tmp, CP_CPC_DEBUG, CPC_HARVESTING_RELAUNCH_DISABLE, 1);
+			tmp = REG_SET_FIELD(tmp, CP_CPC_DEBUG, CPC_HARVESTING_DISPATCH_DISABLE, 1);
+			WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_CPC_DEBUG, tmp);
 		}
 		gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
 					    xcc_id);
-- 
2.43.0


