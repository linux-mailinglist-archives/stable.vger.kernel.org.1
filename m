Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1A77759E6
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjHILDs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjHILDr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:03:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902CA2111
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:03:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DB71625AD
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A971C433C7;
        Wed,  9 Aug 2023 11:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579023;
        bh=H5zEHZa9fae65WNbFr4lHwy8p7u/1ZbE313iCkys0k0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chknFs6HW2L07notJLEwT6oyJfq5CfxRpDhJEXQOmbedyZIjhyebY2x1lIWpzDIK1
         5aA8igZuz1qZfu5DEV33QEL5c8wWQmUqQKTlmfTTARZq/MsGoLYN7YT1pTdsL6QFFP
         I1iELVKqZn7dp0I7MrGG2fQwK+uYWML8PhvY3728=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 019/204] wifi: wl3501_cs: Fix an error handling path in wl3501_probe()
Date:   Wed,  9 Aug 2023 12:39:17 +0200
Message-ID: <20230809103643.217312456@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 391af06a02e7642039ac5f6c4b2c034ab0992b5d ]

Should wl3501_config() fail, some resources need to be released as already
done in the remove function.

Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/7cc9c9316489b7d69b36aeb0edd3123538500b41.1684569865.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/wl3501_cs.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index cfde9b94b4b60..2eacd099a812f 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -1865,6 +1865,7 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
 {
 	struct net_device *dev;
 	struct wl3501_card *this;
+	int ret;
 
 	/* The io structure describes IO port mapping */
 	p_dev->resource[0]->end	= 16;
@@ -1876,8 +1877,7 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
 
 	dev = alloc_etherdev(sizeof(struct wl3501_card));
 	if (!dev)
-		goto out_link;
-
+		return -ENOMEM;
 
 	dev->netdev_ops		= &wl3501_netdev_ops;
 	dev->watchdog_timeo	= 5 * HZ;
@@ -1890,9 +1890,15 @@ static int wl3501_probe(struct pcmcia_device *p_dev)
 	netif_stop_queue(dev);
 	p_dev->priv = dev;
 
-	return wl3501_config(p_dev);
-out_link:
-	return -ENOMEM;
+	ret = wl3501_config(p_dev);
+	if (ret)
+		goto out_free_etherdev;
+
+	return 0;
+
+out_free_etherdev:
+	free_netdev(dev);
+	return ret;
 }
 
 static int wl3501_config(struct pcmcia_device *link)
-- 
2.39.2



