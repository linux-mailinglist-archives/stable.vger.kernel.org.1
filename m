Return-Path: <stable+bounces-121569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3A4A58307
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 11:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3117A16BDB4
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 10:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5E8191494;
	Sun,  9 Mar 2025 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xihwcn8k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D868C2C8
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741516320; cv=none; b=s34arBlhjg/Lz5jjNJMqgNXxFu8HxXb0pPIeWGodtConKEzyontjdOpEUumiYOmOTvIIRtcU9IFhipWVRWseslUJVSoR8JEx6JkG9bWk1VRFJb1M4XmVZdi3zr1ivH8gk/FnJ+pcSP5DkQkWdiIu3xv1aiE5KIVVcvVND3E5lIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741516320; c=relaxed/simple;
	bh=0+CE4h2vKjDT44vssyZbBDzunm0x2BAj5NW4r7PgrT8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C4nDQDbgFW9G/LvjDoznV+RzBGKE/pWckTFsYbWKXzAUEXPD9FLEIGt2NXSBPRSrnpNNSqw9nm5h1rLuEfrd+SPCCwM3hmrnc9ZZwjkBxOQ0ho9JEtwjfRBND4K/8o3Rb/8pH2wZdebpSt71o1Fu2vpmV732WHuz2PECv4Tuvgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xihwcn8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6CDC4CEEC;
	Sun,  9 Mar 2025 10:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741516319;
	bh=0+CE4h2vKjDT44vssyZbBDzunm0x2BAj5NW4r7PgrT8=;
	h=Subject:To:Cc:From:Date:From;
	b=xihwcn8k2N470mX13NZG3GXygVyY0B8LF3XSIFPeMvTXs5K9G7qP/k9yey/E3hR+F
	 ubCZ7b4pexn5AuMdaJcSUsbIK2t+NZn/2plovwJAPkx3IeYbbO3YFoT4TCiaJPFMiN
	 Iwfix4LPmNvRNDZc1NKJtd3gRjjwvpbomUIf/FIQ=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix null check for pipe_ctx->plane_state in" failed to apply to 5.4-stable tree
To: make24@iscas.ac.cn,alex.hung@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Mar 2025 11:30:33 +0100
Message-ID: <2025030933-vividness-retreat-a4bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 374c9faac5a763a05bc3f68ad9f73dab3c6aec90
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030933-vividness-retreat-a4bf@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 374c9faac5a763a05bc3f68ad9f73dab3c6aec90 Mon Sep 17 00:00:00 2001
From: Ma Ke <make24@iscas.ac.cn>
Date: Wed, 26 Feb 2025 16:37:31 +0800
Subject: [PATCH] drm/amd/display: Fix null check for pipe_ctx->plane_state in
 resource_build_scaling_params

Null pointer dereference issue could occur when pipe_ctx->plane_state
is null. The fix adds a check to ensure 'pipe_ctx->plane_state' is not
null before accessing. This prevents a null pointer dereference.

Found by code review.

Fixes: 3be5262e353b ("drm/amd/display: Rename more dc_surface stuff to plane_state")
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 63e6a77ccf239337baa9b1e7787cde9fa0462092)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 520a34a42827..a45037cb4cc0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1455,7 +1455,8 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 
 	/* Invalid input */
-	if (!plane_state->dst_rect.width ||
+	if (!plane_state ||
+			!plane_state->dst_rect.width ||
 			!plane_state->dst_rect.height ||
 			!plane_state->src_rect.width ||
 			!plane_state->src_rect.height) {


