Return-Path: <stable+bounces-145888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A653ABF98D
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440D2503671
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E034F21D3F1;
	Wed, 21 May 2025 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/S1YXgc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945AC1DF75C;
	Wed, 21 May 2025 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841616; cv=none; b=eoUJLauoQZjrxW+VmODgVhAxDGEHj+6F8HM6eCcnbAP0KUI21bOmoQvb/WKJzYajCrYVg4r08BidPIuKYerpVtxzGepEJfndCYnJuJV2ND8BdRT0GReMZVe/tdm1T1KJbX6CdiXINQYkubvMfg739mrijRF2VLigTmPt9gVnT6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841616; c=relaxed/simple;
	bh=4XqPg+mh/kFe742e9TKTxwUvm/c1ssaaC/hHgrTNopA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czVuti3OYx8S4t3BTnMyvtgHu0c/H+ePy+7EFjneWlARs6mbVuHVqAf48RXgbm0huIzsjNCfp+MsDPUxR9REXcFZlDR5FT4JmfguBbW7lscf0/fABuhRXz5XB2AT3EzBVWOdRFE+u+3oeqjf3EH61ifB9g1YxctNnfZSVkqCHCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/S1YXgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A35DC4CEE4;
	Wed, 21 May 2025 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841615;
	bh=4XqPg+mh/kFe742e9TKTxwUvm/c1ssaaC/hHgrTNopA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h/S1YXgc/RM92uPN5zmMIXHrjO8dfKaDoTX6HTkd/VTMLM86pahb3B0iuV+zSeAhg
	 6p0DJiqBexx3/yFV2+LDEEtA/T0dCaYYGilklJZeeSR6/iImOnfFAEXTNmV+aLBYXx
	 A2IkPfgi3xZ0lRHxRhuFI0tsJ99w0K7X7zv3ojjlfXhnX511YHVUozCxfmaF2bUKlG
	 eDJF1/gc/3iB6GgDyQxqB+1TECZZcqXba8nbembJGue6fXmXg8pfo/WFPTPij07/Oa
	 Q6t4knaFtXLaaBv8gqbWWjOW22rKhT+VbSKHK/74KjQ+Yzzyl202OA0j8ryo8r9pee
	 5TPH2Ejaj7QJw==
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
Cc: stable@vger.kernel.org
Subject: [PATCH v6.1 11/27] af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
Date: Wed, 21 May 2025 16:27:10 +0100
Message-ID: <20250521152920.1116756-12-lee@kernel.org>
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

[ Upstream commit 22c3c0c52d32f41cc38cd936ea0c93f22ced3315 ]

Currently, we track the number of inflight sockets in two variables.
unix_tot_inflight is the total number of inflight AF_UNIX sockets on
the host, and user->unix_inflight is the number of inflight fds per
user.

We update them one by one in unix_inflight(), which can be done once
in batch.  Also, sendmsg() could fail even after unix_inflight(), then
we need to acquire unix_gc_lock only to decrement the counters.

Let's bulk update the counters in unix_add_edges() and unix_del_edges(),
which is called only for successfully passed fds.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240325202425.60930-5-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 22c3c0c52d32f41cc38cd936ea0c93f22ced3315)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/unix/garbage.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index b5b4a200dbf3..f7041fc23000 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -144,6 +144,7 @@ static void unix_free_vertices(struct scm_fp_list *fpl)
 }
 
 DEFINE_SPINLOCK(unix_gc_lock);
+unsigned int unix_tot_inflight;
 
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 {
@@ -168,7 +169,10 @@ void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 		unix_add_edge(fpl, edge);
 	} while (i < fpl->count_unix);
 
+	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + fpl->count_unix);
 out:
+	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight + fpl->count);
+
 	spin_unlock(&unix_gc_lock);
 
 	fpl->inflight = true;
@@ -191,7 +195,10 @@ void unix_del_edges(struct scm_fp_list *fpl)
 		unix_del_edge(fpl, edge);
 	} while (i < fpl->count_unix);
 
+	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - fpl->count_unix);
 out:
+	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight - fpl->count);
+
 	spin_unlock(&unix_gc_lock);
 
 	fpl->inflight = false;
@@ -234,7 +241,6 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 	unix_free_vertices(fpl);
 }
 
-unsigned int unix_tot_inflight;
 static LIST_HEAD(gc_candidates);
 static LIST_HEAD(gc_inflight_list);
 
@@ -255,13 +261,8 @@ void unix_inflight(struct user_struct *user, struct file *filp)
 			WARN_ON_ONCE(list_empty(&u->link));
 		}
 		u->inflight++;
-
-		/* Paired with READ_ONCE() in wait_for_unix_gc() */
-		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + 1);
 	}
 
-	WRITE_ONCE(user->unix_inflight, user->unix_inflight + 1);
-
 	spin_unlock(&unix_gc_lock);
 }
 
@@ -278,13 +279,8 @@ void unix_notinflight(struct user_struct *user, struct file *filp)
 		u->inflight--;
 		if (!u->inflight)
 			list_del_init(&u->link);
-
-		/* Paired with READ_ONCE() in wait_for_unix_gc() */
-		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - 1);
 	}
 
-	WRITE_ONCE(user->unix_inflight, user->unix_inflight - 1);
-
 	spin_unlock(&unix_gc_lock);
 }
 
-- 
2.49.0.1143.g0be31eac6b-goog


