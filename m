Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEB27CE645
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 20:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjJRSYH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 14:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjJRSYF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 14:24:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6015112
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 11:24:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FE9C4339A;
        Wed, 18 Oct 2023 18:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697653443;
        bh=wgF2DRUgasKE34DdDKzqsvEchHtBI9vBd4zl65+aas4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hGXSAj+hDhRJ2xW5fbYQtHKdrdPH2NJpj+IKM280SZr8gaG3SMx1BW5XnELvZhu3r
         RRrGvZAU/+j+FnCNqYVgAJJXGm5nUv/Dc2GIaRjSMKtOcTgARHYcXL8IIUMfzy8TS8
         utjSM40Nm4A2KBnno6frI6VGGgH+4nskbyUUEDEq/DsQ1WhhGKIuuG+eR6UH43ZI0G
         fwyMLPiDIigXkzMGm2n4nPcL86KxGwWdE4QPWE79yEjNwnu5wJKj6+L7QyaqX2lyoQ
         OjtlmADwbXa4ZXK7StjClbds33++twH1u9COGidRGDhn2+Q1iQHtUuP0O50z4FfvkA
         rzURdCZgx/8UQ==
From:   Mat Martineau <martineau@kernel.org>
Date:   Wed, 18 Oct 2023 11:23:53 -0700
Subject: [PATCH net 2/5] tcp: check mptcp-level constraints for backlog
 coalescing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-send-net-20231018-v1-2-17ecb002e41d@kernel.org>
References: <20231018-send-net-20231018-v1-0-17ecb002e41d@kernel.org>
In-Reply-To: <20231018-send-net-20231018-v1-0-17ecb002e41d@kernel.org>
To:     Matthieu Baerts <matttbe@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Davide Caratti <dcaratti@redhat.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, mptcp@lists.linux.dev,
        Mat Martineau <martineau@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP protocol can acquire the subflow-level socket lock and
cause the tcp backlog usage. When inserting new skbs into the
backlog, the stack will try to coalesce them.

Currently, we have no check in place to ensure that such coalescing
will respect the MPTCP-level DSS, and that may cause data stream
corruption, as reported by Christoph.

Address the issue by adding the relevant admission check for coalescing
in tcp_add_backlog().

Note the issue is not easy to reproduce, as the MPTCP protocol tries
hard to avoid acquiring the subflow-level socket lock.

Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/420
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/ipv4/tcp_ipv4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 27140e5cdc06..4167e8a48b60 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1869,6 +1869,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 #ifdef CONFIG_TLS_DEVICE
 	    tail->decrypted != skb->decrypted ||
 #endif
+	    !mptcp_skb_can_collapse(tail, skb) ||
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
 		goto no_coalesce;

-- 
2.41.0

