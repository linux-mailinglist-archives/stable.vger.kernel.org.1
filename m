Return-Path: <stable+bounces-20252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C67856068
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 11:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686CF28303B
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 10:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0C612C803;
	Thu, 15 Feb 2024 10:44:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1971512C7F4
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993890; cv=none; b=Vc9nXxKQbZHzVH9dXo8+mr0AiY3+idQD3fjEY0SXe8D7aCNgEhHvK9xX0Qnf2NgVKkXOziu1DghqGSUfBNEoQkBuFrmSFH0j+akGBF4EmIL0xrRqWgxtHnNr2mZEoz8vf8wxSYV8fTA73eoYKq4LccAasC59RO6h/o7lwrK075k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993890; c=relaxed/simple;
	bh=28hFVFkX/qTX2YlQcdUVqHOYYKNFrN7C5rA97xrRDeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVk4al7avY0u603ux5nDfEDVB2rtEk0B/QCkFvb5rmLo2MmPctVe9d5W0NKwcDs4DQAJBWszJljiK1A6WgQn8aZT3lscVxkWLVO+KClpmFtV1TEkbaFnuZEo3if8LwbflWw7y0hzfU1JbL6SIoaN8Vr/2PSslw7Ma/2JKam746A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1raZET-0000oe-9R
	for stable@vger.kernel.org; Thu, 15 Feb 2024 11:44:45 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1raZES-000rla-7t
	for stable@vger.kernel.org; Thu, 15 Feb 2024 11:44:44 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 6041E28E57C
	for <stable@vger.kernel.org>; Wed, 14 Feb 2024 14:03:52 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 32D9528E541;
	Wed, 14 Feb 2024 14:03:50 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 2b0f11ca;
	Wed, 14 Feb 2024 14:03:49 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Sili Luo <rootlab@huawei.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 2/3] can: j1939: Fix UAF in j1939_sk_match_filter during setsockopt(SO_J1939_FILTER)
Date: Wed, 14 Feb 2024 14:59:06 +0100
Message-ID: <20240214140348.2412776-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214140348.2412776-1-mkl@pengutronix.de>
References: <20240214140348.2412776-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

Lock jsk->sk to prevent UAF when setsockopt(..., SO_J1939_FILTER, ...)
modifies jsk->filters while receiving packets.

Following trace was seen on affected system:
 ==================================================================
 BUG: KASAN: slab-use-after-free in j1939_sk_recv_match_one+0x1af/0x2d0 [can_j1939]
 Read of size 4 at addr ffff888012144014 by task j1939/350

 CPU: 0 PID: 350 Comm: j1939 Tainted: G        W  OE      6.5.0-rc5 #1
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
 Call Trace:
  print_report+0xd3/0x620
  ? kasan_complete_mode_report_info+0x7d/0x200
  ? j1939_sk_recv_match_one+0x1af/0x2d0 [can_j1939]
  kasan_report+0xc2/0x100
  ? j1939_sk_recv_match_one+0x1af/0x2d0 [can_j1939]
  __asan_load4+0x84/0xb0
  j1939_sk_recv_match_one+0x1af/0x2d0 [can_j1939]
  j1939_sk_recv+0x20b/0x320 [can_j1939]
  ? __kasan_check_write+0x18/0x20
  ? __pfx_j1939_sk_recv+0x10/0x10 [can_j1939]
  ? j1939_simple_recv+0x69/0x280 [can_j1939]
  ? j1939_ac_recv+0x5e/0x310 [can_j1939]
  j1939_can_recv+0x43f/0x580 [can_j1939]
  ? __pfx_j1939_can_recv+0x10/0x10 [can_j1939]
  ? raw_rcv+0x42/0x3c0 [can_raw]
  ? __pfx_j1939_can_recv+0x10/0x10 [can_j1939]
  can_rcv_filter+0x11f/0x350 [can]
  can_receive+0x12f/0x190 [can]
  ? __pfx_can_rcv+0x10/0x10 [can]
  can_rcv+0xdd/0x130 [can]
  ? __pfx_can_rcv+0x10/0x10 [can]
  __netif_receive_skb_one_core+0x13d/0x150
  ? __pfx___netif_receive_skb_one_core+0x10/0x10
  ? __kasan_check_write+0x18/0x20
  ? _raw_spin_lock_irq+0x8c/0xe0
  __netif_receive_skb+0x23/0xb0
  process_backlog+0x107/0x260
  __napi_poll+0x69/0x310
  net_rx_action+0x2a1/0x580
  ? __pfx_net_rx_action+0x10/0x10
  ? __pfx__raw_spin_lock+0x10/0x10
  ? handle_irq_event+0x7d/0xa0
  __do_softirq+0xf3/0x3f8
  do_softirq+0x53/0x80
  </IRQ>
  <TASK>
  __local_bh_enable_ip+0x6e/0x70
  netif_rx+0x16b/0x180
  can_send+0x32b/0x520 [can]
  ? __pfx_can_send+0x10/0x10 [can]
  ? __check_object_size+0x299/0x410
  raw_sendmsg+0x572/0x6d0 [can_raw]
  ? __pfx_raw_sendmsg+0x10/0x10 [can_raw]
  ? apparmor_socket_sendmsg+0x2f/0x40
  ? __pfx_raw_sendmsg+0x10/0x10 [can_raw]
  sock_sendmsg+0xef/0x100
  sock_write_iter+0x162/0x220
  ? __pfx_sock_write_iter+0x10/0x10
  ? __rtnl_unlock+0x47/0x80
  ? security_file_permission+0x54/0x320
  vfs_write+0x6ba/0x750
  ? __pfx_vfs_write+0x10/0x10
  ? __fget_light+0x1ca/0x1f0
  ? __rcu_read_unlock+0x5b/0x280
  ksys_write+0x143/0x170
  ? __pfx_ksys_write+0x10/0x10
  ? __kasan_check_read+0x15/0x20
  ? fpregs_assert_state_consistent+0x62/0x70
  __x64_sys_write+0x47/0x60
  do_syscall_64+0x60/0x90
  ? do_syscall_64+0x6d/0x90
  ? irqentry_exit+0x3f/0x50
  ? exc_page_fault+0x79/0xf0
  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

 Allocated by task 348:
  kasan_save_stack+0x2a/0x50
  kasan_set_track+0x29/0x40
  kasan_save_alloc_info+0x1f/0x30
  __kasan_kmalloc+0xb5/0xc0
  __kmalloc_node_track_caller+0x67/0x160
  j1939_sk_setsockopt+0x284/0x450 [can_j1939]
  __sys_setsockopt+0x15c/0x2f0
  __x64_sys_setsockopt+0x6b/0x80
  do_syscall_64+0x60/0x90
  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

 Freed by task 349:
  kasan_save_stack+0x2a/0x50
  kasan_set_track+0x29/0x40
  kasan_save_free_info+0x2f/0x50
  __kasan_slab_free+0x12e/0x1c0
  __kmem_cache_free+0x1b9/0x380
  kfree+0x7a/0x120
  j1939_sk_setsockopt+0x3b2/0x450 [can_j1939]
  __sys_setsockopt+0x15c/0x2f0
  __x64_sys_setsockopt+0x6b/0x80
  do_syscall_64+0x60/0x90
  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Fixes: 9d71dd0c70099 ("can: add support of SAE J1939 protocol")
Reported-by: Sili Luo <rootlab@huawei.com>
Suggested-by: Sili Luo <rootlab@huawei.com>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/all/20231020133814.383996-1-o.rempel@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/j1939-priv.h |  1 +
 net/can/j1939/socket.c     | 22 ++++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 74f15592d170..31a93cae5111 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -301,6 +301,7 @@ struct j1939_sock {
 
 	int ifindex;
 	struct j1939_addr addr;
+	spinlock_t filters_lock;
 	struct j1939_filter *filters;
 	int nfilters;
 	pgn_t pgn_rx_filter;
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 94cfc2315e54..305dd72c844c 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -262,12 +262,17 @@ static bool j1939_sk_match_dst(struct j1939_sock *jsk,
 static bool j1939_sk_match_filter(struct j1939_sock *jsk,
 				  const struct j1939_sk_buff_cb *skcb)
 {
-	const struct j1939_filter *f = jsk->filters;
-	int nfilter = jsk->nfilters;
+	const struct j1939_filter *f;
+	int nfilter;
+
+	spin_lock_bh(&jsk->filters_lock);
+
+	f = jsk->filters;
+	nfilter = jsk->nfilters;
 
 	if (!nfilter)
 		/* receive all when no filters are assigned */
-		return true;
+		goto filter_match_found;
 
 	for (; nfilter; ++f, --nfilter) {
 		if ((skcb->addr.pgn & f->pgn_mask) != f->pgn)
@@ -276,9 +281,15 @@ static bool j1939_sk_match_filter(struct j1939_sock *jsk,
 			continue;
 		if ((skcb->addr.src_name & f->name_mask) != f->name)
 			continue;
-		return true;
+		goto filter_match_found;
 	}
+
+	spin_unlock_bh(&jsk->filters_lock);
 	return false;
+
+filter_match_found:
+	spin_unlock_bh(&jsk->filters_lock);
+	return true;
 }
 
 static bool j1939_sk_recv_match_one(struct j1939_sock *jsk,
@@ -401,6 +412,7 @@ static int j1939_sk_init(struct sock *sk)
 	atomic_set(&jsk->skb_pending, 0);
 	spin_lock_init(&jsk->sk_session_queue_lock);
 	INIT_LIST_HEAD(&jsk->sk_session_queue);
+	spin_lock_init(&jsk->filters_lock);
 
 	/* j1939_sk_sock_destruct() depends on SOCK_RCU_FREE flag */
 	sock_set_flag(sk, SOCK_RCU_FREE);
@@ -703,9 +715,11 @@ static int j1939_sk_setsockopt(struct socket *sock, int level, int optname,
 		}
 
 		lock_sock(&jsk->sk);
+		spin_lock_bh(&jsk->filters_lock);
 		ofilters = jsk->filters;
 		jsk->filters = filters;
 		jsk->nfilters = count;
+		spin_unlock_bh(&jsk->filters_lock);
 		release_sock(&jsk->sk);
 		kfree(ofilters);
 		return 0;
-- 
2.43.0



