Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C28D7D31EE
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjJWLOw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjJWLOw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:14:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A767DD
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:14:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD8AC433C9;
        Mon, 23 Oct 2023 11:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059689;
        bh=xBkJaE+Om76tVCcpYMSGsR9Zdh4UgEZW8zB+l6UT/UY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQeMg3NGNlKUoTaTX7o2YDqbRgAMrlF/PlxAA5kESEpTvZfWS5fva1SKoid+QdvSL
         NLvdKPbnhPWIAwbeM06AoTH9uIK8yAN0EF4B1yGNM3TccvZp/7ejUzqOP/ebbtqEEF
         utPvuxa4+n0sTD4aXzd9sh3JEfnpQ3+GB9qnbvX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 02/98] net: use indirect calls helpers at the socket layer
Date:   Mon, 23 Oct 2023 12:55:51 +0200
Message-ID: <20231023104813.672778736@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104813.580375891@linuxfoundation.org>
References: <20231023104813.580375891@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 8c3c447b3cec27cf6f77080f4d157d53b64e9555 ]

This avoids an indirect call per {send,recv}msg syscall in
the common (IPv6 or IPv4 socket) case.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 86a7e0b69bd5 ("net: prevent rewrite of msg_name in sock_sendmsg()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/socket.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index db9d908198f21..dc4d4ecd6cea2 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -90,6 +90,7 @@
 #include <linux/slab.h>
 #include <linux/xattr.h>
 #include <linux/nospec.h>
+#include <linux/indirect_call_wrapper.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -108,6 +109,13 @@
 #include <net/busy_poll.h>
 #include <linux/errqueue.h>
 
+/* proto_ops for ipv4 and ipv6 use the same {recv,send}msg function */
+#if IS_ENABLED(CONFIG_INET)
+#define INDIRECT_CALL_INET4(f, f1, ...) INDIRECT_CALL_1(f, f1, __VA_ARGS__)
+#else
+#define INDIRECT_CALL_INET4(f, f1, ...) f(__VA_ARGS__)
+#endif
+
 #ifdef CONFIG_NET_RX_BUSY_POLL
 unsigned int sysctl_net_busy_read __read_mostly;
 unsigned int sysctl_net_busy_poll __read_mostly;
@@ -645,10 +653,12 @@ EXPORT_SYMBOL(__sock_tx_timestamp);
  *	Sends @msg through @sock, passing through LSM.
  *	Returns the number of bytes sent, or an error code.
  */
-
+INDIRECT_CALLABLE_DECLARE(int inet_sendmsg(struct socket *, struct msghdr *,
+					   size_t));
 static inline int sock_sendmsg_nosec(struct socket *sock, struct msghdr *msg)
 {
-	int ret = sock->ops->sendmsg(sock, msg, msg_data_left(msg));
+	int ret = INDIRECT_CALL_INET4(sock->ops->sendmsg, inet_sendmsg, sock,
+				      msg, msg_data_left(msg));
 	BUG_ON(ret == -EIOCBQUEUED);
 	return ret;
 }
@@ -852,11 +862,13 @@ EXPORT_SYMBOL_GPL(__sock_recv_ts_and_drops);
  *	Receives @msg from @sock, passing through LSM. Returns the total number
  *	of bytes received, or an error.
  */
-
+INDIRECT_CALLABLE_DECLARE(int inet_recvmsg(struct socket *, struct msghdr *,
+					   size_t , int ));
 static inline int sock_recvmsg_nosec(struct socket *sock, struct msghdr *msg,
 				     int flags)
 {
-	return sock->ops->recvmsg(sock, msg, msg_data_left(msg), flags);
+	return INDIRECT_CALL_INET4(sock->ops->recvmsg, inet_recvmsg, sock, msg,
+				   msg_data_left(msg), flags);
 }
 
 int sock_recvmsg(struct socket *sock, struct msghdr *msg, int flags)
-- 
2.40.1



