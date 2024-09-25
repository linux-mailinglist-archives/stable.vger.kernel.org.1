Return-Path: <stable+bounces-77494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A5C985E60
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7315BB25284
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31758204917;
	Wed, 25 Sep 2024 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcleH/Xn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3805204912;
	Wed, 25 Sep 2024 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266014; cv=none; b=TpqNCuhpMu58GX967UJ3iGkzOQ92S8A6QlBjq6ZTIZ/Onq46PI41r1fVoUryKBuPndnGUGrywzyLvIshHGodmn03KYJszWFn9al9kYXCCW+iC87RHjN3gX30G1meXkuLOvbvqpm6OCqTmWs6VyalXLt3JDbfJVtDbCDH6NbSLHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266014; c=relaxed/simple;
	bh=u62ZCuNuPGvw3MRHzvTFtS1Thg8AkgpGBY8eVZFzDhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eT74TmsBl1ig4DwmZ4e8Z2RVFlAe9qzRteyjhe3+h5qdHuahbMO5L0PnE8ERUFQW8e4HD7BTGKE/opVgLlkftKsXb1GsjjkkO3ojq6gltgyOWNuFzLT1GtJ5SIXuLNCk/Hr/j4T2yolFCU68QNabHEQ5NxLEVMztoy5ykuzd0pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcleH/Xn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCFAC4CEC3;
	Wed, 25 Sep 2024 12:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266013;
	bh=u62ZCuNuPGvw3MRHzvTFtS1Thg8AkgpGBY8eVZFzDhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TcleH/XnhBGVT9iE7c3r2K0ZJ60eDOVVojB617LX+LV6QVQtlwN2u/VHqgIwXpaz5
	 dYHcJ0WpIJ1zkvQzmN2Uas1KHOZwqKAD//UWruHJd0/LgOHj8EZCvneFvVDur+MnGZ
	 nLRjO7/gnI5O7QSriQv4gKQDGbP60dUd/PEXcX6Wn2W0z88Yq0Pa3NTdHkgXv1O4Ax
	 hY2/1ovIXsCK8AQ+BQ6/kZfFLnWXxel1KUIP40y1vqrAVKTp+f2M7ykXY4OfPJ7sbz
	 bxJKHYlGLAgxZ5pVmR251v/KHGJAJJEYfYTExCLdyFB/DJbrvx3w9T1O0rqmo5fM40
	 YoAinmUDVDtsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Nevenko Stupar <nevenko.stupar@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
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
	alvin.lee2@amd.com,
	chaitanya.dhere@amd.com,
	hamza.mahfooz@amd.com,
	wenjing.liu@amd.com,
	sohaib.nadeem@amd.com,
	samson.tam@amd.com,
	Qingqing.Zhuo@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 149/197] drm/amd/display: Check null-initialized variables
Date: Wed, 25 Sep 2024 07:52:48 -0400
Message-ID: <20240925115823.1303019-149-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 367cd9ceba1933b63bc1d87d967baf6d9fd241d2 ]

[WHAT & HOW]
drr_timing and subvp_pipe are initialized to null and they are not
always assigned new values. It is necessary to check for null before
dereferencing.

This fixes 2 FORWARD_NULL issues reported by Coverity.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index ebcf5ece209a4..bf8c89fe95a7e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -871,8 +871,9 @@ static bool subvp_drr_schedulable(struct dc *dc, struct dc_state *context)
 	 * for VBLANK: (VACTIVE region of the SubVP pipe can fit the MALL prefetch, VBLANK frame time,
 	 * and the max of (VBLANK blanking time, MALL region)).
 	 */
-	if (stretched_drr_us < (1 / (double)drr_timing->min_refresh_in_uhz) * 1000000 * 1000000 &&
-			subvp_active_us - prefetch_us - stretched_drr_us - max_vblank_mallregion > 0)
+	if (drr_timing &&
+	    stretched_drr_us < (1 / (double)drr_timing->min_refresh_in_uhz) * 1000000 * 1000000 &&
+	    subvp_active_us - prefetch_us - stretched_drr_us - max_vblank_mallregion > 0)
 		schedulable = true;
 
 	return schedulable;
@@ -937,7 +938,7 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
 		if (!subvp_pipe && pipe_mall_type == SUBVP_MAIN)
 			subvp_pipe = pipe;
 	}
-	if (found) {
+	if (found && subvp_pipe) {
 		phantom_stream = dc_state_get_paired_subvp_stream(context, subvp_pipe->stream);
 		main_timing = &subvp_pipe->stream->timing;
 		phantom_timing = &phantom_stream->timing;
-- 
2.43.0


