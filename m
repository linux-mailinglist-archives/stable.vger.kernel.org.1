Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D8D7DD53E
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376488AbjJaRsg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376510AbjJaRsb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:48:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCFAEA
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:48:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90876C433CC;
        Tue, 31 Oct 2023 17:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774507;
        bh=xrROycKAnd/qnrxWLF0cMljlGK1iYmbbv1hB7B33zvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EoGPup/UL2qoT7S5EhoeLPXLMWRcV5uzscJC2JNvcWuArI8xZHaXJa5Eo6OjG+l7y
         yf8krrNv4h/kAevN+oC0gkNJze6h0ysVj0US8aVJVyFYKMV92qaFOdveQXmuESsVJ9
         Dq6fIxqielmBnlDmrZ0zbpUGsnW0HY6+bGXSR6Zc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Moritz=20Wanzenb=C3=B6ck?= 
        <moritz.wanzenboeck@linbit.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 070/112] net/handshake: fix file ref count in handshake_nl_accept_doit()
Date:   Tue, 31 Oct 2023 18:01:11 +0100
Message-ID: <20231031165903.522946684@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moritz Wanzenböck <moritz.wanzenboeck@linbit.com>

[ Upstream commit 7798b59409c345d4a6034a4326bceb9f7e2e8b58 ]

If req->hr_proto->hp_accept() fail, we call fput() twice:
Once in the error path, but also a second time because sock->file
is at that point already associated with the file descriptor. Once
the task exits, as it would probably do after receiving an error
reading from netlink, the fd is closed, calling fput() a second time.

To fix, we move installing the file after the error path for the
hp_accept() call. In the case of errors we simply put the unused fd.
In case of success we can use fd_install() to link the sock->file
to the reserved fd.

Fixes: 7ea9c1ec66bc ("net/handshake: Fix handshake_dup() ref counting")
Signed-off-by: Moritz Wanzenböck <moritz.wanzenboeck@linbit.com>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/r/20231019125847.276443-1-moritz.wanzenboeck@linbit.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/handshake/netlink.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index d0bc1dd8e65a8..80c7302692c74 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -87,29 +87,6 @@ struct nlmsghdr *handshake_genl_put(struct sk_buff *msg,
 }
 EXPORT_SYMBOL(handshake_genl_put);
 
-/*
- * dup() a kernel socket for use as a user space file descriptor
- * in the current process. The kernel socket must have an
- * instatiated struct file.
- *
- * Implicit argument: "current()"
- */
-static int handshake_dup(struct socket *sock)
-{
-	struct file *file;
-	int newfd;
-
-	file = get_file(sock->file);
-	newfd = get_unused_fd_flags(O_CLOEXEC);
-	if (newfd < 0) {
-		fput(file);
-		return newfd;
-	}
-
-	fd_install(newfd, file);
-	return newfd;
-}
-
 int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net *net = sock_net(skb->sk);
@@ -133,17 +110,20 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out_status;
 
 	sock = req->hr_sk->sk_socket;
-	fd = handshake_dup(sock);
+	fd = get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0) {
 		err = fd;
 		goto out_complete;
 	}
+
 	err = req->hr_proto->hp_accept(req, info, fd);
 	if (err) {
-		fput(sock->file);
+		put_unused_fd(fd);
 		goto out_complete;
 	}
 
+	fd_install(fd, get_file(sock->file));
+
 	trace_handshake_cmd_accept(net, req, req->hr_sk, fd);
 	return 0;
 
-- 
2.42.0



