Return-Path: <stable+bounces-66669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDDF94F0A4
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C179E1C21C5F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82264183087;
	Mon, 12 Aug 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yG7NrysP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43131183061
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474345; cv=none; b=PtDubHzhQ5bLCQ7y6rCRwQU6s8DS550f9gznP5qAvIXML4m28Vd7pRD2yWc1M1s1wYjz/Itc49qzy/n1rA/G5mkEW2fV0hNtg22L5a2RPTZXDcDcpmI9ZJuDb4VAgwgQzf6F6PB92rk4s/yHBQqCdRxIdGMaElxkHWEM5TGpH6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474345; c=relaxed/simple;
	bh=gvyD4BCPQBl7h8PG1HqpkuJOG/NldGJuV96ldqSkNEs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ErsjIB8NgQcQulh4ny4ioilO8KcZPI83aYEJTY70vCC6Z+9Lj4Gd0CIYoTXjPIRwBh7oVRabj6rluJ6TZ0jtAJLxXjSkWn6ija+3kRSDpYcd8prjGh7FLaNBaMoGTvVVql28B2zkDWDw6S+e595Rc46I/i+PVKDQ9dgVwQITE24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yG7NrysP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D833C32782;
	Mon, 12 Aug 2024 14:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723474345;
	bh=gvyD4BCPQBl7h8PG1HqpkuJOG/NldGJuV96ldqSkNEs=;
	h=Subject:To:Cc:From:Date:From;
	b=yG7NrysPdAmrgBiYn+cILQt71V/wnOH5G6CKl9mAn9jI8i0VoShxUXG3cPLLgkFuM
	 6UQPLELeyp846hD9kTX2K1Bcum155x/U/9+s3OdwobbqVaMJF+1yM6ZIMZktbJ4sCw
	 EWm2PCYzPb81bP2H3ip7FbTB5lXS7MIB47CO8A7g=
Subject: FAILED: patch "[PATCH] drm/amd/display: Add null check to" failed to apply to 6.10-stable tree
To: dillon.varone@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:50:00 +0200
Message-ID: <2024081259-observer-unroll-e6c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x a157dcc521dcb8eb0acb50d66d1b0fc5efcea789
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081259-observer-unroll-e6c5@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

a157dcc521dc ("drm/amd/display: Add null check to dml21_find_dc_pipes_for_plane")
70839da63605 ("drm/amd/display: Add new DCN401 sources")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a157dcc521dcb8eb0acb50d66d1b0fc5efcea789 Mon Sep 17 00:00:00 2001
From: Dillon Varone <dillon.varone@amd.com>
Date: Tue, 4 Jun 2024 15:34:36 -0400
Subject: [PATCH] drm/amd/display: Add null check to
 dml21_find_dc_pipes_for_plane

When a phantom stream is in the process of being deconstructed, there
could be pipes with no associated planes.  In that case, ignore the
phantom stream entirely when searching for associated pipes.

Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
index 4e12810308a4..4166332b5b89 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
@@ -126,10 +126,15 @@ int dml21_find_dc_pipes_for_plane(const struct dc *in_dc,
 	if (dc_phantom_stream && num_pipes > 0) {
 		dc_phantom_stream_status = dml_ctx->config.callbacks.get_stream_status(context, dc_phantom_stream);
 
-		/* phantom plane will have same index as main */
-		dc_phantom_plane = dc_phantom_stream_status->plane_states[dc_plane_index];
+		if (dc_phantom_stream_status) {
+			/* phantom plane will have same index as main */
+			dc_phantom_plane = dc_phantom_stream_status->plane_states[dc_plane_index];
 
-		dml_ctx->config.callbacks.get_dpp_pipes_for_plane(dc_phantom_plane, &context->res_ctx, dc_phantom_pipes);
+			if (dc_phantom_plane) {
+				/* only care about phantom pipes if they contain the phantom plane */
+				dml_ctx->config.callbacks.get_dpp_pipes_for_plane(dc_phantom_plane, &context->res_ctx, dc_phantom_pipes);
+			}
+		}
 	}
 
 	return num_pipes;


