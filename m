Return-Path: <stable+bounces-232634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KsmA1dszGmUSwYAu9opvQ
	(envelope-from <stable+bounces-232634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:52:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA763734B1
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA8973045038
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9D1175A84;
	Wed,  1 Apr 2026 00:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0JzeP5oi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF872AD03;
	Wed,  1 Apr 2026 00:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775004572; cv=none; b=SidHdXAumL1hJeNXOGhfNCChO+aOC75JnOjN8o8OdWATcTzaPV2ProsdPEmCCOW8rWEPNu/3q515h2FdZPfJdA+Q7fiHTHchSaQ7tc9OkW58Vzx4B+IoQhgfCtaweWPVGnH2llltW4hINF4zEAW37jhxpEl9YASxPOVH4N/V/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775004572; c=relaxed/simple;
	bh=vUrluuoZRhSYpBLjGbEn4sx2TK3GqyhqGROHhUsZQic=;
	h=Date:To:From:Subject:Message-Id; b=mAiC238ZHHVP7AU43WmaYijd+uNdLnYy3IF262YQvkXwf9ZtA+KWTVynzxtw5k96ufDMtFMMDbnreBtNe+UVv80VcM/+zhf194XmFxcA7ulidbKDFYsHXCkQp6iK7FYRFPYq4mi29pWWSnMDAF1hwM/ihn1E/BvsObxqTncaVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0JzeP5oi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA59C19423;
	Wed,  1 Apr 2026 00:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775004571;
	bh=vUrluuoZRhSYpBLjGbEn4sx2TK3GqyhqGROHhUsZQic=;
	h=Date:To:From:Subject:From;
	b=0JzeP5oiwIfVGmknRxND8wNoZa3e3xS660g2BB/AqSM82lYKFVpx7XsCELed2EYh/
	 zRgj0Ah7ctaBbo2n5GY3HEl52m/BpSg+MJRhaCTIExpBW8QqFBrpr5IaMg4BrJ85m2
	 5bMzg/z/09vsS076RqZf8XZAYiUJ8sPn6/Bx2w1g=
Date: Tue, 31 Mar 2026 17:49:30 -0700
To: mm-commits@vger.kernel.org,wqu@suse.com,stable@vger.kernel.org,minchan@kernel.org,hch@lst.de,bgeffon@google.com,axboe@kernel.dk,avinesh.kumar@suse.com,senozhatsky@chromium.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + zram-do-not-forget-to-endio-for-partial-discard-requests.patch added to mm-new branch
Message-Id: <20260401004931.6FA59C19423@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TAGGED_FROM(0.00)[bounces-232634-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,chromium.org:email,suse.com:email,suse.com:url,linux-foundation.org:dkim,linux-foundation.org:email,kernel.dk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email]
X-Rspamd-Queue-Id: 6DA763734B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch titled
     Subject: zram: do not forget to endio for partial discard requests
has been added to the -mm mm-new branch.  Its filename is
     zram-do-not-forget-to-endio-for-partial-discard-requests.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/zram-do-not-forget-to-endio-for-partial-discard-requests.patch

This patch will later appear in the mm-new branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Note, mm-new is a provisional staging ground for work-in-progress
patches, and acceptance into mm-new is a notification for others take
notice and to finish up reviews.  Please do not hesitate to respond to
review feedback and post updated versions to replace or incrementally
fixup patches in mm-new.

The mm-new branch of mm.git is not included in linux-next

If a few days of testing in mm-new is successful, the patch will me moved
into mm.git's mm-unstable branch, which is included in linux-next

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
From: Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: zram: do not forget to endio for partial discard requests
Date: Tue, 31 Mar 2026 16:42:44 +0900

As reported by Qu Wenruo and Avinesh Kumar, the following

 getconf PAGESIZE
 65536
 blkdiscard -p 4k /dev/zram0

takes literally forever to complete.  zram doesn't support partial
discards and just returns immediately w/o doing any discard work in such
cases.  The problem is that we forget to endio on our way out, so
blkdiscard sleeps forever in submit_bio_wait().  Fix this by jumping to
end_bio label, which does bio_endio().

Link: https://lkml.kernel.org/r/20260331074255.777019-1-senozhatsky@chromium.org
Fixes: 0120dd6e4e202 ("zram: make zram_bio_discard more self-contained")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reported-by: Qu Wenruo <wqu@suse.com>
Closes: https://lore.kernel.org/linux-block/92361cd3-fb8b-482e-bc89-15ff1acb9a59@suse.com
Tested-by: Qu Wenruo <wqu@suse.com>
Reported-by: Avinesh Kumar <avinesh.kumar@suse.com>
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1256530
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/block/zram/zram_drv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/block/zram/zram_drv.c~zram-do-not-forget-to-endio-for-partial-discard-requests
+++ a/drivers/block/zram/zram_drv.c
@@ -2678,7 +2678,7 @@ static void zram_bio_discard(struct zram
 	 */
 	if (offset) {
 		if (n <= (PAGE_SIZE - offset))
-			return;
+			goto end_bio;
 
 		n -= (PAGE_SIZE - offset);
 		index++;
@@ -2693,6 +2693,7 @@ static void zram_bio_discard(struct zram
 		n -= PAGE_SIZE;
 	}
 
+end_bio:
 	bio_endio(bio);
 }
 
_

Patches currently in -mm which might be from senozhatsky@chromium.org are

zram-do-not-forget-to-endio-for-partial-discard-requests.patch


