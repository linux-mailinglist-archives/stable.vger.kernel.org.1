Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1BC75D36D
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjGUTKc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjGUTKb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:10:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FF11BF4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:10:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F342661D02
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D763C433C7;
        Fri, 21 Jul 2023 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966629;
        bh=dKi6yeEg+AEVKwezsYdxwD7jHXbMT4mYBYn61WdLx1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=173jpOxs8w63nhoiYIGPjacS7YO2Oa1QSsE5f9oHpseCIiq8lO63Xc440Sfjnj/FA
         4wdTxlVfq3XpxZ5Z7cWwinARzHZt224jz0HkHnkUZYyp0KZH64APEWUven8oKotlsq
         wIhofaeQuf/LYxhi9gs74RwUoUE12ZIPHwwQ/2cE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Maxim Cournoyer <maxim.cournoyer@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 384/532] wireguard: netlink: send staged packets when setting initial private key
Date:   Fri, 21 Jul 2023 18:04:48 +0200
Message-ID: <20230721160635.308554887@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit f58d0a9b4c6a7a5199c3af967e43cc8b654604d4 upstream.

Packets bound for peers can queue up prior to the device private key
being set. For example, if persistent keepalive is set, a packet is
queued up to be sent as soon as the device comes up. However, if the
private key hasn't been set yet, the handshake message never sends, and
no timer is armed to retry, since that would be pointless.

But, if a user later sets a private key, the expectation is that those
queued packets, such as a persistent keepalive, are actually sent. So
adjust the configuration logic to account for this edge case, and add a
test case to make sure this works.

Maxim noticed this with a wg-quick(8) config to the tune of:

    [Interface]
    PostUp = wg set %i private-key somefile

    [Peer]
    PublicKey = ...
    Endpoint = ...
    PersistentKeepalive = 25

Here, the private key gets set after the device comes up using a PostUp
script, triggering the bug.

Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Cc: stable@vger.kernel.org
Reported-by: Maxim Cournoyer <maxim.cournoyer@gmail.com>
Tested-by: Maxim Cournoyer <maxim.cournoyer@gmail.com>
Link: https://lore.kernel.org/wireguard/87fs7xtqrv.fsf@gmail.com/
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireguard/netlink.c            |   14 ++++++++-----
 tools/testing/selftests/wireguard/netns.sh |   30 +++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 9 deletions(-)

--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -546,6 +546,7 @@ static int wg_set_device(struct sk_buff
 		u8 *private_key = nla_data(info->attrs[WGDEVICE_A_PRIVATE_KEY]);
 		u8 public_key[NOISE_PUBLIC_KEY_LEN];
 		struct wg_peer *peer, *temp;
+		bool send_staged_packets;
 
 		if (!crypto_memneq(wg->static_identity.static_private,
 				   private_key, NOISE_PUBLIC_KEY_LEN))
@@ -564,14 +565,17 @@ static int wg_set_device(struct sk_buff
 		}
 
 		down_write(&wg->static_identity.lock);
-		wg_noise_set_static_identity_private_key(&wg->static_identity,
-							 private_key);
-		list_for_each_entry_safe(peer, temp, &wg->peer_list,
-					 peer_list) {
+		send_staged_packets = !wg->static_identity.has_identity && netif_running(wg->dev);
+		wg_noise_set_static_identity_private_key(&wg->static_identity, private_key);
+		send_staged_packets = send_staged_packets && wg->static_identity.has_identity;
+
+		wg_cookie_checker_precompute_device_keys(&wg->cookie_checker);
+		list_for_each_entry_safe(peer, temp, &wg->peer_list, peer_list) {
 			wg_noise_precompute_static_static(peer);
 			wg_noise_expire_current_peer_keypairs(peer);
+			if (send_staged_packets)
+				wg_packet_send_staged_packets(peer);
 		}
-		wg_cookie_checker_precompute_device_keys(&wg->cookie_checker);
 		up_write(&wg->static_identity.lock);
 	}
 skip_set_private_key:
--- a/tools/testing/selftests/wireguard/netns.sh
+++ b/tools/testing/selftests/wireguard/netns.sh
@@ -502,10 +502,32 @@ n2 bash -c 'printf 0 > /proc/sys/net/ipv
 n1 ping -W 1 -c 1 192.168.241.2
 [[ $(n2 wg show wg0 endpoints) == "$pub1	10.0.0.3:1" ]]
 
-ip1 link del veth1
-ip1 link del veth3
-ip1 link del wg0
-ip2 link del wg0
+ip1 link del dev veth3
+ip1 link del dev wg0
+ip2 link del dev wg0
+
+# Make sure persistent keep alives are sent when an adapter comes up
+ip1 link add dev wg0 type wireguard
+n1 wg set wg0 private-key <(echo "$key1") peer "$pub2" endpoint 10.0.0.1:1 persistent-keepalive 1
+read _ _ tx_bytes < <(n1 wg show wg0 transfer)
+[[ $tx_bytes -eq 0 ]]
+ip1 link set dev wg0 up
+read _ _ tx_bytes < <(n1 wg show wg0 transfer)
+[[ $tx_bytes -gt 0 ]]
+ip1 link del dev wg0
+# This should also happen even if the private key is set later
+ip1 link add dev wg0 type wireguard
+n1 wg set wg0 peer "$pub2" endpoint 10.0.0.1:1 persistent-keepalive 1
+read _ _ tx_bytes < <(n1 wg show wg0 transfer)
+[[ $tx_bytes -eq 0 ]]
+ip1 link set dev wg0 up
+read _ _ tx_bytes < <(n1 wg show wg0 transfer)
+[[ $tx_bytes -eq 0 ]]
+n1 wg set wg0 private-key <(echo "$key1")
+read _ _ tx_bytes < <(n1 wg show wg0 transfer)
+[[ $tx_bytes -gt 0 ]]
+ip1 link del dev veth1
+ip1 link del dev wg0
 
 # We test that Netlink/IPC is working properly by doing things that usually cause split responses
 ip0 link add dev wg0 type wireguard


