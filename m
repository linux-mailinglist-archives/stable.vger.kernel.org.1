Return-Path: <stable+bounces-268665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +FeXHgB3PWrD3QgAu9opvQ
	(envelope-from <stable+bounces-268665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 20:44:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FAD6C846C
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 20:44:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=pDoddv2G;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268665-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268665-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A879930365AA
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 18:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313A932D0EE;
	Thu, 25 Jun 2026 18:44:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E382430AD1A;
	Thu, 25 Jun 2026 18:44:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782413052; cv=none; b=rreFVVHCq5jgiJCZxCyRoPpiUK9XGxuR5xD+oYWO0YQpZw51keS1fRovxa7Ud1MABxda5cuGNPhuzTfZeNy/pA5dVb8OAl7O4rxAJJwNAjt/wph0TGD0loaZqcxeTcdJEj8LnzfgelV6n3y7Et0oZjLYojSz0UCKSkNzvo371RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782413052; c=relaxed/simple;
	bh=05WJkETWH/PQgd+TZJ1AYnm6QSrIDt4/Y35Pu6HrrgI=;
	h=Date:To:From:Subject:Message-Id; b=XXRbIh2M2zyOxJqvBeRKwHte9ONIbQBpsWB79fCClPzrSccxgrgntKVPTTgF0tVyaVpWy4NWdKrCxKYb1MjUWqJ0ovv2GYN4mMVKY5S9A0uI916bMcIcwxEs+grZLfC6zA5VOI/sqjQ6NdA8prS9pv/VZxTSENoT3Vc6UIc93Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pDoddv2G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDDE1F00A3A;
	Thu, 25 Jun 2026 18:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782413050;
	bh=BaDxdIDDOs7OONuaSbWochtZemo1KNTJbOrJnX6zUdM=;
	h=Date:To:From:Subject;
	b=pDoddv2GoYn8NTJegK/aL6a2REPIkpanGNT5xQzmPy1r63wQLk5FXUIddeIL3y+ym
	 kxAMyIrIjr1gwHH224t/KuSeGrAUl+Zvy7JaDuV+iDckj+vN44IibCAP77oUD52pUB
	 Msl1sCQ75svJZ0NpISgVTsv6qswm6qiyFWGrr3Mw=
Date: Thu, 25 Jun 2026 11:44:10 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,pmladek@suse.com,npiggin@gmail.com,mpe@ellerman.id.au,maddy@linux.ibm.com,dianders@chromium.org,include@grrlz.net,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + panic-use-sys_info_with_filter-to-avoid-duplicate-backtraces.patch added to mm-hotfixes-unstable branch
Message-Id: <20260625184410.9FDDE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-268665-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:pmladek@suse.com,m:npiggin@gmail.com,m:mpe@ellerman.id.au,m:maddy@linux.ibm.com,m:dianders@chromium.org,m:include@grrlz.net,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[vger.kernel.org,suse.com,gmail.com,ellerman.id.au,linux.ibm.com,chromium.org,grrlz.net,linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime,suse.com:email,vger.kernel.org:from_smtp,chromium.org:email,smtp.kernel.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ellerman.id.au:email,grrlz.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19FAD6C846C


The patch titled
     Subject: panic: use sys_info_with_filter() to avoid duplicate backtraces
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     panic-use-sys_info_with_filter-to-avoid-duplicate-backtraces.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/panic-use-sys_info_with_filter-to-avoid-duplicate-backtraces.patch

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
From: Bradley Morgan <include@grrlz.net>
Subject: panic: use sys_info_with_filter() to avoid duplicate backtraces
Date: Thu, 25 Jun 2026 15:25:58 +0000

panic_other_cpus_shutdown() handles SYS_INFO_ALL_BT before stopping the
other CPUs.  Do not ask sys_info() to handle that bit again later in the
panic path.

Use sys_info_with_filter() so panic_print=all_bt does not request more
output after the CPUs are stopped.

Link: https://lore.kernel.org/20260625152558.7450-5-include@grrlz.net
Fixes: a9af76a78760 ("watchdog: add sys_info sysctls to dump sys info on system lockup")
Signed-off-by: Bradley Morgan <include@grrlz.net>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/panic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/panic.c~panic-use-sys_info_with_filter-to-avoid-duplicate-backtraces
+++ a/kernel/panic.c
@@ -680,7 +680,7 @@ void vpanic(const char *fmt, va_list arg
 	 */
 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
 
-	sys_info(panic_print);
+	sys_info_with_filter(panic_print, SYS_INFO_ALL_BT);
 
 	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
 
_

Patches currently in -mm which might be from include@grrlz.net are

sys_info-add-helper-for-callers-that-print-some-sys_info-on-their-own.patch
watchdog-use-sys_info_with_filter-to-avoid-duplicate-backtraces.patch
powerpc-watchdog-use-sys_info_with_filter-to-avoid-duplicate-backtraces.patch
panic-use-sys_info_with_filter-to-avoid-duplicate-backtraces.patch
lib-string-fix-memchr_inv-for-large-ranges.patch


