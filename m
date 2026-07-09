Return-Path: <stable+bounces-272792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LrP7G60RT2otaAIAu9opvQ
	(envelope-from <stable+bounces-272792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 05:12:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE8672C373
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 05:12:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=CGjb4fyR;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272792-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272792-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 957923013D5E
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 03:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DA93890F0;
	Thu,  9 Jul 2026 03:12:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F381A681B;
	Thu,  9 Jul 2026 03:12:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783566760; cv=none; b=TdnUbb1GNZTh1xPF2/YPfB93Lyx9PhlQxhS04oK8j8m4FwEJwH8cqIiejc+6swq1obqOQWmo/NdXR/ojOYp8f/nha6cktBviNTfntqc0+o1Nr7OslNhguQI/wcAPxXIaJUkIYNjexa6milGH2qjicsyjeUGIRM0bM0Uv+37mP70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783566760; c=relaxed/simple;
	bh=NA5YOYVcZ/CJObZoiAoHNXRfWC4Wdb3+ag0KcLho2Sw=;
	h=Date:To:From:Subject:Message-Id; b=UK6EakS+L38MdYvy1GP/HaAKFCrzLXaLJUHreyCMDdejZdPZB7is9lNXKmyhA0IhUSeL4TdRV3ZCJJ4tVkykJKko3oII9C7r5SUZUG0tN00eBi7uZRaaOamswR9i+pX+yz/h+/4HOrViI0WvOcpDYjUNs3d9pm2rJqrHEc4SMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CGjb4fyR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB911F000E9;
	Thu,  9 Jul 2026 03:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783566759;
	bh=8NQ5NrikLWnmFoUVdCwsRfrYg87WScw66Rg803hgDyk=;
	h=Date:To:From:Subject;
	b=CGjb4fyRfHXn57btZD7MvEPeNimsgYblVJOZ+z9lbCuqxNJWxsCf6tA7Y+3v61p57
	 XunWP/maFVpdJkgzD5KPeBLFpJLQslN/t+qwlUJr+0DaknXFt8BZJE8NLlW/sTZEPI
	 /MSzkuVLjmiWFgnBNAq1R0KJqbradcEZ5y5cR+4g=
Date: Wed, 08 Jul 2026 20:12:38 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,linux@roeck-us.net,kees@kernel.org,david@davidgow.net,brendan.higgins@linux.dev,aesteve@redhat.com,acarmina@redhat.com,bartosz.golaszewski@oss.qualcomm.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + bug-fix-warning-suppressions-with-kunit-built-as-module.patch added to mm-hotfixes-unstable branch
Message-Id: <20260709031239.1AB911F000E9@smtp.kernel.org>
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
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-272792-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:linux@roeck-us.net,m:kees@kernel.org,m:david@davidgow.net,m:brendan.higgins@linux.dev,m:aesteve@redhat.com,m:acarmina@redhat.com,m:bartosz.golaszewski@oss.qualcomm.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BAE8672C373


The patch titled
     Subject: bug: fix warning suppressions with kunit built as module
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     bug-fix-warning-suppressions-with-kunit-built-as-module.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/bug-fix-warning-suppressions-with-kunit-built-as-module.patch

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
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: bug: fix warning suppressions with kunit built as module
Date: Wed, 8 Jul 2026 11:54:58 +0200

CONFIG_KUNIT is a tristate symbol but the warning suppression code in
lib/bug.c is only built if it's built-in due to it using a plain #ifdef,
rendering warning suppressions broken for kunit build as loadable module.

kunit_is_suppressed_warning() already has a stub for when kunit is
disabled so drop that guard entirely.

Link: https://lore.kernel.org/20260708095459.12111-1-bartosz.golaszewski@oss.qualcomm.com
Fixes: 85347718ab0d ("bug/kunit: Core support for suppressing warning backtraces")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Suggested-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: David Gow <david@davidgow.net>
Cc: Alessandro Carminati <acarmina@redhat.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: Guenetr Roeck <linux@roeck-us.net>
Cc: Kees Cook <kees@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/bug.c |    2 --
 1 file changed, 2 deletions(-)

--- a/lib/bug.c~bug-fix-warning-suppressions-with-kunit-built-as-module
+++ a/lib/bug.c
@@ -219,14 +219,12 @@ static enum bug_trap_type __report_bug(s
 	no_cut   = bug->flags & BUGFLAG_NO_CUT_HERE;
 	has_args = bug->flags & BUGFLAG_ARGS;
 
-#ifdef CONFIG_KUNIT
 	/*
 	 * Before the once logic so suppressed warnings do not consume
 	 * the single-fire budget of WARN_ON_ONCE().
 	 */
 	if (warning && kunit_is_suppressed_warning(true))
 		return BUG_TRAP_TYPE_WARN;
-#endif
 
 	disable_trace_on_warning();
 
_

Patches currently in -mm which might be from bartosz.golaszewski@oss.qualcomm.com are

bug-fix-warning-suppressions-with-kunit-built-as-module.patch


