Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252F07E7020
	for <lists+stable@lfdr.de>; Thu,  9 Nov 2023 18:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344581AbjKIR0B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 9 Nov 2023 12:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344256AbjKIR0A (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 9 Nov 2023 12:26:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51493255
        for <stable@vger.kernel.org>; Thu,  9 Nov 2023 09:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699550715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y0steN0/ACKFTtJOvpHMkiOMUe7bddz5OgwOILeHxPA=;
        b=FKWjHkZH2+NV8Hp4CCUruPEZysXV/btZRskdgEk8lcmKbpXTVK7g95gzNndAP43JEMn4yO
        SURyKz33+dEUHD1Mjj0zibDyjUIxTkJO/5+O2YC/Wot4uJ1wMtHah0c6X1ri5CT7X+q5pO
        tHvJhMRw128OzFwIHh2QOlBkvrJ2kVA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-FdaRTPZcMv69zDdtMHUNqQ-1; Thu, 09 Nov 2023 12:25:13 -0500
X-MC-Unique: FdaRTPZcMv69zDdtMHUNqQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507a3ae32b2so1069032e87.2
        for <stable@vger.kernel.org>; Thu, 09 Nov 2023 09:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550712; x=1700155512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0steN0/ACKFTtJOvpHMkiOMUe7bddz5OgwOILeHxPA=;
        b=SRe8x3l0ghrukdAiwyaTsY3zYyX6dm96k8ph9VHH5jkgwYq6MMe9lhEdYGAqo+Kv8s
         8yOaCv9nwF9ANLDBSack3rJHyn5EJ9RI9kKjFzGT91msW7OXV+kIicAFyT+0sAnr/jZk
         g0ZyonoYrgnsbM+dKqziX4BFr0QcNy7KVaFSEhDEKBvCqKvvbvJSBPoUkh1W46OXV1Mf
         /pmFv536h0cRzyj7SXxer2eG/9/nq02MyGmw10FZg2qxqUhMop5RQ68ENvsfo8u5e33A
         TY5RU1ejRE2FZCj/vZqRjhVJkD/2/c9pZEAPKheMAmmQkYsGN3TZy9W6i1lAG7b5D9FP
         6u/A==
X-Gm-Message-State: AOJu0YwIhjlVczibn2vCx8vVR6czwMf6KXi69wkJVCm/wn2jAjMUjWzZ
        UnT9Qvk6WOR7lRzWbB6M+N694/j2tMiIQ7+VeIE4kxw9QB4OiRPqSQnFTmG0h+UFoQ9Istm/XFz
        +aIPLFudrwMoJ4yDq
X-Received: by 2002:a19:e007:0:b0:507:b935:9f5f with SMTP id x7-20020a19e007000000b00507b9359f5fmr1877880lfg.24.1699550712280;
        Thu, 09 Nov 2023 09:25:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENtuNNft+jXRPbq2qJhlZT81jWdLguxD1V9O4aFnQJMyc+8VWIMEbR49N4zRWK0Yg8oNcUMw==
X-Received: by 2002:a19:e007:0:b0:507:b935:9f5f with SMTP id x7-20020a19e007000000b00507b9359f5fmr1877857lfg.24.1699550712088;
        Thu, 09 Nov 2023 09:25:12 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f15-20020a056000128f00b00323293bd023sm135806wrx.6.2023.11.09.09.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:25:11 -0800 (PST)
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
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 3/6] drm/virtio: Use drm_atomic_helper_buffer_damage_merged() for buffer damage
Date:   Thu,  9 Nov 2023 18:24:37 +0100
Message-ID: <20231109172449.1599262-4-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109172449.1599262-1-javierm@redhat.com>
References: <20231109172449.1599262-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The driver does per-buffer uploads. It needs to use the damage helper that
handles buffer damages, rather than the helper that handles frame damages.

Fixes: 01f05940a9a7 ("drm/virtio: Enable fb damage clips property for the primary plane")
Cc: <stable@vger.kernel.org> # v6.4+
Reported-by: nerdopolis <bluescreen_avenger@verizon.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218115
Suggested-by: Sima Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/virtio/virtgpu_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a2e045f3a000..1adfd9813cde 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -183,7 +183,7 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 		return;
 	}
 
-	if (!drm_atomic_helper_damage_merged(old_state, plane->state, &rect))
+	if (!drm_atomic_helper_buffer_damage_merged(old_state, plane->state, &rect))
 		return;
 
 	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
-- 
2.41.0

