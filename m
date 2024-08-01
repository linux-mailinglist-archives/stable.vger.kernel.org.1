Return-Path: <stable+bounces-64922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C094E943C84
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6BE1F26D0C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAFB14D28E;
	Thu,  1 Aug 2024 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAuCpQan"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3FF2F5E;
	Thu,  1 Aug 2024 00:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471441; cv=none; b=G3O/hmRIyZ5zFsqK0EUuETM7/mLl8T+I43PeV/OQZ+PXKfqlVQZ4dausMG/LbIIJy6B3OQSaCzJYRhBQFXsc6U3gS4GQtTk7LAymA8/372QBW1/4oAGaRn4tHKx1iNuaUoGI7pfEWREEnGuEKkLEP3qCQLOpd5vPR4yKXJWDlII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471441; c=relaxed/simple;
	bh=pC+GNYtOW75YVqGZ4bYScRzaCNjNeIHNIryyxjWUm3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ja1pcxxx/UoGSfnku88BMa4nOz9G/d2ND/k6bVXc9ANOg9fhbEYSnN2O797mFxRAqwlurl2WPo/2TkqUovEco6WlMCqOM03U1Xo4nGMQAzZnsFoUfqcn6N/aozdoDD5cSO8H2F+lAAYD/V5wsX7lvkbsadDR30aOX/5vDwQHp5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAuCpQan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1EAC4AF0E;
	Thu,  1 Aug 2024 00:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471441;
	bh=pC+GNYtOW75YVqGZ4bYScRzaCNjNeIHNIryyxjWUm3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gAuCpQanFVaa/0Q3WPLOH3HXjjc3JULIbDvOFRQ1AF3+TTp7BNtLsR9DUaiypnnm1
	 9qlm3qRGLi8W9ybzORIFBBLy3+cN6A8C2+anj0XF3n1TYm3d0sq6zdFIKL7n0/BJJq
	 WhHp9KFtKziA7VJPLJ+4nZAMjple/wz9V68E5lHFsWXFJLsWGsGnD1An3oeU0VGOMg
	 b01OI+X8idNTGwmZL5nzrP0SJ1/BFEvvdFOT0jQZrIxUgF6e/hbZIqGxEtBlL7DggC
	 THEY/Hyn6FlwcBFSdlxgBtqDWJafZrAWCI0SoS1/xqKZvpoprzbUCIzIYbCjBVwblE
	 A01aNumNwhrFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hawking Zhang <Hawking.Zhang@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Zhigang.Luo@amd.com,
	yifan1.zhang@amd.com,
	lijo.lazar@amd.com,
	victorchengchi.lu@amd.com,
	Felix.Kuehling@amd.com,
	srinivasan.shanmugam@amd.com,
	David.Francis@amd.com,
	kevinyang.wang@amd.com,
	lang.yu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 097/121] drm/amdgpu: Fix register access violation
Date: Wed, 31 Jul 2024 20:00:35 -0400
Message-ID: <20240801000834.3930818-97-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Hawking Zhang <Hawking.Zhang@amd.com>

[ Upstream commit 9da0f7736763aa0fbf63bb15060c6827135f3f67 ]

fault_status is read only register. fault_cntl
is not accessible from guest environment.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 3 ++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  | 8 +++++---
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 77df8c9cbad2f..9e10e552952e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -627,9 +627,11 @@ static bool gfxhub_v1_2_query_utcl2_poison_status(struct amdgpu_device *adev,
 
 	status = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regVM_L2_PROTECTION_FAULT_STATUS);
 	fed = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
-	/* reset page fault status */
-	WREG32_P(SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id),
-			regVM_L2_PROTECTION_FAULT_STATUS), 1, ~1);
+	if (!amdgpu_sriov_vf(adev)) {
+		/* clear page fault status and address */
+		WREG32_P(SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id),
+			 regVM_L2_PROTECTION_FAULT_CNTL), 1, ~1);
+	}
 
 	return fed;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c4ec1358f3aa6..67f36a79c6f41 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -671,7 +671,8 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	    (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2)))
 		return 0;
 
-	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
+	if (!amdgpu_sriov_vf(adev))
+		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
 	amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status, vmhub);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 7a1ff298417ab..8d7267a013d24 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -566,9 +566,11 @@ static bool mmhub_v1_8_query_utcl2_poison_status(struct amdgpu_device *adev,
 
 	status = RREG32_SOC15(MMHUB, hub_inst, regVM_L2_PROTECTION_FAULT_STATUS);
 	fed = REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
-	/* reset page fault status */
-	WREG32_P(SOC15_REG_OFFSET(MMHUB, hub_inst,
-			regVM_L2_PROTECTION_FAULT_STATUS), 1, ~1);
+	if (!amdgpu_sriov_vf(adev)) {
+		/* clear page fault status and address */
+		WREG32_P(SOC15_REG_OFFSET(MMHUB, hub_inst,
+			 regVM_L2_PROTECTION_FAULT_STATUS), 1, ~1);
+	}
 
 	return fed;
 }
-- 
2.43.0


