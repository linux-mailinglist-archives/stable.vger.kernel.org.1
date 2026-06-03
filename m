Return-Path: <stable+bounces-260209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N17KBkO5IGq07AAAu9opvQ
	(envelope-from <stable+bounces-260209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 01:31:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9AD63BDD3
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 01:31:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=M0sZbHuV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260209-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260209-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93BFF30177B5
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 23:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C4F4DC551;
	Wed,  3 Jun 2026 23:26:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278674DB555;
	Wed,  3 Jun 2026 23:26:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780529189; cv=none; b=JlqzVrQtnZ4NOZYAzxV8nnchpCmtR72qs1LEKO3XSorDmeqoBVbeOKgyu8UYVrnqtXnhILaWhenRuPs17RBvqWF2rtB3MOd0/8CFfcZqgzujYJj64ZEdPU5PK89OzBcwgfUcxDr7JbYIDYMYsbiWkU08RVIZsEPJ1HBuLS2Jz/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780529189; c=relaxed/simple;
	bh=t48Y8CpoRFbKCINZu7Ostvx+JbWSdJwVvWqWssYZ/gg=;
	h=Date:To:From:Subject:Message-Id; b=qeqn0e8vNJfZfY3VHI7NEB+APGbUSfOPfRIN3f1sURVdivcwqGLWSR37E2zd6jIrsO83yDDCeR+hNRKeWe20Ky/GgIS0dvBNXNFuQdGspl8mEkr8hXxslc/HdbMsJznBJSKPKfNHuvSNYtSDrP4eljIYf6u5g6mDrR1OCGMKUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M0sZbHuV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58EA1F00898;
	Wed,  3 Jun 2026 23:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780529187;
	bh=/DPvewFVsBE49TIXLZna2iDEFKUls96f/izXs2IvMFk=;
	h=Date:To:From:Subject;
	b=M0sZbHuVPWRsKTHHdqfEjmk8Sdg13IQhvilBelVcZHeSGwIEmc9w/nZvBalN1pg3C
	 yw+72mLEH80QnrVu2pjaNWu1mXu9mhvBK0ctk49XUp76hmDPrlYXXH9AuuGOrWsYFO
	 ES5bTJcW00jlI56F8x0NvTBU5Obd5sozUKqNUqu4=
Date: Wed, 03 Jun 2026 16:26:27 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,sj@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-damon-reclaim-handle-ctx-allocation-failure.patch removed from -mm tree
Message-Id: <20260603232627.B58EA1F00898@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-260209-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux-foundation.org:dkim,linux-foundation.org:from_mime,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D9AD63BDD3


The quilt patch titled
     Subject: mm/damon/reclaim: handle ctx allocation failure
has been removed from the -mm tree.  Its filename was
     mm-damon-reclaim-handle-ctx-allocation-failure.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: SeongJae Park <sj@kernel.org>
Subject: mm/damon/reclaim: handle ctx allocation failure
Date: Thu, 28 May 2026 17:01:02 -0700

Patch series "mm/damon/{reclaim,lru_sort}: handle ctx allocation failures".

DAMON_RECLAIM and DAMON_LRU_SORT could dereference NULL pointers if their
damon_ctx object allocations fail.  The bugs are expected to happen
infrequently because the allocations are arguably too small to fail on
common setups.  But theoretically they are possible and the consequences
are bad.  Fix those.

The issues were discovered [1] by Sashiko.


This patch (of 2):

DAMON_RECLAIM allocates the damon_ctx object for its kdamond in its init
function.  damon_reclaim_enabled_store() wrongly assumes the allocation
will always succeed once tried.  If the damon_ctx allocation was failed,
therefore, code execution reaches to damon_commit_ctx() while 'ctx' is
NULL.  As a result, it dereferences the NULL 'ctx' pointer.  Avoid the
NULL dereference by returning -ENOMEM if 'ctx' is NULL.

Link: https://lore.kernel.org/20260529000104.7006-2-sj@kernel.org
Link: https://lore.kernel.org/20260419014800.877-1-sj@kernel.org [1]
Fixes: 3f7a914ab9a5 ("mm/damon/reclaim: use damon_initialized()")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/reclaim.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/mm/damon/reclaim.c~mm-damon-reclaim-handle-ctx-allocation-failure
+++ a/mm/damon/reclaim.c
@@ -339,6 +339,10 @@ static int damon_reclaim_enabled_store(c
 	if (!damon_initialized())
 		return 0;
 
+	/* damon_modules_new_paddr_ctx_target() in the init function failed. */
+	if (!ctx)
+		return -ENOMEM;
+
 	return damon_reclaim_turn(enabled);
 }
 
_

Patches currently in -mm which might be from sj@kernel.org are

maintainers-add-testing-abi-documents-for-mm.patch


