Return-Path: <stable+bounces-262401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8RfhOg7BKGpgJAMAu9opvQ
	(envelope-from <stable+bounces-262401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 03:42:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7B566547C
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 03:42:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b="Wgj+/lYo";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262401-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262401-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1FCC311D9DB
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 01:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63E31A0BE0;
	Wed, 10 Jun 2026 01:36:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0430629E116;
	Wed, 10 Jun 2026 01:36:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055413; cv=none; b=PFWVyKrIzu2G3C1TVSvMY2Nt1B5K+MDotIfbgPeKHxV8h2Ma6+YWUaVy5VHfJddhk0TSWlAEfNE1kwscG9gSM/FlISu638I/R7BWudw5MIRk1l18Mtc8oGeoNqb4aGTdDFRNQmj8siKWzuk2N2OCxh43kFO6A+NYbhY3h0INmz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055413; c=relaxed/simple;
	bh=/gl99GJgdfpcWRLZCqYYP8F4/G4eYXx83hWjrBVCNdc=;
	h=Date:To:From:Subject:Message-Id; b=SVksTgqA81P6qSb+xftuNUw326mputMzDnO+2GRJd0oyFQMfo4/P+jD1dr42w/e/bBG0ikOvBr6iLUzqBopE9cEnZ5fTblsIXY1Is8ttidK1SWK5vzCvSH/pPGwX6uTBADTY1CSWdmpsK2wNwrsdifJOUHD4O4W3IGIKQz7zaSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wgj+/lYo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A61F1F00893;
	Wed, 10 Jun 2026 01:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1781055408;
	bh=ekXe1CvN8tWkS0sqK9fMmQJi2X1A0j10kSVWYcb/vbo=;
	h=Date:To:From:Subject;
	b=Wgj+/lYodbqUIKdQPV4j60yxQidDD7Ksu4TXYVielF3gVkY5LUU+oQ/kDcZgPbVig
	 dAN9BLabVVtB95WxKOQOKzLIu80yQ9erXxPjmqqBAMu76XBsIRAa7ntS6ougBilAmG
	 625R8/7w3pGwGVOsIgbd5VIHmAMuX6idRk0JOCV0=
Date: Tue, 09 Jun 2026 18:36:47 -0700
To: mm-commits@vger.kernel.org,yang.lee@linux.alibaba.com,stable@vger.kernel.org,peterx@redhat.com,jhubbard@nvidia.com,jgg@ziepe.ca,david@kernel.org,cuiyunhui@bytedance.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-gup_test-fix-race-with-pin_longterm_test-ioctls.patch added to mm-new branch
Message-Id: <20260610013648.2A61F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-262401-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:yang.lee@linux.alibaba.com,m:stable@vger.kernel.org,m:peterx@redhat.com,m:jhubbard@nvidia.com,m:jgg@ziepe.ca,m:david@kernel.org,m:cuiyunhui@bytedance.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bytedance.com:email,vger.kernel.org:from_smtp,nvidia.com:email,linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A7B566547C


The patch titled
     Subject: mm/gup_test: fix race with PIN_LONGTERM_TEST ioctls
has been added to the -mm mm-new branch.  Its filename is
     mm-gup_test-fix-race-with-pin_longterm_test-ioctls.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-gup_test-fix-race-with-pin_longterm_test-ioctls.patch

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
From: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: mm/gup_test: fix race with PIN_LONGTERM_TEST ioctls
Date: Mon, 8 Jun 2026 10:50:42 +0800

The PIN_LONGTERM_TEST helpers keep their state in global variables that
are protected by pin_longterm_test_mutex when accessed from ioctl(). 
However, gup_test_release() calls pin_longterm_test_stop() without holding
that mutex.

This can race with PIN_LONGTERM_TEST_STOP and let two callers operate on
the same pages array concurrently, corrupting the test state and possibly
freeing it twice:

 CPU 0                              CPU 1
 -----                              -----
 ioctl(PIN_LONGTERM_TEST_STOP)
   mutex_lock(&pin_longterm_test_mutex)
   pin_longterm_test_stop()
     if (pin_longterm_test_pages)
       kvfree(pin_longterm_test_pages)

                                    close()
                                      gup_test_release()
                                        pin_longterm_test_stop()
                                          if (pin_longterm_test_pages)
                                            kvfree(pin_longterm_test_pages)

     pin_longterm_test_pages = NULL
   mutex_unlock(&pin_longterm_test_mutex)

Protect the release path with the same mutex so that stop and release
cannot run pin_longterm_test_stop() concurrently.

Link: https://lore.kernel.org/20260608025043.88087-1-cuiyunhui@bytedance.com
Fixes: c77369b437f9 ("mm/gup_test: start/stop/read functionality for PIN LONGTERM test")
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yang Li <yang.lee@linux.alibaba.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/gup_test.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/gup_test.c~mm-gup_test-fix-race-with-pin_longterm_test-ioctls
+++ a/mm/gup_test.c
@@ -377,7 +377,9 @@ static long gup_test_ioctl(struct file *
 
 static int gup_test_release(struct inode *inode, struct file *file)
 {
+	mutex_lock(&pin_longterm_test_mutex);
 	pin_longterm_test_stop();
+	mutex_unlock(&pin_longterm_test_mutex);
 
 	return 0;
 }
_

Patches currently in -mm which might be from cuiyunhui@bytedance.com are

mm-gup_test-fix-race-with-pin_longterm_test-ioctls.patch


