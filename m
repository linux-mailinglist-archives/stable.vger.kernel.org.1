Return-Path: <stable+bounces-164923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD86B13A3C
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823BE17A58C
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 12:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C57262FE7;
	Mon, 28 Jul 2025 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w326rfl2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A58262FDD
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753704456; cv=none; b=INxMg1Qlkyd9jwmkJe1WWrCVwURpWfKH/Ho+dlMtJyBlTNBRMH7VnPN874cz90Tz2PDdprfHDlPyOaXxx2HmZC3XD4Dd7mJBN0uA0EWF59AgGhpBb5QT4Y4l19ePmE1Q3jJNqzYWQQAcGj9LuO6wqal2c5zq49LiTjZs9tUZ48M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753704456; c=relaxed/simple;
	bh=KajfQnRUJBt5vqbOlCVbpWuimoggwEQKxqjGPDMh2x8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n+yN6afF25FhY80BKoxojbWxNcXZG8VfSjc0wtiXo9IxdaVLwMP3+Nr+DV7YW3fMs9U8Z9PMT2WBcjC/UMnvPbwFyPzEUHNjNQXLSqInsmAF38LkKs0mANtEdW3YqGjpRjiw5sD0HYvihR6g0MhUB3T81xVxzX5HDcFBwIB9u7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w326rfl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6C1C4CEE7;
	Mon, 28 Jul 2025 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753704455;
	bh=KajfQnRUJBt5vqbOlCVbpWuimoggwEQKxqjGPDMh2x8=;
	h=Subject:To:Cc:From:Date:From;
	b=w326rfl2fdhPx8zTixlpj7nW4J+VhjkbVkdZtLqsqQQs+mSfafhfg2OnKWnGbdgAm
	 kIkuqkx9BHL8iVYi2F13L87wRQHAQa0KYoxrVoEZwvJ2TkJQ5ITj9wa1qFSbOk4uqO
	 vN0sGou/mlfrSlCeDVt1b+Tc3Aa/fzCWqDIjvtUQ=
Subject: FAILED: patch "[PATCH] drm/i915/dp: Fix 2.7 Gbps DP_LINK_BW value on g4x" failed to apply to 6.12-stable tree
To: ville.syrjala@linux.intel.com,imre.deak@intel.com,rodrigo.vivi@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Jul 2025 14:07:33 +0200
Message-ID: <2025072832-cannabis-shout-55f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9e0c433d0c05fde284025264b89eaa4ad59f0a3e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072832-cannabis-shout-55f6@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


