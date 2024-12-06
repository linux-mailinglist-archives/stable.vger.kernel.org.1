Return-Path: <stable+bounces-99077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259FD9E6F3B
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1225282B21
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F28C207652;
	Fri,  6 Dec 2024 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hWHzTBOG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28BA20764F
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491423; cv=none; b=Ue9uD9m6Su4kb6B2hJ+uR3pdGuidGofCPyIPxC32h5b6mDER39wNbJEQjTVs/PSc091OUoqfkbFA1rCwf6xABDbg44sPB+sa/60PXgXVAWU+/h2M2Rp2HeaLt3C1mYzuHYieEMKwGo6meJnJiJ6cK3BFI1YBqNdG1HzXk1ZcI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491423; c=relaxed/simple;
	bh=sdiysdF1BbQeTT5pWZDM+Q/Y/qAqom2/R2ZoRKyQzi4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DOQ4X+MbxTUOkq7KzJitva0gnMQ1gsNtz2iMhwnj/jriueQ9yBy4AxKezIvqic456hsEV6DcXOWs8tRoTizOtypwGuQaCBeZ+oN/dXmxrDs2/wpSZ4keBaoaUQbfpq1QnphNpUKX6WV/SNkiVNmtG6HRLdZ+KHma3Sg7N5sY6gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hWHzTBOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FC3C4CED1;
	Fri,  6 Dec 2024 13:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733491423;
	bh=sdiysdF1BbQeTT5pWZDM+Q/Y/qAqom2/R2ZoRKyQzi4=;
	h=Subject:To:Cc:From:Date:From;
	b=hWHzTBOGPl0Fpa2DjB8FEA6KyWI9wP4fyhyU+uRTE5XH7jE+EsLx4+m4xmL7BxTXw
	 5rUo6foJK0XaOfXa6HaDC3EN6wReS93wWIbsBrcsMVb89VywOjrVuADLLBDXqCcfsV
	 zQCBOU1I9EYWuuJLUqHcwqcGi0ae6B8i3Yvj9HBE=
Subject: FAILED: patch "[PATCH] drm/amd/display: Ignore scalar validation failure if pipe is" failed to apply to 6.12-stable tree
To: chris.park@amd.com,alexander.deucher@amd.com,daniel.wheeler@amd.com,dillon.varone@amd.com,hamza.mahfooz@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 14:22:41 +0100
Message-ID: <2024120640-carrot-unaired-fbcc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c33a93201ca07119de90e8c952fbdf65920ab55d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120640-carrot-unaired-fbcc@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c33a93201ca07119de90e8c952fbdf65920ab55d Mon Sep 17 00:00:00 2001
From: Chris Park <chris.park@amd.com>
Date: Mon, 4 Nov 2024 13:18:39 -0500
Subject: [PATCH] drm/amd/display: Ignore scalar validation failure if pipe is
 phantom

[Why]
There are some pipe scaler validation failure when the pipe is phantom
and causes crash in DML validation. Since, scalar parameters are not
as important in phantom pipe and we require this plane to do successful
MCLK switches, the failure condition can be ignored.

[How]
Ignore scalar validation failure if the pipe validation is marked as
phantom pipe.

Cc: stable@vger.kernel.org # 6.11+
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Chris Park <chris.park@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 33125b95c3a1..619fad17de55 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1501,6 +1501,10 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 		res = spl_calculate_scaler_params(spl_in, spl_out);
 		// Convert respective out params from SPL to scaler data
 		translate_SPL_out_params_to_pipe_ctx(pipe_ctx, spl_out);
+
+		/* Ignore scaler failure if pipe context plane is phantom plane */
+		if (!res && plane_state->is_phantom)
+			res = true;
 	} else {
 #endif
 	/* depends on h_active */
@@ -1571,6 +1575,10 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 					&plane_state->scaling_quality);
 	}
 
+	/* Ignore scaler failure if pipe context plane is phantom plane */
+	if (!res && plane_state->is_phantom)
+		res = true;
+
 	if (res && (pipe_ctx->plane_res.scl_data.taps.v_taps != temp.v_taps ||
 		pipe_ctx->plane_res.scl_data.taps.h_taps != temp.h_taps ||
 		pipe_ctx->plane_res.scl_data.taps.v_taps_c != temp.v_taps_c ||


