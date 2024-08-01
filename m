Return-Path: <stable+bounces-65176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9678943F72
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D6AB2BF32
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A0A139E;
	Thu,  1 Aug 2024 00:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bInIwnIG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849251E566B;
	Thu,  1 Aug 2024 00:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472761; cv=none; b=J1bDuagXCchV5bHnsij/ZGe2nj8Dot/g77rqxuS/0vAgKqYWJm4a0dJAtel88cS2E7++bSQ916+U8POhbRO6hS2hVHuYj58jZ4nbVoCquNQ1ga279iCO+j5RZ6qff24OWHiIMFG/NpuKM0CzkC/4XtqB3wJVZDz73N3X2s5wMa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472761; c=relaxed/simple;
	bh=IP2BBatlq30TniBtsAgcYpqqBbh9psY2E9LM11RzS9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FxqhUSr3+La39/eZmvvIvZ0aKsAwkinVYBCMN+sTGzPEC3zzrOVWNgznzdYL1AjWuKh/1hz2GEPqiVgJgjhmu1RM/7TvdyUXY5k6/bU/Z/zVQ/Wslpp6SstIwuMA+QZf25fNLdlM21AznkmWbpOGihsvRAZJYwUFStbYAnw/CQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bInIwnIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971C0C116B1;
	Thu,  1 Aug 2024 00:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472761;
	bh=IP2BBatlq30TniBtsAgcYpqqBbh9psY2E9LM11RzS9k=;
	h=From:To:Cc:Subject:Date:From;
	b=bInIwnIGeYs2hsFPdznqBKwLRjo5V3oFMIlErQd1cDDmIPvOkIDb2MuOOO5kFGpiZ
	 qsx73qv+MhPOyJwSWYmHMbB/yiURdyRVSjtXy8w/AQC8NmQPb826g6W6AYZxPHEXy/
	 eVWDan+E6D4s+DRb6bF7lO7CKXiZOFdkt3GBsef1IK3QP2cJ1BxB0WrouY1AE2wLSe
	 TL6KN+edJpczKoha34evhy6vcOHx27rnoG3hmESpP5dI40c+ENQZh7xZR66sTOg0z3
	 fLMDJ46h8XAxkEeIk5UdyyK+pELIHxFjMTt2ZlpO1ZkNZqdATHgW51QXOrSgC6TuDW
	 7FcRqXK5NGodw==
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
	hannes@cmpxchg.org,
	shashank.sharma@amd.com,
	friedrich.vock@gmx.de,
	andrealmeid@igalia.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 01/22] drm/amdgpu: fix overflowed array index read warning
Date: Wed, 31 Jul 2024 20:38:30 -0400
Message-ID: <20240801003918.3939431-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
index e5c83e164d82a..8fafda87d4ce8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -437,8 +437,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
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


