Return-Path: <stable+bounces-269239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V22CNwGvPmriKAkAu9opvQ
	(envelope-from <stable+bounces-269239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:55:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAE06CF493
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:55:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=y3SHf6US;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269239-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269239-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1998B307D7E4
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65A1358372;
	Fri, 26 Jun 2026 16:50:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28DD3FF1D5;
	Fri, 26 Jun 2026 16:50:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492653; cv=none; b=ZElt/83/h95ACakIBnoNKsTld1o1dgXRgu09+TmSkFmaozog0wQf2nnsJH/UIivE56o6DuBl724W7r8b6MWQuOllMFo4I/mWJSyjx5byezZZVThNqVt+GiN/4ZnTyv3dlAIbK8pgWPSgXMLgVjNw5mNOd7lN7ZO3gRBsGeifksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492653; c=relaxed/simple;
	bh=Rdgi4XISxk2RbCfNkPVFbupZyaYg+7Tp5m7WiFvof6U=;
	h=Date:To:From:Subject:Message-Id; b=SCc/OLfkH39oqmxV++BAGjQ6V7yFueNtNplbxbWN8gV6qqMW2bVf/YS3afCdlqTG0AaR+3C1tvZQwG7RDC1WshTogK17zw0wRxN9tHlsojLECMOg4XXapDanR8hT//BmD30Ls1zgqQ3nJoj+eUfc3A28YnoybYxTG8taPyKq5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=y3SHf6US; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038311F00A3E;
	Fri, 26 Jun 2026 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782492647;
	bh=L/uu47sRYUdCVB/fjvDNa6+lQH6AhBSXI7KIFWy3uVM=;
	h=Date:To:From:Subject;
	b=y3SHf6USIj5OVh9zWZ74XdBsyj2SRFapY3PNf1mf7DD5giUKUsOE3eYISRFIl1pbi
	 RJFs/UFuWlsrSLKCyZcj74fUxjzKv9X/uSWvPL1bPnmv7PuMC/jRkoOBlB6CCOkiGN
	 1J+2YCZS9McwxQpV0BG4+wJzHkzS1uXKd1Ilewis=
Date: Fri, 26 Jun 2026 09:50:46 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,pmladek@suse.com,npiggin@gmail.com,mpe@ellerman.id.au,maddy@linux.ibm.com,dianders@chromium.org,include@grrlz.net,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [to-be-updated] panic-use-sys_info_with_filter-to-avoid-duplicate-backtraces.patch removed from -mm tree
Message-Id: <20260626165047.038311F00A3E@smtp.kernel.org>
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
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-269239-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:pmladek@suse.com,m:npiggin@gmail.com,m:mpe@ellerman.id.au,m:maddy@linux.ibm.com,m:dianders@chromium.org,m:include@grrlz.net,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[vger.kernel.org,suse.com,gmail.com,ellerman.id.au,linux.ibm.com,chromium.org,grrlz.net,linux-foundation.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime,smtp.kernel.org:mid,chromium.org:email,suse.com:email,vger.kernel.org:from_smtp,grrlz.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BAE06CF493


The quilt patch titled
     Subject: panic: use sys_info_with_filter() to avoid duplicate backtraces
has been removed from the -mm tree.  Its filename was
     panic-use-sys_info_with_filter-to-avoid-duplicate-backtraces.patch

This patch was dropped because an updated version will be issued

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

lib-string-fix-memchr_inv-for-large-ranges.patch


