Return-Path: <stable+bounces-110908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1BCA1DD83
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 21:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7E71650F8
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 20:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D944B195FEF;
	Mon, 27 Jan 2025 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iQ/Kiqy9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1445F19343E
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738010616; cv=none; b=sUAaLT7he27UCD/zac40YD6DwQ9jIQl2gklT3s538kBoQcjA05nJ+HH7rkYNQAnOMNpehP0OGca0W+yc5HBfqqNP6sPJnKWFHWlx3cb58K8qzJAJB5WVjYV+SGSRo1vzoR8IsOrWMjzJA6H5OlojtALM6UwLGj4mU1NVJtII+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738010616; c=relaxed/simple;
	bh=2zJNhekoOTDEKC1Z1sASz6aCP00dorFA0rEUrkQHgHw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KC2QJ9ifDOiyBS2Z0fM+4hbyb60QiU93F6J0chv/DQRgh9UNV5sEZrwqloAo6xqz/wMt6AyeVk/uafTFxhlKXvkR4+IVTlj47aJPrrGtCgxP3/4d8ZGD6ysO8JDzfY2ujFiy8PZeh1doldDuSMsKJ6olFoPlTZBybvwRMVXMh9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iQ/Kiqy9; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7bcdb02f43cso591516685a.3
        for <stable@vger.kernel.org>; Mon, 27 Jan 2025 12:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738010614; x=1738615414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dzV8UGvkBceXUR/vOOPGtdnW22mWggChKVN4qUYB1M4=;
        b=iQ/Kiqy96U4+eFN8LxQ/qbH9JSsG+Ls5hq3S/TYST3S5cmWKggAZGaaOp5NaAOP7Oi
         DnGCyh9GIZ4vg6LVXhtg4fmsKVBHhTs3StHbKhrSslAWIVEMy3OZJB5ySQIUL9lhyGNF
         3VCq4iFZdgS9hj1ki4p4jR6KW988I5aF/MwryJZtNTL2XoUesP20yjDnNUbG3evTdWLv
         Lz6GNiEfu4/od6tG9Sjas4T+W+zyb0OOoJZorcQkE/ZdLY9pAH41L2B2fg23IzuSnuye
         /1yB8VmnK0brTCk733kqQPn3a9uQxcOGIHctFP/R/BTrsQq4td/+Iswj3sH8HZEsfEoz
         MRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738010614; x=1738615414;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzV8UGvkBceXUR/vOOPGtdnW22mWggChKVN4qUYB1M4=;
        b=v6fXyMiApBfqbih6LDrj6WcMFr+UIjKKKJfT8RLeW8OSFIH3qEbBb0c7mBvN9XDYFO
         3GQ1UYHEDDkx5EzYUQ1XvkF4BJyOPF31vwaoiqDyfWSWYR7urlbYIFdKly78Y84JDc8l
         XjksgkxUaul0fUudLM+n5tAA4L9EJamwXUekZT4p7Wh7ymkmn4PhcIFX1pbUuPSvUQLJ
         2qeDkyFt4H48y4kKRGGJpkmvFBYJM6MJJi7QkpL9Ohm35SdjYgwznmOAwx+wrUxVJ9O4
         W4TmfsB8cWZOZbucGOzHapHEVQMwLo5VxWCP+BI5EOuVb4Ym2d4B2dAu/WAuoHlAFAWs
         zeOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDkz7DdLWUp63/fl/eopZFZgvz8QBS4xjInKEpkekijdn3/hvGTq9NJzjQKon0/RA24q8Y2z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf+wVqaGfWYqaGV3zS6zpwP43gYE7ffMHAUiAGp3vlucGwTOa3
	q0OMurdRq2UPx/8atiTXyKpaaRNzQmCZxGxRHpan4uk4c/ZQqc7pb3nID2vUFuvEemrTkToLm6m
	vaALpKw==
X-Google-Smtp-Source: AGHT+IFBEQv8z7rhsVep9QiuDVivUN9tp7MT3P8OMl7BIPAdO6dy1kXGcW3kGPZSV9SxDeEqemTQqq2vMIKN
X-Received: from qkbdv21.prod.google.com ([2002:a05:620a:1b95:b0:7b6:eecf:b804])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:4048:b0:7b1:4f5c:a3a3
 with SMTP id af79cd13be357-7be63252ab6mr7274491485a.56.1738010614042; Mon, 27
 Jan 2025 12:43:34 -0800 (PST)
Date: Mon, 27 Jan 2025 15:43:32 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250127204332.336665-1-bgeffon@google.com>
Subject: [PATCH v3] drm/i915: Fix page cleanup on DMA remap failure
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

v2 -> v3:
(Ville) Just use shmem_sg_free_table() as-is in the failure path of
shmem_get_pages(). shmem_sg_free_table() will clear mapping unevictable
but it will be reset when it retries in shmem_sg_alloc_table().

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
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index fe69f2c8527d..ae3343c81a64 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -209,8 +209,6 @@ static int shmem_get_pages(struct drm_i915_gem_object *obj)
 	struct address_space *mapping = obj->base.filp->f_mapping;
 	unsigned int max_segment = i915_sg_segment_size(i915->drm.dev);
 	struct sg_table *st;
-	struct sgt_iter sgt_iter;
-	struct page *page;
 	int ret;
 
 	/*
@@ -239,9 +237,7 @@ static int shmem_get_pages(struct drm_i915_gem_object *obj)
 		 * for PAGE_SIZE chunks instead may be helpful.
 		 */
 		if (max_segment > PAGE_SIZE) {
-			for_each_sgt_page(page, sgt_iter, st)
-				put_page(page);
-			sg_free_table(st);
+			shmem_sg_free_table(st, mapping, false, false);
 			kfree(st);
 
 			max_segment = PAGE_SIZE;
-- 
2.48.1.262.g85cc9f2d1e-goog


