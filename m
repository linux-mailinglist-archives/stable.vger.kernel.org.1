Return-Path: <stable+bounces-77665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9503E985FA8
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6451F26042
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72A1191F70;
	Wed, 25 Sep 2024 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGJAkDt/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8035D1917E9;
	Wed, 25 Sep 2024 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266638; cv=none; b=q4Fsj/tqsuCUzehlIbpge85hF26oM/k3FAYcopS6swJZZR+/1MsAJi+j6R9TZ+vaCL0YndJxlRv8M+03OZZlRMetSGiv24IYfgUgu5rbFeEA4Q+abNNgEoT1ITNC3AhjjO3XoZ5C1YjNwtXM80lX2tE1lLz0jS6cMu+6PJQ72/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266638; c=relaxed/simple;
	bh=WvSpAkOP651MIs1o09Juc6l95pDljWsGK4kLHDn2ki4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVot/V/tYaCTpaQ53FmhAvYhzAAR2OctImOy9i/eV78GoO1LbnJ6rZ/3O81liaIzbuWTMS8KbzT4GAEK4eKFZK6XuuHsX6r4y1mvKE5jL+XMCPzJ151oJ11hKQBL7+Zs1R/Ysb7G5UPHtVNH8w/VBvkhW3wf8YH1+nJj9q0rPGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGJAkDt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCD6C4CEC7;
	Wed, 25 Sep 2024 12:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266638;
	bh=WvSpAkOP651MIs1o09Juc6l95pDljWsGK4kLHDn2ki4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nGJAkDt/tKcLNmVPFEV0O+GdT472KsJ7RIgq7V1XyGV/lhWN33riYoGuz3wXJNQeD
	 02JB3p7HQs2dCLz06PwdcaJsH1lzpHMTA3gx4CDnF01CaH1baijw2fP/ntVMTl4R8x
	 A6Au0HQdF4nyDouo06ZYeG5ZIxUd6PwAdVkgUyFxQBKDUNJUhfBi2jSnRX4yHEmJnJ
	 PdrcKGxx3omuPFcuCvfmZa6YcJEhn19DRYHk0tiDzX25W0REmn4YQ1aeqlV9YLqiDj
	 SX51jYhLHhcOhvrUECb7ir5hm4lWVsP9HnhagRu3DOFenH5aiF2pdK9lkgFIQQVuAs
	 gfmV+K+7+oWuQ==
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
	lijo.lazar@amd.com,
	mario.limonciello@amd.com,
	Stanley.Yang@amd.com,
	tao.zhou1@amd.com,
	victorchengchi.lu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 118/139] drm/amdgpu: fix unchecked return value warning for amdgpu_gfx
Date: Wed, 25 Sep 2024 08:08:58 -0400
Message-ID: <20240925121137.1307574-118-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index 0ca51df46cc0d..e7b053898f9e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -793,8 +793,11 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
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
@@ -938,7 +941,10 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
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
@@ -1004,7 +1010,10 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
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
@@ -1040,6 +1049,7 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 
 failed_undo:
 	amdgpu_ring_undo(ring);
+failed_unlock:
 	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 failed_kiq_write:
 	dev_err(adev->dev, "failed to write reg:%x\n", reg);
-- 
2.43.0


