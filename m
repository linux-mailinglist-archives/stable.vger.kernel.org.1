Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADB97E7022
	for <lists+stable@lfdr.de>; Thu,  9 Nov 2023 18:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344547AbjKIR0B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 12:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344552AbjKIR0A (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 12:26:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD19B3263
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 09:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699550713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DyicNWwvae7/KcxXuwMP09NutaVYwbuAqWEUxMoKBKk=;
        b=QDVyWOw/W6wRlaBdHmdcmUPEjG7LojXpIj2xapR2qW6svpfGLuOx25LEF02ftFC9VdfyhP
        M76BXmxauNl5jbXf7AXyM9iagcwNWqEMyBDxuOTaMnTKF9Vq/ob7efcjAJrhqyQF/rKls+
        xCsDqUUEf/ABV1J+vRXwTaezFrZdVew=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-7bvse_WNMOiw09l0qbbxAg-1; Thu, 09 Nov 2023 12:25:11 -0500
X-MC-Unique: 7bvse_WNMOiw09l0qbbxAg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4083a670d25so7355415e9.0
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 09:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550710; x=1700155510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyicNWwvae7/KcxXuwMP09NutaVYwbuAqWEUxMoKBKk=;
        b=JgRRyVk0bYR8DN3QtEafHGDWSMREPZq0j0v3nB/pyW0YSJVTYhQSwjIdwrWC7eIdt8
         w4IJL+3HUKOFG4Y9KnTad2JRSR6iGciyfewFlBifo9vNqMwZlt4aWFxKgJCIWJ/oyi5H
         8LUDGBwemMofTgMFzzJFPHsBDX6PoP8AhMYoRkpZIdQSzOg9DKuJdFgNX0qeXeop5G/+
         Dl1d9NWexwXPkrcfpdMSYYtqJ0TZBuSXdW3OJtwFz6vK/BV63zBqBflpub02OTiwr2ia
         GbHPouv0TO7j+o/LCH5RYVipV37G/sLHGo64cnq1zD4DoSJsSLWqresx2MyZFg9sFMDs
         PoFQ==
X-Gm-Message-State: AOJu0YzrabYMNHPNoK2rrCZRg9k8wdrkB3sd3hrTVEcFx+tYItK8AXlf
        wX74QIAUuvrgDOvKBae69ioT6/jeVCU1jQNXzfBDC7GlNaOaYEp+p7Qv9dH8BxCqPxZfPT55Kyi
        QaTGSTYpSUOMUtuXF
X-Received: by 2002:a05:600c:4f03:b0:3fe:687a:abb8 with SMTP id l3-20020a05600c4f0300b003fe687aabb8mr4840946wmq.7.1699550710498;
        Thu, 09 Nov 2023 09:25:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyv55FyLGeotT59GTBCN3nwc/tDWDit/kRjBLJAT9nbsysM1eR/y8bcel6P26gupJ3OsvuqQ==
X-Received: by 2002:a05:600c:4f03:b0:3fe:687a:abb8 with SMTP id l3-20020a05600c4f0300b003fe687aabb8mr4840926wmq.7.1699550710072;
        Thu, 09 Nov 2023 09:25:10 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600c4e0b00b004054dcbf92asm2767377wmq.20.2023.11.09.09.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:25:09 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Simon Ser <contact@emersion.fr>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Maxime Ripard <mripard@kernel.org>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Erico Nunes <nunes.erico@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        stable@vger.kernel.org,
        nerdopolis <bluescreen_avenger@verizon.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/6] drm: Add drm_atomic_helper_buffer_damage_{iter_init,merged}() helpers
Date:   Thu,  9 Nov 2023 18:24:36 +0100
Message-ID: <20231109172449.1599262-3-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109172449.1599262-1-javierm@redhat.com>
References: <20231109172449.1599262-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

To be used by drivers that do per-buffer (e.g: virtio-gpu) uploads (rather
than per-plane uploads), since these type of drivers need to handle buffer
damages instead of frame damages.

The drm_atomic_helper_buffer_damage_iter_init() has the same logic than
drm_atomic_helper_damage_iter_init() but it also takes into account if the
framebuffer attached to plane's state has changed since the last update.

And the drm_atomic_helper_buffer_damage_merged() is just a version of the
drm_atomic_helper_damage_merged() helper, but it uses the iter_init helper
that is mentioned above.

Fixes: 01f05940a9a7 ("drm/virtio: Enable fb damage clips property for the primary plane")
Cc: <stable@vger.kernel.org> # v6.4+
Reported-by: nerdopolis <bluescreen_avenger@verizon.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218115
Suggested-by: Sima Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/drm_damage_helper.c | 79 ++++++++++++++++++++++++++---
 include/drm/drm_damage_helper.h     |  7 +++
 2 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
index aa2325567918..b72062c9d31c 100644
--- a/drivers/gpu/drm/drm_damage_helper.c
+++ b/drivers/gpu/drm/drm_damage_helper.c
@@ -204,7 +204,8 @@ EXPORT_SYMBOL(drm_atomic_helper_dirtyfb);
 static void
 __drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
 				     const struct drm_plane_state *old_state,
-				     const struct drm_plane_state *state)
+				     const struct drm_plane_state *state,
+				     bool buffer_damage)
 {
 	struct drm_rect src;
 	memset(iter, 0, sizeof(*iter));
@@ -223,7 +224,8 @@ __drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
 	iter->plane_src.x2 = (src.x2 >> 16) + !!(src.x2 & 0xFFFF);
 	iter->plane_src.y2 = (src.y2 >> 16) + !!(src.y2 & 0xFFFF);
 
-	if (!iter->clips || !drm_rect_equals(&state->src, &old_state->src)) {
+	if (!iter->clips || !drm_rect_equals(&state->src, &old_state->src) ||
+	    (buffer_damage && old_state->fb != state->fb)) {
 		iter->clips = NULL;
 		iter->num_clips = 0;
 		iter->full_update = true;
@@ -243,6 +245,10 @@ __drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
  * update). Currently this iterator returns full plane src in case plane src
  * changed but that can be changed in future to return damage.
  *
+ * Note that this helper is for drivers that do per-plane uploads and expect
+ * to handle frame damages. Drivers that do per-buffer uploads instead should
+ * use @drm_atomic_helper_buffer_damage_iter_init() that handles buffer damages.
+ *
  * For the case when plane is not visible or plane update should not happen the
  * first call to iter_next will return false. Note that this helper use clipped
  * &drm_plane_state.src, so driver calling this helper should have called
@@ -253,10 +259,37 @@ drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
 				   const struct drm_plane_state *old_state,
 				   const struct drm_plane_state *state)
 {
-	__drm_atomic_helper_damage_iter_init(iter, old_state, state);
+	__drm_atomic_helper_damage_iter_init(iter, old_state, state, false);
 }
 EXPORT_SYMBOL(drm_atomic_helper_damage_iter_init);
 
+/**
+ * drm_atomic_helper_buffer_damage_iter_init - Initialize the buffer damage iterator.
+ * @iter: The iterator to initialize.
+ * @old_state: Old plane state for validation.
+ * @state: Plane state from which to iterate the damage clips.
+ *
+ * Initialize an iterator, which clips buffer damage
+ * &drm_plane_state.fb_damage_clips to plane &drm_plane_state.src. This iterator
+ * returns full plane src in case buffer damage is not present because user-space
+ * didn't sent, driver discarded it (it want to do full plane update) or the plane
+ * @state has an attached framebuffer that is different than the one in @state (it
+ * has changed since the last plane update).
+ *
+ * For the case when plane is not visible or plane update should not happen the
+ * first call to iter_next will return false. Note that this helper use clipped
+ * &drm_plane_state.src, so driver calling this helper should have called
+ * drm_atomic_helper_check_plane_state() earlier.
+ */
+void
+drm_atomic_helper_buffer_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
+					  const struct drm_plane_state *old_state,
+					  const struct drm_plane_state *state)
+{
+	__drm_atomic_helper_damage_iter_init(iter, old_state, state, true);
+}
+EXPORT_SYMBOL(drm_atomic_helper_buffer_damage_iter_init);
+
 /**
  * drm_atomic_helper_damage_iter_next - Advance the damage iterator.
  * @iter: The iterator to advance.
@@ -301,7 +334,8 @@ EXPORT_SYMBOL(drm_atomic_helper_damage_iter_next);
 
 static bool __drm_atomic_helper_damage_merged(const struct drm_plane_state *old_state,
 					      struct drm_plane_state *state,
-					      struct drm_rect *rect)
+					      struct drm_rect *rect,
+					      bool buffer_damage)
 {
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect clip;
@@ -312,7 +346,7 @@ static bool __drm_atomic_helper_damage_merged(const struct drm_plane_state *old_
 	rect->x2 = 0;
 	rect->y2 = 0;
 
-	drm_atomic_helper_damage_iter_init(&iter, old_state, state);
+	__drm_atomic_helper_damage_iter_init(&iter, old_state, state, buffer_damage);
 	drm_atomic_for_each_plane_damage(&iter, &clip) {
 		rect->x1 = min(rect->x1, clip.x1);
 		rect->y1 = min(rect->y1, clip.y1);
@@ -336,6 +370,10 @@ static bool __drm_atomic_helper_damage_merged(const struct drm_plane_state *old_
  * For details see: drm_atomic_helper_damage_iter_init() and
  * drm_atomic_helper_damage_iter_next().
  *
+ * Note that this helper is for drivers that do per-plane uploads and expect
+ * to handle frame damages. Drivers that do per-buffer uploads instead should
+ * use @drm_atomic_helper_buffer_damage_merged() that handles buffer damages.
+ *
  * Returns:
  * True if there is valid plane damage otherwise false.
  */
@@ -343,6 +381,35 @@ bool drm_atomic_helper_damage_merged(const struct drm_plane_state *old_state,
 				     struct drm_plane_state *state,
 				     struct drm_rect *rect)
 {
-	return __drm_atomic_helper_damage_merged(old_state, state, rect);
+	return __drm_atomic_helper_damage_merged(old_state, state, rect, false);
 }
 EXPORT_SYMBOL(drm_atomic_helper_damage_merged);
+
+/**
+ * drm_atomic_helper_buffer_damage_merged - Merged buffer damage
+ * @old_state: Old plane state for validation.
+ * @state: Plane state from which to iterate the damage clips.
+ * @rect: Returns the merged buffer damage rectangle
+ *
+ * This function merges any valid buffer damage clips into one rectangle and
+ * returns it in @rect. It checks if the framebuffers attached to @old_state
+ * and @state are the same. If that is not the case then the returned damage
+ * rectangle is the &drm_plane_state.src, since a full update should happen.
+ *
+ * Note that &drm_plane_state.fb_damage_clips == NULL in plane state means that
+ * full plane update should happen. It also ensure helper iterator will return
+ * &drm_plane_state.src as damage.
+ *
+ * For details see: drm_atomic_helper_buffer_damage_iter_init() and
+ * drm_atomic_helper_damage_iter_next().
+ *
+ * Returns:
+ * True if there is valid buffer damage otherwise false.
+ */
+bool drm_atomic_helper_buffer_damage_merged(const struct drm_plane_state *old_state,
+					    struct drm_plane_state *state,
+					    struct drm_rect *rect)
+{
+	return __drm_atomic_helper_damage_merged(old_state, state, rect, true);
+}
+EXPORT_SYMBOL(drm_atomic_helper_buffer_damage_merged);
diff --git a/include/drm/drm_damage_helper.h b/include/drm/drm_damage_helper.h
index effda42cce31..328bb249d68f 100644
--- a/include/drm/drm_damage_helper.h
+++ b/include/drm/drm_damage_helper.h
@@ -74,11 +74,18 @@ void
 drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
 				   const struct drm_plane_state *old_state,
 				   const struct drm_plane_state *new_state);
+void
+drm_atomic_helper_buffer_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
+					  const struct drm_plane_state *old_state,
+					  const struct drm_plane_state *new_state);
 bool
 drm_atomic_helper_damage_iter_next(struct drm_atomic_helper_damage_iter *iter,
 				   struct drm_rect *rect);
 bool drm_atomic_helper_damage_merged(const struct drm_plane_state *old_state,
 				     struct drm_plane_state *state,
 				     struct drm_rect *rect);
+bool drm_atomic_helper_buffer_damage_merged(const struct drm_plane_state *old_state,
+					    struct drm_plane_state *state,
+					    struct drm_rect *rect);
 
 #endif
-- 
2.41.0

