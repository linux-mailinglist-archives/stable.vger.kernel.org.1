Return-Path: <stable+bounces-69548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822E895681D
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00199B20D5B
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 10:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D0716130B;
	Mon, 19 Aug 2024 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FKtfFULL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780116088F
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062755; cv=none; b=WnmvjSMNLU2nJlsB8nZqfnR05j4zX1Lbur0a5Hcy9eO+s4ahKfYeTG0Bdx6IKqTiKcXWUM04kKZOK9sYr3IOz2GwbOwg9KkY+6NnpChmeRU5mJJdz+bjJFw0RNzR1I62hGZeO8Gq1dsmClOh7bc8d39a+PdXLecX8iykbdxv064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062755; c=relaxed/simple;
	bh=XSuNzbm7oHoAiBiQ53k2eWRbGz8S6DYAzW7QA1jPZJ0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e5+MvsEAuZKuRgBr4/AmY7F0DsAk0mqDEEQXO0SdwYlNrKdXsEo1wRmAznHKJwF3zye+uBHp2BRYHU3BYPxUMz+q/hovuDVp78kHg5OyVZcCSoF2ENbGeh7yPMmfhkHuVK+IDv3C5ZmKj9jWSFG+EjTlv/MSag15SmlQRxkHG/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FKtfFULL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2D9C4AF11;
	Mon, 19 Aug 2024 10:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724062754;
	bh=XSuNzbm7oHoAiBiQ53k2eWRbGz8S6DYAzW7QA1jPZJ0=;
	h=Subject:To:Cc:From:Date:From;
	b=FKtfFULL8vid9DjoBDMls/CVTjC4h9XS2YHPBOqJz70ok6uxIVLhFU6WCkUBOEIwE
	 r+jbqGEJOEcftRd6BmWb7egiH5fnskXKYO1Bu5Ri8LbiKawnCThUcfWcrWub1D2M4h
	 AniR6U6XNmU8d7x8Z9Nw4TkEBh/QX0RJrJxOyY3Q=
Subject: FAILED: patch "[PATCH] drm/amd/display: Adjust cursor position" failed to apply to 6.6-stable tree
To: Rodrigo.Siqueira@amd.com,alexander.deucher@amd.com,chiahsuan.chung@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,wayne.lin@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 12:19:11 +0200
Message-ID: <2024081911-spending-purchase-3a01@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 56fb276d0244d430496f249335a44ae114dd5f54
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081911-spending-purchase-3a01@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

56fb276d0244 ("drm/amd/display: Adjust cursor position")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 56fb276d0244d430496f249335a44ae114dd5f54 Mon Sep 17 00:00:00 2001
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Date: Thu, 1 Aug 2024 16:16:35 -0600
Subject: [PATCH] drm/amd/display: Adjust cursor position

[why & how]
When the commit 9d84c7ef8a87 ("drm/amd/display: Correct cursor position
on horizontal mirror") was introduced, it used the wrong calculation for
the position copy for X. This commit uses the correct calculation for that
based on the original patch.

Fixes: 9d84c7ef8a87 ("drm/amd/display: Correct cursor position on horizontal mirror")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 8f9b23abbae5ffcd64856facd26a86b67195bc2f)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 1b9ac8812f5b..14a902ff3b8a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3682,7 +3682,7 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 						(int)hubp->curs_attr.width || pos_cpy.x
 						<= (int)hubp->curs_attr.width +
 						pipe_ctx->plane_state->src_rect.x) {
-						pos_cpy.x = 2 * viewport_width - temp_x;
+						pos_cpy.x = temp_x + viewport_width;
 					}
 				}
 			} else {


