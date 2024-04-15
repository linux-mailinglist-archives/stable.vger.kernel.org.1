Return-Path: <stable+bounces-39488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2788A51A8
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B8DAB244E9
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D8779945;
	Mon, 15 Apr 2024 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KrfJRklA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C710678C8C
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187894; cv=none; b=Emt6vjbPXLNX0gmZ2vgc/O6b/vRReU54Ut6MZYziWMW3ixqzztDPkm+rWUoACzrItm9UhZd2NWsixiqkwgPuawgw/pU1nO3Xwf3N8CF1SATiFverfUgZ3EUUujtBtGzfEoiW3NVPB4s0zymYqlRmhyh/8RudKfr342+x6GGmWkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187894; c=relaxed/simple;
	bh=1kxWW6QPPkNRsVH/XJl8I61VOEzgR6dGdMLEjZHxvkE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p1tc5mdWSWLwQzHIHpv5eIZqATaZfQK+ElAOvnhvuuJ7Sg74zPc9Yut4QuyJn1ZvriV3I3i6kHAQ94se9vPIGBvIILA/qMI4Qzij74PQPiA2Aema62ulo98ff6S4/kE9i9paI+fwPKPJftrfhR8Y7XQ2z1V4qFqwI7XEsC5dVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KrfJRklA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E24C2BD11;
	Mon, 15 Apr 2024 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713187894;
	bh=1kxWW6QPPkNRsVH/XJl8I61VOEzgR6dGdMLEjZHxvkE=;
	h=Subject:To:Cc:From:Date:From;
	b=KrfJRklAiCXcU2H2ZsXq/YcEJDOIKjfEVSBKeXF+/f7Q1mv5EdFGeoK1ZHVu+88Ko
	 SRYjVY0A0QhPfs9WK2MLZF9gR0U6BGE5rrWYuH3oRb8pHVMlniNj7Xz4qyjBm4zQ6i
	 PbNERkUg1aqPar//tpI3e9nBikTEqc4QOnGcmJIM=
Subject: FAILED: patch "[PATCH] drm/i915/cdclk: Fix voltage_level programming edge case" failed to apply to 5.4-stable tree
To: ville.syrjala@linux.intel.com,gustavo.sousa@intel.com,rodrigo.vivi@intel.com,uma.shankar@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Apr 2024 15:31:21 +0200
Message-ID: <2024041521-passport-reiterate-a4ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 6154cc9177ccea00c89ce0bf93352e474b819ff2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041521-passport-reiterate-a4ee@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


