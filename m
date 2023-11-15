Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597D87ED04B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbjKOTyF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbjKOTyF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:54:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059511AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:54:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F45AC433C9;
        Wed, 15 Nov 2023 19:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078040;
        bh=btUJBv94S5Lipo4m7GNvuNE8fjEwkXDEzZG4bPc+sCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKvMJL1gdlj87U3ecjtYQURc6dnhxCyj7q8AIjpx5V1fGIrLKjKtf2h8nTVfAJNO8
         okT8Hxa85ucnqT4kaarp/ziZtANlYCNyq5Ly8gXoAMJ23RqneWaKbtFSIaMQ3Bqx5u
         UnVcZ5YpcE2HnVCwbo8CkSSZD0GbQAnuFp6Jmyw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 056/379] can: dev: can_put_echo_skb(): dont crash kernel if can_priv::echo_skb is accessed out of bounds
Date:   Wed, 15 Nov 2023 14:22:11 -0500
Message-ID: <20231115192648.473317837@linuxfoundation.org>
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



