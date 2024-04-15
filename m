Return-Path: <stable+bounces-39484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554BF8A51A5
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09AE1F25889
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0C678C88;
	Mon, 15 Apr 2024 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dDvTVMRs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7F78C85
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187882; cv=none; b=KZW248MkNRUmJKYNTNJC+O49AjpahzlmcAIFfi4Xw7G7qCWzEkavU+adx56i1FEhCtS2F/Oidr1CZwZ58wEGqkPTYLfiEmnOS7jWh8JqAlKMNPKA4fDh+X+SwDfY9psi1I0pcIxQEgy6nf1ZBCEir8qRsWZp2+gO4GTt0H9e9xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187882; c=relaxed/simple;
	bh=xWn617OPNFDqcTZg9XzCzgzj/mmvFxslTsvVVcJ29nU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KlDoDVVv0wDYY4Qrfm/VMHroNsNpEE3pDdDPPCFdFWDCcHTctnm1EY5bprsAvyXwnUcRXmDUNZBPU17LCABkpYm+vJxbMIAI9TntB2xTrN1M/FFLthKVuzwS4qtuAmJqI/hmu3MfQnIgyAbhsigW12JG2EYk4JoErHKrgw8nikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dDvTVMRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B551C113CC;
	Mon, 15 Apr 2024 13:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713187882;
	bh=xWn617OPNFDqcTZg9XzCzgzj/mmvFxslTsvVVcJ29nU=;
	h=Subject:To:Cc:From:Date:From;
	b=dDvTVMRsAMrH4ChxzANzi7EBkXV/0XshY5Wi9em0xjY6vki65g45rEB8TrAOqilaM
	 VwN+QPFLklQ1lZ5bCKX6ctz/72qcksXcS/oUJB5rvAK+jTbIbvSbjYKFl96eyBRaS4
	 bKz8Vskcout88B37BbuchFpBQLrX6yIPLWHGr2wI=
Subject: FAILED: patch "[PATCH] drm/i915/cdclk: Fix voltage_level programming edge case" failed to apply to 6.6-stable tree
To: ville.syrjala@linux.intel.com,gustavo.sousa@intel.com,rodrigo.vivi@intel.com,uma.shankar@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Apr 2024 15:31:17 +0200
Message-ID: <2024041516-stack-prevail-2b51@gregkh>
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
git cherry-pick -x 6154cc9177ccea00c89ce0bf93352e474b819ff2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041516-stack-prevail-2b51@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6154cc9177ccea00c89ce0bf93352e474b819ff2 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Tue, 2 Apr 2024 18:50:04 +0300
Subject: [PATCH] drm/i915/cdclk: Fix voltage_level programming edge case
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently we only consider the relationship of the
old and new CDCLK frequencies when determining whether
to do the repgramming from intel_set_cdclk_pre_plane_update()
or intel_set_cdclk_post_plane_update().

It is technically possible to have a situation where the
CDCLK frequency is decreasing, but the voltage_level is
increasing due a DDI port. In this case we should bump
the voltage level already in intel_set_cdclk_pre_plane_update()
(so that the voltage_level will have been increased by the
time the port gets enabled), while leaving the CDCLK frequency
unchanged (as active planes/etc. may still depend on it).
We can then reduce the CDCLK frequency to its final value
from intel_set_cdclk_post_plane_update().

In order to handle that correctly we shall construct a
suitable amalgam of the old and new cdclk states in
intel_set_cdclk_pre_plane_update().

And we can simply call intel_set_cdclk() unconditionally
in both places as it will not do anything if nothing actually
changes vs. the current hw state.

v2: Handle cdclk_state->disable_pipes
v3: Only synchronize the cd2x update against the pipe's vblank
    when the cdclk frequency is changing during the current
    commit phase (Gustavo)

Cc: stable@vger.kernel.org
Cc: Gustavo Sousa <gustavo.sousa@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240402155016.13733-3-ville.syrjala@linux.intel.com
(cherry picked from commit 34d127e2bdef73a923aa0dcd95cbc3257ad5af52)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
index 4833479e2e17..f672bfd70d45 100644
--- a/drivers/gpu/drm/i915/display/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
@@ -2534,7 +2534,8 @@ intel_set_cdclk_pre_plane_update(struct intel_atomic_state *state)
 		intel_atomic_get_old_cdclk_state(state);
 	const struct intel_cdclk_state *new_cdclk_state =
 		intel_atomic_get_new_cdclk_state(state);
-	enum pipe pipe = new_cdclk_state->pipe;
+	struct intel_cdclk_config cdclk_config;
+	enum pipe pipe;
 
 	if (!intel_cdclk_changed(&old_cdclk_state->actual,
 				 &new_cdclk_state->actual))
@@ -2543,12 +2544,25 @@ intel_set_cdclk_pre_plane_update(struct intel_atomic_state *state)
 	if (IS_DG2(i915))
 		intel_cdclk_pcode_pre_notify(state);
 
-	if (new_cdclk_state->disable_pipes ||
-	    old_cdclk_state->actual.cdclk <= new_cdclk_state->actual.cdclk) {
-		drm_WARN_ON(&i915->drm, !new_cdclk_state->base.changed);
+	if (new_cdclk_state->disable_pipes) {
+		cdclk_config = new_cdclk_state->actual;
+		pipe = INVALID_PIPE;
+	} else {
+		if (new_cdclk_state->actual.cdclk >= old_cdclk_state->actual.cdclk) {
+			cdclk_config = new_cdclk_state->actual;
+			pipe = new_cdclk_state->pipe;
+		} else {
+			cdclk_config = old_cdclk_state->actual;
+			pipe = INVALID_PIPE;
+		}
 
-		intel_set_cdclk(i915, &new_cdclk_state->actual, pipe);
+		cdclk_config.voltage_level = max(new_cdclk_state->actual.voltage_level,
+						 old_cdclk_state->actual.voltage_level);
 	}
+
+	drm_WARN_ON(&i915->drm, !new_cdclk_state->base.changed);
+
+	intel_set_cdclk(i915, &cdclk_config, pipe);
 }
 
 /**
@@ -2566,7 +2580,7 @@ intel_set_cdclk_post_plane_update(struct intel_atomic_state *state)
 		intel_atomic_get_old_cdclk_state(state);
 	const struct intel_cdclk_state *new_cdclk_state =
 		intel_atomic_get_new_cdclk_state(state);
-	enum pipe pipe = new_cdclk_state->pipe;
+	enum pipe pipe;
 
 	if (!intel_cdclk_changed(&old_cdclk_state->actual,
 				 &new_cdclk_state->actual))
@@ -2576,11 +2590,14 @@ intel_set_cdclk_post_plane_update(struct intel_atomic_state *state)
 		intel_cdclk_pcode_post_notify(state);
 
 	if (!new_cdclk_state->disable_pipes &&
-	    old_cdclk_state->actual.cdclk > new_cdclk_state->actual.cdclk) {
-		drm_WARN_ON(&i915->drm, !new_cdclk_state->base.changed);
+	    new_cdclk_state->actual.cdclk < old_cdclk_state->actual.cdclk)
+		pipe = new_cdclk_state->pipe;
+	else
+		pipe = INVALID_PIPE;
 
-		intel_set_cdclk(i915, &new_cdclk_state->actual, pipe);
-	}
+	drm_WARN_ON(&i915->drm, !new_cdclk_state->base.changed);
+
+	intel_set_cdclk(i915, &new_cdclk_state->actual, pipe);
 }
 
 static int intel_pixel_rate_to_cdclk(const struct intel_crtc_state *crtc_state)


