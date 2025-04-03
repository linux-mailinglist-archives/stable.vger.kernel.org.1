Return-Path: <stable+bounces-128096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A9EA7AF2E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0811892A82
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862AA232363;
	Thu,  3 Apr 2025 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFLWc5UU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C5B22FF2D;
	Thu,  3 Apr 2025 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707964; cv=none; b=kUQjlZDY/DQQhcXwXTTc/YMUsD0En4bZPM9NcyTKO/+RF0Fti30pUzDvQeAlLRwz7H2Fi7QsRoqxCgmvD2ZBPYgEBoXuzKDCOe4S9LpvVKPgf49IOyY+msfWnCyV1gI6U5kdBQlFrFx9xuXuUT/Ev6F+Are8del5MBOmmLKbig4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707964; c=relaxed/simple;
	bh=MJYFvRbidm7NIYxljsuNRSCVtjd5ospfqy3e7o8IHHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r3U/qX7DITT9GROO0SLdZTTd98qioyHEQvcbZy6D3aMyDvSj3LYo48T3PqQhC3RG9ByAZ2Z5uo1Ai71iI3Xv8tNdVhtjrk0sabYcZGY9d3bkxdyl/f3GkIFtsLnXk/LesCNSKR4vplmuKnRRPMuf6+nOp9lYExVXsNKynH+IVAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFLWc5UU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567D6C4CEE3;
	Thu,  3 Apr 2025 19:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707964;
	bh=MJYFvRbidm7NIYxljsuNRSCVtjd5ospfqy3e7o8IHHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JFLWc5UU51E3YWhCNyjXvxI0mwxOJAvv31EGeYYkB49Ql8TiSjbLiWxJVuckFIi0C
	 GFl9pAYy7GfLFhAncJMqhMsmtwJf4i3XDaONDc3ulQjpMqC9JKySWHTwyoUSSyvbzB
	 h9J8oS0rqcCtxDMpN4XWnsWowB3kJVHlE993yXrtac68hdK5rRcNizFg6rPSmvp3zY
	 yP79n+YIQEJcADwnrNFNohmC1El9oNWId6xGl19Prirsz5m9p/GGJSawmO134Dr4qu
	 1mimUafoc5mplMwb77D2Nl0QwdUbAas371zS0bIG/cDgP414tJ98QCFB4Jk9xCRx3Q
	 pYGG7k7k2Uxbw==
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
	bhuvanachandra.pinninti@amd.com,
	chiahsuan.chung@amd.com,
	martin.leung@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 02/20] drm/amd/display: Update Cursor request mode to the beginning prefetch always
Date: Thu,  3 Apr 2025 15:18:55 -0400
Message-Id: <20250403191913.2681831-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191913.2681831-1-sashal@kernel.org>
References: <20250403191913.2681831-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 22 ++++++++-----------
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c |  2 +-
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 416168c7dcc52..b120aa67d26c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1947,20 +1947,11 @@ static void delay_cursor_until_vupdate(struct dc *dc, struct pipe_ctx *pipe_ctx)
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
@@ -1968,13 +1959,18 @@ static void delay_cursor_until_vupdate(struct dc *dc, struct pipe_ctx *pipe_ctx)
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
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
index 39a57bcd78667..576acf2ce10dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
@@ -44,7 +44,7 @@ void hubp31_set_unbounded_requesting(struct hubp *hubp, bool enable)
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
 
 	REG_UPDATE(DCHUBP_CNTL, HUBP_UNBOUNDED_REQ_MODE, enable);
-	REG_UPDATE(CURSOR_CONTROL, CURSOR_REQ_MODE, enable);
+	REG_UPDATE(CURSOR_CONTROL, CURSOR_REQ_MODE, 1);
 }
 
 void hubp31_soft_reset(struct hubp *hubp, bool reset)
-- 
2.39.5


