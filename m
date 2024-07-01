Return-Path: <stable+bounces-56157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C1B91D508
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9871C20AA8
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AE9848E;
	Mon,  1 Jul 2024 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkwbS1gg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BDE81AC6;
	Mon,  1 Jul 2024 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792766; cv=none; b=PCtr7czJVlcURxJcLJIJN6+T+SMYjqpGPqUiZK0RkPwPQ4ZPWyvXV8HEvabUCTOuJb+2S0NMo5LpRGG+A5l4DIfzxUa4X9pk/6EEVaaSwRpS8OPGUtohxAK/DXQVOL/gCpYoCHHHbdTdwVJp4PhN/cXYNVcAucmb4EdOunABbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792766; c=relaxed/simple;
	bh=Z3HaW7ABLPU2N+mCFamrZlsYULE8doUtAvPlgFbDYT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/S8pupJZYAgtsNWuBz47fFkYC3vc48h0LxI/NGPn0ejMlwNB2dPFH9RtvW7xtUKJcnWI+a3uTdIY6+7qchPBua38wbPzsSF7WuNeFTSLVmEYA1mxg82Ll6evlH/wMQD7ELosr5NgHnq3UE5y9FdTrIum/DqYtZVHgcz5x9UpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkwbS1gg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC62C32786;
	Mon,  1 Jul 2024 00:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792766;
	bh=Z3HaW7ABLPU2N+mCFamrZlsYULE8doUtAvPlgFbDYT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rkwbS1ggnkylCnXkfOFcw5neSUuDHztnGZ3zssrV86CwUNMOgfVZEPnN8W2d1RCI+
	 UEit+Tim/XYmSgDzSEBH6ZAow6fSF2jRIAraJY2Sn1hkVKyKxFBv5evvgubwSmEusn
	 1eeaDpxTRi7BQqrDy6aG9VnAyGXgTKfYSs8BD7vGqVwONJU+Rdw93vXJra0VUiHHGC
	 jf+nsUTV2ozEnt2Nmhzn8U0ldaZWy1jpWDMIWw79QdpdczkIJyXPkAA+nWeghYYCRT
	 Hvu9NJa8jrAqjNH2WXEa4A1xS2HRJ8UfY4yE6dVA0k7sUej+xtYl9Soo1P5c8GF3Al
	 pGKcsGk+FrtKg==
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
	Hawking.Zhang@amd.com,
	lijo.lazar@amd.com,
	tao.zhou1@amd.com,
	asad.kamal@amd.com,
	kevinyang.wang@amd.com,
	Mangesh.Gadre@amd.com,
	victorchengchi.lu@amd.com,
	mukul.joshi@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.9 14/20] drm/amdgpu: Indicate CU havest info to CP
Date: Sun, 30 Jun 2024 20:11:19 -0400
Message-ID: <20240701001209.2920293-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001209.2920293-1-sashal@kernel.org>
References: <20240701001209.2920293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.7
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
index d89d6829f1df4..b10fdd8b54144 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4187,9 +4187,10 @@ static u32 gfx_v9_4_3_get_cu_active_bitmap(struct amdgpu_device *adev, int xcc_i
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
@@ -4207,6 +4208,7 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (xcc_id = 0; xcc_id < NUM_XCC(adev->gfx.xcc_mask); xcc_id++) {
+		is_symmetric_cus = true;
 		for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 			for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
 				mask = 1;
@@ -4234,6 +4236,15 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
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


