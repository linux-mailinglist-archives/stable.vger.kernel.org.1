Return-Path: <stable+bounces-233426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHG2J7z402k4ogcAu9opvQ
	(envelope-from <stable+bounces-233426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:17:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0E93A61D2
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE52B30547F8
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 18:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B483909BD;
	Mon,  6 Apr 2026 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XqZnYQpd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B4938F225;
	Mon,  6 Apr 2026 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499266; cv=none; b=sNoOQAhCTb+nFdF6mMuFRShVAIhzbVsgaXll/g6btgLqk97YJ81a9RN7BFcn9eBvl2axova6KDaPlgKWW8Jt9TeetJv3px02SP8wf5tDOylz4GBmMOO3yFZfTJjJV/QJ+UuUSfEEZwSSEq714zleDcnNSla9kMWBR4ZfdJ0uBr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499266; c=relaxed/simple;
	bh=ELqwEKtKuo2HvRhGypY4lanBnc/s6u6+NMS9yriKHqg=;
	h=Date:To:From:Subject:Message-Id; b=htXXzyP4nwTLYE6iI03Yrl6L8fc2qrzDF73Cvp1PQp31NKErg9bPGhI7nnd2NaLS48F6bsRtnIQzeuy9MzQkEstehf/zRHdOztliU8fSB8IXMxRzCuOyU88Eoq90TOgG7rZk4TsyXgGMl8l7mYa2XDhsbraDYXFoA/grobu4jac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XqZnYQpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9D7C4CEF7;
	Mon,  6 Apr 2026 18:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775499266;
	bh=ELqwEKtKuo2HvRhGypY4lanBnc/s6u6+NMS9yriKHqg=;
	h=Date:To:From:Subject:From;
	b=XqZnYQpddXCalyBpReyYGbXZi+UrJwRIPLL7GRFVyWvayg7dC9lnv5KicdJn5sLmj
	 LnebHPVpxSBFunT2/KjC6i11wqp605pTbo4DWQqbmir+0mrWVzbVTlq5SXE986HuZw
	 6NJblU/+JR5w5lYUiavzDqefOr9+ccT2Pj8y9vto=
Date: Mon, 06 Apr 2026 11:14:25 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,sj@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-damon-stat-deallocate-damon_call-failure-leaking-damon_ctx.patch removed from -mm tree
Message-Id: <20260406181426.1A9D7C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [3.84 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233426-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 2B0E93A61D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: mm/damon/stat: deallocate damon_call() failure leaking damon_ctx
has been removed from the -mm tree.  Its filename was
     mm-damon-stat-deallocate-damon_call-failure-leaking-damon_ctx.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: SeongJae Park <sj@kernel.org>
Subject: mm/damon/stat: deallocate damon_call() failure leaking damon_ctx
Date: Thu, 2 Apr 2026 06:44:17 -0700

damon_stat_start() always allocates the module's damon_ctx object
(damon_stat_context).  Meanwhile, if damon_call() in the function fails,
the damon_ctx object is not deallocated.  Hence, if the damon_call() is
failed, and the user writes Y to “enabled” again, the previously
allocated damon_ctx object is leaked.

This cannot simply be fixed by deallocating the damon_ctx object when
damon_call() fails.  That's because damon_call() failure doesn't guarantee
the kdamond main function, which accesses the damon_ctx object, is
completely finished.  In other words, if damon_stat_start() deallocates
the damon_ctx object after damon_call() failure, the not-yet-terminated
kdamond could access the freed memory (use-after-free).

Fix the leak while avoiding the use-after-free by keeping returning
damon_stat_start() without deallocating the damon_ctx object after
damon_call() failure, but deallocating it when the function is invoked
again and the kdamond is completely terminated.  If the kdamond is not yet
terminated, simply return -EAGAIN, as the kdamond will soon be terminated.

The issue was discovered [1] by sashiko.

Link: https://lkml.kernel.org/r/20260402134418.74121-1-sj@kernel.org
Link: https://lore.kernel.org/20260401012428.86694-1-sj@kernel.org [1]
Fixes: 405f61996d9d ("mm/damon/stat: use damon_call() repeat mode instead of damon_callback")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/stat.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/mm/damon/stat.c~mm-damon-stat-deallocate-damon_call-failure-leaking-damon_ctx
+++ a/mm/damon/stat.c
@@ -245,6 +245,12 @@ static int damon_stat_start(void)
 {
 	int err;
 
+	if (damon_stat_context) {
+		if (damon_is_running(damon_stat_context))
+			return -EAGAIN;
+		damon_destroy_ctx(damon_stat_context);
+	}
+
 	damon_stat_context = damon_stat_build_ctx();
 	if (!damon_stat_context)
 		return -ENOMEM;
@@ -261,6 +267,7 @@ static void damon_stat_stop(void)
 {
 	damon_stop(&damon_stat_context, 1);
 	damon_destroy_ctx(damon_stat_context);
+	damon_stat_context = NULL;
 }
 
 static int damon_stat_enabled_store(
_

Patches currently in -mm which might be from sj@kernel.org are

mm-damon-core-fix-damon_call-vs-kdamond_fn-exit-race.patch
mm-damon-core-fix-damos_walk-vs-kdamond_fn-exit-race.patch
mm-damon-core-validate-damos_quota_goal-nid-for-node_mem_usedfree_bp.patch
mm-damon-core-validate-damos_quota_goal-nid-for-node_memcg_usedfree_bp.patch
mm-damon-core-use-time_in_range_open-for-damos-quota-window-start.patch
docs-admin-guide-mm-damon-reclaim-warn-commit_inputs-vs-param-updates-race.patch
docs-admin-guide-mm-damon-lru_sort-warn-commit_inputs-vs-param-updates-race.patch


