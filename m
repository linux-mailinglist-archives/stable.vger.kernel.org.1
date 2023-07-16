Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E837551BD
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGPT7q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjGPT7p (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:59:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC7E1B9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:59:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FE2F60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FCEC433C8;
        Sun, 16 Jul 2023 19:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537582;
        bh=MfCGnfutks5Lvll2yVjRrb1WAy0uTa5zKSZ1/VDgM9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=026oryvR3+2rxwbpbsxzZTXMYlJ1hM2ENss81P1OLZ+kgaucQdMYY2HmdRR7xCzsx
         6caaQaGAdbOM36WQqMeTf85ag+rXHXYEk82e+Z7PYD+LiicUw8GXZHiirmbMIoz56r
         oaBMFgvVCR6J45RNJdoky0/VCfdNzM/tP6g3TVBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kacinski <kuba@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 118/800] net/handshake: Unpin sock->file if a handshake is cancelled
Date:   Sun, 16 Jul 2023 21:39:31 +0200
Message-ID: <20230716194951.848894569@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit f921bd41001ccff2249f5f443f2917f7ef937daf ]

If user space never calls DONE, sock->file's reference count remains
elevated. Enable sock->file to be freed eventually in this case.

Reported-by: Jakub Kacinski <kuba@kernel.org>
Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/handshake/handshake.h | 1 +
 net/handshake/request.c   | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index 4dac965c99df0..8aeaadca844fd 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -31,6 +31,7 @@ struct handshake_req {
 	struct list_head		hr_list;
 	struct rhash_head		hr_rhash;
 	unsigned long			hr_flags;
+	struct file			*hr_file;
 	const struct handshake_proto	*hr_proto;
 	struct sock			*hr_sk;
 	void				(*hr_odestruct)(struct sock *sk);
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 94d5cef3e048b..d78d41abb3d99 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -239,6 +239,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 	}
 	req->hr_odestruct = req->hr_sk->sk_destruct;
 	req->hr_sk->sk_destruct = handshake_sk_destruct;
+	req->hr_file = sock->file;
 
 	ret = -EOPNOTSUPP;
 	net = sock_net(req->hr_sk);
@@ -334,6 +335,9 @@ bool handshake_req_cancel(struct sock *sk)
 		return false;
 	}
 
+	/* Request accepted and waiting for DONE */
+	fput(req->hr_file);
+
 out_true:
 	trace_handshake_cancel(net, req, sk);
 
-- 
2.39.2



