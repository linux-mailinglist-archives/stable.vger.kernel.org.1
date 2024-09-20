Return-Path: <stable+bounces-76798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B8F97D39C
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 11:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04FAB23343
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 09:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3E913D610;
	Fri, 20 Sep 2024 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h5SFab9i"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23D7DA87
	for <stable@vger.kernel.org>; Fri, 20 Sep 2024 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824567; cv=none; b=Ilwn5KcE7Qj9SrJu7/NH9xFUQBAiGGFGlqtJdUeZvs6YV1ot7fZpLRtrwbqrHRjUqA9vijI0wlwFkLEKDk6C6k+eblIdIL8ZL2oAUYwm0Clg/T2/Zgeq6MKTwXetkYAUFdeUwfs8unhXr8e5k0+MtZzYjU6a7uZWj+ZpNTLpFZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824567; c=relaxed/simple;
	bh=OK1BPg2c347cJWfiwvBnva3E4LM3n5XtQ0M3Nf3QdzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=juPGAqDHWtll8g0z+z8D3hQLbBC9FO/hSLwCrwcG1EAbXughmTc01QUznQbkIYhn9LLLkk9Z14HGP6PoCCVcno6WjxeXLhaqtPPV2gAZC+C+xhGm0FT3y59/48TGL4kmcXyAOYMdveMC877xH+mKIZ2SUZrFW7o75Lwjw8pbuvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h5SFab9i; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2057835395aso21095115ad.3
        for <stable@vger.kernel.org>; Fri, 20 Sep 2024 02:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726824565; x=1727429365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSnGEnOTkyY80dZlv3hsxDLTFJVq0qKWNdJjMRPuL7g=;
        b=h5SFab9iCqDQ9bYab198mJSki0ZY4tnY/rpXNgik++7gpi22F+3P6oJ/W+dc+IpWet
         iG5CiuIZxs4GM9NEdGCKcMv4X9xKp5HMMLQbqd8zBJOOKgpFKqrRDtVlFNGq4DdDAWup
         D5oYnVWswzeuVEakmfkMPdywqI1d1ZNU7CoTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726824565; x=1727429365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSnGEnOTkyY80dZlv3hsxDLTFJVq0qKWNdJjMRPuL7g=;
        b=wF73uk6Yo3zjSo4NME1gfeefMeTMSihn1iT7JaxVYGr3dy3W1yvNJ6aY5N41fdBl30
         cgeNhmVE0WnQ+i4YZRaZbStO7EgiSqlvvcI+nbrEDIurAw3Gdwv5nfeCYZrePnuqisp5
         PLR2NllMl1wnVxCaRBOWuiJJN5nwJpwciNUrycwV4AMfa4JbLM/hjTnMXxC6Jixhy9x7
         5NGucG2X2caKm85LoV2s/z/09AM/a46vqtCaQAMt/yr65oNugsET7wUPoPoj/cyvXx+s
         jF88RFlj3sgk0YqOGuB2/UoMKwvlUVHknwUzylqDXljgY1H0wz+2HZlyyTZgQhvHeLMJ
         yo/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUrgUD6ziCRuVnQ01ZHWof+oiuZWytUDSg+EzOa0aQwGartCQ+twh1XzLp3gzEJUoSA+v1q3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCgHGAKx5l9u4+ZdrY9yN7D/TV2Pg/92hta+k59F8JKYynL1oT
	jHII21yaU+IrY0qrfNw2mlMKQt6gzndKM86EjOyMi6IEgwLMlKeNT2Y/LgqWGA==
X-Google-Smtp-Source: AGHT+IH37Bjv++HS2PvnJMQud7IZ3lofoOVAV/d9QZ4v0NQnhQaJlz+w75vPQ+Dn5Ad6y7n4seRG4Q==
X-Received: by 2002:a17:902:ce0e:b0:205:9510:1fb7 with SMTP id d9443c01a7336-208d8343aeemr29518545ad.14.1726824565160;
        Fri, 20 Sep 2024 02:29:25 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079473586esm91254485ad.277.2024.09.20.02.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 02:29:24 -0700 (PDT)
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
Subject: [PATCH v4.19] cgroup: Make operations on the cgroup root_list RCU safe
Date: Fri, 20 Sep 2024 02:29:14 -0700
Message-Id: <20240920092914.101171-1-shivani.agarwal@broadcom.com>
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
[Shivani: Modified to apply on v4.19.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 include/linux/cgroup-defs.h     |  1 +
 kernel/cgroup/cgroup-internal.h |  2 +-
 kernel/cgroup/cgroup.c          | 23 ++++++++++++++++-------
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 56442d3b651d..1803c222e204 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -478,6 +478,7 @@ struct cgroup_root {
 
 	/* A list running through the active hierarchies */
 	struct list_head root_list;
+	struct rcu_head rcu;
 
 	/* Hierarchy-specific flags */
 	unsigned int flags;
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 4168e7d97e87..b96bbbc4b19c 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -151,7 +151,7 @@ extern struct list_head cgroup_roots;
 
 /* iterate across the hierarchies */
 #define for_each_root(root)						\
-	list_for_each_entry((root), &cgroup_roots, root_list)
+	list_for_each_entry_rcu((root), &cgroup_roots, root_list)
 
 /**
  * for_each_subsys - iterate all enabled cgroup subsystems
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 30c058806702..39f5c00cca29 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1246,7 +1246,7 @@ void cgroup_free_root(struct cgroup_root *root)
 {
 	if (root) {
 		idr_destroy(&root->cgroup_idr);
-		kfree(root);
+		kfree_rcu(root, rcu);
 	}
 }
 
@@ -1280,7 +1280,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 	spin_unlock_irq(&css_set_lock);
 
 	if (!list_empty(&root->root_list)) {
-		list_del(&root->root_list);
+		list_del_rcu(&root->root_list);
 		cgroup_root_count--;
 	}
 
@@ -1333,7 +1333,6 @@ static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 {
 	struct cgroup *res = NULL;
 
-	lockdep_assert_held(&cgroup_mutex);
 	lockdep_assert_held(&css_set_lock);
 
 	if (cset == &init_css_set) {
@@ -1353,13 +1352,23 @@ static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
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
@@ -1922,7 +1931,7 @@ void init_cgroup_root(struct cgroup_root *root, struct cgroup_sb_opts *opts)
 {
 	struct cgroup *cgrp = &root->cgrp;
 
-	INIT_LIST_HEAD(&root->root_list);
+	INIT_LIST_HEAD_RCU(&root->root_list);
 	atomic_set(&root->nr_cgrps, 1);
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
@@ -2004,7 +2013,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask, int ref_flags)
 	 * care of subsystems' refcounts, which are explicitly dropped in
 	 * the failure exit path.
 	 */
-	list_add(&root->root_list, &cgroup_roots);
+	list_add_rcu(&root->root_list, &cgroup_roots);
 	cgroup_root_count++;
 
 	/*
-- 
2.39.4


