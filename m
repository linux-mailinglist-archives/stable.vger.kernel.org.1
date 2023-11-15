Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE967ED04C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbjKOTyG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbjKOTyF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:54:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9426E19F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:54:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9D0C433C7;
        Wed, 15 Nov 2023 19:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078042;
        bh=8UNxHa9VkZLLUgXmTebIOmPRyN0c/PxqFA9Q7rk7UsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SYFQAavazKcF/g4YoJBRyhq692+f60bbesNxlceLoCbLylhVRnzWkcLh/CYBPr7fc
         QCnuug08yeEz3mTruQUgHgV4G8yJeXyK5NRY4tLTGd08r34pLboBdsQn1Iv3lowILY
         q+e2BAKsvGiPstJxVLL9cnmEcGnXXZLdZWLBQQ1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 074/379] net: add DEV_STATS_READ() helper
Date:   Wed, 15 Nov 2023 14:22:29 -0500
Message-ID: <20231115192649.526009033@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 0b068c714ca9479d2783cc333fff5bc2d4a6d45c ]

Companion of DEV_STATS_INC() & DEV_STATS_ADD().

This is going to be used in the series.

Use it in macsec_get_stats64().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: ff672b9ffeb3 ("ipvlan: properly track tx_errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c      | 6 +++---
 include/linux/netdevice.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 81453e84b6413..209ee9f352754 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3664,9 +3664,9 @@ static void macsec_get_stats64(struct net_device *dev,
 
 	dev_fetch_sw_netstats(s, dev->tstats);
 
-	s->rx_dropped = atomic_long_read(&dev->stats.__rx_dropped);
-	s->tx_dropped = atomic_long_read(&dev->stats.__tx_dropped);
-	s->rx_errors = atomic_long_read(&dev->stats.__rx_errors);
+	s->rx_dropped = DEV_STATS_READ(dev, rx_dropped);
+	s->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
+	s->rx_errors = DEV_STATS_READ(dev, rx_errors);
 }
 
 static int macsec_get_iflink(const struct net_device *dev)
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5a04fbf724768..0373e09359905 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5190,5 +5190,6 @@ extern struct net_device *blackhole_netdev;
 #define DEV_STATS_INC(DEV, FIELD) atomic_long_inc(&(DEV)->stats.__##FIELD)
 #define DEV_STATS_ADD(DEV, FIELD, VAL) 	\
 		atomic_long_add((VAL), &(DEV)->stats.__##FIELD)
+#define DEV_STATS_READ(DEV, FIELD) atomic_long_read(&(DEV)->stats.__##FIELD)
 
 #endif	/* _LINUX_NETDEVICE_H */
-- 
2.42.0



