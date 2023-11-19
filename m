Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BA07F057F
	for <lists+stable@lfdr.de>; Sun, 19 Nov 2023 11:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjKSK51 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 19 Nov 2023 05:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjKSK50 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 19 Nov 2023 05:57:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6673E192
        for <stable@vger.kernel.org>; Sun, 19 Nov 2023 02:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700391441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wduLhA1JfH2JIibNOg1UP/hJXljazR5AfhyG/qLMjyE=;
        b=R/m4g8Q6Ky1f49aAV1MFbRQGJKisurwHi9YDCzQJk0MI8OjF/72L5KFOZ0p75LBKcvWra2
        mge3A/V6wWF4VFnhnMVOZTmRrthOPVMsqsL9HfwtoXgIQOKbf3maoNOIUFj98Rl3P1jicf
        hGj3dLVuJxc6xrOWQNUU/qDbKQGIK4w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-eViIJoqvPYC_NkrWtMaa7w-1; Sun, 19 Nov 2023 05:57:19 -0500
X-MC-Unique: eViIJoqvPYC_NkrWtMaa7w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40a5290de84so6525695e9.0
        for <stable@vger.kernel.org>; Sun, 19 Nov 2023 02:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700391438; x=1700996238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wduLhA1JfH2JIibNOg1UP/hJXljazR5AfhyG/qLMjyE=;
        b=ssS6p0BzHbCy5vI216sTpXhXgiFhhc611FASkhIKSL2HyJkVWYAtJVrb+2Vncrs+VI
         eLxYqOU/shoinUQQ0FihmNrxC/Yq74zYkgyxI8NGe21lPM/FXwTk+D0VtpMTdbY8VsfS
         9IRgbQUZbaJclYN099i0IDijvrpHC7ZufjOHLcZNgCLimo1fVdTep+bP2gBQsqTtOg04
         89BLXmDe2aTqankMRH8Q0OQ0BAkRWWnBCwVUHTZhYKrzZCdlP1pFWNdcw/RW7hfdq0Qn
         6rWmywdPSPDKCMnqJpdQ65LVQIuV41fyyPzC7rlYz5uQ4d35ubMnBnyyePjY8zbcL9xH
         m5FQ==
X-Gm-Message-State: AOJu0Yxm7t+sVrnEGfdzvF4KAdcbaggHNCOMEugZM2YY79qcwKuZttIB
        squtFrKyvLtz2RsH7ywvH9+ZvN9gKSeUHLRs3Ed66sJFz/aFKmSCHtrzxOUM1iHwWvUqAsBIEch
        RJ6gP53kellSz50f9
X-Received: by 2002:a05:600c:5254:b0:408:40e2:773b with SMTP id fc20-20020a05600c525400b0040840e2773bmr3874929wmb.34.1700391438606;
        Sun, 19 Nov 2023 02:57:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlYVHBUM49anhifPkjs7hxrNsnEGArla3y2Mra38iXhi+oYySY1k50/IKpNWu+heDGdF252Q==
X-Received: by 2002:a05:600c:5254:b0:408:40e2:773b with SMTP id fc20-20020a05600c525400b0040840e2773bmr3874914wmb.34.1700391438309;
        Sun, 19 Nov 2023 02:57:18 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b004094e565e71sm9510932wmo.23.2023.11.19.02.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 02:57:17 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Erico Nunes <nunes.erico@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        stable@vger.kernel.org,
        nerdopolis <bluescreen_avenger@verizon.net>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: [PATCH v3 2/5] drm/virtio: Disable damage clipping if FB changed since last page-flip
Date:   Sun, 19 Nov 2023 11:56:58 +0100
Message-ID: <20231119105709.3143489-3-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231119105709.3143489-1-javierm@redhat.com>
References: <20231119105709.3143489-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The driver does per-buffer uploads and needs to force a full plane update
if the plane's attached framebuffer has change since the last page-flip.

Fixes: 01f05940a9a7 ("drm/virtio: Enable fb damage clips property for the primary plane")
Cc: <stable@vger.kernel.org> # v6.4+
Reported-by: nerdopolis <bluescreen_avenger@verizon.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218115
Suggested-by: Sima Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v2)

Changes in v2:
- Set struct drm_plane_state .ignore_damage_clips in virtio-gpu plane's
  .atomic_check instead of using a different helpers (Thomas Zimmermann).

 drivers/gpu/drm/virtio/virtgpu_plane.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a2e045f3a000..a1ef657eba07 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -79,6 +79,8 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
 										 plane);
+	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state,
+										 plane);
 	bool is_cursor = plane->type == DRM_PLANE_TYPE_CURSOR;
 	struct drm_crtc_state *crtc_state;
 	int ret;
@@ -86,6 +88,14 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
 	if (!new_plane_state->fb || WARN_ON(!new_plane_state->crtc))
 		return 0;
 
+	/*
+	 * Ignore damage clips if the framebuffer attached to the plane's state
+	 * has changed since the last plane update (page-flip). In this case, a
+	 * full plane update should happen because uploads are done per-buffer.
+	 */
+	if (old_plane_state->fb != new_plane_state->fb)
+		new_plane_state->ignore_damage_clips = true;
+
 	crtc_state = drm_atomic_get_crtc_state(state,
 					       new_plane_state->crtc);
 	if (IS_ERR(crtc_state))
-- 
2.41.0

