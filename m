Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1ED7A6A3E
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 19:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjISRxq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 13:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjISRxp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 13:53:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5766E8F
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 10:53:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7fd4c23315so6062610276.2
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 10:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695146017; x=1695750817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3dakH73oFSBXTdrwI4+ZlSgXIWNyYAr3KMqRH086qXw=;
        b=w6a/HtK/Ks2hddiaHR961dWnQvKviSd1XOTr19x1mvpAODE/Nc46lyivg/wei9pUc8
         IMzI8bGjsWDNeeKNv6J155PlM1MLqMsgLAMCjAzQdM5d4wVKqV4BvFMMxNYEDW9f5tIF
         gYVIf1tLJzRyRYBE6XqA/pBCaWcILRyF1W84fQ5gFSIpb0af8SAZgOpLiF48WhJt7fjP
         KoKwXmXSIkf+Ip4LbklsEIAYvG3P7qwTYDcLa3Hnh4fT2GqkDbbhG9xQugDyGWFaoQOr
         VJaohi104suCx4I0Le2hckpaMLJszDxqhMaHx1vHZHsNHpaTjc3YabbujHHOjClfiTaD
         a8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695146017; x=1695750817;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3dakH73oFSBXTdrwI4+ZlSgXIWNyYAr3KMqRH086qXw=;
        b=jslpC3tS34jasjw+F0x9ifOz01pxJ92Almwy61vcGO9iWb1I9iS4urqcEW7LFv3cjD
         U7ehfdP6s4lcJKInx5J5Sj2O6zN9hrDJjMcXLdU8v/Ot9q3M9LY44nmnHrogz/Exn0iy
         /0VHIQXr5I90xHdhKIms+qBjVrqRZcSiI8fcVSGHhBcV5C+a4Jzj/dW2F5EhHk/SMHDq
         nbsdsT4j2I4q2QzPK6wWjkDVj3nUzCl3D04rcMnJDx496FOVevvza2eARuZn/RVDGPFD
         wrB+pS4fHpJdG+E5ETItPgnQFatAF7zWQ99FLNLe3zmiCPCw1riW3TCWre9Tv8MGEXB1
         ON7A==
X-Gm-Message-State: AOJu0YxKF7PXJWrNQNAbxdMrriwbMWvn9+mNZEJXaFQMDXk/qwQaf9ND
        IiGGODOYeZy6mjZUWVk+FezAfLBm1g==
X-Google-Smtp-Source: AGHT+IFeLfPLSvQkmgKFhH1v1MtdCHGoVrUXirxq9kK9cBRYy0h/dsCEHEw33K8bnfI/iIhrV8h5wBBdKw==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:d085:0:b0:d84:2619:56df with SMTP id
 h127-20020a25d085000000b00d84261956dfmr5934ybg.13.1695146017529; Tue, 19 Sep
 2023 10:53:37 -0700 (PDT)
Date:   Tue, 19 Sep 2023 12:53:23 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919175323.144902-1-jrife@google.com>
Subject: [PATCH net v4 3/3] net: prevent address rewrite in kernel_bind()
From:   Jordan Rife <jrife@google.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        netdev@vger.kernel.org
Cc:     dborkman@kernel.org, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        axboe@kernel.dk, airlied@redhat.com, chengyou@linux.alibaba.com,
        kaishen@linux.alibaba.com, jgg@ziepe.ca, leon@kernel.org,
        bmt@zurich.ibm.com, isdn@linux-pingi.de, ccaulfie@redhat.com,
        teigland@redhat.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, sfrench@samba.org, pc@manguebit.com,
        lsahlber@redhat.com, sprasad@microsoft.com, tom@talpey.com,
        horms@verge.net.au, ja@ssi.bg, pablo@netfilter.org,
        kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com,
        Jordan Rife <jrife@google.com>, stable@vger.kernel.org
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

Similar to the change in commit 0bdf399342c5("net: Avoid address
overwrite in kernel_connect"), BPF hooks run on bind may rewrite the
address passed to kernel_bind(). This change

1) Makes a copy of the bind address in kernel_bind() to insulate
   callers.
2) Replaces direct calls to sock->ops->bind() with kernel_bind()

Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
Cc: stable@vger.kernel.org
Signed-off-by: Jordan Rife <jrife@google.com>
---
v3->v4: Remove precondition check for addrlen. Pass address copy to
        bind() instead of original address.
v2->v3: Add "Fixes" tag. Check for positivity in addrlen sanity check.
v1->v2: Split up original patch into patch series. Insulate
        sock->ops->bind() calls with kernel_bind().

 drivers/block/drbd/drbd_receiver.c     |  4 ++--
 drivers/char/agp/alpha-agp.c           |  2 +-
 drivers/infiniband/hw/erdma/erdma_cm.c |  6 +++---
 drivers/infiniband/sw/siw/siw_cm.c     | 10 +++++-----
 drivers/isdn/mISDN/l1oip_core.c        |  4 ++--
 fs/dlm/lowcomms.c                      |  7 +++----
 fs/ocfs2/cluster/tcp.c                 |  6 +++---
 fs/smb/client/connect.c                |  6 +++---
 net/netfilter/ipvs/ip_vs_sync.c        |  4 ++--
 net/rds/tcp_connect.c                  |  2 +-
 net/rds/tcp_listen.c                   |  2 +-
 net/socket.c                           |  7 ++++++-
 12 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 9b2660e990a98..752759ed22b8c 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -638,7 +638,7 @@ static struct socket *drbd_try_connect(struct drbd_connection *connection)
 	*  a free one dynamically.
 	*/
 	what = "bind before connect";
-	err = sock->ops->bind(sock, (struct sockaddr *) &src_in6, my_addr_len);
+	err = kernel_bind(sock, (struct sockaddr *)&src_in6, my_addr_len);
 	if (err < 0)
 		goto out;
 
@@ -725,7 +725,7 @@ static int prepare_listen_socket(struct drbd_connection *connection, struct acce
 	drbd_setbufsize(s_listen, sndbuf_size, rcvbuf_size);
 
 	what = "bind before listen";
-	err = s_listen->ops->bind(s_listen, (struct sockaddr *)&my_addr, my_addr_len);
+	err = kernel_bind(s_listen, (struct sockaddr *)&my_addr, my_addr_len);
 	if (err < 0)
 		goto out;
 
diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
index c9bf2c2198418..f251fedfb4840 100644
--- a/drivers/char/agp/alpha-agp.c
+++ b/drivers/char/agp/alpha-agp.c
@@ -96,7 +96,7 @@ static int alpha_core_agp_insert_memory(struct agp_memory *mem, off_t pg_start,
 	if ((pg_start + mem->page_count) > num_entries)
 		return -EINVAL;
 
-	status = agp->ops->bind(agp, pg_start, mem);
+	status = kernel_bind(agp, pg_start, mem);
 	mb();
 	alpha_core_agp_tlbflush(mem);
 
diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/hw/erdma/erdma_cm.c
index e2b89e7bbe2b8..674702d159c29 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -990,7 +990,7 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 	int ret;
 
 	sock_set_reuseaddr(s->sk);
-	ret = s->ops->bind(s, laddr, laddrlen);
+	ret = kernel_bind(s, laddr, laddrlen);
 	if (ret)
 		return ret;
 	ret = kernel_connect(s, raddr, raddrlen, flags);
@@ -1309,8 +1309,8 @@ int erdma_create_listen(struct iw_cm_id *id, int backlog)
 	if (ipv4_is_zeronet(laddr->sin_addr.s_addr))
 		s->sk->sk_bound_dev_if = dev->netdev->ifindex;
 
-	ret = s->ops->bind(s, (struct sockaddr *)laddr,
-			   sizeof(struct sockaddr_in));
+	ret = kernel_bind(s, (struct sockaddr *)laddr,
+			  sizeof(struct sockaddr_in));
 	if (ret)
 		goto error;
 
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 05624f424153e..d05e0eeee9244 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1324,7 +1324,7 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 			return rv;
 	}
 
-	rv = s->ops->bind(s, laddr, size);
+	rv = kernel_bind(s, laddr, size);
 	if (rv < 0)
 		return rv;
 
@@ -1793,8 +1793,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		if (ipv4_is_zeronet(laddr->sin_addr.s_addr))
 			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
 
-		rv = s->ops->bind(s, (struct sockaddr *)laddr,
-				  sizeof(struct sockaddr_in));
+		rv = kernel_bind(s, (struct sockaddr *)laddr,
+				 sizeof(struct sockaddr_in));
 	} else {
 		struct sockaddr_in6 *laddr = &to_sockaddr_in6(id->local_addr);
 
@@ -1811,8 +1811,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		if (ipv6_addr_any(&laddr->sin6_addr))
 			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
 
-		rv = s->ops->bind(s, (struct sockaddr *)laddr,
-				  sizeof(struct sockaddr_in6));
+		rv = kernel_bind(s, (struct sockaddr *)laddr,
+				 sizeof(struct sockaddr_in6));
 	}
 	if (rv) {
 		siw_dbg(id->device, "socket bind error: %d\n", rv);
diff --git a/drivers/isdn/mISDN/l1oip_core.c b/drivers/isdn/mISDN/l1oip_core.c
index f010b35a05313..681147e1fc843 100644
--- a/drivers/isdn/mISDN/l1oip_core.c
+++ b/drivers/isdn/mISDN/l1oip_core.c
@@ -675,8 +675,8 @@ l1oip_socket_thread(void *data)
 	hc->sin_remote.sin_port = htons((unsigned short)hc->remoteport);
 
 	/* bind to incoming port */
-	if (socket->ops->bind(socket, (struct sockaddr *)&hc->sin_local,
-			      sizeof(hc->sin_local))) {
+	if (kernel_bind(socket, (struct sockaddr *)&hc->sin_local,
+			sizeof(hc->sin_local))) {
 		printk(KERN_ERR "%s: Failed to bind socket to port %d.\n",
 		       __func__, hc->localport);
 		ret = -EINVAL;
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 1cf796b97eb65..73ab179833fbd 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1805,8 +1805,7 @@ static int dlm_tcp_bind(struct socket *sock)
 	memcpy(&src_addr, &dlm_local_addr[0], sizeof(src_addr));
 	make_sockaddr(&src_addr, 0, &addr_len);
 
-	result = sock->ops->bind(sock, (struct sockaddr *)&src_addr,
-				 addr_len);
+	result = kernel_bind(sock, (struct sockaddr *)&src_addr, addr_len);
 	if (result < 0) {
 		/* This *may* not indicate a critical error */
 		log_print("could not bind for connect: %d", result);
@@ -1850,8 +1849,8 @@ static int dlm_tcp_listen_bind(struct socket *sock)
 
 	/* Bind to our port */
 	make_sockaddr(&dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
-	return sock->ops->bind(sock, (struct sockaddr *)&dlm_local_addr[0],
-			       addr_len);
+	return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
+			   addr_len);
 }
 
 static const struct dlm_proto_ops dlm_tcp_ops = {
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index ead7c287ff373..3a4a7a521476d 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1614,8 +1614,8 @@ static void o2net_start_connect(struct work_struct *work)
 	myaddr.sin_addr.s_addr = mynode->nd_ipv4_address;
 	myaddr.sin_port = htons(0); /* any port */
 
-	ret = sock->ops->bind(sock, (struct sockaddr *)&myaddr,
-			      sizeof(myaddr));
+	ret = kernel_bind(sock, (struct sockaddr *)&myaddr,
+			  sizeof(myaddr));
 	if (ret) {
 		mlog(ML_ERROR, "bind failed with %d at address %pI4\n",
 		     ret, &mynode->nd_ipv4_address);
@@ -1998,7 +1998,7 @@ static int o2net_open_listening_sock(__be32 addr, __be16 port)
 	INIT_WORK(&o2net_listen_work, o2net_accept_many);
 
 	sock->sk->sk_reuse = SK_CAN_REUSE;
-	ret = sock->ops->bind(sock, (struct sockaddr *)&sin, sizeof(sin));
+	ret = kernel_bind(sock, (struct sockaddr *)&sin, sizeof(sin));
 	if (ret < 0) {
 		printk(KERN_ERR "o2net: Error %d while binding socket at "
 		       "%pI4:%u\n", ret, &addr, ntohs(port)); 
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index b7764cd57e035..6dcc1cd41b8c5 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2891,9 +2891,9 @@ bind_socket(struct TCP_Server_Info *server)
 	if (server->srcaddr.ss_family != AF_UNSPEC) {
 		/* Bind to the specified local IP address */
 		struct socket *socket = server->ssocket;
-		rc = socket->ops->bind(socket,
-				       (struct sockaddr *) &server->srcaddr,
-				       sizeof(server->srcaddr));
+		rc = kernel_bind(socket,
+				 (struct sockaddr *)&server->srcaddr,
+				 sizeof(server->srcaddr));
 		if (rc < 0) {
 			struct sockaddr_in *saddr4;
 			struct sockaddr_in6 *saddr6;
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
2.42.0.459.ge4e396fd5e-goog

