Return-Path: <stable+bounces-59452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534439328DE
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5C41F216D6
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634151A6534;
	Tue, 16 Jul 2024 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9fG/GSV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB601A072B;
	Tue, 16 Jul 2024 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140079; cv=none; b=npIcofpliIrwj6/T3UhvuSCFdBFBW3WnVia4n3EHR/A9BdZYOT5ddTxuk2SnpH9H5AQb7ypHWkh5qUFap1pwf8PIMAuI/vvS/vpA3FG4+Utcu3TU03/6AMYFtfY7xOPxbPBt8vjWJOrBkZwoXptBb6czIMINR54mEGLcCBHeBMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140079; c=relaxed/simple;
	bh=hPiZBpPQPKfm8zysLlxT6NXhGRC5lcxwMo3vnGpL6WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mx0woSpX4GHBQljqy+s24F8oUbHRWfs+/MJW+AQ1KhNvBGEDELZiKWx5SbbMyZEX16dQowQz3OrCmhDvpfiESAa014xy6b3JjuqTLE/FAkae2Jp9AzGZeCehxgUN9CtEbeqsbYZQrgMD4B5/FuvLBtYoW96Gtanlt1UeFyt2KmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9fG/GSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B746C4AF0F;
	Tue, 16 Jul 2024 14:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140079;
	bh=hPiZBpPQPKfm8zysLlxT6NXhGRC5lcxwMo3vnGpL6WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9fG/GSVKs49p+DnAVxPENOwYZF3xNfXSELB4f7HCVdbLiqI9vAoj7Us8WLLAQaf1
	 XzIL/I38vVasnZqK2+/i3oPqAHJzX1whOxR7OVIo7RRAQfRBCUH+tp1gtSi2qSj4lP
	 3+WFmHPzPeeEYhKbhsYIgmnY+1Qdt7zwR+TA9QHonMmBEws2m/kdfqf7wKKRh/lMCJ
	 tHN5euwpTMIG8YUu8PlSYWZfoa2WhWEHBrKVFXjqYBQiHZhE7Y9rhE3y+s7te80/es
	 haciGKcsIeKbfMRATp5gyGkVyf60+XpmPkvvtqPSi8oaFKy0FVY7H7rceIYKApgKDB
	 tTgcHOdFcKy/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 14/18] drm/radeon: check bo_va->bo is non-NULL before using it
Date: Tue, 16 Jul 2024 10:26:49 -0400
Message-ID: <20240716142713.2712998-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142713.2712998-1-sashal@kernel.org>
References: <20240716142713.2712998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.40
Content-Transfer-Encoding: 8bit

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

[ Upstream commit 6fb15dcbcf4f212930350eaee174bb60ed40a536 ]

The call to radeon_vm_clear_freed might clear bo_va->bo, so
we have to check it before dereferencing it.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 3fec3acdaf284..27225d1fe8d2e 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -641,7 +641,7 @@ static void radeon_gem_va_update_vm(struct radeon_device *rdev,
 	if (r)
 		goto error_unlock;
 
-	if (bo_va->it.start)
+	if (bo_va->it.start && bo_va->bo)
 		r = radeon_vm_bo_update(rdev, bo_va, bo_va->bo->tbo.resource);
 
 error_unlock:
-- 
2.43.0


