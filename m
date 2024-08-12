Return-Path: <stable+bounces-66493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF57A94EC50
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B114282E52
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E53214B95B;
	Mon, 12 Aug 2024 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PzlCEck0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1C81366
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464302; cv=none; b=E8Jn+j8gbIRTxAa76o4ulEN2SoSfeh5ZDG0Uf6loal5/sadu3vGnz46zWSLscIBrNQXusRu/ra1/akPw3NV22uHKppjTg52L+abz3XDdfr1YInVdoK4zJdKa8FxDnA6/b7gte7RKV2CTgjRhZzUNs6344nctRow2Dn6XjnH+vlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464302; c=relaxed/simple;
	bh=gCEbp5sratvRiGVjcAhDGYtQoVE/bc3Gq9iCUiYhY4w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Qz8YcUcr7so2VvSKY6S7rSGiuG9NN/lmP3D1H+LEdvVgod6bxtmrz3sfmhu0dJWCvYgEn0nwNtIfwQsflg9LtR5jmgUDu3JfqXEh0IWNQd++fxD3s5DjZI7Z86+1Pnmm1Eil/J1A8OR25vkYirWFQU2XPEDLUMjO2+5lJPs1vSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PzlCEck0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D98C32782;
	Mon, 12 Aug 2024 12:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723464301;
	bh=gCEbp5sratvRiGVjcAhDGYtQoVE/bc3Gq9iCUiYhY4w=;
	h=Subject:To:Cc:From:Date:From;
	b=PzlCEck0pr6XK1sMtnA+1T0o+42EyshVQ/bhMmh4mF8w2PB71ipsDgclMaVbrw+Hd
	 wXmTrWhu1H9KGqmmcyQxGPfx/f/+HKDcGZ8JYGKitfD/9P106kzk5fjiAEcmTfKBv1
	 LNGYyVFC4MchvFOIjyRsLAJB+xTMmRULJ/msIlbM=
Subject: FAILED: patch "[PATCH] drm/amd/display: prevent register access while in IPS" failed to apply to 6.6-stable tree
To: hamza.mahfooz@amd.com,alexander.deucher@amd.com,roman.li@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:04:50 +0200
Message-ID: <2024081250-agency-configure-c36c@gregkh>
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
git cherry-pick -x 02593249fa11ef8d2ca780ef91962f81b04eeea0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081250-agency-configure-c36c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

02593249fa11 ("drm/amd/display: prevent register access while in IPS")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 02593249fa11ef8d2ca780ef91962f81b04eeea0 Mon Sep 17 00:00:00 2001
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
Date: Mon, 3 Jun 2024 10:16:45 -0400
Subject: [PATCH] drm/amd/display: prevent register access while in IPS

We can't read/write to DCN registers while in IPS. Since, that can cause
the system to hang. So, before proceeding with the access in that
scenario, force the system out of IPS.

Cc: stable@vger.kernel.org # 6.6+
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6d468badb669..27acbe3ff57b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11814,6 +11814,12 @@ void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
 	mutex_unlock(&adev->dm.dc_lock);
 }
 
+static inline void amdgpu_dm_exit_ips_for_hw_access(struct dc *dc)
+{
+	if (dc->ctx->dmub_srv && !dc->ctx->dmub_srv->idle_exit_counter)
+		dc_exit_ips_for_hw_access(dc);
+}
+
 void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
 		       u32 value, const char *func_name)
 {
@@ -11824,6 +11830,8 @@ void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
 		return;
 	}
 #endif
+
+	amdgpu_dm_exit_ips_for_hw_access(ctx->dc);
 	cgs_write_register(ctx->cgs_device, address, value);
 	trace_amdgpu_dc_wreg(&ctx->perf_trace->write_count, address, value);
 }
@@ -11847,6 +11855,8 @@ uint32_t dm_read_reg_func(const struct dc_context *ctx, uint32_t address,
 		return 0;
 	}
 
+	amdgpu_dm_exit_ips_for_hw_access(ctx->dc);
+
 	value = cgs_read_register(ctx->cgs_device, address);
 
 	trace_amdgpu_dc_rreg(&ctx->perf_trace->read_count, address, value);


