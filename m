Return-Path: <stable+bounces-128004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EEEA7AE14
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5A83B8866
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897CE1F0E47;
	Thu,  3 Apr 2025 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmd1Qe43"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AA31F03C3;
	Thu,  3 Apr 2025 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707731; cv=none; b=mCwlnJj2bIYsWHsXmYR31Y43VdRIkFJqJrC1/TiohAFF1gq1A3iEMC3/QLRKFgk+jAk4Id7nPDRy7Vsk0T34wYBgjg3obezjYQZaiDqrwA2kgTP2rtAuuCZJUNrm/YXN8KWci+d31u/D3FUk5bneMs8o3gfnO2zCzjO/2Hf1TiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707731; c=relaxed/simple;
	bh=wHyFbe8lGadhldF5tZXD8T4pgLpVE2yi5fdh5tFPYWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mqoNp5OB2cn0FVkDnJOMORqCeJ+m/B+e2LLLe7Osl0t/S79QCKmq3ezlpubJuKDiZVHb8H31Z50Pp/m21rKTdmt2ctkH31NciTF60OBMNde5mMV68ip8YDR8OnxrkHd+ponBm4uqv0djuKeJLsbROFt1CJCL+O7OBMuqOPykZpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmd1Qe43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A464C4CEE8;
	Thu,  3 Apr 2025 19:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707731;
	bh=wHyFbe8lGadhldF5tZXD8T4pgLpVE2yi5fdh5tFPYWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jmd1Qe43D+uIUiwA863Y4qfJYYZ9UWEDpRuw/hargdA8WSCeCk1gF6m1Wr/r+PCry
	 /XClEKl4R5/En7QSqqFkWWzivH5AN2z/0WEyI8nVyNlQnXIj6B/isaORdDXvPOWMNL
	 OJuayHkGv1NhcMU9Bptuy2/9+OOpAj9uHWXO6cNc0Z3oDLc6Q6ouAD7SO/9SI0plMj
	 wWUb0fl4gc7fD/vfXGZd6JFwTy995OmLanDnP+ygDZHjqOb0NBcXDqcGOMmxa48Md7
	 u4OqWyK6Ij9msPRg8TE0puiZTfvHrLgQKasGbsXxGVMswqwwekUuuJlDiPmLG+s+M3
	 EXQ1EcA45ZwRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhikai Zhai <zhikai.zhai@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sung.lee@amd.com,
	martin.leung@amd.com,
	Aric.Cyr@amd.com,
	bhuvanachandra.pinninti@amd.com,
	siqueira@igalia.com,
	wayne.lin@amd.com,
	chiahsuan.chung@amd.com,
	alex.hung@amd.com,
	mwen@igalia.com,
	tjakobi@math.uni-bielefeld.de,
	peterson.guo@amd.com,
	ivlipski@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 05/37] drm/amd/display: Update Cursor request mode to the beginning prefetch always
Date: Thu,  3 Apr 2025 15:14:41 -0400
Message-Id: <20250403191513.2680235-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Zhikai Zhai <zhikai.zhai@amd.com>

[ Upstream commit 4a4077b4b63a8404efd6d37fc2926f03fb25bace ]

[Why]
The double buffer cursor registers is updated by the cursor
vupdate event. There is a gap between vupdate and cursor data
fetch if cursor fetch data reletive to cursor position.
Cursor corruption will happen if we update the cursor surface
in this gap.

[How]
Modify the cursor request mode to the beginning prefetch always
and avoid wraparound calculation issues.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Zhikai Zhai <zhikai.zhai@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |  2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 22 ++++++++-----------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
index a65a0ddee6467..c671908ba7d06 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn31/dcn31_hubp.c
@@ -44,7 +44,7 @@ void hubp31_set_unbounded_requesting(struct hubp *hubp, bool enable)
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
 	REG_UPDATE(DCHUBP_CNTL, HUBP_UNBOUNDED_REQ_MODE, enable);
-	REG_UPDATE(CURSOR_CONTROL, CURSOR_REQ_MODE, enable);
+	REG_UPDATE(CURSOR_CONTROL, CURSOR_REQ_MODE, 1);
 }
 
 void hubp31_soft_reset(struct hubp *hubp, bool reset)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 44e405e9bc971..13f9e9b439f6a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1992,20 +1992,11 @@ static void delay_cursor_until_vupdate(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	dc->hwss.get_position(&pipe_ctx, 1, &position);
 	vpos = position.vertical_count;
 
-	/* Avoid wraparound calculation issues */
-	vupdate_start += stream->timing.v_total;
-	vupdate_end += stream->timing.v_total;
-	vpos += stream->timing.v_total;
-
 	if (vpos <= vupdate_start) {
 		/* VPOS is in VACTIVE or back porch. */
 		lines_to_vupdate = vupdate_start - vpos;
-	} else if (vpos > vupdate_end) {
-		/* VPOS is in the front porch. */
-		return;
 	} else {
-		/* VPOS is in VUPDATE. */
-		lines_to_vupdate = 0;
+		lines_to_vupdate = stream->timing.v_total - vpos + vupdate_start;
 	}
 
 	/* Calculate time until VUPDATE in microseconds. */
@@ -2013,13 +2004,18 @@ static void delay_cursor_until_vupdate(struct dc *dc, struct pipe_ctx *pipe_ctx)
 		stream->timing.h_total * 10000u / stream->timing.pix_clk_100hz;
 	us_to_vupdate = lines_to_vupdate * us_per_line;
 
+	/* Stall out until the cursor update completes. */
+	if (vupdate_end < vupdate_start)
+		vupdate_end += stream->timing.v_total;
+
+	/* Position is in the range of vupdate start and end*/
+	if (lines_to_vupdate > stream->timing.v_total - vupdate_end + vupdate_start)
+		us_to_vupdate = 0;
+
 	/* 70 us is a conservative estimate of cursor update time*/
 	if (us_to_vupdate > 70)
 		return;
 
-	/* Stall out until the cursor update completes. */
-	if (vupdate_end < vupdate_start)
-		vupdate_end += stream->timing.v_total;
 	us_vupdate = (vupdate_end - vupdate_start + 1) * us_per_line;
 	udelay(us_to_vupdate + us_vupdate);
 }
-- 
2.39.5


