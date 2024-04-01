Return-Path: <stable+bounces-34256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDD5893E91
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F2A281722
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998064596E;
	Mon,  1 Apr 2024 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fiGqLFX3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F021CA8F;
	Mon,  1 Apr 2024 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987509; cv=none; b=XO+0bO9UsE15iddjbT63i/U6hVTAfNv2UaxtDcUsuWMRYqIzuxRDOZzV3Z6jZfBbUB5Y0JlKnd+T4REXZO0Q5jlkBoYCREivn0TkZ6Zh17YxX7n6hrBHGGY80FxTHpjJWDgRMsiuoVVwTCASM/0kk1eLgE8cKvdV8vnu4xzsHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987509; c=relaxed/simple;
	bh=4tMNuuEly6qxZtzq8mm5wjqZQXuU+4BGuoRBgUWkSAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8zRdVhmcZk8KbPCw+gv7Ux8HgFhsN8S9GFo4J0hGhc3qFy/cMdGgLK8rFVSbubpoWXq09axr/jV9CVmJF2no2dR/qYn1k+/or0Xds2fE+bYzZdWEF/LQAUv8392n1wMkm/AUQt02I1BrWmPdgs+1OlJpNV8Jyi8zW6wbqdOllA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fiGqLFX3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF4AC433C7;
	Mon,  1 Apr 2024 16:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987509;
	bh=4tMNuuEly6qxZtzq8mm5wjqZQXuU+4BGuoRBgUWkSAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fiGqLFX3yhVeSCYsq0N0QSI7Efpqe1kzOtvdjVhCiFAaT4mnxUyaZ+Heiiyz3/Caj
	 cKSCjHwpBYrEsGe2aV8VRJPbrC4t2t0wnjaO4wpPDHXB2yuik7lrG0gl0mOLQ8beqa
	 uqsASfotjPTXopqc0kEog21UTpcrVsKLZypGzbBg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jann Horn <jannh@google.com>
Subject: [PATCH 6.8 309/399] mm: cachestat: fix two shmem bugs
Date: Mon,  1 Apr 2024 17:44:35 +0200
Message-ID: <20240401152558.411370553@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Weiner <hannes@cmpxchg.org>

commit d5d39c707a4cf0bcc84680178677b97aa2cb2627 upstream.

When cachestat on shmem races with swapping and invalidation, there
are two possible bugs:

1) A swapin error can have resulted in a poisoned swap entry in the
   shmem inode's xarray. Calling get_shadow_from_swap_cache() on it
   will result in an out-of-bounds access to swapper_spaces[].

   Validate the entry with non_swap_entry() before going further.

2) When we find a valid swap entry in the shmem's inode, the shadow
   entry in the swapcache might not exist yet: swap IO is still in
   progress and we're before __remove_mapping; swapin, invalidation,
   or swapoff have removed the shadow from swapcache after we saw the
   shmem swap entry.

   This will send a NULL to workingset_test_recent(). The latter
   purely operates on pointer bits, so it won't crash - node 0, memcg
   ID 0, eviction timestamp 0, etc. are all valid inputs - but it's a
   bogus test. In theory that could result in a false "recently
   evicted" count.

   Such a false positive wouldn't be the end of the world. But for
   code clarity and (future) robustness, be explicit about this case.

   Bail on get_shadow_from_swap_cache() returning NULL.

Link: https://lkml.kernel.org/r/20240315095556.GC581298@cmpxchg.org
Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reported-by: Chengming Zhou <chengming.zhou@linux.dev>	[Bug #1]
Reported-by: Jann Horn <jannh@google.com>		[Bug #2]
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Cc: <stable@vger.kernel.org>				[v6.5+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/filemap.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4153,7 +4153,23 @@ static void filemap_cachestat(struct add
 				/* shmem file - in swap cache */
 				swp_entry_t swp = radix_to_swp_entry(folio);
 
+				/* swapin error results in poisoned entry */
+				if (non_swap_entry(swp))
+					goto resched;
+
+				/*
+				 * Getting a swap entry from the shmem
+				 * inode means we beat
+				 * shmem_unuse(). rcu_read_lock()
+				 * ensures swapoff waits for us before
+				 * freeing the swapper space. However,
+				 * we can race with swapping and
+				 * invalidation, so there might not be
+				 * a shadow in the swapcache (yet).
+				 */
 				shadow = get_shadow_from_swap_cache(swp);
+				if (!shadow)
+					goto resched;
 			}
 #endif
 			if (workingset_test_recent(shadow, true, &workingset))



