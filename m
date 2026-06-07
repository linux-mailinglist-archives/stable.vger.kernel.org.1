Return-Path: <stable+bounces-261294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XDW9CuZHJWqtFwIAu9opvQ
	(envelope-from <stable+bounces-261294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:28:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9FD64FAFB
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:28:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=dhdHSdTw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261294-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261294-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B277F301E7C8
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA2C31E832;
	Sun,  7 Jun 2026 10:26:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E26324B31;
	Sun,  7 Jun 2026 10:26:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828001; cv=none; b=mXl0u32HlXY6+utvr1cozSo+LPNKOmrnTYI8OtDtk259Hoz81KvZipH5BjYlvJAeoI+MdGMyOn/UIUTXTciC94N9yW/JDD15LC7MNDc7ytTwU7nBq6V9HuosjsPRmVU7f2VibPMl0tl1WtGOhS/xqKMcSwZw8fyYi23SXHiovxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828001; c=relaxed/simple;
	bh=YWoMHUhNGDNMl+pxdLyGMdd6VdJiAhU8wt7JOcyC43Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXbYb9djDBWrqORqsMeB+8N+0Xl6wYqkhWOmO5M/AlI2aqmuTfLDygymGqxA8S0Fye5cLxY6fAvk7O3H5Q4QL2HogjspMTrsp304v0ufQFqd9M8DPElGzbtendxO9H+8JdE49yu+FTtcYLJV+M09c5Sf9pCt9tIiva3akeU32pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dhdHSdTw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41E11F00893;
	Sun,  7 Jun 2026 10:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828000;
	bh=rxCD/uVHb4elnyIdZGnHoB5ctAXVsiif2uXoPXlwHrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dhdHSdTwn/frk+NU9++4UnLhyW4ba4w9EGytTalL9YD6AyvjJz+iZRFrENIZu570J
	 VFYf9Kf6EUovK3brZ9r9/POAdQiVNdKisUz1We0EfuITWOXg7z5o3ooWKxT4Q2IuOL
	 +cT0yfZxjg6zpmzYJowVzLDQpCYCkBYTT/tBYju4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7.0 143/332] mm/rmap: initialize nr_pages to 1 at loop start in try_to_unmap_one
Date: Sun,  7 Jun 2026 11:58:32 +0200
Message-ID: <20260607095733.350530273@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261294-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:dev.jain@arm.com,m:baohua@kernel.org,m:david@kernel.org,m:ljs@kernel.org,m:anshuman.khandual@arm.com,m:harry@kernel.org,m:jannh@google.com,m:liam@infradead.org,m:riel@surriel.com,m:ryan.roberts@arm.com,m:vbabka@kernel.org,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email,arm.com:email,surriel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE9FD64FAFB

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dev Jain <dev.jain@arm.com>

commit 3f8968e9cbf95d5d87d32218906cab0b9b9eddbe upstream.

Initialize nr_pages to 1 at the start of each loop iteration, like
folio_referenced_one() does.

Without this, nr_pages computed by a previous folio_unmap_pte_batch() call
can be reused on a later iteration that does not run
folio_unmap_pte_batch() again.

mmap a 64K large folio with MAP_ANONYMOUS | MAP_DROPPABLE, then call
madvise(MADV_FREE), then make the last page device-exclusive via
HMM_DMIRROR_EXCLUSIVE.

Trigger node reclaim through sysfs.  Now, in try_to_unmap_one(), we will
first clear the first 15 out of 16 entries mapping the lazyfree folio.
This will set nr_pages to 15.  In the next pvmw walk, this nr_pages gets
reused on a device-exclusive pte, thus potentially corrupting folio
refcount/mapcount.

At the moment, I have a userspace program which can make the kernel spit
out a trace, but the blow up is in folio_referenced_one(), because there
are existing bugs in the interaction between device-private and rmap
(which too I am investigating).  I did a one liner kernel change to avoid
going into folio_referenced_one(), and the kernel blows up at
folio_remove_rmap_ptes in try_to_unmap_one which is what I wanted.

Note that the bug is there not since file folio batching but lazyfree
folio batching, since device-exclusive only works for anonymous folios.

Userspace visible effect is simply kernel crashing somewhere due to
refcount/mapcount corruption.

Link: https://lore.kernel.org/20260518063656.3721056-1-dev.jain@arm.com
Fixes: 354dffd29575 ("mm: support batched unmap for lazyfree large folios during reclamation")
Signed-off-by: Dev Jain <dev.jain@arm.com>
Acked-by: Barry Song <baohua@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Harry Yoo <harry@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/rmap.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2024,6 +2024,8 @@ static bool try_to_unmap_one(struct foli
 	mmu_notifier_invalidate_range_start(&range);
 
 	while (page_vma_mapped_walk(&pvmw)) {
+		nr_pages = 1;
+
 		/*
 		 * If the folio is in an mlock()d vma, we must not swap it out.
 		 */



