Return-Path: <stable+bounces-233655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPobLHQg1Wnr0wcAu9opvQ
	(envelope-from <stable+bounces-233655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:19:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CDF3B0D0D
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D8BE302C6D7
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 15:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E1835AC19;
	Tue,  7 Apr 2026 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aqN4tfgA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF851349AE0
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574884; cv=none; b=cQJc2QsYCeh4cnLMioaCktKy0DM0SVF4C2pMnBSgKh6JJV/2YtDRwwtHiqDcX7JxaRClqKf2ehTvBhwj4Izo/RuTDFRfxPwqvTw+yopfcS6HVdWlXRgze3MaQD4+Uu699Ev82bN2L/dBAgicrGyVeTL+sQiCg81hSR18p8FA70I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574884; c=relaxed/simple;
	bh=Rxjx4c6Fo8t5AcvLVeAzvXuURWMnLtbLVXfScxH3dsM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c1sl+KY5oCDFvQb1VfkgZnigbUxC/e9nT+4fcP12JI1uajtjc4j0wL024x72vrgC9Di65seOeclXBEcmllStWGo+794RMfAav0WvMCxNiV3NDhwtTUjL5YUFdha/WiqYvIKG7Bn0UEOlJWnNjqiQqT1FVXxMeKNf3l7wllxvZog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aqN4tfgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2089EC116C6;
	Tue,  7 Apr 2026 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775574884;
	bh=Rxjx4c6Fo8t5AcvLVeAzvXuURWMnLtbLVXfScxH3dsM=;
	h=Subject:To:Cc:From:Date:From;
	b=aqN4tfgAk95EtWTrTvvEFIKLfXNFTdBZQYzodQp2tx1Xu23JVY9DoTm5JOzsI/yiV
	 Q8KDsBACMyQ8xYlPRhAGd1/Dik6RCgrtBJkpUM6727Dits9kwSW0GlJdVMfF12lMtT
	 lVXM+I3yXj4LscTLgpANOWhdSbXcCiyASBSD2Uto=
Subject: FAILED: patch "[PATCH] drm/i915/dsi: Don't do DSC horizontal timing adjustments in" failed to apply to 6.1-stable tree
To: ville.syrjala@linux.intel.com,jani.nikula@intel.com,joonas.lahtinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 17:14:33 +0200
Message-ID: <2026040733-geologist-carol-5b77@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233655-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,intel.com:email,gitlab.freedesktop.org:url,msgid.link:url]
X-Rspamd-Queue-Id: F2CDF3B0D0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4dfce79e098915d8e5fc2b9e1d980bc3251dd32c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040733-geologist-carol-5b77@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4dfce79e098915d8e5fc2b9e1d980bc3251dd32c Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Thu, 26 Mar 2026 13:18:10 +0200
Subject: [PATCH] drm/i915/dsi: Don't do DSC horizontal timing adjustments in
 command mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Stop adjusting the horizontal timing values based on the
compression ratio in command mode. Bspec seems to be telling
us to do this only in video mode, and this is also how the
Windows driver does things.

This should also fix a div-by-zero on some machines because
the adjusted htotal ends up being so small that we end up with
line_time_us==0 when trying to determine the vtotal value in
command mode.

Note that this doesn't actually make the display on the
Huawei Matebook E work, but at least the kernel no longer
explodes when the driver loads.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/12045
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patch.msgid.link/20260326111814.9800-2-ville.syrjala@linux.intel.com
Fixes: 53693f02d80e ("drm/i915/dsi: account for DSC in horizontal timings")
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 0b475e91ecc2313207196c6d7fd5c53e1a878525)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index fc265f71d72b..298b3a48197c 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -889,7 +889,7 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
 	 * non-compressed link speeds, and simplifies down to the ratio between
 	 * compressed and non-compressed bpp.
 	 */
-	if (crtc_state->dsc.compression_enable) {
+	if (is_vid_mode(intel_dsi) && crtc_state->dsc.compression_enable) {
 		mul = fxp_q4_to_int(crtc_state->dsc.compressed_bpp_x16);
 		div = mipi_dsi_pixel_format_to_bpp(intel_dsi->pixel_format);
 	}
@@ -1503,7 +1503,7 @@ static void gen11_dsi_get_timings(struct intel_encoder *encoder,
 	struct drm_display_mode *adjusted_mode =
 					&pipe_config->hw.adjusted_mode;
 
-	if (pipe_config->dsc.compressed_bpp_x16) {
+	if (is_vid_mode(intel_dsi) && pipe_config->dsc.compressed_bpp_x16) {
 		int div = fxp_q4_to_int(pipe_config->dsc.compressed_bpp_x16);
 		int mul = mipi_dsi_pixel_format_to_bpp(intel_dsi->pixel_format);
 


