Return-Path: <stable+bounces-65045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F059C943DCD
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BE91F21723
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F8E1CEE14;
	Thu,  1 Aug 2024 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mty3YoGN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5751CEE10;
	Thu,  1 Aug 2024 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472160; cv=none; b=CSOXHbG8vmmhsSh7y5A3u85VAEHYIdJUZQevNRA0fyUhTo6WzeHDNBMKLXRxhCAbNzerGmVwjxYLtw3SmFvt1n5xzC1AXU/spFJkcNGGEmdoNvoOXdbesZOD0cHaxv0ebY+UmuHgjYu+mG/tuOTk492T626gH1+UDOBOkJbHyTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472160; c=relaxed/simple;
	bh=fcFyv7j6W6exUlVaevB2O95QQRiDOt2xr1T1ykcKJD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snG/xiRZFUmgkY+6XLHJJ2hmQS9ETp4sam5086B7celAtGjBUJdTsH588rg5dRbFAbaOq+vLPY8osHS9MSh+yHs14wXJ3AKp+q1OQp93ffDilLlv4uQasUOMxb6WUfX6jNCA0z8kbdA9qTaR70x9u06w1BVhEgfQJ/Fhn2dcKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mty3YoGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667EFC32786;
	Thu,  1 Aug 2024 00:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472160;
	bh=fcFyv7j6W6exUlVaevB2O95QQRiDOt2xr1T1ykcKJD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mty3YoGNQGPpDzJp9bUtxdDpAs1nuGA+ShnOxNupRkOE6AZgeRw/mg55ck70LO6WY
	 +MIfA1hj/z4aXKGxeI9rNPocFgIVB8GmNXTNXF0wFbh0bdFSEFrZJF6b2Jx4DhxyNT
	 4YCkhFpFnTLvqrM6Qr7W6B6/MfQSaDqNp/FUGzEdSsNeDmIU8yRtLXwi2l7tDe9NRh
	 8SeI3efEcykFGpJxOO5kpFDIqwJyQ8Sda9cQ2eoZH06jJPfUYPP5X005XdPb97amyV
	 LNqiBxsMKVdhJpc/RuCv4moUUYaWefJ3Bqhycnm78XiGnLZypEJgu0QDay+k52JlcS
	 fFwMMii0uoiow==
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
	hannes@cmpxchg.org,
	friedrich.vock@gmx.de,
	andrealmeid@igalia.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 16/61] drm/amdgpu: Fix out-of-bounds write warning
Date: Wed, 31 Jul 2024 20:25:34 -0400
Message-ID: <20240801002803.3935985-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002803.3935985-1-sashal@kernel.org>
References: <20240801002803.3935985-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index 2001c7d27a53e..cb73d06e1d38d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -324,7 +324,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->max_dw = max_dw;
 	ring->hw_prio = hw_prio;
 
-	if (!ring->no_scheduler) {
+	if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP_NUM) {
 		hw_ip = ring->funcs->type;
 		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
 		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
-- 
2.43.0


