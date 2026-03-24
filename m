Return-Path: <stable+bounces-230216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMKfDo3jwmmPnAQAu9opvQ
	(envelope-from <stable+bounces-230216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:18:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A453A31B5B9
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 024003044805
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 19:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149A2288C34;
	Tue, 24 Mar 2026 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fBnuoY50"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80E26A0A7;
	Tue, 24 Mar 2026 19:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379914; cv=none; b=McAKqQADuGGcdO3FxEs0UqwMwWO2Jg7Z7obDJiyH0ZfB9AoG5oPQ8LOvg/La/hJ4podpM0yaYykiWVtrDKGJ+iKWPCrWnSvbhZr7w71atwx7UEwNQ63gFba0YxqP8GN9t03TQe3fwIZ+np4JJYRnsLIlco+jMZ+l9moIczvQHeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379914; c=relaxed/simple;
	bh=JPtDym5iDx7dE6u/fjL0RKrRgDH1LaMNjixVLLIe40g=;
	h=Date:To:From:Subject:Message-Id; b=Pr+4uCKG5Alhb8heu5G12Nux7zjBQpsh/2bZJGD+zVXWWpXedKLibGqlUj+krejrrBqad//Xctev/TDay/eui1Nm6/Gc871FCDpGhdrhf6wDew4gLRd9y0AS29+UvhqOjtCgBB6lHFzVtB+iYDj7qbQO9PHQdbo+EEoT5TTe9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fBnuoY50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3EBC19424;
	Tue, 24 Mar 2026 19:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774379914;
	bh=JPtDym5iDx7dE6u/fjL0RKrRgDH1LaMNjixVLLIe40g=;
	h=Date:To:From:Subject:From;
	b=fBnuoY50wISFUuR34Wqv/Jr+TIQ35WEM8RCJhpVrda5+ndfYHysx3foOxWUgPYI03
	 sVCRFzKfy9/PFDrZa/3ZUmd2ygGdYShVo0qXOiy8gDV7MbwE/aE9RqRyY7SBg1SaoF
	 DpXwGxvfhsl4rWsusS9IQYQ83eY4z3lYMa1v14jE=
Date: Tue, 24 Mar 2026 12:18:33 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,pmladek@suse.com,objecting@objecting.org,kees@kernel.org,dhowells@redhat.com,davidgow@google.com,lk@c--e.de,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + lib-fix-length-calculation-in-extract_kvec_to_sg.patch added to mm-nonmm-unstable branch
Message-Id: <20260324191834.6E3EBC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TAGGED_FROM(0.00)[bounces-230216-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,c--e.de:email,objecting.org:email,linux-foundation.org:dkim,linux-foundation.org:email]
X-Rspamd-Queue-Id: A453A31B5B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch titled
     Subject: lib: fix length calculation in extract_kvec_to_sg
has been added to the -mm mm-nonmm-unstable branch.  Its filename is
     lib-fix-length-calculation-in-extract_kvec_to_sg.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/lib-fix-length-calculation-in-extract_kvec_to_sg.patch

This patch will later appear in the mm-nonmm-unstable branch at
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
From: "Christian A. Ehrhardt" <lk@c--e.de>
Subject: lib: fix length calculation in extract_kvec_to_sg
Date: Mon, 23 Mar 2026 22:23:50 +0100

When extracting from a kvec to a scatterlist, do not cross page
boundaries.  The required length is already calculated but not used as
intended.

The previous changes to the kunit_iov_iter.c demonstrate that the patch is
necessary.

Link: https://lkml.kernel.org/r/20260323212350.807118-4-lk@c--e.de
Fixes: 018584697533 ("netfs: Add a function to extract an iterator into a scatterlist")
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
Reviewed-by: Josh Law <objecting@objecting.org>
Tested-by: Josh Law <objecting@objecting.org>
Cc: David Howells <dhowells@redhat.com>
Cc: David Gow <davidgow@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/scatterlist.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/scatterlist.c~lib-fix-length-calculation-in-extract_kvec_to_sg
+++ a/lib/scatterlist.c
@@ -1247,7 +1247,7 @@ static ssize_t extract_kvec_to_sg(struct
 			else
 				page = virt_to_page((void *)kaddr);
 
-			sg_set_page(sg, page, len, off);
+			sg_set_page(sg, page, seg, off);
 			sgtable->nents++;
 			sg++;
 			sg_max--;
_

Patches currently in -mm which might be from lk@c--e.de are

lib-kunit_iov_iter-improve-error-detection.patch
lib-kunit_iov_iter-add-tests-for-extract_iter_to_sg.patch
lib-fix-length-calculation-in-extract_kvec_to_sg.patch


