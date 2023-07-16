Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5B5755514
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjGPUhL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjGPUhJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:37:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF22BE41
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:37:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD8C560EB8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF03C433C8;
        Sun, 16 Jul 2023 20:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539826;
        bh=+QVoBGjCHwHyp0NZ0tsRY2KoP61YcdYpqRxaf/wZ3yY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kg8r2vY+rJp7ajYJQqUAOX7M894+8zuwNbGCYbn5v0s9lVJbxHiWDxaYaYFpGWNfM
         e5UZO6di7VAGe7Hm/FiwuXzd+eICUX1gCDiXoJg4otHJsry75Powpsj8WFj1lYCVrH
         1tSTqqPiY7BTNdFpPk9fKUR+zZvxADBEV+zi5P+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 146/591] drm/bridge: ti-sn65dsi83: Fix enable error path
Date:   Sun, 16 Jul 2023 21:44:45 +0200
Message-ID: <20230716194927.649018897@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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
index 047c14ddbbf11..0635b824e3682 100644
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



