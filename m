Return-Path: <stable+bounces-192117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2024AC29BDB
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 01:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3577618918AA
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 00:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FAA1DE8BE;
	Mon,  3 Nov 2025 00:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qpOyy5dZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC071DE4DC
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 00:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762131017; cv=none; b=b3DuMO0JCK94otVPnh2Dn5XPRKtQ2LrL209h6ZFmnwxeZmmZ3f5BN31Ekk2vSKAHTfsOwQJokgl/sTXFjX2JqKUkpiiQ63OLwJt8jnQ8EKhPLo/kaktC19LoFwhaSiGuupA5djJiNzxeKntA7lEbdx5KTtGiIWCQlVMA+hKj8sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762131017; c=relaxed/simple;
	bh=h8fbB85npEShN6wrCZLL7EvtEtYmPI5RK2rjY3MOvJ8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Kxn76hLs/fkIGcNjyxDirmSonm4DgJpnTnpXgh59QBP43plFtMKCgcip3tT+WpQfRS4Wz8f4CKjzoQf2TwC5eZVZPgvaPxs8s6txgL3hkcEE/bGAbwSyTW29igQsYoHzyF1nwXTWwivR2vdW+VCuVGAbxK5wik8eWhCoTYgW2u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qpOyy5dZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040E7C4CEF7;
	Mon,  3 Nov 2025 00:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762131017;
	bh=h8fbB85npEShN6wrCZLL7EvtEtYmPI5RK2rjY3MOvJ8=;
	h=Subject:To:Cc:From:Date:From;
	b=qpOyy5dZKx9NQssqv9WO9E+xC1g9+0WSQhdZ0wGmyKyu3ECLy2YoabCUCxmwkl/8h
	 7WYLN/2dPMTFf02gfGMyevSXHtv/UAGJ+Y6L1NqZ4iPGHB43RZMvfmG7TzLfzs1S3S
	 ZP3t/MH74qbV8HqAhwVNMgzsHf+ihdHlOLa2gLEc=
Subject: FAILED: patch "[PATCH] drm/sysfb: Do not dereference NULL pointer in plane reset" failed to apply to 6.1-stable tree
To: tzimmermann@suse.de,airlied@gmail.com,dan.carpenter@linaro.org,javierm@redhat.com,maarten.lankhorst@linux.intel.com,melissa.srw@gmail.com,mripard@kernel.org,simona@ffwll.ch,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Nov 2025 09:50:12 +0900
Message-ID: <2025110312-duration-shape-5d38@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 14e02ed3876f4ab0ed6d3f41972175f8b8df3d70
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110312-duration-shape-5d38@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 14e02ed3876f4ab0ed6d3f41972175f8b8df3d70 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 17 Oct 2025 11:13:36 +0200
Subject: [PATCH] drm/sysfb: Do not dereference NULL pointer in plane reset

The plane state in __drm_gem_reset_shadow_plane() can be NULL. Do not
deref that pointer, but forward NULL to the other plane-reset helpers.
Clears plane->state to NULL.

v2:
- fix typo in commit description (Javier)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: b71565022031 ("drm/gem: Export implementation of shadow-plane helpers")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/dri-devel/aPIDAsHIUHp_qSW4@stanley.mountain/
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Melissa Wen <melissa.srw@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.15+
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patch.msgid.link/20251017091407.58488-1-tzimmermann@suse.de

diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index ebf305fb24f0..6fb55601252f 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -310,8 +310,12 @@ EXPORT_SYMBOL(drm_gem_destroy_shadow_plane_state);
 void __drm_gem_reset_shadow_plane(struct drm_plane *plane,
 				  struct drm_shadow_plane_state *shadow_plane_state)
 {
-	__drm_atomic_helper_plane_reset(plane, &shadow_plane_state->base);
-	drm_format_conv_state_init(&shadow_plane_state->fmtcnv_state);
+	if (shadow_plane_state) {
+		__drm_atomic_helper_plane_reset(plane, &shadow_plane_state->base);
+		drm_format_conv_state_init(&shadow_plane_state->fmtcnv_state);
+	} else {
+		__drm_atomic_helper_plane_reset(plane, NULL);
+	}
 }
 EXPORT_SYMBOL(__drm_gem_reset_shadow_plane);
 


