Return-Path: <stable+bounces-95430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7BC9D8D51
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 21:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C73AB245D8
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 20:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78AF1B6D0F;
	Mon, 25 Nov 2024 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OB20eP9T"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317652B9BF
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732565850; cv=none; b=EAyWhgZCGz5BtaOJzNQ6I70S0YUNsSAjqpti5HSOgL3z4AeCjCvhBQYNV7HIgNAW7BjowKOrwntf3LmoD/hXw/piEIIQeIgQp1DzwcGUxxboOpfmDmj22pYWSknNGSpVoPq+kQsk5lPIuBwZsh8Aecp2HEZW/UR9Igj/NPpYryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732565850; c=relaxed/simple;
	bh=qX6cviK+bhnrVMtT6rih8k4Me+3iUGupXCuakZtorJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4fxQj+z173/CIlKc4kseCz0pvrPp2bKiP7HaIaKv7RalloQ6FoSNZT6SEoZLdjzYaqw4Y73fXXv4vc+kpuw6xcqmAK0WDgjIaL3ZmsRcYRhNSKMCqaqtRkasJ6xxoU9V/34k5u3p/s4oYQf3/lQX1k3NDN0qOK8WxE9tOp9OvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OB20eP9T; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=CHHt0O7rL6AlsO2cAZIVKebUXT6Q6A4nPNqwf9n4YgQ=; b=OB20eP9TLDKrc23czqVlgHa227
	E7oMY9q7avJj/oSwF5aNqmMlncl5r6ftyptNoLcekbsDMahmjnz2woVFGTlUcMNYjdCIu5yVP5D6j
	a4NxaKnN/0MOXgw2CD8X2KViPEUrzd7t++994qcWfjQhC66zTSMMHwkaqLWfAH8pNhnKIbUFVC2MM
	C4KaD5gbA7XqCV8wPJEPH4sXiOZcfQRZADbaETfiIFesToFdonety/tQRMKksIEQBPfQc4t3V3kcD
	D9S8miBA4DrGsNblPNU3nThhCQ2pb6vfsFhsAN9kR84i7yVlWESw0a9o11HJ082gjsBYm99rTq2gA
	rSCKDLgw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFfWM-0000000CQsy-3kcc;
	Mon, 25 Nov 2024 20:17:22 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm: Open-code PageTail in folio_flags() and const_folio_flags()
Date: Mon, 25 Nov 2024 20:17:18 +0000
Message-ID: <20241125201721.2963278-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is unsafe to call PageTail() in dump_page() as page_is_fake_head()
will almost certainly return true when called on a head page that
is copied to the stack.  That will cause the VM_BUG_ON_PGFLAGS() in
const_folio_flags() to trigger when it shouldn't.  Fortunately, we don't
need to call PageTail() here; it's fine to have a pointer to a virtual
alias of the page's flag word rather than the real page's flag word.

Fixes: fae7d834c43c (mm: add __dump_folio())
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: stable@vger.kernel.org
---
 include/linux/page-flags.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 2220bfec278e..cf46ac720802 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -306,7 +306,7 @@ static const unsigned long *const_folio_flags(const struct folio *folio,
 {
 	const struct page *page = &folio->page;
 
-	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+	VM_BUG_ON_PGFLAGS(page->compound_head & 1, page);
 	VM_BUG_ON_PGFLAGS(n > 0 && !test_bit(PG_head, &page->flags), page);
 	return &page[n].flags;
 }
@@ -315,7 +315,7 @@ static unsigned long *folio_flags(struct folio *folio, unsigned n)
 {
 	struct page *page = &folio->page;
 
-	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+	VM_BUG_ON_PGFLAGS(page->compound_head & 1, page);
 	VM_BUG_ON_PGFLAGS(n > 0 && !test_bit(PG_head, &page->flags), page);
 	return &page[n].flags;
 }
-- 
2.45.2


