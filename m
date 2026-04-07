Return-Path: <stable+bounces-233610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDt9Fn0b1Wli0wcAu9opvQ
	(envelope-from <stable+bounces-233610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:58:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D313B07B8
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 16:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85C5D3100A99
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 14:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D73E33AD9C;
	Tue,  7 Apr 2026 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ojBuZ3Ik"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E568C278156
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573522; cv=none; b=oQAapkFVBpDkKAkATaP9xadwjTbqRhjVXPmzXMbEJKaHD0nghTh2tQs9aLpj6KIwdJquijK0HDXQbHnc4dXhqsER6/pCHal3N+1y2RlGCo+uN50rbbBwQIYFgn9He6AUUHYqzJfv9KoQ/NXO5FPAUQEq8OmlP0S9MpMR91M1h2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573522; c=relaxed/simple;
	bh=1Q6tKYjrpdweoByNdz1lOF5+wwKn46RE0/iWpwpy5zY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mgELrX8ZLJ++cGG7gKpB/6leVYSrfPJRHkhm0anfl1S5VCN/nfs4vW56zfnQQesEGq/vXzTu1JzWh0Z8MjziuwCH+z+FnBShmy0OcS7P3jSDdTg1zEL944vlTx9xWK5Ol9/BYlpNdiqaytUzZY9cv5kDyGYBPGHZZOv0v1uOorE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ojBuZ3Ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AF4C116C6;
	Tue,  7 Apr 2026 14:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775573521;
	bh=1Q6tKYjrpdweoByNdz1lOF5+wwKn46RE0/iWpwpy5zY=;
	h=Subject:To:Cc:From:Date:From;
	b=ojBuZ3IkhDcfwtEsth3CiGKTYduswbG/TghipqIZL5GqskwI3ZotEciZaZg4J2D5v
	 W75E3zm3PNvNMKHawsyfQSvks+zzd10+t6brnPsokbJcMuZIrkc3Hn8rvqg/W7C4RV
	 OxfM13BRKlcvPXQ+pgoFE18D6/xNGOGS+DALO4rw=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix NULL pointer dereference in" failed to apply to 6.12-stable tree
To: srinivasan.shanmugam@amd.com,Daniel.Sa@amd.com,alex.hung@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,aurabindo.pillai@amd.com,chiahsuan.chung@amd.com,dan.carpenter@linaro.org,roman.li@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 16:51:58 +0200
Message-ID: <2026040758-chewy-patio-72a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233610-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,amd.com:email]
X-Rspamd-Queue-Id: B0D313B07B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e927b36ae18b66b49219eaa9f46edc7b4fdbb25e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040758-chewy-patio-72a3@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e927b36ae18b66b49219eaa9f46edc7b4fdbb25e Mon Sep 17 00:00:00 2001
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Date: Sat, 21 Mar 2026 17:25:14 +0530
Subject: [PATCH] drm/amd/display: Fix NULL pointer dereference in
 dcn401_init_hw()

dcn401_init_hw() assumes that update_bw_bounding_box() is valid when
entering the update path. However, the existing condition:

  ((!fams2_enable && update_bw_bounding_box) || freq_changed)

does not guarantee this, as the freq_changed branch can evaluate to true
independently of the callback pointer.

This can result in calling update_bw_bounding_box() when it is NULL.

Fix this by separating the update condition from the pointer checks and
ensuring the callback, dc->clk_mgr, and bw_params are validated before
use.

Fixes the below:
../dc/hwss/dcn401/dcn401_hwseq.c:367 dcn401_init_hw() error: we previously assumed 'dc->res_pool->funcs->update_bw_bounding_box' could be null (see line 362)

Fixes: ca0fb243c3bb ("drm/amd/display: Underflow Seen on DCN401 eGPU")
Cc: Daniel Sa <Daniel.Sa@amd.com>
Cc: Alvin Lee <alvin.lee2@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 86117c5ab42f21562fedb0a64bffea3ee5fcd477)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index eb198d52a115..4dfb6c865831 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -147,6 +147,7 @@ void dcn401_init_hw(struct dc *dc)
 	int edp_num;
 	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
 	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
+	bool dchub_ref_freq_changed;
 	int current_dchub_ref_freq = 0;
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks) {
@@ -360,14 +361,18 @@ void dcn401_init_hw(struct dc *dc)
 		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
 		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver > 0;
 		dc->caps.dmub_caps.fams_ver = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
+
+		/* sw and fw FAMS versions must match for support */
 		dc->debug.fams2_config.bits.enable &=
-				dc->caps.dmub_caps.fams_ver == dc->debug.fams_version.ver; // sw & fw fams versions must match for support
-		if ((!dc->debug.fams2_config.bits.enable && dc->res_pool->funcs->update_bw_bounding_box)
-			|| res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 != current_dchub_ref_freq) {
+			dc->caps.dmub_caps.fams_ver == dc->debug.fams_version.ver;
+		dchub_ref_freq_changed =
+			res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 != current_dchub_ref_freq;
+		if ((!dc->debug.fams2_config.bits.enable || dchub_ref_freq_changed) &&
+		    dc->res_pool->funcs->update_bw_bounding_box &&
+		    dc->clk_mgr && dc->clk_mgr->bw_params) {
 			/* update bounding box if FAMS2 disabled, or if dchub clk has changed */
-			if (dc->clk_mgr)
-				dc->res_pool->funcs->update_bw_bounding_box(dc,
-									    dc->clk_mgr->bw_params);
+			dc->res_pool->funcs->update_bw_bounding_box(dc,
+								    dc->clk_mgr->bw_params);
 		}
 	}
 }


