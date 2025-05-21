Return-Path: <stable+bounces-145848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DC5ABF82E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7914E6CEB
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F641E8855;
	Wed, 21 May 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krf3vuOq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BF1E51EF;
	Wed, 21 May 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838973; cv=none; b=p5V7ZwV7bPfquPxSTOpOjStXtr7pJccgBVCeTM3Sj33sgY36b45xUuMWILyVSim6NRDohC6KBax7j2hvN+yzp64kXxuKcUT+Ps6Q9BCNG6t3TOZ2FOg+Ckk1sxWnf8uAnCTdaYddGrWvZPXpvk/uaRA2cJVyPBw1ShlZbf52QO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838973; c=relaxed/simple;
	bh=68+ebJ4FubqnMCeq4jcRHGP5kbGYBkNvzs6YdR8rFLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ek3WQL5xIgjaWiiCI+6yZz2mkvgvxFe1z7HSM7FayEPg6GBZ8MGa3ok491Ty3l5VTtS99j4GB3HpGRBb9trpV0XxyWefSwf6Ex45IvSf17jF9M64kTSef+HNN/SfYuNNBmWafYMk291kyMqQMJdG7n8vARl7IWBujqfUeH9ZYG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krf3vuOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0D3C4CEE7;
	Wed, 21 May 2025 14:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747838973;
	bh=68+ebJ4FubqnMCeq4jcRHGP5kbGYBkNvzs6YdR8rFLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=krf3vuOqh6bceKHwkR17/SEjRqv1XUtGiqXBg6tv0GX01tR6Dojmk8SnfL2MJXD8E
	 ndhUhLAOX3OnBVB1VSrexC1zL2mUlcTiCa9IXPkxH3KVwHvy6+41UaY9Y7my7ULqEn
	 fo7J02WFmPNi+sUrcOShiIZeudH3v6y096I9ijPQIDh3gA+22WGpUyX3tpAsszPTyE
	 PWzAd/QOJ+YOyYBbsWoxEc84a30wQoS0Qk7ro/Zkm9yqfsgrTK//ntOOtmtKJ6kqYe
	 lO+9a/NNArmZzy+iHThRi0mPGPZCWWEdaSOeg3WgdJXd+UZzIvCPaKueX+92funttl
	 0a1UAa1bey+VA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Rao Shoaib <Rao.Shoaib@oracle.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v6.6 01/26] af_unix: Return struct unix_sock from unix_get_socket().
Date: Wed, 21 May 2025 14:45:09 +0000
Message-ID: <20250521144803.2050504-2-lee@kernel.org>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
In-Reply-To: <20250521144803.2050504-1-lee@kernel.org>
References: <20250521144803.2050504-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 5b17307bd0789edea0675d524a2b277b93bbde62 ]

Currently, unix_get_socket() returns struct sock, but after calling
it, we always cast it to unix_sk().

Let's return struct unix_sock from unix_get_socket().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240123170856.41348-4-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 5b17307bd0789edea0675d524a2b277b93bbde62)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/net/af_unix.h |  2 +-
 net/unix/garbage.c    | 19 +++++++------------
 net/unix/scm.c        | 19 +++++++------------
 3 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 77bf30203d3cf..7a00d7ed527b6 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -14,7 +14,7 @@ void unix_destruct_scm(struct sk_buff *skb);
 void io_uring_destruct_scm(struct sk_buff *skb);
 void unix_gc(void);
 void wait_for_unix_gc(void);
-struct sock *unix_get_socket(struct file *filp);
+struct unix_sock *unix_get_socket(struct file *filp);
 struct sock *unix_peer_get(struct sock *sk);
 
 #define UNIX_HASH_MOD	(256 - 1)
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 2a758531e1027..38639766b9e7c 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -105,20 +105,15 @@ static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 
 			while (nfd--) {
 				/* Get the socket the fd matches if it indeed does so */
-				struct sock *sk = unix_get_socket(*fp++);
+				struct unix_sock *u = unix_get_socket(*fp++);
 
-				if (sk) {
-					struct unix_sock *u = unix_sk(sk);
+				/* Ignore non-candidates, they could have been added
+				 * to the queues after starting the garbage collection
+				 */
+				if (u && test_bit(UNIX_GC_CANDIDATE, &u->gc_flags)) {
+					hit = true;
 
-					/* Ignore non-candidates, they could
-					 * have been added to the queues after
-					 * starting the garbage collection
-					 */
-					if (test_bit(UNIX_GC_CANDIDATE, &u->gc_flags)) {
-						hit = true;
-
-						func(u);
-					}
+					func(u);
 				}
 			}
 			if (hit && hitlist != NULL) {
diff --git a/net/unix/scm.c b/net/unix/scm.c
index e92f2fad64105..b5ae5ab167773 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -21,9 +21,8 @@ EXPORT_SYMBOL(gc_inflight_list);
 DEFINE_SPINLOCK(unix_gc_lock);
 EXPORT_SYMBOL(unix_gc_lock);
 
-struct sock *unix_get_socket(struct file *filp)
+struct unix_sock *unix_get_socket(struct file *filp)
 {
-	struct sock *u_sock = NULL;
 	struct inode *inode = file_inode(filp);
 
 	/* Socket ? */
@@ -34,10 +33,10 @@ struct sock *unix_get_socket(struct file *filp)
 
 		/* PF_UNIX ? */
 		if (s && ops && ops->family == PF_UNIX)
-			u_sock = s;
+			return unix_sk(s);
 	}
 
-	return u_sock;
+	return NULL;
 }
 EXPORT_SYMBOL(unix_get_socket);
 
@@ -46,13 +45,11 @@ EXPORT_SYMBOL(unix_get_socket);
  */
 void unix_inflight(struct user_struct *user, struct file *fp)
 {
-	struct sock *s = unix_get_socket(fp);
+	struct unix_sock *u = unix_get_socket(fp);
 
 	spin_lock(&unix_gc_lock);
 
-	if (s) {
-		struct unix_sock *u = unix_sk(s);
-
+	if (u) {
 		if (!u->inflight) {
 			BUG_ON(!list_empty(&u->link));
 			list_add_tail(&u->link, &gc_inflight_list);
@@ -69,13 +66,11 @@ void unix_inflight(struct user_struct *user, struct file *fp)
 
 void unix_notinflight(struct user_struct *user, struct file *fp)
 {
-	struct sock *s = unix_get_socket(fp);
+	struct unix_sock *u = unix_get_socket(fp);
 
 	spin_lock(&unix_gc_lock);
 
-	if (s) {
-		struct unix_sock *u = unix_sk(s);
-
+	if (u) {
 		BUG_ON(!u->inflight);
 		BUG_ON(list_empty(&u->link));
 
-- 
2.49.0.1112.g889b7c5bd8-goog


