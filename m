Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B4A7D3326
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjJWL1O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjJWL1I (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:27:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C71E8
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:27:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F5FC433C9;
        Mon, 23 Oct 2023 11:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060425;
        bh=t3Wws8ZYVJFvTeZPovTn3az2Ic1kmzgjLQtl9WsG7x4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fOFHg4tJhdfSB3FYFtF7dTU4/4j6UgHNiTrjrfxeBFqrNSQXUC2LNAGmfj1K0vVxw
         saK3enFD1TBXDuUEhUtOd6PvnZ7wSc1QISKP4/IyBffGwZdUc5oaFJoH/dktu6/sVs
         +8U79tPgkYp9uFTQijFDCWCTzbpJhmnhGbyJc8NY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Eric Dumazet <edumazet@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 140/196] tcp_bpf: properly release resources on error paths
Date:   Mon, 23 Oct 2023 12:56:45 +0200
Message-ID: <20231023104832.442045242@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 68b54aeff804acceb02f228ea2e28419272c1fb9 ]

In the blamed commit below, I completely forgot to release the acquired
resources before erroring out in the TCP BPF code, as reported by Dan.

Address the issues by replacing the bogus return with a jump to the
relevant cleanup code.

Fixes: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads are waiting")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/r/8f99194c698bcef12666f0a9a999c58f8b1cb52c.1697557782.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_bpf.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cb4549db8bcfc..f8037d142bb75 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -302,8 +302,10 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		}
 
 		data = tcp_msg_wait_data(sk, psock, timeo);
-		if (data < 0)
-			return data;
+		if (data < 0) {
+			copied = data;
+			goto unlock;
+		}
 		if (data && !sk_psock_queue_empty(psock))
 			goto msg_bytes_ready;
 		copied = -EAGAIN;
@@ -314,6 +316,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	tcp_rcv_space_adjust(sk);
 	if (copied > 0)
 		__tcp_cleanup_rbuf(sk, copied);
+
+unlock:
 	release_sock(sk);
 	sk_psock_put(sk, psock);
 	return copied;
@@ -348,8 +352,10 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 		data = tcp_msg_wait_data(sk, psock, timeo);
-		if (data < 0)
-			return data;
+		if (data < 0) {
+			ret = data;
+			goto unlock;
+		}
 		if (data) {
 			if (!sk_psock_queue_empty(psock))
 				goto msg_bytes_ready;
@@ -360,6 +366,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		copied = -EAGAIN;
 	}
 	ret = copied;
+
+unlock:
 	release_sock(sk);
 	sk_psock_put(sk, psock);
 	return ret;
-- 
2.40.1



