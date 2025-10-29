Return-Path: <stable+bounces-191560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33333C17F2A
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 02:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B96E4FDD1C
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 01:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210EF2E1EE1;
	Wed, 29 Oct 2025 01:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YNccw/Br"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F12E764B
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 01:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761702277; cv=none; b=M8ecmrMYKokSSvyqnNoMenaC4cSs5ZF2Gmp4eK1qGYQjYL2gWWtdNqZTUDebFzf/juRLFr44A/C3a9fBRx49uSL1i4gU5zoAuX5M28xMERB1yL87gSKz9nf8c5tnmiovnvHru49v23hqfhj/cuopZnNF9K5ucxRd6elDvAdO6sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761702277; c=relaxed/simple;
	bh=9FQqxzQaeW5MFmh0zozjU7zxq/0jRrA2zdyVnI5HQ2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zqkh4Ty3R3zkvx9HvZ5rAWTGN/Zr+ALrjJxY1IIFRQIFnwLGXf4EdpVCHqsYOlgp6UU5QcbH99o/WjFkz85pYaS1HomNFV8sZoB2EHPYcsEf96QEpj5kXr0RCA3APMzQ0COQtWBCBbaJpuBvhej6fIVXX4I7n5qIgf/wu9qzf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YNccw/Br; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761702260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aM/F09QVx4GPfPIsMF79qJ9NKFno9SfH3yZf/+Wb3Q4=;
	b=YNccw/Brrj60Ymznhn+quzxsoksok+V00LoQGOyoH4Q+qtEC4B97JrnW1LVOha4EqiDScG
	1MVaXdaSs4/R7NQO5tEvxYNdP9zpKJ/mPP1+IU0mbH6fnOHXni5Db0Gb4Lc4vWLTiopCiX
	JZzA/4kwYSLhZy5w8E9niBLNXtimJMg=
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
Subject: [PATCH v2] codetag: debug: handle existing CODETAG_EMPTY in mark_objexts_empty for slabobj_ext
Date: Wed, 29 Oct 2025 09:43:17 +0800
Message-Id: <20251029014317.1533488-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

When alloc_slab_obj_exts() fails and then later succeeds in allocating
a slab extension vector, it calls handle_failed_objexts_alloc() to
mark all objects in the vector as empty. As a result all objects in
this slab (slabA) will have their extensions set to CODETAG_EMPTY.
Later on if this slabA is used to allocate a slabobj_ext vector for
another slab (slabB), we end up with the slabB->obj_exts pointing to a
slabobj_ext vector that itself has a non-NULL slabobj_ext equal to
CODETAG_EMPTY. When slabB gets freed, free_slab_obj_exts() is called
to free slabB->obj_exts vector. free_slab_obj_exts() calls
mark_objexts_empty(slabB->obj_exts) which will generate a warning
because it expects slabobj_ext vectors to have a NULL obj_ext, not
CODETAG_EMPTY.

Modify mark_objexts_empty() to skip the warning and setting the
obj_ext value if it's already set to CODETAG_EMPTY.

Fixes: 09c46563ff6d ("codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark failed slab_ext allocations")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v2: Update the commit message and code comments for greater accuracy,
    incorporating Suren's suggestions.
    Thanks for Suren's help.
---
 mm/slub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index d4367f25b20d..589c596163c4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2046,7 +2046,11 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 	if (slab_exts) {
 		unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
 						 obj_exts_slab, obj_exts);
-		/* codetag should be NULL */
+
+		if (unlikely(is_codetag_empty(&slab_exts[offs].ref)))
+			return;
+
+		/* codetag should be NULL here */
 		WARN_ON(slab_exts[offs].ref.ct);
 		set_codetag_empty(&slab_exts[offs].ref);
 	}
-- 
2.25.1


