Return-Path: <stable+bounces-95297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D92C9D7503
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385B91682BF
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DC61B6D18;
	Sun, 24 Nov 2024 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpF9zXol"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD261B6CFE;
	Sun, 24 Nov 2024 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456633; cv=none; b=WeiGkh6kiHgS31B3C9ZbvG0a3ZqDFGVt0QFfLeIUKLv3VzphTQrt3OqMcQnk/oYcoHP3Gjxb0c0thNaGleY5SaHgulRzsZlP0nuiFAPHRRmz6O9A+mQWfx5Y3c4eZMQUvO5D3SZ6WWleG32V0IBbnykF0TAE9J3/Xi2neyhxyNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456633; c=relaxed/simple;
	bh=HxrGBajcKqbur6utAJ0iiZ+WwhJF2qQdxREm1N0uIR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQC/GJyaIQPSYmwMUYzC73Nz7v+UOU7Anxm/XKpFisPuZ6PyMmG8+5f/6Jce8KJ/7f0GWa0I1/S5YSg34Db9KHq1qKSJG5SCk4m3WDbJJiD3XFirJh+grQ+pm0sAckRFqBcfk/tY/xg0NyPXu+qWX37aVukk49jMuPiZsBUSVLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpF9zXol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B08FC4CECC;
	Sun, 24 Nov 2024 13:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456632;
	bh=HxrGBajcKqbur6utAJ0iiZ+WwhJF2qQdxREm1N0uIR4=;
	h=From:To:Cc:Subject:Date:From;
	b=QpF9zXolPZBgITMVp1lKIzhwC07riaK/0OwADQQxMzC8OFHM6RHMQFWw4KfZXZ7Lx
	 dYMzTgKkjNAndlZjejnVRNy5jjwpWqH97DGP8nGP9tu1Lh0yg95jX32z8vKnP0jg7H
	 78SSriaj9nOuykur43d9fyKhNDzMuZZW5Vy8jhci1YhgmUKGSrQlgTGBqD5UluM6La
	 4Idec28l9OMLuCJkJjvAt58SiJZeTuGnf3YYv+/qd5cUzRWLoP4KkyekwKK9CZcrK/
	 irA0fTPGuVla4WS6mDTrXWe+MR3mo1EbUL/fDmRzd9OeVxH5/FYdxo+SmJvjMlDize
	 9VhNwQVXciSng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 01/21] drm/radeon/r600_cs: Fix possible int overflow in r600_packet3_check()
Date: Sun, 24 Nov 2024 08:56:34 -0500
Message-ID: <20241124135709.3351371-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
Content-Transfer-Encoding: 8bit

From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>

[ Upstream commit a1e2da6a5072f8abe5b0feaa91a5bcd9dc544a04 ]

It is possible, although unlikely, that an integer overflow will occur
when the result of radeon_get_ib_value() is shifted to the left.

Avoid it by casting one of the operands to larger data type (u64).

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/r600_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r600_cs.c
index b6bdfb3f4a7f7..580ca4f753531 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -2104,7 +2104,7 @@ static int r600_packet3_check(struct radeon_cs_parser *p,
 				return -EINVAL;
 			}
 
-			offset = radeon_get_ib_value(p, idx+1) << 8;
+			offset = (u64)radeon_get_ib_value(p, idx+1) << 8;
 			if (offset != track->vgt_strmout_bo_offset[idx_value]) {
 				DRM_ERROR("bad STRMOUT_BASE_UPDATE, bo offset does not match: 0x%llx, 0x%x\n",
 					  offset, track->vgt_strmout_bo_offset[idx_value]);
-- 
2.43.0


