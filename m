Return-Path: <stable+bounces-113209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A4FA29079
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA84163374
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E3814B959;
	Wed,  5 Feb 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n5+1S5F1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFE0151988;
	Wed,  5 Feb 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766187; cv=none; b=MKwsMtioE4b2Up3IX+3fa5ia7f8OyWW5++sLZsrXF2aVc16ZG4JWitgPvua163mTpJj1NG8kSgMSLGEnicwcj3XnqguYFmbi1UKyn1m0mcSYCnY7RUvccmGFnSMm55pSx9Ms96Ld9xmT4wQsrPPdCKHkh28iHe7oKrFGJC8bk+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766187; c=relaxed/simple;
	bh=2OkmJKhXef3hKleTFzWudp/18TXsm667XjOxOeEWAds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEHT++XIVDo4Qho3Eyf94mRFwIOm7dOnA22frhpBLz1YDBYYGIXHOVcYP34loNQvjCwgdMBqNHlkmLa293bo+N1Yae65qmHoAaM8khYAFd/VWjxyuzgEnbwGkP6N68DZgYYi0oyJjUtxkhk3jbTlG98SoOSq5CZCQsxDjhgSENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n5+1S5F1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF9FC4CED1;
	Wed,  5 Feb 2025 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766187;
	bh=2OkmJKhXef3hKleTFzWudp/18TXsm667XjOxOeEWAds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n5+1S5F1kWIXeaAO2VP46FLBUYfVuWQXnz606trtlP7A6IJ+OXXnlJJ8FUSK/DzGg
	 bF0NGd4WwFkSWDBqMGHcFr6RvJ7Ig6YFYWccpMysTJOUyI5mf13jboKILL5i5Y2Rxy
	 Y6UvYR64XU5Pd6IOfFfdjDRJj3XM71hdwrtrNO1c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ridong <chenridong@huawei.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 295/590] padata: add pd get/put refcnt helper
Date: Wed,  5 Feb 2025 14:40:50 +0100
Message-ID: <20250205134506.562628614@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ridong <chenridong@huawei.com>

[ Upstream commit ae154202cc6a189b035359f3c4e143d5c24d5352 ]

Add helpers for pd to get/put refcnt to make code consice.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: dd7d37ccf6b1 ("padata: avoid UAF for reorder_work")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/padata.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index e2ae2c3747a85..a4c7a6eefe10e 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -47,6 +47,22 @@ struct padata_mt_job_state {
 static void padata_free_pd(struct parallel_data *pd);
 static void __init padata_mt_helper(struct work_struct *work);
 
+static inline void padata_get_pd(struct parallel_data *pd)
+{
+	refcount_inc(&pd->refcnt);
+}
+
+static inline void padata_put_pd_cnt(struct parallel_data *pd, int cnt)
+{
+	if (refcount_sub_and_test(cnt, &pd->refcnt))
+		padata_free_pd(pd);
+}
+
+static inline void padata_put_pd(struct parallel_data *pd)
+{
+	padata_put_pd_cnt(pd, 1);
+}
+
 static int padata_index_to_cpu(struct parallel_data *pd, int cpu_index)
 {
 	int cpu, target_cpu;
@@ -206,7 +222,7 @@ int padata_do_parallel(struct padata_shell *ps,
 	if ((pinst->flags & PADATA_RESET))
 		goto out;
 
-	refcount_inc(&pd->refcnt);
+	padata_get_pd(pd);
 	padata->pd = pd;
 	padata->cb_cpu = *cb_cpu;
 
@@ -380,8 +396,7 @@ static void padata_serial_worker(struct work_struct *serial_work)
 	}
 	local_bh_enable();
 
-	if (refcount_sub_and_test(cnt, &pd->refcnt))
-		padata_free_pd(pd);
+	padata_put_pd_cnt(pd, cnt);
 }
 
 /**
@@ -688,8 +703,7 @@ static int padata_replace(struct padata_instance *pinst)
 	synchronize_rcu();
 
 	list_for_each_entry_continue_reverse(ps, &pinst->pslist, list)
-		if (refcount_dec_and_test(&ps->opd->refcnt))
-			padata_free_pd(ps->opd);
+		padata_put_pd(ps->opd);
 
 	pinst->flags &= ~PADATA_RESET;
 
@@ -1137,8 +1151,7 @@ void padata_free_shell(struct padata_shell *ps)
 	mutex_lock(&ps->pinst->lock);
 	list_del(&ps->list);
 	pd = rcu_dereference_protected(ps->pd, 1);
-	if (refcount_dec_and_test(&pd->refcnt))
-		padata_free_pd(pd);
+	padata_put_pd(pd);
 	mutex_unlock(&ps->pinst->lock);
 
 	kfree(ps);
-- 
2.39.5




