Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D0970C5E1
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjEVTNK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjEVTNJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:13:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9C8129
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:13:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AECC626FF
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24639C433D2;
        Mon, 22 May 2023 19:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684782783;
        bh=Af0K9tTI4FM2AI1k/cHxUo0GFsKprbtakhGYgol+xQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/raNy8T1McIREL+rS9pYR96W4wt/cG06Ubh5gwQ4xN6QtVzq74A7tqcovx2OEfYN
         wvjKefcqYt87vnD6aN5bUNBC+Q5mjaaosi5X3IkuPKj9cUAFAysEfSJ1AVtC1YyeB5
         M0njTI6seM3xlkT4xLCmA6mRD02DqTQ5pUkK0JoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 019/203] net: datagram: fix data-races in datagram_poll()
Date:   Mon, 22 May 2023 20:07:23 +0100
Message-Id: <20230522190355.483808827@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5bca1d081f44c9443e61841842ce4e9179d327b6 ]

datagram_poll() runs locklessly, we should add READ_ONCE()
annotations while reading sk->sk_err, sk->sk_shutdown and sk->sk_state.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20230509173131.3263780-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/datagram.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index 28e5f921dcaf4..1ff8241217a9c 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -799,18 +799,21 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
 {
 	struct sock *sk = sock->sk;
 	__poll_t mask;
+	u8 shutdown;
 
 	sock_poll_wait(file, sock, wait);
 	mask = 0;
 
 	/* exceptional events? */
-	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
+	if (READ_ONCE(sk->sk_err) ||
+	    !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR |
 			(sock_flag(sk, SOCK_SELECT_ERR_QUEUE) ? EPOLLPRI : 0);
 
-	if (sk->sk_shutdown & RCV_SHUTDOWN)
+	shutdown = READ_ONCE(sk->sk_shutdown);
+	if (shutdown & RCV_SHUTDOWN)
 		mask |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
-	if (sk->sk_shutdown == SHUTDOWN_MASK)
+	if (shutdown == SHUTDOWN_MASK)
 		mask |= EPOLLHUP;
 
 	/* readable? */
@@ -819,10 +822,12 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
 
 	/* Connection-based need to check for termination and startup */
 	if (connection_based(sk)) {
-		if (sk->sk_state == TCP_CLOSE)
+		int state = READ_ONCE(sk->sk_state);
+
+		if (state == TCP_CLOSE)
 			mask |= EPOLLHUP;
 		/* connection hasn't started yet? */
-		if (sk->sk_state == TCP_SYN_SENT)
+		if (state == TCP_SYN_SENT)
 			return mask;
 	}
 
-- 
2.39.2



