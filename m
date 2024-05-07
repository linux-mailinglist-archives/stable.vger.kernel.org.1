Return-Path: <stable+bounces-43314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAD48BF1A6
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9AF1C22369
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964DC135413;
	Tue,  7 May 2024 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9s4CWCq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE9144D0E;
	Tue,  7 May 2024 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123349; cv=none; b=mavOaJfBREJuOBIuHqNbJrMhWbNv2goX29yS9haSoKMq31OKqAg7P5bpVRNlf1S0RaNaLMxVfGadoqMm8Yi+MX5m3quvVNc3Tfa1tmVAqT4hMirfl3qnxRaFSBWM3lvYy4ZQzgHk6q2tvx+npizcJQq/uheCX0qNTi4fOx7t95E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123349; c=relaxed/simple;
	bh=TC1fHbwX4lCqA9LuinqAvLD4Tet9hyjvajiKyUSSdPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBGVwZAFjQeMCdL/fEcwxWIXoZsvIa3biZ4l+OTtpr29n9VxKuU9MYkYv5GmIt17qxlK/R8aDxNXSLKO+kiry9DcxrooNjRC3TYt3636RpjgW1DwC8O2LJYu4z8+mS3juurXw2UTNFV2lut5L0RzT7LO0EljdnnBvjq+iBvNi3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9s4CWCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF039C4AF68;
	Tue,  7 May 2024 23:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123349;
	bh=TC1fHbwX4lCqA9LuinqAvLD4Tet9hyjvajiKyUSSdPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N9s4CWCqkLwaLVB7BVI3qB4SZ8ZtZCZD5JYpvjFWC0NfF9Hk1ayINANny1eFBKV4/
	 PVUN55Vl6HIcKb9vHIs74BB8IkXGSzkXYQHe9g958j06GsVndr5Fs7sDoFjnM5MfHL
	 ZWPryPpQWxVmc8sFAzuD1PrnBQ8ktbATViT5rA4xiWvCJh5JtbiJYHXwtRkd6TAqtZ
	 XPozEbqB5pvAjzNNvrJNLVUw0jMg7WejA6UOpSJ9YkSm34UFSpPndLH2SWh9v2r/ys
	 75by9Izu8yLKYY45ATTqdARoUWBmu5n0+HQD1LzSiIMcUir7zhwTAaeUGJINaCr0c1
	 3bHnS9XekBX3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mukul Joshi <mukul.joshi@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 35/52] drm/amdgpu: Fix VRAM memory accounting
Date: Tue,  7 May 2024 19:07:01 -0400
Message-ID: <20240507230800.392128-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
Content-Transfer-Encoding: 8bit

From: Mukul Joshi <mukul.joshi@amd.com>

[ Upstream commit f06446ef23216090d1ee8ede1a7d7ae430c22dcc ]

Subtract the VRAM pinned memory when checking for available memory
in amdgpu_amdkfd_reserve_mem_limit function since that memory is not
available for use.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index daa66eb4f722b..b1e2dd52e643d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -220,7 +220,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
 	     kfd_mem_limit.max_ttm_mem_limit) ||
 	    (adev && xcp_id >= 0 && adev->kfd.vram_used[xcp_id] + vram_needed >
-	     vram_size - reserved_for_pt)) {
+	     vram_size - reserved_for_pt - atomic64_read(&adev->vram_pin_size))) {
 		ret = -ENOMEM;
 		goto release;
 	}
-- 
2.43.0


