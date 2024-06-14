Return-Path: <stable+bounces-52156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E1790860B
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 10:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A1E28225B
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5043518308F;
	Fri, 14 Jun 2024 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsaKF8hx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975D149C44;
	Fri, 14 Jun 2024 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353201; cv=none; b=tCr8ED9pwzeFsUVPibihmIGJjc+R/510Xj/RkxW0zcbSRuEgCpH4ayyFyNBuhHa/kCTVMB+WmhFAIZE20otA/KWfD9QSJ3alNpcgRjD5kc/aGmztxD3/94WVbpQsjlLJ98XwLGLiAfS88bnER5dIhXkN005OPlhjRUaU7R3scZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353201; c=relaxed/simple;
	bh=TfxsNSJanNhH9ZFOQCKMNV6ScMRC1YpRzhWw8GYJeO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/9xPHpqNHNs0A8slQAQ0nqZaUs6eG9gbt139o/ZzlawsubfmKZGivL6Q0AwMNVcK//fTNfnGdAttmuM2rT3afSmkaYfHFRezPH+SZRg4jyfduToRBPd6b1niUHTMYxmirsuMlRAkeqvxeH38VpYHHBwXgpZ/n3+49+oRsf15Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsaKF8hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA18C2BD10;
	Fri, 14 Jun 2024 08:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718353200;
	bh=TfxsNSJanNhH9ZFOQCKMNV6ScMRC1YpRzhWw8GYJeO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OsaKF8hxEn4ezvshOUa7jmZq4TwH2/vyh3QvveaZyX2trfbpmpapKC1xpwjtAqu36
	 Q5wa02/1/cKX9/nlO2xSx5bD6yCnH2AoyiAjNVtOrukBB9qzXU0WtDc4mIhDxLd0/m
	 jUar4GCbOyfc859tCNKgcJ1a6R/aDZPdRe6Qk44zIwgHyu85LmLQQcwdKt67+ze7cE
	 RCXvs4jYaALFRbt+m7TVY2lLePkdTmnZh+6GEtleonUjjdH7roNuSvZJh4t7q54oKK
	 iRoaRzEPwdI1lq8kRLL3zAvJ1J0LaNFhnlFC0eBcUAuwQfW2h2dK+doaV86COI59Eq
	 yOkPNK7ShDU+A==
Date: Fri, 14 Jun 2024 11:17:52 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Jan Beulich <jbeulich@suse.com>,
	Narasimhan V <Narasimhan.V@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, stable@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] memblock:fix validation of NUMA coverage
Message-ID: <Zmv8sMMGS8uosLQD@kernel.org>
References: <Zmr9oBecxdufMTeP@kernel.org>
 <CAHk-=wickw1bAqWiMASA2zRiEA_nC3etrndnUqn_6C1tbUjAcQ@mail.gmail.com>
 <CAHk-=wgOMcScTviziAbL9Z2RDduaEFdZbHsESxqUS2eFfUmUVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgOMcScTviziAbL9Z2RDduaEFdZbHsESxqUS2eFfUmUVg@mail.gmail.com>

On Thu, Jun 13, 2024 at 10:38:28AM -0700, Linus Torvalds wrote:
> On Thu, 13 Jun 2024 at 10:09, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Is there some broken scripting that people have started using (or have
> > been using for a while and was recently broken)?
> 
> ... and then when I actually pull the code, I note that the problem
> where it checked _one_ bogus value has just been replaced with
> checking _another_ bogus value.
> 
> Christ.
> 
> What if people use a node ID that is simply outside the range
> entirely, instead of one of those special node IDs?
> 
> And now for memblock_set_node() you should apparently use NUMA_NO_NODE
> to not get a warning, but for memblock_set_region_node() apparently
> the right random constant to use is MAX_NUMNODES.
> 
> Does *any* of this make sense? No.
> 
> How about instead of having two random constants - and not having any
> range checking that I see - just have *one* random constant for "I
> have no range", call that NUMA_NO_NODE, and then have a simple helper
> for "do I have a valid range", and make that be
> 
>    static inline bool numa_valid_node(int nid)
>    { return (unsigned int)nid < MAX_NUMNODES; }
> 
> or something like that? Notice that now *all* of
> 
>  - NUMA_NO_NODE (explicitly no node)
> 
>  - MAX_NUMNODES (randomly used no node)
> 
>  - out of range node (who knows wth firmware tables do?)
> 
> will get the same result from that "numa_valid_node()" function.
> 
> And at that point you don't need to care, you don't need to warn, and
> you don't need to have these insane rules where "sometimes you *HAVE*
> to use NUMA_NO_NODE, or we warn, in other cases MAX_NUMNODES is the
> thing".
> 
> Please? IOW, instead of adding a warning for fragile code, then change
> some caller to follow the new rules, JUST FIX THE STUPID FRAGILITY!
> 
> Or hey, just do
> 
>     #define NUMA_NO_NODE MAX_NUMNODES
> 
> and have two names for the *same* constant, instead fo having two
> different constants with strange semantic differences that seem to
> make no sense and where the memblock code itself seems to go
> back-and-forth on it in different contexts.

A single constant is likely to backfire because I remember seeing checks
like 'if (nid < 0)' so redefining NUMA_NO_NODE will require auditing all
those.

But a helper function works great.
I could only lightly test it as I don't have a fleet of machines with
variety of memory layouts, so I'm planning to push it into -next early next
week (with subject replaced by a more informative one)

From 319eddd74b372cae840782c7d53832ab30533a6b Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (IBM)" <rppt@kernel.org>
Date: Fri, 14 Jun 2024 11:05:43 +0300
Subject: [PATCH] memblock: FIX THE STUPID FRAGILITY

Introduce numa_valid_node(nid) that verifies that nid is a valid node ID
and use that instead of comparing nid parameter with either NUMA_NO_NODE
or MAX_NUMNODES.

This makes the checks for valid node IDs consistent and more robust and
allows to get rid of multiple WARNings.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/numa.h |  5 +++++
 mm/memblock.c        | 28 +++++++---------------------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/include/linux/numa.h b/include/linux/numa.h
index 1d43371fafd2..eb19503604fe 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -15,6 +15,11 @@
 #define	NUMA_NO_NODE	(-1)
 #define	NUMA_NO_MEMBLK	(-1)
 
+static inline bool numa_valid_node(int nid)
+{
+	return nid >= 0 && nid < MAX_NUMNODES;
+}
+
 /* optionally keep NUMA memory info available post init */
 #ifdef CONFIG_NUMA_KEEP_MEMINFO
 #define __initdata_or_meminfo
diff --git a/mm/memblock.c b/mm/memblock.c
index 08e9806b1cf9..e81fb68f7f88 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -754,7 +754,7 @@ bool __init_memblock memblock_validate_numa_coverage(unsigned long threshold_byt
 
 	/* calculate lose page */
 	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
-		if (nid == NUMA_NO_NODE)
+		if (!numa_valid_node(nid))
 			nr_pages += end_pfn - start_pfn;
 	}
 
@@ -1061,7 +1061,7 @@ static bool should_skip_region(struct memblock_type *type,
 		return false;
 
 	/* only memory regions are associated with nodes, check it */
-	if (nid != NUMA_NO_NODE && nid != m_nid)
+	if (numa_valid_node(nid) && nid != m_nid)
 		return true;
 
 	/* skip hotpluggable memory regions if needed */
@@ -1118,10 +1118,6 @@ void __next_mem_range(u64 *idx, int nid, enum memblock_flags flags,
 	int idx_a = *idx & 0xffffffff;
 	int idx_b = *idx >> 32;
 
-	if (WARN_ONCE(nid == MAX_NUMNODES,
-	"Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
-		nid = NUMA_NO_NODE;
-
 	for (; idx_a < type_a->cnt; idx_a++) {
 		struct memblock_region *m = &type_a->regions[idx_a];
 
@@ -1215,9 +1211,6 @@ void __init_memblock __next_mem_range_rev(u64 *idx, int nid,
 	int idx_a = *idx & 0xffffffff;
 	int idx_b = *idx >> 32;
 
-	if (WARN_ONCE(nid == MAX_NUMNODES, "Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
-		nid = NUMA_NO_NODE;
-
 	if (*idx == (u64)ULLONG_MAX) {
 		idx_a = type_a->cnt - 1;
 		if (type_b != NULL)
@@ -1303,7 +1296,7 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
 
 		if (PFN_UP(r->base) >= PFN_DOWN(r->base + r->size))
 			continue;
-		if (nid == MAX_NUMNODES || nid == r_nid)
+		if (!numa_valid_node(nid) || nid == r_nid)
 			break;
 	}
 	if (*idx >= type->cnt) {
@@ -1339,10 +1332,6 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 	int start_rgn, end_rgn;
 	int i, ret;
 
-	if (WARN_ONCE(nid == MAX_NUMNODES,
-		      "Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
-		nid = NUMA_NO_NODE;
-
 	ret = memblock_isolate_range(type, base, size, &start_rgn, &end_rgn);
 	if (ret)
 		return ret;
@@ -1452,9 +1441,6 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 	enum memblock_flags flags = choose_memblock_flags();
 	phys_addr_t found;
 
-	if (WARN_ONCE(nid == MAX_NUMNODES, "Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
-		nid = NUMA_NO_NODE;
-
 	if (!align) {
 		/* Can't use WARNs this early in boot on powerpc */
 		dump_stack();
@@ -1467,7 +1453,7 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 	if (found && !memblock_reserve(found, size))
 		goto done;
 
-	if (nid != NUMA_NO_NODE && !exact_nid) {
+	if (numa_valid_node(nid) && !exact_nid) {
 		found = memblock_find_in_range_node(size, align, start,
 						    end, NUMA_NO_NODE,
 						    flags);
@@ -1987,7 +1973,7 @@ static void __init_memblock memblock_dump(struct memblock_type *type)
 		end = base + size - 1;
 		flags = rgn->flags;
 #ifdef CONFIG_NUMA
-		if (memblock_get_region_node(rgn) != MAX_NUMNODES)
+		if (numa_valid_node(memblock_get_region_node(rgn)))
 			snprintf(nid_buf, sizeof(nid_buf), " on node %d",
 				 memblock_get_region_node(rgn));
 #endif
@@ -2181,7 +2167,7 @@ static void __init memmap_init_reserved_pages(void)
 			start = region->base;
 			end = start + region->size;
 
-			if (nid == NUMA_NO_NODE || nid >= MAX_NUMNODES)
+			if (!numa_valid_node(nid))
 				nid = early_pfn_to_nid(PFN_DOWN(start));
 
 			reserve_bootmem_region(start, end, nid);
@@ -2272,7 +2258,7 @@ static int memblock_debug_show(struct seq_file *m, void *private)
 
 		seq_printf(m, "%4d: ", i);
 		seq_printf(m, "%pa..%pa ", &reg->base, &end);
-		if (nid != MAX_NUMNODES)
+		if (numa_valid_node(nid))
 			seq_printf(m, "%4d ", nid);
 		else
 			seq_printf(m, "%4c ", 'x');
-- 
2.43.0

 
>               Linus

-- 
Sincerely yours,
Mike.

