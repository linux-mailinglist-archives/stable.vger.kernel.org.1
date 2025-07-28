Return-Path: <stable+bounces-164920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 500AFB139FD
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66764189381B
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 11:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877F525D8F7;
	Mon, 28 Jul 2025 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e8GM969M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3032E22B8C2
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753702976; cv=none; b=jv+Hwv1U54H6YG6VBxa6wqbAX+rsTRkF75tenLdh3VJNrfLzH4YO0HEppoeofmHSfOxP6IGT42b4L7qiPVrU3g4iGxW0rtMpNJpjABOAHTE6oQvWvfnM3oiUI1bDSQ5t+sDGX6ytj/U5JJIRTSddU6vwLpJ5s2DP0RYkPbMp9Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753702976; c=relaxed/simple;
	bh=mGlTOqmcfnOSVPNKQmf4e1yyVF5uPy0qd4gODvnq0Vw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qHQj7eyLD0J3fg+8gQ/JQlu9YawiXBPD7H/9wZn2viNmRG8HG2rgZ6mOR7/hBKDJHHU7EHTVajohgTNRLYd/wV0gydMs8wwLGDG8hOQbQzbeW1YcBSy2fl3cZJpDBU9lCxqjy2EF/oHF0KhNjkdjzO2wNip+bQ84hokGp7dIwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e8GM969M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BE3C4CEE7;
	Mon, 28 Jul 2025 11:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753702975;
	bh=mGlTOqmcfnOSVPNKQmf4e1yyVF5uPy0qd4gODvnq0Vw=;
	h=Subject:To:Cc:From:Date:From;
	b=e8GM969MszTNc9i/TVuQhP0mrh4kz9ZkILdDvcbd9z6s7YKlOx1rx5o0cFkbZs/2c
	 /JPWp+9eJVD0JV8DMYD+yPf09LzD5o7kyYlqi2/JlhmU1qBCgsD/srO0S3KjSKgDAq
	 Ol1cJJ3K6So4gDKgMrynAg1tzFrwQ6Fd9r/HQgkE=
Subject: FAILED: patch "[PATCH] drm/i915/dp: Fix 2.7 Gbps DP_LINK_BW value on g4x" failed to apply to 6.1-stable tree
To: ville.syrjala@linux.intel.com,imre.deak@intel.com,rodrigo.vivi@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Jul 2025 13:42:52 +0200
Message-ID: <2025072852-brewing-moonrise-04ac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 9e0c433d0c05fde284025264b89eaa4ad59f0a3e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072852-brewing-moonrise-04ac@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9e0c433d0c05fde284025264b89eaa4ad59f0a3e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Thu, 10 Jul 2025 23:17:12 +0300
Subject: [PATCH] drm/i915/dp: Fix 2.7 Gbps DP_LINK_BW value on g4x
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On g4x we currently use the 96MHz non-SSC refclk, which can't actually
generate an exact 2.7 Gbps link rate. In practice we end up with 2.688
Gbps which seems to be close enough to actually work, but link training
is currently failing due to miscalculating the DP_LINK_BW value (we
calcualte it directly from port_clock which reflects the actual PLL
outpout frequency).

Ideas how to fix this:
- nudge port_clock back up to 270000 during PLL computation/readout
- track port_clock and the nominal link rate separately so they might
  differ a bit
- switch to the 100MHz refclk, but that one should be SSC so perhaps
  not something we want

While we ponder about a better solution apply some band aid to the
immediate issue of miscalculated DP_LINK_BW value. With this
I can again use 2.7 Gbps link rate on g4x.

Cc: stable@vger.kernel.org
Fixes: 665a7b04092c ("drm/i915: Feed the DPLL output freq back into crtc_state")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250710201718.25310-2-ville.syrjala@linux.intel.com
Reviewed-by: Imre Deak <imre.deak@intel.com>
(cherry picked from commit a8b874694db5cae7baaf522756f87acd956e6e66)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 640c43bf62d4..724de7ed3c04 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1604,6 +1604,12 @@ int intel_dp_rate_select(struct intel_dp *intel_dp, int rate)
 void intel_dp_compute_rate(struct intel_dp *intel_dp, int port_clock,
 			   u8 *link_bw, u8 *rate_select)
 {
+	struct intel_display *display = to_intel_display(intel_dp);
+
+	/* FIXME g4x can't generate an exact 2.7GHz with the 96MHz non-SSC refclk */
+	if (display->platform.g4x && port_clock == 268800)
+		port_clock = 270000;
+
 	/* eDP 1.4 rate select method. */
 	if (intel_dp->use_rate_select) {
 		*link_bw = 0;


