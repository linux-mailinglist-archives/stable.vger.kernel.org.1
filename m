Return-Path: <stable+bounces-33828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CB5892A46
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 11:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C901F22280
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A05200DA;
	Sat, 30 Mar 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VoZnFf44"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35340200C8
	for <stable@vger.kernel.org>; Sat, 30 Mar 2024 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711793012; cv=none; b=pZBYEm+o6l6c1jZZ8XhqaSJ1oKWM580NhTpYVyBdwoEpSekM5QiSBGpNEvULTEm6QmT34kXsWEfOgRxrHKUr7LSmxGZ6SXPlFxeEzmU6NQ0hP9wjtbm0B8qav6HmVglFp4uQefSUeuT7+TNX0pBEAwM0EMo5Yp9UpI4QJwIkIKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711793012; c=relaxed/simple;
	bh=AF8DEugfFep0r+51+VbkZPkEdIU+k0GH2OAu9SozLcU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uhBtBvDJA30a3HBnnBxqpMTjfEQrHK2G+uAxoa38JZP/38eq2qd8LwHIOhtHh/JyCVAg/iUy9YfugRojFK4pfXnGORpipz/Tmt5NM+HXY0oJgdqZmGHnOuwGzal7vEyLnZmNbDYwPpf03DVa2QNZ2lALvXHIS/IDefrIRe0I6x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VoZnFf44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55794C433F1;
	Sat, 30 Mar 2024 10:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711793011;
	bh=AF8DEugfFep0r+51+VbkZPkEdIU+k0GH2OAu9SozLcU=;
	h=Subject:To:Cc:From:Date:From;
	b=VoZnFf44TXAizN1A/+FChiOY2lF83MDhJNYPQdrXWKKcwPZQH/wGKilDmNSqq7WAl
	 VbYiDD53LwtOQ64usXnXnF6aaX5tzEGSAVHED14YokoglvyLlGE3vUlRcbdk/7ZRkm
	 IX44O5aUSoA+pgMa4AvRnQs7lWAOdHOXd7GUNpDU=
Subject: FAILED: patch "[PATCH] drm/i915: Pre-populate the cursor physical dma address" failed to apply to 6.1-stable tree
To: ville.syrjala@linux.intel.com,bp@alien8.de,chaitanya.kumar.borah@intel.com,rodrigo.vivi@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Mar 2024 11:03:18 +0100
Message-ID: <2024033018-corsage-bacteria-dd67@gregkh>
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
git cherry-pick -x 582dc04b0658ef3b90aeb49cbdd9747c2f1eccc3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024033018-corsage-bacteria-dd67@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 582dc04b0658ef3b90aeb49cbdd9747c2f1eccc3 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Date: Mon, 25 Mar 2024 19:57:38 +0200
Subject: [PATCH] drm/i915: Pre-populate the cursor physical dma address
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Calling i915_gem_object_get_dma_address() from the vblank
evade critical section triggers might_sleep().

While we know that we've already pinned the framebuffer
and thus i915_gem_object_get_dma_address() will in fact
not sleep in this case, it seems reasonable to keep the
unconditional might_sleep() for maximum coverage.

So let's instead pre-populate the dma address during
fb pinning, which all happens before we enter the
vblank evade critical section.

We can use u32 for the dma address as this class of
hardware doesn't support >32bit addresses.

Cc: stable@vger.kernel.org
Fixes: 0225a90981c8 ("drm/i915: Make cursor plane registers unlocked")
Reported-by: Borislav Petkov <bp@alien8.de>
Closes: https://lore.kernel.org/intel-gfx/20240227100342.GAZd2zfmYcPS_SndtO@fat_crate.local/
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240325175738.3440-1-ville.syrjala@linux.intel.com
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
(cherry picked from commit c1289a5c3594cf04caa94ebf0edeb50c62009f1f)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/drm/i915/display/intel_cursor.c
index f8b33999d43f..0d3da55e1c24 100644
--- a/drivers/gpu/drm/i915/display/intel_cursor.c
+++ b/drivers/gpu/drm/i915/display/intel_cursor.c
@@ -36,12 +36,10 @@ static u32 intel_cursor_base(const struct intel_plane_state *plane_state)
 {
 	struct drm_i915_private *dev_priv =
 		to_i915(plane_state->uapi.plane->dev);
-	const struct drm_framebuffer *fb = plane_state->hw.fb;
-	struct drm_i915_gem_object *obj = intel_fb_obj(fb);
 	u32 base;
 
 	if (DISPLAY_INFO(dev_priv)->cursor_needs_physical)
-		base = i915_gem_object_get_dma_address(obj, 0);
+		base = plane_state->phys_dma_addr;
 	else
 		base = intel_plane_ggtt_offset(plane_state);
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index e67cd5b02e84..9104f18753b4 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -727,6 +727,7 @@ struct intel_plane_state {
 #define PLANE_HAS_FENCE BIT(0)
 
 	struct intel_fb_view view;
+	u32 phys_dma_addr; /* for cursor_needs_physical */
 
 	/* Plane pxp decryption state */
 	bool decrypt;
diff --git a/drivers/gpu/drm/i915/display/intel_fb_pin.c b/drivers/gpu/drm/i915/display/intel_fb_pin.c
index 7b42aef37d2f..b6df9baf481b 100644
--- a/drivers/gpu/drm/i915/display/intel_fb_pin.c
+++ b/drivers/gpu/drm/i915/display/intel_fb_pin.c
@@ -255,6 +255,16 @@ int intel_plane_pin_fb(struct intel_plane_state *plane_state)
 			return PTR_ERR(vma);
 
 		plane_state->ggtt_vma = vma;
+
+		/*
+		 * Pre-populate the dma address before we enter the vblank
+		 * evade critical section as i915_gem_object_get_dma_address()
+		 * will trigger might_sleep() even if it won't actually sleep,
+		 * which is the case when the fb has already been pinned.
+		 */
+		if (phys_cursor)
+			plane_state->phys_dma_addr =
+				i915_gem_object_get_dma_address(intel_fb_obj(fb), 0);
 	} else {
 		struct intel_framebuffer *intel_fb = to_intel_framebuffer(fb);
 


