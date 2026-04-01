Return-Path: <stable+bounces-232873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UImXIPSizWl9fgYAu9opvQ
	(envelope-from <stable+bounces-232873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 00:57:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B17381267
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 00:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB6DB30293DD
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 22:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEE23E8C42;
	Wed,  1 Apr 2026 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sn3HU47x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF96233CE88;
	Wed,  1 Apr 2026 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775084271; cv=none; b=SOvVyR/SPcrpEaLoGa+xMPVaRNWZhJkZ9ENz83sAkDIc6m0+jP9Gz60bDC80HEwD6zMuSTbejQ7VIeftvWZgurIPohDuuOoebEaF74w1RwHzw3McVihX6JrFM26QuMYKOer4A6oA8B+Fx68Lgl2NVbKYBrAAblEd3CISZEnZSpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775084271; c=relaxed/simple;
	bh=2c0avaSSCydsBRPbzT4smQQFFCfBOyDjF+K3e1zO+Ek=;
	h=Date:To:From:Subject:Message-Id; b=i3I3EaZjvOZU+f8xH0npxEl0hTLEarfokFDht8HUQybm+r2wW0jG+up/+w/kpVHrIE6B3ecO+sjQ/sSBk4BEc+qIWl6NgmSsx8ieMQ71gSx1Ne/orpEiLCKW/6Iw+pW3QZcnA1oQ1bldIyeAvGD6tkqbOnQhLtGRkQ7J9JX18TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sn3HU47x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2C6C4CEF7;
	Wed,  1 Apr 2026 22:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775084271;
	bh=2c0avaSSCydsBRPbzT4smQQFFCfBOyDjF+K3e1zO+Ek=;
	h=Date:To:From:Subject:From;
	b=sn3HU47x5nWKNPwtEUXxmWxqffoqi77Kdoobe4sMZvSANq2Cqa+1v5IQFQ0p2bbBc
	 vuDPPG3N2Z9o3TBioiqZGqEm03oTMsgLKURw/YufdudnB4jOPJswBgza1uoAXrmehr
	 GhLHkjrvKdB4DrkPqLUZiK1UdyfL685AMjnEEREA=
Date: Wed, 01 Apr 2026 15:57:50 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,shikemeng@huaweicloud.com,nphamcs@gmail.com,kasong@tencent.com,david@kernel.org,chrisl@kernel.org,bhe@redhat.com,baohua@kernel.org,devnexen@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [to-be-updated] mm-page_io-fix-pswpin-undercount-for-large-folios-in-sio_read_complete.patch removed from -mm tree
Message-Id: <20260401225751.3B2C6C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TAGGED_FROM(0.00)[bounces-232873-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[linux-foundation.org:s=korg];
	NEURAL_SPAM(0.00)[0.983];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,huaweicloud.com,gmail.com,tencent.com,kernel.org,redhat.com,linux-foundation.org];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4B17381267
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: mm/page_io: fix PSWPIN undercount for large folios in sio_read_complete()
has been removed from the -mm tree.  Its filename was
     mm-page_io-fix-pswpin-undercount-for-large-folios-in-sio_read_complete.patch

This patch was dropped because an updated version will be issued

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


