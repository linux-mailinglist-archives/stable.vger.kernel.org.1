Return-Path: <stable+bounces-233390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM8XA93N02lpmQcAu9opvQ
	(envelope-from <stable+bounces-233390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 17:14:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 762F03A4A0E
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 17:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73EDA3013A68
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7028A386547;
	Mon,  6 Apr 2026 15:14:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B399831D72E;
	Mon,  6 Apr 2026 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775488471; cv=none; b=Mpa06PM+em2RDKc/6wF9kWZdDAyNuJtM9nvNmJXWyiuRx3pXiqtGbtKLctD3nuCZVfLIzIbYWho7EONCZC6K3KeZlX5n7bWy9yOn/C4zKMm9RRE0p4DLR0BJHvy39LLQMhMt4b00txHYxfYCkYDtRb+4x+WyXNiUT1s/Iu/Da34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775488471; c=relaxed/simple;
	bh=ts5KzjUHDQyKdtXvflQGnOpoyo0dUSCDgyObsf4tRw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqLuzNNuyvBnOWYmnUxNlGycfyOof2ECJEWonlRyA0N2YVrMMX0z3mYNOEhkZezW9WYTtngiVNga7Hiw7ZlvrsitBXLkRMEy+hrEtBmauc8snK4WZrZ6oJDYIHGlgX/t/Nwe2jmgp1Q/F9CmO+8uAGmjIua45YNb2jmpUSEao2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 0A2748B85F;
	Mon,  6 Apr 2026 15:14:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 02AF360011;
	Mon,  6 Apr 2026 15:14:19 +0000 (UTC)
Date: Mon, 6 Apr 2026 11:15:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tamir Duberstein <tamird@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH] printf: mark errptr() noinline
Message-ID: <20260406111531.779571d7@gandalf.local.home>
In-Reply-To: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qj577ua6dnhnu9pjaaszfsp969oidgam
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19+5yIf5FKTeYhjpwEa7iZHSDHB+idZfRk=
X-HE-Tag: 1775488459-959853
X-HE-Meta: U2FsdGVkX19abzY3ZUquCOFNi6+zDVTlPGzMPkv/iF8yFsY5N0U58Z3iqe+uRKmgP5nsneZ/zOcAHkys28wkA0CQAeDJ5iItF9lboVUvDHbhS/KhNZmPlVKUU+REvOkRgJcFg9BMgM7FfW1aIp5OgyzEdeRaoWdM2hJgFVnQUTIZQFDpO8s7V2W8Wubl2UYbwm6eBzD8NAdM+eqyRBQ+ZL1hsh4/RikTn+dyICwMcMAAySo4yTzYI2r2aTcBNkthca0gr8e2mgBH20/UcMQio/v/U909yqPLUR0hjE1J23ZaHgEiOqq1U/7kCzxMJXFDodC+DI9VqoGJvEHI8o49VSo0wyPIef7DgRm5rEhNI5B/ZiFv5unyuw==
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.710];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-233390-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,gandalf.local.home:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 762F03A4A0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 05 Apr 2026 13:31:50 -0400
Tamir Duberstein <tamird@kernel.org> wrote:

> Old GCC can miscompile printf_kunit's errptr() test when branch
> profiling is enabled. BUILD_BUG_ON(IS_ERR(PTR)) is a constant false
> expression, but CONFIG_TRACE_BRANCH_PROFILING and
> CONFIG_PROFILE_ALL_BRANCHES make the IS_ERR() path side-effectful.
> GCC's IPA splitter can then outline the cold assert arm into
> errptr.part.* and leave that clone with an unconditional
> __compiletime_assert_*() call, causing a false build failure.
> 
> This started showing up after test_hashed() became a macro and moved its
> local buffer into errptr(), which changed GCC's inlining and splitting
> decisions enough to expose the compiler bug.
> 
> Mark errptr() noinline to keep it out of that buggy IPA path while
> preserving the BUILD_BUG_ON(IS_ERR(PTR)) check and the macro-based
> printf argument checking.
> 
> Fixes: 9bfa52dac27a ("printf: convert test_hashed into macro")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604030636.NqjaJvYp-lkp@intel.com/
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>

Another solution which I would be fine with is:

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e130da35808f..c07e8eadfdd0 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -692,6 +692,7 @@ config PROFILE_ANNOTATED_BRANCHES
 config PROFILE_ALL_BRANCHES
 	bool "Profile all if conditionals" if !FORTIFY_SOURCE
 	select TRACE_BRANCH_PROFILING
+	depends on !KUNIT
 	help
 	  This tracer profiles all branch conditions. Every if ()
 	  taken in the kernel is recorded whether it hit or miss.


-- Steve

