Return-Path: <stable+bounces-95203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 533679D7671
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 18:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15AB8B356C5
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A3C1E260B;
	Sun, 24 Nov 2024 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hp1K5VjB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801101E2605;
	Sun, 24 Nov 2024 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456347; cv=none; b=AUjTtFGefRaQADRIl9PnsrJ4/UwoU6rDYYwJAclliacFew/8wFO1GZFuh2UWbNd6WW0e5TkcOVU5zJyrAGAhUmGRrBCLjrYaIcirx1PUIHB3nmi7T/XsQspiKJpMLDw1IJSRmdLor/DnT0w+8+cBlo2f7jMLUq3lSLzKLvvZXb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456347; c=relaxed/simple;
	bh=+dGWbWYce8ne2vfZcQ4Aogy79GqVwJep0ojU6GjFDwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqiE5QIvl8RD3p0BvAHAU2xB8/r4XKRHPgR+BfZ6ve9kNmPJtkFeYx46PxWEITj44Ep8la+52cDFVCapFI90PYtBahDK1uGaMGCU1aDwSyQZX3jmbYHeoZh/gY1ZBUWzrxZsbO6NE/4EOdyU/gRqBFXxpoiSWvHdasUCibqVYNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hp1K5VjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37F1C4CED6;
	Sun, 24 Nov 2024 13:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456347;
	bh=+dGWbWYce8ne2vfZcQ4Aogy79GqVwJep0ojU6GjFDwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hp1K5VjBF8OctOhx40QJnvcFGanun07XTFSq3tBZ4Cz+4kdwIfxGi+TfF6HGP5C2K
	 UkprOhv/dY0lpASUQN11CxHRXPWSrooKDkVO21DAEoOgyMnTsdXofRIfe7MMiq17lR
	 AXyx+PQHlMt8lTmO8pBGJ1LMp5cSVKHg9vYytL0aZQzjBrBWU7VOgJOcZO9bmuJtm0
	 eZjGkWw2ikpZmYuiXfjTEVKqigspsKcWsOb8HK4ZYV8s77tdonHzKAOBqjRhIQWJ/v
	 bOZoqc4UzIitFURUDiBGtQ3TX0+AKhDdayOuppBekkBOjbY5jeQGxKGF8ZfcyPrkYd
	 Ujb3boSYPHlfw==
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
Subject: [PATCH AUTOSEL 5.15 04/36] drm/radeon/r600_cs: Fix possible int overflow in r600_packet3_check()
Date: Sun, 24 Nov 2024 08:51:18 -0500
Message-ID: <20241124135219.3349183-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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
index 6ade5dd470d5f..7fe2c49854987 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -2106,7 +2106,7 @@ static int r600_packet3_check(struct radeon_cs_parser *p,
 				return -EINVAL;
 			}
 
-			offset = radeon_get_ib_value(p, idx+1) << 8;
+			offset = (u64)radeon_get_ib_value(p, idx+1) << 8;
 			if (offset != track->vgt_strmout_bo_offset[idx_value]) {
 				DRM_ERROR("bad STRMOUT_BASE_UPDATE, bo offset does not match: 0x%llx, 0x%x\n",
 					  offset, track->vgt_strmout_bo_offset[idx_value]);
-- 
2.43.0


