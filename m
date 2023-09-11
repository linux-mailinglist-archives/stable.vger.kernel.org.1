Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC5079BDC0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345595AbjIKVVb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240191AbjIKOiw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:38:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB11F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:38:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83640C433C8;
        Mon, 11 Sep 2023 14:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443127;
        bh=PRp8MeG4ORFCr5xiw0p1Kwjv/nmgIqJ1yKUOwn++76w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vAoP12lgs5oFmp8OMxmn9ZfxCSR71CN9UDPa9D6lfvjjJAvOic73jmgXIqTJCeZkR
         v735MvboHl/4bsmzdNAkmyOf+35/B44NXOOsNqAA+L1vYElP5n+yp0m1gESYk3q+54
         fGIQl7kWD3+S1BpLkayIPezqNH61ljkzwjZpx/bk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 267/737] drm/bridge: tc358764: Fix debug print parameter order
Date:   Mon, 11 Sep 2023 15:42:06 +0200
Message-ID: <20230911134658.041028539@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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
index f85654f1b1045..8e938a7480f37 100644
--- a/drivers/gpu/drm/bridge/tc358764.c
+++ b/drivers/gpu/drm/bridge/tc358764.c
@@ -176,7 +176,7 @@ static void tc358764_read(struct tc358764 *ctx, u16 addr, u32 *val)
 	if (ret >= 0)
 		le32_to_cpus(val);
 
-	dev_dbg(ctx->dev, "read: %d, addr: %d\n", addr, *val);
+	dev_dbg(ctx->dev, "read: addr=0x%04x data=0x%08x\n", addr, *val);
 }
 
 static void tc358764_write(struct tc358764 *ctx, u16 addr, u32 val)
-- 
2.40.1



