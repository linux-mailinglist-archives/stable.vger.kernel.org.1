Return-Path: <stable+bounces-64926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB27943CA0
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316FA288516
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB7C1C8FA0;
	Thu,  1 Aug 2024 00:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6nCt9Ee"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AD314D2BE;
	Thu,  1 Aug 2024 00:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471466; cv=none; b=e/IjYNZO+cPjwz3Ng6CBrH3ICw3TRNp2LdGILi9P297z7LC/hHuOcF8d/sLfjrrwK86pNJRZrMpSJ5k2zfN070KbEOh1BiVTEivV9//JiUymmz0OjXIqRlhwCNsN/xqKsvU21yq+LYbVnx3dR6Rw7dwsLYtC51hAwqYgjlyhECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471466; c=relaxed/simple;
	bh=SWgEroS/GkL8CcFagMVaUBw49wtARMIKIVtQQ+y/E0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqVm0DQmBZ96aBaITZEEtcx5d9M3QEIfsZqrgX6drTSQtECg85sYQ2wu9tg8Qzzrjermt93BteXhnex6RL7rMsqmIWiSnn3rTJoJrimlualOkXkgyLQ8k8+OVD2431tRo67Gt7QO7kgSxyEEqnp2o1/DdtAZbwZTGdErF8Jaxtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6nCt9Ee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52912C4AF0C;
	Thu,  1 Aug 2024 00:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471466;
	bh=SWgEroS/GkL8CcFagMVaUBw49wtARMIKIVtQQ+y/E0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L6nCt9Ee8VfopqLNhGT4Es4GqiQivFc4oBhJe2N7ZNcMznWw6xI5vnrCFa+pFVXzY
	 ttOOUBp9tpCLq9F8fz3ohEDI/IRlQzzgaE95nGI0tyqPqPDYmsLpunl8AZI0ILCoOI
	 o0CwuR7GU9U0iYU/nYQnUgBCiFmJxoCOm98UpNrf+tDeiRU/9yzqoHczvpGk/wjIJA
	 3ckB95gZLq5BPeJBOGHdSWORgrlxANl+VNLUo/piK1uKGMYd6C5F0Oa7gYct0XgIHu
	 331h2n9m2JwVMaVq2h0zqFVh4+JvxHUq80lXGFMzq0o5Tzr0yfwvSxSP5BLYv3TJ67
	 glWBCE75Ir8qQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bob Zhou <bob.zhou@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Felix.Kuehling@amd.com,
	Yunxiang.Li@amd.com,
	yifan1.zhang@amd.com,
	lijo.lazar@amd.com,
	Hawking.Zhang@amd.com,
	srinivasan.shanmugam@amd.com,
	mario.limonciello@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 101/121] drm/amdgpu: add missing error handling in function amdgpu_gmc_flush_gpu_tlb_pasid
Date: Wed, 31 Jul 2024 20:00:39 -0400
Message-ID: <20240801000834.3930818-101-sashal@kernel.org>
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

From: Bob Zhou <bob.zhou@amd.com>

[ Upstream commit 9ff2e14cf013fa887e269bdc5ea3cffacada8635 ]

Fix the unchecked return value warning reported by Coverity,
so add error handling.

Signed-off-by: Bob Zhou <bob.zhou@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 08b9dfb653355..1f02d282cfcd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -720,7 +720,11 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 			ndw += kiq->pmf->invalidate_tlbs_size;
 
 		spin_lock(&adev->gfx.kiq[inst].ring_lock);
-		amdgpu_ring_alloc(ring, ndw);
+		r = amdgpu_ring_alloc(ring, ndw);
+		if (r) {
+			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
+			goto error_unlock_reset;
+		}
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
 			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
 
-- 
2.43.0


