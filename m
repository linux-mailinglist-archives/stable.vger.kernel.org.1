Return-Path: <stable+bounces-108291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93764A0A4C4
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 17:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3CA2169E97
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 16:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C147219342F;
	Sat, 11 Jan 2025 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gePAFpWf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A71474DA
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736612619; cv=none; b=EtQQkLmZYQQJgkcBakXOn+2Get/XPqyFlMFMeIkWXjT9dpEggFBxRfi6ciHYvk60IYg957ELOzAdB2vqQAZYjZi4E/OqTJPEFyozCPlxr0HhlJQIgVHB9Tc1pJvgcu1CouO73h969xzEr1dDK7a5SLHJvKzUWbyHKqUGrzQ5xGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736612619; c=relaxed/simple;
	bh=e1ZlImrTGnJ9qKLZCALs+QRzdR7+kPgsqNoI/ccdC0s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BCcTX86Qws2Zrh9Soa3jvlRTqZIxW0rDhUNAdIJ3qVJkMHCKzNbf/RxJgK4AsQIr3dOIidkMcsjWQSDZZ9I+y6ux0UkReyA8D0oMPURZvBKHfGsGmjHMvBJogLPAVJj3WMaQ+YE78vjn/quTVNBb8Ja7huDqEO9Jms2oEzdKUik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gePAFpWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77081C4CED2;
	Sat, 11 Jan 2025 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736612619;
	bh=e1ZlImrTGnJ9qKLZCALs+QRzdR7+kPgsqNoI/ccdC0s=;
	h=Subject:To:Cc:From:Date:From;
	b=gePAFpWflC/5Bq35I20fM6V9ERhJVb1U2SKMezkay/RLstB0DM3aqCd5gCehW6zC7
	 9gKIPFYtNXvVZ1uw1itvheRIonfkfWxPvA5DWumvj1ZnwlHPHoUldIRoa8GmX00Cwy
	 2Vx9qU+v+4pt9jsKNJ5KVaCiepGSnp5hQoTHfk5o=
Subject: FAILED: patch "[PATCH] rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,kuba@kernel.org,viro@zeniv.linux.org.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 11 Jan 2025 17:23:24 +0100
Message-ID: <2025011124-ability-carrousel-5947@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7f5611cbc4871c7fb1ad36c2e5a9edad63dca95c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011124-ability-carrousel-5947@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7f5611cbc4871c7fb1ad36c2e5a9edad63dca95c Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 8 Jan 2025 16:34:37 +0100
Subject: [PATCH] rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using
 current->nsproxy

As mentioned in a previous commit of this series, using the 'net'
structure via 'current' is not recommended for different reasons:

- Inconsistency: getting info from the reader's/writer's netns vs only
  from the opener's netns.

- current->nsproxy can be NULL in some cases, resulting in an 'Oops'
  (null-ptr-deref), e.g. when the current task is exiting, as spotted by
  syzbot [1] using acct(2).

The per-netns structure can be obtained from the table->data using
container_of(), then the 'net' one can be retrieved from the listen
socket (if available).

Fixes: c6a58ffed536 ("RDS: TCP: Add sysctl tunables for sndbuf/rcvbuf on rds-tcp socket")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250108-net-sysctl-current-nsproxy-v1-9-5df34b2083e8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 351ac1747224..0581c53e6517 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -61,8 +61,10 @@ static atomic_t rds_tcp_unloading = ATOMIC_INIT(0);
 
 static struct kmem_cache *rds_tcp_conn_slab;
 
-static int rds_tcp_skbuf_handler(const struct ctl_table *ctl, int write,
-				 void *buffer, size_t *lenp, loff_t *fpos);
+static int rds_tcp_sndbuf_handler(const struct ctl_table *ctl, int write,
+				  void *buffer, size_t *lenp, loff_t *fpos);
+static int rds_tcp_rcvbuf_handler(const struct ctl_table *ctl, int write,
+				  void *buffer, size_t *lenp, loff_t *fpos);
 
 static int rds_tcp_min_sndbuf = SOCK_MIN_SNDBUF;
 static int rds_tcp_min_rcvbuf = SOCK_MIN_RCVBUF;
@@ -74,7 +76,7 @@ static struct ctl_table rds_tcp_sysctl_table[] = {
 		/* data is per-net pointer */
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = rds_tcp_skbuf_handler,
+		.proc_handler   = rds_tcp_sndbuf_handler,
 		.extra1		= &rds_tcp_min_sndbuf,
 	},
 #define	RDS_TCP_RCVBUF	1
@@ -83,7 +85,7 @@ static struct ctl_table rds_tcp_sysctl_table[] = {
 		/* data is per-net pointer */
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = rds_tcp_skbuf_handler,
+		.proc_handler   = rds_tcp_rcvbuf_handler,
 		.extra1		= &rds_tcp_min_rcvbuf,
 	},
 };
@@ -682,10 +684,10 @@ static void rds_tcp_sysctl_reset(struct net *net)
 	spin_unlock_irq(&rds_tcp_conn_lock);
 }
 
-static int rds_tcp_skbuf_handler(const struct ctl_table *ctl, int write,
+static int rds_tcp_skbuf_handler(struct rds_tcp_net *rtn,
+				 const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *fpos)
 {
-	struct net *net = current->nsproxy->net_ns;
 	int err;
 
 	err = proc_dointvec_minmax(ctl, write, buffer, lenp, fpos);
@@ -694,11 +696,34 @@ static int rds_tcp_skbuf_handler(const struct ctl_table *ctl, int write,
 			*(int *)(ctl->extra1));
 		return err;
 	}
-	if (write)
+
+	if (write && rtn->rds_tcp_listen_sock && rtn->rds_tcp_listen_sock->sk) {
+		struct net *net = sock_net(rtn->rds_tcp_listen_sock->sk);
+
 		rds_tcp_sysctl_reset(net);
+	}
+
 	return 0;
 }
 
+static int rds_tcp_sndbuf_handler(const struct ctl_table *ctl, int write,
+				  void *buffer, size_t *lenp, loff_t *fpos)
+{
+	struct rds_tcp_net *rtn = container_of(ctl->data, struct rds_tcp_net,
+					       sndbuf_size);
+
+	return rds_tcp_skbuf_handler(rtn, ctl, write, buffer, lenp, fpos);
+}
+
+static int rds_tcp_rcvbuf_handler(const struct ctl_table *ctl, int write,
+				  void *buffer, size_t *lenp, loff_t *fpos)
+{
+	struct rds_tcp_net *rtn = container_of(ctl->data, struct rds_tcp_net,
+					       rcvbuf_size);
+
+	return rds_tcp_skbuf_handler(rtn, ctl, write, buffer, lenp, fpos);
+}
+
 static void rds_tcp_exit(void)
 {
 	rds_tcp_set_unloading();


