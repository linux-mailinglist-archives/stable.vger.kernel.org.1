Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6757ECB7F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjKOTWn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjKOTWm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:22:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F025B1BE
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:22:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D12FC433C8;
        Wed, 15 Nov 2023 19:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076156;
        bh=LyEouhdRCe6NuBZo+zHII8nVMWGA82chxhoP/OqZbMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z7BeZwfmG6nkDPd9W+78K8e9u80VeiLmXadIaK4GudFu2BsHGn9V0Ydffb98VpPOK
         CDuYrZLTAMcGAD33UueAcaV8XJU5hiKrGoDSrbz9QtkbdV0C/Q5OWfEDK19AdYLpoc
         QWqCmq5aZDAEiCLsHgGkwi4uGPxEKQFoSXg90zQo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 109/550] can: dev: can_put_echo_skb(): dont crash kernel if can_priv::echo_skb is accessed out of bounds
Date:   Wed, 15 Nov 2023 14:11:33 -0500
Message-ID: <20231115191608.256046559@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit 6411959c10fe917288cbb1038886999148560057 ]

If the "struct can_priv::echoo_skb" is accessed out of bounds, this
would cause a kernel crash. Instead, issue a meaningful warning
message and return with an error.

Fixes: a6e4bc530403 ("can: make the number of echo skb's configurable")
Link: https://lore.kernel.org/all/20231005-can-dev-fix-can-restart-v2-5-91b5c1fd922c@pengutronix.de
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/dev/skb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index f6d05b3ef59ab..3ebd4f779b9bd 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -49,7 +49,11 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 {
 	struct can_priv *priv = netdev_priv(dev);
 
-	BUG_ON(idx >= priv->echo_skb_max);
+	if (idx >= priv->echo_skb_max) {
+		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
+			   __func__, idx, priv->echo_skb_max);
+		return -EINVAL;
+	}
 
 	/* check flag whether this packet has to be looped back */
 	if (!(dev->flags & IFF_ECHO) ||
-- 
2.42.0



