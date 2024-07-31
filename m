Return-Path: <stable+bounces-64834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264F1943A93
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 980D6B260B1
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53AD14B97D;
	Thu,  1 Aug 2024 00:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzggrWKo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFF513775B;
	Thu,  1 Aug 2024 00:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470959; cv=none; b=CuIl4zc/X0Jg1jTMtZtkta25qKqmuDBTKQv+IqdkZzgqvUnG5LVMJ458Z+lrbheLk9Di6p6UZwdrFo5ErhpdVmAwvkQrk2XfjO1rSCSuM5F+f3PC0Bedub4tLGf9QdGkO4TfQtalHVQH1JYTyie3AAzK0uEc6i4yu2TcGvsgWIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470959; c=relaxed/simple;
	bh=1yKMbkhAyfPrW+nh7Z+gF1Y+RpRfYc0PmOUjnFEVyI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AttNGJ+8b0Nv++oP5SRro3JK3krOxhyxrJFPU+fgAnlGVFizQq92gok2flEqDeDrvEofxrj85Mwp/uihNStXjLbVBB7hGmyYqHoI5yHaUiWbNR2VKOpN68y1H7wmz8tGhkYDebCgHmI+ikvDwPnarnSfTuQ45AvClY8DsjmNxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzggrWKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BD5C116B1;
	Thu,  1 Aug 2024 00:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470959;
	bh=1yKMbkhAyfPrW+nh7Z+gF1Y+RpRfYc0PmOUjnFEVyI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XzggrWKoHobAGdLDK62yRzy3Q8Hc2QsheQAHyIx9Yevu31aAH4mofeO8CXq7FsK94
	 z82lZSG5Fu+Ci8T/TL/oIY9CImB145PjmH1qNWtrEuiz7Liw91KPcYQib2eLDv7V5P
	 JYw3/za6UDMT261d5tZK9qRUwK+2gr+nlq7suY/M9yH9QKZNmrsgZcVTp0XWXHJkRW
	 n8cYzd+TEmyUCiG6YOIDjuqE2G+Va54yhAWC5ErOy7WHAzAJK6R3JmBhNCGzuioFb5
	 ZbYsslnMh+zVaplsRysvyzSUBP/B0pLnKCw5sLMyzoP1QUvi+D0mtsplcWVBH9MpFo
	 ALMzan/6gBXwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	wenjing.liu@amd.com,
	jun.lei@amd.com,
	hamza.mahfooz@amd.com,
	alvin.lee2@amd.com,
	george.shen@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 009/121] drm/amd/display: Ensure array index tg_inst won't be -1
Date: Wed, 31 Jul 2024 19:59:07 -0400
Message-ID: <20240801000834.3930818-9-sashal@kernel.org>
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 687fe329f18ab0ab0496b20ed2cb003d4879d931 ]

[WHY & HOW]
tg_inst will be a negative if timing_generator_count equals 0, which
should be checked before used.

This fixes 2 OVERRUN issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 15819416a2f36..693d05a98c6fb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3492,7 +3492,7 @@ static bool acquire_otg_master_pipe_for_stream(
 		if (pool->dpps[pipe_idx])
 			pipe_ctx->plane_res.mpcc_inst = pool->dpps[pipe_idx]->inst;
 
-		if (pipe_idx >= pool->timing_generator_count) {
+		if (pipe_idx >= pool->timing_generator_count && pool->timing_generator_count != 0) {
 			int tg_inst = pool->timing_generator_count - 1;
 
 			pipe_ctx->stream_res.tg = pool->timing_generators[tg_inst];
-- 
2.43.0


