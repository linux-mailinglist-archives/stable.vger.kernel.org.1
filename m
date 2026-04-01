Return-Path: <stable+bounces-232649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO81FM+DzGlXTgYAu9opvQ
	(envelope-from <stable+bounces-232649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 04:32:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E6A373E8A
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 04:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 056A6304C95D
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 02:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC71A3321A1;
	Wed,  1 Apr 2026 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F2+GeXx+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237F2361DC3;
	Wed,  1 Apr 2026 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775010698; cv=none; b=k0jWuAjEaSi1K943aLkzomLuuj6/UJlGQ0s5axrd4VjS/o1CoPz94oc/bzpa5Afa0ZUiGDIlWjxqxjoyy5OzKHRGA7y3kGV7/XLozFwLJu8JzPoHRXxtEdAA/vJJ5wi1DjQHeq6S88IfoQNBveDys5nC/6uN6Z6OTjm9ckoF3gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775010698; c=relaxed/simple;
	bh=mVbnR9Ib8gJAM8yCeuJRFr5yzVy4XJITjtNw0S1LcBU=;
	h=Date:To:From:Subject:Message-Id; b=C9i7qbTABWKvi4f80J3Wdu8VAm9rWaCLKRFa5vOipQWvmNE2gDrosvo31qzaZpbumJQsSEeSYIG6sVhvJgj8+kvrx/lD5zMlGavaO7JWR7v+Ndw7GJFyz+uiPFDmw0aGUmRPnZy+VHzhKF86vHyr9rDs56VVupQWhW5LoUVpQoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F2+GeXx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7B4C19423;
	Wed,  1 Apr 2026 02:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775010696;
	bh=mVbnR9Ib8gJAM8yCeuJRFr5yzVy4XJITjtNw0S1LcBU=;
	h=Date:To:From:Subject:From;
	b=F2+GeXx+t37EPFXTV0dE74P0IRcHnC0BqGBYG49ye5pyonXEgkEIulgyPTVGYkxRG
	 rI0WVqrpZWouHlWNGGbTmPofw1aULdFnwucI1PEhNNKzeZRppXcGrjnxo6jgScuce+
	 fMIto36IDJEh3+G8aCUCHUHO1OAoWVxLILXUi3A4=
Date: Tue, 31 Mar 2026 19:31:36 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,sj@kernel.org,liuyun01@kylinos.cn,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-damon-stat-fix-memory-leak-on-damon_start-failure-in-damon_stat_start.patch added to mm-hotfixes-unstable branch
Message-Id: <20260401023136.AB7B4C19423@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232649-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: E2E6A373E8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch titled
     Subject: mm/damon/stat: fix memory leak on damon_start() failure in damon_stat_start()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-damon-stat-fix-memory-leak-on-damon_start-failure-in-damon_stat_start.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-damon-stat-fix-memory-leak-on-damon_start-failure-in-damon_stat_start.patch

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
From: Jackie Liu <liuyun01@kylinos.cn>
Subject: mm/damon/stat: fix memory leak on damon_start() failure in damon_stat_start()
Date: Tue, 31 Mar 2026 18:15:53 +0800

Destroy the DAMON context and reset the global pointer when damon_start()
fails.  Otherwise, the context allocated by damon_stat_build_ctx() is
leaked, and the stale damon_stat_context pointer will be overwritten on
the next enable attempt, making the old allocation permanently
unreachable.

Link: https://lkml.kernel.org/r/20260331101553.88422-1-liu.yun@linux.dev
Fixes: 369c415e6073 ("mm/damon: introduce DAMON_STAT module")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/stat.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/mm/damon/stat.c~mm-damon-stat-fix-memory-leak-on-damon_start-failure-in-damon_stat_start
+++ a/mm/damon/stat.c
@@ -249,8 +249,11 @@ static int damon_stat_start(void)
 	if (!damon_stat_context)
 		return -ENOMEM;
 	err = damon_start(&damon_stat_context, 1, true);
-	if (err)
+	if (err) {
+		damon_destroy_ctx(damon_stat_context);
+		damon_stat_context = NULL;
 		return err;
+	}
 
 	damon_stat_last_refresh_jiffies = jiffies;
 	call_control.data = damon_stat_context;
_

Patches currently in -mm which might be from liuyun01@kylinos.cn are

mm-damon-stat-fix-memory-leak-on-damon_start-failure-in-damon_stat_start.patch
mm-mempolicy-fix-memory-leak-in-weighted_interleave_auto_store.patch


