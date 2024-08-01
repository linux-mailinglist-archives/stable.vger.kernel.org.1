Return-Path: <stable+bounces-64948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16278943CE8
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CF81C21546
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807BE43ADE;
	Thu,  1 Aug 2024 00:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5Ujm/cw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3506142AB3;
	Thu,  1 Aug 2024 00:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471677; cv=none; b=Odhc0r44+zEuoGwgedubySLNbke8ybgVS+YLS6eSruNTPOgWWsXPtUlGho80+lTk9b/q5o0/M/yEFBRrHVQjtvyCRQa7allsdzBpHvG7u0NAPbhygRQEocucsDyIocdU9dcpwG8o8+tVnJkVeP/hq4PilRFbAO7PaFab+ddCpYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471677; c=relaxed/simple;
	bh=o2jeISf03ig9ZsZkorSwiRwpgh5d2u7PJ4PzbOE/HvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhwm/RoqPNcKen5dH6zrkgxbDv9VRlAprg1ch0xyT0u98vXTzA/B510pm+vs4m+LgPO/6gddjJNmDA1crRXbVsIelzYISeI60Wov0JFITsFM0DXmhadvxonCmaT4RlXnXmVMiD5LDoU08sB7lsr1cnjUY1uOSOSt+1rhqrQyPss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5Ujm/cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FF4C116B1;
	Thu,  1 Aug 2024 00:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471676;
	bh=o2jeISf03ig9ZsZkorSwiRwpgh5d2u7PJ4PzbOE/HvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5Ujm/cwyFNi3MDNTcxpMZD/StIR5u+J2M68CVg2llFlFdLlGGJZ4ySgBCZfY1RMn
	 ksJmiUCpvdinNeEbEwbO8kJDDUMY5nBwDs38NvoxbvoaB28I3q1mtaci94VzHKt6jK
	 mnANKEMuBzvshg6eM0Ybn0HVz0ORGegA+OQwoJ/T4fyxdf3OPuhuA0yKrtSol3Q5hC
	 Y9dJME8lNfijJwDmmayTyrmWEh+aArclQgnyI6QACcvlZ5j30F2RAZ35iKVcmpxynl
	 +VlRT4/xLy9em7oP9Ep6cxPlpMvCMq/wOqzLBdIDNN21Qe1KH5K8gC9mClqehCxYwl
	 CaAswMF0pR9mQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Jun.Ma2@amd.com,
	shashank.sharma@amd.com,
	hannes@cmpxchg.org,
	andrealmeid@igalia.com,
	friedrich.vock@gmx.de,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 02/83] drm/amdgpu: fix overflowed array index read warning
Date: Wed, 31 Jul 2024 20:17:17 -0400
Message-ID: <20240801002107.3934037-2-sashal@kernel.org>
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

From: Tim Huang <Tim.Huang@amd.com>

[ Upstream commit ebbc2ada5c636a6a63d8316a3408753768f5aa9f ]

Clear overflowed array index read warning by cast operation.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index dbde3b41c0883..0bedffc4eb435 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -469,8 +469,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 					size_t size, loff_t *pos)
 {
 	struct amdgpu_ring *ring = file_inode(f)->i_private;
-	int r, i;
 	uint32_t value, result, early[3];
+	loff_t i;
+	int r;
 
 	if (*pos & 3 || size & 3)
 		return -EINVAL;
-- 
2.43.0


