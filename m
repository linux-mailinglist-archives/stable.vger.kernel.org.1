Return-Path: <stable+bounces-233149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAdmApRhz2kVvwYAu9opvQ
	(envelope-from <stable+bounces-233149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 08:43:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B59139178F
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 08:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E51BB301B911
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 06:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4195534D91F;
	Fri,  3 Apr 2026 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R9+AlFrH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05012369208;
	Fri,  3 Apr 2026 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775198546; cv=none; b=M/xeg0JgB8IXqIJ5b1OXyoEbREfPJXxNkbm6Gi7/nUUhiR+iV3RK8zLRAnAPrlcbbkuT3h27a8J5ZaDF3g97cCECznMlwP4zgtm4C6nvujtlr7d2Jze3mUyzqd/KDtMDQ9rLVS+VZe/pzq5+EsFGNCJYhdkHsrCwSAo5LOWtBDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775198546; c=relaxed/simple;
	bh=3SunqnGFUePcUqHb6D2D5edAZV6gkC9ABeFFWho+slw=;
	h=Date:To:From:Subject:Message-Id; b=fRAXn0YGl9bOzWvd+8ywLisVGRbHFG+5WQA6Eimw8mflpB0bdZtDnMuHiL9+cORTB7+XbE2wHgzt+S7N3kQ6nAmdBYnd1CtbDJPj7OyfaC5E+iDSZHB8xDnPOK3sKGGXSkrUduWMEMoojsdZZ7CPvZYw6DH7RjMt7+ZxAVwuaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R9+AlFrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2903C4CEF7;
	Fri,  3 Apr 2026 06:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775198545;
	bh=3SunqnGFUePcUqHb6D2D5edAZV6gkC9ABeFFWho+slw=;
	h=Date:To:From:Subject:From;
	b=R9+AlFrH4K2u/FSq2gpb1mZ6hR0LjLxfFKR6iZjKKlbdxU7Sw0vk3bWl+Mc+r6MXG
	 wFaOGErEDB2oiO554a/gnsE7BWk23RrXXGc2cq4qQw/jYjfqC3AeSUb2qxi2QU2Y3b
	 GscgbsKRlZXZa3ha08XKrwvXi18blxus+4cvTbP4=
Date: Thu, 02 Apr 2026 23:42:25 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,pmladek@suse.com,kees@kernel.org,dhowells@redhat.com,davidgow@google.com,lk@c--e.de,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-nonmm-stable] lib-scatterlist-fix-length-calculations-in-extract_kvec_to_sg.patch removed from -mm tree
Message-Id: <20260403064225.D2903C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233149-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5B59139178F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: lib/scatterlist: fix length calculations in extract_kvec_to_sg
has been removed from the -mm tree.  Its filename was
     lib-scatterlist-fix-length-calculations-in-extract_kvec_to_sg.patch

This patch was dropped because it was merged into the mm-nonmm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: "Christian A. Ehrhardt" <lk@c--e.de>
Subject: lib/scatterlist: fix length calculations in extract_kvec_to_sg
Date: Thu, 26 Mar 2026 22:49:01 +0100

Patch series "Fix bugs in extract_iter_to_sg()", v3.

Fix bugs in the kvec and user variants of extract_iter_to_sg.  This series
is growing due to useful remarks made by sashiko.dev.

The main bugs are:
- The length for an sglist entry when extracting from
  a kvec can exceed the number of bytes in the page. This
  is obviously not intended.
- When extracting a user buffer the sglist is temporarily
  used as a scratch buffer for extracted page pointers.
  If the sglist already contains some elements this scratch
  buffer could overlap with existing entries in the sglist.

The series adds test cases to the kunit_iov_iter test that demonstrate all
of these bugs.  Additionally, there is a memory leak fix for the test
itself.

The bugs were orignally introduced into kernel v6.3 where the function
lived in fs/netfs/iterator.c.  It was later moved to lib/scatterlist.c in
v6.5.  Thus the actual fix is only marked for backports to v6.5+.


This patch (of 5):

When extracting from a kvec to a scatterlist, do not cross page
boundaries.  The required length was already calculated but not used as
intended.

Adjust the copied length if the loop runs out of sglist entries without
extracting everything.

While there, return immediately from extract_iter_to_sg if there are no
sglist entries at all.

A subsequent commit will add kunit test cases that demonstrate that the
patch is necessary.

Link: https://lkml.kernel.org/r/20260326214905.818170-1-lk@c--e.de
Link: https://lkml.kernel.org/r/20260326214905.818170-2-lk@c--e.de
Fixes: 018584697533 ("netfs: Add a function to extract an iterator into a scatterlist")
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
Cc: David Gow <davidgow@google.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: <stable@vger.kernel.org>	[v6.5+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/scatterlist.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/lib/scatterlist.c~lib-scatterlist-fix-length-calculations-in-extract_kvec_to_sg
+++ a/lib/scatterlist.c
@@ -1247,7 +1247,7 @@ static ssize_t extract_kvec_to_sg(struct
 			else
 				page = virt_to_page((void *)kaddr);
 
-			sg_set_page(sg, page, len, off);
+			sg_set_page(sg, page, seg, off);
 			sgtable->nents++;
 			sg++;
 			sg_max--;
@@ -1256,6 +1256,7 @@ static ssize_t extract_kvec_to_sg(struct
 			kaddr += PAGE_SIZE;
 			off = 0;
 		} while (len > 0 && sg_max > 0);
+		ret -= len;
 
 		if (maxsize <= 0 || sg_max == 0)
 			break;
@@ -1409,7 +1410,7 @@ ssize_t extract_iter_to_sg(struct iov_it
 			   struct sg_table *sgtable, unsigned int sg_max,
 			   iov_iter_extraction_t extraction_flags)
 {
-	if (maxsize == 0)
+	if (maxsize == 0 || sg_max == 0)
 		return 0;
 
 	switch (iov_iter_type(iter)) {
_

Patches currently in -mm which might be from lk@c--e.de are



