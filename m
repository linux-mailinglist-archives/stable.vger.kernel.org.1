Return-Path: <stable+bounces-65138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1822943F13
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFAD282E68
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7671DF69C;
	Thu,  1 Aug 2024 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH82i5Ly"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB9A1DF68C;
	Thu,  1 Aug 2024 00:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472606; cv=none; b=StGx2500ucztBRKa2fladLGYFX5L/KNR3P6GrBQK4nLJSRDSbs5787q2XMSgI/IVP5+DcMRxTreJAqszWAEriw8Hyg0b0+EONtPEQAWGpwOzhIxuiKgYPoUS4KxKmrHxtTmYVe7Og9RIV93Sphp9qfc5wXYGcJPZJgU8htffzfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472606; c=relaxed/simple;
	bh=Co3rOYWFyMzUQ/iRBOHAF8/nPZFV/WYnqoQl2tPTpws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tXUCIKuDen78+71aLEPC+cCBH9RB5ztxg4XAPMAPOlCgJ6TQWZ8UWKtfDecl25cL74VPlpe7vJAplCPcNyCYeL7ONi5TQbQO14qF7EPlHZRvLeiIwTtIf4tFI9ftwqO0zxWy/jz0cfFpLd+QqGAyot4lf9cuCa8bf+8rEM6588o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IH82i5Ly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A5EC116B1;
	Thu,  1 Aug 2024 00:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472606;
	bh=Co3rOYWFyMzUQ/iRBOHAF8/nPZFV/WYnqoQl2tPTpws=;
	h=From:To:Cc:Subject:Date:From;
	b=IH82i5LyYE8doxPOf26734EDraM0s0kJXkxZCtENe/HbCFQPkizAn9M44w/XNMJSy
	 kKyjJQe+a6MLq/fIEawfaq8J2lsajYNBiVzhF3FuyJ+II7mwqCX6j+DgTm7MElazyf
	 DO8ZY4bAEhjtt4kW9v+urWZGRaEY/3iw3rwiakB99vqZLpyXFZIioGE553MznVPsrl
	 J8x38wAF4a96vRIn3yGPb8gBU9CLSzTcU5z6YQAMK4XfV+Jj+PwOdOxHkwQMwdGKt3
	 SNzOjyhwVe+xrFGOCr7yTAdmYWFZbWglMc2k0Od4+KYlnzpau1ejTlEstMGsjPeFYH
	 Rg+d9kuUSt2Dg==
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
	friedrich.vock@gmx.de,
	andrealmeid@igalia.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 01/38] drm/amdgpu: fix overflowed array index read warning
Date: Wed, 31 Jul 2024 20:35:07 -0400
Message-ID: <20240801003643.3938534-1-sashal@kernel.org>
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
X-stable-base: Linux 5.10.223
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
index 15ee13c3bd9e1..6976f61be7341 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -368,8 +368,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
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


