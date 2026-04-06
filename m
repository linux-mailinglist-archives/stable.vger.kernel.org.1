Return-Path: <stable+bounces-233422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Po+FaH402k4ogcAu9opvQ
	(envelope-from <stable+bounces-233422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:17:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FFB3A61B6
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 20:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 262543029246
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 18:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49946390234;
	Mon,  6 Apr 2026 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rRo7nWra"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4AA2989B5;
	Mon,  6 Apr 2026 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499261; cv=none; b=Enwbqd1ygJ3bgj9uDblT3BKfRkO/DYr354tOvgKmUW1eK/ebBs8TsBB9lkYEStG/EiOiYFoAE5BUP2seX+74K/ZbaopnLEKoZiuoABJ1B560WMc4V/bzy5DIZYuBskOxgQspRXWRTiv7VkGrjiQRQ2NfYDJkaj8OUh0dKjPC0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499261; c=relaxed/simple;
	bh=QH1Wsyj9Jjeq0aTziZRXd2KAMn23pwsIyk95YpuA5fI=;
	h=Date:To:From:Subject:Message-Id; b=t5jPgXmrezwfPTzXffHf4xxKxenbu9rDQFKOLOwvRKduJm7moi2iGvdx3VkmL0agOEZWx3Qd5lH2bL/qqwtzwAhPyi1oRualsljzFT6S6N6cPaBISaVRONOhSt3PJ14GnpbRLeJEuXUkLSr6ItojEjijBTmNTCgftSJKgejCtEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rRo7nWra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A5CC4CEF7;
	Mon,  6 Apr 2026 18:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775499260;
	bh=QH1Wsyj9Jjeq0aTziZRXd2KAMn23pwsIyk95YpuA5fI=;
	h=Date:To:From:Subject:From;
	b=rRo7nWraWj4W+qSN7scw4AZ6pXMU74Fu6RTwQfdb+VLBOms9xaBD0sRBv4C+Wqbuc
	 vHMDMR7XGLzEW1MNBRXbnJLb4+x006Q4NMPolmbLEqdnd98F//Nn8Gn6rT/qpCzJH7
	 CBhGBIgyCQx5lvtF9pVreVywn5gQ/8TEsuNP35Kg=
Date: Mon, 06 Apr 2026 11:14:20 -0700
To: mm-commits@vger.kernel.org,willy@infradead.org,stable@vger.kernel.org,jack@suse.cz,hch@lst.de,hannes@cmpxchg.org,joannelkoong@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-reinstate-unconditional-writeback-start-in-balance_dirty_pages.patch removed from -mm tree
Message-Id: <20260406181420.A3A5CC4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233422-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,infradead.org,suse.cz,lst.de,cmpxchg.org,gmail.com,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,suse.cz:email,lst.de:email,infradead.org:email,cmpxchg.org:email]
X-Rspamd-Queue-Id: A5FFB3A61B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: mm: reinstate unconditional writeback start in balance_dirty_pages()
has been removed from the -mm tree.  Its filename was
     mm-reinstate-unconditional-writeback-start-in-balance_dirty_pages.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Joanne Koong <joannelkoong@gmail.com>
Subject: mm: reinstate unconditional writeback start in balance_dirty_pages()
Date: Thu, 26 Mar 2026 14:51:27 -0700

Commit 64dd89ae01f2 ("mm/block/fs: remove laptop_mode") removed this
unconditional writeback start from balance_dirty_pages():

       if (unlikely(!writeback_in_progress(wb)))
	       wb_start_background_writeback(wb);

This logic needs to be reinstated to prevent performance regressions for
strictlimited BDIs and memcg setups.  The problem occurs because:

a) For strictlimited BDIs, throttling is calculated using per-wb
   thresholds.  The per-wb threshold can be exceeded even when the global
   dirty threshold was not exceeded (nr_dirty < gdtc->bg_thresh)

b) For memcg-based throttling, memcg uses its own dirty count /
   thresholds and can trigger throttling even when the global threshold
   isn't exceeded

Without the unconditional writeback start, IO is throttled as it waits for
dirty pages to be written back but there is no writeback running.  This
leads to severe stalls.  On fuse, buffered write performance dropped from
1400 MiB/s to 2000 KiB/s.

Reinstate the unconditional writeback start so that writeback is
guaranteed to be running whenever IO needs to be throttled.

Link: https://lkml.kernel.org/r/20260326215127.3857682-2-joannelkoong@gmail.com
Fixes: 64dd89ae01f2 ("mm/block/fs: remove laptop_mode")
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/page-writeback.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/mm/page-writeback.c~mm-reinstate-unconditional-writeback-start-in-balance_dirty_pages
+++ a/mm/page-writeback.c
@@ -1858,6 +1858,27 @@ free_running:
 			break;
 		}
 
+		/*
+		 * Unconditionally start background writeback if it's not
+		 * already in progress. We need to do this because the global
+		 * dirty threshold check above (nr_dirty > gdtc->bg_thresh)
+		 * doesn't account for these cases:
+		 *
+		 * a) strictlimit BDIs: throttling is calculated using per-wb
+		 * thresholds. The per-wb threshold can be exceeded even when
+		 * nr_dirty < gdtc->bg_thresh
+		 *
+		 * b) memcg-based throttling: memcg uses its own dirty count and
+		 * thresholds and can trigger throttling even when global
+		 * nr_dirty < gdtc->bg_thresh
+		 *
+		 * Writeback needs to be started else the writer stalls in the
+		 * throttle loop waiting for dirty pages to be written back
+		 * while no writeback is running.
+		 */
+		if (unlikely(!writeback_in_progress(wb)))
+			wb_start_background_writeback(wb);
+
 		mem_cgroup_flush_foreign(wb);
 
 		/*
_

Patches currently in -mm which might be from joannelkoong@gmail.com are

mm-start-background-writeback-based-on-per-wb-threshold-for-strictlimit-bdis.patch


