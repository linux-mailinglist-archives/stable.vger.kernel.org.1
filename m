Return-Path: <stable+bounces-188277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D32BF4383
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 03:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42B594E2380
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 01:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F437169AD2;
	Tue, 21 Oct 2025 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TqylpQ8j"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FE286347
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761008696; cv=none; b=Hiy/CvJ6HUoH2+SfbSmpAE+eu11xGXtC7hhfAMAShJSUJijYU4JFkh8PFtoiHx3kjbR1badsfC29xr0JbkB7JrRE1TdJF1gAE+eE/qduM82y78YvJP0MHw/T56LaPxQqNT/C5y3AJiIzIM04pGWPHlRczVz3we1MpiW4kAQxuqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761008696; c=relaxed/simple;
	bh=6aN2ovqyybXzCMwblB9oyJ2EfGZvvf/XwIjAojm4NZs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FU/v2JoQpNmUWKfe6P/zpUnoclisszF6tSw0z2dKuuSuSZPDPNvswVQIBkMU0MAarsxZCoBGb4zzuxGm3ahi7g/VAamG+1ujMZIhz4XjZ9hJrFGa2iSo3Mm6FOd8MSeg9Clc75ovEKJWwj4SaTTgnNpbzOyuXa5HggWhFXIYUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TqylpQ8j; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761008689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/uhNugh/EUyo0G9PtnWbQz5kQB6FYcMFt9ZcmcW3jq8=;
	b=TqylpQ8jaM+tbH6RZRwPSgDqSyExtn/o1YOdg6CC3a+gfj0xGkpuyk1O6LrMagcfAc88iq
	erQ6AWTHO0yiIyOSjRHExx+Oz54RKFO4QVqX/mKymo0e/bl2mj0+vR7PKMlldkNwXxTDoK
	PaRg2JM/VgIA1BzjEE7euqijCyQ0Pac=
From: Hao Ge <hao.ge@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3] slab: Avoid race on slab->obj_exts in alloc_slab_obj_exts
Date: Tue, 21 Oct 2025 09:03:53 +0800
Message-Id: <20251021010353.1187193-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

If two competing threads enter alloc_slab_obj_exts() and one of them
fails to allocate the object extension vector, it might override the
valid slab->obj_exts allocated by the other thread with
OBJEXTS_ALLOC_FAIL. This will cause the thread that lost this race and
expects a valid pointer to dereference a NULL pointer later on.

Update slab->obj_exts atomically using cmpxchg() to avoid
slab->obj_exts overrides by racing threads.

Thanks for Vlastimil and Suren's help with debugging.

Fixes: f7381b911640 ("slab: mark slab->obj_exts allocation failures unconditionally")
Cc: <stable@vger.kernel.org>
Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v3: According to Suren's suggestion, simplify the commit message and the code comments.
    Thanks for Suren.

v2: Incorporate handling for the scenario where, if mark_failed_objexts_alloc wins the race,
    the other process (that previously succeeded in allocation) will lose the race, based on Suren's suggestion.
    Add Suggested-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/slub.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2e4340c75be2..d4403341c9df 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2054,7 +2054,7 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 
 static inline void mark_failed_objexts_alloc(struct slab *slab)
 {
-	slab->obj_exts = OBJEXTS_ALLOC_FAIL;
+	cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
 }
 
 static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
@@ -2136,6 +2136,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 #ifdef CONFIG_MEMCG
 	new_exts |= MEMCG_DATA_OBJEXTS;
 #endif
+retry:
 	old_exts = READ_ONCE(slab->obj_exts);
 	handle_failed_objexts_alloc(old_exts, vec, objects);
 	if (new_slab) {
@@ -2145,8 +2146,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		 * be simply assigned.
 		 */
 		slab->obj_exts = new_exts;
-	} else if ((old_exts & ~OBJEXTS_FLAGS_MASK) ||
-		   cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
+	} else if (old_exts & ~OBJEXTS_FLAGS_MASK) {
 		/*
 		 * If the slab is already in use, somebody can allocate and
 		 * assign slabobj_exts in parallel. In this case the existing
@@ -2158,6 +2158,9 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		else
 			kfree(vec);
 		return 0;
+	} else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
+		/* Retry if a racing thread changed slab->obj_exts from under us. */
+		goto retry;
 	}
 
 	if (allow_spin)
-- 
2.25.1


