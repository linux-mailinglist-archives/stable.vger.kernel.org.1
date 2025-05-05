Return-Path: <stable+bounces-139993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D2EAAA380
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E593A3D64
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36A7283FE2;
	Mon,  5 May 2025 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRQxWFDa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A088D2F3671;
	Mon,  5 May 2025 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483842; cv=none; b=JBM2kEREDdbWfSfrZE1m3mp1lAAocswWp8HqnulkNwwFjctQ0OL/sIbF/h9I00/ZjOe8y+DwbrR7jUpQ9bnaKhGH596wPz/LGDB2IL8jC8WNp/dPZpDIF7+Gn96clkdDm+TYifE0atSPpBJqWui9HoCdT7TwExDflyT9qdYAsVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483842; c=relaxed/simple;
	bh=qM4WJnGHM1m1fsGvJCRhq94cX/P+bapNYT6XAdoDPVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PMYN/6+9kwMwc/ZXvxMkiT2VKqrYtxcsBLFQbGRTOBeoG5A2yL4asi8QmatGGilSaJbUYdIWfKwWHqL96Uh+ht/lagego8f9nBY6VM0Tl3UNtWMTkTnaDxGq0O2yuJlnZY2p3+32I08WQyw+7IM3KDwFEbarKr+svz88QDOlYcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRQxWFDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0699C4CEEE;
	Mon,  5 May 2025 22:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483841;
	bh=qM4WJnGHM1m1fsGvJCRhq94cX/P+bapNYT6XAdoDPVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IRQxWFDaeiz0LKD/V5mWSaQf0kEXTrpd7we7T+iUc650PL3PfnBF/G980L/EgCSfn
	 gCziogBiQDUhXH6dBLezRmCN87Yw2GX04wnQJnWcVfC4p6FXtEEn/y24lKKR3qb92b
	 INDjZXkE6o1wHEqFu8W30cfgmYC/0HDUrsQGJ7RCiJjCZ1izx5oiAOU83TUOYfXy3q
	 7ZIGpLseYVQCcT1o4CEikKrk6fVXDoFB2ENpgIGWyGaBjNCLhNgj0aipyRIm68qj1o
	 R54/3FfdSYwt33uJfdo7zFWUh6xeLl5hZClzdbqQgSl0Sx9lQb00yFikSJ6Lr+16t6
	 jZE01u1TJdMxQ==
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
Subject: [PATCH AUTOSEL 6.14 246/642] drm/amdgpu: Do not program AGP BAR regs under SRIOV in gfxhub_v1_0.c
Date: Mon,  5 May 2025 18:07:42 -0400
Message-Id: <20250505221419.2672473-246-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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


