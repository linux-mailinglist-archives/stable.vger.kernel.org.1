Return-Path: <stable+bounces-222740-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKZBDLoYpmmeKQAAu9opvQ
	(envelope-from <stable+bounces-222740-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 00:09:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F25A1E6597
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 00:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C364031B55C0
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 22:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35FF31E83F;
	Mon,  2 Mar 2026 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="twALcp3N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633E31A06C;
	Mon,  2 Mar 2026 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490527; cv=none; b=FjNbEMgQGGw1FeSyf5LdgWwNMoWAfYJDLOrrRNoJgO5RlIr56+P6QEiQCITB1Vu4Z5df3Rgx+JDM1uK3/VztxMmfPI6i+MhkAmDtygivB+y5d+0R/347rcvPtXUtMnWMqXGtP6UipcrSCSBXXfuxKzkJB2iQJPwTmvWAiKCQxEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490527; c=relaxed/simple;
	bh=Mzw9ZSYa0WyWWwpW0clcX9lo+Bk7602YPpbpkRLXTAA=;
	h=Date:To:From:Subject:Message-Id; b=fo7/78j9VrFN7JhE4j7lnTANBh4QVzRWT5mOSmRbHet/mdprk7dVRUlBVy0oWSxCx+SwK8/TKSjNtZRSE0HjOxJclfhvhrdy5R5W2I+rXN/pNaJqmnqafIdSxrSdmwQYjgk9uwTnW2ZYn40Sd7zRM2d6wUVomD5ujJwtHDzswkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=twALcp3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59E2C19423;
	Mon,  2 Mar 2026 22:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772490527;
	bh=Mzw9ZSYa0WyWWwpW0clcX9lo+Bk7602YPpbpkRLXTAA=;
	h=Date:To:From:Subject:From;
	b=twALcp3NMBrn5nNGlbZpgWpROkSIJLfT8OzqjtIhGjwUL3k2PwmPlukRJd/lwRUZY
	 mLoWwgiSQpblZ8C8i0lXADpWqM1Mge/RvrZ9RknCrtqEfY04bDGkD2tVIBMdgLwZP5
	 I/NU+OV6eBYFU85Ac3o1u74X34LlisPHTj/XDwJA=
Date: Mon, 02 Mar 2026 14:28:46 -0800
To: mm-commits@vger.kernel.org,willy@infradead.org,stable@vger.kernel.org,ryan.roberts@arm.com,npache@redhat.com,lorenzo.stoakes@oracle.com,liam.howlett@oracle.com,lance.yang@linux.dev,hughd@google.com,dev.jain@arm.com,david@kernel.org,bas@dfinity.org,baolin.wang@linux.alibaba.com,baohua@kernel.org,ziy@nvidia.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-huge_memory-fix-a-folio_split-race-condition-with-folio_try_get.patch added to mm-hotfixes-unstable branch
Message-Id: <20260302222846.D59E2C19423@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 4F25A1E6597
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222740-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


The patch titled
     Subject: mm/huge_memory: fix a folio_split() race condition with folio_try_get()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-huge_memory-fix-a-folio_split-race-condition-with-folio_try_get.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-huge_memory-fix-a-folio_split-race-condition-with-folio_try_get.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: Zi Yan <ziy@nvidia.com>
Subject: mm/huge_memory: fix a folio_split() race condition with folio_try_get()
Date: Mon, 2 Mar 2026 15:31:59 -0500

During a pagecache folio split, the values in the related xarray should
not be changed from the original folio at xarray split time until all
after-split folios are well formed and stored in the xarray.  Current use
of xas_try_split() in __split_unmapped_folio() lets some after-split
folios show up at wrong indices in the xarray.  When these misplaced
after-split folios are unfrozen, before correct folios are stored via
__xa_store(), and grabbed by folio_try_get(), they are returned to
userspace at wrong file indices, causing data corruption.  More detailed
explanation is at the bottom.

The reproducer is at: https://github.com/dfinity/thp-madv-remove-test
It
1. creates a memfd,
2. forks,
3. in the child process, maps the file with large folios (via shmem code
   path) and reads the mapped file continuously with 16 threads,
4. in the parent process, uses madvise(MADV_REMOVE) to punch poles in the
   large folio.

Data corruption can be observed without the fix.  Basically, data from a
wrong page->index is returned.

Fix it by using the original folio in xas_try_split() calls, so that
folio_try_get() can get the right after-split folios after the original
folio is unfrozen.

Uniform split, split_huge_page*(), is not affected, since it uses
xas_split_alloc() and xas_split() only once and stores the original folio
in the xarray.  Change xas_split() used in uniform split branch to use the
original folio to avoid confusion.

Fixes below points to the commit introduces the code, but folio_split() is
used in a later commit 7460b470a131f ("mm/truncate: use folio_split() in
truncate operation").

More details:

For example, a folio f is split non-uniformly into f, f2, f3, f4 like
below:
+----------------+---------+----+----+
|       f        |    f2   | f3 | f4 |
+----------------+---------+----+----+
but the xarray would look like below after __split_unmapped_folio() is
done:
+----------------+---------+----+----+
|       f        |    f2   | f3 | f3 |
+----------------+---------+----+----+

After __split_unmapped_folio(), the code changes the xarray and unfreezes
after-split folios:

1. unfreezes f2, __xa_store(f2)
2. unfreezes f3, __xa_store(f3)
3. unfreezes f4, __xa_store(f4), which overwrites the second f3 to f4.
4. unfreezes f.

Meanwhile, a parallel filemap_get_entry() can read the second f3 from the
xarray and use folio_try_get() on it at step 2 when f3 is unfrozen. Then,
f3 is wrongly returned to user.

After the fix, the xarray looks like below after __split_unmapped_folio():
+----------------+---------+----+----+
|       f        |    f    | f  | f  |
+----------------+---------+----+----+
so that the race window no longer exists.

Link: https://lkml.kernel.org/r/20260302203159.3208341-1-ziy@nvidia.com
Fixes: 00527733d0dc8 ("mm/huge_memory: add two new (not yet used) functions for folio_split()")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reported-by: Bas van Dijk <bas@dfinity.org>
Closes: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/
Tested-by: Lance Yang <lance.yang@linux.dev>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/huge_memory.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/mm/huge_memory.c~mm-huge_memory-fix-a-folio_split-race-condition-with-folio_try_get
+++ a/mm/huge_memory.c
@@ -3635,6 +3635,7 @@ static int __split_unmapped_folio(struct
 	const bool is_anon = folio_test_anon(folio);
 	int old_order = folio_order(folio);
 	int start_order = split_type == SPLIT_TYPE_UNIFORM ? new_order : old_order - 1;
+	struct folio *old_folio = folio;
 	int split_order;
 
 	/*
@@ -3656,11 +3657,17 @@ static int __split_unmapped_folio(struct
 			 * irq is disabled to allocate enough memory, whereas
 			 * non-uniform split can handle ENOMEM.
 			 */
-			if (split_type == SPLIT_TYPE_UNIFORM)
-				xas_split(xas, folio, old_order);
-			else {
+			if (split_type == SPLIT_TYPE_UNIFORM) {
+				xas_split(xas, old_folio, old_order);
+			} else {
 				xas_set_order(xas, folio->index, split_order);
-				xas_try_split(xas, folio, old_order);
+				/*
+				 * use the to-be-split folio, so that a parallel
+				 * folio_try_get() waits on it until xarray is
+				 * updated with after-split folios and
+				 * the original one is unfrozen.
+				 */
+				xas_try_split(xas, old_folio, old_order);
 				if (xas_error(xas))
 					return xas_error(xas);
 			}
_

Patches currently in -mm which might be from ziy@nvidia.com are

mm-cma-move-put_page_testzero-out-of-vm_warn_on-in-cma_release.patch
mm-huge_memory-fix-a-folio_split-race-condition-with-folio_try_get.patch


