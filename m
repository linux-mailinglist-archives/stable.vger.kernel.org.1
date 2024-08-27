Return-Path: <stable+bounces-71222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51B5961274
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9032AB29DF5
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B5B1CFEC9;
	Tue, 27 Aug 2024 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FnQU1ZNN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48931CFEBC;
	Tue, 27 Aug 2024 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772499; cv=none; b=kyk+PovY7fOesnEc5MH4bxt8siDpPckfduSx4BMF803bhmKdRwTk2WCQoePIweGMyRUz1MRBdUP08Ner8RtnYgvFBjaMPzlcyLZg575CO4PaoY1o/ngxJvabUj4Pd0BdWMExqOIakihcUVmu98As7d21LgadUcTR54cCHk0aB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772499; c=relaxed/simple;
	bh=x8wGCYmN2ReGqhmFMLLx/38GjZQx5gDVOryzbRrhJNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lt0ii8WvTDtowpt4sX2aOfMFX/wELmpX1nQgehSaWDxVdrY1Cg+ANXXPfHJY4CxdaQogqqF5A0bbDCOI4t+8zbXUdXeUPd3r1bFFN6nt4xL0Ul6Nn1U0dltWq9FoYbniQ41v6KA1Qbw+6uoi9nZ6LEkzYHA0UI/KzZF0pYsXbM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FnQU1ZNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A40BC61047;
	Tue, 27 Aug 2024 15:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772499;
	bh=x8wGCYmN2ReGqhmFMLLx/38GjZQx5gDVOryzbRrhJNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FnQU1ZNNMm6IyqCTt3z11VeG9M4G3eUvrHo0xlyhkjFcaFg5V9vO+nsoWWlLlWQ7g
	 73wSbZEtXStOWJf2MqGlR0rGs079M3yxj3RL6ZGvuobhU01yKQjQlf6VqAeZssfoKS
	 22mT+Jpm8AVDaCeCT3dZD0YbWhpDmL4WK0bmb/1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com,
	Florian Westphal <fw@strlen.de>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 232/321] tcp: prevent concurrent execution of tcp_sk_exit_batch
Date: Tue, 27 Aug 2024 16:39:00 +0200
Message-ID: <20240827143847.068990799@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 565d121b69980637f040eb4d84289869cdaabedf ]

Its possible that two threads call tcp_sk_exit_batch() concurrently,
once from the cleanup_net workqueue, once from a task that failed to clone
a new netns.  In the latter case, error unwinding calls the exit handlers
in reverse order for the 'failed' netns.

tcp_sk_exit_batch() calls tcp_twsk_purge().
Problem is that since commit b099ce2602d8 ("net: Batch inet_twsk_purge"),
this function picks up twsk in any dying netns, not just the one passed
in via exit_batch list.

This means that the error unwind of setup_net() can "steal" and destroy
timewait sockets belonging to the exiting netns.

This allows the netns exit worker to proceed to call

WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));

without the expected 1 -> 0 transition, which then splats.

At same time, error unwind path that is also running inet_twsk_purge()
will splat as well:

WARNING: .. at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210
...
 refcount_dec include/linux/refcount.h:351 [inline]
 inet_twsk_kill+0x758/0x9c0 net/ipv4/inet_timewait_sock.c:70
 inet_twsk_deschedule_put net/ipv4/inet_timewait_sock.c:221
 inet_twsk_purge+0x725/0x890 net/ipv4/inet_timewait_sock.c:304
 tcp_sk_exit_batch+0x1c/0x170 net/ipv4/tcp_ipv4.c:3522
 ops_exit_list+0x128/0x180 net/core/net_namespace.c:178
 setup_net+0x714/0xb40 net/core/net_namespace.c:375
 copy_net_ns+0x2f0/0x670 net/core/net_namespace.c:508
 create_new_namespaces+0x3ea/0xb10 kernel/nsproxy.c:110

... because refcount_dec() of tw_refcount unexpectedly dropped to 0.

This doesn't seem like an actual bug (no tw sockets got lost and I don't
see a use-after-free) but as erroneous trigger of debug check.

Add a mutex to force strict ordering: the task that calls tcp_twsk_purge()
blocks other task from doing final _dec_and_test before mutex-owner has
removed all tw sockets of dying netns.

Fixes: e9bd0cca09d1 ("tcp: Don't allocate tcp_death_row outside of struct netns_ipv4.")
Reported-by: syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/0000000000003a5292061f5e4e19@google.com/
Link: https://lore.kernel.org/netdev/20240812140104.GA21559@breakpoint.cc/
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20240812222857.29837-1-fw@strlen.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_ipv4.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 167de693981a8..1327447a3aade 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -93,6 +93,8 @@ EXPORT_SYMBOL(tcp_hashinfo);
 
 static DEFINE_PER_CPU(struct sock *, ipv4_tcp_sk);
 
+static DEFINE_MUTEX(tcp_exit_batch_mutex);
+
 static u32 tcp_v4_init_seq(const struct sk_buff *skb)
 {
 	return secure_tcp_seq(ip_hdr(skb)->daddr,
@@ -3242,6 +3244,16 @@ static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
 {
 	struct net *net;
 
+	/* make sure concurrent calls to tcp_sk_exit_batch from net_cleanup_work
+	 * and failed setup_net error unwinding path are serialized.
+	 *
+	 * tcp_twsk_purge() handles twsk in any dead netns, not just those in
+	 * net_exit_list, the thread that dismantles a particular twsk must
+	 * do so without other thread progressing to refcount_dec_and_test() of
+	 * tcp_death_row.tw_refcount.
+	 */
+	mutex_lock(&tcp_exit_batch_mutex);
+
 	tcp_twsk_purge(net_exit_list);
 
 	list_for_each_entry(net, net_exit_list, exit_list) {
@@ -3249,6 +3261,8 @@ static void __net_exit tcp_sk_exit_batch(struct list_head *net_exit_list)
 		WARN_ON_ONCE(!refcount_dec_and_test(&net->ipv4.tcp_death_row.tw_refcount));
 		tcp_fastopen_ctx_destroy(net);
 	}
+
+	mutex_unlock(&tcp_exit_batch_mutex);
 }
 
 static struct pernet_operations __net_initdata tcp_sk_ops = {
-- 
2.43.0




