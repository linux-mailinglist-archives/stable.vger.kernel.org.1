Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D5D7AA5C5
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 01:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjIUXrB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 19:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUXrA (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 19:47:00 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04B68F
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 16:46:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59eb7293017so20991047b3.3
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 16:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695340014; x=1695944814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4feA2KEt0DR8/ZntIptdaN+Nf2Xctc39CYmdwvzveQ=;
        b=q2t9xWPozTKADkWEAWJekLY7O+k7faBcaszc2tIW16CbjgV0phE/afPI5zBWnPmsf+
         fVPNe7u7Am5D2ecAWvp/6olQHsjTsdl8zGGH1TN+z7uksONrmk/8dLojm5lOOlfbY/Fe
         ay8vki60c3lEOJ/MHJoy1ln0b4llIirX9Q43MB08lhPaagAsITbi55gwJp2QkrD2lNle
         Cg7r8tpPnCGzlZk2f3l9FbG70inetFcSfJt6Q5iCpVkPKU1mQjm2hnDzRjebjpApDBnx
         l6jaB6nVqwxt9geOkeSGMuVAlJrGWfFNQgO+C4NZNTMhQXZQoRZ4HYIOjwRg5QCNvRmL
         PGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695340014; x=1695944814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4feA2KEt0DR8/ZntIptdaN+Nf2Xctc39CYmdwvzveQ=;
        b=TFTrK9/S+wcBgKxDvFwVasPoUS3xYTK1AKS6AugX6HezyWcTVkWsUjQJywvMmghY1H
         UrvAEYFUdKHyjlMouttTjsyNEVMbHVFNo++/ycp+96eZ90gKT0J6/zNnnwtPDKSOfGhK
         3Sgh6vYRhsd7Km7zQnir67po8bbIj6rK1z8Cpx8yIJMViOhxKa94hQ5OEwDvayi3xRuJ
         R0H4jwicwFaptVpH4Zdf4CFnnMzfOc1qwHpKZxrDez2OKXtyWcV0j1GbNDiTadmBbC1Y
         xYBGc4+ML4gsRDU/lTSybkDmngYoHovOCiBSs7impGN0BV4/h9vmgzxD0jPDTGQ4kmQ7
         OSaQ==
X-Gm-Message-State: AOJu0Yw30jcMFeDHyJt++giImqe1AEPNDbtEnfO6bRK6ra1wqptKKxqC
        ZKW5ve0D7wFGemk96JsIoruQq4bqoQ==
X-Google-Smtp-Source: AGHT+IHj+sOKndZXgtZwEdckrqs5Wz6uZ24eW94jK1vzUIXgO2mzYWsC2EHjLnKJIlW4rAtfSV5E4uGlVw==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:f826:0:b0:d80:2650:57fa with SMTP id
 u38-20020a25f826000000b00d80265057famr89621ybd.8.1695340013808; Thu, 21 Sep
 2023 16:46:53 -0700 (PDT)
Date:   Thu, 21 Sep 2023 18:46:42 -0500
In-Reply-To: <20230921234642.1111903-1-jrife@google.com>
Mime-Version: 1.0
References: <20230921234642.1111903-1-jrife@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921234642.1111903-3-jrife@google.com>
Subject: [PATCH net v5 3/3] net: prevent address rewrite in kernel_bind()
From:   Jordan Rife <jrife@google.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        netdev@vger.kernel.org
Cc:     dborkman@kernel.org, horms@verge.net.au, pablo@netfilter.org,
        kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com,
        ast@kernel.org, rdna@fb.com, Jordan Rife <jrife@google.com>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
---
v4->v5: Remove non-net changes.
v3->v4: Remove precondition check for addrlen. Pass address copy to
        bind() instead of original address.
v2->v3: Add "Fixes" tag. Check for positivity in addrlen sanity check.
v1->v2: Split up original patch into patch series. Insulate
        sock->ops->bind() calls with kernel_bind().

 net/netfilter/ipvs/ip_vs_sync.c | 4 ++--
 net/rds/tcp_connect.c           | 2 +-
 net/rds/tcp_listen.c            | 2 +-
 net/socket.c                    | 7 ++++++-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 6e4ed1e11a3b7..4174076c66fa7 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1439,7 +1439,7 @@ static int bind_mcastif_addr(struct socket *sock, struct net_device *dev)
 	sin.sin_addr.s_addr  = addr;
 	sin.sin_port         = 0;
 
-	return sock->ops->bind(sock, (struct sockaddr*)&sin, sizeof(sin));
+	return kernel_bind(sock, (struct sockaddr *)&sin, sizeof(sin));
 }
 
 static void get_mcast_sockaddr(union ipvs_sockaddr *sa, int *salen,
@@ -1546,7 +1546,7 @@ static int make_receive_sock(struct netns_ipvs *ipvs, int id,
 
 	get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->bcfg, id);
 	sock->sk->sk_bound_dev_if = dev->ifindex;
-	result = sock->ops->bind(sock, (struct sockaddr *)&mcast_addr, salen);
+	result = kernel_bind(sock, (struct sockaddr *)&mcast_addr, salen);
 	if (result < 0) {
 		pr_err("Error binding to the multicast addr\n");
 		goto error;
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index d788c6d28986f..a0046e99d6df7 100644
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
index a39ec136f5cff..c4a6f55329552 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3516,7 +3516,12 @@ static long compat_sock_ioctl(struct file *file, unsigned int cmd,
 
 int kernel_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 {
-	return READ_ONCE(sock->ops)->bind(sock, addr, addrlen);
+	struct sockaddr_storage address;
+
+	memcpy(&address, addr, addrlen);
+
+	return READ_ONCE(sock->ops)->bind(sock, (struct sockaddr *)&address,
+					  addrlen);
 }
 EXPORT_SYMBOL(kernel_bind);
 
-- 
2.42.0.515.g380fc7ccd1-goog

