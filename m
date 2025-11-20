Return-Path: <stable+bounces-195210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF4C7197F
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 01:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBE084E1072
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 00:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0EB1DE2BF;
	Thu, 20 Nov 2025 00:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E5mzQQmp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BDD1EF38E
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 00:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763599612; cv=none; b=Cbke+w3O/jkNZ1Q/DCIC8aJR6d5YTW4d4GNFcLcuy4QAxQZMxEDcDagJBsneY+mtehX7W4yQXzLNpapUrrBHkLiebEGCjNAjDm3IEz0ozNj3HP5SCVrOrywkG1IQnkuU4nI6MSDc/hVSdoNtfsDt5Yao18r3dPtTHSdEiDXcSFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763599612; c=relaxed/simple;
	bh=ex36AqEu5u6kvJkLAoT49xL6SZDajGUNQof96jW/Dwo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AohlL/FW2Tw62D4qhQw+Qkjj5lcFYqrMWOpdfbEHPqud/1ig3U2M2M0AebhWKgnLo6ILogMP3ufhIwXGVjE5ERofI7SMBN/TXNbx+rV+ZsbyzI/KNwwKtwo21mVNSk1eBuoErAaIdLOT3lvo7D/KybDhIq9uXmFM6XugUgNo2X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E5mzQQmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8463AC4CEF5;
	Thu, 20 Nov 2025 00:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763599612;
	bh=ex36AqEu5u6kvJkLAoT49xL6SZDajGUNQof96jW/Dwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E5mzQQmpAZd5076RJmQhBoM5Dq46hvfibPyu3y+pTuGawh5HfOV9d5sec0MS2OE2a
	 zn29VpHtncY9DmbtvoexxXjcXmn76f0X0hVB0PteiBD7V7hK4eBl4CELexLBaZzrg1
	 FWBWO+zBWbUdnc6xXp8MfAm7HAHgOL/UR8xPhKXg=
Date: Wed, 19 Nov 2025 16:46:50 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, linux-mm@kvack.org,
 stable@vger.kernel.org
Subject: Re: [Patch v2] mm/huge_memory: fix NULL pointer deference when
 splitting folio
Message-Id: <20251119164650.e5ac7e3b5fa6062016652149@linux-foundation.org>
In-Reply-To: <20251120000312.xasxdzmmztvp4spa@master>
References: <20251119235302.24773-1-richard.weiyang@gmail.com>
	<20251120000312.xasxdzmmztvp4spa@master>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 00:03:12 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> +	 * TODO: this will also currently refuse shmem folios that are in the
> >+	 * swapcache.
> >+	 */
> >+	if (!is_anon && !folio->mapping)
> >+		return -EBUSY;
> >+
> 
> This one would have a conflict on direct cherry-pick to current master and
> mm-stable.
> 
> But if I move this code before (folio != page_folio(split_at) ...), it could
> be apply to mm-new and master/mm-stable smoothly.
> 
> Not sure whether this could make Andrew's life easier.

I added the below and fixed up fallout in the later patches.

If this doesn't apply to -stable kernels then the -stable maintainers
might later ask you to help rework it.



From: Wei Yang <richard.weiyang@gmail.com>
Subject: mm/huge_memory: fix NULL pointer deference when splitting folio
Date: Wed, 19 Nov 2025 23:53:02 +0000

Commit c010d47f107f ("mm: thp: split huge page to any lower order pages")
introduced an early check on the folio's order via mapping->flags before
proceeding with the split work.

This check introduced a bug: for shmem folios in the swap cache and
truncated folios, the mapping pointer can be NULL.  Accessing
mapping->flags in this state leads directly to a NULL pointer dereference.

This commit fixes the issue by moving the check for mapping != NULL before
any attempt to access mapping->flags.

Link: https://lkml.kernel.org/r/20251119235302.24773-1-richard.weiyang@gmail.com
Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/huge_memory.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

--- a/mm/huge_memory.c~mm-huge_memory-fix-null-pointer-deference-when-splitting-folio
+++ a/mm/huge_memory.c
@@ -3619,6 +3619,16 @@ static int __folio_split(struct folio *f
 	if (folio != page_folio(split_at) || folio != page_folio(lock_at))
 		return -EINVAL;
 
+	/*
+	 * Folios that just got truncated cannot get split. Signal to the
+	 * caller that there was a race.
+	 *
+	 * TODO: this will also currently refuse shmem folios that are in the
+	 * swapcache.
+	 */
+	if (!is_anon && !folio->mapping)
+		return -EBUSY;
+
 	if (new_order >= folio_order(folio))
 		return -EINVAL;
 
@@ -3659,18 +3669,6 @@ static int __folio_split(struct folio *f
 		gfp_t gfp;
 
 		mapping = folio->mapping;
-
-		/* Truncated ? */
-		/*
-		 * TODO: add support for large shmem folio in swap cache.
-		 * When shmem is in swap cache, mapping is NULL and
-		 * folio_test_swapcache() is true.
-		 */
-		if (!mapping) {
-			ret = -EBUSY;
-			goto out;
-		}
-
 		min_order = mapping_min_folio_order(folio->mapping);
 		if (new_order < min_order) {
 			ret = -EINVAL;
_


