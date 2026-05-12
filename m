Return-Path: <stable+bounces-246684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHcdBEagA2pL8QEAu9opvQ
	(envelope-from <stable+bounces-246684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:48:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A4C52A993
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E1573035954
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 21:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E585392C47;
	Tue, 12 May 2026 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="duksbW89"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363C386C28;
	Tue, 12 May 2026 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622530; cv=none; b=RqWYPyE+IQFTdIES/WsKMKvpkRXySuRUtdUol8e1lbcvtzcjHda2dq52Ik7Op9Oso49xOplBTiosu8Q43UJ4dVquz2Avx2YE8J4/HeNWbHtVFJVWVCrQc/CTxzrS7CIFABvZPHphhqBGBp7iZvSlXrnYyN3CqxFSNrgXaRAleEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622530; c=relaxed/simple;
	bh=QyxVqxguFhbFcM8GTf2Un1e3RN/fK15mcPt8MXWN1DM=;
	h=Date:To:From:Subject:Message-Id; b=IMgKirpvD/GGJCNn53omiN1uAYbwniUrsY+BdKiUv/OpHN7FyW9IWCrcfLCDFF0824WIi2U70VWb/TObbX8jkjH+MBlUlYzgs1gyQsrB+8e7HQbYcFmbx5vSqdQii5uhjd/Phmz/Da4r8EPekZ94rlvFea3U8S342eTHx6I2MYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=duksbW89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE80C2BCB0;
	Tue, 12 May 2026 21:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778622530;
	bh=QyxVqxguFhbFcM8GTf2Un1e3RN/fK15mcPt8MXWN1DM=;
	h=Date:To:From:Subject:From;
	b=duksbW893MuuL/pIi9RPfLe/Yzag0vI5fKBODQmS0MvQqIEi0dD/bODVzWaxIK3yJ
	 6cfd4eTpXyuQ3clTsZnT1w510deNJrYBEEvzwRM4U8F4fe23OFXJnPQw/DkMPSyNX6
	 UR9hIgM6fXyPa1rgg4xIfzNFCgUKFpq1ZhFO88E4=
Date: Tue, 12 May 2026 14:48:49 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,senozhatsky@chromium.org,minchan@kernel.org,hannes@cmpxchg.org,gourry@gourry.net,dan.j.williams@intel.com,chengming.zhou@linux.dev,contact.kartikn@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + zsmalloc-zero-initialize-zspage-memory-to-prevent-kmsan-uninit-reads.patch added to mm-hotfixes-unstable branch
Message-Id: <20260512214850.3AE80C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: A4A4C52A993
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246684-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,chromium.org,kernel.org,cmpxchg.org,gourry.net,intel.com,linux.dev,gmail.com,linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,linux-foundation.org:dkim,intel.com:email,linux.dev:email,smtp.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email,chromium.org:email]
X-Rspamd-Action: no action


The patch titled
     Subject: zsmalloc: zero-initialize zspage memory to prevent KMSAN uninit reads
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     zsmalloc-zero-initialize-zspage-memory-to-prevent-kmsan-uninit-reads.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/zsmalloc-zero-initialize-zspage-memory-to-prevent-kmsan-uninit-reads.patch

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
From: Kartik Nair <contact.kartikn@gmail.com>
Subject: zsmalloc: zero-initialize zspage memory to prevent KMSAN uninit reads
Date: Tue, 12 May 2026 03:06:58 +0530

Pages allocated via alloc_zpdesc() use alloc_pages_node() without
__GFP_ZERO, leaving physical memory uninitialized.  When a compressed
object spans two physical pages in a zspage, zs_obj_read_sg_begin() sets
up a scatterlist pointing directly at the raw second page.  If the second
page was freshly allocated and never written beyond the object boundary,
KMSAN detects reads of uninitialized memory downstream in the decompressor
(e.g.  sw842_decompress reading the CRC trailer).

Fix this by passing __GFP_ZERO to alloc_zpdesc() in alloc_zspage() so
all pages backing a zspage are zero-initialized at allocation time.

Link: https://lore.kernel.org/20260511213658.25273-1-contact.kartikn@gmail.com
Fixes: 56e5a103a721 ("zsmalloc: prefer the the original page's node for compressed data")
Reported-by: syzbot+8f77ff6144a73f0cf71b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8f77ff6144a73f0cf71b
Signed-off-by: Kartik Nair <contact.kartikn@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/zsmalloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/zsmalloc.c~zsmalloc-zero-initialize-zspage-memory-to-prevent-kmsan-uninit-reads
+++ a/mm/zsmalloc.c
@@ -951,7 +951,7 @@ static struct zspage *alloc_zspage(struc
 	for (i = 0; i < class->pages_per_zspage; i++) {
 		struct zpdesc *zpdesc;
 
-		zpdesc = alloc_zpdesc(gfp, nid);
+		zpdesc = alloc_zpdesc(gfp | __GFP_ZERO, nid);
 		if (!zpdesc) {
 			while (--i >= 0) {
 				zpdesc_dec_zone_page_state(zpdescs[i]);
_

Patches currently in -mm which might be from contact.kartikn@gmail.com are

zsmalloc-zero-initialize-zspage-memory-to-prevent-kmsan-uninit-reads.patch


