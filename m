Return-Path: <stable+bounces-43241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 610DD8BF07F
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F16A3B22ADC
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31A5132492;
	Tue,  7 May 2024 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS6c5axM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC3684E0E;
	Tue,  7 May 2024 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122771; cv=none; b=mlObajlIa/qGTdJzzoFwri3eItdi+v8r4RZ7rqCM+D+gbdykULCV5iEwwGQofdaeIlTphNbQ8mXBWlSOzfwNTPTkD4oEFIt27/Ua8QNjCBba/Cv9393sp+ydrXcsYoK7XqDXIUqa8LLVlJ/x5dxRjoQ+4tdWCKEjgxUzn3haYZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122771; c=relaxed/simple;
	bh=HvV+pVVFFLbbX4ltkN3w+EWnX6aqtF6HzprSpkb0SWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vF+OsZlQK1f1HsA7pH64XktRJpfCPt9GKqtFRTaoGpyk9THSCQhRoY+fZTZfv8riiO7buiMUFxoFevE5gCfQxWL7BSqiIYZoByI1YW5DSt5qnrcQol5klKg8xtITWYzeENYdSlkLueiqNaOQb6IxUtt9tqsJgrm28ZrUYaJRORQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS6c5axM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3589FC3277B;
	Tue,  7 May 2024 22:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122771;
	bh=HvV+pVVFFLbbX4ltkN3w+EWnX6aqtF6HzprSpkb0SWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WS6c5axMJEwJVHxWZ5F2+YCcRqsRK7nSFBJC9rCjmld9UucwAarwhNlYOMZB95ltp
	 5lYHeB5laTChr+Q3QNY67VbUTRZlTZ+846QGoEdne1286u2MqlO8wlsRs6mxXVHjhj
	 fJ1VuQs9MduRjt1DwYrs8epMkzzYRolIE5/XAkLsE0PlNLCeJB2LiZe1qQnKGXa4Hn
	 Pr2F1AlFBuSecC5fc6Xs3JaR1kLnCFMO2Ql487SZ8hhmYKuD/LJWbMkDNDBARYIOsC
	 FJaFCEA7+oLUtNwYNcZRua81DnzJfuLHkGYNi3FqPi8zUB1mfeQOeqSSt36l2Iq2P9
	 /i8qP+r7LgPkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Kuehling <felix.kuehling@amd.com>,
	Mukul Joshi <mukul.joshi@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Philip.Yang@amd.com,
	Arunpravin.PaneerSelvam@amd.com,
	Hongkun.Zhang@amd.com,
	pierre-eric.pelloux-prayer@amd.com,
	Jun.Ma2@amd.com,
	Wang.Beyond@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 08/19] drm/amdgpu: Update BO eviction priorities
Date: Tue,  7 May 2024 18:58:30 -0400
Message-ID: <20240507225910.390914-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225910.390914-1-sashal@kernel.org>
References: <20240507225910.390914-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Felix Kuehling <felix.kuehling@amd.com>

[ Upstream commit b0b13d532105e0e682d95214933bb8483a063184 ]

Make SVM BOs more likely to get evicted than other BOs. These BOs
opportunistically use available VRAM, but can fall back relatively
seamlessly to system memory. It also avoids SVM migrations evicting
other, more important BOs as they will evict other SVM allocations
first.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Acked-by: Mukul Joshi <mukul.joshi@amd.com>
Tested-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 361f2cc94e8e5..1e33e82531f58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -613,6 +613,8 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	else
 		amdgpu_bo_placement_from_domain(bo, bp->domain);
 	if (bp->type == ttm_bo_type_kernel)
+		bo->tbo.priority = 2;
+	else if (!(bp->flags & AMDGPU_GEM_CREATE_DISCARDABLE))
 		bo->tbo.priority = 1;
 
 	if (!bp->destroy)
-- 
2.43.0


