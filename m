Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7DC72C097
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbjFLKxe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbjFLKxK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:53:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4322261A2
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2739612E8
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D9AC433D2;
        Mon, 12 Jun 2023 10:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566270;
        bh=IBAZGypJCEuEPM1OF2gW7kAOSMQgVHtvn94AO3Pdpws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R9cOMvZU9Oappl8hIGxhxXgg8HnqI61XM7aaQiNrOG8pvRqrnJ81nOuTpLJ7Mmyal
         3J7XDvSGhQwkjrHtQy/1O7xvKNlvomrKtjOYyDOMM0fwR3preonlPV5lpNvwWv0zEx
         SUZBpqiKK5bsPoblmWNkYv6YCDADOZwXHBvPx4aQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Fedor Pchelkin <pchelkin@ispras.ru>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15 59/91] can: j1939: change j1939_netdev_lock type to mutex
Date:   Mon, 12 Jun 2023 12:26:48 +0200
Message-ID: <20230612101704.526575893@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Fedor Pchelkin <pchelkin@ispras.ru>

commit cd9c790de2088b0d797dc4d244b4f174f9962554 upstream.

It turns out access to j1939_can_rx_register() needs to be serialized,
otherwise j1939_priv can be corrupted when parallel threads call
j1939_netdev_start() and j1939_can_rx_register() fails. This issue is
thoroughly covered in other commit which serializes access to
j1939_can_rx_register().

Change j1939_netdev_lock type to mutex so that we do not need to remove
GFP_KERNEL from can_rx_register().

j1939_netdev_lock seems to be used in normal contexts where mutex usage
is not prohibited.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Suggested-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20230526171910.227615-2-pchelkin@ispras.ru
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/j1939/main.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -122,7 +122,7 @@ static void j1939_can_recv(struct sk_buf
 #define J1939_CAN_ID CAN_EFF_FLAG
 #define J1939_CAN_MASK (CAN_EFF_FLAG | CAN_RTR_FLAG)
 
-static DEFINE_SPINLOCK(j1939_netdev_lock);
+static DEFINE_MUTEX(j1939_netdev_lock);
 
 static struct j1939_priv *j1939_priv_create(struct net_device *ndev)
 {
@@ -216,7 +216,7 @@ static void __j1939_rx_release(struct kr
 	j1939_can_rx_unregister(priv);
 	j1939_ecu_unmap_all(priv);
 	j1939_priv_set(priv->ndev, NULL);
-	spin_unlock(&j1939_netdev_lock);
+	mutex_unlock(&j1939_netdev_lock);
 }
 
 /* get pointer to priv without increasing ref counter */
@@ -244,9 +244,9 @@ static struct j1939_priv *j1939_priv_get
 {
 	struct j1939_priv *priv;
 
-	spin_lock(&j1939_netdev_lock);
+	mutex_lock(&j1939_netdev_lock);
 	priv = j1939_priv_get_by_ndev_locked(ndev);
-	spin_unlock(&j1939_netdev_lock);
+	mutex_unlock(&j1939_netdev_lock);
 
 	return priv;
 }
@@ -256,14 +256,14 @@ struct j1939_priv *j1939_netdev_start(st
 	struct j1939_priv *priv, *priv_new;
 	int ret;
 
-	spin_lock(&j1939_netdev_lock);
+	mutex_lock(&j1939_netdev_lock);
 	priv = j1939_priv_get_by_ndev_locked(ndev);
 	if (priv) {
 		kref_get(&priv->rx_kref);
-		spin_unlock(&j1939_netdev_lock);
+		mutex_unlock(&j1939_netdev_lock);
 		return priv;
 	}
-	spin_unlock(&j1939_netdev_lock);
+	mutex_unlock(&j1939_netdev_lock);
 
 	priv = j1939_priv_create(ndev);
 	if (!priv)
@@ -273,20 +273,20 @@ struct j1939_priv *j1939_netdev_start(st
 	spin_lock_init(&priv->j1939_socks_lock);
 	INIT_LIST_HEAD(&priv->j1939_socks);
 
-	spin_lock(&j1939_netdev_lock);
+	mutex_lock(&j1939_netdev_lock);
 	priv_new = j1939_priv_get_by_ndev_locked(ndev);
 	if (priv_new) {
 		/* Someone was faster than us, use their priv and roll
 		 * back our's.
 		 */
 		kref_get(&priv_new->rx_kref);
-		spin_unlock(&j1939_netdev_lock);
+		mutex_unlock(&j1939_netdev_lock);
 		dev_put(ndev);
 		kfree(priv);
 		return priv_new;
 	}
 	j1939_priv_set(ndev, priv);
-	spin_unlock(&j1939_netdev_lock);
+	mutex_unlock(&j1939_netdev_lock);
 
 	ret = j1939_can_rx_register(priv);
 	if (ret < 0)
@@ -304,7 +304,7 @@ struct j1939_priv *j1939_netdev_start(st
 
 void j1939_netdev_stop(struct j1939_priv *priv)
 {
-	kref_put_lock(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);
+	kref_put_mutex(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);
 	j1939_priv_put(priv);
 }
 


