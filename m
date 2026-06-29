Return-Path: <stable+bounces-269629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s+07JFn5QWpaxgkAu9opvQ
	(envelope-from <stable+bounces-269629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 06:49:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A546D5EC3
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 06:49:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=ViqWIiRq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269629-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-269629-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C792E3006B4C
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 04:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54CC282F30;
	Mon, 29 Jun 2026 04:49:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A216DEB1;
	Mon, 29 Jun 2026 04:49:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782708564; cv=none; b=iPKwB8GG9AqiCSSmjJJF1Tp+oN9mI/Yv2AYTuljhWNU2iRRgtmnlioLhLGexAl4o/EisTznwcPM7nRowyh9M0bVBPVcBJ2Cz69zreubwtzJrELWV/hPHUc/gOQjPm//sSw0E5swI7qdncSTsLWBOvubr2S1RT43lxBVKMLT24ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782708564; c=relaxed/simple;
	bh=+aV6Hpr/PFgAyM0K0pw1vR1dkmd4N1qNaqvwPNKQg44=;
	h=Date:To:From:Subject:Message-Id; b=IUeEHOZ5Sh8ioR7q0JZhbUOeyf5hhWPk3Kcfr/F0c4KnDjO1RtIVuDw3H4rNC1NIY6bYP/8oQr5r9xEjsUxVo++BADPna8YnMtWTqLMnQbDhUIXEnRkgOgx8sy79Q119a2kr5wpL1UvFf/kVl3FZpk4ILkuu9Yajbv46+X4qTNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ViqWIiRq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652901F000E9;
	Mon, 29 Jun 2026 04:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782708563;
	bh=+ln2U9hW9OGylynFKD+79eS7gsCd+TVs3gfdezM+Dbc=;
	h=Date:To:From:Subject;
	b=ViqWIiRqlTwNKaNEOxZg0sqnuXLsm2feHqT1rV6l4wcrLyTUM4aatmMQWMCxyuxRU
	 s6YV26ZNDOmBSSeHew1bCUr0FxNtvJ2URnYPJFEOeWiPCSKSHpSZt9ZR5SJPEWGeLQ
	 7s7Xttqzzihe79pGG9RHrT7wZ0v4f2+JLVjv5TJI=
Date: Sun, 28 Jun 2026 21:49:22 -0700
To: mm-commits@vger.kernel.org,zenghui.yu@linux.dev,stable@vger.kernel.org,sj@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + samples-damon-wsse-stop-and-free-damon-ctx-when-damon_call-fails.patch added to mm-new branch
Message-Id: <20260629044923.652901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269629-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:zenghui.yu@linux.dev,m:stable@vger.kernel.org,m:sj@kernel.org,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,smtp.kernel.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57A546D5EC3


The patch titled
     Subject: samples/damon/wsse: stop and free damon ctx when damon_call() fails
has been added to the -mm mm-new branch.  Its filename is
     samples-damon-wsse-stop-and-free-damon-ctx-when-damon_call-fails.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/samples-damon-wsse-stop-and-free-damon-ctx-when-damon_call-fails.patch

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
From: SJ Park <sj@kernel.org>
Subject: samples/damon/wsse: stop and free damon ctx when damon_call() fails
Date: Sun, 28 Jun 2026 14:54:44 -0700

damon_sample_wsse_start() calls damon_call() right after damon_start() is
succeeded.  The kdamond that has started by the damon_start() could be
terminated by itself before or in the middle of the damon_call()
execution.  There could be multiple reasons for such a stop including
monitoring target process termination and kdamond_fn() internal memory
allocation failures.  In the case, damon_call() will fail and return an
error without cleaning up the DAMON context object.  The
damon_sample_wsse_start() caller assumes it would clean up the object,
though.  When the user requests to start DAMON again,
damon_sample_wsse_start() is called again, allocates a new DAMON context
object and overwrites the pointer for the previous object.  As a result,
the previous context object is leaked.

Safely stop the kdamond and deallocate the context object when the failure
is returned.  Note that the kdamond should be stopped first, because
damon_call() failure means not complete termination of the kdamond but
only the fact that the termination process has started.

The user impact shouldn't be that significant because the race is not easy
to happen, and only up to one DAMON context object can be leaked per race.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260628215447.96166-6-sj@kernel.org
Link: https://lore.kernel.org/20260610034828.4632-1-sj@kernel.org [1]
Fixes: cc9c1b8c205b ("samples/damon/wsse: use damon_call() repeat mode instead of damon_callback")
Signed-off-by: SJ Park <sj@kernel.org>
Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 samples/damon/wsse.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/samples/damon/wsse.c~samples-damon-wsse-stop-and-free-damon-ctx-when-damon_call-fails
+++ a/samples/damon/wsse.c
@@ -92,7 +92,12 @@ static int damon_sample_wsse_start(void)
 		return err;
 	}
 	repeat_call_control.data = ctx;
-	return damon_call(ctx, &repeat_call_control);
+	err = damon_call(ctx, &repeat_call_control);
+	if (err) {
+		damon_stop(&ctx, 1);
+		damon_destroy_ctx(ctx);
+	}
+	return err;
 }
 
 static void damon_sample_wsse_stop(void)
_

Patches currently in -mm which might be from sj@kernel.org are

mm-damon-sysfs-schemes-fix-dir-put-orders-in-access_pattern_add_dirs.patch
mm-damon-sysfs-schemes-put-stats-for-scheme_add_dirs-internal-error.patch
mm-damon-ops-common-handle-extreme-intervals-in-damon_hot_score.patch
maintainers-s-seongjae-sj.patch
samples-damon-wsse-handle-damon_start-failure.patch
samples-damon-prcl-handle-damon_start-failure.patch
samples-damon-mtier-handle-damon_start-failure.patch
samples-damon-mtier-handle-damon_stop-failure.patch
samples-damon-wsse-stop-and-free-damon-ctx-when-damon_call-fails.patch
samples-damon-prcl-stop-and-free-damon-ctx-when-damon_call-fails.patch


