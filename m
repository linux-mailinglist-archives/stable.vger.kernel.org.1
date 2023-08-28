Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B1178ACA8
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjH1Klf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjH1KlP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:41:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52DCC5
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:41:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 847EE615FE
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970E5C433C8;
        Mon, 28 Aug 2023 10:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219271;
        bh=yAbQnjxPZhxGefE/STspDKV4KoqywJ5b53dwU9jZYZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBGLY+EL+ISnZjQJqZDDycVCxDQghTnw8GX7sdQ1KM3Y4g2yjKGcYXmIz4+mVJHoN
         W9VvvJ5+X26L/rO/GSa628l0+ysutrR/rJMBhXgEoC48aZTR2xQM9C6l6P8jjpemla
         9mzD55kNdCbfZVB7a0f2lOhN3VSM+QUa2TSlWn/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5.4 135/158] batman-adv: Dont increase MTU when set by user
Date:   Mon, 28 Aug 2023 12:13:52 +0200
Message-ID: <20230828101202.064516976@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit d8e42a2b0addf238be8b3b37dcd9795a5c1be459 upstream.

If the user set an MTU value, it usually means that there are special
requirements for the MTU. But if an interface gots activated, the MTU was
always recalculated and then the user set value was overwritten.

The only reason why this user set value has to be overwritten, is when the
MTU has to be decreased because batman-adv is not able to transfer packets
with the user specified size.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/hard-interface.c |   14 +++++++++++++-
 net/batman-adv/soft-interface.c |    3 +++
 net/batman-adv/types.h          |    6 ++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -632,7 +632,19 @@ out:
  */
 void batadv_update_min_mtu(struct net_device *soft_iface)
 {
-	dev_set_mtu(soft_iface, batadv_hardif_min_mtu(soft_iface));
+	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
+	int limit_mtu;
+	int mtu;
+
+	mtu = batadv_hardif_min_mtu(soft_iface);
+
+	if (bat_priv->mtu_set_by_user)
+		limit_mtu = bat_priv->mtu_set_by_user;
+	else
+		limit_mtu = ETH_DATA_LEN;
+
+	mtu = min(mtu, limit_mtu);
+	dev_set_mtu(soft_iface, mtu);
 
 	/* Check if the local translate table should be cleaned up to match a
 	 * new (and smaller) MTU.
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -156,11 +156,14 @@ static int batadv_interface_set_mac_addr
 
 static int batadv_interface_change_mtu(struct net_device *dev, int new_mtu)
 {
+	struct batadv_priv *bat_priv = netdev_priv(dev);
+
 	/* check ranges */
 	if (new_mtu < 68 || new_mtu > batadv_hardif_min_mtu(dev))
 		return -EINVAL;
 
 	dev->mtu = new_mtu;
+	bat_priv->mtu_set_by_user = new_mtu;
 
 	return 0;
 }
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1564,6 +1564,12 @@ struct batadv_priv {
 	struct net_device *soft_iface;
 
 	/**
+	 * @mtu_set_by_user: MTU was set once by user
+	 * protected by rtnl_lock
+	 */
+	int mtu_set_by_user;
+
+	/**
 	 * @bat_counters: mesh internal traffic statistic counters (see
 	 *  batadv_counters)
 	 */


