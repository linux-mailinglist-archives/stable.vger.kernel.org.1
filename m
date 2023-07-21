Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF4875CD8D
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjGUQMs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjGUQMb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:12:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA03F421C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:12:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBBDF61D1D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE3CC433CB;
        Fri, 21 Jul 2023 16:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955926;
        bh=4xEtw08rc/2nHWBBHKlJLz2lOPBGeT06VfD0bBd/KSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RMTMCZm4qdrqe/6BPk/JQFXHnaKIBAjZX8Hq8fUmpmeR4TT3B0s7QMgbitmm2SfP1
         lCHUCgkmA8E4YnqSys+MKUmXvdOfZZmbICUt8VGsy9W5vjsMMDFiJDLZTBcmaY0xFR
         Ir+0rcNT9s/sXaMGoAQYTAo3IlowEx26lNLAM6LM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ivan Babrou <ivan@cloudflare.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 051/292] udp6: add a missing call into udp_fail_queue_rcv_skb tracepoint
Date:   Fri, 21 Jul 2023 18:02:40 +0200
Message-ID: <20230721160530.994492935@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ivan Babrou <ivan@cloudflare.com>

[ Upstream commit 8139dccd464aaee4a2c351506ff883733c6ca5a3 ]

The tracepoint has existed for 12 years, but it only covered udp
over the legacy IPv4 protocol. Having it enabled for udp6 removes
the unnecessary difference in error visibility.

Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
Fixes: 296f7ea75b45 ("udp: add tracepoints for queueing skb to rcvbuf")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/net-traces.c | 2 ++
 net/ipv6/udp.c        | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/core/net-traces.c b/net/core/net-traces.c
index 805b7385dd8da..6aef976bc1da2 100644
--- a/net/core/net-traces.c
+++ b/net/core/net-traces.c
@@ -63,4 +63,6 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(napi_poll);
 EXPORT_TRACEPOINT_SYMBOL_GPL(tcp_send_reset);
 EXPORT_TRACEPOINT_SYMBOL_GPL(tcp_bad_csum);
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(udp_fail_queue_rcv_skb);
+
 EXPORT_TRACEPOINT_SYMBOL_GPL(sk_data_ready);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index e5a337e6b9705..debb98fb23c0b 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -45,6 +45,7 @@
 #include <net/tcp_states.h>
 #include <net/ip6_checksum.h>
 #include <net/ip6_tunnel.h>
+#include <trace/events/udp.h>
 #include <net/xfrm.h>
 #include <net/inet_hashtables.h>
 #include <net/inet6_hashtables.h>
@@ -680,6 +681,7 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		}
 		UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 		kfree_skb_reason(skb, drop_reason);
+		trace_udp_fail_queue_rcv_skb(rc, sk);
 		return -1;
 	}
 
-- 
2.39.2



