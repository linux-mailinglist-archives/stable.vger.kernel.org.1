Return-Path: <stable+bounces-145886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137F4ABF989
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F3A3BE599
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BDE21CA1F;
	Wed, 21 May 2025 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgOWnU1o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F02821C9F3;
	Wed, 21 May 2025 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841602; cv=none; b=fi6dDEXyu76ldX3MFbEJbTE9aniv1heycn7WEioNm8byUdHXsAyEYOLw/LNLEa8OFv4Gm/sZuZtulxaZJZ9memZrWx/VpLp2SafMRJnePZp5Y/436JcVK9z7FWZ3zb9MbV35MjKKwUyerCPXhA6/kV4GAb/Dfl6i+DTkUPFPT6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841602; c=relaxed/simple;
	bh=aCmgMEOAM0j0CHxLV4UlaDTjhZ5Vvnt97mhZk29kpbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjvWqr4xcINtS3pmpEg5M7WRC6AJDSXDEz0JAN3rguM9pf7+HqJn8G8VAbAYapUUWCWecN/QTKLVc2UaToqmtLxYTbAttWAp9cjOuWK0D9mVimSQGUt/2emqMtkyNr/wIW974DCJybtdlRCIMiwvFhiYJm7R+MlJRpB8ZkLA0AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgOWnU1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7226C4CEE4;
	Wed, 21 May 2025 15:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841600;
	bh=aCmgMEOAM0j0CHxLV4UlaDTjhZ5Vvnt97mhZk29kpbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CgOWnU1ox6+9sZjix2vvQr60e3FocABop1an6Uf2uzXqGdKBfHJrndJOYfMLoKSh6
	 b9DMWudXyZ1ezwXaw1NBgL6aai08zsSS+t/G8CrX/dx57eUzoesRyk3zAIMTebBWn+
	 HOuK+eboPk2hRgBm/PUwdOo9hQOa9gkRZ0s7WUFCWRhpFegxY/8ZnYZEElTaXlb+IY
	 5OkPzMtulSuJOKMiPgxjmsDbbNzisoRl69iRMzYBShPhlTGimiZiWvJXY+UYLbH+hq
	 7VV/gpzQiIWlQmhn5p8GlRRO0IFQoQ36j+00w8e7wZdcYjTLipd57HhrO6jtkYizeu
	 2dh4dm6Y7XZgw==
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
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.1 09/27] af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
Date: Wed, 21 May 2025 16:27:08 +0100
Message-ID: <20250521152920.1116756-10-lee@kernel.org>
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
index b41aff1ac688..279087595966 100644
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
index 4183495d1981..19d7d802ed6c 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -21,12 +21,17 @@ struct scm_creds {
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
index 09bacb3d36f2..4c343729f960 100644
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
@@ -379,6 +380,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
 		new_fpl->max = new_fpl->count;
 		new_fpl->user = get_uid(fpl->user);
 #if IS_ENABLED(CONFIG_UNIX)
+		new_fpl->edges = NULL;
 		INIT_LIST_HEAD(&new_fpl->vertices);
 #endif
 	}
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 8ea7640e032e..912b7945692c 100644
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
2.49.0.1143.g0be31eac6b-goog


