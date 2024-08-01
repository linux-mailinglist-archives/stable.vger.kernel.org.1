Return-Path: <stable+bounces-65148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCE3943F27
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C461C2229F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8341E0235;
	Thu,  1 Aug 2024 00:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhCw9EiY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEDD1E0226;
	Thu,  1 Aug 2024 00:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472655; cv=none; b=cj4OWGz7x4IcxUYCEpMNEqhQDMBfLFTxUkEtOHSfJbA7ScXChxhx7M+ow4YKaH1BGP0fpOAs9BmQulhZqc1ZYWWrWd2xyxlDPO/x7e/asBPiWgNX+BdH+DQxfGzq3vNuW7ZGLN48tqH6gJow8IGCcyEgvrHA8BM0XyiOdZWt5w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472655; c=relaxed/simple;
	bh=k75stHD32wBEPIDsCFSMR2r2v5yJTF1MaAXt/r7yYHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uqoj485FupX5lRXzg1vVgPpfavXSqDQAlcr5GOId4C9Gt9dKg2nLPm10ghgGR3rzjTi3lZzYPsMtwM3pTFOx4UhqCKpGNDDXV98i4fqPNvcgECAHjKxq8b09X1G5LIDspw5FvyPgvdaz9XWT/fJSMNyx3oKaysaT0yi1RwBDPaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhCw9EiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A92C32786;
	Thu,  1 Aug 2024 00:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472655;
	bh=k75stHD32wBEPIDsCFSMR2r2v5yJTF1MaAXt/r7yYHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhCw9EiYiFcxY2DY2KAoabMCVTnkk9R1Dc+kxDoLSl2GMTKkIoE4ws9mFtNKj9HFh
	 nKEnJ1rnv3OxsZdzpnJkmaN8Pkalm7CC2gBj6IkrgT6bPtWaVSA60BLhJ6NMYxfTlN
	 0KXkFbRpUIfZQBmWjgzueO9yBqYhqbBeuKzqBHct5bMv7cnt5E557EhOYYh/42uJXf
	 sTUlR6ww0V2Ql/2BnlmXU8KKjnw5GKwiu3o7bKzx3kQnmmbdexMcdQQ7gRhJZ8GSZ8
	 ltcOOMP0XOALq2vf89BJm++051B65W8i6WjLsDXiYI9yWmk1RA4I9JmU2qSTjJs7bJ
	 kg/kqDzcvwRRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ma Jun <Jun.Ma2@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	shashank.sharma@amd.com,
	hannes@cmpxchg.org,
	friedrich.vock@gmx.de,
	andrealmeid@igalia.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 11/38] drm/amdgpu: Fix out-of-bounds write warning
Date: Wed, 31 Jul 2024 20:35:17 -0400
Message-ID: <20240801003643.3938534-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Ma Jun <Jun.Ma2@amd.com>

[ Upstream commit be1684930f5262a622d40ce7a6f1423530d87f89 ]

Check the ring type value to fix the out-of-bounds
write warning

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 6976f61be7341..b78feb8ba01e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -260,7 +260,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->priority = DRM_SCHED_PRIORITY_NORMAL;
 	mutex_init(&ring->priority_mutex);
 
-	if (!ring->no_scheduler) {
+	if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP_NUM) {
 		hw_ip = ring->funcs->type;
 		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
 		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
-- 
2.43.0


