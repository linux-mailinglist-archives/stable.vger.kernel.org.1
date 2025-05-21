Return-Path: <stable+bounces-145851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4918AABF838
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5461BC3B9D
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2DD1E3DED;
	Wed, 21 May 2025 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5XnY31j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A31D63DF;
	Wed, 21 May 2025 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747838996; cv=none; b=CM7UgrpRrJ1q1AV7jiD/IL5C1Rpi6+8hPISsZ1QuESdUnx8TdYqa5VJ3HQeUe80eD8yacqCzK0mMd9+pbQRY9SrSRl8YAi2ywndnoeefd2ft/d5j8jdPu+HbulLm4uFt8yWnHEZXdAscPOjNs9OraKsi+a4gO1YHDWX/O7yJg6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747838996; c=relaxed/simple;
	bh=rUbsdizpyy0BfPaaxnOjmiPENgTIRCEFrJ0owHP8VDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBIe59bkmj3p6Kcx4ZUSJUWoQ0tWtZ4WgbSSimJFyJu1Blm+JOdeCJ1/riLA0ioT60LXyeOxa7iW4vOgj1LTQbbNHFmituEVAzFZMh5DPFG9QnfE7hBx8eExIBznxjO/qXoytsqc9wVKm1LNnCsKo88+oxwTpkwFOmDqKICxMq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5XnY31j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A5DC4CEE4;
	Wed, 21 May 2025 14:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747838996;
	bh=rUbsdizpyy0BfPaaxnOjmiPENgTIRCEFrJ0owHP8VDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E5XnY31jYeaRpcMNMsks6CZkqLulVxE1twVgsZvIeh6eH1DENlQ/GSKUKy5/zIdFS
	 yWSK6hh7fm1Q+qRYh1hx+Wfzm9jH1JmE0SYIw5bvs9x6zrB3azrtwIbnE69aAB+lHS
	 Z2OsOWgfzHSbQY0/DnsrIe9jCg8fSDKVWeJqD2Q3CXatAYjwVbaZubGS+4hnxvJvmV
	 eZY0HVk0gspYhk7/oZsrZ78iNUjt8Zua6wKTdG3HVP5BXT/dlTfOkKK/f6dpe8tXkg
	 EJ8hVGW5hAp8rU2qQ3JquaqbFouWWQughVq4zm7sv5dWqzaUND88B5tcVFvA6Y5i5c
	 f6BcTxe+c3A5w==
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
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.6 04/26] af_unix: Replace BUG_ON() with WARN_ON_ONCE().
Date: Wed, 21 May 2025 14:45:12 +0000
Message-ID: <20250521144803.2050504-5-lee@kernel.org>
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

[ Upstream commit d0f6dc26346863e1f4a23117f5468614e54df064 ]

This is a prep patch for the last patch in this series so that
checkpatch will not warn about BUG_ON().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Jens Axboe <axboe@kernel.dk>
Link: https://lore.kernel.org/r/20240129190435.57228-2-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit d0f6dc26346863e1f4a23117f5468614e54df064)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/unix/garbage.c | 8 ++++----
 net/unix/scm.c     | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 96cc6b7674333..b4bf7f7538826 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -145,7 +145,7 @@ static void scan_children(struct sock *x, void (*func)(struct unix_sock *),
 			/* An embryo cannot be in-flight, so it's safe
 			 * to use the list link.
 			 */
-			BUG_ON(!list_empty(&u->link));
+			WARN_ON_ONCE(!list_empty(&u->link));
 			list_add_tail(&u->link, &embryos);
 		}
 		spin_unlock(&x->sk_receive_queue.lock);
@@ -224,8 +224,8 @@ static void __unix_gc(struct work_struct *work)
 
 		total_refs = file_count(sk->sk_socket->file);
 
-		BUG_ON(!u->inflight);
-		BUG_ON(total_refs < u->inflight);
+		WARN_ON_ONCE(!u->inflight);
+		WARN_ON_ONCE(total_refs < u->inflight);
 		if (total_refs == u->inflight) {
 			list_move_tail(&u->link, &gc_candidates);
 			__set_bit(UNIX_GC_CANDIDATE, &u->gc_flags);
@@ -318,7 +318,7 @@ static void __unix_gc(struct work_struct *work)
 		list_move_tail(&u->link, &gc_inflight_list);
 
 	/* All candidates should have been detached by now. */
-	BUG_ON(!list_empty(&gc_candidates));
+	WARN_ON_ONCE(!list_empty(&gc_candidates));
 
 	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
 	WRITE_ONCE(gc_in_progress, false);
diff --git a/net/unix/scm.c b/net/unix/scm.c
index b5ae5ab167773..505e56cf02a21 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -51,10 +51,10 @@ void unix_inflight(struct user_struct *user, struct file *fp)
 
 	if (u) {
 		if (!u->inflight) {
-			BUG_ON(!list_empty(&u->link));
+			WARN_ON_ONCE(!list_empty(&u->link));
 			list_add_tail(&u->link, &gc_inflight_list);
 		} else {
-			BUG_ON(list_empty(&u->link));
+			WARN_ON_ONCE(list_empty(&u->link));
 		}
 		u->inflight++;
 		/* Paired with READ_ONCE() in wait_for_unix_gc() */
@@ -71,8 +71,8 @@ void unix_notinflight(struct user_struct *user, struct file *fp)
 	spin_lock(&unix_gc_lock);
 
 	if (u) {
-		BUG_ON(!u->inflight);
-		BUG_ON(list_empty(&u->link));
+		WARN_ON_ONCE(!u->inflight);
+		WARN_ON_ONCE(list_empty(&u->link));
 
 		u->inflight--;
 		if (!u->inflight)
-- 
2.49.0.1112.g889b7c5bd8-goog


