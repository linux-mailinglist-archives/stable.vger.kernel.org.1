Return-Path: <stable+bounces-95239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0899D747B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C11284BAB
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740A61FBE83;
	Sun, 24 Nov 2024 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnfD5uVl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317171B3949;
	Sun, 24 Nov 2024 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456458; cv=none; b=DR7vzgd4uJ+ngL8NMwY+JSzX4MGik8imqFE2uBYXHp876sEjGLAKhqDVRPHsFd9Zhita7wWG/9oIMIYuLwWd4z4aqxz/ZIB4BCszmev6B6nSxq9v5gF8QwMT5VPQOMp92y1QPdwgWOhSOhdjjIon6D6bzzYAAyUoMgS5eKDK/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456458; c=relaxed/simple;
	bh=G8GaEfhVAJkdNU9y7l6PrKPcv77I/Gpo8fMcXWS65Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8q2N3YH1DLKJ5k0XoupYoKLiQx/l3Rso6DtocZf9LxK5UxKm+N4abXlA61QxxzKPOr4txwRCpkDxyrnR0K7kqIZQIkxnvQ5mdGsTnq6t8kR92wFZe39zOEDryGLBNI0oW8T0r/xu0jluqEdfClUfrd4LttaqlpTNUIyYddYI+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnfD5uVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61E0C4CECC;
	Sun, 24 Nov 2024 13:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456458;
	bh=G8GaEfhVAJkdNU9y7l6PrKPcv77I/Gpo8fMcXWS65Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qnfD5uVlvmls4rohX3cUaDeBxGb44k31Ut9kYyzyIoOghZAb/CDr8fbhy9cwTbZ1v
	 470bh3ZTQPvsFCW4Fdc/yDYPsavfdw3Ye3ss3xkTTBmLdl2WLWU8FJghkI5yQumBtg
	 xGjBrdeKGKK7DhWmxCQ2eJQvQ0Ou8hJEpKd6qdXYkWJLfAyPQ0D9BoIi9Q0JWS8Et5
	 z6DXo1WRfUlMM/DqEJpmimHmg2N4MLDxsjpRYz1Q1BklSmp729pV5wJUQjevECuEW5
	 PCsrXQqPVqCYDae2iRlIVjejg5ZFBTPr1BbnTF63YFHYkH3VpG4ZEuVsNur+8jONzE
	 k7Y90YPoZe4Lw==
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
Subject: [PATCH AUTOSEL 5.10 04/33] drm/radeon/r600_cs: Fix possible int overflow in r600_packet3_check()
Date: Sun, 24 Nov 2024 08:53:16 -0500
Message-ID: <20241124135410.3349976-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index 1e6ad9daff534..c738740f8b19e 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -2102,7 +2102,7 @@ static int r600_packet3_check(struct radeon_cs_parser *p,
 				return -EINVAL;
 			}
 
-			offset = radeon_get_ib_value(p, idx+1) << 8;
+			offset = (u64)radeon_get_ib_value(p, idx+1) << 8;
 			if (offset != track->vgt_strmout_bo_offset[idx_value]) {
 				DRM_ERROR("bad STRMOUT_BASE_UPDATE, bo offset does not match: 0x%llx, 0x%x\n",
 					  offset, track->vgt_strmout_bo_offset[idx_value]);
-- 
2.43.0


