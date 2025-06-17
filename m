Return-Path: <stable+bounces-154270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 980DAADD931
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07534A421F
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30292235067;
	Tue, 17 Jun 2025 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uhmOgI1P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71E188006;
	Tue, 17 Jun 2025 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178651; cv=none; b=LMCpu9RvR1BhSg7r01Q8uJoR/f9seFmN/wMdtZ29xEPPuEHNMEdaVI4p+ZywQBFl1ASOX8TojJ7dmahfxgzF9NSSGoHa/kICqWBiUv6voMwg2BXwQG9k4VM1PwkAddzuaRu36K2GzdVmo7LntXg/uPi2SFUaQD1WK3NGaaH2w9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178651; c=relaxed/simple;
	bh=ajJxX4YxZ7UXonvg/HWDqTJkfAZgV4NiEg9RNvS68Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcUxNmRIns2ochkU/fs073pGYn72l5QvkKI9WyE9PHTf6533mBjG5gW759+wiAy08RGyWUaxlxc3InjjFW0FXSRUi/DFD3hT/lW9yUvpabt69+Mub9WYJuoHolIy3v0FWUToL25hTZQfMDsgQ61F1zeKoLIVcBwgrekIr8v/6nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uhmOgI1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFCAC4CEE3;
	Tue, 17 Jun 2025 16:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178649;
	bh=ajJxX4YxZ7UXonvg/HWDqTJkfAZgV4NiEg9RNvS68Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uhmOgI1PgWVDTzIVpkxAXTC12MerPSoQDoUDCatquL8RX0euegKbJUA3eacICN31U
	 iwO6eMa0F3jlbXBbD5JLq6tcAG4iRhpJvl1EQzvdaVsiyV7JXxVxfhLRu5gvCVLu4Q
	 mSZnxS9nV75uQVna1Q2/EmgG+iT1MdG5hyhv09yw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	NeilBrown <neil@brown.name>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 482/780] nfs_localio: change nfsd_file_put_local() to take a pointer to __rcu pointer
Date: Tue, 17 Jun 2025 17:23:10 +0200
Message-ID: <20250617152511.115939579@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neil@brown.name>

[ Upstream commit c25a89770d1f216dcedfc2d25d56b604f62ce0bd ]

Instead of calling xchg() and unrcu_pointer() before
nfsd_file_put_local(), we now pass pointer to the __rcu pointer and call
xchg() and unrcu_pointer() inside that function.

Where unrcu_pointer() is currently called the internals of "struct
nfsd_file" are not known and that causes older compilers such as gcc-8
to complain.

In some cases we have a __kernel (aka normal) pointer not an __rcu
pointer so we need to cast it to __rcu first.  This is strictly a
weakening so no information is lost.  Somewhat surprisingly, this cast
is accepted by gcc-8.

This has the pleasing result that the cmpxchg() which sets ro_file and
rw_file, and also the xchg() which clears them, are both now in the nfsd
code.

Reported-by: Pali Rohár <pali@kernel.org>
Reported-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
Signed-off-by: NeilBrown <neil@brown.name>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/localio.c           | 11 +++++++++--
 fs/nfs_common/nfslocalio.c | 24 ++++++------------------
 fs/nfsd/filecache.c        | 11 ++++++++---
 fs/nfsd/filecache.h        |  2 +-
 include/linux/nfslocalio.h | 23 ++++++++++++-----------
 5 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 030a54c8c9d8b..e6d36b3d3fc05 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -207,9 +207,16 @@ void nfs_local_probe_async(struct nfs_client *clp)
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe_async);
 
-static inline void nfs_local_file_put(struct nfsd_file *nf)
+static inline void nfs_local_file_put(struct nfsd_file *localio)
 {
-	nfs_to_nfsd_file_put_local(nf);
+	/* nfs_to_nfsd_file_put_local() expects an __rcu pointer
+	 * but we have a __kernel pointer.  It is always safe
+	 * to cast a __kernel pointer to an __rcu pointer
+	 * because the cast only weakens what is known about the pointer.
+	 */
+	struct nfsd_file __rcu *nf = (struct nfsd_file __rcu*) localio;
+
+	nfs_to_nfsd_file_put_local(&nf);
 }
 
 /*
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 1dd5a8cca064d..05c7c16e37ab4 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -170,9 +170,6 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 	while ((nfl = list_first_entry_or_null(&nfs_uuid->files,
 					       struct nfs_file_localio,
 					       list)) != NULL) {
-		struct nfsd_file *ro_nf;
-		struct nfsd_file *rw_nf;
-
 		/* If nfs_uuid is already NULL, nfs_close_local_fh is
 		 * closing and we must wait, else we unlink and close.
 		 */
@@ -189,17 +186,14 @@ static bool nfs_uuid_put(nfs_uuid_t *nfs_uuid)
 			continue;
 		}
 
-		ro_nf = unrcu_pointer(xchg(&nfl->ro_file, NULL));
-		rw_nf = unrcu_pointer(xchg(&nfl->rw_file, NULL));
-
 		/* Remove nfl from nfs_uuid->files list */
 		list_del_init(&nfl->list);
 		spin_unlock(&nfs_uuid->lock);
-		if (ro_nf)
-			nfs_to_nfsd_file_put_local(ro_nf);
-		if (rw_nf)
-			nfs_to_nfsd_file_put_local(rw_nf);
+
+		nfs_to_nfsd_file_put_local(&nfl->ro_file);
+		nfs_to_nfsd_file_put_local(&nfl->rw_file);
 		cond_resched();
+
 		spin_lock(&nfs_uuid->lock);
 		/* Now we can allow racing nfs_close_local_fh() to
 		 * skip the locking.
@@ -303,8 +297,6 @@ EXPORT_SYMBOL_GPL(nfs_open_local_fh);
 
 void nfs_close_local_fh(struct nfs_file_localio *nfl)
 {
-	struct nfsd_file *ro_nf;
-	struct nfsd_file *rw_nf;
 	nfs_uuid_t *nfs_uuid;
 
 	rcu_read_lock();
@@ -337,12 +329,8 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
 	spin_unlock(&nfs_uuid->lock);
 	rcu_read_unlock();
 
-	ro_nf = unrcu_pointer(xchg(&nfl->ro_file, NULL));
-	rw_nf = unrcu_pointer(xchg(&nfl->rw_file, NULL));
-	if (ro_nf)
-		nfs_to_nfsd_file_put_local(ro_nf);
-	if (rw_nf)
-		nfs_to_nfsd_file_put_local(rw_nf);
+	nfs_to_nfsd_file_put_local(&nfl->ro_file);
+	nfs_to_nfsd_file_put_local(&nfl->rw_file);
 
 	/* Remove nfl from nfs_uuid->files list and signal nfs_uuid_put()
 	 * that we are done.  The moment we drop the spinlock the
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index eedf2af8ee6ec..e108b6c705b45 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -378,11 +378,16 @@ nfsd_file_put(struct nfsd_file *nf)
  * the reference of the nfsd_file.
  */
 struct net *
-nfsd_file_put_local(struct nfsd_file *nf)
+nfsd_file_put_local(struct nfsd_file __rcu **pnf)
 {
-	struct net *net = nf->nf_net;
+	struct nfsd_file *nf;
+	struct net *net = NULL;
 
-	nfsd_file_put(nf);
+	nf = unrcu_pointer(xchg(pnf, NULL));
+	if (nf) {
+		net = nf->nf_net;
+		nfsd_file_put(nf);
+	}
 	return net;
 }
 
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index cd02f91aaef13..722b26c71e454 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -62,7 +62,7 @@ void nfsd_file_cache_shutdown(void);
 int nfsd_file_cache_start_net(struct net *net);
 void nfsd_file_cache_shutdown_net(struct net *net);
 void nfsd_file_put(struct nfsd_file *nf);
-struct net *nfsd_file_put_local(struct nfsd_file *nf);
+struct net *nfsd_file_put_local(struct nfsd_file __rcu **nf);
 struct nfsd_file *nfsd_file_get_local(struct nfsd_file *nf);
 struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
 struct file *nfsd_file_file(struct nfsd_file *nf);
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index c3f34bae60e13..5c7c92659e736 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -50,10 +50,6 @@ void nfs_localio_invalidate_clients(struct list_head *nn_local_clients,
 				    spinlock_t *nn_local_clients_lock);
 
 /* localio needs to map filehandle -> struct nfsd_file */
-extern struct nfsd_file *
-nfsd_open_local_fh(struct net *, struct auth_domain *, struct rpc_clnt *,
-		   const struct cred *, const struct nfs_fh *,
-		   const fmode_t) __must_hold(rcu);
 void nfs_close_local_fh(struct nfs_file_localio *);
 
 struct nfsd_localio_operations {
@@ -64,8 +60,9 @@ struct nfsd_localio_operations {
 						struct rpc_clnt *,
 						const struct cred *,
 						const struct nfs_fh *,
+						struct nfsd_file __rcu **pnf,
 						const fmode_t);
-	struct net *(*nfsd_file_put_local)(struct nfsd_file *);
+	struct net *(*nfsd_file_put_local)(struct nfsd_file __rcu **);
 	struct nfsd_file *(*nfsd_file_get_local)(struct nfsd_file *);
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
 } ____cacheline_aligned;
@@ -76,6 +73,7 @@ extern const struct nfsd_localio_operations *nfs_to;
 struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *,
 		   struct rpc_clnt *, const struct cred *,
 		   const struct nfs_fh *, struct nfs_file_localio *,
+		   struct nfsd_file __rcu **pnf,
 		   const fmode_t);
 
 static inline void nfs_to_nfsd_net_put(struct net *net)
@@ -90,16 +88,19 @@ static inline void nfs_to_nfsd_net_put(struct net *net)
 	rcu_read_unlock();
 }
 
-static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)
+static inline void nfs_to_nfsd_file_put_local(struct nfsd_file __rcu **localio)
 {
 	/*
-	 * Must not hold RCU otherwise nfsd_file_put() can easily trigger:
-	 * "Voluntary context switch within RCU read-side critical section!"
-	 * by scheduling deep in underlying filesystem (e.g. XFS).
+	 * Either *localio must be guaranteed to be non-NULL, or caller
+	 * must prevent nfsd shutdown from completing as nfs_close_local_fh()
+	 * does by blocking the nfs_uuid from being finally put.
 	 */
-	struct net *net = nfs_to->nfsd_file_put_local(localio);
+	struct net *net;
 
-	nfs_to_nfsd_net_put(net);
+	net = nfs_to->nfsd_file_put_local(localio);
+
+	if (net)
+		nfs_to_nfsd_net_put(net);
 }
 
 #else   /* CONFIG_NFS_LOCALIO */
-- 
2.39.5




