Return-Path: <stable+bounces-22563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EAF85DCA1
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 629CBB27D9D
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26A07BB03;
	Wed, 21 Feb 2024 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C60mnrhD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3AC78B50;
	Wed, 21 Feb 2024 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523733; cv=none; b=H+bH4OKcRRIQW0s8N0k8SZAlp17IS62OrADq/81jjBXyQvpuTREpNgYaAJPP4YnELuB7klcVxCr3jX1Hwn/NQ80RAHQlz1lgwZaKlrqU1uQ37yhdfQIAkYJ2oKGTcNNPrkobN3t2/lyzv9vDy0e6GrBmLsRB/ROgXzQWyIwQdh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523733; c=relaxed/simple;
	bh=wVs6SPOGRdCxXTCnkxCAkQW3W9cuSGMmmWYweU0ZbSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQ7ThhRz66EDiUC/R87hq7l3fjMEGl/Minro+pAmvOXsmIvwVAgA2PdYz6m8CDxAcmMvBKPFiGRFH557R41VdUgw0gfvBRt8lyGp73D3R1mZYmsmyrYvdXoc6AVXc2ku6iYd0ZHN17qhR6QWsogEWsqrSTO1CjlxmTQWu3bULFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C60mnrhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC90EC433C7;
	Wed, 21 Feb 2024 13:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523733;
	bh=wVs6SPOGRdCxXTCnkxCAkQW3W9cuSGMmmWYweU0ZbSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C60mnrhD0Lnk0lpUpFKGBR4JdUurhUBjqqtc2J8YH0xHrcBBms0Vl7bW0gdWaCckz
	 FanXDtGPCb6FTVNCh/k3dgvdm2C5XblWYIiqvF5iw+nbg7rfIE16Q41JLdooaFG2On
	 XSsMHZW21B4QhjlgmkyKNhi8x4DIuoJtQ7YR/weo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming Shu <sming56@aliyun.com>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 043/379] tcp: make sure init the accept_queues spinlocks once
Date: Wed, 21 Feb 2024 14:03:42 +0100
Message-ID: <20240221125956.191217361@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
References: <20240221125954.917878865@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhengchao Shao <shaozhengchao@huawei.com>

[ Upstream commit 198bc90e0e734e5f98c3d2833e8390cac3df61b2 ]

When I run syz's reproduction C program locally, it causes the following
issue:
pvqspinlock: lock 0xffff9d181cd5c660 has corrupted value 0x0!
WARNING: CPU: 19 PID: 21160 at __pv_queued_spin_unlock_slowpath (kernel/locking/qspinlock_paravirt.h:508)
Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
RIP: 0010:__pv_queued_spin_unlock_slowpath (kernel/locking/qspinlock_paravirt.h:508)
Code: 73 56 3a ff 90 c3 cc cc cc cc 8b 05 bb 1f 48 01 85 c0 74 05 c3 cc cc cc cc 8b 17 48 89 fe 48 c7 c7
30 20 ce 8f e8 ad 56 42 ff <0f> 0b c3 cc cc cc cc 0f 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffa8d200604cb8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff9d1ef60e0908
RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9d1ef60e0900
RBP: ffff9d181cd5c280 R08: 0000000000000000 R09: 00000000ffff7fff
R10: ffffa8d200604b68 R11: ffffffff907dcdc8 R12: 0000000000000000
R13: ffff9d181cd5c660 R14: ffff9d1813a3f330 R15: 0000000000001000
FS:  00007fa110184640(0000) GS:ffff9d1ef60c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 000000011f65e000 CR4: 00000000000006f0
Call Trace:
<IRQ>
  _raw_spin_unlock (kernel/locking/spinlock.c:186)
  inet_csk_reqsk_queue_add (net/ipv4/inet_connection_sock.c:1321)
  inet_csk_complete_hashdance (net/ipv4/inet_connection_sock.c:1358)
  tcp_check_req (net/ipv4/tcp_minisocks.c:868)
  tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2260)
  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:205)
  ip_local_deliver_finish (net/ipv4/ip_input.c:234)
  __netif_receive_skb_one_core (net/core/dev.c:5529)
  process_backlog (./include/linux/rcupdate.h:779)
  __napi_poll (net/core/dev.c:6533)
  net_rx_action (net/core/dev.c:6604)
  __do_softirq (./arch/x86/include/asm/jump_label.h:27)
  do_softirq (kernel/softirq.c:454 kernel/softirq.c:441)
</IRQ>
<TASK>
  __local_bh_enable_ip (kernel/softirq.c:381)
  __dev_queue_xmit (net/core/dev.c:4374)
  ip_finish_output2 (./include/net/neighbour.h:540 net/ipv4/ip_output.c:235)
  __ip_queue_xmit (net/ipv4/ip_output.c:535)
  __tcp_transmit_skb (net/ipv4/tcp_output.c:1462)
  tcp_rcv_synsent_state_process (net/ipv4/tcp_input.c:6469)
  tcp_rcv_state_process (net/ipv4/tcp_input.c:6657)
  tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1929)
  __release_sock (./include/net/sock.h:1121 net/core/sock.c:2968)
  release_sock (net/core/sock.c:3536)
  inet_wait_for_connect (net/ipv4/af_inet.c:609)
  __inet_stream_connect (net/ipv4/af_inet.c:702)
  inet_stream_connect (net/ipv4/af_inet.c:748)
  __sys_connect (./include/linux/file.h:45 net/socket.c:2064)
  __x64_sys_connect (net/socket.c:2073 net/socket.c:2070 net/socket.c:2070)
  do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
  RIP: 0033:0x7fa10ff05a3d
  Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89
  c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ab a3 0e 00 f7 d8 64 89 01 48
  RSP: 002b:00007fa110183de8 EFLAGS: 00000202 ORIG_RAX: 000000000000002a
  RAX: ffffffffffffffda RBX: 0000000020000054 RCX: 00007fa10ff05a3d
  RDX: 000000000000001c RSI: 0000000020000040 RDI: 0000000000000003
  RBP: 00007fa110183e20 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000202 R12: 00007fa110184640
  R13: 0000000000000000 R14: 00007fa10fe8b060 R15: 00007fff73e23b20
</TASK>

The issue triggering process is analyzed as follows:
Thread A                                       Thread B
tcp_v4_rcv	//receive ack TCP packet       inet_shutdown
  tcp_check_req                                  tcp_disconnect //disconnect sock
  ...                                              tcp_set_state(sk, TCP_CLOSE)
    inet_csk_complete_hashdance                ...
      inet_csk_reqsk_queue_add                 inet_listen  //start listen
        spin_lock(&queue->rskq_lock)             inet_csk_listen_start
        ...                                        reqsk_queue_alloc
        ...                                          spin_lock_init
        spin_unlock(&queue->rskq_lock)	//warning

When the socket receives the ACK packet during the three-way handshake,
it will hold spinlock. And then the user actively shutdowns the socket
and listens to the socket immediately, the spinlock will be initialized.
When the socket is going to release the spinlock, a warning is generated.
Also the same issue to fastopenq.lock.

Move init spinlock to inet_create and inet_accept to make sure init the
accept_queue's spinlocks once.

Fixes: fff1f3001cc5 ("tcp: add a spinlock to protect struct request_sock_queue")
Fixes: 168a8f58059a ("tcp: TCP Fast Open Server - main code path")
Reported-by: Ming Shu <sming56@aliyun.com>
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240118012019.1751966-1-shaozhengchao@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_connection_sock.h | 8 ++++++++
 net/core/request_sock.c            | 3 ---
 net/ipv4/af_inet.c                 | 3 +++
 net/ipv4/inet_connection_sock.c    | 4 ++++
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index ff901aade442..568121fa0965 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -339,4 +339,12 @@ static inline bool inet_csk_has_ulp(struct sock *sk)
 	return inet_sk(sk)->is_icsk && !!inet_csk(sk)->icsk_ulp_ops;
 }
 
+static inline void inet_init_csk_locks(struct sock *sk)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+
+	spin_lock_init(&icsk->icsk_accept_queue.rskq_lock);
+	spin_lock_init(&icsk->icsk_accept_queue.fastopenq.lock);
+}
+
 #endif /* _INET_CONNECTION_SOCK_H */
diff --git a/net/core/request_sock.c b/net/core/request_sock.c
index f35c2e998406..63de5c635842 100644
--- a/net/core/request_sock.c
+++ b/net/core/request_sock.c
@@ -33,9 +33,6 @@
 
 void reqsk_queue_alloc(struct request_sock_queue *queue)
 {
-	spin_lock_init(&queue->rskq_lock);
-
-	spin_lock_init(&queue->fastopenq.lock);
 	queue->fastopenq.rskq_rst_head = NULL;
 	queue->fastopenq.rskq_rst_tail = NULL;
 	queue->fastopenq.qlen = 0;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index acb4887351da..27c433eedea1 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -327,6 +327,9 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	if (INET_PROTOSW_REUSE & answer_flags)
 		sk->sk_reuse = SK_CAN_REUSE;
 
+	if (INET_PROTOSW_ICSK & answer_flags)
+		inet_init_csk_locks(sk);
+
 	inet = inet_sk(sk);
 	inet->is_icsk = (INET_PROTOSW_ICSK & answer_flags) != 0;
 
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 5f71a1c74e7e..b15c9ad0095a 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -536,6 +536,10 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
 	}
 	if (req)
 		reqsk_put(req);
+
+	if (newsk)
+		inet_init_csk_locks(newsk);
+
 	return newsk;
 out_err:
 	newsk = NULL;
-- 
2.43.0




