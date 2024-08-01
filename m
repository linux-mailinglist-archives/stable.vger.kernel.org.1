Return-Path: <stable+bounces-64967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234B1943D14
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BBE1B21365
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9D5157478;
	Thu,  1 Aug 2024 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcRwUBf+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BE0156F5B;
	Thu,  1 Aug 2024 00:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471787; cv=none; b=fJ0ocxoPrU4C0MYBGAg03J1I9j1/ktOwff98Hk1NR+p+15rF1ardf2W9WQXGLGUxkskQrBjM2rlA+KYQmkg8P+t/sgm7GgbQd5FY09JbsHjDAdRyHCXwaCnnxyBNRdOtRfD7lFvFyoEpD3JXZHfpctcqCJ4X7XnChXDWy3Z+WR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471787; c=relaxed/simple;
	bh=5dv3H7JAxGTY9qF4NzFQWWyQru6NosY6yTo7xygdZMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j44R9EhMR92iQfYBJtVSM2Bk+ghkETV8sfSfNpJ3VNe4cnpt2DmDjqE7DZUUIWuw/GlWguKB4udYA+bIbRU/5KnIAjzvbQ3rkjTK1NgK25UsaBnuEpXkoqGni/52ZDU0df/FNqQwAj7cZ/bN1k2kbR8/2Fyeh1xsWULq8ovOiYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcRwUBf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5591C32786;
	Thu,  1 Aug 2024 00:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471786;
	bh=5dv3H7JAxGTY9qF4NzFQWWyQru6NosY6yTo7xygdZMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pcRwUBf+hu2YNNsX7ME8A93meKcN3oT8eESOCDkS/E83GZO/0zGGc7eRjQYmJ2NDf
	 cViAUKogpCO+95IO7h+20mdFvmj5nWaYWQjXmDcpXIHGlLxXApDhPnQxx+lGpP5Xvf
	 eFyBW+LiwbTir8aU1GtGygEkScH8zX+/PbwGjZLHetJGJFWD4PLwchNIyghB8g+11q
	 jQjGzetjjWmjUXjWPR0U/sjydbUSMosJzHT3X22Qx4u4mWK+AcDh/PqmYmwtO/5E+B
	 x/1NjcLuZMsIeQEftLwOhGYVLnRJxrQ5D+0bCgGfoecw1CaYN1A1ltKCmR6BvERX2N
	 V4mOJLXkBov/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Asad Kamal <asad.kamal@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	mario.limonciello@amd.com,
	candice.li@amd.com,
	Jun.Ma2@amd.com,
	victorchengchi.lu@amd.com,
	andrealmeid@igalia.com,
	hamza.mahfooz@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 21/83] drm/amd/amdgpu: Check tbo resource pointer
Date: Wed, 31 Jul 2024 20:17:36 -0400
Message-ID: <20240801002107.3934037-21-sashal@kernel.org>
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

From: Asad Kamal <asad.kamal@amd.com>

[ Upstream commit 6cd2b872643bb29bba01a8ac739138db7bd79007 ]

Validate tbo resource pointer, skip if NULL

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index e1227b7c71b16..8c95b877155a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4479,7 +4479,8 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 		shadow = vmbo->shadow;
 
 		/* No need to recover an evicted BO */
-		if (shadow->tbo.resource->mem_type != TTM_PL_TT ||
+		if (!shadow->tbo.resource ||
+		    shadow->tbo.resource->mem_type != TTM_PL_TT ||
 		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||
 		    shadow->parent->tbo.resource->mem_type != TTM_PL_VRAM)
 			continue;
-- 
2.43.0


