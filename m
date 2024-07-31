Return-Path: <stable+bounces-64828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1793C943A65
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1C01F2129C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8396146D4C;
	Thu,  1 Aug 2024 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCWbA8v2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E6A146A74;
	Thu,  1 Aug 2024 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470930; cv=none; b=ua2w6Jtsu2ruxt03PnN6sKfwQ5/R4+OUL2plZO2mv5Y+BYRwX88PWPWDtA1J3iXy9grmmaWqw2xe2FT2ry9wphbLFrdheBPR+oHFZOanipnK+m7f2LUD/vPO1IP7ftU9T3tVN+h2POCiE2Mjm+cjp0rJkQFOXhYREbsZVRR98I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470930; c=relaxed/simple;
	bh=iUrRRL7mz7ujbO+O1A61PnTruGlIHpHZ+70IF0VySGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfKEEjrqNNolUGsdGECcCF+hYbRWQjhqr1Fj9cwNzqDaPZE+G9w/o3r2c0tVWplzi7eMYA0OR0mmek0LVCFIkqPtJkZu1kB+//ZsRHiZIyzjDL3/Lb06XcTSgO6JknTTN7Uklyx/pRMn3VdCmrpBAk8m4dnxpZBMScDHR87MHz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCWbA8v2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E21FC4AF0F;
	Thu,  1 Aug 2024 00:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470930;
	bh=iUrRRL7mz7ujbO+O1A61PnTruGlIHpHZ+70IF0VySGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rCWbA8v2+rjZ6gLQ8CXZ9bLvXqTC/z1Rt3G+HBzeA9ehEtMR5NkgSTxmwMZ8QgvBr
	 BpqJIQOxUiXYGuhATXKT0v9i2ac/cvjP/nCIsJpqUe4R2UrKIVCUt5vruDh5ojbId3
	 xwkVNuWQY8nUSzpf89/0ORarP/gmZJDwDjgRLxxjTh/DgfumvTw4w/VmHxLMY3UAKU
	 2zRoiyZta3iQzzsU3aUcwSbo1S8YqxSTSIQ6rHjZCKkTNogsD5IPsGdOQvX3JobNwO
	 0XlrjR77FEYOWC73cBlR7/ZtbZaZ4fgQlLZfUxN3XxSlExeUIYDv5WSG4u3uNUqFAZ
	 sF55z2ZJ83JGg==
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
	vitaly.prosyak@amd.com,
	hannes@cmpxchg.org,
	friedrich.vock@gmx.de,
	andrealmeid@igalia.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 003/121] drm/amdgpu: fix overflowed array index read warning
Date: Wed, 31 Jul 2024 19:59:01 -0400
Message-ID: <20240801000834.3930818-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 06f0a6534a94f..15c2406564700 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -473,8 +473,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
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


