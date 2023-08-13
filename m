Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BACA77AB7C
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjHMVWm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjHMVW3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:22:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F5410D0
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:22:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1891C62802
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B51C433C7;
        Sun, 13 Aug 2023 21:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961750;
        bh=6G4kSgCXG/FEsdVTpIowIUtq5BEcBaQy3j2XY1KTA2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=js9vKwjrFkUO1RXTtRBU8jsev3AaW5q8vQkFoXOzjBGIZ4rFu8pFnyaHyAAorkwHC
         OO2aNCDmwQ88emZPJ2V+Pa8u1RVEgRXq+8xzMfVvXj7e+CxypXoiP0rNJ9E0bzb3e7
         QsCcXjC8rodv/Msvyx6g390jlCrWrK4qfOzSA1mY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@gmail.com>,
        nouveau@lists.freedesktop.org, Karol Herbst <kherbst@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH 4.19 05/33] drm/nouveau/gr: enable memory loads on helper invocation on all channels
Date:   Sun, 13 Aug 2023 23:18:59 +0200
Message-ID: <20230813211704.120063047@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211703.915807095@linuxfoundation.org>
References: <20230813211703.915807095@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Karol Herbst <kherbst@redhat.com>

commit 1cb9e2ef66d53b020842b18762e30d0eb4384de8 upstream.

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
Cc: stable@vger.kernel.org # 4.19+
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230622152017.2512101-1-kherbst@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h  |    1 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c  |    4 +++-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c  |   10 ++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c |    1 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c  |    1 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c  |    1 +
 6 files changed, 17 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgf100.h
@@ -121,6 +121,7 @@ void gk104_grctx_generate_r418800(struct
 
 extern const struct gf100_grctx_func gk110_grctx;
 void gk110_grctx_generate_r419eb0(struct gf100_gr *);
+void gk110_grctx_generate_r419f78(struct gf100_gr *);
 
 extern const struct gf100_grctx_func gk110b_grctx;
 extern const struct gf100_grctx_func gk208_grctx;
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk104.c
@@ -916,7 +916,9 @@ static void
 gk104_grctx_generate_r419f78(struct gf100_gr *gr)
 {
 	struct nvkm_device *device = gr->base.engine.subdev.device;
-	nvkm_mask(device, 0x419f78, 0x00000001, 0x00000000);
+
+	/* bit 3 set disables loads in fp helper invocations, we need it enabled */
+	nvkm_mask(device, 0x419f78, 0x00000009, 0x00000000);
 }
 
 void
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110.c
@@ -820,6 +820,15 @@ gk110_grctx_generate_r419eb0(struct gf10
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
@@ -852,4 +861,5 @@ gk110_grctx = {
 	.gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
 	.r418800 = gk104_grctx_generate_r418800,
 	.r419eb0 = gk110_grctx_generate_r419eb0,
+	.r419f78 = gk110_grctx_generate_r419f78,
 };
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk110b.c
@@ -101,4 +101,5 @@ gk110b_grctx = {
 	.gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
 	.r418800 = gk104_grctx_generate_r418800,
 	.r419eb0 = gk110_grctx_generate_r419eb0,
+	.r419f78 = gk110_grctx_generate_r419f78,
 };
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgk208.c
@@ -566,4 +566,5 @@ gk208_grctx = {
 	.dist_skip_table = gf117_grctx_generate_dist_skip_table,
 	.gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
 	.r418800 = gk104_grctx_generate_r418800,
+	.r419f78 = gk110_grctx_generate_r419f78,
 };
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ctxgm107.c
@@ -991,4 +991,5 @@ gm107_grctx = {
 	.r406500 = gm107_grctx_generate_r406500,
 	.gpc_tpc_nr = gk104_grctx_generate_gpc_tpc_nr,
 	.r419e00 = gm107_grctx_generate_r419e00,
+	.r419f78 = gk110_grctx_generate_r419f78,
 };


