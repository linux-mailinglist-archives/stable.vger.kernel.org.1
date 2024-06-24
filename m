Return-Path: <stable+bounces-55056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E5B915402
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 18:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BB1B209E9
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E027D19DF6F;
	Mon, 24 Jun 2024 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ufguTDRc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1F019AA7E
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246957; cv=none; b=gVigMmFc7BRMgAUpU00IpqmY4ec2AiSiA9nEq+08wB98EfEI+rxRCCusYYqHDtN0mfFVzZIfIqJitTldATJyzFMHB6iY7ICMlp2VtTSNwcOF2LTfu3rMPI4iPWGSttGAl2KDVNQ0iLImXX7I4hPdUGbjz268YBjPMF37VKrCEvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246957; c=relaxed/simple;
	bh=YrGM0EyR/T2p/02B+5Mz6+KiDPd9puyEo1Jw35Yc/WI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FcPaggjSffkKJiU+AsBPK8vnNSYVkdHz0E3sDk90/k9JOjOIpLYvt3YOgMLtDi4gmZMRJnuWZm88RL2Usvib76rRNrN25NpdHITLEBKAROkyYggdMmAgpMnGGMf+M8o0USmMBGH5XiUfGFNC9TIlsj5/5CLrIo9KAPHTAb7AR50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ufguTDRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF80BC2BBFC;
	Mon, 24 Jun 2024 16:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719246957;
	bh=YrGM0EyR/T2p/02B+5Mz6+KiDPd9puyEo1Jw35Yc/WI=;
	h=Subject:To:Cc:From:Date:From;
	b=ufguTDRcP2nVyOo3aY0TF9IpYcB8RFzSbIfNHaMdSJ0WRsIVitGvMk31F5CS7kRYI
	 m0yRySIgMSCQrYBst3W8GQjwYsfa63ilGPokct8uMwCxvlAh5+0U7ikYCTXNeQnkBF
	 RnGp3nq/utj6X61z5trTb5lvZDlJ9SOiLPcAW96w=
Subject: FAILED: patch "[PATCH] drm/amd/display: prevent register access while in IPS" failed to apply to 6.6-stable tree
To: hamza.mahfooz@amd.com,alexander.deucher@amd.com,roman.li@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 18:35:54 +0200
Message-ID: <2024062453-fretted-sulfur-3c0f@gregkh>
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
git cherry-pick -x 56342da3d8cc15efe9df7f29985ba8d256bdc258
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062453-fretted-sulfur-3c0f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 56342da3d8cc15efe9df7f29985ba8d256bdc258 Mon Sep 17 00:00:00 2001
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
index e426adf95d7d..e9ac20bed0f2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11437,6 +11437,12 @@ void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
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
@@ -11447,6 +11453,8 @@ void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
 		return;
 	}
 #endif
+
+	amdgpu_dm_exit_ips_for_hw_access(ctx->dc);
 	cgs_write_register(ctx->cgs_device, address, value);
 	trace_amdgpu_dc_wreg(&ctx->perf_trace->write_count, address, value);
 }
@@ -11470,6 +11478,8 @@ uint32_t dm_read_reg_func(const struct dc_context *ctx, uint32_t address,
 		return 0;
 	}
 
+	amdgpu_dm_exit_ips_for_hw_access(ctx->dc);
+
 	value = cgs_read_register(ctx->cgs_device, address);
 
 	trace_amdgpu_dc_rreg(&ctx->perf_trace->read_count, address, value);


