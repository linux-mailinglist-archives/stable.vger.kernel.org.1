Return-Path: <stable+bounces-145900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553B4ABF9B7
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29754504F0A
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5FA21ADA0;
	Wed, 21 May 2025 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCkT2Su1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E2321A420;
	Wed, 21 May 2025 15:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841701; cv=none; b=ATR9gOxh+JC4kfA4hSrG4enLkRnboOmRhVkjiPFnB3NvQRoScZKfl2poE2T2UXMxBJarNxi5R4K37SRfrxLE+fgQoyIDh4IpNyssSM/7j7rUz1TLd5Gxn+xhmiowWT9piw4/W5irQuCRZdAxPEMdEAhCJpyAzUarEbgUEnsohv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841701; c=relaxed/simple;
	bh=mi2zcw7qvB0tv8uFyF/DELKbUV30hjdh0e9RKqDxxGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uT4SPG1avwVxw2HZXQ/FzA42exh7D4uq9gF0h97EvbiYIffa62X6vzKivVPBCvt6pKrXrSURk1PvWmCXAgsJ938IoVjS8/6kk92XBdKFheJNEOPzk2WEIGk6MqXnEHm7Hm8eoK+neZO8CKz0VKwCzn5dRpNBAUPRn3/OhRULAhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCkT2Su1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD971C4CEE7;
	Wed, 21 May 2025 15:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841700;
	bh=mi2zcw7qvB0tv8uFyF/DELKbUV30hjdh0e9RKqDxxGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCkT2Su1FhhgiFEpjoZL4y0uj+gfjB347kLWFMQGikn1WgY6rs5Q1NZnEvuNjF/wL
	 1v1vGIeapY77dt7I+24/Wm6Q0he3NCQYkTR6Nch077CYcScVGEaiGDJeKYspQg2Qlz
	 y4inirtVxkeSKdReK2uBbgr1OIBH4KbsHlvPpqyD5/Nd9Axsu2yUCRdHlPp1xhZkoQ
	 dAmqtoBIxKnA96EdLflwvSqD+fnSzvFYtF8JwVJBRk/AY1+iU1tZf3BVa2g9gg/kV2
	 fbyIStb+Sy76DBMSdNsaxSmSq7RzZGxnsqDjsg0vq5cA455fqRQZm5BcTFZtQQGIJC
	 pYcvwNRyVgTDw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Sasha Levin <sashal@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Rao Shoaib <Rao.Shoaib@oracle.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v6.1 23/27] af_unix: Try not to hold unix_gc_lock during accept().
Date: Wed, 21 May 2025 16:27:22 +0100
Message-ID: <20250521152920.1116756-24-lee@kernel.org>
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

[ Upstream commit fd86344823b521149bb31d91eba900ba3525efa6 ]

Commit dcf70df2048d ("af_unix: Fix up unix_edge.successor for embryo
socket.") added spin_lock(&unix_gc_lock) in accept() path, and it
caused regression in a stress test as reported by kernel test robot.

If the embryo socket is not part of the inflight graph, we need not
hold the lock.

To decide that in O(1) time and avoid the regression in the normal
use case,

  1. add a new stat unix_sk(sk)->scm_stat.nr_unix_fds

  2. count the number of inflight AF_UNIX sockets in the receive
     queue under unix_state_lock()

  3. move unix_update_edges() call under unix_state_lock()

  4. avoid locking if nr_unix_fds is 0 in unix_update_edges()

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202404101427.92a08551-oliver.sang@intel.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20240413021928.20946-1-kuniyu@amazon.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit fd86344823b521149bb31d91eba900ba3525efa6)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/net/af_unix.h |  1 +
 net/unix/af_unix.c    |  2 +-
 net/unix/garbage.c    | 20 ++++++++++++++++----
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 4c726df56c0b..b1f82d74339e 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -67,6 +67,7 @@ struct unix_skb_parms {
 
 struct scm_stat {
 	atomic_t nr_fds;
+	unsigned long nr_unix_fds;
 };
 
 #define UNIXCB(skb)	(*(struct unix_skb_parms *)&((skb)->cb))
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ce5b74dfd8ae..79b783a70c87 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1677,12 +1677,12 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 	}
 
 	tsk = skb->sk;
-	unix_update_edges(unix_sk(tsk));
 	skb_free_datagram(sk, skb);
 	wake_up_interruptible(&unix_sk(sk)->peer_wait);
 
 	/* attach accepted sock to socket */
 	unix_state_lock(tsk);
+	unix_update_edges(unix_sk(tsk));
 	newsock->state = SS_CONNECTED;
 	unix_sock_inherit_flags(sock, newsock);
 	sock_graft(tsk, newsock);
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 12a4ec27e0d4..95240a59808f 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -209,6 +209,7 @@ void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 		unix_add_edge(fpl, edge);
 	} while (i < fpl->count_unix);
 
+	receiver->scm_stat.nr_unix_fds += fpl->count_unix;
 	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + fpl->count_unix);
 out:
 	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight + fpl->count);
@@ -222,6 +223,7 @@ void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 
 void unix_del_edges(struct scm_fp_list *fpl)
 {
+	struct unix_sock *receiver;
 	int i = 0;
 
 	spin_lock(&unix_gc_lock);
@@ -235,6 +237,8 @@ void unix_del_edges(struct scm_fp_list *fpl)
 		unix_del_edge(fpl, edge);
 	} while (i < fpl->count_unix);
 
+	receiver = fpl->edges[0].successor;
+	receiver->scm_stat.nr_unix_fds -= fpl->count_unix;
 	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - fpl->count_unix);
 out:
 	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight - fpl->count);
@@ -246,10 +250,18 @@ void unix_del_edges(struct scm_fp_list *fpl)
 
 void unix_update_edges(struct unix_sock *receiver)
 {
-	spin_lock(&unix_gc_lock);
-	unix_update_graph(unix_sk(receiver->listener)->vertex);
-	receiver->listener = NULL;
-	spin_unlock(&unix_gc_lock);
+	/* nr_unix_fds is only updated under unix_state_lock().
+	 * If it's 0 here, the embryo socket is not part of the
+	 * inflight graph, and GC will not see it, so no lock needed.
+	 */
+	if (!receiver->scm_stat.nr_unix_fds) {
+		receiver->listener = NULL;
+	} else {
+		spin_lock(&unix_gc_lock);
+		unix_update_graph(unix_sk(receiver->listener)->vertex);
+		receiver->listener = NULL;
+		spin_unlock(&unix_gc_lock);
+	}
 }
 
 int unix_prepare_fpl(struct scm_fp_list *fpl)
-- 
2.49.0.1143.g0be31eac6b-goog


