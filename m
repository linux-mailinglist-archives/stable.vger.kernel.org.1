Return-Path: <stable+bounces-225849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGDUH8E9uWkowQEAu9opvQ
	(envelope-from <stable+bounces-225849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:40:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F2D2A913D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0555E30DCFD3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9605F36EAA9;
	Tue, 17 Mar 2026 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qTcABcbG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599AF145355
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747466; cv=none; b=NGpDNRmTeptx7oh2ZNxXuAAAYIoUl3pPj9gtqJ0K8fvH789chAtx8MUskLYDWKLo1kcG7K2eOGUNSB/70PXeGc2jgvhgCvmOrQQoMRHIFYJi3jGOGHARzLL9kqgBzUVrt/Gn0gIfwQTnDFlZYc4POcthuWjGSnDvn8pevQJDY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747466; c=relaxed/simple;
	bh=xNDwjE+miTpCE8GE0YBv1bbtBuGLHJ2yivy+qGlC++E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uezqP/+qHxUJZ15Y8XSvScmyR61chm12nAFhOt1eFia45NMcVBfXCvnf31X0ZHli1ddfdeE6FV0rx92UGQUPMKL1tMvuen0QcI11WagaDbO30DAYubesjDqe/JZd1qQKEYDVBV8PkFTULqEjIMqnJLNLlPCoYqd3PeALPR4QZ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qTcABcbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417FDC19425;
	Tue, 17 Mar 2026 11:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773747466;
	bh=xNDwjE+miTpCE8GE0YBv1bbtBuGLHJ2yivy+qGlC++E=;
	h=Subject:To:Cc:From:Date:From;
	b=qTcABcbGH2MdamvKJrMFMiWUl7D8K9A/JqTJGJoFFXgoZ1/gegUc+PvWqtikDhuZ1
	 QYCQpF9gn01nizUqQf5nWsTdnpVjh4oFlfDjqCjiLUIazz66t8rjyDKzfwvzdz5vVT
	 BS6dLr7omXVcDDPAEHIoXb0f3KoGP6mRYse1NIZI=
Subject: FAILED: patch "[PATCH] mm/huge_memory: fix a folio_split() race condition with" failed to apply to 6.18-stable tree
To: ziy@nvidia.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,bas@dfinity.org,david@kernel.org,dev.jain@arm.com,hughd@google.com,lance.yang@linux.dev,liam.howlett@oracle.com,lorenzo.stoakes@oracle.com,npache@redhat.com,richard.weiyang@gmail.com,ryan.roberts@arm.com,stable@vger.kernel.org,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 12:37:41 +0100
Message-ID: <2026031741-handmade-lilly-566b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225849-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,linux-foundation.org,kernel.org,linux.alibaba.com,dfinity.org,arm.com,google.com,linux.dev,oracle.com,redhat.com,gmail.com,vger.kernel.org,infradead.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7F2D2A913D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 577a1f495fd78d8fb61b67ac3d3b595b01f6fcb0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031741-handmade-lilly-566b@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 577a1f495fd78d8fb61b67ac3d3b595b01f6fcb0 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 2 Mar 2026 15:31:59 -0500
Subject: [PATCH] mm/huge_memory: fix a folio_split() race condition with
 folio_try_get()

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

[ziy@nvidia.com: move comment, per David]
  Link: https://lkml.kernel.org/r/5C9FA053-A4C6-4615-BE05-74E47A6462B3@nvidia.com
Link: https://lkml.kernel.org/r/20260302203159.3208341-1-ziy@nvidia.com
Fixes: 00527733d0dc ("mm/huge_memory: add two new (not yet used) functions for folio_split()")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reported-by: Bas van Dijk <bas@dfinity.org>
Closes: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/
Tested-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8e2746ea74ad..912c248a3f7e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3631,6 +3631,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	const bool is_anon = folio_test_anon(folio);
 	int old_order = folio_order(folio);
 	int start_order = split_type == SPLIT_TYPE_UNIFORM ? new_order : old_order - 1;
+	struct folio *old_folio = folio;
 	int split_order;
 
 	/*
@@ -3651,12 +3652,16 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 			 * uniform split has xas_split_alloc() called before
 			 * irq is disabled to allocate enough memory, whereas
 			 * non-uniform split can handle ENOMEM.
+			 * Use the to-be-split folio, so that a parallel
+			 * folio_try_get() waits on it until xarray is updated
+			 * with after-split folios and the original one is
+			 * unfrozen.
 			 */
-			if (split_type == SPLIT_TYPE_UNIFORM)
-				xas_split(xas, folio, old_order);
-			else {
+			if (split_type == SPLIT_TYPE_UNIFORM) {
+				xas_split(xas, old_folio, old_order);
+			} else {
 				xas_set_order(xas, folio->index, split_order);
-				xas_try_split(xas, folio, old_order);
+				xas_try_split(xas, old_folio, old_order);
 				if (xas_error(xas))
 					return xas_error(xas);
 			}


