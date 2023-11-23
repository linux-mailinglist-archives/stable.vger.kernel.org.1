Return-Path: <stable+bounces-91-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A137F68E3
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 23:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D6EB20DAA
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 22:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E443D1401C;
	Thu, 23 Nov 2023 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ipv1Iy51"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AA210C9
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 14:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700777607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNr7AyogBLBECN5NVEc3sDwHAg2qPYRl5gFzwIza95Q=;
	b=Ipv1Iy5122PEMFm8/8jKSTXKJ6P5hCcAiaugXJWoe+MSDood2Kdu/8+maWPPHq2jDMiWFD
	eRv27xuRmh6fBGeApTczn8ER1j5wW9pqqkDYGMCgk+xjr2IFhD6cD+wBxHMs7DcmpPe6nQ
	Awz32XNyQ2r4o60Fc0WgpqDlma5RQ/I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-ZGq8Yi7fPXe7MF0h9yer-g-1; Thu, 23 Nov 2023 17:13:25 -0500
X-MC-Unique: ZGq8Yi7fPXe7MF0h9yer-g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40b349b990fso6276175e9.3
        for <stable@vger.kernel.org>; Thu, 23 Nov 2023 14:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700777604; x=1701382404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNr7AyogBLBECN5NVEc3sDwHAg2qPYRl5gFzwIza95Q=;
        b=D8NMBXz5TTGAmW0XIPIv67sjJGGJWiS6DGBzbTVJQagpbuGmtwJyfri18vqIr6fQHu
         H5/2TMGeICkzhMvwhlyg51nuyMrRaF9lOOgSF4znSHUZTOY4bzPQlrpxjqM1pUGuaCFG
         H+/o97KCLTZCkxLS5JT/1Er5i797Uf+Gd3LM7I7RGIj/toFUmmxQf0IjQVqYNXJLDKzR
         BD35U3swjypgcerjFAcZVSuTkvb2iblWmMpMTiN/G4wurIo4voWt8InwBQs0HUJis3wE
         5tg9CDShKH2WIGCylWpV0M8QAGSfOC6YPaBQkA5ZLp1hAiL7kkm4TMW2+e8lRIcVwRhf
         1VmQ==
X-Gm-Message-State: AOJu0YwSQvN54nFvEFP/8TbIdke6VO86wgrGj0bgXj7STtt0KDro9a0y
	sC4Zh8Uf27ht0F0v3IL1nd5UjsxMzXwNf7UPsLVIt2YILQFrOV3ZvDhDNTxJwqHxHBuHVhYj3a9
	2U4+BbOFY/LYde88u
X-Received: by 2002:a05:600c:1c9d:b0:408:434c:dae7 with SMTP id k29-20020a05600c1c9d00b00408434cdae7mr695841wms.2.1700777599761;
        Thu, 23 Nov 2023 14:13:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsLgt3C+76rwt6+lTv0sowa6U49h5FFZqfpVdWRCJlUnBufhPrTXVPA1hV/im8nsFEBKfIcQ==
X-Received: by 2002:a05:600c:1c9d:b0:408:434c:dae7 with SMTP id k29-20020a05600c1c9d00b00408434cdae7mr695832wms.2.1700777599346;
        Thu, 23 Nov 2023 14:13:19 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0040b30be6244sm3233457wmq.24.2023.11.23.14.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 14:13:18 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	Zack Rusin <zackr@vmware.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Bilal Elmoussaoui <belmouss@redhat.com>,
	Simon Ser <contact@emersion.fr>,
	Erico Nunes <nunes.erico@gmail.com>,
	Sima Vetter <daniel.vetter@ffwll.ch>,
	Javier Martinez Canillas <javierm@redhat.com>,
	stable@vger.kernel.org,
	nerdopolis <bluescreen_avenger@verizon.net>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v4 1/5] drm: Allow drivers to indicate the damage helpers to ignore damage clips
Date: Thu, 23 Nov 2023 23:13:00 +0100
Message-ID: <20231123221315.3579454-2-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123221315.3579454-1-javierm@redhat.com>
References: <20231123221315.3579454-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It allows drivers to set a struct drm_plane_state .ignore_damage_clips in
their plane's .atomic_check callback, as an indication to damage helpers
such as drm_atomic_helper_damage_iter_init() that the damage clips should
be ignored.

To be used by drivers that do per-buffer (e.g: virtio-gpu) uploads (rather
than per-plane uploads), since these type of drivers need to handle buffer
damages instead of frame damages.

That way, these drivers could force a full plane update if the framebuffer
attached to a plane's state has changed since the last update (page-flip).

Fixes: 01f05940a9a7 ("drm/virtio: Enable fb damage clips property for the primary plane")
Cc: <stable@vger.kernel.org> # v6.4+
Reported-by: nerdopolis <bluescreen_avenger@verizon.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218115
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Zack Rusin <zackr@vmware.com>
Acked-by: Sima Vetter <daniel.vetter@ffwll.ch>
---

Changes in v4:
- Refer in ignore_damage_clips kernel-doc to "Damage Tracking Properties"
  KMS documentation section (Sima Vetter).

Changes in v2:
- Add a struct drm_plane_state .ignore_damage_clips to set in the plane's
  .atomic_check, instead of having different helpers (Thomas Zimmermann).

 Documentation/gpu/drm-kms.rst       |  2 ++
 drivers/gpu/drm/drm_damage_helper.c |  3 ++-
 include/drm/drm_plane.h             | 10 ++++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
index 270d320407c7..a98a7e04e86f 100644
--- a/Documentation/gpu/drm-kms.rst
+++ b/Documentation/gpu/drm-kms.rst
@@ -548,6 +548,8 @@ Plane Composition Properties
 .. kernel-doc:: drivers/gpu/drm/drm_blend.c
    :doc: overview
 
+.. _damage_tracking_properties:
+
 Damage Tracking Properties
 --------------------------
 
diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
index d8b2955e88fd..afb02aae707b 100644
--- a/drivers/gpu/drm/drm_damage_helper.c
+++ b/drivers/gpu/drm/drm_damage_helper.c
@@ -241,7 +241,8 @@ drm_atomic_helper_damage_iter_init(struct drm_atomic_helper_damage_iter *iter,
 	iter->plane_src.x2 = (src.x2 >> 16) + !!(src.x2 & 0xFFFF);
 	iter->plane_src.y2 = (src.y2 >> 16) + !!(src.y2 & 0xFFFF);
 
-	if (!iter->clips || !drm_rect_equals(&state->src, &old_state->src)) {
+	if (!iter->clips || state->ignore_damage_clips ||
+	    !drm_rect_equals(&state->src, &old_state->src)) {
 		iter->clips = NULL;
 		iter->num_clips = 0;
 		iter->full_update = true;
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 79d62856defb..fef775200a81 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -190,6 +190,16 @@ struct drm_plane_state {
 	 */
 	struct drm_property_blob *fb_damage_clips;
 
+	/**
+	 * @ignore_damage_clips:
+	 *
+	 * Set by drivers to indicate the drm_atomic_helper_damage_iter_init()
+	 * helper that the @fb_damage_clips blob property should be ignored.
+	 *
+	 * See :ref:`damage_tracking_properties` for more information.
+	 */
+	bool ignore_damage_clips;
+
 	/**
 	 * @src:
 	 *
-- 
2.41.0


