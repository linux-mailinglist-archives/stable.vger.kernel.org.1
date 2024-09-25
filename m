Return-Path: <stable+bounces-77301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27985985B95
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C554B1F273AA
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B353419ABC7;
	Wed, 25 Sep 2024 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gysEpwlV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4A619ABBF;
	Wed, 25 Sep 2024 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265068; cv=none; b=FH+lE9kQFWNLnHPlsudkQFv55bjrEOvoOk+KsTI68Y/nRgvigKYq+OMFQIYH3+AEgfJ6ASd2hQYcpq8US2sshwChwIAcrZl/He4GdVTljJmX8peMXK4Fkkqek+W4EMMXDt9tVUHubmztVKaS1kDs1we6Itdm737N8VeWvUMT5Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265068; c=relaxed/simple;
	bh=oGQnSzjkJ9ii2c2vUWL5h9SFe4jaWw+1mulU4/XGYm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1Aexg6b0Mt1Jo67zjK0B+QB8lUXOJ9Hn7yI3LzvD3f9gEGeRhruYRDc8jziyd8je7rJBMN9IlgOZyWHl/BiLBH3IaS0UWkCu5VSbUtLn9jabVnisZl3JnCkyK5wo+0W1OixSdAxcnKcMua1MNlAUEtnDPHIY065r3J2BBkthOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gysEpwlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BC4C4CEC3;
	Wed, 25 Sep 2024 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265068;
	bh=oGQnSzjkJ9ii2c2vUWL5h9SFe4jaWw+1mulU4/XGYm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gysEpwlV2ISjlx4GdkLsGvEHlwtOT2YFyMDxVOKSQaR0Ay831yyzy6gqEKZTh9a1S
	 75xtmSakIeSb6OQVUfsAJTxkm+2sff2/ZJdDNpwMJDZPo+y+xP4kpouWkxF0a6dc+Q
	 wYqKKWNnjedx2JwVmylAwEdH3TNMd5W5GOfbEkj4go/PrfcT1OiVsp9HL3tbijQ1qP
	 vXMUwF52nIYDfAHLJCP6I9Fno6lAnXUoJw+2xHxGG8GlNSxSzANXetX5rfjcXxRD8/
	 gwuzZwTZB96gPuMAd3eDKdHKGjiVYN3whRPGnsePZ9PAw/o+jC+UV6g7B9O257x/5z
	 Me5B79GO0Bzew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <tim.huang@amd.com>,
	Jesse Zhang <jesse.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	Jack.Xiao@amd.com,
	srinivasan.shanmugam@amd.com,
	tao.zhou1@amd.com,
	mario.limonciello@amd.com,
	Stanley.Yang@amd.com,
	victorchengchi.lu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 203/244] drm/amdgpu: fix unchecked return value warning for amdgpu_gfx
Date: Wed, 25 Sep 2024 07:27:04 -0400
Message-ID: <20240925113641.1297102-203-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Tim Huang <tim.huang@amd.com>

[ Upstream commit c0277b9d7c2ee9ee5dbc948548984f0fbb861301 ]

This resolves the unchecded return value warning reported by Coverity.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 1849510a308ad..3ff39d3ec317c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -882,8 +882,11 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 	int r;
 
 	if (amdgpu_ras_is_supported(adev, ras_block->block)) {
-		if (!amdgpu_persistent_edc_harvesting_supported(adev))
-			amdgpu_ras_reset_error_status(adev, AMDGPU_RAS_BLOCK__GFX);
+		if (!amdgpu_persistent_edc_harvesting_supported(adev)) {
+			r = amdgpu_ras_reset_error_status(adev, AMDGPU_RAS_BLOCK__GFX);
+			if (r)
+				return r;
+		}
 
 		r = amdgpu_ras_block_late_init(adev, ras_block);
 		if (r)
@@ -1027,7 +1030,10 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg, uint32_t xcc_
 		pr_err("critical bug! too many kiq readers\n");
 		goto failed_unlock;
 	}
-	amdgpu_ring_alloc(ring, 32);
+	r = amdgpu_ring_alloc(ring, 32);
+	if (r)
+		goto failed_unlock;
+
 	amdgpu_ring_emit_rreg(ring, reg, reg_val_offs);
 	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
 	if (r)
@@ -1093,7 +1099,10 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 	}
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
-	amdgpu_ring_alloc(ring, 32);
+	r = amdgpu_ring_alloc(ring, 32);
+	if (r)
+		goto failed_unlock;
+
 	amdgpu_ring_emit_wreg(ring, reg, v);
 	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
 	if (r)
@@ -1129,6 +1138,7 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint3
 
 failed_undo:
 	amdgpu_ring_undo(ring);
+failed_unlock:
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq_write:
 	dev_err(adev->dev, "failed to write reg:%x\n", reg);
-- 
2.43.0


