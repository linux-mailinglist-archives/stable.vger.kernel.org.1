Return-Path: <stable+bounces-109296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD525A13E49
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 16:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B7516C192
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EB322BACA;
	Thu, 16 Jan 2025 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5hLHK5Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB7422BAA2
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042825; cv=none; b=n8exy4aMq4zrA/DvDlcew5BpBA0Co7IoBU2qyH7oL4Dg4WHBQjDIVyQBfHY96roBRA4jTJbVHV8+zWbaY8keY8ef2diKfkHd2xEN9sCGKfxIq665rkZD4c8Vgz84Rroc3inJDVB/7BGhVFkb9LgYo4C4Rx84ZPx2/Hnsbb+VKyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042825; c=relaxed/simple;
	bh=Q7aXi4fcGo6T1SehVHNdY3YQJ59WO0VvIIZiNerAq64=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iAfOtb0P46tcUv00caOEvaCFyYJn9/c7gYg8eJmyIb9wCrWi8uqwTRIDPhN6Sc+ctzvqG7U88+DlGVugYWbClJSPQI3H69MMfUdOPxx4jP25zHvJ4Gzk7YwlmygJ+3NwrV9SsihEibJ5KNG6VZAse2I9Cudth3bGuTNzR+gw1xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5hLHK5Z; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b6e6cf6742so271062085a.3
        for <stable@vger.kernel.org>; Thu, 16 Jan 2025 07:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737042822; x=1737647622; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+NgxzohitdM1qWFyHYVoLcjjA8gFpN7ubVQANdColG0=;
        b=r5hLHK5ZCoUNXy5lcs2O53Bd7U9YQQLRg1VuD1mFi/jtMgfSJEBvfGehNM+5cLK//V
         IUU53SWd4FWlZ8QjGl8Es58lLZR6hJZYmZFHcQvwc465o8XctGfvChWwLMzCqUPSJ4U1
         cx9E5ZlI7vrw5vUGH7vwciesaeXGCCZmGMS9LUpE5+V4fp7qNBYAqq3pg7M7O1JmVuWA
         ZZDaU2VJmwYJCCfAW5HCrbVqa4/adTWOImRpYWujRqEFslw0NgVHN+yVcazt0614AGkq
         lI/XZrkVgpnO7WCXEiFRYAdnPNKAqq6DrgbNA1mb8C5P1ZqXW8adm7+6pG+H2EvhlIwK
         4IZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737042822; x=1737647622;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+NgxzohitdM1qWFyHYVoLcjjA8gFpN7ubVQANdColG0=;
        b=askjJsxtozRjsNkm44tBVf8+XpAmLq/hJhZC+t/deDLc0Ta3ORQrcNEHrug5wkdFaP
         gRrzHCmh37TZtU8lb8qsEHuKI3Q8Rjez54nUiIzLHKG+VWNlDCHwbZvN7kYao924VssS
         +iVL+n8QNxx/g/si62r4iCCC02IBgAWgMqoBLQk5Z6QL9fj2llcYzkJSH4MTP+flwnEF
         x+bBhdFIjJrThQMWveTHm1vf8YuYZ/sK8rYtfsvscKHOgh4/z9j5dc/Msr33qxY6No+p
         rVwQHb50xohGGu2h5AcgXb7sXaiDoRtZCDkARVv9AZwKDXVaJPNNAZR9EHkexCN2qhvq
         8HaA==
X-Forwarded-Encrypted: i=1; AJvYcCWWmNCC0it273vFMJlqj9dGOYuT6P9nRfBCIr/JnePnMW3xy+2TBKr4jIiEvRIASdpxHJVvvyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhpPTWpDZS0N1YderAOf2S4H87NECatItvILSm25lZWM7Vyw/+
	ER+jFFEDAeh2iRxySIV6mIhGb4lNk9l7JS8nl077wQvT340CwQpELpmOiAht9bEc5D9phfS3gAz
	HzOk4Sw==
X-Google-Smtp-Source: AGHT+IGJOnZhDdWOuqF4V2FKZrAxZRVdn4bKnAiEpdg+yjoPSSoWSLu+uDS4cdr2EjL67ZS7jo3Ffc+mWC1W
X-Received: from qkhn21.prod.google.com ([2002:a05:620a:2235:b0:7b6:cc15:8bb0])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:5e15:b0:7be:3cd7:dd95
 with SMTP id af79cd13be357-7be3cd7de65mr1979422985a.12.1737042822520; Thu, 16
 Jan 2025 07:53:42 -0800 (PST)
Date: Thu, 16 Jan 2025 10:53:40 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250116155340.533180-1-bgeffon@google.com>
Subject: [PATCH v2] drm/i915: Fix page cleanup on DMA remap failure
From: Brian Geffon <bgeffon@google.com>
To: intel-gfx@lists.freedesktop.org
Cc: chris.p.wilson@intel.com, jani.saarinen@intel.com, tomasz.mistat@intel.com, 
	vidya.srinivas@intel.com, ville.syrjala@linux.intel.com, 
	jani.nikula@linux.intel.com, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Brian Geffon <bgeffon@google.com>, 
	stable@vger.kernel.org, Tomasz Figa <tfiga@google.com>
Content-Type: text/plain; charset="UTF-8"

When converting to folios the cleanup path of shmem_get_pages() was
missed. When a DMA remap fails and the max segment size is greater than
PAGE_SIZE it will attempt to retry the remap with a PAGE_SIZEd segment
size. The cleanup code isn't properly using the folio apis and as a
result isn't handling compound pages correctly.

v1 -> v2:
  (Ville) Fixed locations where we were not clearing mapping unevictable.

Cc: stable@vger.kernel.org
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: Vidya Srinivas <vidya.srinivas@intel.com>
Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13487
Link: https://lore.kernel.org/lkml/20250116135636.410164-1-bgeffon@google.com/
Fixes: 0b62af28f249 ("i915: convert shmem_sg_free_table() to use a folio_batch")
Signed-off-by: Brian Geffon <bgeffon@google.com>
Suggested-by: Tomasz Figa <tfiga@google.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_object.h |  3 +--
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c  | 23 +++++++++-------------
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c    |  7 ++++---
 3 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index 3dc61cbd2e11..0f122a12d4a5 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -843,8 +843,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			 size_t size, struct intel_memory_region *mr,
 			 struct address_space *mapping,
 			 unsigned int max_segment);
-void shmem_sg_free_table(struct sg_table *st, struct address_space *mapping,
-			 bool dirty, bool backup);
+void shmem_sg_free_table(struct sg_table *st, bool dirty, bool backup);
 void __shmem_writeback(size_t size, struct address_space *mapping);
 
 #ifdef CONFIG_MMU_NOTIFIER
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index fe69f2c8527d..b320d9dfd6d3 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -29,16 +29,13 @@ static void check_release_folio_batch(struct folio_batch *fbatch)
 	cond_resched();
 }
 
-void shmem_sg_free_table(struct sg_table *st, struct address_space *mapping,
-			 bool dirty, bool backup)
+void shmem_sg_free_table(struct sg_table *st, bool dirty, bool backup)
 {
 	struct sgt_iter sgt_iter;
 	struct folio_batch fbatch;
 	struct folio *last = NULL;
 	struct page *page;
 
-	mapping_clear_unevictable(mapping);
-
 	folio_batch_init(&fbatch);
 	for_each_sgt_page(page, sgt_iter, st) {
 		struct folio *folio = page_folio(page);
@@ -180,10 +177,10 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	return 0;
 err_sg:
 	sg_mark_end(sg);
+	mapping_clear_unevictable(mapping);
 	if (sg != st->sgl) {
-		shmem_sg_free_table(st, mapping, false, false);
+		shmem_sg_free_table(st, false, false);
 	} else {
-		mapping_clear_unevictable(mapping);
 		sg_free_table(st);
 	}
 
@@ -209,8 +206,6 @@ static int shmem_get_pages(struct drm_i915_gem_object *obj)
 	struct address_space *mapping = obj->base.filp->f_mapping;
 	unsigned int max_segment = i915_sg_segment_size(i915->drm.dev);
 	struct sg_table *st;
-	struct sgt_iter sgt_iter;
-	struct page *page;
 	int ret;
 
 	/*
@@ -239,9 +234,8 @@ static int shmem_get_pages(struct drm_i915_gem_object *obj)
 		 * for PAGE_SIZE chunks instead may be helpful.
 		 */
 		if (max_segment > PAGE_SIZE) {
-			for_each_sgt_page(page, sgt_iter, st)
-				put_page(page);
-			sg_free_table(st);
+			/* Leave the mapping unevictable while we retry */
+			shmem_sg_free_table(st, false, false);
 			kfree(st);
 
 			max_segment = PAGE_SIZE;
@@ -265,7 +259,8 @@ static int shmem_get_pages(struct drm_i915_gem_object *obj)
 	return 0;
 
 err_pages:
-	shmem_sg_free_table(st, mapping, false, false);
+	mapping_clear_unevictable(mapping);
+	shmem_sg_free_table(st, false, false);
 	/*
 	 * shmemfs first checks if there is enough memory to allocate the page
 	 * and reports ENOSPC should there be insufficient, along with the usual
@@ -402,8 +397,8 @@ void i915_gem_object_put_pages_shmem(struct drm_i915_gem_object *obj, struct sg_
 	if (i915_gem_object_needs_bit17_swizzle(obj))
 		i915_gem_object_save_bit_17_swizzle(obj, pages);
 
-	shmem_sg_free_table(pages, file_inode(obj->base.filp)->i_mapping,
-			    obj->mm.dirty, obj->mm.madv == I915_MADV_WILLNEED);
+	mapping_clear_unevictable(file_inode(obj->base.filp)->i_mapping);
+	shmem_sg_free_table(pages, obj->mm.dirty, obj->mm.madv == I915_MADV_WILLNEED);
 	kfree(pages);
 	obj->mm.dirty = false;
 }
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index 10d8673641f7..37f51a04b838 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -232,7 +232,8 @@ static int i915_ttm_tt_shmem_populate(struct ttm_device *bdev,
 	return 0;
 
 err_free_st:
-	shmem_sg_free_table(st, filp->f_mapping, false, false);
+	mapping_clear_unevictable(filp->f_mapping);
+	shmem_sg_free_table(st, false, false);
 
 	return err;
 }
@@ -243,8 +244,8 @@ static void i915_ttm_tt_shmem_unpopulate(struct ttm_tt *ttm)
 	bool backup = ttm->page_flags & TTM_TT_FLAG_SWAPPED;
 	struct sg_table *st = &i915_tt->cached_rsgt.table;
 
-	shmem_sg_free_table(st, file_inode(i915_tt->filp)->i_mapping,
-			    backup, backup);
+	mapping_clear_unevictable(file_inode(i915_tt->filp)->i_mapping);
+	shmem_sg_free_table(st, backup, backup);
 }
 
 static void i915_ttm_tt_release(struct kref *ref)
-- 
2.48.0.rc2.279.g1de40edade-goog


