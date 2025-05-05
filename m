Return-Path: <stable+bounces-141234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E9AAAB19D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3FC7B7480
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554202D26B2;
	Tue,  6 May 2025 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVlHzqOF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1162DA545;
	Mon,  5 May 2025 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485573; cv=none; b=ph037MFun5XUpor9t+PFMLNYuRjlzTrmfAowpQgH2vx181Me+uMeZdONCirWJy28LYqVwxJ7q4CPRoGy8LSzVz/orozvWmZM5mNN9JNrHda2Ajccx9Q7gxLIsk3NBIKne+v8FkZebs6nLvHVdyUBMl4yc/ypv2Ced1J6JeehqPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485573; c=relaxed/simple;
	bh=DG2CcR+hXoZUDxJmebsLWyCXU0Rqe4Z3prDsSICLdvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ixMmG5W4A5kxZrAwOTPzvODBHaWJQ9g3OJcNRB1SMtXxi5dlYTLqXxiFtzNwfVc6Rmx4MSOxYrHmV7EAaLsoxNtz5HgTemSxPTN/fwU3u5zOAb7MD6YuJ5lKFGObRVFBZUty1oDLNeAlEet1NKnpzdtPT9jnFbiuF4CBJWVPxmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVlHzqOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5919EC4CEED;
	Mon,  5 May 2025 22:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485573;
	bh=DG2CcR+hXoZUDxJmebsLWyCXU0Rqe4Z3prDsSICLdvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EVlHzqOFamLTtmzEYgHKXcGPmFbida3leCLuX8pqnA/uYh2Rx0VZeP5sxWlZeF8uI
	 0K5ip+BCcudC0BxX3DzD3thgh3Mz05jpZQp3ZuJ2TAkxMzzqbxnBho6QAX7YDX1mwd
	 m7Ztkyq74YWmbl/Yrj50F66n27Mx16S28BoUkLWmBZqnJMo1uvvgab3E8qyy/UnhAa
	 J7nNxWBiD0LUFhXU6RNqPpTmZ9J8pm5ywENhKsPajJ6xURq5zHeyljNxgyzX60uLJX
	 5gcT/SQ3Jz7DUZ/hvfbrYaD8/FAa0q3J1qVEtsiHBS0bag6cwwiffYQVneOyiT7nAm
	 kRwXLl3KHAOyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Austin Zheng <Austin.Zheng@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	austin.zheng@amd.com,
	jun.lei@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	siqueira@igalia.com,
	alex.hung@amd.com,
	colin.i.king@gmail.com,
	aurabindo.pillai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 372/486] drm/amd/display: Use Nominal vBlank If Provided Instead Of Capping It
Date: Mon,  5 May 2025 18:37:28 -0400
Message-Id: <20250505223922.2682012-372-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Austin Zheng <Austin.Zheng@amd.com>

[ Upstream commit 41df56b1fc24cc36fffb10e437385b3a49fbb5e2 ]

[Why/How]
vBlank used to determine the max vStartup is based on the smallest between
the vblank provided by the timing and vblank in ip_caps.
Extra vblank time is not considered if the vblank provided by the timing ends
up being higher than what's defined by the ip_caps

Use 1 less than the vblank size in case the timing is interlaced
so vstartup will always be less than vblank_nom.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c       | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index e2a3764d9d181..0090b7bc232bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -3630,13 +3630,12 @@ static unsigned int CalculateMaxVStartup(
 	double line_time_us = (double)timing->h_total / ((double)timing->pixel_clock_khz / 1000);
 	unsigned int vblank_actual = timing->v_total - timing->v_active;
 	unsigned int vblank_nom_default_in_line = (unsigned int)math_floor2((double)vblank_nom_default_us / line_time_us, 1.0);
-	unsigned int vblank_nom_input = (unsigned int)math_min2(timing->vblank_nom, vblank_nom_default_in_line);
-	unsigned int vblank_avail = (vblank_nom_input == 0) ? vblank_nom_default_in_line : vblank_nom_input;
+	unsigned int vblank_avail = (timing->vblank_nom == 0) ? vblank_nom_default_in_line : (unsigned int)timing->vblank_nom;
 
 	vblank_size = (unsigned int)math_min2(vblank_actual, vblank_avail);
 
 	if (timing->interlaced && !ptoi_supported)
-		max_vstartup_lines = (unsigned int)(math_floor2(vblank_size / 2.0, 1.0));
+		max_vstartup_lines = (unsigned int)(math_floor2((vblank_size - 1) / 2.0, 1.0));
 	else
 		max_vstartup_lines = vblank_size - (unsigned int)math_max2(1.0, math_ceil2(write_back_delay_us / line_time_us, 1.0));
 #ifdef __DML_VBA_DEBUG__
-- 
2.39.5


