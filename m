Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F66D74C2BE
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjGILYN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjGILYM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:24:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BC113D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:24:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA55D60BD6
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08621C433CA;
        Sun,  9 Jul 2023 11:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901850;
        bh=/Gb+7d5on5ldbUvYUatmLzZgwsfbIb2xtlY4bWoTHfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WpQ4TGWMoiWWkRoHdzjOXz5j7hvQA//M+sePjIUvC43p9KONtG+dSvCJZk1S6Vjpu
         oklr8lLRTV96/RIDzN0pPyz4Xmrj4tw+qYj288Zw6H9LcSfDmqlvJyKuCXKcsIfsN9
         38xIzz9uS760irOQNUTrbwxiEC2eC07JBQV/6tZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 167/431] drm/bridge: ti-sn65dsi83: Fix enable error path
Date:   Sun,  9 Jul 2023 13:11:55 +0200
Message-ID: <20230709111455.088793546@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 8a91b29f1f50ce7742cdbe5cf11d17f128511f3f ]

If PLL locking failed, the regulator needs to be disabled again.

Fixes: 5664e3c907e2 ("drm/bridge: ti-sn65dsi83: Add vcc supply regulator support")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230504065316.2640739-1-alexander.stein@ew.tq-group.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 91ecfbe45bf90..a6534011c9214 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -478,6 +478,7 @@ static void sn65dsi83_atomic_enable(struct drm_bridge *bridge,
 		dev_err(ctx->dev, "failed to lock PLL, ret=%i\n", ret);
 		/* On failure, disable PLL again and exit. */
 		regmap_write(ctx->regmap, REG_RC_PLL_EN, 0x00);
+		regulator_disable(ctx->vcc);
 		return;
 	}
 
-- 
2.39.2



