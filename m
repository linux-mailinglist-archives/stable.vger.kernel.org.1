Return-Path: <stable+bounces-43360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 602DB8BF20E
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929A11C2373B
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C433916F281;
	Tue,  7 May 2024 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJIOPI26"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E916F274;
	Tue,  7 May 2024 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123487; cv=none; b=I5egSgoous6r8wxuScrAR9RAnVIv0ZKWfjDzca8dLTwUoGWEhXvhsry8MiDyjx3uvAwJeJ9UWeiiX2CdS7UcIamyPFBZQJqJryDb6yR4NJoi2SyP54BQJ422CQfLl7/ROfF58KKZPzy640eDlSAJPtSe+I+aZlsVdolsy99IVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123487; c=relaxed/simple;
	bh=Izw35QVQsTLTzboznqrLCxwrPV1y5ztO80AnI0ghQyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucgeE6zvV2v7hpKYudF6mJjz1TUlu6YPzqizFnZ9MQg9n6sbEJ991284aWk0QO2L9KGQYV2fASa4R7J9Ve5o+5BPBTF+qobe76p5p5q1DGcLoA2donw+w7CUwMnuqMT9EAv+6F1xPlPkjNsIEUnIsiehCxZgVOThMqu1PB9xaLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJIOPI26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6B3C4DDE0;
	Tue,  7 May 2024 23:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123487;
	bh=Izw35QVQsTLTzboznqrLCxwrPV1y5ztO80AnI0ghQyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJIOPI26LC95GJQBdn31FpfE5GTZzQLNkcqDkUEq4yj/tDVFiD2I5GjsRh2J/Mi+T
	 Ifu88OZkeBVNdGtaR2unCdMLNCkG5R00gNUp2/Z54nXgffO7xqS1WnZjeOWRKIZZ2K
	 MtRgrM2RA+S5BBwnWPUbUhqMwXTbCQQ1gJtp8KCHduen/5YsnS/MN6EPtxQtGwbJP2
	 RMA7Lk7ed61FvLcCygqz3GjNzB59iZa2nzToYvnTFAk1NRbWC2Tm6xXwekD5kimr7q
	 BWKmGoEV9lWjpmDBkJqize/rXD6hco+QJQLf09oJRjGiN/XWfjqe/yRayl0JZ/Exxi
	 4wMirhQ3wuujw==
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
Subject: [PATCH AUTOSEL 6.6 28/43] drm/amdgpu: Fix VRAM memory accounting
Date: Tue,  7 May 2024 19:09:49 -0400
Message-ID: <20240507231033.393285-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
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
index 15c5a2533ba60..704567885c7a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -213,7 +213,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
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


