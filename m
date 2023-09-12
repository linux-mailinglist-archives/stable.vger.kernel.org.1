Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A5079BE5A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355369AbjIKV56 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238789AbjIKOFF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:05:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BABCF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:05:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7254BC433C7;
        Mon, 11 Sep 2023 14:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441100;
        bh=c+ia0f29xaVBqIQs6WPcLGFR++ExWXBCjTCS2m+g9hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y6ad39692JqPy+GC6dADKClPy9vy4OwXfkMtIkO00LbIliBmi965MxgiOpB5YTG+r
         nlwUKd9MYcX3pXwBgPAl3/0nA9mxHozTrpbRB8l7cRrTGO20ItqAyYKhdSa5+34KGF
         KyDmHmNVMP1OHH728olPPL84dsUSdxheEFIVrhoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 296/739] drm/armada: Fix off-by-one error in armada_overlay_get_property()
Date:   Mon, 11 Sep 2023 15:41:35 +0200
Message-ID: <20230911134659.398702787@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 5f0d984053f74983a287100a9519b2fabb785fb5 ]

As ffs() returns one more than the index of the first bit set (zero
means no bits set), the color key mode value is shifted one position too
much.

Fix this by using FIELD_GET() instead.

Fixes: c96103b6c49ff9a8 ("drm/armada: move colorkey properties into overlay plane state")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/a4d779d954a7515ddbbf31cb0f0d8184c0e7c879.1689600265.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/armada/armada_overlay.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_overlay.c b/drivers/gpu/drm/armada/armada_overlay.c
index f21eb8fb76d87..3b9bd8ecda137 100644
--- a/drivers/gpu/drm/armada/armada_overlay.c
+++ b/drivers/gpu/drm/armada/armada_overlay.c
@@ -4,6 +4,8 @@
  *  Rewritten from the dovefb driver, and Armada510 manuals.
  */
 
+#include <linux/bitfield.h>
+
 #include <drm/armada_drm.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -445,8 +447,8 @@ static int armada_overlay_get_property(struct drm_plane *plane,
 			     drm_to_overlay_state(state)->colorkey_ug,
 			     drm_to_overlay_state(state)->colorkey_vb, 0);
 	} else if (property == priv->colorkey_mode_prop) {
-		*val = (drm_to_overlay_state(state)->colorkey_mode &
-			CFG_CKMODE_MASK) >> ffs(CFG_CKMODE_MASK);
+		*val = FIELD_GET(CFG_CKMODE_MASK,
+				 drm_to_overlay_state(state)->colorkey_mode);
 	} else if (property == priv->brightness_prop) {
 		*val = drm_to_overlay_state(state)->brightness + 256;
 	} else if (property == priv->contrast_prop) {
-- 
2.40.1



