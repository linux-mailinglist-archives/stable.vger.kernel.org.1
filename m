Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCD973A4AD
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 17:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjFVPVM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 11:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjFVPVI (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 11:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF117E42
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687447224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GMA8wGndW1W3qKjciAhlPaH569xG8UzR5aTyG8RbL8A=;
        b=dHXgOJ8YZfidliWf9elYwZqy44QwqMmObA5H5fgeI3eFisQ1GPoxkviL3ZoYmFY8WQoBD+
        G7iMf8lnu/aHOFAcJ1NbNw602Ettw4rPY3is/9RZkeF3UuQ9/MDrPNcHpVMlkTjPQ/K7QV
        hJKIZoyxHdPRop7BoKyVanhq/wgFY2Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-uBsr0MjdN4i7yyikVmI8Vw-1; Thu, 22 Jun 2023 11:20:22 -0400
X-MC-Unique: uBsr0MjdN4i7yyikVmI8Vw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3ff1fd64d57so11471271cf.0
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 08:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687447221; x=1690039221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMA8wGndW1W3qKjciAhlPaH569xG8UzR5aTyG8RbL8A=;
        b=UcMB0SE2Q4kHGr3RAhsSL0Gtz6T6861E6/KFzY3YC9USftmy01TGPYSuiZg8JNShw6
         4bpICH+jNg1rGuGxoc4sJZbcJLwXzhAFj9bJTG6DOF50mDpA3YE683X8yjYw9uoQFVKX
         SvndMcsFF/mcW5uRMqrBrfMhEBm8CWse5IT7EjLiQSTybqzPCioHkAB7xhVJgMZqPyK9
         ffHwpnpFbQVJh17YfmPBO6eXK8IxqYiGzfcYq37CuwNslyAb5YpM/7xcKbSNwDJhPVu4
         Shk3pQjjGb16iFOzU/gHjzUViB9EkF1TPiFDmoijbmwnHq3wUV87oGuFJaNwNE10MEd7
         q2ig==
X-Gm-Message-State: AC+VfDw/6kWT3pOqjtvtaq4TSlFqMt2tN6D9MBa9VzEa45ARQSQpV17d
        MEfpYJxGUv2E8gFwt8daVPvDjCXmb+CsGRXDo79G22pTXPVqZ+SH3XbZE1b1Ou8ACw+XIrHdfHa
        sHteCD73ONJsg5682nIcLY4WU
X-Received: by 2002:a05:622a:1b8c:b0:3fd:def0:57fb with SMTP id bp12-20020a05622a1b8c00b003fddef057fbmr22153316qtb.6.1687447221591;
        Thu, 22 Jun 2023 08:20:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7bOzGejNL9heS5tg9yZzKLbqW+z4bcegBQgxfOE33k3iRU6uDJF1Thh4gS9a3ffxTuKXKluQ==
X-Received: by 2002:a05:622a:1b8c:b0:3fd:def0:57fb with SMTP id bp12-20020a05622a1b8c00b003fddef057fbmr22153311qtb.6.1687447221348;
        Thu, 22 Jun 2023 08:20:21 -0700 (PDT)
Received: from kherbst.pingu (ip5f5a301e.dynamic.kabel-deutschland.de. [95.90.48.30])
        by smtp.gmail.com with ESMTPSA id bp20-20020a05622a1b9400b003ff251b17c8sm3701072qtb.10.2023.06.22.08.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 08:20:20 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@gmail.com>,
        nouveau@lists.freedesktop.org, stable@vger.kernel.org
Subject: [PATCH v2] drm/nouveau/gr: enable memory loads on helper invocation on all channels
Date:   Thu, 22 Jun 2023 17:20:17 +0200
Message-ID: <20230622152017.2512101-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

We have a lurking bug where Fragment Shader Helper Invocations can't load
from memory. But this is actually required in OpenGL and is causing random
hangs or failures in random shaders.

It is unknown how widespread this issue is, but shaders hitting this can
end up with infinite loops.

We enable those only on all Kepler and newer GPUs where we use our own
Firmware.

Nvidia's firmware provides a way to set a kernelspace controlled list of
mmio registers in the gr space from push buffers via MME macros.

v2: drop code for gm200 and newer.

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: nouveau@lists.freedesktop.org
Cc: stable@vger.kernel.org
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h  |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c  |  4 +++-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c  | 10 ++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c  |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c  |  1 +
 6 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h
index 00dbeda7e346..de161e7a04aa 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h
@@ -117,6 +117,7 @@ void gk104_grctx_generate_r418800(struct gf100_gr *);
 
 extern const struct gf100_grctx_func gk110_grctx;
 void gk110_grctx_generate_r419eb0(struct gf100_gr *);
+void gk110_grctx_generate_r419f78(struct gf100_gr *);
 
 extern const struct gf100_grctx_func gk110b_grctx;
 extern const struct gf100_grctx_func gk208_grctx;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c
index 94233d0119df..52a234b1ef01 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c
@@ -906,7 +906,9 @@ static void
 gk104_grctx_generate_r419f78(struct gf100_gr *gr)
 {
 	struct nvkm_device *device = gr->base.engine.subdev.device;
-	nvkm_mask(device, 0x419f78, 0x00000001, 0x00000000);
+
+	/* bit 3 set disables loads in fp helper invocations, we need it enabled */
+	nvkm_mask(device, 0x419f78, 0x00000009, 0x00000000);
 }
 
 void
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c
index 4391458e1fb2..3acdd9eeb74a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c
@@ -820,6 +820,15 @@ gk110_grctx_generate_r419eb0(struct gf100_gr *gr)
 	nvkm_mask(device, 0x419eb0, 0x00001000, 0x00001000);
 }
 
+void
+gk110_grctx_generate_r419f78(struct gf100_gr *gr)
+{
+	struct nvkm_device *device = gr->base.engine.subdev.device;
+
+	/* bit 3 set disables loads in fp helper invocations, we need it enabled */
+	nvkm_mask(device, 0x419f78, 0x00000008, 0x00000000);
+}
+
 const struct gf100_grctx_func
 gk110_grctx = {
 	.main  = gf100_grctx_generate_main,
@@ -854,4 +863,5 @@ gk110_grctx = {
 	.gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
 	.r418800 = gk104_grctx_generate_r418800,
 	.r419eb0 = gk110_grctx_generate_r419eb0,
+	.r419f78 = gk110_grctx_generate_r419f78,
 };
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c
index 7b9a34f9ec3c..5597e87624ac 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c
@@ -103,4 +103,5 @@ gk110b_grctx = {
 	.gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
 	.r418800 = gk104_grctx_generate_r418800,
 	.r419eb0 = gk110_grctx_generate_r419eb0,
+	.r419f78 = gk110_grctx_generate_r419f78,
 };
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c
index c78d07a8bb7d..612656496541 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c
@@ -568,4 +568,5 @@ gk208_grctx = {
 	.dist_skip_table = gf117_grctx_generate_dist_skip_table,
 	.gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
 	.r418800 = gk104_grctx_generate_r418800,
+	.r419f78 = gk110_grctx_generate_r419f78,
 };
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c
index beac66eb2a80..9906974ac3f0 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c
@@ -988,4 +988,5 @@ gm107_grctx = {
 	.r406500 = gm107_grctx_generate_r406500,
 	.gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
 	.r419e00 = gm107_grctx_generate_r419e00,
+	.r419f78 = gk110_grctx_generate_r419f78,
 };
-- 
2.41.0

