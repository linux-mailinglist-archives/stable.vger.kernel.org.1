Return-Path: <stable+bounces-56911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC0C924FF2
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 05:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10361F25510
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 03:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC561799F;
	Wed,  3 Jul 2024 03:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Tv3+gpJY"
X-Original-To: stable@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39990179BC
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 03:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719978542; cv=none; b=iINPKLPYCf4KQ67NsoDjwVWbg2NMQDbeH2DECU3MDtiCu6KAAESFjiz2YcN3qpV+IhMnZIRiP5bvDlv7zpqoePP9YwJvuyjW1g7hD681KeDxCaUjphf5R2z1e2yggBmsPOggZSrz+wpkofAPFQNGv1CEJK1VNUIs8VbN1Yv2cEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719978542; c=relaxed/simple;
	bh=YwcFYNpk66isl3FP+bRI53s9Vql50/KEDdlceaPIWws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GLANb2OUO0WKNwPzr7aVUuQkcm1pStngfLFOnXbkIaw3Ri6MYhTJH5H4uUL6mNK1/B/lhPCJxc0o3r7OnhElSK8XuUgiKeXQmF8IDExBN9+sxwFSqXqIZJTiPb55yeVRs7lVorNDtRAEixd1hnr4xI2d5Uk1NpEcHWRCR967FQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Tv3+gpJY; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719978530; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PjUcqEuyqkJL/QmLybXP6RbM9rH1es9q8dt4o5hl1hE=;
	b=Tv3+gpJYkzG1DeVwviWPnh3mlmDghIdibbhbF93cdslu2z4FKC7Lpy9jmQ8+7e4IOlqpmSNYT8bUxNTiNZHKZFwiAkVIr5zNNT5fTcl/1JPfrx6sbB5t049YbhI3pKWQaTEtOkMPNc+d8BN2tdu86Gi29sBmidDQwHETx8LqP9c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W9kcqC3_1719978466;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W9kcqC3_1719978466)
          by smtp.aliyun-inc.com;
          Wed, 03 Jul 2024 11:48:50 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: wangyufen@huawei.com,
	mqaio@linux.alibaba.com,
	dtcccc@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com
Subject: [PATCH backport 5.10.y] bpf, sockmap: Fix sk->sk_forward_alloc warn_on in sk_stream_kill_queues
Date: Wed,  3 Jul 2024 11:47:46 +0800
Message-Id: <20240703034746.57537-1-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Yufen <wangyufen@huawei.com>

[ Upstream commit d8616ee2affcff37c5d315310da557a694a3303d ]

During TCP sockmap redirect pressure test, the following warning is triggered:

WARNING: CPU: 3 PID: 2145 at net/core/stream.c:205 sk_stream_kill_queues+0xbc/0xd0
CPU: 3 PID: 2145 Comm: iperf Kdump: loaded Tainted: G        W         5.10.0+ #9
Call Trace:
 inet_csk_destroy_sock+0x55/0x110
 inet_csk_listen_stop+0xbb/0x380
 tcp_close+0x41b/0x480
 inet_release+0x42/0x80
 __sock_release+0x3d/0xa0
 sock_close+0x11/0x20
 __fput+0x9d/0x240
 task_work_run+0x62/0x90
 exit_to_user_mode_prepare+0x110/0x120
 syscall_exit_to_user_mode+0x27/0x190
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The reason we observed is that:

When the listener is closing, a connection may have completed the three-way
handshake but not accepted, and the client has sent some packets. The child
sks in accept queue release by inet_child_forget()->inet_csk_destroy_sock(),
but psocks of child sks have not released.

To fix, add sock_map_destroy to release psocks.

Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20220524075311.649153-1-wangyufen@huawei.com
Stable-dep-of: 8bbabb3fddcd ("bpf, sock_map: Move cancel_work_sync() out of sock lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Conflict in include/linux/bpf.h due to function declaration position
and remove non-existed sk_psock_stop helper from sock_map_destroy.]
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
background:
Link: https://lore.kernel.org/stable/d11bc7e6-a2c7-445a-8561-3599eafb07b0@linux.alibaba.com/

@stable team:
This backport has 2 changes compared to the original patch:
- fix conflict due to sock_map_destroy declaration position in include/linux/bpf.h;
- remove the non-existed sk_psock_stop helper from sock_map_destroy. This helper is
  introduced by 799aa7f98d53 ("skmsg: Avoid lock_sock() in sk_psock_backlog()") after
  v5.10, it is not a fix and hard to backport. Considering that what did in
  sk_psock_stop is done in sk_psock_drop and neither sock_map_close nor sock_map_unhash
  in v5.10 introduces sk_psock_stop, I removed it from sock_map_destroy too.
I tested it in my environment, the regression was gone.

Cc:  Wang Yufen <wangyufen@huawei.com>
@Yufen, if I missed anything, please point it out, thanks!
---
 include/linux/bpf.h   |  1 +
 include/linux/skmsg.h |  1 +
 net/core/skmsg.c      |  1 +
 net/core/sock_map.c   | 22 ++++++++++++++++++++++
 net/ipv4/tcp_bpf.c    |  1 +
 5 files changed, 26 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a75faf437e75..340f4fef5b5a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1800,6 +1800,7 @@ int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
 int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
 int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags);
 void sock_map_unhash(struct sock *sk);
+void sock_map_destroy(struct sock *sk);
 void sock_map_close(struct sock *sk, long timeout);
 #else
 static inline int sock_map_prog_update(struct bpf_map *map,
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 1138dd3071db..e2af013ec05f 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -98,6 +98,7 @@ struct sk_psock {
 	spinlock_t			link_lock;
 	refcount_t			refcnt;
 	void (*saved_unhash)(struct sock *sk);
+	void (*saved_destroy)(struct sock *sk);
 	void (*saved_close)(struct sock *sk, long timeout);
 	void (*saved_write_space)(struct sock *sk);
 	struct proto			*sk_proto;
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index bb4fbc60b272..51792dda1b73 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -599,6 +599,7 @@ struct sk_psock *sk_psock_init(struct sock *sk, int node)
 	psock->eval = __SK_NONE;
 	psock->sk_proto = prot;
 	psock->saved_unhash = prot->unhash;
+	psock->saved_destroy = prot->destroy;
 	psock->saved_close = prot->close;
 	psock->saved_write_space = sk->sk_write_space;
 
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 52e395a189df..d1d0ee2dbfaa 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1566,6 +1566,28 @@ void sock_map_unhash(struct sock *sk)
 	saved_unhash(sk);
 }
 
+void sock_map_destroy(struct sock *sk)
+{
+	void (*saved_destroy)(struct sock *sk);
+	struct sk_psock *psock;
+
+	rcu_read_lock();
+	psock = sk_psock_get(sk);
+	if (unlikely(!psock)) {
+		rcu_read_unlock();
+		if (sk->sk_prot->destroy)
+			sk->sk_prot->destroy(sk);
+		return;
+	}
+
+	saved_destroy = psock->saved_destroy;
+	sock_map_remove_links(sk, psock);
+	rcu_read_unlock();
+	sk_psock_put(sk, psock);
+	saved_destroy(sk);
+}
+EXPORT_SYMBOL_GPL(sock_map_destroy);
+
 void sock_map_close(struct sock *sk, long timeout)
 {
 	void (*saved_close)(struct sock *sk, long timeout);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d0ca1fc325cd..f909e440bb22 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -582,6 +582,7 @@ static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
 				   struct proto *base)
 {
 	prot[TCP_BPF_BASE]			= *base;
+	prot[TCP_BPF_BASE].destroy		= sock_map_destroy;
 	prot[TCP_BPF_BASE].close		= sock_map_close;
 	prot[TCP_BPF_BASE].recvmsg		= tcp_bpf_recvmsg;
 	prot[TCP_BPF_BASE].stream_memory_read	= tcp_bpf_stream_read;
-- 
2.32.0.3.g01195cf9f


