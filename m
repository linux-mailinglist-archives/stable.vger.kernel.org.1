Return-Path: <stable+bounces-231290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CInEBFT5ymmlBwYAu9opvQ
	(envelope-from <stable+bounces-231290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 00:29:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 721E7361F13
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 00:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26B5F30980BC
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 22:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CE83E1D1B;
	Mon, 30 Mar 2026 22:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gBUQOcAd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCA52ECD1D;
	Mon, 30 Mar 2026 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909234; cv=none; b=AGZjZwv50SS8JTZ7S+J/M0RcMwivrT2QVV3a594pZDrpklmvHv5pGf/VfxlT20uu0OmW+WqwH8kXw5QL0/tvm3aEFSASrgq4oKOo4k1GjQfyqGIPrkHG8wsyQWLGgRxjYgVJRmNY67QoI7oSKQlbT/lX4TxINTeMD6ALvz0bh+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909234; c=relaxed/simple;
	bh=k+NdETrGiDBGa0a7NxxeZZXU28MZohtqDIOG7XgqfqM=;
	h=Date:To:From:Subject:Message-Id; b=Worg8+oPsUTC7r8JYiCmam+cDmryX/PtUoCnIx6qq7+Q49WlIBJFPOKKK33LiyhLeK4DGxRzrVYkZL/PIlFDLPjYPJZnwHnvNne7WY8huPJpcT4Mx3JBPhiSOtu0/cMjmJXJiCxSM+6YBj25dP+ytKxmGxpkKgNK1ZJcidmFdtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gBUQOcAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766DEC2BCB4;
	Mon, 30 Mar 2026 22:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774909233;
	bh=k+NdETrGiDBGa0a7NxxeZZXU28MZohtqDIOG7XgqfqM=;
	h=Date:To:From:Subject:From;
	b=gBUQOcAdjwGDRrwb0Thzyc5p7CUamxKJi1ViN8pH0N9Q6c4vYx0siWHRgbhBRlfiS
	 08ggu1aVdZ6tX6toMERyPKq+gNZcYqyYwpI+X0uCKZ5yTq/zs895BahYZTwaEdG6Ga
	 xbwI4K39U5XL1n6ba+VzTjKgkzQa0T+le0xqCcmU=
Date: Mon, 30 Mar 2026 15:20:32 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,shikemeng@huaweicloud.com,nphamcs@gmail.com,kasong@tencent.com,david@kernel.org,chrisl@kernel.org,bhe@redhat.com,baohua@kernel.org,devnexen@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-page_io-fix-pswpin-undercount-for-large-folios-in-sio_read_complete.patch added to mm-unstable branch
Message-Id: <20260330222033.766DEC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231290-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[linux-foundation.org:s=korg];
	FREEMAIL_TO(0.00)[vger.kernel.org,huaweicloud.com,gmail.com,tencent.com,kernel.org,redhat.com,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.962];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:email,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 721E7361F13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch titled
     Subject: mm/page_io: fix PSWPIN undercount for large folios in sio_read_complete()
has been added to the -mm mm-unstable branch.  Its filename is
     mm-page_io-fix-pswpin-undercount-for-large-folios-in-sio_read_complete.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-page_io-fix-pswpin-undercount-for-large-folios-in-sio_read_complete.patch

This patch will later appear in the mm-unstable branch at
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
Subject: mm/page_io: fix PSWPIN undercount for large folios in sio_read_complete()
Date: Mon, 23 Mar 2026 23:13:15 +0000

sio_read_complete() uses sio->pages to account global PSWPIN vm events,
but sio->pages tracks the number of bvec entries (folios), not base pages.
For large folios this undercounts compared to the per-memcg path which
correctly uses folio_nr_pages(), and compared to the bdev read paths which
also use folio_nr_pages().

Use sio->len >> PAGE_SHIFT instead, which gives the correct base page
count since sio->len is accumulated via folio_size(folio).

Link: https://lkml.kernel.org/r/20260323231315.240137-1-devnexen@gmail.com
Fixes: a1a0dfd56f97 ("mm: handle THP in swap_*page_fs()")
Signed-off-by: David Carlier <devnexen@gmail.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/page_io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/page_io.c~mm-page_io-fix-pswpin-undercount-for-large-folios-in-sio_read_complete
+++ a/mm/page_io.c
@@ -497,7 +497,7 @@ static void sio_read_complete(struct kio
 			folio_mark_uptodate(folio);
 			folio_unlock(folio);
 		}
-		count_vm_events(PSWPIN, sio->pages);
+		count_vm_events(PSWPIN, sio->len >> PAGE_SHIFT);
 	} else {
 		for (p = 0; p < sio->pages; p++) {
 			struct folio *folio = page_folio(sio->bvec[p].bv_page);
_

Patches currently in -mm which might be from devnexen@gmail.com are

mm-hugetlb-restore-reservation-on-error-in-hugetlb_mfill_atomic_pte-resubmission-path.patch
mm-page_io-fix-pswpin-undercount-for-large-folios-in-sio_read_complete.patch


