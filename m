Return-Path: <stable+bounces-268521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QVW2AXkpPWoIyQgAu9opvQ
	(envelope-from <stable+bounces-268521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:13:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C8A6C608C
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:13:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=yuOJDxRx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268521-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268521-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC4E830451C6
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362622E040D;
	Thu, 25 Jun 2026 13:12:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09562DCC13;
	Thu, 25 Jun 2026 13:12:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393125; cv=none; b=D8As/RI85s3BPiX22X53U7brQiOnTF+iMDAmNxJWYbZS0s4bn0TlCWPBpGrZMItnknQ0biZmbn1O8wp0pTHaBHN4KZpMMXcOXM4K4xVpW0QP/ckoceAHCQc0XmTavtbcG1Kgv9PKBDLBaJAPe0RaqAQ7P99b+F8qN2pwaiBPRFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393125; c=relaxed/simple;
	bh=q4fyDn/Icl583NHfYEkPQmUm2JEggRWHMJEiVjap2no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTICEU7vvbcZKorCkOumVhis8RvynBCt63Q/5HDmAQvx9Me3CtaDAgxWM5leyYFpiQxKlAgqlALD+41s9sempstiF5D42ihwSBg/8tbE1Z+kSzd27mcLcNZkvpD2hvy6+/wfo/mBsTEUJcPbCyt5907RxzXTLJ0bbYBrlkD3UmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yuOJDxRx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115091F000E9;
	Thu, 25 Jun 2026 13:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782393123;
	bh=EGqgHoV/y27U38e24N4KegEPUrpb7AgEpKDwF9Y8D64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yuOJDxRxAUl4A2PLr9t+lG4+j8swgf7duiQiSyHrAJIUjFa79RcrAAOj++9lBU9ZI
	 r1D0+tjbaY5SVUOOET7CqlrAleqwwCt1omaY2qDBAxVxo3kVwZ2cR91XpBkXpTzoOO
	 lOCMpNXwqO/prKE9cyBGf/p5rk6WiNHXHi4Ss07Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Alexandr Alexandrov <alexandr.alexandrov@oracle.com>,
	Yang Erkun <yangerkun@huawei.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 7.1 03/21] Revert "NFSD: Defer sub-object cleanup in export put callbacks"
Date: Thu, 25 Jun 2026 14:03:55 +0100
Message-ID: <20260625125613.682733239@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625125613.243729608@linuxfoundation.org>
References: <20260625125613.243729608@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268521-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jlayton@kernel.org,m:alexandr.alexandrov@oracle.com,m:yangerkun@huawei.com,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,oracle.com:email,vger.kernel.org:from_smtp,huawei.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98C8A6C608C

7.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Erkun <yangerkun@huawei.com>

commit 516403d4d85607fdef3ca41d4a56b54e5566fa9a upstream.

This reverts commit 48db892356d6cb80f6942885545de4a6dd8d2a29.

Commit 48db892356d6 ("NFSD: Defer sub-object cleanup in export
put callbacks") moved path_put() and auth_domain_put() out of
svc_export_put() and expkey_put() and behind queue_rcu_work() to
close a claimed use-after-free in e_show() and c_show() against
ex_path and ex_client->name. Discussion in [1] shows neither
the diagnosis nor the remedy survives review.

The downstream teardown of both sub-objects is already RCU-deferred.
auth_domain_put() reaches svcauth_unix_domain_release(), which frees
the unix_domain and its ->name through call_rcu(). path_put()
reaches dentry_free(), which frees the dentry through call_rcu(),
and prepend_path() is already structured to tolerate concurrent
dentry teardown. A reader in cache_seq_start_rcu() therefore
observes both sub-objects through the next grace period regardless
of whether svc_export_put() runs synchronously, so the synchronous
form was never unsafe.

The crash signature in the report cited by commit 48db892356d6
("NFSD: Defer sub-object cleanup in export put callbacks") has a
different root cause: a /proc/net/rpc cache file held open across
network-namespace exit lets cache_destroy_net() free cd->hash_table
while a reader is still walking it. The correct fix pins cd->net for
the open fd's lifetime and does not require any deferral inside
svc_export_put().

Meanwhile, deferring path_put() out of svc_export_put() reintroduces
the regression that commit 69d803c40ede ("nfsd: Revert "nfsd:
release svc_expkey/svc_export with rcu_work"") repaired: after
"exportfs -r" drops the last cache reference, the mount reference
held through ex_path lingers in the workqueue, so a subsequent
umount fails with EBUSY.

Restore the synchronous path_put() and auth_domain_put() in
svc_export_put() and expkey_put() and the call_rcu()/kfree_rcu()
free of the containing structures. The unrelated fix for
ex_uuid/ex_stats from commit 2530766492ec ("nfsd: fix UAF when
access ex_uuid or ex_stats") is preserved.

Link: https://lore.kernel.org/all/10019b42-4589-4f9f-8d5b-d8197db1ce3c@huawei.com/ [1]
Fixes: 48db892356d6 ("NFSD: Defer sub-object cleanup in export put callbacks")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Alexandr Alexandrov <alexandr.alexandrov@oracle.com>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/export.c |   63 +++++++------------------------------------------------
 fs/nfsd/export.h |    7 +-----
 fs/nfsd/nfsctl.c |    8 ------
 3 files changed, 12 insertions(+), 66 deletions(-)

--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -36,30 +36,19 @@
  * second map contains a reference to the entry in the first map.
  */
 
-static struct workqueue_struct *nfsd_export_wq;
-
 #define	EXPKEY_HASHBITS		8
 #define	EXPKEY_HASHMAX		(1 << EXPKEY_HASHBITS)
 #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
 
-static void expkey_release(struct work_struct *work)
+static void expkey_put(struct kref *ref)
 {
-	struct svc_expkey *key = container_of(to_rcu_work(work),
-					      struct svc_expkey, ek_rwork);
+	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
 
 	if (test_bit(CACHE_VALID, &key->h.flags) &&
 	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
 		path_put(&key->ek_path);
 	auth_domain_put(key->ek_client);
-	kfree(key);
-}
-
-static void expkey_put(struct kref *ref)
-{
-	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
-
-	INIT_RCU_WORK(&key->ek_rwork, expkey_release);
-	queue_rcu_work(nfsd_export_wq, &key->ek_rwork);
+	kfree_rcu(key, ek_rcu);
 }
 
 static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
@@ -364,13 +353,11 @@ static void export_stats_destroy(struct
 					    EXP_STATS_COUNTERS_NUM);
 }
 
-static void svc_export_release(struct work_struct *work)
+static void svc_export_release(struct rcu_head *rcu_head)
 {
-	struct svc_export *exp = container_of(to_rcu_work(work),
-					      struct svc_export, ex_rwork);
+	struct svc_export *exp = container_of(rcu_head, struct svc_export,
+			ex_rcu);
 
-	path_put(&exp->ex_path);
-	auth_domain_put(exp->ex_client);
 	nfsd4_fslocs_free(&exp->ex_fslocs);
 	export_stats_destroy(exp->ex_stats);
 	kfree(exp->ex_stats);
@@ -382,8 +369,9 @@ static void svc_export_put(struct kref *
 {
 	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
 
-	INIT_RCU_WORK(&exp->ex_rwork, svc_export_release);
-	queue_rcu_work(nfsd_export_wq, &exp->ex_rwork);
+	path_put(&exp->ex_path);
+	auth_domain_put(exp->ex_client);
+	call_rcu(&exp->ex_rcu, svc_export_release);
 }
 
 static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
@@ -1492,36 +1480,6 @@ const struct seq_operations nfs_exports_
 	.show	= e_show,
 };
 
-/**
- * nfsd_export_wq_init - allocate the export release workqueue
- *
- * Called once at module load. The workqueue runs deferred svc_export and
- * svc_expkey release work scheduled by queue_rcu_work() in the cache put
- * callbacks.
- *
- * Return values:
- *   %0: workqueue allocated
- *   %-ENOMEM: allocation failed
- */
-int nfsd_export_wq_init(void)
-{
-	nfsd_export_wq = alloc_workqueue("nfsd_export", WQ_UNBOUND, 0);
-	if (!nfsd_export_wq)
-		return -ENOMEM;
-	return 0;
-}
-
-/**
- * nfsd_export_wq_shutdown - drain and free the export release workqueue
- *
- * Called once at module unload. Per-namespace teardown in
- * nfsd_export_shutdown() has already drained all deferred work.
- */
-void nfsd_export_wq_shutdown(void)
-{
-	destroy_workqueue(nfsd_export_wq);
-}
-
 /*
  * Initialize the exports module.
  */
@@ -1583,9 +1541,6 @@ nfsd_export_shutdown(struct net *net)
 
 	cache_unregister_net(nn->svc_expkey_cache, net);
 	cache_unregister_net(nn->svc_export_cache, net);
-	/* Drain deferred export and expkey release work. */
-	rcu_barrier();
-	flush_workqueue(nfsd_export_wq);
 	cache_destroy_net(nn->svc_expkey_cache, net);
 	cache_destroy_net(nn->svc_export_cache, net);
 	svcauth_unix_purge(net);
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -7,7 +7,6 @@
 
 #include <linux/sunrpc/cache.h>
 #include <linux/percpu_counter.h>
-#include <linux/workqueue.h>
 #include <uapi/linux/nfsd/export.h>
 #include <linux/nfs4.h>
 
@@ -76,7 +75,7 @@ struct svc_export {
 	u32			ex_layout_types;
 	struct nfsd4_deviceid_map *ex_devid_map;
 	struct cache_detail	*cd;
-	struct rcu_work		ex_rwork;
+	struct rcu_head		ex_rcu;
 	unsigned long		ex_xprtsec_modes;
 	struct export_stats	*ex_stats;
 };
@@ -93,7 +92,7 @@ struct svc_expkey {
 	u32			ek_fsid[6];
 
 	struct path		ek_path;
-	struct rcu_work		ek_rwork;
+	struct rcu_head		ek_rcu;
 };
 
 #define EX_ISSYNC(exp)		(!((exp)->ex_flags & NFSEXP_ASYNC))
@@ -111,8 +110,6 @@ __be32 check_nfsd_access(struct svc_expo
 /*
  * Function declarations
  */
-int			nfsd_export_wq_init(void);
-void			nfsd_export_wq_shutdown(void);
 int			nfsd_export_init(struct net *);
 void			nfsd_export_shutdown(struct net *);
 void			nfsd_export_flush(struct net *);
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2320,12 +2320,9 @@ static int __init init_nfsd(void)
 	if (retval)
 		goto out_free_pnfs;
 	nfsd_lockd_init();	/* lockd->nfsd callbacks */
-	retval = nfsd_export_wq_init();
-	if (retval)
-		goto out_free_lockd;
 	retval = register_pernet_subsys(&nfsd_net_ops);
 	if (retval < 0)
-		goto out_free_export_wq;
+		goto out_free_lockd;
 	retval = register_cld_notifier();
 	if (retval)
 		goto out_free_subsys;
@@ -2354,8 +2351,6 @@ out_free_cld:
 	unregister_cld_notifier();
 out_free_subsys:
 	unregister_pernet_subsys(&nfsd_net_ops);
-out_free_export_wq:
-	nfsd_export_wq_shutdown();
 out_free_lockd:
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
@@ -2376,7 +2371,6 @@ static void __exit exit_nfsd(void)
 	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
-	nfsd_export_wq_shutdown();
 	nfsd_drc_slab_free();
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();



