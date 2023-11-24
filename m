Return-Path: <stable+bounces-258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 716327F760A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1556CB212E2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161BC2C85B;
	Fri, 24 Nov 2023 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nfXyguhB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAE528E25
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537D1C433CA;
	Fri, 24 Nov 2023 14:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700835249;
	bh=SLGVCrOaZZ9Fj162ph1miBl61WfHWPDiALr3MMGZ2CI=;
	h=Subject:To:Cc:From:Date:From;
	b=nfXyguhBohCVYzxir7V/ZdK7PbKB3sMAqSkxsJRV1rDmjgFFuotayPfm8+thsinsl
	 /Xzp0u6k1U2IBBY0OdiAOf7HjTQEnXmFsqsgzKAshZRa/Yp2G5kjWi6nCpzz5mx8Z9
	 JPzfTYoc1AcxmiIOS5X8NTIoyS1DrXr/eHRjB+so=
Subject: FAILED: patch "[PATCH] drm/amd/display: limit the v_startup workaround to ASICs" failed to apply to 6.1-stable tree
To: hamza.mahfooz@amd.com,alexander.deucher@amd.com,jerry.zuo@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 14:13:58 +0000
Message-ID: <2023112458-pretended-legged-8883@gregkh>
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
git cherry-pick -x 813ba1ff8484e801d2ef155e0e5388b8a7691788
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112458-pretended-legged-8883@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

813ba1ff8484 ("drm/amd/display: limit the v_startup workaround to ASICs older than DCN3.1")
63461ea3fb40 ("Revert "drm/amd/display: Remove v_startup workaround for dcn3+"")
3a31e8b89b72 ("drm/amd/display: Remove v_startup workaround for dcn3+")
e95afc1cf7c6 ("drm/amd/display: Enable AdaptiveSync in DC interface")
d5a43956b73b ("drm/amd/display: move dp capability related logic to link_dp_capability")
94dfeaa46925 ("drm/amd/display: move dp phy related logic to link_dp_phy")
630168a97314 ("drm/amd/display: move dp link training logic to link_dp_training")
238debcaebe4 ("drm/amd/display: Use DML for MALL SS and Subvp allocation calculations")
d144b40a4833 ("drm/amd/display: move dc_link_dpia logic to link_dp_dpia")
a28d0bac0956 ("drm/amd/display: move dpcd logic from dc_link_dpcd to link_dpcd")
a98cdd8c4856 ("drm/amd/display: refactor ddc logic from dc_link_ddc to link_ddc")
4370f72e3845 ("drm/amd/display: refactor hpd logic from dc_link to link_hpd")
0e8cf83a2b47 ("drm/amd/display: allow hpo and dio encoder switching during dp retrain test")
7462475e3a06 ("drm/amd/display: move dccg programming from link hwss hpo dp to hwss")
e85d59885409 ("drm/amd/display: use encoder type independent hwss instead of accessing enc directly")
ebf13b72020a ("drm/amd/display: Revert Scaler HCBlank issue workaround")
639f6ad6df7f ("drm/amd/display: Revert Reduce delay when sink device not able to ACK 00340h write")
d5bec4030fd7 ("drm/amd/display: Use DCC meta pitch for MALL allocation requirements")
359bcc904e23 ("drm/amd/display: Fix arithmetic error in MALL size calculations for subvp")
719b59a3fac1 ("drm/amd/display: MALL SS calculations should iterate over all pipes for cursor")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 813ba1ff8484e801d2ef155e0e5388b8a7691788 Mon Sep 17 00:00:00 2001
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
Date: Thu, 31 Aug 2023 15:22:35 -0400
Subject: [PATCH] drm/amd/display: limit the v_startup workaround to ASICs
 older than DCN3.1

Since, calling dcn20_adjust_freesync_v_startup() on DCN3.1+ ASICs
can cause the display to flicker and underflow to occur, we shouldn't
call it for them. So, ensure that the DCN version is less than
DCN_VERSION_3_1 before calling dcn20_adjust_freesync_v_startup().

Cc: stable@vger.kernel.org
Reviewed-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 1bfdf0271fdf..a68fb45ed487 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1099,7 +1099,8 @@ void dcn20_calculate_dlg_params(struct dc *dc,
 		context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz =
 						pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
 		context->res_ctx.pipe_ctx[i].pipe_dlg_param = pipes[pipe_idx].pipe.dest;
-		if (context->res_ctx.pipe_ctx[i].stream->adaptive_sync_infopacket.valid)
+		if (dc->ctx->dce_version < DCN_VERSION_3_1 &&
+		    context->res_ctx.pipe_ctx[i].stream->adaptive_sync_infopacket.valid)
 			dcn20_adjust_freesync_v_startup(
 				&context->res_ctx.pipe_ctx[i].stream->timing,
 				&context->res_ctx.pipe_ctx[i].pipe_dlg_param.vstartup_start);


