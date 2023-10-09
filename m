Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF927BE0FA
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377483AbjJINqG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377525AbjJINpq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:45:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9A111D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:45:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B30C433C7;
        Mon,  9 Oct 2023 13:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859133;
        bh=R/7Nl9E5fzaxNMaOjNbWN5SiiYpXPjkG37u8gXzetYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A73dgiJq7uAiHApDWxbjU8SLXuCsU5IJbse5auzEZSv6N0bGMSxPf4zW8ZlU7eIho
         EWnoNQyGAZBo04DqD6XQogjpKlXwWcRmNRdjAuoyic5gTXKKZLDC7iLa5tfT7Xtm4r
         kp62dpfVOZuAsVIdaN17HFXuS1LB1su5Ng+xcGEc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Willem de Bruijn <willemb@google.com>,
        Jordan Rife <jrife@google.com>,
        Simon Horman <horms@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.10 182/226] net: replace calls to sock->ops->connect() with kernel_connect()
Date:   Mon,  9 Oct 2023 15:02:23 +0200
Message-ID: <20231009130131.390062750@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jordan Rife <jrife@google.com>

commit 26297b4ce1ce4ea40bc9a48ec99f45da3f64d2e2 upstream.

commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect")
ensured that kernel_connect() will not overwrite the address parameter
in cases where BPF connect hooks perform an address rewrite. This change
replaces direct calls to sock->ops->connect() in net with kernel_connect()
to make these call safe.

Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
Cc: stable@vger.kernel.org
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jordan Rife <jrife@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/ipvs/ip_vs_sync.c |    4 ++--
 net/rds/tcp_connect.c           |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1507,8 +1507,8 @@ static int make_send_sock(struct netns_i
 	}
 
 	get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->mcfg, id);
-	result = sock->ops->connect(sock, (struct sockaddr *) &mcast_addr,
-				    salen, 0);
+	result = kernel_connect(sock, (struct sockaddr *)&mcast_addr,
+				salen, 0);
 	if (result < 0) {
 		pr_err("Error connecting to the multicast addr\n");
 		goto error;
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -169,7 +169,7 @@ int rds_tcp_conn_path_connect(struct rds
 	 * own the socket
 	 */
 	rds_tcp_set_callbacks(sock, cp);
-	ret = sock->ops->connect(sock, addr, addrlen, O_NONBLOCK);
+	ret = kernel_connect(sock, addr, addrlen, O_NONBLOCK);
 
 	rdsdebug("connect to address %pI6c returned %d\n", &conn->c_faddr, ret);
 	if (ret == -EINPROGRESS)


