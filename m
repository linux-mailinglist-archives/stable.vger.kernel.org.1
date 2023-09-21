Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360727AA5C3
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 01:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjIUXq5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 21 Sep 2023 19:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUXq4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 21 Sep 2023 19:46:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3635A8F
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 16:46:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d816fa2404aso2295690276.0
        for <stable@vger.kernel.org>; Thu, 21 Sep 2023 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695340009; x=1695944809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2po5KMytqzs1aZq0Zn6CcoUcUJMoRpPcm+1a082rpbc=;
        b=L/6izN30+9ujTWwjQIFXlwmlA7h/L0AL6UFtjg7BJce1bZdjmHUNukVhKwiZNjRHEi
         5iMln9MYk6EvHYhcgPzCG6/HLF7yWV4VMcxFQjGO0I/IiSPs7nn6ujx0K5BCh04zjPIA
         eWuVNXd4QAxO6L5WD08O9Kphin5YSrbNOX2bULH0Ha80ra2a35JFOHlSG9MeGu+bbUsX
         h1Ck5Nv4mnjgfe+L4mBbQLABSlkzj4TV6D1noyjoY/Tya6QSJz7GyaufkhcjoWNpX4vn
         Qn4Lz8YHJ/f+cwJFcgdy3/N91uV9iCYr9oao2p64fvgMMwXKLNUCjkSqjEUNK4slcL+r
         Hr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695340009; x=1695944809;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2po5KMytqzs1aZq0Zn6CcoUcUJMoRpPcm+1a082rpbc=;
        b=l4WMGw+5l+C4Z83OWNVf1+3zlaAyxTKCaY5t6yrxdCiBj9VVRgbAG6nLAhobyEuyGA
         sYt0gyhmGjxBaHQkZQwnUNZlj/+PDLZqfvIqKW51gU7PxOfahSQvujkXZCtwPcNEjz/w
         9a0Lr5FHZdaFK16D9mbnUkiarXGAZojv6Q6PkzzRAxydNzjhd9jYntHuvgyywXu63WHv
         hSX4F3F9DHARLZel71YdKVZuxw9rRRJ2mjTQWOhEjsNKMiizVx+huBOcsuA8desyzNQB
         x5tjGhmsR91ox/uekJWstbrUZ8ebIpsEzMrY8p6e8W6ECtTKrw8SvONZ0FZxsprd3gRN
         XWjA==
X-Gm-Message-State: AOJu0Yx7rCqsr6gROl8aGVRoiE3OTgMj4G/eApathgrvW+NnoH8jricv
        XFStj1nBUUFGgUkA193lkUIX6Ed5zQ==
X-Google-Smtp-Source: AGHT+IF1RdaT9gzc+LmBDDlflKDiJNFtWmEg1sp6goIT3q1y18gaTPqpGUvLDbhLN4VUn9B+GeHsxh/Kzw==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6902:100c:b0:d40:932e:f7b1 with SMTP id
 w12-20020a056902100c00b00d40932ef7b1mr117253ybt.7.1695340009466; Thu, 21 Sep
 2023 16:46:49 -0700 (PDT)
Date:   Thu, 21 Sep 2023 18:46:40 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921234642.1111903-1-jrife@google.com>
Subject: [PATCH net v5 1/3] net: replace calls to sock->ops->connect() with kernel_connect()
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
---
v4->v5: Remove non-net changes.
v3->v4: Remove precondition check for addrlen.
v2->v3: Add "Fixes" tag. Check for positivity in addrlen sanity check.
v1->v2: Split up original patch into patch series. Insulate calls with
        kernel_connect() instead of pushing address copy deeper into
        sock->ops->connect().

 net/netfilter/ipvs/ip_vs_sync.c | 4 ++--
 net/rds/tcp_connect.c           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index da5af28ff57b5..6e4ed1e11a3b7 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1505,8 +1505,8 @@ static int make_send_sock(struct netns_ipvs *ipvs, int id,
 	}
 
 	get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->mcfg, id);
-	result = sock->ops->connect(sock, (struct sockaddr *) &mcast_addr,
-				    salen, 0);
+	result = kernel_connect(sock, (struct sockaddr *)&mcast_addr,
+				salen, 0);
 	if (result < 0) {
 		pr_err("Error connecting to the multicast addr\n");
 		goto error;
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index f0c477c5d1db4..d788c6d28986f 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -173,7 +173,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 	 * own the socket
 	 */
 	rds_tcp_set_callbacks(sock, cp);
-	ret = sock->ops->connect(sock, addr, addrlen, O_NONBLOCK);
+	ret = kernel_connect(sock, addr, addrlen, O_NONBLOCK);
 
 	rdsdebug("connect to address %pI6c returned %d\n", &conn->c_faddr, ret);
 	if (ret == -EINPROGRESS)
-- 
2.42.0.515.g380fc7ccd1-goog

