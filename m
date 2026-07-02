Return-Path: <stable+bounces-271569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YWPLB+nZRmppegsAu9opvQ
	(envelope-from <stable+bounces-271569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 23:36:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 883546FCFE5
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 23:36:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=G9oH5muX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271569-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271569-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18D983062D4A
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 21:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC23739AD49;
	Thu,  2 Jul 2026 21:35:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E02338C2AA;
	Thu,  2 Jul 2026 21:35:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028109; cv=none; b=HlY/ns5Eo3+YoC0Xb7IOjdJlp50sL2GaB72LzquzYF0dW0BLkUXtnByHy0md4v48s9ykLRS0qrgAWWqwZrRxiTBA72xhDVn2ZHP5qS9+c8p8pZ+IRE0lMK3Bi+M/uEn7MlyTtG3/RB5OrVOD3mK/t217iHEXv8FOw/kQtR0b8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028109; c=relaxed/simple;
	bh=2o2fSWTp6QggWWcN8QbJNZ46sp7VyRbOEnXTSNsP+WQ=;
	h=Date:To:From:Subject:Message-Id; b=It72YfPAXTzffL0q/QGiwaY6WM71fegyw5PS+DGjQcWW2w5nen7Nqaig1RVEhtlUvhrkP1upnaW3ePsvRPP15HVajaF5P2d74bv9pY7ej4LhynyYtgGiJ+5nwbGqC4yw3/VSuTzOcIIk80N73jtgIrCGUmUFTleaQmAJIDsFQ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G9oH5muX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25431F000E9;
	Thu,  2 Jul 2026 21:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783028108;
	bh=z90TcoArdTBKg21IvkGFt5bsPGuBfxV6VaICZYRPQXM=;
	h=Date:To:From:Subject;
	b=G9oH5muXdnyDLAzAfb2fJNgMf6ys6pFcQ2Kn7BBJI2grKcjtYGJy/1GNwlVClrmHL
	 wLm8t7l2WVu9qRkcQRenJSzDvYBpZb8KvOvFk6xbsaKvxU4zRFMWvOOveS3oWM0mY0
	 jkksBK1TdIdwCcHHMcWfWToDqJV8G0rLpzjCXqxM=
Date: Thu, 02 Jul 2026 14:35:07 -0700
To: mm-commits@vger.kernel.org,ziy@nvidia.com,ying.huang@linux.alibaba.com,willy@infradead.org,stable@vger.kernel.org,rakie.kim@sk.com,osalvador@suse.de,matthew.brost@intel.com,ljs@kernel.org,joshua.hahnjy@gmail.com,gourry@gourry.net,david@kernel.org,byungchul@sk.com,baohua@kernel.org,apopple@nvidia.com,npache@redhat.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-migrate-exclude-hugetlb-folios-from-mthp_stat_nr_anon-accounting.patch added to mm-hotfixes-unstable branch
Message-Id: <20260702213507.F25431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271569-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,nvidia.com,linux.alibaba.com,infradead.org,sk.com,suse.de,intel.com,kernel.org,gmail.com,gourry.net,redhat.com,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:ziy@nvidia.com,m:ying.huang@linux.alibaba.com,m:willy@infradead.org,m:stable@vger.kernel.org,m:rakie.kim@sk.com,m:osalvador@suse.de,m:matthew.brost@intel.com,m:ljs@kernel.org,m:joshua.hahnjy@gmail.com,m:gourry@gourry.net,m:david@kernel.org,m:byungchul@sk.com,m:baohua@kernel.org,m:apopple@nvidia.com,m:npache@redhat.com,m:akpm@linux-foundation.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 883546FCFE5


The patch titled
     Subject: mm/migrate: exclude hugetlb folios from MTHP_STAT_NR_ANON accounting
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-migrate-exclude-hugetlb-folios-from-mthp_stat_nr_anon-accounting.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-migrate-exclude-hugetlb-folios-from-mthp_stat_nr_anon-accounting.patch

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
From: Nico Pache <npache@redhat.com>
Subject: mm/migrate: exclude hugetlb folios from MTHP_STAT_NR_ANON accounting
Date: Thu, 2 Jul 2026 11:25:47 -0600

__folio_migrate_mapping() increments MTHP_STAT_NR_ANON for the destination
folio when `folio_test_anon(folio) && folio_test_large(folio)` is true. 
However, hugetlb folios satisfy both conditions despite having a
completely separate accounting system; they use hugetlb_add_anon_rmap()
which does not touch mTHP stats, and their free path also bypasses the
mTHP decrement in __free_pages_prepare().

This causes MTHP_STAT_NR_ANON to be incremented on each hugetlb migration
without a corresponding decrement, permanently inflating the nr_anon
counter.

Add a !folio_test_hugetlb() check to both places in
__folio_migrate_mapping() so that only actual mTHP folios are counted.

Link: https://lore.kernel.org/20260702172548.37075-3-npache@redhat.com
Fixes: 5d65c8d758f2 ("mm: count the number of anonymous THPs per size")
Co-developed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Nico Pache <npache@redhat.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/migrate.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/mm/migrate.c~mm-migrate-exclude-hugetlb-folios-from-mthp_stat_nr_anon-accounting
+++ a/mm/migrate.c
@@ -590,7 +590,8 @@ static int __folio_migrate_mapping(struc
 		/* No turning back from here */
 		newfolio->index = folio->index;
 		newfolio->mapping = folio->mapping;
-		if (folio_test_anon(folio) && folio_test_large(folio))
+		if (folio_test_anon(folio) && folio_test_large(folio) &&
+		    !folio_test_hugetlb(folio))
 			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 		if (folio_test_swapbacked(folio))
 			__folio_set_swapbacked(newfolio);
@@ -623,7 +624,8 @@ static int __folio_migrate_mapping(struc
 	 */
 	newfolio->index = folio->index;
 	newfolio->mapping = folio->mapping;
-	if (folio_test_anon(folio) && folio_test_large(folio))
+	if (folio_test_anon(folio) && folio_test_large(folio) &&
+	    !folio_test_hugetlb(folio))
 		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 	folio_ref_add(newfolio, nr); /* add cache reference */
 	if (folio_test_swapbacked(folio))
_

Patches currently in -mm which might be from npache@redhat.com are

mm-decrement-mthp_stat_nr_anon-in-free_zone_device_folio.patch
mm-migrate-exclude-hugetlb-folios-from-mthp_stat_nr_anon-accounting.patch


