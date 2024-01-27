Return-Path: <stable+bounces-16118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E9983F0AE
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFB51F2583E
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2614814A97;
	Sat, 27 Jan 2024 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lEXrw4l2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB57D1F5F7
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394631; cv=none; b=XTTAXsAPdLUjM5KXapO5dTtHVgjOxInpUvSWHt5M/mud7adQ1DxPXTdRmjGhZ0V273d6zjfFtG+0yaYNEmcm8Krs7eBr9ANp3YKxOUDwzlYqiwDPlYRp4WNVzsJ/L8Owh1TF0qWPV+7Gc8msGdfLIXebjbqu5nCxZksy9RY+HCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394631; c=relaxed/simple;
	bh=LUPxPVDNa8jF1chmqGQKtc3ksiXyy7WTSoaLztGYlVA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NcB+Mh43qE+o9zXcFlt/QKdAdULftYG4xj9ho8WN4Ij2SKs59BDwxG/ExeLkBGQ8cCTmwL564Vfey4XLyEcxYWFWliM0yvGdE2gwlF4CyO+Euj2qfeEgB2WpGUVqGudSTgxY5P/yqWG9aOcbi1M2EDgjN+kU8o1HzBymNYaK14k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lEXrw4l2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98370C433C7;
	Sat, 27 Jan 2024 22:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706394631;
	bh=LUPxPVDNa8jF1chmqGQKtc3ksiXyy7WTSoaLztGYlVA=;
	h=Subject:To:Cc:From:Date:From;
	b=lEXrw4l2z27jXPqF0fqOrXDHXHQkBuWVKtZ7AR/Vb/DfAyHMoXj/sbhO4pZozAZys
	 WvFTLcetfPZZDEK3THkr/DkN11idJ4h1Nt/cHYSPTL1/iUmxdeZ59CqBbSF5nqQIY8
	 RxQMYjDTy+Z85ijTc+kZhPKPaA+uRYJPc4ogcbAE=
Subject: FAILED: patch "[PATCH] drm/i915/psr: Only allow PSR in LPSP mode on HSW non-ULT" failed to apply to 6.6-stable tree
To: ville.syrjala@linux.intel.com,joonas.lahtinen@linux.intel.com,jouni.hogander@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 14:30:30 -0800
Message-ID: <2024012730-encroach-lid-4960@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f9f031dd21a7ce13a13862fa5281d32e1029c70f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012730-encroach-lid-4960@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

f9f031dd21a7 ("drm/i915/psr: Only allow PSR in LPSP mode on HSW non-ULT")
a2cd15c24116 ("drm/i915/lnl: Remove watchdog timers for PSR")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f9f031dd21a7ce13a13862fa5281d32e1029c70f Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Thu, 18 Jan 2024 23:21:31 +0200
Subject: [PATCH] drm/i915/psr: Only allow PSR in LPSP mode on HSW non-ULT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On HSW non-ULT (or at least on Dell Latitude E6540) external displays
start to flicker when we enable PSR on the eDP. We observe a much higher
SR and PC6 residency than should be possible with an external display,
and indeen much higher than what we observe with eDP disabled and
only the external display enabled. Looks like the hardware is somehow
ignoring the fact that the external display is active during PSR.

I wasn't able to redproduce this on my HSW ULT machine, or BDW.
So either there's something specific about this particular laptop
(eg. some unknown firmware thing) or the issue is limited to just
non-ULT HSW systems. All known registers that could affect this
look perfectly reasonable on the affected machine.

As a workaround let's unmask the LPSP event to prevent PSR entry
except while in LPSP mode (only pipe A + eDP active). This
will prevent PSR entry entirely when multiple pipes are active.
The one slight downside is that we now also prevent PSR entry
when driving eDP with pipe B or C, but I think that's a reasonable
tradeoff to avoid having to implement a more complex workaround.

Cc: stable@vger.kernel.org
Fixes: 783d8b80871f ("drm/i915/psr: Re-enable PSR1 on hsw/bdw")
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10092
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240118212131.31868-1-ville.syrjala@linux.intel.com
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
(cherry picked from commit 94501c3ca6400e463ff6cc0c9cf4a2feb6a9205d)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 8f702c3fc62d..57bbf3e3af92 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1525,8 +1525,18 @@ static void intel_psr_enable_source(struct intel_dp *intel_dp,
 	 * can rely on frontbuffer tracking.
 	 */
 	mask = EDP_PSR_DEBUG_MASK_MEMUP |
-	       EDP_PSR_DEBUG_MASK_HPD |
-	       EDP_PSR_DEBUG_MASK_LPSP;
+	       EDP_PSR_DEBUG_MASK_HPD;
+
+	/*
+	 * For some unknown reason on HSW non-ULT (or at least on
+	 * Dell Latitude E6540) external displays start to flicker
+	 * when PSR is enabled on the eDP. SR/PC6 residency is much
+	 * higher than should be possible with an external display.
+	 * As a workaround leave LPSP unmasked to prevent PSR entry
+	 * when external displays are active.
+	 */
+	if (DISPLAY_VER(dev_priv) >= 8 || IS_HASWELL_ULT(dev_priv))
+		mask |= EDP_PSR_DEBUG_MASK_LPSP;
 
 	if (DISPLAY_VER(dev_priv) < 20)
 		mask |= EDP_PSR_DEBUG_MASK_MAX_SLEEP;


