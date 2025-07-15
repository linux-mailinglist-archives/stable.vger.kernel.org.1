Return-Path: <stable+bounces-162247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023AFB05C89
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44795168D4A
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC1F2D5426;
	Tue, 15 Jul 2025 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y3YL2WZS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8E2E7BAF;
	Tue, 15 Jul 2025 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586052; cv=none; b=R2EkvKU8Mxh/jCLbKmthz61RBIHByAF2SN5C2IxceNNFzNiqnbikUjfVUi1rt8oJ2/RZtCFrolGLKVf8HtT+4ANtJj8CZc8QkWYrZ4Rn0X5PRMndRDQEh7wRjnwsG11rdKqs8xWTImTclhF+vUFPR4K7gdraj7rZ8akqzgKAaPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586052; c=relaxed/simple;
	bh=JfLckwTwu3U6rcnfhvqRsC2nqiPZ0Q1F2QpK4uOvFls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMgDVtSsqZBKMxC04KzCGODKn7L8LrYrx0rePAW1aDPLD3d9aHdYPeiDOuyCPUVPidQt1SlwfrJ8vaiuM7LlD8vkjWpJML0kspq8OH1XFRFhw12eY8IXOOc9D+DywV4He0jJkXbc33mqFS/g5ZdTM/KLW5X8Adc7c5REXXu49oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y3YL2WZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9520C4CEE3;
	Tue, 15 Jul 2025 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586052;
	bh=JfLckwTwu3U6rcnfhvqRsC2nqiPZ0Q1F2QpK4uOvFls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y3YL2WZSEmsQY3ex+9l0QWt1FDm+j4JUNV/z1NW1yFbwagLBoUK4lRh+oViPzKBBd
	 P51aPmLTAlNfAHJ+YwhRqstGBW8vSbTjL8u+2lxyk3sIR6tWHbODfsBEFPMFEZefIe
	 zc8Q36fmVgXb/6WkjkqFq55X2VwrJVkT/9f82dcY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 076/109] smb: client: fix DFS interlink failover
Date: Tue, 15 Jul 2025 15:13:32 +0200
Message-ID: <20250715130801.927312731@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130758.864940641@linuxfoundation.org>
References: <20250715130758.864940641@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 4f42a8b54b5c6e36519aef3cb1f6210e54abd451 ]

The DFS interlinks point to different DFS namespaces so make sure to
use the correct DFS root server to chase any DFS links under it by
storing the SMB session in dfs_ref_walk structure and then using it on
every referral walk.

Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 74ebd02163fd ("cifs: all initializations for tcon should happen in tcon_info_alloc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h   |  3 ++
 fs/smb/client/cifsproto.h  | 12 ++-----
 fs/smb/client/connect.c    | 41 +++++++++++----------
 fs/smb/client/dfs.c        | 73 ++++++++++++++++++--------------------
 fs/smb/client/dfs.h        | 42 ++++++++++++++--------
 fs/smb/client/dfs_cache.c  |  3 +-
 fs/smb/client/fs_context.h |  1 +
 fs/smb/client/misc.c       |  3 ++
 fs/smb/client/namespace.c  |  2 +-
 9 files changed, 94 insertions(+), 86 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 5c856adf7be9e..c9b37f2ebde85 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -830,6 +830,7 @@ struct TCP_Server_Info {
 	 * format: \\HOST\SHARE[\OPTIONAL PATH]
 	 */
 	char *leaf_fullpath;
+	bool dfs_conn:1;
 };
 
 static inline bool is_smb1(struct TCP_Server_Info *server)
@@ -1065,6 +1066,7 @@ struct cifs_ses {
 	struct list_head smb_ses_list;
 	struct list_head rlist; /* reconnect list */
 	struct list_head tcon_list;
+	struct list_head dlist; /* dfs list */
 	struct cifs_tcon *tcon_ipc;
 	spinlock_t ses_lock;  /* protect anything here that is not protected */
 	struct mutex session_mutex;
@@ -1294,6 +1296,7 @@ struct cifs_tcon {
 	/* BB add field for back pointer to sb struct(s)? */
 #ifdef CONFIG_CIFS_DFS_UPCALL
 	struct delayed_work dfs_cache_work;
+	struct list_head dfs_ses_list;
 #endif
 	struct delayed_work	query_interfaces; /* query interfaces workqueue job */
 	char *origin_fullpath; /* canonical copy of smb3_fs_context::source */
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index c6d325666b5cd..8edb6fe89a97c 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -737,15 +737,9 @@ static inline int cifs_create_options(struct cifs_sb_info *cifs_sb, int options)
 
 int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server, bool retry);
 
-/* Put references of @ses and its children */
 static inline void cifs_put_smb_ses(struct cifs_ses *ses)
 {
-	struct cifs_ses *next;
-
-	do {
-		next = ses->dfs_root_ses;
-		__cifs_put_smb_ses(ses);
-	} while ((ses = next));
+	__cifs_put_smb_ses(ses);
 }
 
 /* Get an active reference of @ses and its children.
@@ -759,9 +753,7 @@ static inline void cifs_put_smb_ses(struct cifs_ses *ses)
 static inline void cifs_smb_ses_inc_refcount(struct cifs_ses *ses)
 {
 	lockdep_assert_held(&cifs_tcp_ses_lock);
-
-	for (; ses; ses = ses->dfs_root_ses)
-		ses->ses_count++;
+	ses->ses_count++;
 }
 
 static inline bool dfs_src_pathname_equal(const char *s1, const char *s2)
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 8298d1745f9b9..14be8822d23a2 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1551,6 +1551,9 @@ static int match_server(struct TCP_Server_Info *server,
 	if (server->nosharesock)
 		return 0;
 
+	if (!match_super && (ctx->dfs_conn || server->dfs_conn))
+		return 0;
+
 	/* If multidialect negotiation see if existing sessions match one */
 	if (strcmp(ctx->vals->version_string, SMB3ANY_VERSION_STRING) == 0) {
 		if (server->vals->protocol_id < SMB30_PROT_ID)
@@ -1740,6 +1743,7 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 
 	if (ctx->nosharesock)
 		tcp_ses->nosharesock = true;
+	tcp_ses->dfs_conn = ctx->dfs_conn;
 
 	tcp_ses->ops = ctx->ops;
 	tcp_ses->vals = ctx->vals;
@@ -1890,12 +1894,14 @@ cifs_get_tcp_session(struct smb3_fs_context *ctx,
 }
 
 /* this function must be called with ses_lock and chan_lock held */
-static int match_session(struct cifs_ses *ses, struct smb3_fs_context *ctx)
+static int match_session(struct cifs_ses *ses,
+			 struct smb3_fs_context *ctx,
+			 bool match_super)
 {
 	struct TCP_Server_Info *server = ses->server;
 	enum securityEnum ctx_sec, ses_sec;
 
-	if (ctx->dfs_root_ses != ses->dfs_root_ses)
+	if (!match_super && ctx->dfs_root_ses != ses->dfs_root_ses)
 		return 0;
 
 	/*
@@ -2047,7 +2053,7 @@ cifs_find_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 			continue;
 		}
 		spin_lock(&ses->chan_lock);
-		if (match_session(ses, ctx)) {
+		if (match_session(ses, ctx, false)) {
 			spin_unlock(&ses->chan_lock);
 			spin_unlock(&ses->ses_lock);
 			ret = ses;
@@ -2450,8 +2456,6 @@ cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 	 * need to lock before changing something in the session.
 	 */
 	spin_lock(&cifs_tcp_ses_lock);
-	if (ctx->dfs_root_ses)
-		cifs_smb_ses_inc_refcount(ctx->dfs_root_ses);
 	ses->dfs_root_ses = ctx->dfs_root_ses;
 	list_add(&ses->smb_ses_list, &server->smb_ses_list);
 	spin_unlock(&cifs_tcp_ses_lock);
@@ -2528,6 +2532,7 @@ cifs_put_tcon(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace)
 {
 	unsigned int xid;
 	struct cifs_ses *ses;
+	LIST_HEAD(ses_list);
 
 	/*
 	 * IPC tcon share the lifetime of their session and are
@@ -2552,6 +2557,9 @@ cifs_put_tcon(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace)
 
 	list_del_init(&tcon->tcon_list);
 	tcon->status = TID_EXITING;
+#ifdef CONFIG_CIFS_DFS_UPCALL
+	list_replace_init(&tcon->dfs_ses_list, &ses_list);
+#endif
 	spin_unlock(&tcon->tc_lock);
 	spin_unlock(&cifs_tcp_ses_lock);
 
@@ -2579,6 +2587,9 @@ cifs_put_tcon(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace)
 	cifs_fscache_release_super_cookie(tcon);
 	tconInfoFree(tcon, netfs_trace_tcon_ref_free);
 	cifs_put_smb_ses(ses);
+#ifdef CONFIG_CIFS_DFS_UPCALL
+	dfs_put_root_smb_sessions(&ses_list);
+#endif
 }
 
 /**
@@ -2962,7 +2973,7 @@ cifs_match_super(struct super_block *sb, void *data)
 	spin_lock(&ses->chan_lock);
 	spin_lock(&tcon->tc_lock);
 	if (!match_server(tcp_srv, ctx, true) ||
-	    !match_session(ses, ctx) ||
+	    !match_session(ses, ctx, true) ||
 	    !match_tcon(tcon, ctx) ||
 	    !match_prepath(sb, tcon, mnt_data)) {
 		rc = 0;
@@ -3712,13 +3723,12 @@ int cifs_is_path_remote(struct cifs_mount_ctx *mnt_ctx)
 int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 {
 	struct cifs_mount_ctx mnt_ctx = { .cifs_sb = cifs_sb, .fs_ctx = ctx, };
-	bool isdfs;
 	int rc;
 
-	rc = dfs_mount_share(&mnt_ctx, &isdfs);
+	rc = dfs_mount_share(&mnt_ctx);
 	if (rc)
 		goto error;
-	if (!isdfs)
+	if (!ctx->dfs_conn)
 		goto out;
 
 	/*
@@ -4135,7 +4145,7 @@ cifs_set_vol_auth(struct smb3_fs_context *ctx, struct cifs_ses *ses)
 }
 
 static struct cifs_tcon *
-__cifs_construct_tcon(struct cifs_sb_info *cifs_sb, kuid_t fsuid)
+cifs_construct_tcon(struct cifs_sb_info *cifs_sb, kuid_t fsuid)
 {
 	int rc;
 	struct cifs_tcon *master_tcon = cifs_sb_master_tcon(cifs_sb);
@@ -4233,17 +4243,6 @@ __cifs_construct_tcon(struct cifs_sb_info *cifs_sb, kuid_t fsuid)
 	return tcon;
 }
 
-static struct cifs_tcon *
-cifs_construct_tcon(struct cifs_sb_info *cifs_sb, kuid_t fsuid)
-{
-	struct cifs_tcon *ret;
-
-	cifs_mount_lock();
-	ret = __cifs_construct_tcon(cifs_sb, fsuid);
-	cifs_mount_unlock();
-	return ret;
-}
-
 struct cifs_tcon *
 cifs_sb_master_tcon(struct cifs_sb_info *cifs_sb)
 {
diff --git a/fs/smb/client/dfs.c b/fs/smb/client/dfs.c
index bd259b04cdede..c35953843373e 100644
--- a/fs/smb/client/dfs.c
+++ b/fs/smb/client/dfs.c
@@ -69,7 +69,7 @@ static int get_session(struct cifs_mount_ctx *mnt_ctx, const char *full_path)
  * Get an active reference of @ses so that next call to cifs_put_tcon() won't
  * release it as any new DFS referrals must go through its IPC tcon.
  */
-static void add_root_smb_session(struct cifs_mount_ctx *mnt_ctx)
+static void set_root_smb_session(struct cifs_mount_ctx *mnt_ctx)
 {
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
 	struct cifs_ses *ses = mnt_ctx->ses;
@@ -95,7 +95,7 @@ static inline int parse_dfs_target(struct smb3_fs_context *ctx,
 	return rc;
 }
 
-static int set_ref_paths(struct cifs_mount_ctx *mnt_ctx,
+static int setup_dfs_ref(struct cifs_mount_ctx *mnt_ctx,
 			 struct dfs_info3_param *tgt,
 			 struct dfs_ref_walk *rw)
 {
@@ -120,6 +120,7 @@ static int set_ref_paths(struct cifs_mount_ctx *mnt_ctx,
 	}
 	ref_walk_path(rw) = ref_path;
 	ref_walk_fpath(rw) = full_path;
+	ref_walk_ses(rw) = ctx->dfs_root_ses;
 	return 0;
 }
 
@@ -128,11 +129,11 @@ static int __dfs_referral_walk(struct cifs_mount_ctx *mnt_ctx,
 {
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
 	struct dfs_info3_param tgt = {};
-	bool is_refsrv;
 	int rc = -ENOENT;
 
 again:
 	do {
+		ctx->dfs_root_ses = ref_walk_ses(rw);
 		if (ref_walk_empty(rw)) {
 			rc = dfs_get_referral(mnt_ctx, ref_walk_path(rw) + 1,
 					      NULL, ref_walk_tl(rw));
@@ -158,10 +159,7 @@ static int __dfs_referral_walk(struct cifs_mount_ctx *mnt_ctx,
 			if (rc)
 				continue;
 
-			is_refsrv = tgt.server_type == DFS_TYPE_ROOT ||
-				DFS_INTERLINK(tgt.flags);
 			ref_walk_set_tgt_hint(rw);
-
 			if (tgt.flags & DFSREF_STORAGE_SERVER) {
 				rc = cifs_mount_get_tcon(mnt_ctx);
 				if (!rc)
@@ -172,12 +170,10 @@ static int __dfs_referral_walk(struct cifs_mount_ctx *mnt_ctx,
 					continue;
 			}
 
-			if (is_refsrv)
-				add_root_smb_session(mnt_ctx);
-
+			set_root_smb_session(mnt_ctx);
 			rc = ref_walk_advance(rw);
 			if (!rc) {
-				rc = set_ref_paths(mnt_ctx, &tgt, rw);
+				rc = setup_dfs_ref(mnt_ctx, &tgt, rw);
 				if (!rc) {
 					rc = -EREMOTE;
 					goto again;
@@ -193,20 +189,22 @@ static int __dfs_referral_walk(struct cifs_mount_ctx *mnt_ctx,
 	return rc;
 }
 
-static int dfs_referral_walk(struct cifs_mount_ctx *mnt_ctx)
+static int dfs_referral_walk(struct cifs_mount_ctx *mnt_ctx,
+			     struct dfs_ref_walk **rw)
 {
-	struct dfs_ref_walk *rw;
 	int rc;
 
-	rw = ref_walk_alloc();
-	if (IS_ERR(rw))
-		return PTR_ERR(rw);
+	*rw = ref_walk_alloc();
+	if (IS_ERR(*rw)) {
+		rc = PTR_ERR(*rw);
+		*rw = NULL;
+		return rc;
+	}
 
-	ref_walk_init(rw);
-	rc = set_ref_paths(mnt_ctx, NULL, rw);
+	ref_walk_init(*rw);
+	rc = setup_dfs_ref(mnt_ctx, NULL, *rw);
 	if (!rc)
-		rc = __dfs_referral_walk(mnt_ctx, rw);
-	ref_walk_free(rw);
+		rc = __dfs_referral_walk(mnt_ctx, *rw);
 	return rc;
 }
 
@@ -214,16 +212,16 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 {
 	struct cifs_sb_info *cifs_sb = mnt_ctx->cifs_sb;
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
+	struct dfs_ref_walk *rw = NULL;
 	struct cifs_tcon *tcon;
 	char *origin_fullpath;
-	bool new_tcon = true;
 	int rc;
 
 	origin_fullpath = dfs_get_path(cifs_sb, ctx->source);
 	if (IS_ERR(origin_fullpath))
 		return PTR_ERR(origin_fullpath);
 
-	rc = dfs_referral_walk(mnt_ctx);
+	rc = dfs_referral_walk(mnt_ctx, &rw);
 	if (!rc) {
 		/*
 		 * Prevent superblock from being created with any missing
@@ -241,21 +239,16 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 
 	tcon = mnt_ctx->tcon;
 	spin_lock(&tcon->tc_lock);
-	if (!tcon->origin_fullpath) {
-		tcon->origin_fullpath = origin_fullpath;
-		origin_fullpath = NULL;
-	} else {
-		new_tcon = false;
-	}
+	tcon->origin_fullpath = origin_fullpath;
+	origin_fullpath = NULL;
+	ref_walk_set_tcon(rw, tcon);
 	spin_unlock(&tcon->tc_lock);
-
-	if (new_tcon) {
-		queue_delayed_work(dfscache_wq, &tcon->dfs_cache_work,
-				   dfs_cache_get_ttl() * HZ);
-	}
+	queue_delayed_work(dfscache_wq, &tcon->dfs_cache_work,
+			   dfs_cache_get_ttl() * HZ);
 
 out:
 	kfree(origin_fullpath);
+	ref_walk_free(rw);
 	return rc;
 }
 
@@ -279,7 +272,7 @@ static int update_fs_context_dstaddr(struct smb3_fs_context *ctx)
 	return rc;
 }
 
-int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs)
+int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 {
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
 	bool nodfs = ctx->nodfs;
@@ -289,7 +282,6 @@ int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs)
 	if (rc)
 		return rc;
 
-	*isdfs = false;
 	rc = get_session(mnt_ctx, NULL);
 	if (rc)
 		return rc;
@@ -317,10 +309,15 @@ int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs)
 		return rc;
 	}
 
-	*isdfs = true;
-	add_root_smb_session(mnt_ctx);
-	rc = __dfs_mount_share(mnt_ctx);
-	dfs_put_root_smb_sessions(mnt_ctx);
+	if (!ctx->dfs_conn) {
+		ctx->dfs_conn = true;
+		cifs_mount_put_conns(mnt_ctx);
+		rc = get_session(mnt_ctx, NULL);
+	}
+	if (!rc) {
+		set_root_smb_session(mnt_ctx);
+		rc = __dfs_mount_share(mnt_ctx);
+	}
 	return rc;
 }
 
diff --git a/fs/smb/client/dfs.h b/fs/smb/client/dfs.h
index e5c4dcf837503..1aa2bc65b3bc2 100644
--- a/fs/smb/client/dfs.h
+++ b/fs/smb/client/dfs.h
@@ -19,6 +19,7 @@
 struct dfs_ref {
 	char *path;
 	char *full_path;
+	struct cifs_ses *ses;
 	struct dfs_cache_tgt_list tl;
 	struct dfs_cache_tgt_iterator *tit;
 };
@@ -38,6 +39,7 @@ struct dfs_ref_walk {
 #define ref_walk_path(w)	(ref_walk_cur(w)->path)
 #define ref_walk_fpath(w)	(ref_walk_cur(w)->full_path)
 #define ref_walk_tl(w)		(&ref_walk_cur(w)->tl)
+#define ref_walk_ses(w)	(ref_walk_cur(w)->ses)
 
 static inline struct dfs_ref_walk *ref_walk_alloc(void)
 {
@@ -60,14 +62,19 @@ static inline void __ref_walk_free(struct dfs_ref *ref)
 	kfree(ref->path);
 	kfree(ref->full_path);
 	dfs_cache_free_tgts(&ref->tl);
+	if (ref->ses)
+		cifs_put_smb_ses(ref->ses);
 	memset(ref, 0, sizeof(*ref));
 }
 
 static inline void ref_walk_free(struct dfs_ref_walk *rw)
 {
-	struct dfs_ref *ref = ref_walk_start(rw);
+	struct dfs_ref *ref;
 
-	for (; ref <= ref_walk_end(rw); ref++)
+	if (!rw)
+		return;
+
+	for (ref = ref_walk_start(rw); ref <= ref_walk_end(rw); ref++)
 		__ref_walk_free(ref);
 	kfree(rw);
 }
@@ -116,9 +123,22 @@ static inline void ref_walk_set_tgt_hint(struct dfs_ref_walk *rw)
 				       ref_walk_tit(rw));
 }
 
+static inline void ref_walk_set_tcon(struct dfs_ref_walk *rw,
+				     struct cifs_tcon *tcon)
+{
+	struct dfs_ref *ref = ref_walk_start(rw);
+
+	for (; ref <= ref_walk_cur(rw); ref++) {
+		if (WARN_ON_ONCE(!ref->ses))
+			continue;
+		list_add(&ref->ses->dlist, &tcon->dfs_ses_list);
+		ref->ses = NULL;
+	}
+}
+
 int dfs_parse_target_referral(const char *full_path, const struct dfs_info3_param *ref,
 			      struct smb3_fs_context *ctx);
-int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs);
+int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx);
 
 static inline char *dfs_get_path(struct cifs_sb_info *cifs_sb, const char *path)
 {
@@ -142,20 +162,14 @@ static inline int dfs_get_referral(struct cifs_mount_ctx *mnt_ctx, const char *p
  * references of all DFS root sessions that were used across the mount process
  * in dfs_mount_share().
  */
-static inline void dfs_put_root_smb_sessions(struct cifs_mount_ctx *mnt_ctx)
+static inline void dfs_put_root_smb_sessions(struct list_head *head)
 {
-	const struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
-	struct cifs_ses *ses = ctx->dfs_root_ses;
-	struct cifs_ses *cur;
-
-	if (!ses)
-		return;
+	struct cifs_ses *ses, *n;
 
-	for (cur = ses; cur; cur = cur->dfs_root_ses) {
-		if (cur->dfs_root_ses)
-			cifs_put_smb_ses(cur->dfs_root_ses);
+	list_for_each_entry_safe(ses, n, head, dlist) {
+		list_del_init(&ses->dlist);
+		cifs_put_smb_ses(ses);
 	}
-	cifs_put_smb_ses(ses);
 }
 
 #endif /* _CIFS_DFS_H */
diff --git a/fs/smb/client/dfs_cache.c b/fs/smb/client/dfs_cache.c
index 3cf7c88489be4..433f546055b97 100644
--- a/fs/smb/client/dfs_cache.c
+++ b/fs/smb/client/dfs_cache.c
@@ -1336,9 +1336,8 @@ void dfs_cache_refresh(struct work_struct *work)
 	struct cifs_ses *ses;
 
 	tcon = container_of(work, struct cifs_tcon, dfs_cache_work.work);
-	ses = tcon->ses->dfs_root_ses;
 
-	for (; ses; ses = ses->dfs_root_ses)
+	list_for_each_entry(ses, &tcon->dfs_ses_list, dlist)
 		refresh_ses_referral(ses);
 	refresh_tcon_referral(tcon, false);
 
diff --git a/fs/smb/client/fs_context.h b/fs/smb/client/fs_context.h
index d0a2043ea4468..52ee72e562f5f 100644
--- a/fs/smb/client/fs_context.h
+++ b/fs/smb/client/fs_context.h
@@ -287,6 +287,7 @@ struct smb3_fs_context {
 	struct cifs_ses *dfs_root_ses;
 	bool dfs_automount:1; /* set for dfs automount only */
 	enum cifs_reparse_type reparse_type;
+	bool dfs_conn:1; /* set for dfs mounts */
 };
 
 extern const struct fs_parameter_spec smb3_fs_parameters[];
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 9e8e0a01ae8eb..2e9a14e28e466 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -145,6 +145,9 @@ tcon_info_alloc(bool dir_leases_enabled, enum smb3_tcon_ref_trace trace)
 	mutex_init(&ret_buf->fscache_lock);
 #endif
 	trace_smb3_tcon_ref(ret_buf->debug_id, ret_buf->tc_count, trace);
+#ifdef CONFIG_CIFS_DFS_UPCALL
+	INIT_LIST_HEAD(&ret_buf->dfs_ses_list);
+#endif
 
 	return ret_buf;
 }
diff --git a/fs/smb/client/namespace.c b/fs/smb/client/namespace.c
index ec58c0e507244..a6655807c0865 100644
--- a/fs/smb/client/namespace.c
+++ b/fs/smb/client/namespace.c
@@ -260,7 +260,7 @@ static struct vfsmount *cifs_do_automount(struct path *path)
 		ctx->source = NULL;
 		goto out;
 	}
-	ctx->dfs_automount = is_dfs_mount(mntpt);
+	ctx->dfs_automount = ctx->dfs_conn = is_dfs_mount(mntpt);
 	cifs_dbg(FYI, "%s: ctx: source=%s UNC=%s prepath=%s dfs_automount=%d\n",
 		 __func__, ctx->source, ctx->UNC, ctx->prepath, ctx->dfs_automount);
 
-- 
2.39.5




