Return-Path: <stable+bounces-229998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AApRDmOYwWlNUAQAu9opvQ
	(envelope-from <stable+bounces-229998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:45:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4762FC8CA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B6E130A166E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED4C33859A;
	Mon, 23 Mar 2026 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NgDdAxg6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F25327C09;
	Mon, 23 Mar 2026 19:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293201; cv=none; b=XjB/1Co1J3cu9jQbXthXLwNbyhFTnUWowyDxHXdmUiDp85SXUEwfGk4Qa16y+NNMCKzqXP1O7UoQTs1WhjvsJnuF9+DLzB1/8NdSBpSzoXqcFLn+KZvT89eK5ELzTl+7tCun8DhpxSWaapaQnORPubV9NXQIPvSY/f999IZPK/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293201; c=relaxed/simple;
	bh=F48kMF2IkiJijqlgL/VGOlGk1zpqxg2N5smXrL1ImlA=;
	h=Date:To:From:Subject:Message-Id; b=jIfFqO7bq+ShZ+irCEXw/jaBmiZLL3lrvL9UD4B6mp4/xm3lW4pB5pgpxdX1OkJ8ByclII6zmqCGnNO0hWn0QUjWd22mNK80dJFlLnS9Iby1V9elS8EY7PcwmQ4mGColDnLPQW/lgRSwTemWGFoLahYYMJdhA6U6bntsq9gMmPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NgDdAxg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17585C4CEF7;
	Mon, 23 Mar 2026 19:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774293201;
	bh=F48kMF2IkiJijqlgL/VGOlGk1zpqxg2N5smXrL1ImlA=;
	h=Date:To:From:Subject:From;
	b=NgDdAxg6U1QtKPMKYprbTFwKX7oyfSWnbVg9cVBvJSDJe6sWFLNhQEO7hxsusuJOs
	 SPPpmJITEMSp9xbfsSvzPXCv5gXQ7EzEOp02AFuHCaJugan92BStlGJyvFFRP0reiP
	 Lda3DfVNDY/jm7yJagqgbA9n3huD9aCN2B9I7NkM=
Date: Mon, 23 Mar 2026 12:13:20 -0700
To: mm-commits@vger.kernel.org,yuehaibing@huawei.com,stable@vger.kernel.org,osalvador@suse.de,muchun.song@linux.dev,david@kernel.org,almasrymina@google.com,devnexen@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-hugetlb-restore-reservation-on-error-in-hugetlb_mfill_atomic_pte-resubmission-path.patch added to mm-hotfixes-unstable branch
Message-Id: <20260323191321.17585C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229998-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,huawei.com,suse.de,linux.dev,kernel.org,google.com,gmail.com,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:dkim,linux-foundation.org:email,smtp.kernel.org:mid,huawei.com:email,linux.dev:email]
X-Rspamd-Queue-Id: 8D4762FC8CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch titled
     Subject: mm/hugetlb: restore reservation on error in hugetlb_mfill_atomic_pte() resubmission path
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-hugetlb-restore-reservation-on-error-in-hugetlb_mfill_atomic_pte-resubmission-path.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-hugetlb-restore-reservation-on-error-in-hugetlb_mfill_atomic_pte-resubmission-path.patch

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
From: David Carlier <devnexen@gmail.com>
Subject: mm/hugetlb: restore reservation on error in hugetlb_mfill_atomic_pte() resubmission path
Date: Sun, 22 Mar 2026 05:21:20 +0000

When the resubmission path in hugetlb_mfill_atomic_pte() allocates a new
hugetlb folio via alloc_hugetlb_folio(), a VMA reservation is consumed. 
If copy_user_large_folio() subsequently fails, folio_put() restores the
global hugetlb pool count through free_huge_folio(), but the per-VMA
reservation map entry is left in an inconsistent state.

Add the missing restore_reserve_on_error() call before folio_put(),
matching the first-attempt error path which already handles this
correctly.

Link: https://lkml.kernel.org/r/20260322052120.14021-1-devnexen@gmail.com
Fixes: 8cc5fcbb5be8 ("mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY")
Signed-off-by: David Carlier <devnexen@gmail.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: yuehaibing <yuehaibing@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/hugetlb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/hugetlb.c~mm-hugetlb-restore-reservation-on-error-in-hugetlb_mfill_atomic_pte-resubmission-path
+++ a/mm/hugetlb.c
@@ -6306,6 +6306,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_
 		folio_put(*foliop);
 		*foliop = NULL;
 		if (ret) {
+			restore_reserve_on_error(h, dst_vma, dst_addr, folio);
 			folio_put(folio);
 			goto out;
 		}
_

Patches currently in -mm which might be from devnexen@gmail.com are

mm-hugetlb-restore-reservation-on-error-in-hugetlb_mfill_atomic_pte-resubmission-path.patch
mm-memcontrol-convert-objcg-to-be-per-memcg-per-node-type-fix-fix-fix-2.patch


