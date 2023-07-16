Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B9F755269
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjGPUHe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjGPUHe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:07:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1B39B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:07:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E189460EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3172C433C7;
        Sun, 16 Jul 2023 20:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538052;
        bh=j97IC3UZTTirl69QGwvmrQh8aZGq4tIqkya9dvtFx1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D3VjJhA7HeRuVZWPINZWaF5Aw6hMnAHhAnULlqNT3YFRsT/1Q7y74KdQqoaBN+eYX
         zGl2WhFXPad0VEHWgDXTV2d1JtmM4YZlc7yveIsSXflyhhzmigBTl1zp9EHE+w2dBK
         9qXJUYWxN+DtGVpaSrqjVjyXErVl+mCnO9rOiabA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Karol Herbst <kherbst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 278/800] drm/nouveau: dispnv50: fix missing-prototypes warning
Date:   Sun, 16 Jul 2023 21:42:11 +0200
Message-ID: <20230716194955.548165576@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 504e72ed3a1b1c0d4450712a42ae6070d3a05a8e ]

nv50_display_create() is declared in another header, along with
a couple of declarations that are now outdated:

drivers/gpu/drm/nouveau/dispnv50/disp.c:2517:1: error: no previous prototype for 'nv50_display_create'

Fixes: ba801ef068c1 ("drm/nouveau/kms: display destroy/init/fini hooks can be static")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Karol Herbst <kherbst@redhat.com>
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230417210329.2469722-1-arnd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 1 +
 drivers/gpu/drm/nouveau/nv50_display.h  | 4 +---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 5bb777ff13130..9b6824f6b9e4b 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -64,6 +64,7 @@
 #include "nouveau_connector.h"
 #include "nouveau_encoder.h"
 #include "nouveau_fence.h"
+#include "nv50_display.h"
 
 #include <subdev/bios/dp.h>
 
diff --git a/drivers/gpu/drm/nouveau/nv50_display.h b/drivers/gpu/drm/nouveau/nv50_display.h
index fbd3b15583bc8..60f77766766e9 100644
--- a/drivers/gpu/drm/nouveau/nv50_display.h
+++ b/drivers/gpu/drm/nouveau/nv50_display.h
@@ -31,7 +31,5 @@
 #include "nouveau_reg.h"
 
 int  nv50_display_create(struct drm_device *);
-void nv50_display_destroy(struct drm_device *);
-int  nv50_display_init(struct drm_device *);
-void nv50_display_fini(struct drm_device *);
+
 #endif /* __NV50_DISPLAY_H__ */
-- 
2.39.2



