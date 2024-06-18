Return-Path: <stable+bounces-53265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9679390D0E3
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278981F23867
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E32E18EFCD;
	Tue, 18 Jun 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n5MutsrJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6C513BAFB;
	Tue, 18 Jun 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715817; cv=none; b=oOejSus0DolFFqMWM2mAAr6UGJN8XP+8Yqps8QdptgNkM5cPV5VYBAAb9Dfr27lFWOBHEyuQpSU+UHORIwbdcahObQzhudSVetQ8o39jiqDScsBZxtElfzUpxtm0QxyrnkpRDH/Sc56eXeYJ5ePE8rVb67JqSG8Xfpqq+BPJfRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715817; c=relaxed/simple;
	bh=NJ3AVsS1GBrlcVr3rpf8PLfQ81hvP/viJBaMThqfYz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ox5AwlwNIZ8WX2nSbIOYa4byT00KCZygLo3NxseNw0xwUIr+Nc/QghmXL2fm/DdvJBVSgBF4bR9POxkvzGYc9o3gekCyfTRmLnl485gVdQyPL+M5DOWtrfVAq89IUy6LT5KhVSeIg4zi0LKxgM41nYbcPrDOVc/wn+tRygaVmbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n5MutsrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CD1C3277B;
	Tue, 18 Jun 2024 13:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715817;
	bh=NJ3AVsS1GBrlcVr3rpf8PLfQ81hvP/viJBaMThqfYz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n5MutsrJHkIyTmwWjT72HAR28Cil8Tl1W5F//euaajckaytNq64LgDms01mpEzGUz
	 3/EQaUiLJetev/gO6vD9pme6geLNRLD/CRrzwoum90snLW+OZ3VzZM6TYKMXuQaVaB
	 /LVlox9VMs9+/uxaKW4yFj7AV1Ybqy1PrEPDkAXI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neilb@suse.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 436/770] SUNRPC: always treat sv_nrpools==1 as "not pooled"
Date: Tue, 18 Jun 2024 14:34:49 +0200
Message-ID: <20240618123424.115634003@linuxfoundation.org>
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

[ Upstream commit 93aa619eb0b42eec2f3a9b4d9db41f5095390aec ]

Currently 'pooled' services hold a reference on the pool_map, and
'unpooled' services do not.
svc_destroy() uses the presence of ->svo_function (via
svc_serv_is_pooled()) to determine if the reference should be dropped.
There is no direct correlation between being pooled and the use of
svo_function, though in practice, lockd is the only non-pooled service,
and the only one not to use svo_function.

This is untidy and would cause problems if we changed lockd to use
svc_set_num_threads(), which requires the use of ->svo_function.

So change the test for "is the service pooled" to "is sv_nrpools > 1".

This means that when svc_pool_map_get() returns 1, it must NOT take a
reference to the pool.

We discard svc_serv_is_pooled(), and test sv_nrpools directly.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/svc.c | 54 ++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index c681ac1c9d569..ceccd4ae5f797 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -35,8 +35,6 @@
 
 static void svc_unregister(const struct svc_serv *serv, struct net *net);
 
-#define svc_serv_is_pooled(serv)    ((serv)->sv_ops->svo_function)
-
 #define SVC_POOL_DEFAULT	SVC_POOL_GLOBAL
 
 /*
@@ -238,8 +236,10 @@ svc_pool_map_init_pernode(struct svc_pool_map *m)
 
 /*
  * Add a reference to the global map of cpus to pools (and
- * vice versa).  Initialise the map if we're the first user.
- * Returns the number of pools.
+ * vice versa) if pools are in use.
+ * Initialise the map if we're the first user.
+ * Returns the number of pools. If this is '1', no reference
+ * was taken.
  */
 static unsigned int
 svc_pool_map_get(void)
@@ -251,6 +251,7 @@ svc_pool_map_get(void)
 
 	if (m->count++) {
 		mutex_unlock(&svc_pool_map_mutex);
+		WARN_ON_ONCE(m->npools <= 1);
 		return m->npools;
 	}
 
@@ -266,29 +267,36 @@ svc_pool_map_get(void)
 		break;
 	}
 
-	if (npools < 0) {
+	if (npools <= 0) {
 		/* default, or memory allocation failure */
 		npools = 1;
 		m->mode = SVC_POOL_GLOBAL;
 	}
 	m->npools = npools;
 
+	if (npools == 1)
+		/* service is unpooled, so doesn't hold a reference */
+		m->count--;
+
 	mutex_unlock(&svc_pool_map_mutex);
-	return m->npools;
+	return npools;
 }
 
 /*
- * Drop a reference to the global map of cpus to pools.
+ * Drop a reference to the global map of cpus to pools, if
+ * pools were in use, i.e. if npools > 1.
  * When the last reference is dropped, the map data is
  * freed; this allows the sysadmin to change the pool
  * mode using the pool_mode module option without
  * rebooting or re-loading sunrpc.ko.
  */
 static void
-svc_pool_map_put(void)
+svc_pool_map_put(int npools)
 {
 	struct svc_pool_map *m = &svc_pool_map;
 
+	if (npools <= 1)
+		return;
 	mutex_lock(&svc_pool_map_mutex);
 
 	if (!--m->count) {
@@ -357,21 +365,18 @@ svc_pool_for_cpu(struct svc_serv *serv, int cpu)
 	struct svc_pool_map *m = &svc_pool_map;
 	unsigned int pidx = 0;
 
-	/*
-	 * An uninitialised map happens in a pure client when
-	 * lockd is brought up, so silently treat it the
-	 * same as SVC_POOL_GLOBAL.
-	 */
-	if (svc_serv_is_pooled(serv)) {
-		switch (m->mode) {
-		case SVC_POOL_PERCPU:
-			pidx = m->to_pool[cpu];
-			break;
-		case SVC_POOL_PERNODE:
-			pidx = m->to_pool[cpu_to_node(cpu)];
-			break;
-		}
+	if (serv->sv_nrpools <= 1)
+		return serv->sv_pools;
+
+	switch (m->mode) {
+	case SVC_POOL_PERCPU:
+		pidx = m->to_pool[cpu];
+		break;
+	case SVC_POOL_PERNODE:
+		pidx = m->to_pool[cpu_to_node(cpu)];
+		break;
 	}
+
 	return &serv->sv_pools[pidx % serv->sv_nrpools];
 }
 
@@ -524,7 +529,7 @@ svc_create_pooled(struct svc_program *prog, unsigned int bufsize,
 		goto out_err;
 	return serv;
 out_err:
-	svc_pool_map_put();
+	svc_pool_map_put(npools);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(svc_create_pooled);
@@ -559,8 +564,7 @@ svc_destroy(struct kref *ref)
 
 	cache_clean_deferred(serv);
 
-	if (svc_serv_is_pooled(serv))
-		svc_pool_map_put();
+	svc_pool_map_put(serv->sv_nrpools);
 
 	kfree(serv->sv_pools);
 	kfree(serv);
-- 
2.43.0




