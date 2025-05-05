Return-Path: <stable+bounces-140570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8676BAAAE25
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A426417FDF9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A28A2DA540;
	Mon,  5 May 2025 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxM5ChGv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D75F365717;
	Mon,  5 May 2025 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485168; cv=none; b=Ieb9vKJrjOfrIv07Y+Cpp2z2ePDE4fL/l6dGDKKgpxmBFnfbCywAiub0XLB2TzCFT3dXB7Lqex+uoZBcX2MYcTSuKmi69DSaQkK7NS6XOE6LwK8aG8MAfG1wqB4sB/ALwN5sLs5esudeXpg4MRw7gxTxrd+d2MjUYBf+oSO07zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485168; c=relaxed/simple;
	bh=qM4WJnGHM1m1fsGvJCRhq94cX/P+bapNYT6XAdoDPVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mi7WHDK69iM2aOPZvcXA2O8xb7u5prw+qfxT8b3jLFFoO4fnT1ylWhQv4mjurzgRU9unLwt9Qo+Q49BHwgd4MkPzR47t0hsrMTuu9dZpOCaL+Ok2oCi7oXkLQq0txFb2LPxUTR6MBgHa3Hb6uU7HqOlMv3XWBGJFsADXl2J81AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxM5ChGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A567EC4CEE4;
	Mon,  5 May 2025 22:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485166;
	bh=qM4WJnGHM1m1fsGvJCRhq94cX/P+bapNYT6XAdoDPVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxM5ChGvRH3pgLaGJcESJIGNuaz4oDXK6phtpI2fkhJy0UEb2m4VWBZGGRdzsR2co
	 0VaZMRgoNPgGc3LKoMrnzjKR/h0B94qEfqPMu3867GM1GGMvxXMKUMML+Z+XBWNS5x
	 h4+ABjXfdJOCbNxfNw0TINq7J/15wZN0P4+EmrOxACeOj1eNEhuv1zhUe6+Qpc/tzx
	 dJX+JaZ+DLcVCDMsf1vbyk28GIBcYQiFNZSIZkGYr00UxtVlHRFQrot96EKwbSihZ+
	 2SWCUG4ar8TsOtyOpPNs96eZROk9Zblc7CtWhhWfWqJhLRYZ1Yen+WcNeCXpTFxoe7
	 u1QQaoJMnoFaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Victor Lu <victorchengchi.lu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Hawking.Zhang@amd.com,
	tao.zhou1@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 196/486] drm/amdgpu: Do not program AGP BAR regs under SRIOV in gfxhub_v1_0.c
Date: Mon,  5 May 2025 18:34:32 -0400
Message-Id: <20250505223922.2682012-196-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Victor Lu <victorchengchi.lu@amd.com>

[ Upstream commit 057fef20b8401110a7bc1c2fe9d804a8a0bf0d24 ]

SRIOV VF does not have write access to AGP BAR regs.
Skip the writes to avoid a dmesg warning.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 0e3ddea7b8e0f..a7bfc9f41d0e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -92,12 +92,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
 
-	/* Program the AGP BAR */
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BASE, 0);
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
-
 	if (!amdgpu_sriov_vf(adev) || adev->asic_type <= CHIP_VEGA10) {
+		/* Program the AGP BAR */
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BASE, 0);
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
 		/* Program the system aperture low logical page number. */
 		WREG32_SOC15_RLC(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
-- 
2.39.5


