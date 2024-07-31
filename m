Return-Path: <stable+bounces-64854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 350B8943AD3
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40EA283572
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E210E13CFB7;
	Thu,  1 Aug 2024 00:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjVxeuy4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3E5F50F;
	Thu,  1 Aug 2024 00:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471123; cv=none; b=fQlMn6fGd/QTU2vyi479XynjAeRzMyra9/rzTFw10BlJ/TCb9KaiItFL7YE1VFTGlCL0PGEeJjngloXuBE4ux/OvZrteG2fLavgASJLqeWU1vHV/Zf1znP/oOQb/aCPq7FkC7RQGRAh56oBOrWoLO5EZXfOc/i2BeePZm0/Ggnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471123; c=relaxed/simple;
	bh=wbpWnqBLV2lkBryAi5aIhbY2qvOMtO65SUHSHUkllIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kh6jkxB8lBljH7/sG4QPpnW684NUbtbHNTnbIP001rdCjTMxzaHE/DQb6rFlgUr0343kHOgL84yJO3hlubFGcfdsNQbi5zRvjcMO94Wi1jSXjaoFi3pUdnHsZyDhCB0YcOjTy+nSacivGDTbmVPoe2zZQ+gt6Cv8EyEn3/HJnnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjVxeuy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA83C4AF0C;
	Thu,  1 Aug 2024 00:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471123;
	bh=wbpWnqBLV2lkBryAi5aIhbY2qvOMtO65SUHSHUkllIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MjVxeuy4eL6znHXEr+raZSK8icHC/OTNhsr110s7hCQo5Mp17kc70z2gRua4W4LU3
	 LaLfrY4EB+wK5hm8t9dihsQaGW1SFsICUI2qqM0gGpUHUyqE/HzK39HFIo28e5rMlR
	 ceY/8Lr8RRMySgCuqW9T2JPQdV+yX95yyuGMYVUp5axcfOOISvqzRH3UlG/NAmqGlA
	 NUczCz+f3kGr0cmlrn3zIPnoIs5XRbrIjPFu2aYL4dZ0lzXcUlpnUIA9rCgXetGoBk
	 s1C8NbBQ2o71a1E+06YlnUUsIG3xeXSk6wYoY/ookC7LOvrIToua5l3t5bWuTc0tiv
	 WacgxcqAaiNpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hersen Wu <hersenxs.wu@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 029/121] drm/amd/display: Skip inactive planes within ModeSupportAndSystemConfiguration
Date: Wed, 31 Jul 2024 19:59:27 -0400
Message-ID: <20240801000834.3930818-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Hersen Wu <hersenxs.wu@amd.com>

[ Upstream commit a54f7e866cc73a4cb71b8b24bb568ba35c8969df ]

[Why]
Coverity reports Memory - illegal accesses.

[How]
Skip inactive planes.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 9a3ded3111952..85453bbb4f9b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -1099,8 +1099,13 @@ void ModeSupportAndSystemConfiguration(struct display_mode_lib *mode_lib)
 
 	// Total Available Pipes Support Check
 	for (k = 0; k < mode_lib->vba.NumberOfActivePlanes; ++k) {
-		total_pipes += mode_lib->vba.DPPPerPlane[k];
 		pipe_idx = get_pipe_idx(mode_lib, k);
+		if (pipe_idx == -1) {
+			ASSERT(0);
+			continue; // skip inactive planes
+		}
+		total_pipes += mode_lib->vba.DPPPerPlane[k];
+
 		if (mode_lib->vba.cache_pipes[pipe_idx].clks_cfg.dppclk_mhz > 0.0)
 			mode_lib->vba.DPPCLK[k] = mode_lib->vba.cache_pipes[pipe_idx].clks_cfg.dppclk_mhz;
 		else
-- 
2.43.0


