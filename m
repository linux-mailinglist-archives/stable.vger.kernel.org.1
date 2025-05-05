Return-Path: <stable+bounces-140934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5201EAAACBA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D283B1BE1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E163A1250;
	Mon,  5 May 2025 23:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8vArT4S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D83A015D;
	Mon,  5 May 2025 23:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486933; cv=none; b=JNOnAWI9uiAKFsfydfbCpzRGNnmuwYurXMy2d3zaK6ml+fcYgci+wrlI21yAOvVY4dwMO+/pyVZmuSe7OYdoCz2yprpXuennQg6yB0G3MRN+auwBygniErBqpMkiD71yGRCDkWUNKSreX7M3XXE69+AKhqsPD6y6kmjn54s8uHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486933; c=relaxed/simple;
	bh=QJfy7XoR3GgHAWIN+riRyxgwzioOkcUWXnWokSKqXwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oILNW0RDWfKdCchZ0WeMZsCU8SVx0UF8/In37P0SBk8ojndekrw8UfkdUNAXmMXgnEC8SJjd62S6E62DUyeAXHwf95bMtAFxa6/X4NiwUnDJ7fJTOSvHc9Fu3QUUTHziJq9kNpcF9k5GddKIhaW+8fvVJC94VKk8c4E+eh5fYjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8vArT4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB06EC4CEE4;
	Mon,  5 May 2025 23:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486932;
	bh=QJfy7XoR3GgHAWIN+riRyxgwzioOkcUWXnWokSKqXwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8vArT4S0/rT/EEA/A5IyqX17q0rBo06GRGAHCiz9AK7SdH8R50Aau6xnt+gz6oc3
	 HQa/vkAqJMmojnoOHyM8oaEpis1DI6owVv62+faozXyR8guL7kkD8i+IIodE7hPH63
	 Y5ZevwereXDhcqo9+YhL18k6YKqz2cqgLnMhHswIVZQVXzWhB93FUV/oL9pcoqKw4P
	 YM8SivlaW3Yv14xrJZO+qDnVmIvGzN2/Iw/1kRRk2SnvqKUbZOVGimXlzTKO1//5qD
	 HLCxyJXWO0UURV8t58yTsJ/O8NTT67+kr6S55xR6pSBhIhhSh8qsXUBH3KrxUcXCPd
	 cwGy2/vBvVD3Q==
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
Subject: [PATCH AUTOSEL 5.15 066/153] drm/amdgpu: Do not program AGP BAR regs under SRIOV in gfxhub_v1_0.c
Date: Mon,  5 May 2025 19:11:53 -0400
Message-Id: <20250505231320.2695319-66-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index f51fd0688eca7..9b881d8413b14 100644
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


