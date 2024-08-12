Return-Path: <stable+bounces-66614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FC894F061
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821CB280E73
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24893184552;
	Mon, 12 Aug 2024 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dxba1uHS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93924B5AE
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474157; cv=none; b=C3PtbzcinPEwjQLHaT8GR9HpjfeKmPonG8/6ZOIJP33PQHiBJ38iGqAwVpwrCNNt3qQhKtC/djDxzYm55Zj2lNspkB3D4VQza88bLVhoNf3z/T5WFHnOH1fwR7AzhlpsJlqsFA1Iv6TcJx1TAy3VBan0HDVhCxvyr/1j4Lnwcls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474157; c=relaxed/simple;
	bh=OXNO6YdvTIXPqXElzwhOq9qTjqvu9+vmLHADpAUoSBw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uFfCN38xtelyCqOZtr7ykR7550ltFAC86RwD/upv9onzbwtBK5UEfRGfZsKih7pklFP8OOHKe8+uKkMpexs9HZDJKWy0RWmSSfhkKqAQNfrJwgjUZMsQMKFzZG2lRFhSC7thecNwimmjxK1x7QyB9L8ssR4QV+rIbQ1Ul/En0tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dxba1uHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC45C32782;
	Mon, 12 Aug 2024 14:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474157;
	bh=OXNO6YdvTIXPqXElzwhOq9qTjqvu9+vmLHADpAUoSBw=;
	h=Subject:To:Cc:From:Date:From;
	b=dxba1uHSwJIqNLCjR2jEF1VDYPxjXoRmMyMFlWU38FwKcPCwkB3L7TroCYDeUJ00j
	 NKxQTmWuCcs6q/LP6eY4U6XfAE5jA6FuVaSPtSWNPOd5wSZNaRO/TXpaPLdws+eQfc
	 Rk/1MHoNTzUS23aEXmzfNTz/E33DbpZpYrnjSIgA=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix cursor size issues" failed to apply to 6.6-stable tree
To: nevenko.stupar@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,sridevi.arvindekar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:48:15 +0200
Message-ID: <2024081215-trilogy-scorebook-d9bc@gregkh>
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
git cherry-pick -x 51dbe0239b1fc7c435867ce28e5eb4394b6641e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081215-trilogy-scorebook-d9bc@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

51dbe0239b1f ("drm/amd/display: Fix cursor size issues")
70839da63605 ("drm/amd/display: Add new DCN401 sources")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 51dbe0239b1fc7c435867ce28e5eb4394b6641e1 Mon Sep 17 00:00:00 2001
From: Nevenko Stupar <nevenko.stupar@amd.com>
Date: Tue, 11 Jun 2024 12:31:38 -0400
Subject: [PATCH] drm/amd/display: Fix cursor size issues

[WHY & HOW]
Fix the cursor size between ODM slices.

Reviewed-by: Sridevi Arvindekar <sridevi.arvindekar@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nevenko Stupar <nevenko.stupar@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 0cf55f557c3c..42753f56d31d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1169,6 +1169,20 @@ void dcn401_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		x_pos -= (prev_odm_width + prev_odm_offset);
 	}
 
+	/* If the position is negative then we need to add to the hotspot
+	 * to fix cursor size between ODM slices
+	 */
+
+	if (x_pos < 0) {
+		pos_cpy.x_hotspot -= x_pos;
+		x_pos = 0;
+	}
+
+	if (y_pos < 0) {
+		pos_cpy.y_hotspot -= y_pos;
+		y_pos = 0;
+	}
+
 	pos_cpy.x = (uint32_t)x_pos;
 	pos_cpy.y = (uint32_t)y_pos;
 


