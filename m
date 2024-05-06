Return-Path: <stable+bounces-43092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526568BC61C
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 05:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3C5281A01
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 03:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EED04316B;
	Mon,  6 May 2024 03:13:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C5343AA2;
	Mon,  6 May 2024 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714965181; cv=none; b=LMRlGDeS9LRRbMT+N7lGSgelOxXeV8CuG6D6MSQbyQyWn2vJUbb/JVSwMDiyiz2Rnb6GBCFPZvL0uVjEAxQXSNnbJPWIcVZ7E5TUVIRbR6bRALKAwBQNBuC7C/H4RVTzEnJCz710WCqLGV6IyWW5sTVlgvxxKEhvJtADydjWEG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714965181; c=relaxed/simple;
	bh=PM7wj1rcdQ93mNXiFncnKDfnDadcag1nFXw/rPL+Ut0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PE3R9ulXOzMZIKvWEDLxzI9fZyxNR+thzzCuzUdubGutRs5RfxWPU7B1mjUZORrkQnOdNu9/LdSt5DmMPbSzX4u3zceAwP19DnZeKxD4Uu7jdf9/N4vZpXTf171sq9m/tS4LPGLKfl0XEGmnbb2lHytABGUm84l4un5cEy+zV6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VXmcG4P3lzNw0h;
	Mon,  6 May 2024 11:10:06 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id CBFF414037B;
	Mon,  6 May 2024 11:12:50 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 6 May
 2024 11:12:50 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <stable@vger.kernel.org>
CC: <netdev@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
	<kuba@kernel.org>, <edumazet@google.com>, <kuniyu@amazon.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH stable,5.4 1/2] Revert "tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()"
Date: Mon, 6 May 2024 11:17:49 +0800
Message-ID: <20240506031750.3169282-2-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506031750.3169282-1-shaozhengchao@huawei.com>
References: <20240506031750.3169282-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)

This reverts commit fc5bb10173cda1178d4e40d4cce812dadd3775c8.

In order to revert commit 53fab9cec2cd("tcp: Clean up kernel listener's
reqsk in inet_twsk_purge()"), revert this patch.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/ipv4/inet_timewait_sock.c | 41 +++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 85cb44bfa3ba..04726bbd72dc 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -254,12 +254,12 @@ void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo, bool rearm)
 }
 EXPORT_SYMBOL_GPL(__inet_twsk_schedule);
 
-/* Remove all non full sockets (TIME_WAIT and NEW_SYN_RECV) for dead netns */
 void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 {
+	struct inet_timewait_sock *tw;
+	struct sock *sk;
 	struct hlist_nulls_node *node;
 	unsigned int slot;
-	struct sock *sk;
 
 	for (slot = 0; slot <= hashinfo->ehash_mask; slot++) {
 		struct inet_ehash_bucket *head = &hashinfo->ehash[slot];
@@ -268,35 +268,38 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 		rcu_read_lock();
 restart:
 		sk_nulls_for_each_rcu(sk, node, &head->chain) {
-			int state = inet_sk_state_load(sk);
+			if (sk->sk_state != TCP_TIME_WAIT) {
+				/* A kernel listener socket might not hold refcnt for net,
+				 * so reqsk_timer_handler() could be fired after net is
+				 * freed.  Userspace listener and reqsk never exist here.
+				 */
+				if (unlikely(sk->sk_state == TCP_NEW_SYN_RECV &&
+					     hashinfo->pernet)) {
+					struct request_sock *req = inet_reqsk(sk);
+
+					inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
+				}
 
-			if ((1 << state) & ~(TCPF_TIME_WAIT |
-					     TCPF_NEW_SYN_RECV))
 				continue;
+			}
 
-			if (sk->sk_family != family ||
-			    refcount_read(&sock_net(sk)->count))
+			tw = inet_twsk(sk);
+			if ((tw->tw_family != family) ||
+				refcount_read(&twsk_net(tw)->count))
 				continue;
 
-			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+			if (unlikely(!refcount_inc_not_zero(&tw->tw_refcnt)))
 				continue;
 
-			if (unlikely(sk->sk_family != family ||
-				     refcount_read(&sock_net(sk)->count))) {
-				sock_gen_put(sk);
+			if (unlikely((tw->tw_family != family) ||
+				     refcount_read(&twsk_net(tw)->count))) {
+				inet_twsk_put(tw);
 				goto restart;
 			}
 
 			rcu_read_unlock();
 			local_bh_disable();
-			if (state == TCP_TIME_WAIT) {
-				inet_twsk_deschedule_put(inet_twsk(sk));
-			} else {
-				struct request_sock *req = inet_reqsk(sk);
-
-				inet_csk_reqsk_queue_drop_and_put(req->rsk_listener,
-								  req);
-			}
+			inet_twsk_deschedule_put(tw);
 			local_bh_enable();
 			goto restart_rcu;
 		}
-- 
2.34.1


