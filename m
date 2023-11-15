Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFEF7ED2B9
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjKOUnF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343700AbjKOTzo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:55:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982A11715
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:55:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C385C433C8;
        Wed, 15 Nov 2023 19:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078140;
        bh=qq+pQWndxCbzLlHkOtEBqm1nwkr5IyBnqrzwIF2OXVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UYu09U5tcwbYKWSVwq72MW0ZLRgDiGm7NnckoIkqI0mODPjEhg4NH820EEZ245nrM
         jtbaxDAvTENp/mqONZ5EstVyFgZ627UKS02RGt7eI2jBdKjWa6891JBakoVy0FfXoF
         rAP42TTmYF3aTGnmHcIXFGiYz0M1mjoxG9By4xPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Robert Foss <rfoss@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Maxim Schwalm <maxim.schwalm@gmail.com>
Subject: [PATCH 6.1 134/379] drm/bridge: tc358768: Fix tc358768_ns_to_cnt()
Date:   Wed, 15 Nov 2023 14:23:29 -0500
Message-ID: <20231115192653.057214581@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit f1dabbe645065d20ca863c8d446c74c59ca1ca9d ]

The tc358768_ns_to_cnt() is, most likely, supposed to do a div-round-up
operation, but it misses subtracting one from the dividend.

Fix this by just using DIV_ROUND_UP().

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # Asus TF700T
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230906-tc358768-v4-11-31725f008a50@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 5fd89596c9a20..8429b6518b502 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -631,7 +631,7 @@ static int tc358768_setup_pll(struct tc358768_priv *priv,
 
 static u32 tc358768_ns_to_cnt(u32 ns, u32 period_ps)
 {
-	return (ns * 1000 + period_ps) / period_ps;
+	return DIV_ROUND_UP(ns * 1000, period_ps);
 }
 
 static u32 tc358768_ps_to_ns(u32 ps)
-- 
2.42.0



