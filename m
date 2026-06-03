Return-Path: <stable+bounces-260210-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qHxGFEq5IGq17AAAu9opvQ
	(envelope-from <stable+bounces-260210-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 01:31:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9123463BDD8
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 01:31:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=clZ+eL84;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260210-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260210-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96DB3301AD35
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 23:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB994D90D2;
	Wed,  3 Jun 2026 23:26:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BEF4DC54D;
	Wed,  3 Jun 2026 23:26:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780529190; cv=none; b=agOC55pTNGI187E7x8yX9RN4uRqvfjFK0MOAq/EqyEZknPJpz8wP0DU93+EbGfq3ZYfQlYxdZpu8JOVNJXt9eXbFniZ/QOHHFKUQ0ipszAe1mFa+zG5Z739MkQsSe8tFMK5lri/fDw4oWDsZYgfZ5x6ksDy4Gc0cvsiU3lqfQAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780529190; c=relaxed/simple;
	bh=Gxwv9TgPVAhnXWlR2ogghjW91kpIEvJV11T6qz6muls=;
	h=Date:To:From:Subject:Message-Id; b=XCHRkc8EY4A+w0V32MtQ5BDQ5LSvbe9LxWuP5BHDrpx1Ag+QLPYmMflTYrAUNaIGtwgsnGD1C+mQM5UwS9cRupVNwPr0LP8afTr9ui+WIt3hs4sWvOXUILZ3FIVlibxdowX5DJvt0u4OGMu+WFVwYA0QxjCzm3jHWRzvcaFqj0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=clZ+eL84; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2F31F00893;
	Wed,  3 Jun 2026 23:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780529189;
	bh=Dsd8h/jqjqcUnSgc2eofCLeQQWDPWAFlPKpEmI+2dFE=;
	h=Date:To:From:Subject;
	b=clZ+eL847iRETL/H2puUVvtXj4zCs4Fbs0hJtDUUKWxLtfhQCHaSxqdv31A1nZf8W
	 Yvfq/VCS4IXerXpebIxQz2LVB49Wf8xXOP6QeXqDovyWKsDFZWMgrtXg81GTcaOB5P
	 Aq1R/Me/3t3bkGlHh9DT0YhUwV69SDpkgCXqckUI=
Date: Wed, 03 Jun 2026 16:26:28 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,sj@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-damonn-lru_sort-handle-ctx-allocation-failure.patch removed from -mm tree
Message-Id: <20260603232628.DB2F31F00893@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260210-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:sj@kernel.org,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,linux-foundation.org:dkim,linux-foundation.org:from_mime,linux-foundation.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9123463BDD8


The quilt patch titled
     Subject: mm/damon/lru_sort: handle ctx allocation failure
has been removed from the -mm tree.  Its filename was
     mm-damonn-lru_sort-handle-ctx-allocation-failure.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: SeongJae Park <sj@kernel.org>
Subject: mm/damon/lru_sort: handle ctx allocation failure
Date: Thu, 28 May 2026 17:01:03 -0700

DAMON_LRU_SORT allocates the damon_ctx object for its kdamond in its init
function.  damon_lru_sort_enabled_store() wrongly assumes the allocation
will always succeed once tried.  If the damon_ctx allocation was failed,
therefore, code execution reaches to damon_commit_ctx() while 'ctx' is
NULL.  As a result, it dereferences the NULL 'ctx' pointer.  Avoid the
NULL dereference by returning -ENOMEM if 'ctx' is NULL.

Link: https://lore.kernel.org/20260529000104.7006-3-sj@kernel.org
Fixes: c4a8e662c839 ("mm/damon/lru_sort: use damon_initialized()")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/lru_sort.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/mm/damon/lru_sort.c~mm-damonn-lru_sort-handle-ctx-allocation-failure
+++ a/mm/damon/lru_sort.c
@@ -437,6 +437,10 @@ static int damon_lru_sort_enabled_store(
 	if (!damon_initialized())
 		return 0;
 
+	/* damon_modules_new_paddr_ctx_target() in the init function failed. */
+	if (!ctx)
+		return -ENOMEM;
+
 	return damon_lru_sort_turn(enabled);
 }
 
_

Patches currently in -mm which might be from sj@kernel.org are

maintainers-add-testing-abi-documents-for-mm.patch


