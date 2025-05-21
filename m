Return-Path: <stable+bounces-145879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075DDABF965
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F4E9E080E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5927A21A459;
	Wed, 21 May 2025 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAfo93rf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C8B218EBF;
	Wed, 21 May 2025 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841552; cv=none; b=RjmNATmiDkgvgE9C4cLnMJVJ/C6AiGbQlGXVn1VhpmtUluMLTad69JibX7zdNS13Hf7Rp7KKJLqSqtmV6bVGRZJemfiM3/icupgQ5ry6jjoIyufe6BSdukWxLm6L2hsfLAGT+GCPZFthg5NcWk/GqXmSH1Hq+lD/WWW+IjV5svY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841552; c=relaxed/simple;
	bh=dl4/jVpEjwuOyn5OIckbpyVPjbDVzVffI1XGjQPselI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtIS4qXhLhYKi5OHNcytaeomZcSdA6G9uKJPytIRe71hRjJXluQ0bAk1Jeu38CTYUAE+wH1zxP+1N9Mnm4xmjCXJpnq65zpRdAUn4DoQql1AIiR75A9BO39v7IyUUdebdryOwppt7dWB+vHVQpLNSK1rr/4l37tuVrdb9qz1ryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAfo93rf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D567C4AF0C;
	Wed, 21 May 2025 15:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841551;
	bh=dl4/jVpEjwuOyn5OIckbpyVPjbDVzVffI1XGjQPselI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vAfo93rfwi8tR5zMMbkAXxRq/O/qSPaWusN2ajbt3w2cPBmjq16hrYyybnUIklsUP
	 xk5uByeilYrZE3S6GZc9c5Dl4FTykaiLs082mQG6iddGQUV4qDbOEm9TWU7gOkm18l
	 PGQDXF08nZyYqZt3o0UFQMIH+8Qxt1zgS/YmxQ/pVAZHeuXJHpUAIVEOr8K70W3X+t
	 PK8ZULVDYLHeQq5b57XW4CCRNv3c9X4brN1wCmvZqisl3AQ/CGJQNFXQgk/mQXrndS
	 6j0X1U5Vvb7M2HtRFM9ECN/qJOXlCPTWqELgMzPKBk4LOp+Yxjsu5Pl0/r0cxzb/wK
	 +weNqO5upSi/A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Rao Shoaib <Rao.Shoaib@oracle.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v6.1 02/27] af_unix: Return struct unix_sock from unix_get_socket().
Date: Wed, 21 May 2025 16:27:01 +0100
Message-ID: <20250521152920.1116756-3-lee@kernel.org>
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
In-Reply-To: <20250521152920.1116756-1-lee@kernel.org>
References: <20250521152920.1116756-1-lee@kernel.org>
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
index e7d71a516bd4..52ae023c3e93 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -13,7 +13,7 @@ void unix_notinflight(struct user_struct *user, struct file *fp);
 void unix_destruct_scm(struct sk_buff *skb);
 void unix_gc(void);
 void wait_for_unix_gc(void);
-struct sock *unix_get_socket(struct file *filp);
+struct unix_sock *unix_get_socket(struct file *filp);
 struct sock *unix_peer_get(struct sock *sk);
 
 #define UNIX_HASH_MOD	(256 - 1)
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index d2fc795394a5..438f5d9b9173 100644
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
index 4eff7da9f6f9..693817a31ad8 100644
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
@@ -33,10 +32,10 @@ struct sock *unix_get_socket(struct file *filp)
 
 		/* PF_UNIX ? */
 		if (s && sock->ops && sock->ops->family == PF_UNIX)
-			u_sock = s;
+			return unix_sk(s);
 	}
 
-	return u_sock;
+	return NULL;
 }
 EXPORT_SYMBOL(unix_get_socket);
 
@@ -45,13 +44,11 @@ EXPORT_SYMBOL(unix_get_socket);
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
@@ -68,13 +65,11 @@ void unix_inflight(struct user_struct *user, struct file *fp)
 
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
2.49.0.1143.g0be31eac6b-goog


