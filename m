Return-Path: <stable+bounces-233423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGWnI6n402k4ogcAu9opvQ
	(envelope-from <stable+bounces-233423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:17:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 254033A61BD
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEA29302BA5B
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 18:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870B2390218;
	Mon,  6 Apr 2026 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N1OTd5v1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4EC38B151;
	Mon,  6 Apr 2026 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499262; cv=none; b=dyTMyDYDFFcQPUOg0T4pPKwn0336ZI7NsFLk6FGTr1PU1pi0gR/G63ZbbjSCIptes86HhWuK2p2sI221Ee21gy2s/m2KzLIRQ/7HctjrMurSScKjZTjHCUs/PIJYww0UfRYYRrjLbHdy1qPvTgWAuaGjdlzXYwXf+y1HkkPcbXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499262; c=relaxed/simple;
	bh=Nzov9D3KUFERDV94cNfhdDQ1/usjHodFdjqQ5c2sAk0=;
	h=Date:To:From:Subject:Message-Id; b=AqSyhIrZjQO+DCR6N8mormN57UzLgXQgudUxdqeZrvxsGx1i8ymiad5XlT5urmb66fbRnxiKaI046XB1WbrEx+0T13PX3ivUbDh/YapVCwWCecKbM21VQB5L19asDubXLzVyvl79kActCaovD3coi5daMUXfa82RXllD2h5yw0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N1OTd5v1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF770C4CEF7;
	Mon,  6 Apr 2026 18:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775499262;
	bh=Nzov9D3KUFERDV94cNfhdDQ1/usjHodFdjqQ5c2sAk0=;
	h=Date:To:From:Subject:From;
	b=N1OTd5v15WJF1zxv4JkrB8iM1VhpyNDT7Di3F/vqR+gOGkWtEinyJPKetuXu6aILG
	 RKUfUC+UUE6ChYYU2FpWK2GowQgXxKY/4/UX39UCnGuh7liBuG8nE7OgNEal3n54BC
	 rIPnIvW5lsR5LkDVXJFcUrmIL1rtz+wJsjJc/HlM=
Date: Mon, 06 Apr 2026 11:14:21 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,sj@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-damon-sysfs-dealloc-repeat_call_control-if-damon_call-fails.patch removed from -mm tree
Message-Id: <20260406181421.EF770C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233423-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid]
X-Rspamd-Queue-Id: 254033A61BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: mm/damon/sysfs: dealloc repeat_call_control if damon_call() fails
has been removed from the -mm tree.  Its filename was
     mm-damon-sysfs-dealloc-repeat_call_control-if-damon_call-fails.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: SeongJae Park <sj@kernel.org>
Subject: mm/damon/sysfs: dealloc repeat_call_control if damon_call() fails
Date: Thu, 26 Mar 2026 17:32:22 -0700

damon_call() for repeat_call_control of DAMON_SYSFS could fail if somehow
the kdamond is stopped before the damon_call().  It could happen, for
example, when te damon context was made for monitroing of a virtual
address processes, and the process is terminated immediately, before the
damon_call() invocation.  In the case, the dyanmically allocated
repeat_call_control is not deallocated and leaked.

Fix the leak by deallocating the repeat_call_control under the
damon_call() failure.

This issue is discovered by sashiko [1].

Link: https://lkml.kernel.org/r/20260327003224.55752-1-sj@kernel.org
Link: https://lore.kernel.org/20260320020630.962-1-sj@kernel.org [1]
Fixes: 04a06b139ec0 ("mm/damon/sysfs: use dynamically allocated repeat mode damon_call_control")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[6.17+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/sysfs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/damon/sysfs.c~mm-damon-sysfs-dealloc-repeat_call_control-if-damon_call-fails
+++ a/mm/damon/sysfs.c
@@ -1670,7 +1670,8 @@ static int damon_sysfs_turn_damon_on(str
 	repeat_call_control->data = kdamond;
 	repeat_call_control->repeat = true;
 	repeat_call_control->dealloc_on_cancel = true;
-	damon_call(ctx, repeat_call_control);
+	if (damon_call(ctx, repeat_call_control))
+		kfree(repeat_call_control);
 	return err;
 }
 
_

Patches currently in -mm which might be from sj@kernel.org are

mm-damon-core-fix-damon_call-vs-kdamond_fn-exit-race.patch
mm-damon-core-fix-damos_walk-vs-kdamond_fn-exit-race.patch
mm-damon-core-validate-damos_quota_goal-nid-for-node_mem_usedfree_bp.patch
mm-damon-core-validate-damos_quota_goal-nid-for-node_memcg_usedfree_bp.patch
mm-damon-core-use-time_in_range_open-for-damos-quota-window-start.patch
docs-admin-guide-mm-damon-reclaim-warn-commit_inputs-vs-param-updates-race.patch
docs-admin-guide-mm-damon-lru_sort-warn-commit_inputs-vs-param-updates-race.patch


