Return-Path: <stable+bounces-95253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E889D749A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 16:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0EF287179
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716CB1FC43C;
	Sun, 24 Nov 2024 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Stl4n8d9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9BA1FC40A;
	Sun, 24 Nov 2024 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456486; cv=none; b=hDBPOdYLL6X8dioRgSxkZIux8xJJQzZ+R6++oM3Koe10n1nUkTbrAblwt6fQQ9wVW+hzNk5q2I8qEL2A4134uSYmjbH013GKNWIjUiP/1OpkKEyN/u9CEYZEp4dYoxTlcuQSd+xCcxiQm3VZDiz/W0yCYXpvRqemboNAxxlJcjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456486; c=relaxed/simple;
	bh=s1fiOOSdlP6cScEh9i9xkl3os/I1RKVixQ9iju5HVos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lURoMP0zIEvzjGHLYMimaw8jQKo/NAxdOgBtgWhitfmFahrLyrrPQ9wX1JWZNemy9SVGIVxpmuTuCGmDZwLua+aPbxBdefey829vonjLA3DQrm/od5csDyC1uWMSeUlodsp9q6svjH2Y5NEE5mmBJmvdOzXXop9Et42t5yeJr2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Stl4n8d9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F94BC4CECC;
	Sun, 24 Nov 2024 13:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456486;
	bh=s1fiOOSdlP6cScEh9i9xkl3os/I1RKVixQ9iju5HVos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Stl4n8d97kzfsLR/OslQgmxatYy0zeXPdTs7uAwLgZe+/rceBgHToVr2+JGShTSbP
	 jywU+DX/ow5AfOgJ1Wxf8ZdXXcJraBrUzOWpG3O5nZUALJD/6Wc+LauTn3/4VOnGOX
	 Wu6F+Mh0jtfnaOInXM++UJIXHbpVe3+6y5Y0Wib3bVtcmJDe3u1L08yPnzz1nMGbA7
	 Jrz+WaylkatrwKKkET0q142jH+b8B2wMFaDDflLigkzk3caghwU6WwBYFmXBAco5Rj
	 kMJ+2VWsuU8i7tHOg/u5tIALqXnU44LHmrI5y7BCVx1OMec24G1BliHp2tV6rQFhAP
	 DkJUf/wWrmO/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lang Yu <lang.yu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Frank.Min@amd.com,
	pierre-eric.pelloux-prayer@amd.com,
	felix.kuehling@amd.com,
	Philip.Yang@amd.com,
	mdaenzer@redhat.com,
	Arunpravin.PaneerSelvam@amd.com,
	Amaranath.Somalapuram@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 18/33] drm/amdgpu: refine error handling in amdgpu_ttm_tt_pin_userptr
Date: Sun, 24 Nov 2024 08:53:30 -0500
Message-ID: <20241124135410.3349976-18-sashal@kernel.org>
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

From: Lang Yu <lang.yu@amd.com>

[ Upstream commit 46186667f98fb7158c98f4ff5da62c427761ffcd ]

Free sg table when dma_map_sgtable() failed to avoid memory leak.

Signed-off-by: Lang Yu <lang.yu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0b162928a248b..8196a8e253266 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1006,7 +1006,7 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_bo_device *bdev,
 	/* Map SG to device */
 	r = dma_map_sgtable(adev->dev, ttm->sg, direction, 0);
 	if (r)
-		goto release_sg;
+		goto release_sg_table;
 
 	/* convert SG to linear array of pages and dma addresses */
 	drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
@@ -1014,6 +1014,8 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_bo_device *bdev,
 
 	return 0;
 
+release_sg_table:
+	sg_free_table(ttm->sg);
 release_sg:
 	kfree(ttm->sg);
 	ttm->sg = NULL;
-- 
2.43.0


