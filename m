Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE338735216
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjFSKaW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjFSKaV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8894EC6
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E00F60A50
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFE4C433CB;
        Mon, 19 Jun 2023 10:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170619;
        bh=7SZpRBOPuEVYE2QmaYt4jJ9GIL8+s98F+KMoarjT3RY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCtY+bLfCmVOFc4PpYl4pQ3wOqeJSVcPM15Qrg1wLkeTDFVxmYtUC4hTN4qUuhkZC
         BV+yn4OmOOxl5lDMqioPFU7XxuJWl95L/NQUbP1aE0pybkFfdj8hCVDWdDfSx6l37v
         2l0WaHb6N1Y3bMJPdwN1lenzI7vSjvIShMFbgDPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Guillaume Nault <gnault@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 19/32] ping6: Fix send to link-local addresses with VRF.
Date:   Mon, 19 Jun 2023 12:29:07 +0200
Message-ID: <20230619102128.553797160@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102127.461443957@linuxfoundation.org>
References: <20230619102127.461443957@linuxfoundation.org>
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

From: Guillaume Nault <gnault@redhat.com>

[ Upstream commit 91ffd1bae1dafbb9e34b46813f5b058581d9144d ]

Ping sockets can't send packets when they're bound to a VRF master
device and the output interface is set to a slave device.

For example, when net.ipv4.ping_group_range is properly set, so that
ping6 can use ping sockets, the following kind of commands fails:
  $ ip vrf exec red ping6 fe80::854:e7ff:fe88:4bf1%eth1

What happens is that sk->sk_bound_dev_if is set to the VRF master
device, but 'oif' is set to the real output device. Since both are set
but different, ping_v6_sendmsg() sees their value as inconsistent and
fails.

Fix this by allowing 'oif' to be a slave device of ->sk_bound_dev_if.

This fixes the following kselftest failure:
  $ ./fcnal-test.sh -t ipv6_ping
  [...]
  TEST: ping out, vrf device+address bind - ns-B IPv6 LLA        [FAIL]

Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/b6191f90-ffca-dbca-7d06-88a9788def9c@alu.unizg.hr/
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Fixes: 5e457896986e ("net: ipv6: Fix ping to link-local addresses.")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://lore.kernel.org/r/6c8b53108816a8d0d5705ae37bdc5a8322b5e3d9.1686153846.git.gnault@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index d5cdba8213a44..49e11bbf390cf 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -101,7 +101,8 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	addr_type = ipv6_addr_type(daddr);
 	if ((__ipv6_addr_needs_scope_id(addr_type) && !oif) ||
 	    (addr_type & IPV6_ADDR_MAPPED) ||
-	    (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if))
+	    (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if &&
+	     l3mdev_master_ifindex_by_index(sock_net(sk), oif) != sk->sk_bound_dev_if))
 		return -EINVAL;
 
 	/* TODO: use ip6_datagram_send_ctl to get options from cmsg */
-- 
2.39.2



