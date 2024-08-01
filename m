Return-Path: <stable+bounces-65031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9043A943DB7
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0AA51C20C26
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2A31487E2;
	Thu,  1 Aug 2024 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKL1MrAd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD65148300;
	Thu,  1 Aug 2024 00:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472092; cv=none; b=C5AF3MExeBXTs1g9Yt6RDALrQgzYCp7AyZ8XPQW76bXXvfmNuOAfU6r/SmRS8R2DvLexw+0H7u5Y/3VQGJsP46ZXJfsIKLMsbJSABb9cjhmSqLo8jt8Wj2lWzWYSSEoOAeRHoyJQdvROhPLaKrtvupBNaxIYThHiGWf+XP2zUbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472092; c=relaxed/simple;
	bh=6tY1AvApnn8sYRmPZ5tGiNkXafrXSm7d+iiI6CS7I/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXqk8dKgpbMyHq8GE/KSBO88JhYrtWE84VzYZWPp9fSero4cuTVbLuuFvieY8iES1pptc6pTV7ZE9UDdK2eAAJBGMQGU8o+aoxrsODa0t0+GC7WUpTp03fxAUiAgRzYIVDI4x9ayQLmEUU+XDIfuYSm8lYbJl6gStPJCJXRpJVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKL1MrAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA94C116B1;
	Thu,  1 Aug 2024 00:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472091;
	bh=6tY1AvApnn8sYRmPZ5tGiNkXafrXSm7d+iiI6CS7I/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HKL1MrAdIlL/iCoWXTC0b/7hym94rvROpo/4MGm4KS3M/lG5kCAhCsNifdsswKNfC
	 xBU03gbTzsnQJKx8PBy+fe7tbUyeI9olH8l4lxXvUEWe/g9qyNOugYT0KldWYklWFo
	 qxGjUUn8PL4n8i0AqGw0Mlx2GNejbhcp+eLPTR2PhJoU0E0MQH0kw9LOUUrft7f7o6
	 j7ssXGN/Ok/lIvgKivATJZtBIlLJKlbChAKyYxNf2tYgG9xAYVCAbIPL2o3ZopnE2r
	 Ip50rKz/hPfylbiLqGMaRYjj8s60op170Mn6CdX8YW8cylaiUcxlKe9OfV+RS4WKXD
	 mpAIG+EZAK6aQ==
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
	andrealmeid@igalia.com,
	friedrich.vock@gmx.de,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 02/61] drm/amdgpu: fix overflowed array index read warning
Date: Wed, 31 Jul 2024 20:25:20 -0400
Message-ID: <20240801002803.3935985-2-sashal@kernel.org>
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
index 296b2d5976af7..2001c7d27a53e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -434,8 +434,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
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


