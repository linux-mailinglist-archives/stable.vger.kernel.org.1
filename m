Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5BC7ECE41
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbjKOTlx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbjKOTlw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:41:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7181FAB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:41:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB7CC433C9;
        Wed, 15 Nov 2023 19:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077308;
        bh=Akpa59Uoz8UBBqApT0zXrvbBI9srNyyo4L8nD4AQrwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+unlgbLat+n/Bpdk3M+yMxkWIlxthxNGX7utPyr+CB0LHs7Nq9tG1fI9cBvGOnxg
         /BWh6EVC+DQqfnhP31R6C4BHyrYEdBUdtF8bjcreYbtoX2e9Oz0Vvao6VVGwDn0/cr
         qx3VLSRQw/eKd8LbBg9xL67d5ebiAW3M7/2zO67g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nishanth Menon <nm@ti.com>,
        Helen Koike <helen.koike@collabora.com>,
        Jai Luthra <j-luthra@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 224/603] drm: bridge: it66121: Fix invalid connector dereference
Date:   Wed, 15 Nov 2023 14:12:49 -0500
Message-ID: <20231115191628.736011042@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jai Luthra <j-luthra@ti.com>

[ Upstream commit d0375f6858c4ff7244b62b02eb5e93428e1916cd ]

Fix the NULL pointer dereference when no monitor is connected, and the
sound card is opened from userspace.

Instead return an empty buffer (of zeroes) as the EDID information to
the sound framework if there is no connector attached.

Fixes: e0fd83dbe924 ("drm: bridge: it66121: Add audio support")
Reported-by: Nishanth Menon <nm@ti.com>
Closes: https://lore.kernel.org/all/20230825105849.crhon42qndxqif4i@gondola/
Reviewed-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230901-it66121_edid-v2-1-aa59605336b9@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 466641c77fe91..fc7f5ec5fb381 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1447,10 +1447,14 @@ static int it66121_audio_get_eld(struct device *dev, void *data,
 	struct it66121_ctx *ctx = dev_get_drvdata(dev);
 
 	mutex_lock(&ctx->lock);
-
-	memcpy(buf, ctx->connector->eld,
-	       min(sizeof(ctx->connector->eld), len));
-
+	if (!ctx->connector) {
+		/* Pass en empty ELD if connector not available */
+		dev_dbg(dev, "No connector present, passing empty EDID data");
+		memset(buf, 0, len);
+	} else {
+		memcpy(buf, ctx->connector->eld,
+		       min(sizeof(ctx->connector->eld), len));
+	}
 	mutex_unlock(&ctx->lock);
 
 	return 0;
-- 
2.42.0



