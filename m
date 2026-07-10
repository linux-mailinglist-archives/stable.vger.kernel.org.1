Return-Path: <stable+bounces-273302-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yha7JBk/UWrrBAMAu9opvQ
	(envelope-from <stable+bounces-273302-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 20:51:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AB773D6EE
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 20:51:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=0oEeUu5M;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273302-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273302-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABB65302F7DC
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 18:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB3837702C;
	Fri, 10 Jul 2026 18:50:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79B62FD69E;
	Fri, 10 Jul 2026 18:50:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709445; cv=none; b=L5yKc5K09HFUiJVp5zslaCaRwhTrO3NZsb8t8uYDV3j850wMxTYsrANg2zKQu5zA0bBgQuawlLlVNBy5vGmQBv4iqYjLnte2yZ0NdAxv7rru3R7w/znYO7KXhhwLNENPXjUwA3bJ6GZEREYeHMJQGit1veGieCzKTOTTBzd7UnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709445; c=relaxed/simple;
	bh=WOzNP117jm4OL0RhQhIcfJcXE/oUn90/juMZlPhKOmQ=;
	h=Date:To:From:Subject:Message-Id; b=WVPf4ztIG5GVqEqgSpUHRMfv7+/PXCJaYzbeInfitAe5Flq8XOO0OU00hfoWIoqrcIivBYptYcvjg8DdeD2OZmmZ/S21bcz5wq6vPd5iJ+/tYpcEcftmpIDaDs4Gr24UMxPma+DLCuGttIjb8CtRk10yHD6ktQsxXbWNSOrLJ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0oEeUu5M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499A01F000E9;
	Fri, 10 Jul 2026 18:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783709443;
	bh=VzT18xDDE23PNjf8Ei4vzdFxx+ju9YxlrMwmDN12IF0=;
	h=Date:To:From:Subject;
	b=0oEeUu5MpjtzV/BzigxYeYRKgU5BILIYY+ha3I3PpXqcHDN7JOJAwp5lnIShfNu8x
	 j0qLZQLf3y1X5GoaBvP+/uezR4Er3qMHGG6i0fGZ94IYPbWXpA6qGiX5yIkFMbqINM
	 M5gfHdFlqPEobI9VvNg5VAFpGI4xFy3YAa5Uu0zM=
Date: Fri, 10 Jul 2026 11:50:42 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,shuah@kernel.org,richard.weiyang@gmail.com,cyphar@cyphar.com,brauner@kernel.org,jkoolstra@xs4all.nl,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + selftest-fix-headers-in-fclogc.patch added to mm-hotfixes-unstable branch
Message-Id: <20260710185043.499A01F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-273302-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:shuah@kernel.org,m:richard.weiyang@gmail.com,m:cyphar@cyphar.com,m:brauner@kernel.org,m:jkoolstra@xs4all.nl,m:akpm@linux-foundation.org,m:richardweiyang@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,cyphar.com,xs4all.nl,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cyphar.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4AB773D6EE


The patch titled
     Subject: selftest: fix headers in fclog.c
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     selftest-fix-headers-in-fclogc.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/selftest-fix-headers-in-fclogc.patch

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
From: Jori Koolstra <jkoolstra@xs4all.nl>
Subject: selftest: fix headers in fclog.c
Date: Fri, 10 Jul 2026 19:17:35 +0200

fclog.c does not compile because it is missing fcntl.h, needed for
O_RDONLY etc.

There are also some redundant includes that are also in
kselftest_harness.h.

Link: https://lore.kernel.org/20260710171741.837308-1-jkoolstra@xs4all.nl
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/testing/selftests/filesystems/fclog.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/tools/testing/selftests/filesystems/fclog.c~selftest-fix-headers-in-fclogc
+++ a/tools/testing/selftests/filesystems/fclog.c
@@ -6,10 +6,8 @@
 
 #include <assert.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <sched.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
 #include <unistd.h>
 #include <sys/mount.h>
 
_

Patches currently in -mm which might be from jkoolstra@xs4all.nl are

selftest-fix-headers-in-fclogc.patch


