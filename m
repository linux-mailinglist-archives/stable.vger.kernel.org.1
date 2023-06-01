Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FE2719E36
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbjFANaX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjFANaC (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:30:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583A2E47
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57C83644E8
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7629EC433D2;
        Thu,  1 Jun 2023 13:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626139;
        bh=gQX4XUar3UWHeN9dNE4GmrysgoMlMDVnpP29rl99bLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bHamcouEBPaGRyez4yn/dJd00I3aZc+W95/ynXeqkyCCqtbFnluJvEghZlCfsNqaX
         PzB+e4DZyy1C+uLzGwH0TVZECjnAYCqClGGuO23wdt02izCJ4r1CN2QZualCqUb6yd
         qHU6PINqDjbZN2q6vwyKugZ1ATLRtZYs2ZTriXLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 20/42] bpf, sockmap: Wake up polling after data copy
Date:   Thu,  1 Jun 2023 14:21:29 +0100
Message-Id: <20230601131939.941082244@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 6df7f764cd3cf5a03a4a47b23be47e57e41fcd85 ]

When TCP stack has data ready to read sk_data_ready() is called. Sockmap
overwrites this with its own handler to call into BPF verdict program.
But, the original TCP socket had sock_def_readable that would additionally
wake up any user space waiters with sk_wake_async().

Sockmap saved the callback when the socket was created so call the saved
data ready callback and then we can wake up any epoll() logic waiting
on the read.

Note we call on 'copied >= 0' to account for returning 0 when a FIN is
received because we need to wake up user for this as well so they
can do the recvmsg() -> 0 and detect the shutdown.

Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/20230523025618.113937-8-john.fastabend@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skmsg.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index d3ffca1b96462..062612ee508c0 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1196,10 +1196,19 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 static void sk_psock_verdict_data_ready(struct sock *sk)
 {
 	struct socket *sock = sk->sk_socket;
+	int copied;
 
 	if (unlikely(!sock || !sock->ops || !sock->ops->read_skb))
 		return;
-	sock->ops->read_skb(sk, sk_psock_verdict_recv);
+	copied = sock->ops->read_skb(sk, sk_psock_verdict_recv);
+	if (copied >= 0) {
+		struct sk_psock *psock;
+
+		rcu_read_lock();
+		psock = sk_psock(sk);
+		psock->saved_data_ready(sk);
+		rcu_read_unlock();
+	}
 }
 
 void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
-- 
2.39.2



