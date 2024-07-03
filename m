Return-Path: <stable+bounces-57169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED68925B33
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99571F21B61
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E687B183076;
	Wed,  3 Jul 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h6aFfBm0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FA21822CD;
	Wed,  3 Jul 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004057; cv=none; b=d3txqjSN30lkvsZG2O8WYUXom1bUZFKyov0zVO/YRgzOO3/B9Dg73G+vmOs/m02r6idvo2MProxdWu6qPVHAm35wX5RqVyl5paeIRcqcg3R2Ph26yfh16h9IXrQrf08+b49pS8dlXFAqg+D7FoedBQ2QOojQNkOzqsD7JVOzVyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004057; c=relaxed/simple;
	bh=Kbvek5rNAyWWApfOiyczvtuGRXWoKN1IJBM2B5KDQAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCIyMEg0jkCe1DEAylFBvykd8YZc+PK7bz2/z5GdUQDyziwSjpLonxC27oKu1y8BWxc4dpGsqBfnPIRbbU5xZ+NkRsYrL5XIjvm1gilXJxZAbyrY4dXCqezuJGwccJmmmpPOheu0hSlD5D8ULWu9EHe/vC0Fn8T14BnSksFaaXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h6aFfBm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F45DC2BD10;
	Wed,  3 Jul 2024 10:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004057;
	bh=Kbvek5rNAyWWApfOiyczvtuGRXWoKN1IJBM2B5KDQAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h6aFfBm0xlzz75gSHDnt66NevjsP3rHA5WkxlzL4DbkYRKDxgk3vfxNPLd43xjHty
	 mkqjr2n+CTE+X6gpZ9KtK1mE0qQdIyWh209q7wsh3yGzr6t6C69EotEbpkxxeT0JkK
	 NFk2XSqxNlk6Xp1XOx/KzikM25VNrWwvGLm1ucOs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pedro Tammela <pctammela@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 109/189] net/sched: act_api: rely on rcu in tcf_idr_check_alloc
Date: Wed,  3 Jul 2024 12:39:30 +0200
Message-ID: <20240703102845.616037315@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
References: <20240703102841.492044697@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit 4b55e86736d5b492cf689125da2600f59c7d2c39 ]

Instead of relying only on the idrinfo->lock mutex for
bind/alloc logic, rely on a combination of rcu + mutex + atomics
to better scale the case where multiple rtnl-less filters are
binding to the same action object.

Action binding happens when an action index is specified explicitly and
an action exists which such index exists. Example:
  tc actions add action drop index 1
  tc filter add ... matchall action drop index 1
  tc filter add ... matchall action drop index 1
  tc filter add ... matchall action drop index 1
  tc filter ls ...
     filter protocol all pref 49150 matchall chain 0 filter protocol all pref 49150 matchall chain 0 handle 0x1
     not_in_hw
           action order 1: gact action drop
            random type none pass val 0
            index 1 ref 4 bind 3

   filter protocol all pref 49151 matchall chain 0 filter protocol all pref 49151 matchall chain 0 handle 0x1
     not_in_hw
           action order 1: gact action drop
            random type none pass val 0
            index 1 ref 4 bind 3

   filter protocol all pref 49152 matchall chain 0 filter protocol all pref 49152 matchall chain 0 handle 0x1
     not_in_hw
           action order 1: gact action drop
            random type none pass val 0
            index 1 ref 4 bind 3

When no index is specified, as before, grab the mutex and allocate
in the idr the next available id. In this version, as opposed to before,
it's simplified to store the -EBUSY pointer instead of the previous
alloc + replace combination.

When an index is specified, rely on rcu to find if there's an object in
such index. If there's none, fallback to the above, serializing on the
mutex and reserving the specified id. If there's one, it can be an -EBUSY
pointer, in which case we just try again until it's an action, or an action.
Given the rcu guarantees, the action found could be dead and therefore
we need to bump the refcount if it's not 0, handling the case it's
in fact 0.

As bind and the action refcount are already atomics, these increments can
happen without the mutex protection while many tcf_idr_check_alloc race
to bind to the same action instance.

In case binding encounters a parallel delete or add, it will return
-EAGAIN in order to try again. Both filter and action apis already
have the retry machinery in-place. In case it's an unlocked filter it
retries under the rtnl lock.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Link: https://lore.kernel.org/r/20231211181807.96028-2-pctammela@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: d864319871b0 ("net/sched: act_api: fix possible infinite loop in tcf_idr_check_alloc()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_api.c | 65 ++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index db1c0139f99c6..92477d51c49dd 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -479,6 +479,9 @@ EXPORT_SYMBOL(tcf_idr_cleanup);
  * its reference and bind counters, and return 1. Otherwise insert temporary
  * error pointer (to prevent concurrent users from inserting actions with same
  * index) and return 0.
+ *
+ * May return -EAGAIN for binding actions in case of a parallel add/delete on
+ * the requested index.
  */
 
 int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
@@ -487,43 +490,61 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 	struct tcf_idrinfo *idrinfo = tn->idrinfo;
 	struct tc_action *p;
 	int ret;
+	u32 max;
 
-again:
-	mutex_lock(&idrinfo->lock);
 	if (*index) {
+again:
+		rcu_read_lock();
 		p = idr_find(&idrinfo->action_idr, *index);
+
 		if (IS_ERR(p)) {
 			/* This means that another process allocated
 			 * index but did not assign the pointer yet.
 			 */
-			mutex_unlock(&idrinfo->lock);
+			rcu_read_unlock();
 			goto again;
 		}
 
-		if (p) {
-			refcount_inc(&p->tcfa_refcnt);
-			if (bind)
-				atomic_inc(&p->tcfa_bindcnt);
-			*a = p;
-			ret = 1;
-		} else {
-			*a = NULL;
-			ret = idr_alloc_u32(&idrinfo->action_idr, NULL, index,
-					    *index, GFP_KERNEL);
-			if (!ret)
-				idr_replace(&idrinfo->action_idr,
-					    ERR_PTR(-EBUSY), *index);
+		if (!p) {
+			/* Empty slot, try to allocate it */
+			max = *index;
+			rcu_read_unlock();
+			goto new;
+		}
+
+		if (!refcount_inc_not_zero(&p->tcfa_refcnt)) {
+			/* Action was deleted in parallel */
+			rcu_read_unlock();
+			return -EAGAIN;
 		}
+
+		if (bind)
+			atomic_inc(&p->tcfa_bindcnt);
+		*a = p;
+
+		rcu_read_unlock();
+
+		return 1;
 	} else {
+		/* Find a slot */
 		*index = 1;
-		*a = NULL;
-		ret = idr_alloc_u32(&idrinfo->action_idr, NULL, index,
-				    UINT_MAX, GFP_KERNEL);
-		if (!ret)
-			idr_replace(&idrinfo->action_idr, ERR_PTR(-EBUSY),
-				    *index);
+		max = UINT_MAX;
 	}
+
+new:
+	*a = NULL;
+
+	mutex_lock(&idrinfo->lock);
+	ret = idr_alloc_u32(&idrinfo->action_idr, ERR_PTR(-EBUSY), index, max,
+			    GFP_KERNEL);
 	mutex_unlock(&idrinfo->lock);
+
+	/* N binds raced for action allocation,
+	 * retry for all the ones that failed.
+	 */
+	if (ret == -ENOSPC && *index == max)
+		ret = -EAGAIN;
+
 	return ret;
 }
 EXPORT_SYMBOL(tcf_idr_check_alloc);
-- 
2.43.0




