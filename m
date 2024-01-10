Return-Path: <stable+bounces-9375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E0482320F
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1B61F232A6
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6391BDF1;
	Wed,  3 Jan 2024 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2AqQYVxM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79EC1BDE9;
	Wed,  3 Jan 2024 17:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FA1C433C7;
	Wed,  3 Jan 2024 17:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301328;
	bh=b1v6nD6rzotLHWJnm55aq3EshJbsWBTKuxXe5rDmLeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2AqQYVxMgSF4gBkp3dLMWR90uot9nLdb1nJIQ3yRQJ0HPc6X3NA7lqcS8j6t0d4F1
	 NkVYvP4h1lzTpHn8ki7RciotRrtDqZ181+H5q3kNl69sh/2BE0EE4mGLGn/z+MvsA5
	 Uoq5WNhEc+HS5mrBLSzOvj78qyN1/X6gFtxM77Lo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 078/100] nfsd: separate nfsd_last_thread() from nfsd_put()
Date: Wed,  3 Jan 2024 17:55:07 +0100
Message-ID: <20240103164907.792959492@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164856.169912722@linuxfoundation.org>
References: <20240103164856.169912722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.de>

[ Upstream commit 9f28a971ee9fdf1bf8ce8c88b103f483be610277 ]

Now that the last nfsd thread is stopped by an explicit act of calling
svc_set_num_threads() with a count of zero, we only have a limited
number of places that can happen, and don't need to call
nfsd_last_thread() in nfsd_put()

So separate that out and call it at the two places where the number of
threads is set to zero.

Move the clearing of ->nfsd_serv and the call to svc_xprt_destroy_all()
into nfsd_last_thread(), as they are really part of the same action.

nfsd_put() is now a thin wrapper around svc_put(), so make it a static
inline.

nfsd_put() cannot be called after nfsd_last_thread(), so in a couple of
places we have to use svc_put() instead.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 2a501f55cd64 ("nfsd: call nfsd_last_thread() before final nfsd_put()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfsd.h   |  7 ++++++-
 fs/nfsd/nfssvc.c | 52 ++++++++++++++++++------------------------------
 2 files changed, 25 insertions(+), 34 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 09726c5b9a317..fddd70372e4cb 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -97,7 +97,12 @@ int		nfsd_pool_stats_open(struct inode *, struct file *);
 int		nfsd_pool_stats_release(struct inode *, struct file *);
 void		nfsd_shutdown_threads(struct net *net);
 
-void		nfsd_put(struct net *net);
+static inline void nfsd_put(struct net *net)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	svc_put(nn->nfsd_serv);
+}
 
 bool		i_am_nfsd(void);
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index f6cc99af81925..6ac18399fed2b 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -523,9 +523,14 @@ static struct notifier_block nfsd_inet6addr_notifier = {
 /* Only used under nfsd_mutex, so this atomic may be overkill: */
 static atomic_t nfsd_notifier_refcount = ATOMIC_INIT(0);
 
-static void nfsd_last_thread(struct svc_serv *serv, struct net *net)
+static void nfsd_last_thread(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv = nn->nfsd_serv;
+
+	spin_lock(&nfsd_notifier_lock);
+	nn->nfsd_serv = NULL;
+	spin_unlock(&nfsd_notifier_lock);
 
 	/* check if the notifier still has clients */
 	if (atomic_dec_return(&nfsd_notifier_refcount) == 0) {
@@ -535,6 +540,8 @@ static void nfsd_last_thread(struct svc_serv *serv, struct net *net)
 #endif
 	}
 
+	svc_xprt_destroy_all(serv, net);
+
 	/*
 	 * write_ports can create the server without actually starting
 	 * any threads--if we get shut down before any threads are
@@ -625,7 +632,8 @@ void nfsd_shutdown_threads(struct net *net)
 	svc_get(serv);
 	/* Kill outstanding nfsd threads */
 	svc_set_num_threads(serv, NULL, 0);
-	nfsd_put(net);
+	nfsd_last_thread(net);
+	svc_put(serv);
 	mutex_unlock(&nfsd_mutex);
 }
 
@@ -655,9 +663,6 @@ int nfsd_create_serv(struct net *net)
 	serv->sv_maxconn = nn->max_connections;
 	error = svc_bind(serv, net);
 	if (error < 0) {
-		/* NOT nfsd_put() as notifiers (see below) haven't
-		 * been set up yet.
-		 */
 		svc_put(serv);
 		return error;
 	}
@@ -700,29 +705,6 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
 	return 0;
 }
 
-/* This is the callback for kref_put() below.
- * There is no code here as the first thing to be done is
- * call svc_shutdown_net(), but we cannot get the 'net' from
- * the kref.  So do all the work when kref_put returns true.
- */
-static void nfsd_noop(struct kref *ref)
-{
-}
-
-void nfsd_put(struct net *net)
-{
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	if (kref_put(&nn->nfsd_serv->sv_refcnt, nfsd_noop)) {
-		svc_xprt_destroy_all(nn->nfsd_serv, net);
-		nfsd_last_thread(nn->nfsd_serv, net);
-		svc_destroy(&nn->nfsd_serv->sv_refcnt);
-		spin_lock(&nfsd_notifier_lock);
-		nn->nfsd_serv = NULL;
-		spin_unlock(&nfsd_notifier_lock);
-	}
-}
-
 int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 {
 	int i = 0;
@@ -773,7 +755,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
 		if (err)
 			break;
 	}
-	nfsd_put(net);
+	svc_put(nn->nfsd_serv);
 	return err;
 }
 
@@ -788,6 +770,7 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 	int	error;
 	bool	nfsd_up_before;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 
 	mutex_lock(&nfsd_mutex);
 	dprintk("nfsd: creating service\n");
@@ -807,22 +790,25 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 		goto out;
 
 	nfsd_up_before = nn->nfsd_net_up;
+	serv = nn->nfsd_serv;
 
 	error = nfsd_startup_net(net, cred);
 	if (error)
 		goto out_put;
-	error = svc_set_num_threads(nn->nfsd_serv, NULL, nrservs);
+	error = svc_set_num_threads(serv, NULL, nrservs);
 	if (error)
 		goto out_shutdown;
-	error = nn->nfsd_serv->sv_nrthreads;
+	error = serv->sv_nrthreads;
+	if (error == 0)
+		nfsd_last_thread(net);
 out_shutdown:
 	if (error < 0 && !nfsd_up_before)
 		nfsd_shutdown_net(net);
 out_put:
 	/* Threads now hold service active */
 	if (xchg(&nn->keep_active, 0))
-		nfsd_put(net);
-	nfsd_put(net);
+		svc_put(serv);
+	svc_put(serv);
 out:
 	mutex_unlock(&nfsd_mutex);
 	return error;
-- 
2.43.0




