Return-Path: <stable+bounces-249192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKLdM0+0Cmpx5wQAu9opvQ
	(envelope-from <stable+bounces-249192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 08:40:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F01AA566D23
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 08:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C760300AB1B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 06:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6105C386C30;
	Mon, 18 May 2026 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="t6lho3Um"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EE232A3EC;
	Mon, 18 May 2026 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086242; cv=none; b=nAlRKWQHJj9vxeSBIuxkONWv5mXamRAfZIbdIh6krRM1xSsZD64xWfRd5r3vlvmtaG8T5UTbMAKOIV+0PC6m72wjV37j1vJI8ZrzkkkeuWtboqcuFFOa1loPI9/9szUJ1LlNnZkiVvvC1l8fIMPRtrqZjmjrAKInUov3+ZuIY04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086242; c=relaxed/simple;
	bh=yQIbVnCjhAuXcMBGfVGIHYdxNObzjctBtEnLOIjQBZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CYEpXtVM6MYzGqJriF33zDZl+VjgOIzPqrOv423myxjlPKRSkBNieRm5sn3im569+A4CuSOVqxBD9cctuBVJr10EsTmrXVUn66U7smyggMLuo8UZYk4y4VsFWGQfEiidCuqpO1Z6GX2nE4rIO+3gK+M8LyfFSIiGV5t4Og1IdkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=t6lho3Um; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 260C745BD;
	Sun, 17 May 2026 23:37:11 -0700 (PDT)
Received: from a080796.blr.arm.com (a080796.arm.com [10.164.21.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ABCAD3F85F;
	Sun, 17 May 2026 23:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779086236; bh=yQIbVnCjhAuXcMBGfVGIHYdxNObzjctBtEnLOIjQBZQ=;
	h=From:To:Cc:Subject:Date:From;
	b=t6lho3UmNLB5Cm7wXq1KfUS25waa1wm1w6iIg3gs5tcZD9vZrCzGj2pGb9GHydwwt
	 UP7Fn+rcxcfuqkFXoTiKefdP5RtlpKm0efarKCueLZfXKF4d83qeyGcfWLfI+8UUeF
	 sy6Jal5jsHiq0IHpP7D8fKztoqyImnje7LS/ewfU=
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org
Cc: Dev Jain <dev.jain@arm.com>,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	baohua@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH] mm/rmap: initialize nr_pages to 1 at loop start in try_to_unmap_one
Date: Mon, 18 May 2026 12:06:56 +0530
Message-Id: <20260518063656.3721056-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F01AA566D23
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249192-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[dev.jain@arm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email,arm.com:mid,arm.com:dkim]
X-Rspamd-Action: no action

Initialize nr_pages to 1 at the start of each loop iteration, like
folio_referenced_one() does.

Without this, nr_pages computed by a previous folio_unmap_pte_batch() call
can be reused on a later iteration that does not run
folio_unmap_pte_batch() again.

mmap a 64K large folio with MAP_ANONYMOUS | MAP_DROPPABLE, then call
madvise(MADV_FREE), then make the last page device-exclusive via
HMM_DMIRROR_EXCLUSIVE.

Trigger node reclaim through sysfs. Now, in try_to_unmap_one(), we will
first clear the first 15 out of 16 entries mapping the lazyfree folio.
This will set nr_pages to 15. In the next pvmw walk, this nr_pages gets
reused on a device-exclusive pte, thus potentially corrupting folio
refcount/mapcount.

At the moment, I have a userspace program which can make the kernel spit
out a trace, but the blow up is in folio_referenced_one(), because there
are existing bugs in the interaction between device-private and rmap
(which too I am investigating). I did a one liner kernel change to avoid
going into folio_referenced_one(), and the kernel blows up at
folio_remove_rmap_ptes in try_to_unmap_one which is what I wanted. 

Note that the bug is there not since file folio batching but lazyfree folio
batching, since device-exclusive only works for anonymous folios.

Userspace visible effect is simply kernel crashing somewhere due to
refcount/mapcount corruption.

Fixes: 354dffd29575 ("mm: support batched unmap for lazyfree large folios during reclamation")
Cc: stable@vger.kernel.org
Signed-off-by: Dev Jain <dev.jain@arm.com>
Acked-by: Barry Song <baohua@kernel.org>
---
Applies on mm-unstable. This patch was part of
https://lore.kernel.org/all/20260506094504.2588857-2-dev.jain@arm.com/

 mm/rmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index fb3c351f8c45..1c77d5dc06e9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2030,6 +2030,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	mmu_notifier_invalidate_range_start(&range);
 
 	while (page_vma_mapped_walk(&pvmw)) {
+		nr_pages = 1;
+
 		/*
 		 * If the folio is in an mlock()d vma, we must not swap it out.
 		 */
-- 
2.43.0


