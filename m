Return-Path: <stable+bounces-179472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD6EB560D2
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C32A3BEB63
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 12:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99972EC570;
	Sat, 13 Sep 2025 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l2zptytn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995812798F5
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757766435; cv=none; b=O960JbCDpOG74LvUK4JtiEOwxHwxsh6WhU6d9PibHIkHjqZN/njCD92OLGrGwLocNaeH/PD+k/qnKlV9bD56z1JwWaEdY3WAV2+wyHpwKa3ie42EAg8SvRFrWCmUBa/qMnVxtG5YnVdt5YixOjDmbVfff2NVvhciCCYEb1pVOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757766435; c=relaxed/simple;
	bh=l0geLPHnBSN7b1k3yRfkjGtkIbvopYJOYyLaB9btqYI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N95rX8G6Mbn6wf4cgUIa3mAV9OuQS3mGe+vBhlY5CcBpmqRUGMezro0agkQVR8vKcHGWSToGepb5CMpkLqJ8zdbISLUQGRyKVmXFyTDJLVyCABtGkERpD1OuaDhrQJNyvc4tkVDz8y8sbMAUQgya1FTgx2FffHsEhOlQ9buwpXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l2zptytn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DF3C4CEEB;
	Sat, 13 Sep 2025 12:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757766435;
	bh=l0geLPHnBSN7b1k3yRfkjGtkIbvopYJOYyLaB9btqYI=;
	h=Subject:To:Cc:From:Date:From;
	b=l2zptytnTIIEvVQ1N6tptWsavrh798X0iNDZvSdrXxHdpYAJydd/GanQwewt1Ryg/
	 aFNCZt0wAh3Z1mwVmagFAsPVsVxEP7ijeMHm5vZipeOqO0DIr9A/lIfgWjTEmkNGT0
	 61P6CCQKTT2C1Zj20lDskBfpCUQNzTgtyvsNn7os=
Subject: FAILED: patch "[PATCH] drm/i915/power: fix size for for_each_set_bit() in abox" failed to apply to 5.10-stable tree
To: jani.nikula@intel.com,matthew.d.roper@intel.com,tursulin@ursulin.net,ville.syrjala@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 13 Sep 2025 14:26:56 +0200
Message-ID: <2025091356-brownnose-numbing-a046@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x cfa7b7659757f8d0fc4914429efa90d0d2577dd7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091356-brownnose-numbing-a046@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


