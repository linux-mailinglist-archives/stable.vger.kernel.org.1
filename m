Return-Path: <stable+bounces-192118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76976C29BED
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 01:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEA844ED9C7
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 00:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790341DF987;
	Mon,  3 Nov 2025 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fmo5yhst"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2561DB54C
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762131020; cv=none; b=dTftJSNu5GrzfYpkfiRVHf+oJ7iPxkD6mcdDgewQfvInQ7Ii3qOuCv4o+gWX6DfMQzKy2TSnkxeDFEx+iLGWL8fvpNPYX8KYAFH3bgCBAn0g50MWQ31r9IJfvukNfwAimgLz4M4DqKJ9twcTtSkUHiIQZYpy6kaXuUmiPuSCUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762131020; c=relaxed/simple;
	bh=51D+u2AtDz8CfOYBxJ9tf+OJttcfvfUXkKh4sHEKbdE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ez3no2ROLHGDinQemzIHeD+4Bu9/YuwpeuFa6BRaOkxDC5DXCc2fCUBvrMtE0vlPiKROKAqTS/apAIztDI6BX6EJI+90H/62agAgKNRlR8en9ImGOcljEXKEdRaHHpMXn/0BdGLU+qARuowDyjxVwhlBSFSmPrcT/4T2OJkJYcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fmo5yhst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55979C4CEF7;
	Mon,  3 Nov 2025 00:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762131019;
	bh=51D+u2AtDz8CfOYBxJ9tf+OJttcfvfUXkKh4sHEKbdE=;
	h=Subject:To:Cc:From:Date:From;
	b=Fmo5yhstdJMT9KX+4C024uL2bYShWF6BN99ZQgk9y8RBHDS29prpfQEJ7H41Gugyo
	 jsK9x1Ue6LFRo9OSaZiXUmWTbgF8XkBBVVl0ir/CMNd+V/yND//GyBXdn9rL5LQoq8
	 H+aJhKsX/XihYVlCkKoV48LQ07+4gxGzLGtlhMEY=
Subject: FAILED: patch "[PATCH] drm/sysfb: Do not dereference NULL pointer in plane reset" failed to apply to 5.15-stable tree
To: tzimmermann@suse.de,airlied@gmail.com,dan.carpenter@linaro.org,javierm@redhat.com,maarten.lankhorst@linux.intel.com,melissa.srw@gmail.com,mripard@kernel.org,simona@ffwll.ch,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Nov 2025 09:50:14 +0900
Message-ID: <2025110314-plank-canned-8743@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 14e02ed3876f4ab0ed6d3f41972175f8b8df3d70
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110314-plank-canned-8743@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 


