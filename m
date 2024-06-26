Return-Path: <stable+bounces-55881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52579919874
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 21:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2571C2185A
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 19:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7025014A0B8;
	Wed, 26 Jun 2024 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0Uj2op2p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262ED191494;
	Wed, 26 Jun 2024 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431072; cv=none; b=LsqWiNXnRlfs3h5RPQN2iv3dc+i8XDccX+rmWS6BM4KkIr3A6vRLqhUVeBH8iUgglHtXLrh//y4naVyr/p4IcMNBwzbRg3J4DvLNaUKxJGl0paeY/ZwovPjja52yOK6NKSNSYrk+Oc0GIhIumybc6SmIiy4gQxnTRynJ5xEKMFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431072; c=relaxed/simple;
	bh=ZyYs7lTJW9WWv0MBAs8l2xGXgHddtwz6DWfa6WD5XeQ=;
	h=Date:To:From:Subject:Message-Id; b=Wv7ntIek4oWmrEb2sDwy8yxF2qpj417yuz3Ut45rkHh7QqPuyHWWjr2SjxDh5jdUVd/xovmWtj8fgaWCqrBXuLwqEtX4jzTEfBk2CHeofEq1hyXZ7xZaUTvKbtaSZNA4OG2mBIUithpI7GlBJ5f2KbFzKwGqCIpx0Qh0jqVvyu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0Uj2op2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF60C116B1;
	Wed, 26 Jun 2024 19:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719431071;
	bh=ZyYs7lTJW9WWv0MBAs8l2xGXgHddtwz6DWfa6WD5XeQ=;
	h=Date:To:From:Subject:From;
	b=0Uj2op2pNoFHnmdf0G1UYu+XFYkOn6vDaFKiq1uiAJVPimNe0yjayj8dnrDVu6Zun
	 7KG5iESdndl/LY7Sfgn8FEjj7/YIZ/GJH8HLr/d9CHW+bIBoPOtK2I5IV0XOUjvqpy
	 kEFAqQfBURVYCGCOKeD67l613Lhi8nxu99T7CeMo=
Date: Wed, 26 Jun 2024 12:44:30 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,oleksiy.avramchenko@sony.com,nbowler@draconx.ca,hch@infradead.org,hailong.liu@oppo.com,bhe@redhat.com,urezki@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-vmalloc-check-if-a-hash-index-is-in-cpu_possible_mask.patch added to mm-hotfixes-unstable branch
Message-Id: <20240626194431.7FF60C116B1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm: vmalloc: check if a hash-index is in cpu_possible_mask
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-vmalloc-check-if-a-hash-index-is-in-cpu_possible_mask.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-vmalloc-check-if-a-hash-index-is-in-cpu_possible_mask.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: mm: vmalloc: check if a hash-index is in cpu_possible_mask
Date: Wed, 26 Jun 2024 16:03:30 +0200

The problem is that there are systems where cpu_possible_mask has gaps
between set CPUs, for example SPARC.  In this scenario addr_to_vb_xa()
hash function can return an index which accesses to not-possible and not
setup CPU area using per_cpu() macro.  This results in an oops on SPARC.

A per-cpu vmap_block_queue is also used as hash table, incorrectly
assuming the cpu_possible_mask has no gaps.  Fix it by adjusting an index
to a next possible CPU.

Link: https://lkml.kernel.org/r/20240626140330.89836-1-urezki@gmail.com
Fixes: 062eacf57ad9 ("mm: vmalloc: remove a global vmap_blocks xarray")
Reported-by: Nick Bowler <nbowler@draconx.ca>
Closes: https://lore.kernel.org/linux-kernel/ZntjIE6msJbF8zTa@MiWiFi-R3L-srv/T/
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hailong.Liu <hailong.liu@oppo.com>
Cc: Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/vmalloc.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/mm/vmalloc.c~mm-vmalloc-check-if-a-hash-index-is-in-cpu_possible_mask
+++ a/mm/vmalloc.c
@@ -2543,7 +2543,15 @@ static DEFINE_PER_CPU(struct vmap_block_
 static struct xarray *
 addr_to_vb_xa(unsigned long addr)
 {
-	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
+	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
+
+	/*
+	 * Please note, nr_cpu_ids points on a highest set
+	 * possible bit, i.e. we never invoke cpumask_next()
+	 * if an index points on it which is nr_cpu_ids - 1.
+	 */
+	if (!cpu_possible(index))
+		index = cpumask_next(index, cpu_possible_mask);
 
 	return &per_cpu(vmap_block_queue, index).vmap_blocks;
 }
_

Patches currently in -mm which might be from urezki@gmail.com are

mm-vmalloc-check-if-a-hash-index-is-in-cpu_possible_mask.patch


