Return-Path: <stable+bounces-140852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866E6AAAF88
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D1A3BA5AB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01732FA13B;
	Mon,  5 May 2025 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi5EvHR7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCCC2EE468;
	Mon,  5 May 2025 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486562; cv=none; b=XAJoL3RUfBMOPWuD/yVWQhxzu9yqg+E7KVp19Ega6o77CCkuMZJBBsDy6IHyVAsJyYqz3Gy0Id+XnRYLp4nBfD8wa/N9auJkipxRbkynkuBmK5HJjM6pmOlSMaGGIKaHDX2im5g47a6m/+dbvSr/eSDGOfAXycLUOUOg4J2Z4Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486562; c=relaxed/simple;
	bh=xR8HItLqSKPUB0KcBnM9Bg8bJlEv0YqN9bUXCQUdFI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLS98eMVFdgBf3g/t7j0Lp8PnKG9VBibnaLrdPceYfQYXAJ20Ishz9MkS/QuSZeJfwsnz2RUdr8LMvSb0wJHKno5xajG5CZLgeTasvE4OWS9+1nuMbq9UfT4GE85i4Ewm146J/bXH70D4HPneotmPl/OEPGVZ8jhPLp8nW7Gsxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zi5EvHR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3862EC4CEED;
	Mon,  5 May 2025 23:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486561;
	bh=xR8HItLqSKPUB0KcBnM9Bg8bJlEv0YqN9bUXCQUdFI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zi5EvHR7guJtfavszqJAzRrVp3xnvvV3dNlXG1K8PBrlvpKr2JEvZ0mxDvkUfgsiB
	 +w4bLSj2/mJZuDQvTIUIGhvBBmG6Au0lxUpwtwmJttY9a1StO3ZwW/MqOTpXD5UAom
	 mLTRWqS98mVoW6f2sRh8vfU/rLbhhmZcJcYw+i8tqyp4DFfzOENiz6PIhwjDJ7t7ar
	 +OoR4niYyv/LgnFIQNaE3hBcACxcUJrTJUm2+2Nb65556ICayYIov7fasOdFYQETQL
	 APvIoszdO5UysrSSGp24+gSBludqRQltPKXv70uAb4jd0kZU7w07T3KIEIqeCYACV/
	 dU2CM8gZggxJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Victor Lu <victorchengchi.lu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	tao.zhou1@amd.com,
	Hawking.Zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 092/212] drm/amdgpu: Do not program AGP BAR regs under SRIOV in gfxhub_v1_0.c
Date: Mon,  5 May 2025 19:04:24 -0400
Message-Id: <20250505230624.2692522-92-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index ec4d5e15b766a..de74686cb1dbd 100644
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


