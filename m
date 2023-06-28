Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F99741ACE
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 23:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjF1VZu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 17:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjF1VZ2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 17:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DD1359B
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 14:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687987376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fP84djK5erd2GrrGFYuKnbHCuXvHXjeqzaJ4gXaZwiY=;
        b=RfW679b+zBmntmSbQc29Eq0WngafEXD0JXEmfdq+i7cjp/l48aDU8tkfFhAJprZ8rz80AB
        zoYjmh45DlmkLHdbpVI6CDdkQNZmEsJ3d5f2IkORKSA5tLhLPJZh/2Ukkn8F5kGDnEaUuo
        Ez1D0vt+w5pg/xhRFF6+50qVF3OnQoM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44--gm-qtCGPi6OjurVHlGWVw-1; Wed, 28 Jun 2023 17:22:55 -0400
X-MC-Unique: -gm-qtCGPi6OjurVHlGWVw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-313ecc94e23so714f8f.0
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 14:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687987374; x=1690579374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fP84djK5erd2GrrGFYuKnbHCuXvHXjeqzaJ4gXaZwiY=;
        b=ROpV0/SrKB9Vzrj4LXvtBG42VHRKHVu9h0Os8k2wiSg5zELIGOGT+BPqHgJVmfVtAc
         8pu99aAJw1qgzM9LERL2fR0gYUH5jEjff3PQorH6gMKogmttQPML9cKb5TCPtUC/klY1
         8ZlFr5STeFbsAA+1CxWw2GKz4Duz+L7C9vo2xBG+6KataXVLzf1XnGjujWlZ4GtlKMU6
         kNGw+Y5LsFYB5NKqAVozmgHAxPXzGKnc7XckA5tMbwi8+C0AYkzSWcSdWloA4LtlXbMt
         dn0hx9WHyIlFlxcYHKLJNNv5yF17FSP+IYoahFTOReOX0Ic2TgJkJf80EGLPbuPz1n8M
         hqdQ==
X-Gm-Message-State: AC+VfDyiI63cAnK6LLU5kCSn03TLn2emCe0Vbo5lEYOvUmRo1uNDE2i2
        uMF8ujP6oIIMVXCjPBrQK0OZv2K7CJ4KUsMYh1dY55JqsQuDGBV+e0HoECo4ZzqN4qQ1qjJH4AR
        jNRJ4zF6Dc59P9Q7i
X-Received: by 2002:a05:6000:151:b0:314:a77:b6c0 with SMTP id r17-20020a056000015100b003140a77b6c0mr2925787wrx.1.1687987373884;
        Wed, 28 Jun 2023 14:22:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5dTARVZLT46r+M/QXdzbg3Pfto134Vfy7ETRKzO1nDBcz+HGLvTECmnUAAxcjTyp3OM3kxvg==
X-Received: by 2002:a05:6000:151:b0:314:a77:b6c0 with SMTP id r17-20020a056000015100b003140a77b6c0mr2925773wrx.1.1687987373643;
        Wed, 28 Jun 2023 14:22:53 -0700 (PDT)
Received: from kherbst.pingu ([95.90.48.30])
        by smtp.gmail.com with ESMTPSA id r3-20020adfda43000000b0030ae3a6be4asm14294323wrl.72.2023.06.28.14.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:22:52 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH 3/3] drm/nouveau/disp: verify mode on atomic_check
Date:   Wed, 28 Jun 2023 23:22:48 +0200
Message-ID: <20230628212248.3798605-3-kherbst@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628212248.3798605-1-kherbst@redhat.com>
References: <20230628212248.3798605-1-kherbst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

We have to verify the selected mode as Userspace might request one which
we can't configure the GPU for.

X with the modesetting DDX is adding a bunch of modes, some so far outside
of hardware limits that things simply break.

Sadly we can't fix X this way as on start it sticks to one mode and
ignores any error and there is really nothing we can do about this, but at
least this way we won't let the GPU run into any errors caused by a non
supported display mode.

However this does prevent X from switching to such a mode, which to be
fair is an improvement as well.

Seen on one of my Tesla GPUs with a connected 4K display.

Link: https://gitlab.freedesktop.org/drm/nouveau/-/issues/199
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org # v6.1+
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 22c42a5e184d..edf490c1490c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1114,6 +1114,25 @@ nouveau_connector_atomic_check(struct drm_connector *connector, struct drm_atomi
 	struct drm_connector_state *conn_state =
 		drm_atomic_get_new_connector_state(state, connector);
 
+	/* As we can get any random mode from Userspace, we have to make sure the to be set mode
+	 * is valid and does not violate hardware constraints as we rely on it being sane.
+	 */
+	if (conn_state->crtc) {
+		struct drm_crtc_state *crtc_state =
+			drm_atomic_get_crtc_state(state, conn_state->crtc);
+
+		if (IS_ERR(crtc_state))
+			return PTR_ERR(crtc_state);
+
+		if (crtc_state->enable && (crtc_state->mode_changed ||
+					   crtc_state->connectors_changed)) {
+			struct drm_display_mode *mode = &crtc_state->mode;
+
+			if (connector->helper_private->mode_valid(connector, mode) != MODE_OK)
+				return -EINVAL;
+		}
+	}
+
 	if (!nv_conn->dp_encoder || !nv50_has_mst(nouveau_drm(connector->dev)))
 		return 0;
 
-- 
2.41.0

