Return-Path: <stable+bounces-2343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DA47F83C6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E811C264A0
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90456381D2;
	Fri, 24 Nov 2023 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qiN+Z8I5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43F33E9;
	Fri, 24 Nov 2023 19:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4088EC433C7;
	Fri, 24 Nov 2023 19:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853648;
	bh=Gy70Kws/uFsJDXlekRO8q2TMtopFE4ZA14zX/zfJnn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qiN+Z8I54yEIWiVba4pBV5DVtrHFuqd7P4o/Er+IOjSDWPyEOcsIbNhPxWDAvtVHw
	 j9Sg035mDB7dHI65lCfOYAby9cBpgizVVxIoJ67Y9KMxNxdYitRJgAULwM2ihPOdNY
	 7yCUYVHiWG74GUwMuvHgAe8NaDp5DX4MCXwu6Q78=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Christoph Lameter <cl@linux.com>,
	Shakeel Butt <shakeelb@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 273/297] mm: kmem: drop __GFP_NOFAIL when allocating objcg vectors
Date: Fri, 24 Nov 2023 17:55:15 +0000
Message-ID: <20231124172009.689480055@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Gushchin <roman.gushchin@linux.dev>

commit 24948e3b7b12e0031a6edb4f49bbb9fb2ad1e4e9 upstream.

Objcg vectors attached to slab pages to store slab object ownership
information are allocated using gfp flags for the original slab
allocation.  Depending on slab page order and the size of slab objects,
objcg vector can take several pages.

If the original allocation was done with the __GFP_NOFAIL flag, it
triggered a warning in the page allocation code.  Indeed, order > 1 pages
should not been allocated with the __GFP_NOFAIL flag.

Fix this by simply dropping the __GFP_NOFAIL flag when allocating the
objcg vector.  It effectively allows to skip the accounting of a single
slab object under a heavy memory pressure.

An alternative would be to implement the mechanism to fallback to order-0
allocations for accounting metadata, which is also not perfect because it
will increase performance penalty and memory footprint of the kernel
memory accounting under memory pressure.

Link: https://lkml.kernel.org/r/ZUp8ZFGxwmCx4ZFr@P9FQF9L96D.corp.robot.car
Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Reported-by: Christoph Lameter <cl@linux.com>
Closes: https://lkml.kernel.org/r/6b42243e-f197-600a-5d22-56bd728a5ad8@gentwo.org
Acked-by: Shakeel Butt <shakeelb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memcontrol.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2822,7 +2822,8 @@ retry:
  * Moreover, it should not come from DMA buffer and is not readily
  * reclaimable. So those GFP bits should be masked off.
  */
-#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
+#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | \
+				 __GFP_ACCOUNT | __GFP_NOFAIL)
 
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 				 gfp_t gfp, bool new_page)



