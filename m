Return-Path: <stable+bounces-53266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D09D90D0E4
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DC21C23F0A
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F33F18EFCF;
	Tue, 18 Jun 2024 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AkNkVPBc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC4E13BAFB;
	Tue, 18 Jun 2024 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715820; cv=none; b=QHVZdfRi8LUEH+adaHi32WfmzlJ1WRjrsYePfoJjcHJNGORfjw7b1cfmWZaoEy9W1QVY7SkfSoRKtG7ZWFihMy2Nq8BHAjI1jRAnQnKEJLQO9BnHT5kZozU3Czz6j8ERCEAKHJ9eLjDSAEhxsKXgY6zsNSeUBRGy90PisvMnFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715820; c=relaxed/simple;
	bh=iRQTd6yLYYFffjMw0OcOh34bmKG/lXg1uT0+5QA7ec4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFSjuY+KB4Io9aw+AztUftNdsrFPdhHvM8Ms2/iOiEDoxZlc1XQtnZxbodrJwhfvAsvXmlvu2nENDFNXCQGM4SU1qR+FSObFC6b9xE8Cf4aaRNFjDXt0ZqFUwXH1CeymiEP+3pJPuHnr3ocHcPuF91FU621U17topKhpnkTjHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AkNkVPBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3A7C3277B;
	Tue, 18 Jun 2024 13:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715820;
	bh=iRQTd6yLYYFffjMw0OcOh34bmKG/lXg1uT0+5QA7ec4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AkNkVPBcqErb0Mj6tK1RmyLEIvzBgHD8Dqxtk3GuQ12glIYO0dYTDIgz1qR8LTmuF
	 pYm71Y5A8cnliLC3TvxHVVau4+WHmt7V+KMtR1xPgmeLUf4d5Dn+DD5DbMEA8wi2Rg
	 lA7DvEcu2+MUsuF+HBvOpkaG8gWIEYAf4QJQcRqk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 437/770] lockd: use svc_set_num_threads() for thread start and stop
Date: Tue, 18 Jun 2024 14:34:50 +0200
Message-ID: <20240618123424.155264588@linuxfoundation.org>
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

[ Upstream commit 6b044fbaab02292fedb17565dbb3f2528083b169 ]

svc_set_num_threads() does everything that lockd_start_svc() does, except
set sv_maxconn.  It also (when passed 0) finds the threads and
stops them with kthread_stop().

So move the setting for sv_maxconn, and use svc_set_num_thread()

We now don't need nlmsvc_task.

Now that we use svc_set_num_threads() it makes sense to set svo_module.
This request that the thread exists with module_put_and_exit().
Also fix the documentation for svo_module to make this explicit.

svc_prepare_thread is now only used where it is defined, so it can be
made static.

Signed-off-by: NeilBrown <neilb@suse.de>
[ cel: address merge conflict with fd2468fa1301 ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/lockd/svc.c             | 58 ++++++--------------------------------
 include/linux/sunrpc/svc.h |  6 ++--
 net/sunrpc/svc.c           |  3 +-
 3 files changed, 12 insertions(+), 55 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 1a7c11118b320..0475c5a5d061e 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -55,7 +55,6 @@ EXPORT_SYMBOL_GPL(nlmsvc_ops);
 static DEFINE_MUTEX(nlmsvc_mutex);
 static unsigned int		nlmsvc_users;
 static struct svc_serv		*nlmsvc_serv;
-static struct task_struct	*nlmsvc_task;
 unsigned long			nlmsvc_timeout;
 
 unsigned int lockd_net_id;
@@ -186,7 +185,7 @@ lockd(void *vrqstp)
 
 	svc_exit_thread(rqstp);
 
-	return 0;
+	module_put_and_kthread_exit(0);
 }
 
 static int create_lockd_listener(struct svc_serv *serv, const char *name,
@@ -292,8 +291,8 @@ static void lockd_down_net(struct svc_serv *serv, struct net *net)
 				__func__, net->ns.inum);
 		}
 	} else {
-		pr_err("%s: no users! task=%p, net=%x\n",
-			__func__, nlmsvc_task, net->ns.inum);
+		pr_err("%s: no users! net=%x\n",
+			__func__, net->ns.inum);
 		BUG();
 	}
 }
@@ -351,49 +350,11 @@ static struct notifier_block lockd_inet6addr_notifier = {
 };
 #endif
 
-static int lockd_start_svc(struct svc_serv *serv)
-{
-	int error;
-	struct svc_rqst *rqst;
-
-	/*
-	 * Create the kernel thread and wait for it to start.
-	 */
-	rqst = svc_prepare_thread(serv, &serv->sv_pools[0], NUMA_NO_NODE);
-	if (IS_ERR(rqst)) {
-		error = PTR_ERR(rqst);
-		printk(KERN_WARNING
-			"lockd_up: svc_rqst allocation failed, error=%d\n",
-			error);
-		goto out_rqst;
-	}
-
-	svc_sock_update_bufs(serv);
-	serv->sv_maxconn = nlm_max_connections;
-
-	nlmsvc_task = kthread_create(lockd, rqst, "%s", serv->sv_name);
-	if (IS_ERR(nlmsvc_task)) {
-		error = PTR_ERR(nlmsvc_task);
-		printk(KERN_WARNING
-			"lockd_up: kthread_run failed, error=%d\n", error);
-		goto out_task;
-	}
-	rqst->rq_task = nlmsvc_task;
-	wake_up_process(nlmsvc_task);
-
-	dprintk("lockd_up: service started\n");
-	return 0;
-
-out_task:
-	svc_exit_thread(rqst);
-	nlmsvc_task = NULL;
-out_rqst:
-	return error;
-}
-
 static const struct svc_serv_ops lockd_sv_ops = {
 	.svo_shutdown		= svc_rpcb_cleanup,
+	.svo_function		= lockd,
 	.svo_enqueue_xprt	= svc_xprt_do_enqueue,
+	.svo_module		= THIS_MODULE,
 };
 
 static int lockd_get(void)
@@ -425,7 +386,8 @@ static int lockd_get(void)
 		return -ENOMEM;
 	}
 
-	error = lockd_start_svc(serv);
+	serv->sv_maxconn = nlm_max_connections;
+	error = svc_set_num_threads(serv, NULL, 1);
 	/* The thread now holds the only reference */
 	svc_put(serv);
 	if (error < 0)
@@ -453,11 +415,7 @@ static void lockd_put(void)
 	unregister_inet6addr_notifier(&lockd_inet6addr_notifier);
 #endif
 
-	if (nlmsvc_task) {
-		kthread_stop(nlmsvc_task);
-		dprintk("lockd_down: service stopped\n");
-		nlmsvc_task = NULL;
-	}
+	svc_set_num_threads(nlmsvc_serv, NULL, 0);
 	nlmsvc_serv = NULL;
 	dprintk("lockd_down: service destroyed\n");
 }
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 89e9d00af601b..f116141ea64d0 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -64,7 +64,9 @@ struct svc_serv_ops {
 	/* queue up a transport for servicing */
 	void		(*svo_enqueue_xprt)(struct svc_xprt *);
 
-	/* optional module to count when adding threads (pooled svcs only) */
+	/* optional module to count when adding threads.
+	 * Thread function must call module_put_and_kthread_exit() to exit.
+	 */
 	struct module	*svo_module;
 };
 
@@ -507,8 +509,6 @@ struct svc_serv *svc_create(struct svc_program *, unsigned int,
 			    const struct svc_serv_ops *);
 struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
 					struct svc_pool *pool, int node);
-struct svc_rqst *svc_prepare_thread(struct svc_serv *serv,
-					struct svc_pool *pool, int node);
 void		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 					 struct page *page);
 void		   svc_rqst_free(struct svc_rqst *);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index ceccd4ae5f797..d34d03b0bf76b 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -650,7 +650,7 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 }
 EXPORT_SYMBOL_GPL(svc_rqst_alloc);
 
-struct svc_rqst *
+static struct svc_rqst *
 svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 {
 	struct svc_rqst	*rqstp;
@@ -670,7 +670,6 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	spin_unlock_bh(&pool->sp_lock);
 	return rqstp;
 }
-EXPORT_SYMBOL_GPL(svc_prepare_thread);
 
 /*
  * Choose a pool in which to create a new thread, for svc_set_num_threads
-- 
2.43.0




