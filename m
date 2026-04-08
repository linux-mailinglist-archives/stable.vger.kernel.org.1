Return-Path: <stable+bounces-235152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PdXIIGl1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:59:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A12013C220D
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFB58301CA9A
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814BF357A20;
	Wed,  8 Apr 2026 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YUBbXrHi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF92F39C2;
	Wed,  8 Apr 2026 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674703; cv=none; b=qmznwVWPzB9aGo6YKToKo2ZKaJnP95rH0n89bYWH1fdGvHxbwb6hhn7q/zxHQ/cvC8w5snA85zZFusN8z5vOsiHlO2qLCKFPlbnTN+fPW6BynsFvmLSLdGPCI4WSzUR7EBCDfXZixskrDxnP+5ZVjEnqficwXIdZF02Nrg/Ro/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674703; c=relaxed/simple;
	bh=P6itY0M9P4Bb6XrhmcdZE/gUzClh0wzHGFEoavr5Msg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T72Pz78j6kLPv+53I4b21SL2OPNKZH1QJ7cPkQ0y7OeA74A6FlGs8zxo4uqoyZQPSWiOk0f3CLc8Aj9jlUxFM6wvDrlNdf/GTgmnnA5Y4zZ57kvy95+7enFG1bTU3mdLFnmFZEgW4V4CMgpLGVQPsE86oxos0LM23EtMLG0NQcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YUBbXrHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF45C19421;
	Wed,  8 Apr 2026 18:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674703;
	bh=P6itY0M9P4Bb6XrhmcdZE/gUzClh0wzHGFEoavr5Msg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUBbXrHiV9r443dqUIiV7yVYLMfR1Udmpj9hJg0XTiyUbaVKbZlGdxEZAw4wJTnp2
	 TCTOdXscV9ebBTMgquxKCS4Jc9wfHP0/9EaWdZi7+SLJdNIOHUgbyY+WFebjOu8fCF
	 1BvllaaaPNZ5hBTCAcrVxEATcPkK1CX1sdT/Lk9Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 6.19 200/311] drm/i915/dsi: Dont do DSC horizontal timing adjustments in command mode
Date: Wed,  8 Apr 2026 20:03:20 +0200
Message-ID: <20260408175946.879560650@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235152-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: A12013C220D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 4dfce79e098915d8e5fc2b9e1d980bc3251dd32c upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/icl_dsi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -889,7 +889,7 @@ gen11_dsi_set_transcoder_timings(struct
 	 * non-compressed link speeds, and simplifies down to the ratio between
 	 * compressed and non-compressed bpp.
 	 */
-	if (crtc_state->dsc.compression_enable) {
+	if (is_vid_mode(intel_dsi) && crtc_state->dsc.compression_enable) {
 		mul = fxp_q4_to_int(crtc_state->dsc.compressed_bpp_x16);
 		div = mipi_dsi_pixel_format_to_bpp(intel_dsi->pixel_format);
 	}
@@ -1503,7 +1503,7 @@ static void gen11_dsi_get_timings(struct
 	struct drm_display_mode *adjusted_mode =
 					&pipe_config->hw.adjusted_mode;
 
-	if (pipe_config->dsc.compressed_bpp_x16) {
+	if (is_vid_mode(intel_dsi) && pipe_config->dsc.compressed_bpp_x16) {
 		int div = fxp_q4_to_int(pipe_config->dsc.compressed_bpp_x16);
 		int mul = mipi_dsi_pixel_format_to_bpp(intel_dsi->pixel_format);
 



