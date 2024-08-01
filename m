Return-Path: <stable+bounces-65216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D5B94416F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 04:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270631F2219A
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9204B13C3D3;
	Thu,  1 Aug 2024 02:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hZkOmvBq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E126213BAF1
	for <stable@vger.kernel.org>; Thu,  1 Aug 2024 02:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722480763; cv=none; b=JmlRLJbj8iGcI2fi8V3ZL6b6EWoGqWe8PL9abuDogvNPQbvj9erZyq5AwszcJNlRe4+iVmPPQo1Q7P5vJynOI2XkSIJXX6b+T8OzzSf5lVFIgi9G+kdKERgHMHQRUJjoomNaNOPtJctSq+k1ChlJ8dgk/4sC/pwwp64V2jckGxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722480763; c=relaxed/simple;
	bh=jdh5QL8IAPjC5hwY1uxfbyge2t1ate/DN9AIY7RnTmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f7V3g1cacDagUmTw1inG3ZR/NqETpRkO3k0Iym2mcXfKbMCXi/0I7ptapjIJfcHYqhbTNocOPUyK9+Io1yOQHelohSTC1kOTZstp3W+/NI1tHFUvneFWe7lzudQ2cGP5B2TPYQGgzm+EbKyOkYNc86xVCcCQoI5rs+R5JhCjiZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hZkOmvBq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd66cddd07so46958235ad.2
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 19:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722480761; x=1723085561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MO67bKN71emtFnIdYufuYQuueaGz+jJ9f99zlg6P9GY=;
        b=hZkOmvBqvvApsh6CfHv/euLDrMB4eW5EAqpOM4BpSgA0wCBjKMkieSheugXNv27pGJ
         xv7abBUZ98GfyKV+vEtaOyVJUP1JaTyRMSshTczXciatvVh1KDIdOL7pE4z6ehSDc9v5
         AzazYpLsDvMoUFPjXU+K4NmL4Xhll/9wl3M5jJIrPK+p36a/RrGVPjWeceWoEbpRLwMz
         s899886ep8PyrpTXk7knnoWiFz50VMohxSq/pkojpDpLLfhfprIlWd35kYaXqWSkXoo7
         vyzc//SrMJ0u6iCrisjovjs+hWoa1gqse7vcBWHOxEnZxLwPzfG+qvqPmwU7CYkkL43X
         P70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722480761; x=1723085561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MO67bKN71emtFnIdYufuYQuueaGz+jJ9f99zlg6P9GY=;
        b=B8CiA2gWt99rlN8yTv61J/qS1QWfnSwS3vbFz9SW0sSEukI1xP1yO+GXznWnSwyVs0
         3Xzw/cRqi9MuWWPFIraDMdJIrP85aUPpjKm/Bb1DFrY6jMlmpIiIIztzqDxrfY6UZvv2
         SLrGz/+lSU6mQebVoZJSujDaVV0CLrYwWbXQ0VMeSb3uvjDYFRQ4L2vK6vCOwBge+Wtl
         cFUAZN+NHE/TikPpWuaD1f21wrO5ZlIO+0UmOwIhmczYvGz+w1JQEA4i+e9pyjmVKO4c
         dJZiapSWnpRl4Nm7yBuKKpEe2o7tJtJ6BprAmjlmoN7QqCL4Ys7S95lEMobAEzpUW98r
         qN4A==
X-Forwarded-Encrypted: i=1; AJvYcCUryQksGZf1JhXIXWJt6s6ia7s7tIB2nQ+rhjcucHmI8k7X0PaIXAg1mQ8XR6MB5SmiBbtpXS0CX1D65b1RFuAKw+bipZv9
X-Gm-Message-State: AOJu0Yzx6wrE+YxY+uzwmz/E1+l8Xz4bPxAKQn/uQ1PLrJOQyVjK1svN
	rSRdKjLNxbYFJrfBIygy7nGGUPPr7yo8e0u1R3/7shcjxxmzAESUA2jCzJK8qeM=
X-Google-Smtp-Source: AGHT+IHUUI2hJklTanphWfjhEVjpkQn8/7G1hpxN+PZYzcg0FnUHpugBQX6p1CwTxCTIR0lX05VE4Q==
X-Received: by 2002:a17:902:f691:b0:1fd:d5b8:a4be with SMTP id d9443c01a7336-1ff4d242db4mr15825825ad.53.1722480761112;
        Wed, 31 Jul 2024 19:52:41 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee4b0asm128018165ad.176.2024.07.31.19.52.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 31 Jul 2024 19:52:40 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	vbabka@kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm: list_lru: fix UAF for memory cgroup
Date: Thu,  1 Aug 2024 10:46:03 +0800
Message-Id: <20240801024603.1865-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mem_cgroup_from_slab_obj() is supposed to be called under rcu
lock or cgroup_mutex or others which could prevent returned memcg
from being freed. Fix it by adding missing rcu read lock.

Fixes: 0a97c01cd20b ("list_lru: allow explicit memcg and NUMA node selection")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
---
v2:
 Only grab rcu lock when necessary (Vlastimil Babka)

 mm/list_lru.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index a29d96929d7c7..9b7ff06e9d326 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -85,6 +85,7 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 }
 #endif /* CONFIG_MEMCG */
 
+/* The caller must ensure the memcg lifetime. */
 bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
 		    struct mem_cgroup *memcg)
 {
@@ -109,14 +110,22 @@ EXPORT_SYMBOL_GPL(list_lru_add);
 
 bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
 {
+	bool ret;
 	int nid = page_to_nid(virt_to_page(item));
-	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
-		mem_cgroup_from_slab_obj(item) : NULL;
 
-	return list_lru_add(lru, item, nid, memcg);
+	if (list_lru_memcg_aware(lru)) {
+		rcu_read_lock();
+		ret = list_lru_add(lru, item, nid, mem_cgroup_from_slab_obj(item));
+		rcu_read_unlock();
+	} else {
+		ret = list_lru_add(lru, item, nid, NULL);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(list_lru_add_obj);
 
+/* The caller must ensure the memcg lifetime. */
 bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
 		    struct mem_cgroup *memcg)
 {
@@ -139,11 +148,18 @@ EXPORT_SYMBOL_GPL(list_lru_del);
 
 bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
 {
+	bool ret;
 	int nid = page_to_nid(virt_to_page(item));
-	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
-		mem_cgroup_from_slab_obj(item) : NULL;
 
-	return list_lru_del(lru, item, nid, memcg);
+	if (list_lru_memcg_aware(lru)) {
+		rcu_read_lock();
+		ret = list_lru_del(lru, item, nid, mem_cgroup_from_slab_obj(item));
+		rcu_read_unlock();
+	} else {
+		ret = list_lru_del(lru, item, nid, NULL);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(list_lru_del_obj);
 
-- 
2.20.1


