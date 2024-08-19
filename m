Return-Path: <stable+bounces-69553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A219595682C
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57A31C2193C
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 10:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8CE1607B5;
	Mon, 19 Aug 2024 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I+6RsTYe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE96515F316
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062840; cv=none; b=YXuZbdF86FV6oIwWsHefUuBWuXjP7QGLSuT2TsqhVCcMxsWma2sMUEqK8BgqPyldKuysjtRMfzeHlcR9H2icwxDHwE0jkcqPBvpxh4bygrVstxc9BUWHICqk1jr0p214KPIEzv87s0JY5of+zFfeqr/lY7usGiYW/cTunkR+6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062840; c=relaxed/simple;
	bh=xpOgg0Te8wZHK3F+fozg6JOU8Fj48viEn/4M30pFiQ8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RfIhv3tyuqZFA7oUt5cP2VFz8L8rqan/b1u/KOXeah/raLtszg53eIELt+VTSPBygdy2v4P4Vl+cItXD/bbRkYHP0QfQGHfbg8kmPuz1w0jKCAvk1d1o+APXQkWUb+o909xyLZs7IUX62IPwguDB8FoLIk6H5kFgi3s27O2s6aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I+6RsTYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336C8C32782;
	Mon, 19 Aug 2024 10:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724062840;
	bh=xpOgg0Te8wZHK3F+fozg6JOU8Fj48viEn/4M30pFiQ8=;
	h=Subject:To:Cc:From:Date:From;
	b=I+6RsTYe6dvFl90xsIgzuko9IElTvA6+NHOTx/UOkRbEloX5mxuIsspMQ9EN+dVQk
	 kk6SD7BTQXVrOGVx7jUkxtZ9kGNQym9dUiamsLxTpER9TBlbBta4IdPc4/FfgQz3zX
	 /oLGgQD4xRkuOHpZ1h3UT0eirFV/ywGStcnkO+ac=
Subject: FAILED: patch "[PATCH] drm/amd/display: fix cursor offset on rotation 180" failed to apply to 6.1-stable tree
To: mwen@igalia.com,alexander.deucher@amd.com,chiahsuan.chung@amd.com,daniel.wheeler@amd.com,hamza.mahfooz@amd.com,harry.wentland@amd.com,xaver.hugl@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 12:20:37 +0200
Message-ID: <2024081937-granular-passably-9226@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 737222cebecbdbcdde2b69475c52bcb9ecfeb830
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081937-granular-passably-9226@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

737222cebecb ("drm/amd/display: fix cursor offset on rotation 180")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 737222cebecbdbcdde2b69475c52bcb9ecfeb830 Mon Sep 17 00:00:00 2001
From: Melissa Wen <mwen@igalia.com>
Date: Tue, 31 Jan 2023 15:05:46 -0100
Subject: [PATCH] drm/amd/display: fix cursor offset on rotation 180

[why & how]
Cursor gets clipped off in the middle of the screen with hw
rotation 180. Fix a miscalculation of cursor offset when it's
placed near the edges in the pipe split case.

Cursor bugs with hw rotation were reported on AMD issue
tracker:
https://gitlab.freedesktop.org/drm/amd/-/issues/2247

The issues on rotation 270 was fixed by:
https://lore.kernel.org/amd-gfx/20221118125935.4013669-22-Brian.Chang@amd.com/
that partially addressed the rotation 180 too. So, this patch is the
final bits for rotation 180.

Reported-by: Xaver Hugl <xaver.hugl@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2247
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Fixes: 9d84c7ef8a87 ("drm/amd/display: Correct cursor position on horizontal mirror")
Signed-off-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1fd2cf090096af8a25bf85564341cfc21cec659d)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index ff03b1d98aa7..1b9ac8812f5b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3589,7 +3589,7 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 						(int)hubp->curs_attr.width || pos_cpy.x
 						<= (int)hubp->curs_attr.width +
 						pipe_ctx->plane_state->src_rect.x) {
-						pos_cpy.x = temp_x + viewport_width;
+						pos_cpy.x = 2 * viewport_width - temp_x;
 					}
 				}
 			} else {


