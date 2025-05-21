Return-Path: <stable+bounces-145855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBDAABF84A
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F04189166E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0842F202C3B;
	Wed, 21 May 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxWlsvIi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33971E1C09;
	Wed, 21 May 2025 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839026; cv=none; b=BwchxWb2c9tfeTEYg+eBU85Do5FpEfTs1CGjIlVYiyb+u5ggmV2woz9Ps3a11AvjIZcOtworzm03p4lddJbi9VkFvuNvy1wY90jmIPOwRH+xpIk7eU1NqZ8NIHQNGzTBtOAhxNoO7TszpFggLXJmrdLibyPqKelJEgQLa20p3+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839026; c=relaxed/simple;
	bh=o/VWYxs0NRzWCaYUudCgt1Nw4n+OPgG9HufhAotjsSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHFEcB9+YF31+TC21nTksN79k3zrAeKQLX/g5cFP4z9ZK2JjA4C6FZTQ6tqqpXPnjMVQGUD410MkBTSc8tyqxw4fMQ/j5jqWVznjdazZdjtEukXSxtSJmAotqXuTQpOjwhQlGvPtBqVxhXR1Rjmnd9UqknMIcdt62TBjcua3Nvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxWlsvIi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523BAC4CEE4;
	Wed, 21 May 2025 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747839026;
	bh=o/VWYxs0NRzWCaYUudCgt1Nw4n+OPgG9HufhAotjsSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxWlsvIiqFqv1BLpNncPpRpgA2+jM/zYBEzw0zB9UwOWclLwDU21W8KUv8eqfyi1r
	 wyOZzCoz/ouY4tohzFCAg8U0TeM0MARTgSM25F9B72sIyPieLCZq8QZiCuu4w+bpoS
	 wLXNUSxLTNHOwC22xu6JPoF62NPI3g2VJP9Z2/5lwshw4FSdU/j/Yb0yX+HoTpJr7v
	 5Gs9z+4o0RfZ1q8IC9C4KW8+rF54jZ4BCIRCVxc+mlTzkQV/e7KmfFXb4yr6kRyRyD
	 YvGN8YikGKO4HJbcopimoEG/32WdIJHRqc65zQct72kyx5u3n6H41PNQqaJ00o/GTd
	 tiIcBPxL75e0g==
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
Cc: stable@vger.kernel.org
Subject: [PATCH v6.6 08/26] af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
Date: Wed, 21 May 2025 14:45:16 +0000
Message-ID: <20250521144803.2050504-9-lee@kernel.org>
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

[ Upstream commit 29b64e354029cfcf1eea4d91b146c7b769305930 ]

As with the previous patch, we preallocate to skb's scm_fp_list an
array of struct unix_edge in the number of inflight AF_UNIX fds.

There we just preallocate memory and do not use immediately because
sendmsg() could fail after this point.  The actual use will be in
the next patch.

When we queue skb with inflight edges, we will set the inflight
socket's unix_sock as unix_edge->predecessor and the receiver's
unix_sock as successor, and then we will link the edge to the
inflight socket's unix_vertex.edges.

Note that we set NULL to cloned scm_fp_list.edges in scm_fp_dup()
so that MSG_PEEK does not change the shape of the directed graph.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240325202425.60930-3-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 29b64e354029cfcf1eea4d91b146c7b769305930)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 include/net/af_unix.h | 6 ++++++
 include/net/scm.h     | 5 +++++
 net/core/scm.c        | 2 ++
 net/unix/garbage.c    | 6 ++++++
 4 files changed, 19 insertions(+)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 07f0f698c9490..dd5750daf0b92 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -33,6 +33,12 @@ struct unix_vertex {
 	unsigned long out_degree;
 };
 
+struct unix_edge {
+	struct unix_sock *predecessor;
+	struct unix_sock *successor;
+	struct list_head vertex_entry;
+};
+
 struct sock *unix_peer_get(struct sock *sk);
 
 #define UNIX_HASH_MOD	(256 - 1)
diff --git a/include/net/scm.h b/include/net/scm.h
index 11e86e55f332d..915c4c94306ec 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -22,12 +22,17 @@ struct scm_creds {
 	kgid_t	gid;
 };
 
+#ifdef CONFIG_UNIX
+struct unix_edge;
+#endif
+
 struct scm_fp_list {
 	short			count;
 	short			count_unix;
 	short			max;
 #ifdef CONFIG_UNIX
 	struct list_head	vertices;
+	struct unix_edge	*edges;
 #endif
 	struct user_struct	*user;
 	struct file		*fp[SCM_MAX_FD];
diff --git a/net/core/scm.c b/net/core/scm.c
index 27e5634c958e8..96e3d2785e509 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -90,6 +90,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		fpl->max = SCM_MAX_FD;
 		fpl->user = NULL;
 #if IS_ENABLED(CONFIG_UNIX)
+		fpl->edges = NULL;
 		INIT_LIST_HEAD(&fpl->vertices);
 #endif
 	}
@@ -383,6 +384,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
 		new_fpl->max = new_fpl->count;
 		new_fpl->user = get_uid(fpl->user);
 #if IS_ENABLED(CONFIG_UNIX)
+		new_fpl->edges = NULL;
 		INIT_LIST_HEAD(&new_fpl->vertices);
 #endif
 	}
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 8ea7640e032e8..912b7945692c9 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -127,6 +127,11 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
 		list_add(&vertex->entry, &fpl->vertices);
 	}
 
+	fpl->edges = kvmalloc_array(fpl->count_unix, sizeof(*fpl->edges),
+				    GFP_KERNEL_ACCOUNT);
+	if (!fpl->edges)
+		goto err;
+
 	return 0;
 
 err:
@@ -136,6 +141,7 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
 
 void unix_destroy_fpl(struct scm_fp_list *fpl)
 {
+	kvfree(fpl->edges);
 	unix_free_vertices(fpl);
 }
 
-- 
2.49.0.1112.g889b7c5bd8-goog


