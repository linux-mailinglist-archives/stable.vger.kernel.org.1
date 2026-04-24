Return-Path: <stable+bounces-240990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GtNIUqM62lBNwAAu9opvQ
	(envelope-from <stable+bounces-240990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 17:29:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFDC460C79
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 17:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9EBC3007AED
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B071D3115BC;
	Fri, 24 Apr 2026 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O0sLZ65E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F152C0F6D;
	Fri, 24 Apr 2026 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777044547; cv=none; b=dCvVHj2kgaM3/OCgGuQV4zvVYtQvcNog9KDy6mxMPgeWGbzl0EIjAu4XyCIRYN2eHARm+G4g0h+C1zQz/ad/NnCSwRmFITZNq6FIgZMXbj7g2nwbfoeqddnMA9xMHA1xbcJALipDNbzxez+8QLHA0WdjrVPj1L81mEOiEwe0UeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777044547; c=relaxed/simple;
	bh=z8g55jJxkVK65lBlfAd1QlVw49kpoWTm3+rI70O8CRM=;
	h=Date:To:From:Subject:Message-Id; b=Kqz9D4deRMG26p/+7SKVx9AjT1ZBHoWYXmQwDB39cSRsVOkxHE4yWiyDo70twEs4y3wK2FHAHEEXAwxH9X9KMhYkCupWgwZ+IRajrwz9/0QPl2RM5Qa1Uf+lb5Bjs6LKHNpesaL1jmLeY8KiIvfSBtiHqiXpq474VoLMin3B2Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O0sLZ65E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C783C19425;
	Fri, 24 Apr 2026 15:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777044547;
	bh=z8g55jJxkVK65lBlfAd1QlVw49kpoWTm3+rI70O8CRM=;
	h=Date:To:From:Subject:From;
	b=O0sLZ65El+HYcqC1sNvxuPLp3VigVgBEMQ6m6u0W0K9L/PMo1Ps/xDJ1erErcV1b3
	 gHVG9gTXA7fe3ynY3HMQoIv2/w0sjl6A75SKfmVx5V/P4SxHa4VQtNphI6m6G6Z2SZ
	 rzAXgui4qY+GmfGbaG/t4WMPNbjNJEuUsjccGn3I=
Date: Fri, 24 Apr 2026 08:29:06 -0700
To: mm-commits@vger.kernel.org,vbabka@kernel.org,surenb@google.com,stable@vger.kernel.org,shuah@kernel.org,rppt@kernel.org,pfalcato@suse.de,mhocko@suse.com,ljs@kernel.org,liam@infradead.org,jason@zx2c4.com,jannh@google.com,david@kernel.org,broonie@kernel.org,anthony.yznaga@oracle.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-fix-mmap-errno-value-when-map_droppable-is-not-supported.patch added to mm-new branch
Message-Id: <20260424152907.1C783C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 8AFDC460C79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240990-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]


The patch titled
     Subject: mm: fix mmap errno value when MAP_DROPPABLE is not supported
has been added to the -mm mm-new branch.  Its filename is
     mm-fix-mmap-errno-value-when-map_droppable-is-not-supported.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-fix-mmap-errno-value-when-map_droppable-is-not-supported.patch

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
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: mm: fix mmap errno value when MAP_DROPPABLE is not supported
Date: Wed, 15 Apr 2026 20:39:37 -0700

Patch series "fix MAP_DROPPABLE not supported errno", v4.

Mark Brown reported seeing a regression in -next on 32 bit arm with the
mlock selftests.  Before exiting and marking the tests failed, the
following message was logged after an attempt to create a MAP_DROPPABLE
mapping:

Bail out! mmap error: Unknown error 524

It turns out error 524 is ENOTSUPP which is an error that userspace is not
supposed to see, but it indicates in this instance that MAP_DROPPABLE is
not supported.

The first patch changes the errno returned to EOPNOTSUPP.  The second
patch is a second version of a prior patch to introduce selftests to
verify locking behavior with droppable mappings with the additional change
to skip the tests when MAP_DROPPABLE is not supported.  The third patch
fixes the MAP_DROPPABLE selftest so that it is run by the framework and
skips if MAP_DROPPABLE is not supported.


This patch (of 3):

On configs where MAP_DROPPABLE is not supported (currently any 32-bit
config except for PPC32), mmap fails with errno set to ENOTSUPP.  However,
ENOTSUPP is not a standard error value that userspace knows about.  The
acceptable userspace-visible errno to use is EOPNOTSUPP.  checkpatch.pl
has a warning to this effect.

Link: https://lore.kernel.org/20260416033939.49981-1-anthony.yznaga@oracle.com
Link: https://lore.kernel.org/20260416033939.49981-2-anthony.yznaga@oracle.com
Fixes: 9651fcedf7b9 ("mm: add MAP_DROPPABLE for designating always lazily freeable mappings")
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reported-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Jason A. Donenfeld <jason@zx2c4.com>
Cc: Liam Howlett <liam@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/mmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/mmap.c~mm-fix-mmap-errno-value-when-map_droppable-is-not-supported
+++ a/mm/mmap.c
@@ -504,7 +504,7 @@ unsigned long do_mmap(struct file *file,
 			break;
 		case MAP_DROPPABLE:
 			if (VM_DROPPABLE == VM_NONE)
-				return -ENOTSUPP;
+				return -EOPNOTSUPP;
 			/*
 			 * A locked or stack area makes no sense to be droppable.
 			 *
_

Patches currently in -mm which might be from anthony.yznaga@oracle.com are

mm-fix-mmap-errno-value-when-map_droppable-is-not-supported.patch
selftests-mm-verify-droppable-mappings-cannot-be-locked.patch
selftests-mm-run-the-map_droppable-selftest.patch


