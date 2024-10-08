Return-Path: <stable+bounces-82772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EF2994E9E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E573B24112
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF011DE89A;
	Tue,  8 Oct 2024 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uPAY3NgW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686CF1C5793;
	Tue,  8 Oct 2024 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393377; cv=none; b=WnoAFBWBRDjNbJCkOHG9+lxBm6WQYqOcmILzIasHAGZnxUYnkdV8zobyTxh9q/L5tQ7KZVsTdqiYItelQ3lcipAQd2ZNv1/IQUxJQp3+itKs06gb0hiNanmC5Ta9iPRj3qV5Q4r0kvzGTZB/+WZ2PLa3erkBbrTOysd5HjrIriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393377; c=relaxed/simple;
	bh=0+VDpalympnib673eN8SOsQ7EUwJIDBbRJ9I8O1LXE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNh75jUyKVcUM55zS8wlANUTT0xIMG3HlTuFuxzSnODZ2BXijMT8VVyYx5nX6IkZ3r0fxAD2XCiCzV8pyNlZYM8m9W5cox87HovTDUV0OTeTekauPrf72zXLJ98/YtAuC/rN4X2B704tfscYH9ARjz9HRytjCh/YARm/7bkGiQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uPAY3NgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A0AC4CEC7;
	Tue,  8 Oct 2024 13:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728393377;
	bh=0+VDpalympnib673eN8SOsQ7EUwJIDBbRJ9I8O1LXE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uPAY3NgWtpiYmwsXKKF9clUNwQmCES/Pqr6wempfBo8x0lM89gZK7q/kiUqnW/YLj
	 YPE+NLpcwVZjeqYMuXXSO3jeiTAtxL5JNZi1E4isqUdlLhm+gV6dJGCPMYnE7SLypG
	 zgvOv/BVa0T9r9ZHPa4tTD79OTOmDKm/PVHJW4jA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tom Chung <chiahsuan.chung@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 134/386] drm/amd/display: Add null check for top_pipe_to_program in commit_planes_for_stream
Date: Tue,  8 Oct 2024 14:06:19 +0200
Message-ID: <20241008115634.708131581@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 50e643bfdfbad..0b2eb2a6c8e14 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3797,7 +3797,8 @@ static void commit_planes_for_stream(struct dc *dc,
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




