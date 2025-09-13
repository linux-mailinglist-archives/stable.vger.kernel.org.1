Return-Path: <stable+bounces-179468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7553B560CE
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7802A3BB83C
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6672E7BBD;
	Sat, 13 Sep 2025 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NVyeNaRF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9DDDD2
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766418; cv=none; b=gjckRERbpYgr32o2NjmPisVYkeZnpSKWnnLl0tVwhiYIXsYvl3OuD0TW8IkvqOZndzeZ4yX52+weTGMN6UhYR18MkE9NYdVD8IwCBmiqzKsozfVbJTF0L6ul/pnns28jt2HaoS3mQkCOHis4lPhxVj+3H/rwFNPK0CToQo1zlDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766418; c=relaxed/simple;
	bh=d8qR2dMPnKIweV9JwlWLA4bIjogc8r5BlQ2C27Qs6/8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TNLSJwSRxV5EjYUoxNwXSZOqC9KXEJzc/DyiHEg44Pm/LaQD7Q/92emB8wcsc5rva7gjKJPh9enz/Kt+Xe4ob6yxqlgRIj65/kyqVvx6px4bjlB46EzUHNLzpsiFWxHRR1Re5IRvQM0cJ0z9E+VoG+5qNiyWuRTuWS1R/wIwQMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NVyeNaRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25DDC4CEEB;
	Sat, 13 Sep 2025 12:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757766418;
	bh=d8qR2dMPnKIweV9JwlWLA4bIjogc8r5BlQ2C27Qs6/8=;
	h=Subject:To:Cc:From:Date:From;
	b=NVyeNaRFnkVqiQS6XID+SceOlFdOPnrBW7AdGRcEtLC9Nws6JQq0mCnP89Aeh7oXZ
	 n9BgMTXrWjOUawrUrCnGVbgFO1XK34h7AenKHSPxmg234fT+BoYGr3+1TPNKuRW7dR
	 h7hWL+wJ7NdHT67oekocgCBT+qXPv4E6xgODulTA=
Subject: FAILED: patch "[PATCH] drm/i915/power: fix size for for_each_set_bit() in abox" failed to apply to 6.12-stable tree
To: jani.nikula@intel.com,matthew.d.roper@intel.com,tursulin@ursulin.net,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:26:54 +0200
Message-ID: <2025091354-plenty-unlined-c98e@gregkh>
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
git cherry-pick -x cfa7b7659757f8d0fc4914429efa90d0d2577dd7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091354-plenty-unlined-c98e@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cfa7b7659757f8d0fc4914429efa90d0d2577dd7 Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Fri, 5 Sep 2025 13:41:49 +0300
Subject: [PATCH] drm/i915/power: fix size for for_each_set_bit() in abox
 iteration
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

for_each_set_bit() expects size to be in bits, not bytes. The abox mask
iteration uses bytes, but it works by coincidence, because the local
variable holding the mask is unsigned long, and the mask only ever has
bit 2 as the highest bit. Using a smaller type could lead to subtle and
very hard to track bugs.

Fixes: 62afef2811e4 ("drm/i915/rkl: RKL uses ABOX0 for pixel transfers")
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: stable@vger.kernel.org # v5.9+
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://lore.kernel.org/r/20250905104149.1144751-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 7ea3baa6efe4bb93d11e1c0e6528b1468d7debf6)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>

diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
index 273054c22325..c92f3e736228 100644
--- a/drivers/gpu/drm/i915/display/intel_display_power.c
+++ b/drivers/gpu/drm/i915/display/intel_display_power.c
@@ -1172,7 +1172,7 @@ static void icl_mbus_init(struct intel_display *display)
 	if (DISPLAY_VER(display) == 12)
 		abox_regs |= BIT(0);
 
-	for_each_set_bit(i, &abox_regs, sizeof(abox_regs))
+	for_each_set_bit(i, &abox_regs, BITS_PER_TYPE(abox_regs))
 		intel_de_rmw(display, MBUS_ABOX_CTL(i), mask, val);
 }
 
@@ -1629,11 +1629,11 @@ static void tgl_bw_buddy_init(struct intel_display *display)
 	if (table[config].page_mask == 0) {
 		drm_dbg_kms(display->drm,
 			    "Unknown memory configuration; disabling address buddy logic.\n");
-		for_each_set_bit(i, &abox_mask, sizeof(abox_mask))
+		for_each_set_bit(i, &abox_mask, BITS_PER_TYPE(abox_mask))
 			intel_de_write(display, BW_BUDDY_CTL(i),
 				       BW_BUDDY_DISABLE);
 	} else {
-		for_each_set_bit(i, &abox_mask, sizeof(abox_mask)) {
+		for_each_set_bit(i, &abox_mask, BITS_PER_TYPE(abox_mask)) {
 			intel_de_write(display, BW_BUDDY_PAGE_MASK(i),
 				       table[config].page_mask);
 


