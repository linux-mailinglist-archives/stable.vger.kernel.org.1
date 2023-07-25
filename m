Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD7761166
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjGYKus (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjGYKu3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730AF2106
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10E1961648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9B6C433C7;
        Tue, 25 Jul 2023 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282213;
        bh=Gwuv9sdKf0MLjye6unTscqreNr2+mNE7wSo+lcCE+24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNnoPwc7AS1e5A/kq8qCk6giDt9DBfHwNJGx7XRxDfEAoks/x0i1lJg9YR2q3cJSn
         bvehYhSg/vYLowhCaNGkxCux/iHQVJw4J9cXmfyirzKOhiliek6rM+ZsrH/fV9dMx7
         TZbmaD+dOhm++YTp3Kl29NayE76Gf0q4ZVcD9nlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>
Subject: [PATCH 6.4 049/227] drm/nouveau/i2c: fix number of aux event slots
Date:   Tue, 25 Jul 2023 12:43:36 +0200
Message-ID: <20230725104516.831173243@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

commit 752a281032b2d6f4564be827e082bde6f7d2fd4f upstream.

This was completely bogus before, using maximum DCB device index rather
than maximum AUX ID to size the buffer that stores event refcounts.

*Pretty* unlikely to have been an actual problem on most configurations,
that is, unless you've got one of the rare boards that have off-chip DP.

There, it'll likely crash.

Cc: stable@vger.kernel.org # 6.4+
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Reviewed-by: Karol Herbst <kherbst@redhat.com>
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230719044051.6975-1-skeggsb@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/include/nvkm/subdev/i2c.h |  4 ++--
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c    | 11 +++++++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/i2c.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/i2c.h
index 40a1065ae626..ef441dfdea09 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/i2c.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/i2c.h
@@ -16,7 +16,7 @@ struct nvkm_i2c_bus {
 	const struct nvkm_i2c_bus_func *func;
 	struct nvkm_i2c_pad *pad;
 #define NVKM_I2C_BUS_CCB(n) /* 'n' is ccb index */                           (n)
-#define NVKM_I2C_BUS_EXT(n) /* 'n' is dcb external encoder type */ ((n) + 0x100)
+#define NVKM_I2C_BUS_EXT(n) /* 'n' is dcb external encoder type */  ((n) + 0x10)
 #define NVKM_I2C_BUS_PRI /* ccb primary comm. port */                        -1
 #define NVKM_I2C_BUS_SEC /* ccb secondary comm. port */                      -2
 	int id;
@@ -38,7 +38,7 @@ struct nvkm_i2c_aux {
 	const struct nvkm_i2c_aux_func *func;
 	struct nvkm_i2c_pad *pad;
 #define NVKM_I2C_AUX_CCB(n) /* 'n' is ccb index */                           (n)
-#define NVKM_I2C_AUX_EXT(n) /* 'n' is dcb external encoder type */ ((n) + 0x100)
+#define NVKM_I2C_AUX_EXT(n) /* 'n' is dcb external encoder type */  ((n) + 0x10)
 	int id;
 
 	struct mutex mutex;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
index 976539de4220..731b2f68d3db 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
@@ -260,10 +260,11 @@ nvkm_i2c_new_(const struct nvkm_i2c_func *func, struct nvkm_device *device,
 {
 	struct nvkm_bios *bios = device->bios;
 	struct nvkm_i2c *i2c;
+	struct nvkm_i2c_aux *aux;
 	struct dcb_i2c_entry ccbE;
 	struct dcb_output dcbE;
 	u8 ver, hdr;
-	int ret, i;
+	int ret, i, ids;
 
 	if (!(i2c = *pi2c = kzalloc(sizeof(*i2c), GFP_KERNEL)))
 		return -ENOMEM;
@@ -406,5 +407,11 @@ nvkm_i2c_new_(const struct nvkm_i2c_func *func, struct nvkm_device *device,
 		}
 	}
 
-	return nvkm_event_init(&nvkm_i2c_intr_func, &i2c->subdev, 4, i, &i2c->event);
+	ids = 0;
+	list_for_each_entry(aux, &i2c->aux, head)
+		ids = max(ids, aux->id + 1);
+	if (!ids)
+		return 0;
+
+	return nvkm_event_init(&nvkm_i2c_intr_func, &i2c->subdev, 4, ids, &i2c->event);
 }
-- 
2.41.0



