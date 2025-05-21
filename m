Return-Path: <stable+bounces-145882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8477EABF978
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937B53B67C6
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2282153E7;
	Wed, 21 May 2025 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAn5V7uA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B812B189513;
	Wed, 21 May 2025 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841572; cv=none; b=bHdtnsaijjekicstUlHW77qTEIURojhXto1KQnXEBYKOaARaDcy1PGM2EHo1qDV+rCcKuea4wx4wj9rUt0J+z2hlXyqr8eic4RLUJvtJBl55qetlsXsS13KH8+54j/qnkuMWjqaOnVXrbT8JLTra6nVQUq2LEiLKqbaC7uq2YxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841572; c=relaxed/simple;
	bh=PQ8yqnHUEFa5BUreHYRwSgQIVySTh+UdDqRcgs6i9lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+nCF8csFl0MZxU2LNF4h7OfYjXwI+busmGDf53fCj0DoMAa6dV5xpp06uPTBtCY/wvrZA9T13VrLJoocQtdbz0/78v/+101nrV8I6fpMvR5amZOqmq+kP/Q+J88K/P17AMEt4scw8HdQPNxhwEMPfYiERAc/HWFmuBDQ6YbNK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAn5V7uA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8147EC4CEE4;
	Wed, 21 May 2025 15:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841572;
	bh=PQ8yqnHUEFa5BUreHYRwSgQIVySTh+UdDqRcgs6i9lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BAn5V7uAjpTI4MACXEixF5hQmEMuTIqpoql0l9KOsRg+qj7/C7xw8wcjPSOdg9zBi
	 r/d7ADETVl+Pn3CJAwoqlcZer+JxFqJCVVLo46spb1BrZsnvwfJOGZtlTp7xx4lqOy
	 jLdhqspMbwFfOEAGuXv7rqKz86FbHhhdPPr+OqKiXJxhkWrU9BBHE7f/vcK2ShYPkb
	 4gzOogxi3UKUe1TVfH5TlrhbMb+gOCStevxGUx/9rx4qHuA6lSbQ1MK1+j0CgZTEK9
	 nMC0/0jZK+qAr8a1BySWi9KkQkjnHwqKfSnHiUH45bh7fAwFAalcKATdmOPGqvif2B
	 28Kf4F7oi97MA==
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
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.1 05/27] af_unix: Replace BUG_ON() with WARN_ON_ONCE().
Date: Wed, 21 May 2025 16:27:04 +0100
Message-ID: <20250521152920.1116756-6-lee@kernel.org>
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
index 2934d7b68036..7eeaac165e85 100644
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
index 693817a31ad8..6f446dd2deed 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -50,10 +50,10 @@ void unix_inflight(struct user_struct *user, struct file *fp)
 
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
@@ -70,8 +70,8 @@ void unix_notinflight(struct user_struct *user, struct file *fp)
 	spin_lock(&unix_gc_lock);
 
 	if (u) {
-		BUG_ON(!u->inflight);
-		BUG_ON(list_empty(&u->link));
+		WARN_ON_ONCE(!u->inflight);
+		WARN_ON_ONCE(list_empty(&u->link));
 
 		u->inflight--;
 		if (!u->inflight)
-- 
2.49.0.1143.g0be31eac6b-goog


