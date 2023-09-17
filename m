Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D137A37BF
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbjIQTYq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239501AbjIQTYU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:24:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F74D9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:24:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358CCC433C7;
        Sun, 17 Sep 2023 19:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978654;
        bh=0lCvPl2emCW/skxaV+tcY0MsWBt0HEJZLlDEp6WmGUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6dp+G013wnuuiUUK7rPCCjEZeD33XU22MbbZiw6hQA4bepxMYjfpK18zHyHutKv8
         Mjb04VbgegYbvyo246xa4h3JSD7kJ+oy5w9QXh0TOgmS97sdybWxi55S2j0KDfP2pL
         0saQTpOoJTsUXPLhxGA2dDvj+KCOkcpx4/12vWpE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 122/406] drm/bridge: tc358764: Fix debug print parameter order
Date:   Sun, 17 Sep 2023 21:09:36 +0200
Message-ID: <20230917191104.360616493@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>

[ Upstream commit 7f947be02aab5b154427cb5b0fffe858fc387b02 ]

The debug print parameters were swapped in the output and they were
printed as decimal values, both the hardware address and the value.
Update the debug print to print the parameters in correct order, and
use hexadecimal print for both address and value.

Fixes: f38b7cca6d0e ("drm/bridge: tc358764: Add DSI to LVDS bridge driver")
Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230615152817.359420-1-marex@denx.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358764.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358764.c b/drivers/gpu/drm/bridge/tc358764.c
index d89394bc5aa4d..ea1445e09e6f1 100644
--- a/drivers/gpu/drm/bridge/tc358764.c
+++ b/drivers/gpu/drm/bridge/tc358764.c
@@ -180,7 +180,7 @@ static void tc358764_read(struct tc358764 *ctx, u16 addr, u32 *val)
 	if (ret >= 0)
 		le32_to_cpus(val);
 
-	dev_dbg(ctx->dev, "read: %d, addr: %d\n", addr, *val);
+	dev_dbg(ctx->dev, "read: addr=0x%04x data=0x%08x\n", addr, *val);
 }
 
 static void tc358764_write(struct tc358764 *ctx, u16 addr, u32 val)
-- 
2.40.1



