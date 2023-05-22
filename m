Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BB070C865
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjEVTif (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjEVTiX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:38:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A24710EC
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDF32629B1
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E99C433EF;
        Mon, 22 May 2023 19:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784285;
        bh=a35NCOtWRwsG5/d5uKbMEp/GwcysG2Js6piTYORGXVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w2+YQxfc92nUSrQV5154ka+0HhQfgpwLpU6SY4DjGC80TaPG25c8MYHRHezorEctA
         WsIaSMZ5nK75AN8HbpMoeulPzINOfsmdJ5AlGOBgVLoODJemSv9jl8jcMZRHCm4yL8
         fQugTnhaOUZeEm32s+F2gQvJsYqC3eKJ5LJehgcA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Karol Herbst <git@karolherbst.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 004/364] drm/nouveau/disp: More DP_RECEIVER_CAP_SIZE array fixes
Date:   Mon, 22 May 2023 20:05:09 +0100
Message-Id: <20230522190412.918898275@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 25feda6fbd0cfefcb69308fb20d4d4815a107c5e ]

More arrays (and arguments) for dcpd were set to 16, when it looks like
DP_RECEIVER_CAP_SIZE (15) should be used. Fix the remaining cases, seen
with GCC 13:

../drivers/gpu/drm/nouveau/nvif/outp.c: In function 'nvif_outp_acquire_dp':
../include/linux/fortify-string.h:57:33: warning: array subscript 'unsigned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds=]
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
...
../drivers/gpu/drm/nouveau/nvif/outp.c:140:9: note: in expansion of macro 'memcpy'
  140 |         memcpy(args.dp.dpcd, dpcd, sizeof(args.dp.dpcd));
      |         ^~~~~~
../drivers/gpu/drm/nouveau/nvif/outp.c:130:49: note: object 'dpcd' of size [0, 15]
  130 | nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[DP_RECEIVER_CAP_SIZE],
      |                                              ~~~^~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 813443721331 ("drm/nouveau/disp: move DP link config into acquire")
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Karol Herbst <kherbst@redhat.com>
Signed-off-by: Karol Herbst <git@karolherbst.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230204184307.never.825-kees@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/include/nvif/if0012.h    | 4 +++-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h  | 3 ++-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvif/if0012.h b/drivers/gpu/drm/nouveau/include/nvif/if0012.h
index eb99d84eb8443..16d4ad5023a3e 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/if0012.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/if0012.h
@@ -2,6 +2,8 @@
 #ifndef __NVIF_IF0012_H__
 #define __NVIF_IF0012_H__
 
+#include <drm/display/drm_dp.h>
+
 union nvif_outp_args {
 	struct nvif_outp_v0 {
 		__u8 version;
@@ -63,7 +65,7 @@ union nvif_outp_acquire_args {
 				__u8 hda;
 				__u8 mst;
 				__u8 pad04[4];
-				__u8 dpcd[16];
+				__u8 dpcd[DP_RECEIVER_CAP_SIZE];
 			} dp;
 		};
 	} v0;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
index b7631c1ab2420..4e7f873f66e27 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
@@ -3,6 +3,7 @@
 #define __NVKM_DISP_OUTP_H__
 #include "priv.h"
 
+#include <drm/display/drm_dp.h>
 #include <subdev/bios.h>
 #include <subdev/bios/dcb.h>
 #include <subdev/bios/dp.h>
@@ -42,7 +43,7 @@ struct nvkm_outp {
 			bool aux_pwr_pu;
 			u8 lttpr[6];
 			u8 lttprs;
-			u8 dpcd[16];
+			u8 dpcd[DP_RECEIVER_CAP_SIZE];
 
 			struct {
 				int dpcd; /* -1, or index into SUPPORTED_LINK_RATES table */
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
index 4f0ca709c85a4..fc283a4a1522a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
@@ -146,7 +146,7 @@ nvkm_uoutp_mthd_release(struct nvkm_outp *outp, void *argv, u32 argc)
 }
 
 static int
-nvkm_uoutp_mthd_acquire_dp(struct nvkm_outp *outp, u8 dpcd[16],
+nvkm_uoutp_mthd_acquire_dp(struct nvkm_outp *outp, u8 dpcd[DP_RECEIVER_CAP_SIZE],
 			   u8 link_nr, u8 link_bw, bool hda, bool mst)
 {
 	int ret;
-- 
2.39.2



