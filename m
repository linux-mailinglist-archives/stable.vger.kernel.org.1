Return-Path: <stable+bounces-64968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E25943D16
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD72A28337C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44692139DA;
	Thu,  1 Aug 2024 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMpnL83N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE8515749A;
	Thu,  1 Aug 2024 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471791; cv=none; b=kAl/RwMeXnvv/v/HiO1noGboX2DvatzTB9fzruDT9woLr/LFw3oDjEWoegQ010AOvayXnfpRz0HdXl+930gVNF7fgWSQUJynKsMCQBb2weY20piCvYFEHQ/y58LMqSIDeCr8WCqVpASiYBrCtwUA/0/uw4Y23bA3aFejQ59A+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471791; c=relaxed/simple;
	bh=mdtSGVThuocfhAncG/yE9HLunHNL+4zIVSo0VUb1UGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjjBaP8AOPyUeeh2BmkL9rdL+tErOejAs5T/Pr7j/avKgTexvEQQe7X8AOMEEV6u9WRCcSYX5jZIlmtZYDRJfapeb29rtOjsMAJUalu6UvzcKGx3aHFRu1/2jeYnf/hg83Ud7hUx0W/6v3mpH5fha0vC2hGKO8jEm5PHUDIX0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMpnL83N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4606C4AF0E;
	Thu,  1 Aug 2024 00:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471791;
	bh=mdtSGVThuocfhAncG/yE9HLunHNL+4zIVSo0VUb1UGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vMpnL83NEem4PPUrj1N3Oul2PdhY9E4ixcpqiYo/FIGBSTHELJJkwq3qwfvyNbDoA
	 dTrZMj0a5GNMroUdjQ+pJHJ+c9YW7Wt8nKUy3Ktg7ecTgCWxNIS6Dva778yL3mWMgP
	 DwqfVTVcd1L9QuUuZ9SAThigPmyc8GURaiOfpsi6WdIJagzDnj5W9N7hLYHPBJuM/k
	 wLI3AcrcOProDD5FylOKlUv8HyAEi+N4Zzdnrlyce6KaqHOR4AywiW0DQE/JHAh+CT
	 b1JOuhuvRurkiMWJfJJw8y03x+szpWcq1tGEBarZYvgrEgS3DcE9mAt7Gcrep7z2YF
	 Wsr3h5m6wAvtA==
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
	andrealmeid@igalia.com,
	friedrich.vock@gmx.de,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 22/83] drm/amdgpu: Fix out-of-bounds write warning
Date: Wed, 31 Jul 2024 20:17:37 -0400
Message-ID: <20240801002107.3934037-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 0bedffc4eb435..f44b303ae287a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -352,7 +352,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->max_dw = max_dw;
 	ring->hw_prio = hw_prio;
 
-	if (!ring->no_scheduler) {
+	if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP_NUM) {
 		hw_ip = ring->funcs->type;
 		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
 		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
-- 
2.43.0


