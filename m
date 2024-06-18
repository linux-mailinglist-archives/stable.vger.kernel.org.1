Return-Path: <stable+bounces-53256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFD290D0DB
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE581F2103F
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29410156F3C;
	Tue, 18 Jun 2024 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BTAxLjK7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC60B156F3F;
	Tue, 18 Jun 2024 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715790; cv=none; b=lMIBPnLxsRRpyNmw14bGMYiaXaIIVop0JuIQeIxm3uPUrh9YO2ld7SaTJt+yGsaxzUPJ8mUzBp5/nDElQDxZ6mjc79+AjwIzjtFJUipU8TcPp91ToprQYz+eC3PKPAKIo2pOiPprLvsPtsjmk3SIjU1k4XRbMrPapoANbmNPnEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715790; c=relaxed/simple;
	bh=u+KcRGA2rir2ZA/fenrII5IxlfbWEves2ANcgYTUKhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pACFsNwc9Tbw4flkzxamlK3ORHExGZjYvxDLSsRndAe95JPQD943uLb9NdPMb8Gig3SD+yW11Y8QtTUz8ztbTiK4bNTan/S3Q0Rji0cz7TRTXgwneuEEsl7/lPDkr19qO3viWdN/+G86HFxuDN+t9dbrQ67oTnhIxXR88N7Q6io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BTAxLjK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63487C3277B;
	Tue, 18 Jun 2024 13:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715790;
	bh=u+KcRGA2rir2ZA/fenrII5IxlfbWEves2ANcgYTUKhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BTAxLjK7nbyK3ndGPmEALQnu/PzFYIeqGmyHJxGmybF4jqrj0qzRpQZtxDbND0JK6
	 ZKA/VMj77EeajeJ2MWw4ip3bSRYVDhLT25bum6vuZdlACdC4kvDY3v74Vc4syJmRjZ
	 SxPb5ziqK2LHsFn3z5Aco3jk/EV1corIeLGBwFi0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 428/770] NFSD: simplify locking for network notifier.
Date: Tue, 18 Jun 2024 14:34:41 +0200
Message-ID: <20240618123423.804676083@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.de>

[ Upstream commit d057cfec4940ce6eeffa22b4a71dec203b06cd55 ]

nfsd currently maintains an open-coded read/write semaphore (refcount
and wait queue) for each network namespace to ensure the nfs service
isn't shut down while the notifier is running.

This is excessive.  As there is unlikely to be contention between
notifiers and they run without sleeping, a single spinlock is sufficient
to avoid problems.

Signed-off-by: NeilBrown <neilb@suse.de>
[ cel: ensure nfsd_notifier_lock is static ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/netns.h  |  3 ---
 fs/nfsd/nfsctl.c |  2 --
 fs/nfsd/nfssvc.c | 38 ++++++++++++++++++++------------------
 3 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 1fd59eb0730bb..021acdc0d03bb 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -131,9 +131,6 @@ struct nfsd_net {
 	 */
 	int keep_active;
 
-	wait_queue_head_t ntf_wq;
-	atomic_t ntf_refcnt;
-
 	/*
 	 * clientid and stateid data for construction of net unique COPY
 	 * stateids.
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 53076c5afe62c..504b169d27881 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1484,8 +1484,6 @@ static __net_init int nfsd_init_net(struct net *net)
 	nn->clientid_counter = nn->clientid_base + 1;
 	nn->s2s_cp_cl_id = nn->clientid_counter++;
 
-	atomic_set(&nn->ntf_refcnt, 0);
-	init_waitqueue_head(&nn->ntf_wq);
 	seqlock_init(&nn->boot_lock);
 
 	return 0;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 8d49dfbe03f85..8554bc7ff4322 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -434,6 +434,7 @@ static void nfsd_shutdown_net(struct net *net)
 	nfsd_shutdown_generic();
 }
 
+static DEFINE_SPINLOCK(nfsd_notifier_lock);
 static int nfsd_inetaddr_event(struct notifier_block *this, unsigned long event,
 	void *ptr)
 {
@@ -443,18 +444,17 @@ static int nfsd_inetaddr_event(struct notifier_block *this, unsigned long event,
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct sockaddr_in sin;
 
-	if ((event != NETDEV_DOWN) ||
-	    !atomic_inc_not_zero(&nn->ntf_refcnt))
+	if (event != NETDEV_DOWN || !nn->nfsd_serv)
 		goto out;
 
+	spin_lock(&nfsd_notifier_lock);
 	if (nn->nfsd_serv) {
 		dprintk("nfsd_inetaddr_event: removed %pI4\n", &ifa->ifa_local);
 		sin.sin_family = AF_INET;
 		sin.sin_addr.s_addr = ifa->ifa_local;
 		svc_age_temp_xprts_now(nn->nfsd_serv, (struct sockaddr *)&sin);
 	}
-	atomic_dec(&nn->ntf_refcnt);
-	wake_up(&nn->ntf_wq);
+	spin_unlock(&nfsd_notifier_lock);
 
 out:
 	return NOTIFY_DONE;
@@ -474,10 +474,10 @@ static int nfsd_inet6addr_event(struct notifier_block *this,
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct sockaddr_in6 sin6;
 
-	if ((event != NETDEV_DOWN) ||
-	    !atomic_inc_not_zero(&nn->ntf_refcnt))
+	if (event != NETDEV_DOWN || !nn->nfsd_serv)
 		goto out;
 
+	spin_lock(&nfsd_notifier_lock);
 	if (nn->nfsd_serv) {
 		dprintk("nfsd_inet6addr_event: removed %pI6\n", &ifa->addr);
 		sin6.sin6_family = AF_INET6;
@@ -486,8 +486,8 @@ static int nfsd_inet6addr_event(struct notifier_block *this,
 			sin6.sin6_scope_id = ifa->idev->dev->ifindex;
 		svc_age_temp_xprts_now(nn->nfsd_serv, (struct sockaddr *)&sin6);
 	}
-	atomic_dec(&nn->ntf_refcnt);
-	wake_up(&nn->ntf_wq);
+	spin_unlock(&nfsd_notifier_lock);
+
 out:
 	return NOTIFY_DONE;
 }
@@ -504,7 +504,6 @@ static void nfsd_last_thread(struct svc_serv *serv, struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	atomic_dec(&nn->ntf_refcnt);
 	/* check if the notifier still has clients */
 	if (atomic_dec_return(&nfsd_notifier_refcount) == 0) {
 		unregister_inetaddr_notifier(&nfsd_inetaddr_notifier);
@@ -512,7 +511,6 @@ static void nfsd_last_thread(struct svc_serv *serv, struct net *net)
 		unregister_inet6addr_notifier(&nfsd_inet6addr_notifier);
 #endif
 	}
-	wait_event(nn->ntf_wq, atomic_read(&nn->ntf_refcnt) == 0);
 
 	/*
 	 * write_ports can create the server without actually starting
@@ -624,6 +622,7 @@ int nfsd_create_serv(struct net *net)
 {
 	int error;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_serv *serv;
 
 	WARN_ON(!mutex_is_locked(&nfsd_mutex));
 	if (nn->nfsd_serv) {
@@ -633,21 +632,23 @@ int nfsd_create_serv(struct net *net)
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
-	nn->nfsd_serv = svc_create_pooled(&nfsd_program, nfsd_max_blksize,
-						&nfsd_thread_sv_ops);
-	if (nn->nfsd_serv == NULL)
+	serv = svc_create_pooled(&nfsd_program, nfsd_max_blksize,
+				 &nfsd_thread_sv_ops);
+	if (serv == NULL)
 		return -ENOMEM;
 
-	nn->nfsd_serv->sv_maxconn = nn->max_connections;
-	error = svc_bind(nn->nfsd_serv, net);
+	serv->sv_maxconn = nn->max_connections;
+	error = svc_bind(serv, net);
 	if (error < 0) {
 		/* NOT nfsd_put() as notifiers (see below) haven't
 		 * been set up yet.
 		 */
-		svc_put(nn->nfsd_serv);
-		nn->nfsd_serv = NULL;
+		svc_put(serv);
 		return error;
 	}
+	spin_lock(&nfsd_notifier_lock);
+	nn->nfsd_serv = serv;
+	spin_unlock(&nfsd_notifier_lock);
 
 	set_max_drc();
 	/* check if the notifier is already set */
@@ -657,7 +658,6 @@ int nfsd_create_serv(struct net *net)
 		register_inet6addr_notifier(&nfsd_inet6addr_notifier);
 #endif
 	}
-	atomic_inc(&nn->ntf_refcnt);
 	nfsd_reset_boot_verifier(nn);
 	return 0;
 }
@@ -701,7 +701,9 @@ void nfsd_put(struct net *net)
 	if (kref_put(&nn->nfsd_serv->sv_refcnt, nfsd_noop)) {
 		svc_shutdown_net(nn->nfsd_serv, net);
 		svc_destroy(&nn->nfsd_serv->sv_refcnt);
+		spin_lock(&nfsd_notifier_lock);
 		nn->nfsd_serv = NULL;
+		spin_unlock(&nfsd_notifier_lock);
 	}
 }
 
-- 
2.43.0




