Return-Path: <stable+bounces-267775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iFjDK6lrOWqgsQcAu9opvQ
	(envelope-from <stable+bounces-267775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 19:06:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 217486B1602
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 19:06:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=cgQnItSb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267775-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267775-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF8AF30067BA
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 17:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDE133F594;
	Mon, 22 Jun 2026 17:05:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1672B31326A;
	Mon, 22 Jun 2026 17:05:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147933; cv=none; b=EaAi0k+XgKKyzQroZYuhAn07bxBJQtLhGbfnkmgOTQ3as3XoEwOoInxrl1jR4e4iSFmmwMmqgWOfd6V3q3ArKcllknpsOJk5N5v/lgnkS9q54Npu+KnvPVMJAnLfLgn+n0bJ2OQygEvbvnJsTGfygP+yDmeT79xNbmM4tM2iUwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147933; c=relaxed/simple;
	bh=jqwYCpLupMQPrXMQoJMwt33kyxypwk6469wvnGadTE8=;
	h=Date:To:From:Subject:Message-Id; b=u+z1Ond3DqbivuWBdGkKZACc4fGE2hjv96t2WrvF47iRddP7ruqFA98p6slRr6tpVqSpwIEF8Y/y2aByyhV9PAXgfKoSGIsq7+l19GNnWAXgiZp/qDSXOwKX8Nl3MLuPGN7JWQDTbUfp+uk6sPue9r6FcoUujdIlr8T/tWFaMgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cgQnItSb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D891F000E9;
	Mon, 22 Jun 2026 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782147931;
	bh=pOrVFAm99gvh4cWAzHDQ8dVva5Kqq1rhR8W056gB/xU=;
	h=Date:To:From:Subject;
	b=cgQnItSb13MKBJ1VQ7dKzA30h4FMoHxblpLxOn0DWqJNEOqLXM2roEb5U4BuKgifJ
	 CQygJBOXCud35IUphDTC70Qshco5UsaULDGPzJ4oTCgP0POL/mb5xYeeE1Mmd3DEnd
	 WAdlnqX3M2H2fkQ+f03PqUKZyjjt/orr8wouE/5c=
Date: Mon, 22 Jun 2026 10:05:31 -0700
To: mm-commits@vger.kernel.org,vbabka@kernel.org,surenb@google.com,stable@vger.kernel.org,mhocko@suse.com,jiaqiyan@google.com,jackmanb@google.com,hannes@cmpxchg.org,baolin.wang@linux.alibaba.com,ziy@nvidia.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-compaction-handle-free_pages_prepare-properly-in-compaction_free.patch added to mm-hotfixes-unstable branch
Message-Id: <20260622170531.92D891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-267775-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:vbabka@kernel.org,m:surenb@google.com,m:stable@vger.kernel.org,m:mhocko@suse.com,m:jiaqiyan@google.com,m:jackmanb@google.com,m:hannes@cmpxchg.org,m:baolin.wang@linux.alibaba.com,m:ziy@nvidia.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,vger.kernel.org:from_smtp,suse.com:email,nvidia.com:email,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email,linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 217486B1602


The patch titled
     Subject: mm/compaction: handle free_pages_prepare() properly in compaction_free()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-compaction-handle-free_pages_prepare-properly-in-compaction_free.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-compaction-handle-free_pages_prepare-properly-in-compaction_free.patch

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
From: Zi Yan <ziy@nvidia.com>
Subject: mm/compaction: handle free_pages_prepare() properly in compaction_free()
Date: Mon, 22 Jun 2026 11:30:42 -0400

free_pages_prepare() can fail but compaction_free() does not handle the
failure case.  Failed pages should not be added back to cc->freepages for
future use, since they can be either PageHWPoison or free_page_is_bad()
and might cause data corruption.

Link: https://lore.kernel.org/20260622-handle_free_pages_prepare_in_compaction_free-v1-1-fcf3b14abcf7@nvidia.com
Fixes: 733aea0b3a7bb ("mm/compaction: add support for >0 order folio memory compaction.")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Jiaqi Yan <jiaqiyan@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/compaction.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/mm/compaction.c~mm-compaction-handle-free_pages_prepare-properly-in-compaction_free
+++ a/mm/compaction.c
@@ -1875,15 +1875,14 @@ static void compaction_free(struct folio
 	int order = folio_order(dst);
 	struct page *page = &dst->page;
 
-	if (folio_put_testzero(dst)) {
-		free_pages_prepare(page, order);
+	if (folio_put_testzero(dst) && free_pages_prepare(page, order)) {
 		list_add(&dst->lru, &cc->freepages[order]);
 		cc->nr_freepages += 1 << order;
 	}
 	cc->nr_migratepages += 1 << order;
 	/*
-	 * someone else has referenced the page, we cannot take it back to our
-	 * free list.
+	 * someone else has referenced the page or free_pages_prepare() fails,
+	 * we cannot take it back to our free list.
 	 */
 }
 
_

Patches currently in -mm which might be from ziy@nvidia.com are

mm-compaction-handle-free_pages_prepare-properly-in-compaction_free.patch


