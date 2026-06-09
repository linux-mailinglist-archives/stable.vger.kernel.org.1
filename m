Return-Path: <stable+bounces-262156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x9s/Ao9rJ2rDwQIAu9opvQ
	(envelope-from <stable+bounces-262156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 03:25:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB0E65B98B
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 03:25:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=VIt7MqmM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262156-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262156-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB9F630459DA
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 01:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922572FE066;
	Tue,  9 Jun 2026 01:22:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592F12DB794;
	Tue,  9 Jun 2026 01:22:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780968157; cv=none; b=rubfB2sB53/XqU+AJiNJ1j4C8nAx7RrNJEI9/dvwMm5IvlRNpcj9w8laPF6My6loSiNkHDofNhd7xCaZuME0HOobCfwfqReAn0c9MzkjuVXvLTd4xn29mXhUQDkRC2w5t6vaniRXqoQ+79LNZZyEHDMiiHwPYPyngzC9fFRyhEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780968157; c=relaxed/simple;
	bh=9jHkxvXqvVqmtF76HUrlmX37NLwS4sAtU4D1xyzPMxM=;
	h=Date:To:From:Subject:Message-Id; b=gUWgnIlAmKZFg4H/9LBHZOdrdrMN7lvhL+E8ta+MKMUUFpwJJJwrfTHCEGcP8smsQOruusVmUZkADCORS1ce46gkqPDTEdMUI/zzD732DgjnSqNaqtzmVaPin+yspNutEzWCEKts3gG7EjGGRyAiHWijqhnNdzveaBQeZl4iQqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VIt7MqmM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB781F00898;
	Tue,  9 Jun 2026 01:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780968156;
	bh=mGNjz3jIOEOTKnwl/gsIwXqOBM6jqIUel7EaLcItHGw=;
	h=Date:To:From:Subject;
	b=VIt7MqmM45NCpef6GYwDhVe5NlW7mtzk6D9hes5yZDPnxGGJmmtQzVoQV7Ccg9qN6
	 NgXQ63aOyVpABDh3qagkeZ89kHW05xzKLsK++XoA0NdNKpe1gVvHPdTA0Y+dLJAQ/8
	 nWGvndRO6wh1BCacIgKKIga72KU2Ak6VW69FtVkw=
Date: Mon, 08 Jun 2026 18:22:35 -0700
To: mm-commits@vger.kernel.org,vbabka@kernel.org,surenb@google.com,stable@vger.kernel.org,sashiko-bot@kernel.org,rppt@kernel.org,peterx@redhat.com,mhocko@suse.com,ljs@kernel.org,dev.jain@arm.com,david@kernel.org,balbirs@nvidia.com,kas@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-stable] fs-proc-task_mmu-use-huge_page_size-in-pagemap_scan_hugetlb_entry.patch removed from -mm tree
Message-Id: <20260609012236.2BB781F00898@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262156-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:vbabka@kernel.org,m:surenb@google.com,m:stable@vger.kernel.org,m:sashiko-bot@kernel.org,m:rppt@kernel.org,m:peterx@redhat.com,m:mhocko@suse.com,m:ljs@kernel.org,m:dev.jain@arm.com,m:david@kernel.org,m:balbirs@nvidia.com,m:kas@kernel.org,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime,suse.com:email,vger.kernel.org:from_smtp,smtp.kernel.org:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FB0E65B98B


The quilt patch titled
     Subject: fs/proc/task_mmu: use huge_page_size() in pagemap_scan_hugetlb_entry()
has been removed from the -mm tree.  Its filename was
     fs-proc-task_mmu-use-huge_page_size-in-pagemap_scan_hugetlb_entry.patch

This patch was dropped because it was merged into the mm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: fs/proc/task_mmu: use huge_page_size() in pagemap_scan_hugetlb_entry()
Date: Fri, 29 May 2026 18:23:26 +0100

The partial-page check compares against HPAGE_SIZE (PMD_SIZE), which is
wrong for gigantic hugetlb hstates (e.g.  1G).  The walker hands the
callback a huge_page_size()-sized range, never start + HPAGE_SIZE, so the
comparison always declares it partial and aborts the WP.  Compare against
the actual hstate's page size.

Link: https://lore.kernel.org/20260529172331.356655-3-kas@kernel.org
Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/proc/task_mmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/proc/task_mmu.c~fs-proc-task_mmu-use-huge_page_size-in-pagemap_scan_hugetlb_entry
+++ a/fs/proc/task_mmu.c
@@ -2960,7 +2960,7 @@ static int pagemap_scan_hugetlb_entry(pt
 	if (~categories & PAGE_IS_WRITTEN)
 		goto out_unlock;
 
-	if (end != start + HPAGE_SIZE) {
+	if (end != start + huge_page_size(hstate_vma(vma))) {
 		/* Partial HugeTLB page WP isn't possible. */
 		pagemap_scan_backout_range(p, start, end);
 		p->arg.walk_end = start;
_

Patches currently in -mm which might be from kas@kernel.org are



