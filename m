Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C77F7C5E64
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 22:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376336AbjJKU3G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 16:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376411AbjJKU3F (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 16:29:05 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F4E90
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 13:29:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7d261a84bso3581937b3.3
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 13:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697056143; x=1697660943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G4shVxFlqmVxL8s/BJobfR/ES1jqSASBpAdyPH+dBVg=;
        b=ElJmU9dRhD+snQthC36NHipTLfButlXFmHezX8dVUDd7PIELv52wbew8waZs0dyBQz
         g+7dM+WuJ/Gh7yGBFVZ5rKYxpJt/fDvgkooIF3DkOhjCPGfTBjpREvC9HzVzsTMFdglU
         oE1GuCr2KU9Ycdd7vOHZofiVqgdd3giDMB3hOarVOlgp96Q760mRXAzjn/7STrEesoa7
         gVXLAZlLQ1fq9egDfVzZg+7VXKtg/X2MrTYnpnhjtSb8oLq9Ej2ww5Nghbh/nSG5dyXt
         ayU6baUhTrwBs6uUPjLCVf2MmVJ50xvQEmVgNsPvh6tnkMiV2YJnmbw74gtN1uSkD/AK
         5FcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697056143; x=1697660943;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4shVxFlqmVxL8s/BJobfR/ES1jqSASBpAdyPH+dBVg=;
        b=jdRiNrqNBHSJ/Xww9ys/2zHm7ly9R5PO8Keecz/oZPQAC3sTrfrE6O6ZyEnO4QDbuQ
         sRksGlbRt5AtM+Xiz2mj6pLFm808oO6mM7HuoJzMf445AnF8nGBzeGefbovNmRBSY8wU
         fqVLQ5gOYajHk72/JRxZZMPJGiP/yszR5lC6p5eQfb69pMin284vKf8lpa+oktzmR3CF
         doasBk18tZz5FCLHWKsuU/FvoWR/cXtok3CZxcarKgJlqK1ArOlV//s3tR1ev8SLuciy
         WGEG+MYJ7Mq15t3XpTJJqX2LkXd/qTdJIRjAiGaXEN9yZawuBgE0miUDyPbpWguIXXBo
         mQJQ==
X-Gm-Message-State: AOJu0YzQxhAKTJiInO5kGEFKGPwQM2Mv2OG6157p3XgwU2VtzYZkYVuX
        POAUXDWMN2XYAgkwGcxRoG+IjVLB2Dwh35uKzxLkLlnOuZ8K9T/Nm61IdnjSU0C6MeHGUbSA9Gd
        bGP3KGZqP7aY0DG67wbXHeLV4E6aauNkXO260QxQT+/vUhw+wSbxQ8wMsgmQ=
X-Google-Smtp-Source: AGHT+IER8pLhMLfHgIdcRFyZ7bWxWZRUveRuSUDMnyxCu0vEvH5a7QSnSfln5y7dFRJ5NvFYGixHhkU8oQ==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:690c:fc6:b0:5a4:f657:3a19 with SMTP id
 dg6-20020a05690c0fc600b005a4f6573a19mr488193ywb.6.1697056143011; Wed, 11 Oct
 2023 13:29:03 -0700 (PDT)
Date:   Wed, 11 Oct 2023 15:28:50 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231011202849.3549727-2-jrife@google.com>
Subject: [PATCH] net: prevent address rewrite in kernel_bind()
From:   Jordan Rife <jrife@google.com>
To:     stable@vger.kernel.org
Cc:     Jordan Rife <jrife@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Simon Horman <horms@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit c889a99a21bf124c3db08d09df919f0eccc5ea4c upstream.

Fix merge conflicts, so this patch can be backported to 4.19+.

Similar to the change in commit 0bdf399342c5("net: Avoid address
overwrite in kernel_connect"), BPF hooks run on bind may rewrite the
address passed to kernel_bind(). This change

1) Makes a copy of the bind address in kernel_bind() to insulate
   callers.
2) Replaces direct calls to sock->ops->bind() in net with kernel_bind()

Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
Cc: stable@vger.kernel.org
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jordan Rife <jrife@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/netfilter/ipvs/ip_vs_sync.c | 4 ++--
 net/rds/tcp_connect.c           | 2 +-
 net/rds/tcp_listen.c            | 2 +-
 net/socket.c                    | 6 +++++-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 264f2f87a4376..bc7b71c9d28ab 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1441,7 +1441,7 @@ static int bind_mcastif_addr(struct socket *sock, struct net_device *dev)
 	sin.sin_addr.s_addr  = addr;
 	sin.sin_port         = 0;
 
-	return sock->ops->bind(sock, (struct sockaddr*)&sin, sizeof(sin));
+	return kernel_bind(sock, (struct sockaddr *)&sin, sizeof(sin));
 }
 
 static void get_mcast_sockaddr(union ipvs_sockaddr *sa, int *salen,
@@ -1548,7 +1548,7 @@ static int make_receive_sock(struct netns_ipvs *ipvs, int id,
 
 	get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->bcfg, id);
 	sock->sk->sk_bound_dev_if = dev->ifindex;
-	result = sock->ops->bind(sock, (struct sockaddr *)&mcast_addr, salen);
+	result = kernel_bind(sock, (struct sockaddr *)&mcast_addr, salen);
 	if (result < 0) {
 		pr_err("Error binding to the multicast addr\n");
 		goto error;
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index f0c477c5d1db4..5cf227472272e 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -145,7 +145,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 		addrlen = sizeof(sin);
 	}
 
-	ret = sock->ops->bind(sock, addr, addrlen);
+	ret = kernel_bind(sock, addr, addrlen);
 	if (ret) {
 		rdsdebug("bind failed with %d at address %pI6c\n",
 			 ret, &conn->c_laddr);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 014fa24418c12..53b3535a1e4a8 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -306,7 +306,7 @@ struct socket *rds_tcp_listen_init(struct net *net, bool isv6)
 		addr_len = sizeof(*sin);
 	}
 
-	ret = sock->ops->bind(sock, (struct sockaddr *)&ss, addr_len);
+	ret = kernel_bind(sock, (struct sockaddr *)&ss, addr_len);
 	if (ret < 0) {
 		rdsdebug("could not bind %s listener socket: %d\n",
 			 isv6 ? "IPv6" : "IPv4", ret);
diff --git a/net/socket.c b/net/socket.c
index b5639a6500158..9bbc061688d28 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3450,7 +3450,11 @@ static long compat_sock_ioctl(struct file *file, unsigned int cmd,
 
 int kernel_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 {
-	return sock->ops->bind(sock, addr, addrlen);
+	struct sockaddr_storage address;
+
+	memcpy(&address, addr, addrlen);
+
+	return sock->ops->bind(sock, (struct sockaddr *)&address, addrlen);
 }
 EXPORT_SYMBOL(kernel_bind);
 
-- 
2.42.0.609.gbb76f46606-goog

