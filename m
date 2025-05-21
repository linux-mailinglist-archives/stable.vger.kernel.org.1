Return-Path: <stable+bounces-145909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE88ABFACE
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 18:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484504E6C2C
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 16:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608DF21D3FD;
	Wed, 21 May 2025 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6QPRHob"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B44212B1E
	for <stable@vger.kernel.org>; Wed, 21 May 2025 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747843568; cv=none; b=QeC9+GkX4wivitNcsvOo97OgX3Eu8Ib5qHOvtyVozMzcMvgjDGelcF+ck2dVeK5epzPIaqm+wPXF5GISv8D/bA54KYnY5zItqe07mmcbbbFFf7g70x4NMQNsqwG4PlrgM9OufNejPN+SgnJviG8fAaCQ5jGBP2Tl4wbrOOBkRMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747843568; c=relaxed/simple;
	bh=PCifrGMaHBClbKvmZWajsTE53B2GxDcUEm+7czXcSdM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SxUx84iZm+nblNAixxRhw3YCZFdREp9DYPMm64VtRpxPyO/hHibtyAwOdsv4eQhkjmViaUgG6ZwdvSGcnFp+bWx089KpBfOiMaLHpAbL+OEBmvzis3ieyofdZxfJkbS1zcSN3C+LtMI2ZvAnhsOf+NN7uk2PQOBjrOCKrOuAX9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a6QPRHob; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b19226b5f7dso5000742a12.0
        for <stable@vger.kernel.org>; Wed, 21 May 2025 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747843565; x=1748448365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ql9Z9xm5K7XH9O9hnF7qelsAjP39T8fR3nTvKKw0nvo=;
        b=a6QPRHobOh2SxPmxrkGIaySJwcLM+IGdX1QMnwYQaGACd+tGXBXcyFT6Me9M17p0bR
         CJJszXfgOg3glD+XAEkNpaFxh/NXwyk2WMVYZGytCrxvnkkpA+4H8pNRfOUz0LYHA4sh
         SEhNuso2NqWKRCe/fId6Sq3rLm5h4efMEXIJ/txp7LEi74oNWuX4U7KN+W8G68zSBdG+
         GzVQYUe3c0WTS16eDhRjA+U4Leb95j1QWpu73ZQ4CdT1StiSLJrAN63qq7tU72FNs6v5
         sri2Fx80sqYGukPruwaF+dlrUD0zfDkiyN9b6poQNZRIaYb/X6b+FlnqCQxtFgSmDVa0
         GXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747843565; x=1748448365;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ql9Z9xm5K7XH9O9hnF7qelsAjP39T8fR3nTvKKw0nvo=;
        b=If7uQGRTleOJEzlT/vWWHniZ9Qt0sBwGFmb+u8ymAwCdXABUCKj0YUc8abMKDD/V3+
         iCCAEl6zWUq1geM9YLV6LjQZGheXuWlkGcmp1GJ6UCUgZOYjTiK5OqqrOzUgSG9YRjTX
         zzCJFuKi1SLUB2GIXoLg9OoCqxX6MRdWGvr4kxNzVJC8v7nS0ughagDRntygI8N0ZsL1
         jVuNeEeSNPlHlZyPQeL1ZM6faNkWoNZ8sTaM3dT2JU+lHjR1n81I0SuML8KrbLOeoMoW
         VrzEKr2Bxg6jtqzw2/D5KDrNjZDTeXMON7Qp5/1bIAP/A8zNJX1lmcyS2ebKZwWQw8y5
         cYSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4ZV99YxcUmfBoGD3rd5rIOu1Y1+Op10YVRFpEpL9oUgOjTB1N8o8uHAbEdIRZCLAzv1AdvKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiiFULehCbU+qigYOvc8BvPvLfBlfUZPX9qxs81I3ByPM15sBL
	qkzDFCZ0v+173bjEsEJyfSjmB8aOifIdKE3+fAEEe2NwYsS/P3ccaJHq9axzIox/A1E6aNbhYnY
	yqMDQ7g==
X-Google-Smtp-Source: AGHT+IFNeaIVQ685CZL/ir/FqHiM6qg4cufw1xi0AGG2BDj+FgfngqEqs+kjHu3RZknxYhNp6O6Iptv6chk=
X-Received: from plke8.prod.google.com ([2002:a17:903:1948:b0:232:afa:7ca1])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce91:b0:232:219c:2a4f
 with SMTP id d9443c01a7336-232219c2f99mr194334555ad.1.1747843565544; Wed, 21
 May 2025 09:06:05 -0700 (PDT)
Date: Wed, 21 May 2025 09:06:02 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250521160602.1940771-1-surenb@google.com>
Subject: [PATCH 1/1] alloc_tag: handle module codetag load errors as module
 load failures
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mcgrof@kernel.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, 00107082@163.com, 
	cachen@purestorage.com, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Failures inside codetag_load_module() are currently ignored. As a
result an error there would not cause a module load failure and freeing
of the associated resources. Correct this behavior by propagating the
error code to the caller and handling possible errors. With this change,
error to allocate percpu counters, which happens at this stage, will not
be ignored and will cause a module load failure and freeing of resources.
With this change we also do not need to disable memory allocation
profiling when this error happens, instead we fail to load the module.

Fixes: 10075262888b ("alloc_tag: allocate percpu counters for module tags dynamically")
Reported-by: Casey Chen <cachen@purestorage.com>
Closes: https://lore.kernel.org/all/20250520231620.15259-1-cachen@purestorage.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
---
 include/linux/codetag.h |  8 ++++----
 kernel/module/main.c    |  5 +++--
 lib/alloc_tag.c         | 12 +++++++-----
 lib/codetag.c           | 34 +++++++++++++++++++++++++---------
 4 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/include/linux/codetag.h b/include/linux/codetag.h
index 0ee4c21c6dbc..5f2b9a1f722c 100644
--- a/include/linux/codetag.h
+++ b/include/linux/codetag.h
@@ -36,8 +36,8 @@ union codetag_ref {
 struct codetag_type_desc {
 	const char *section;
 	size_t tag_size;
-	void (*module_load)(struct module *mod,
-			    struct codetag *start, struct codetag *end);
+	int (*module_load)(struct module *mod,
+			   struct codetag *start, struct codetag *end);
 	void (*module_unload)(struct module *mod,
 			      struct codetag *start, struct codetag *end);
 #ifdef CONFIG_MODULES
@@ -89,7 +89,7 @@ void *codetag_alloc_module_section(struct module *mod, const char *name,
 				   unsigned long align);
 void codetag_free_module_sections(struct module *mod);
 void codetag_module_replaced(struct module *mod, struct module *new_mod);
-void codetag_load_module(struct module *mod);
+int codetag_load_module(struct module *mod);
 void codetag_unload_module(struct module *mod);
 
 #else /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
@@ -103,7 +103,7 @@ codetag_alloc_module_section(struct module *mod, const char *name,
 			     unsigned long align) { return NULL; }
 static inline void codetag_free_module_sections(struct module *mod) {}
 static inline void codetag_module_replaced(struct module *mod, struct module *new_mod) {}
-static inline void codetag_load_module(struct module *mod) {}
+static inline int codetag_load_module(struct module *mod) { return 0; }
 static inline void codetag_unload_module(struct module *mod) {}
 
 #endif /* defined(CONFIG_CODE_TAGGING) && defined(CONFIG_MODULES) */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5c6ab20240a6..9861c2ac5fd5 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3399,11 +3399,12 @@ static int load_module(struct load_info *info, const char __user *uargs,
 			goto sysfs_cleanup;
 	}
 
+	if (codetag_load_module(mod))
+		goto sysfs_cleanup;
+
 	/* Get rid of temporary copy. */
 	free_copy(info, flags);
 
-	codetag_load_module(mod);
-
 	/* Done! */
 	trace_module_load(mod);
 
diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 45dae7da70e1..d48b80f3f007 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -607,15 +607,16 @@ static void release_module_tags(struct module *mod, bool used)
 	mas_unlock(&mas);
 }
 
-static void load_module(struct module *mod, struct codetag *start, struct codetag *stop)
+static int load_module(struct module *mod, struct codetag *start, struct codetag *stop)
 {
 	/* Allocate module alloc_tag percpu counters */
 	struct alloc_tag *start_tag;
 	struct alloc_tag *stop_tag;
 	struct alloc_tag *tag;
 
+	/* percpu counters for core allocations are already statically allocated */
 	if (!mod)
-		return;
+		return 0;
 
 	start_tag = ct_to_alloc_tag(start);
 	stop_tag = ct_to_alloc_tag(stop);
@@ -627,12 +628,13 @@ static void load_module(struct module *mod, struct codetag *start, struct codeta
 				free_percpu(tag->counters);
 				tag->counters = NULL;
 			}
-			shutdown_mem_profiling(true);
-			pr_err("Failed to allocate memory for allocation tag percpu counters in the module %s. Memory allocation profiling is disabled!\n",
+			pr_err("Failed to allocate memory for allocation tag percpu counters in the module %s\n",
 			       mod->name);
-			break;
+			return -ENOMEM;
 		}
 	}
+
+	return 0;
 }
 
 static void replace_module(struct module *mod, struct module *new_mod)
diff --git a/lib/codetag.c b/lib/codetag.c
index de332e98d6f5..650d54d7e14d 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -167,6 +167,7 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 {
 	struct codetag_range range;
 	struct codetag_module *cmod;
+	int mod_id;
 	int err;
 
 	range = get_section_range(mod, cttype->desc.section);
@@ -190,11 +191,20 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
 	cmod->range = range;
 
 	down_write(&cttype->mod_lock);
-	err = idr_alloc(&cttype->mod_idr, cmod, 0, 0, GFP_KERNEL);
-	if (err >= 0) {
-		cttype->count += range_size(cttype, &range);
-		if (cttype->desc.module_load)
-			cttype->desc.module_load(mod, range.start, range.stop);
+	mod_id = idr_alloc(&cttype->mod_idr, cmod, 0, 0, GFP_KERNEL);
+	if (mod_id >= 0) {
+		if (cttype->desc.module_load) {
+			err = cttype->desc.module_load(mod, range.start, range.stop);
+			if (!err)
+				cttype->count += range_size(cttype, &range);
+			else
+				idr_remove(&cttype->mod_idr, mod_id);
+		} else {
+			cttype->count += range_size(cttype, &range);
+			err = 0;
+		}
+	} else {
+		err = mod_id;
 	}
 	up_write(&cttype->mod_lock);
 
@@ -295,17 +305,23 @@ void codetag_module_replaced(struct module *mod, struct module *new_mod)
 	mutex_unlock(&codetag_lock);
 }
 
-void codetag_load_module(struct module *mod)
+int codetag_load_module(struct module *mod)
 {
 	struct codetag_type *cttype;
+	int ret = 0;
 
 	if (!mod)
-		return;
+		return 0;
 
 	mutex_lock(&codetag_lock);
-	list_for_each_entry(cttype, &codetag_types, link)
-		codetag_module_init(cttype, mod);
+	list_for_each_entry(cttype, &codetag_types, link) {
+		ret = codetag_module_init(cttype, mod);
+		if (ret)
+			break;
+	}
 	mutex_unlock(&codetag_lock);
+
+	return ret;
 }
 
 void codetag_unload_module(struct module *mod)

base-commit: 9f3e87f6c8d4b28b96eb8bddb22d3ba4b846e10b
-- 
2.49.0.1112.g889b7c5bd8-goog


