Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420DF7F057E
	for <lists+stable@lfdr.de>; Sun, 19 Nov 2023 11:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjKSK5Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 19 Nov 2023 05:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKSK5Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 19 Nov 2023 05:57:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180CAC6
        for <stable@vger.kernel.org>; Sun, 19 Nov 2023 02:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700391439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vwKTxIgr09omGUBF1m9vDxqCyG9hQEMime1yIZzuygQ=;
        b=J0kbmJxLkdMnVBSBlPY5aiBzwfs/TlAm8sJvbW4eHRBN4WpBtzKhPZUTDTJlkb+EaLOSun
        OtMb7Ono8zHQiT/K07IGpeqCoIpNdlT59Q27HiKBRCwhcmFFp+sgzEMrqzpyefDQ/vGGYi
        dT56txQd+KSwLDZF4J/QiYVLLWRUhs0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-N_7gSOvlOV2SLbXXfLK3ag-1; Sun, 19 Nov 2023 05:57:17 -0500
X-MC-Unique: N_7gSOvlOV2SLbXXfLK3ag-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40855a91314so5200135e9.1
        for <stable@vger.kernel.org>; Sun, 19 Nov 2023 02:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700391436; x=1700996236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwKTxIgr09omGUBF1m9vDxqCyG9hQEMime1yIZzuygQ=;
        b=CIF9ghQIUVYnn1SGS+fI79KpG9SZGk8USma+9j+NMhwBH+kqdTozLSzG7BwRJiroey
         5tUSJXl+Ead+KLekVne5247GejW/DBRW5HND9O9eEC/At0Br13XQ36Wr+T5oZW3mnEGp
         MJasau8sE+YtTCsW1C1ImyE75L0WyIuLIfFSvLF3CIxYJOLUfLblnsyisPy6mgBlr71P
         aJk4QIH8Cm1ITs90UZpgtILOV9OqTvVEx/IWoo1BJ97fYcVkqcFrbehVciXvQWb+b2gL
         Z4TMYDCA8cXXbr9CAExoWZJR/LMTlwKpmpMd1IT+xVFVFRnDuWavi13jyBfq9Kn5Osr1
         3KRw==
X-Gm-Message-State: AOJu0Yyvz/wCN8BjikrBVQTf171GjySEgt0qDBn8wwL0kmyIQjPLnfZH
        VkskTzvJ6Nscyxl90+5sq3aGJXnOrNvB7zQUap0adFIK3kMFR7jUI6iQS184lB51ekLvjA2Dc24
        Ac7V+b1UubC6ZVvBP
X-Received: by 2002:a05:600c:a48:b0:401:b425:2414 with SMTP id c8-20020a05600c0a4800b00401b4252414mr8849698wmq.18.1700391436497;
        Sun, 19 Nov 2023 02:57:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTr3xemuWiX3MZFy4qGqbNac/hdlijHFi83h7o6vBK3ccLPETc7+WJcogKeoinWFEMLApjFA==
X-Received: by 2002:a05:600c:a48:b0:401:b425:2414 with SMTP id c8-20020a05600c0a4800b00401b4252414mr8849674wmq.18.1700391436164;
        Sun, 19 Nov 2023 02:57:16 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c510200b0040a4835d2b2sm14233407wms.37.2023.11.19.02.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 02:57:14 -0800 (PST)
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
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 1/5] drm: Allow drivers to indicate the damage helpers to ignore damage clips
Date:   Sun, 19 Nov 2023 11:56:57 +0100
Message-ID: <20231119105709.3143489-2-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231119105709.3143489-1-javierm@redhat.com>
References: <20231119105709.3143489-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
---

(no changes since v2)

Changes in v2:
- Add a struct drm_plane_state .ignore_damage_clips to set in the plane's
  .atomic_check, instead of having different helpers (Thomas Zimmermann).

 drivers/gpu/drm/drm_damage_helper.c | 3 ++-
 include/drm/drm_plane.h             | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

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
index 79d62856defb..cc2e8fc35fd2 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -190,6 +190,14 @@ struct drm_plane_state {
 	 */
 	struct drm_property_blob *fb_damage_clips;
 
+	/**
+	 * @ignore_damage_clips:
+	 *
+	 * Set by drivers to indicate the drm_atomic_helper_damage_iter_init()
+	 * helper that the @fb_damage_clips blob property should be ignored.
+	 */
+	bool ignore_damage_clips;
+
 	/**
 	 * @src:
 	 *
-- 
2.41.0

