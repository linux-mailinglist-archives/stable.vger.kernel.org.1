Return-Path: <stable+bounces-76800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D87297D3A0
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 11:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B4028841F
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 09:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124AB13D88E;
	Fri, 20 Sep 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PKkrGrqE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DDC13D521
	for <stable@vger.kernel.org>; Fri, 20 Sep 2024 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824612; cv=none; b=aLikFo9ZurVzZjqx87vm4T9WfVL0mmAHoYqBaOOOlzAUhB2f5oHlp2JfZIeLVttI2qjHgtVYUWWm+tGHQst/2V3WJnwzMzcX/8/kynXfahxutYX+NHdqf4CUkHcWt1GjT89R5s0h6DByaKRRSIQwuAVNi7sJR84SZzZ3GzksQ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824612; c=relaxed/simple;
	bh=C6p6R+ek3O53JwyFgb15Sgrr8d5lCPcRQVTWxNxdYtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WLSkqhc3OuCOlhzWSwT1EAXEiRqBNKf8fYkOVKeDH1Txr1G+nVIxoaV6tKWLqplOqtm+puxfoavwsRdvq5EwRxw2ADKh3fEWJot3MB87YqZIXh0Y9dHR1s8oG6+/lUOHL8Mlq3vD0DtK0GKLVTgi2wZW9GTOk7HHCF2OOtnTYXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PKkrGrqE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-718da0821cbso1388631b3a.0
        for <stable@vger.kernel.org>; Fri, 20 Sep 2024 02:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726824610; x=1727429410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJudsDaTdfcBGyaEMCPm9yipYUAx0IM1I1EMAnVF4ys=;
        b=PKkrGrqE+NWdAXIHzOx1bDVnTzXNy35K1Nkz1LFJBawK49Mx1QNZySnw+v4qpdYORc
         99lux7+i6ci1XygGhoJQQQwlJI/e2nckVqYDO3lhi8mjdcqUPuvYsQE4N+NwY8IebSJg
         U9hmWAfI0SPRYMo7IxrQZEG5Mtd0h4OknWILA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726824610; x=1727429410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJudsDaTdfcBGyaEMCPm9yipYUAx0IM1I1EMAnVF4ys=;
        b=ZO9MLpGvJqLzflFkdBryC/jIQOud6cMKcekMLwHvJimt4N5sktYHb7bLv+Ux9Jm2AR
         An5d/M/Y1R5E1ZB6bShbfeuHASgY9ouw9EBBxStAXsqN1EntgxIKmYBuUiYbuPGg2LT+
         kw9Jc7YDmeX/7LQ3gtVhuxJ+wJJ3iICXcq701wt6XIFjhduJ1DFnq8TFp1mdWQ7xpqbb
         FCDHZsTGxuv78efeSweuSNwJyVtWy1N6qoFHDX+8TYLay68Sfdodg537m5uv6+BWE3ze
         Ryqlae8gk4+2x5YMsLb2xwjfsHNK7U1Baeg32SA1jCGj4oJWk0WnkzCmOrLO2g3gssEB
         BTMA==
X-Forwarded-Encrypted: i=1; AJvYcCWVnfKJqb9mep7aryjDVG6W/fFW6lzcnLNxAAwDNjfJ/yohp54oKCtQ3C/Djzqb/9pfo/Vh7AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQxUBLP5YZuLqMYYN6KPReWCriiT2sPl6NH6nxBh6skEQKM5+K
	taOVG5NWoW1VVcift6MHoNpfUj31k1Z9mWh0knDKHQZBTmVWN2CZ11rFUjdHlQ==
X-Google-Smtp-Source: AGHT+IHhHi9xrWS+viz/xd9pRafdRfiDEchj4mVIiFh+J80NS4zkmDrreOXQ6tb0XatjUVvhzpN8kw==
X-Received: by 2002:a05:6a00:3e14:b0:717:d4e3:df21 with SMTP id d2e1a72fcca58-7199ca8343bmr3366894b3a.23.1726824610447;
        Fri, 20 Sep 2024 02:30:10 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e0cc229dc9sm557620a12.60.2024.09.20.02.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 02:30:10 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: pchelkin@ispras.ru,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: chenridong@huawei.com,
	gthelen@google.com,
	lvc-project@linuxtesting.org,
	mkoutny@suse.com,
	shivani.agarwal@broadcom.com,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	cgroups@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5.4] cgroup: Make operations on the cgroup root_list RCU safe
Date: Fri, 20 Sep 2024 02:30:02 -0700
Message-Id: <20240920093002.101293-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240919-5e2d9ccca61f5022e0b574af-pchelkin@ispras.ru>
References: <20240919-5e2d9ccca61f5022e0b574af-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yafang Shao <laoar.shao@gmail.com>

commit d23b5c577715892c87533b13923306acc6243f93 upstream.

At present, when we perform operations on the cgroup root_list, we must
hold the cgroup_mutex, which is a relatively heavyweight lock. In reality,
we can make operations on this list RCU-safe, eliminating the need to hold
the cgroup_mutex during traversal. Modifications to the list only occur in
the cgroup root setup and destroy paths, which should be infrequent in a
production environment. In contrast, traversal may occur frequently.
Therefore, making it RCU-safe would be beneficial.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[fp: adapt to 5.10 mainly because of changes made by e210a89f5b07
 ("cgroup.c: add helper __cset_cgroup_from_root to cleanup duplicated
 codes")]
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
[Shivani: Modified to apply on v5.4.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 include/linux/cgroup-defs.h     |  1 +
 kernel/cgroup/cgroup-internal.h |  3 ++-
 kernel/cgroup/cgroup.c          | 23 ++++++++++++++++-------
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index d15884957e7f..c64f11674850 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -517,6 +517,7 @@ struct cgroup_root {
 
 	/* A list running through the active hierarchies */
 	struct list_head root_list;
+	struct rcu_head rcu;
 
 	/* Hierarchy-specific flags */
 	unsigned int flags;
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 803989eae99e..bb85acc1114e 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -172,7 +172,8 @@ extern struct list_head cgroup_roots;
 
 /* iterate across the hierarchies */
 #define for_each_root(root)						\
-	list_for_each_entry((root), &cgroup_roots, root_list)
+	list_for_each_entry_rcu((root), &cgroup_roots, root_list,	\
+				lockdep_is_held(&cgroup_mutex))
 
 /**
  * for_each_subsys - iterate all enabled cgroup subsystems
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 16ae86894121..dc6351095baf 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1314,7 +1314,7 @@ void cgroup_free_root(struct cgroup_root *root)
 {
 	if (root) {
 		idr_destroy(&root->cgroup_idr);
-		kfree(root);
+		kfree_rcu(root, rcu);
 	}
 }
 
@@ -1348,7 +1348,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 	spin_unlock_irq(&css_set_lock);
 
 	if (!list_empty(&root->root_list)) {
-		list_del(&root->root_list);
+		list_del_rcu(&root->root_list);
 		cgroup_root_count--;
 	}
 
@@ -1401,7 +1401,6 @@ static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 {
 	struct cgroup *res = NULL;
 
-	lockdep_assert_held(&cgroup_mutex);
 	lockdep_assert_held(&css_set_lock);
 
 	if (cset == &init_css_set) {
@@ -1421,13 +1420,23 @@ static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 		}
 	}
 
-	BUG_ON(!res);
+	/*
+	 * If cgroup_mutex is not held, the cgrp_cset_link will be freed
+	 * before we remove the cgroup root from the root_list. Consequently,
+	 * when accessing a cgroup root, the cset_link may have already been
+	 * freed, resulting in a NULL res_cgroup. However, by holding the
+	 * cgroup_mutex, we ensure that res_cgroup can't be NULL.
+	 * If we don't hold cgroup_mutex in the caller, we must do the NULL
+	 * check.
+	 */
 	return res;
 }
 
 /*
  * Return the cgroup for "task" from the given hierarchy. Must be
- * called with cgroup_mutex and css_set_lock held.
+ * called with css_set_lock held to prevent task's groups from being modified.
+ * Must be called with either cgroup_mutex or rcu read lock to prevent the
+ * cgroup root from being destroyed.
  */
 struct cgroup *task_cgroup_from_root(struct task_struct *task,
 				     struct cgroup_root *root)
@@ -2012,7 +2021,7 @@ void init_cgroup_root(struct cgroup_fs_context *ctx)
 	struct cgroup_root *root = ctx->root;
 	struct cgroup *cgrp = &root->cgrp;
 
-	INIT_LIST_HEAD(&root->root_list);
+	INIT_LIST_HEAD_RCU(&root->root_list);
 	atomic_set(&root->nr_cgrps, 1);
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
@@ -2094,7 +2103,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	 * care of subsystems' refcounts, which are explicitly dropped in
 	 * the failure exit path.
 	 */
-	list_add(&root->root_list, &cgroup_roots);
+	list_add_rcu(&root->root_list, &cgroup_roots);
 	cgroup_root_count++;
 
 	/*
-- 
2.39.4


