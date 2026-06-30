Return-Path: <stable+bounces-269860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hPh8ORgpQ2pRSwoAu9opvQ
	(envelope-from <stable+bounces-269860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 04:25:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD086DFC5B
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 04:25:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b="sTi8Q08/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269860-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269860-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DE603036CEB
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 02:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE91A33F58C;
	Tue, 30 Jun 2026 02:25:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D933065C;
	Tue, 30 Jun 2026 02:25:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786307; cv=none; b=d2i2fmY8as/KZEE/dpjB0sEt2PvlXyclxKs+AOVZv0ExOH1uUeeE80Y3Jf50O/NZ3j4hkpqX9RHj4NHAvq0O3zEGJKf9O3lzGTvD4g8W363lKHbeVeKS/9N6ZUNNtC3LNOVgkW60ZfZ5YRzhShtkUcxuv7L9GTIDeFvherpL3Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786307; c=relaxed/simple;
	bh=HmyaUhETQ3psk/gjNIk85I2wmYyzTFspPzmzcV8EQR0=;
	h=Date:To:From:Subject:Message-Id; b=e+N6KvxNumNkw9QgbkmBgHBc3Qt0Ls8g40KMisA8vSsWKeBvSkhluRkcftQlPe7yyzsmhtUT2sVKVn3ihhSgQnoTlqCFbnwuuDoy0VX+DpUwgNBkz76WEWcW8t/iNPlcKF6cug7xRHcXvrfqMBEty2pQhDetQRAsVJqVLmsrLJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sTi8Q08/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2112B1F000E9;
	Tue, 30 Jun 2026 02:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782786306;
	bh=ftGC2LjujBssyZngqrXsX05yVdKVKQ0aNOoEdG1l3cY=;
	h=Date:To:From:Subject;
	b=sTi8Q08/JBA1K2oehR0UJVTJ3Y7yhYrMLrL/YPFW/hoxkGtU6rIaDq/Un7zpd+sAt
	 csp33pFS9G45Fx/lMgViWVvDuKuNl3u8QcbxrLzKFTb8rv+Upeu83YqzS6NAJH0VRz
	 yoLlnG3cl6yNrDfvhuxhi9Ki40tNjs73tWeKPsHQ=
Date: Mon, 29 Jun 2026 19:25:05 -0700
To: mm-commits@vger.kernel.org,ziy@nvidia.com,stable@vger.kernel.org,sj@kernel.org,ljs@kernel.org,lance.yang@linux.dev,david@kernel.org,balbirs@nvidia.com,richard.weiyang@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-page_vma_mapped-fix-device-private-pmd-handling.patch added to mm-hotfixes-unstable branch
Message-Id: <20260630022506.2112B1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269860-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,nvidia.com,kernel.org,linux.dev,gmail.com,linux-foundation.org];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:ziy@nvidia.com,m:stable@vger.kernel.org,m:sj@kernel.org,m:ljs@kernel.org,m:lance.yang@linux.dev,m:david@kernel.org,m:balbirs@nvidia.com,m:richard.weiyang@gmail.com,m:akpm@linux-foundation.org,m:richardweiyang@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime,linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CD086DFC5B


The patch titled
     Subject: mm/page_vma_mapped: fix device-private PMD handling
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-page_vma_mapped-fix-device-private-pmd-handling.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-page_vma_mapped-fix-device-private-pmd-handling.patch

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
From: Wei Yang <richard.weiyang@gmail.com>
Subject: mm/page_vma_mapped: fix device-private PMD handling
Date: Tue, 30 Jun 2026 02:15:40 +0000

Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
device-private entries") introduced the concept of device-private PMD
entries, but did not correctly update the rmap walk code to account for
them.

As a result, when page_vma_mapped_walk() encounters device-private PMD
entries, it takes no action other than to acquire the PMD lock and exit.

However this is highly problematic for two reasons - firstly, device
private entries possess a PFN so check_pmd() needs to be called to ensure
an overlapping PFN range.

Secondly, and more importantly, if PVMW_MIGRATION is set the caller
assumes the returned entry is a migration entry, resulting in memory
corruption when the caller tries to interpret the device private entry as
such.

In addition, commit 146287290023 ("mm/huge_memory: implement
device-private THP splitting") allowed device private PMDs to be split
like THP mappings, but again did not update this code path.

As a result, we might race a PMD split prior to acquiring the PMD lock.

This patch addresses all of these issues by invoking check_pmd(), ensuring
PMVW_MIGRATION is not set and checks whether a split raced us we do for
PMD THP and migration entries.

Instead of checking for a subset of the cases after taking the pmd_lock(),
put device-private along with pmd_trans_huge() and
pmd_is_migration_entry().  Also remove thp_migration_supported() as it is
already guarded by pmd_is_migration_entry().

Link: https://lore.kernel.org/20260630021540.17297-1-richard.weiyang@gmail.com
Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Suggested-by: David Hildenbrand <david@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/page_vma_mapped.c |   30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

--- a/mm/page_vma_mapped.c~mm-page_vma_mapped-fix-device-private-pmd-handling
+++ a/mm/page_vma_mapped.c
@@ -243,21 +243,30 @@ restart:
 		 */
 		pmde = pmdp_get_lockless(pvmw->pmd);
 
-		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
+		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde) ||
+		    pmd_is_device_private_entry(pmde)) {
 			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
 			pmde = *pvmw->pmd;
-			if (!pmd_present(pmde)) {
+			if (pmd_is_migration_entry(pmde)) {
 				softleaf_t entry;
 
-				if (!thp_migration_supported() ||
-				    !(pvmw->flags & PVMW_MIGRATION))
+				if (!(pvmw->flags & PVMW_MIGRATION))
 					return not_found(pvmw);
 				entry = softleaf_from_pmd(pmde);
+				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
+					return not_found(pvmw);
+				return true;
+			} else if (pmd_is_device_private_entry(pmde)) {
+				softleaf_t entry;
 
-				if (!softleaf_is_migration(entry) ||
-				    !check_pmd(softleaf_to_pfn(entry), pvmw))
+				if (pvmw->flags & PVMW_MIGRATION)
+					return not_found(pvmw);
+				entry = softleaf_from_pmd(pmde);
+				if (!check_pmd(softleaf_to_pfn(entry), pvmw))
 					return not_found(pvmw);
 				return true;
+			} else if (!pmd_present(pmde)) {
+				return not_found(pvmw);
 			}
 			if (likely(pmd_trans_huge(pmde))) {
 				if (pvmw->flags & PVMW_MIGRATION)
@@ -266,17 +275,10 @@ restart:
 					return not_found(pvmw);
 				return true;
 			}
-			/* THP pmd was split under us: handle on pte level */
+			/* THP/device-private pmd was split under us: handle on pte level */
 			spin_unlock(pvmw->ptl);
 			pvmw->ptl = NULL;
 		} else if (!pmd_present(pmde)) {
-			const softleaf_t entry = softleaf_from_pmd(pmde);
-
-			if (softleaf_is_device_private(entry)) {
-				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
-				return true;
-			}
-
 			if ((pvmw->flags & PVMW_SYNC) &&
 			    thp_vma_suitable_order(vma, pvmw->address,
 						   PMD_ORDER) &&
_

Patches currently in -mm which might be from richard.weiyang@gmail.com are

mm-page_vma_mapped-fix-device-private-pmd-handling.patch


