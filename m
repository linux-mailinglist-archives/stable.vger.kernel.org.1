Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06E97EC369
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 14:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343899AbjKONQF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 08:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343875AbjKONQD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 08:16:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B721120
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 05:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700054159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8baLtlzsuyZcOKODOHaJ6HAGilgrqHGy9qmPbinQNI=;
        b=dJW0ZBw3CvOtyjgVlMKm0LvmmQPjELpmTE0cLvwL8MK8vKrGqFZYhc4zuC8w1MbQ3bKEu9
        JwiLZAWcdbOLOUr8XmxMmcoUVzGsJnD9czzoi/HCDEY2xHf+zwcsLMOJBDlvK10539biy3
        u/6wmuoJy+F+WSS3Jy/dQUMe15TO0nA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-Px22S3EQMneBAB2Ti3ix0A-1; Wed, 15 Nov 2023 08:15:58 -0500
X-MC-Unique: Px22S3EQMneBAB2Ti3ix0A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3314bd215ceso1455724f8f.2
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 05:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054157; x=1700658957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8baLtlzsuyZcOKODOHaJ6HAGilgrqHGy9qmPbinQNI=;
        b=tEi8oj3BsFmwC4l4tzF2wjay9LUyml4Cysw45WzcN6wBrAlyST0xColzxZKkjz/36t
         KocOhkLDAIIsW2l2xNDY0zZXrbbJmAzxf7N2jbVAUSgY4SkJ8ivx9P9koVqWTz40h29P
         G/YscjspbntkSiIdA/wVPOwV+6/BLY3U6Ol0yG8ulQCULMERfsZbywB+4sbSFrYUz1YZ
         l0AopJ6eSZ+8TXvKpDqdD0BFYP+UKN15gdNFJSlsLbOdY2Y/O49LwxV0y3tuxmbpGeZ8
         VFClaG/3bpj66AsbO1z3VwNahwqILyjeLwZy6AZWToPMBPnlZ1RLxiP19PoVMvHxNj0J
         mlCQ==
X-Gm-Message-State: AOJu0YyoRNks2799R01BFc1u5Fu0auxsy5zeocwTsoEBDXYQ8ppp6pQ2
        sq6aOMaaecOsBSU+X3RM6QX2QJbfFSAZAOboz/YQS6dMnWsrzADIsDU5hjIzLDchcgypuvQgskb
        6bdEIYSXWVIKb+2OQ
X-Received: by 2002:a5d:6d89:0:b0:32f:7b14:89d9 with SMTP id l9-20020a5d6d89000000b0032f7b1489d9mr10958287wrs.9.1700054157041;
        Wed, 15 Nov 2023 05:15:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDaKwJNBk2fEmPyHouSjZgkvyhlK79vrfYZN/upvL8mRJpAtkAcw0QUDFTOK7GVHFogRFeXg==
X-Received: by 2002:a5d:6d89:0:b0:32f:7b14:89d9 with SMTP id l9-20020a5d6d89000000b0032f7b1489d9mr10958258wrs.9.1700054156678;
        Wed, 15 Nov 2023 05:15:56 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h15-20020a5d548f000000b0032fbe5b1e45sm10507123wrv.61.2023.11.15.05.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:15:55 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Bilal Elmoussaoui <belmouss@redhat.com>,
        Simon Ser <contact@emersion.fr>,
        Erico Nunes <nunes.erico@gmail.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sima Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        stable@vger.kernel.org,
        nerdopolis <bluescreen_avenger@verizon.net>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: [PATCH v2 2/5] drm/virtio: Disable damage clipping if FB changed since last page-flip
Date:   Wed, 15 Nov 2023 14:15:41 +0100
Message-ID: <20231115131549.2191589-3-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115131549.2191589-1-javierm@redhat.com>
References: <20231115131549.2191589-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---

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

