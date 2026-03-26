Return-Path: <stable+bounces-230451-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F78AyIaxWnr6QQAu9opvQ
	(envelope-from <stable+bounces-230451-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 12:36:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF3F33499B
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 12:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0AC2630C3702
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 11:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946B33DA7D9;
	Thu, 26 Mar 2026 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJnUSpCG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331833CB2FA
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523909; cv=none; b=D5ImeWvuS2rMM6G2NLWj73if18b2ifYjNN+iiXips/aY6vKrRYT7ATjAX+rlVTELJcfLaXmMNg1q1+wMbubDld9oGz71nGjG6VaqKq+TFvGp5cewaXJKXJL/tbSwL4xXGKnuNG6QI16JY03XLAM2OSMMKAbH4EXwrRU/V2/GUFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523909; c=relaxed/simple;
	bh=ApCVMVjwnS7a/xHuzJFTiqSOxaahZ6dDvpv4mYLb4Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpMVWil+AME+Bs2gGcjM7BjZ6i4tByFLrgCF4Xnitkzto+kNcWZDCEwF/36ubfNMvCjA7QFR24b1S7AKzuftuU3ZDut/o+wWYPT8PxPM9W3riyWL4ZufPhuREHa0hgokvJmw9xBadBWGYM73veoeXlkONwg/ln4PBSdUUjALE7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJnUSpCG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774523906; x=1806059906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ApCVMVjwnS7a/xHuzJFTiqSOxaahZ6dDvpv4mYLb4Hs=;
  b=kJnUSpCGQAu7bV0hGeLRQvdLvyjvbaOMkufN3NnCrmUjjXoCG0g6QaSA
   /y6tbOTx4Q70XnpEgvkqpSnRY+/qyfIXihxohiUo+7tMH1WvuSbkvYXly
   2YUo1hGVCQ5uK3b2DZmSNnWjKR11pHVQNpX5GTUbBdp3YMmO4oJYiFKNA
   w/+ygSlIP2OCmwXlua7raRkPOI2J19BfrcYnj5qaJpf7AZtQhKlGgtlOl
   5B454W4m6YPmMD6KmrUGAHSCCtHhfY+vqeeDXDkNEYMn1NBjvf8XB9iid
   HmmBVS7nr96l3RimmOhqQMOJcMi9k5lFVgZMrH9+AP+vRRC/lyqTbIg8Z
   w==;
X-CSE-ConnectionGUID: 1a/yxJkIQpWsoVNwReYO5w==
X-CSE-MsgGUID: TcGbreb8SQql+vgbS+3Z4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75692309"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75692309"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 04:18:22 -0700
X-CSE-ConnectionGUID: qWSf1oJbRbWwWSMTN9IllA==
X-CSE-MsgGUID: uJD/pltARlmeK2g7HvPv3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="220127404"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.14])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 04:18:20 -0700
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH 1/5] drm/i915/dsi: Don't do DSC horizontal timing adjustments in command mode
Date: Thu, 26 Mar 2026 13:18:10 +0200
Message-ID: <20260326111814.9800-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326111814.9800-1-ville.syrjala@linux.intel.com>
References: <20260326111814.9800-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230451-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ville.syrjala@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: CDF3F33499B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Stop adjusting the horizontal timing values based on the
compression ratio in command mode. Bspec seems to be telling
us to do this only in video mode, and this is also how the
Windows driver does things.

This should also fix a div-by-zero on some machines because due to
the adjusted htotal ends up being so small that we end up with
line_time_us==0 when trying to determine the vtotal value in
command mode.

Note that this doesn't actually make the display on the
Huawei Matebook E work, but at least the kernel no longer
explodes when the driver loads.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/12045
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/icl_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index c04327979678..a763f2b13ff2 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -888,7 +888,7 @@ gen11_dsi_set_transcoder_timings(struct intel_encoder *encoder,
 	 * non-compressed link speeds, and simplifies down to the ratio between
 	 * compressed and non-compressed bpp.
 	 */
-	if (crtc_state->dsc.compression_enable) {
+	if (is_vid_mode(intel_dsi) && crtc_state->dsc.compression_enable) {
 		mul = fxp_q4_to_int(crtc_state->dsc.compressed_bpp_x16);
 		div = mipi_dsi_pixel_format_to_bpp(intel_dsi->pixel_format);
 	}
@@ -1502,7 +1502,7 @@ static void gen11_dsi_get_timings(struct intel_encoder *encoder,
 	struct drm_display_mode *adjusted_mode =
 					&pipe_config->hw.adjusted_mode;
 
-	if (pipe_config->dsc.compressed_bpp_x16) {
+	if (is_vid_mode(intel_dsi) && pipe_config->dsc.compressed_bpp_x16) {
 		int div = fxp_q4_to_int(pipe_config->dsc.compressed_bpp_x16);
 		int mul = mipi_dsi_pixel_format_to_bpp(intel_dsi->pixel_format);
 
-- 
2.52.0


