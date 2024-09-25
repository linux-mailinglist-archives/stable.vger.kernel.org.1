Return-Path: <stable+bounces-77467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A6B985D88
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493131F249AB
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648E01B2EDA;
	Wed, 25 Sep 2024 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWdK5nJR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223CC1B2ED6;
	Wed, 25 Sep 2024 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265909; cv=none; b=Hs4q5PikiHUiiJcw2C+GnkZ9NyB5XPzUQtVTnC74Fe0IjQV27lw/Q70LIi4VPRgmKSALkvVGLUUEstvSsYSPQ/DUo0nVsA7KseE6KQieEP6ir4xhnN6GBiLp1a4voeavqBf7iaFRQyD2OUXAtJTZNXYQgFhB83UpBxp7lbCzNE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265909; c=relaxed/simple;
	bh=+wDXTxHikvoawVP0k03++IlOfhH0N07O8DRw4idg+r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftATcetaZ8+zUZRvPyYu0Hi6jnKiZE4z5+z/tFdQZNjAy2mhUK4ex7Ab6fdklrP+caW2HvbNWyneK2gHjCtxhjw6+EskL5yprduoxdepKxM8KkTqtZM0QExhU18ToDsX0oz+FIdgGxrikiQP756LV8G3Jt7X7n8lzhRwTdCfkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWdK5nJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B383C4CECE;
	Wed, 25 Sep 2024 12:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265908;
	bh=+wDXTxHikvoawVP0k03++IlOfhH0N07O8DRw4idg+r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HWdK5nJRuzXARqDIwungjkhD2Tx+s8RGCU0G6F9lhX68Z/qDFyChwnvu4nSlO0elu
	 +4q2sQoc/uTiL6OEYLfBMgEiWY+yiAD66TCKn9hXKmAcNeqOMhPYXEz4Jr5TLpPPZu
	 ET6gOctI2k0ywtKWUTCWJl/CV1rp1K4vJDrov4dKIzxVYwthpxbzxlRbezcc69VD1P
	 i+1zURfD2cugIwn1LGMuasnB6J7BiBSwlUAwXEBGcLmGEQgNdh7fTbZ96zoWe626fI
	 WX/+Eir2UYJKAfhhadVr0nX93J6huhL9wbNqqyzlbJzD8kYY6Br5fYKzxFWsZWzmIt
	 Q1CGzjanWq7xw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alvin.lee2@amd.com,
	wayne.lin@amd.com,
	wenjing.liu@amd.com,
	sungjoon.kim@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 122/197] drm/amd/display: Add null check for top_pipe_to_program in commit_planes_for_stream
Date: Wed, 25 Sep 2024 07:52:21 -0400
Message-ID: <20240925115823.1303019-122-sashal@kernel.org>
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 66d71a72539e173a9b00ca0b1852cbaa5f5bf1ad ]

This commit addresses a null pointer dereference issue in the
`commit_planes_for_stream` function at line 4140. The issue could occur
when `top_pipe_to_program` is null.

The fix adds a check to ensure `top_pipe_to_program` is not null before
accessing its stream_res. This prevents a null pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:4140 commit_planes_for_stream() error: we previously assumed 'top_pipe_to_program' could be null (see line 3906)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index da237f718dbdd..3bd18e862945f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3970,7 +3970,8 @@ static void commit_planes_for_stream(struct dc *dc,
 	}
 
 	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
-		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
+		if (top_pipe_to_program &&
+		    top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
 			top_pipe_to_program->stream_res.tg->funcs->wait_for_state(
 				top_pipe_to_program->stream_res.tg,
 				CRTC_STATE_VACTIVE);
-- 
2.43.0


