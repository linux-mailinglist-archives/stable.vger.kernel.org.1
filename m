Return-Path: <stable+bounces-89888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE6A9BD284
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6E91C219E3
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A461D89F3;
	Tue,  5 Nov 2024 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tpH+KaHO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0D717C7CE
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824671; cv=none; b=q8Cp6hHa1/PeWlr8BsozOyFCgkLWVKb6ypagbu2sdyKMMzO5osuJRUw3N2lutTgx4y2oak80DInVLar9Nm7aDI0/lx3zt++FPkXmvb5zTkx+vZiJ1LCmu045HhTzzwv3Y9I7FZDklfNbn+6MSol16bQAPBYHn3L33ZpbRTtNNhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824671; c=relaxed/simple;
	bh=tkNABRAnUSJHDOsH6KR9qu5hhsSYQ898jeL2mWKRexg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LKaVZvgaMQN8RyTzdOYfE620ByDmlOFu0PWe6UkP2dACKAr/HJ56Dz6SyD4jGZMKYVn24QeEmtVXP9ldWyY/2I4+N2/DNFocWBhIFJQtvj1x0uIGanh1emzYz7Fqqa/Rl/Bl/ZVtHjm2eHXdBiBNAQ4sDO+aTJ2/QREm/Q0ziXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tpH+KaHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E29C4CECF;
	Tue,  5 Nov 2024 16:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730824670;
	bh=tkNABRAnUSJHDOsH6KR9qu5hhsSYQ898jeL2mWKRexg=;
	h=Subject:To:Cc:From:Date:From;
	b=tpH+KaHOWrOJRnVWZBK/ViNe7FTbOjxq3X4AysDRPsjxmHgpRz2crLn6IEMduxhvk
	 oMjt/d6BmMfLokrKaa+Ma/L57oWYANbNabpgTGbXjCtR/ATKOnfcrLo/YQQ7TLSELd
	 LMqHwg0iHO98PiOBJpPTWLAxVBgyvJHbGNH5Cf9s=
Subject: FAILED: patch "[PATCH] mm: allow set/clear page_type again" failed to apply to 6.6-stable tree
To: yuzhao@google.com,akpm@linux-foundation.org,muchun.song@linux.dev,stable@vger.kernel.org,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 05 Nov 2024 17:37:25 +0100
Message-ID: <2024110524-patience-rice-79e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9d08ec41a0645283d79a2e642205d488feaceacf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110524-patience-rice-79e2@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9d08ec41a0645283d79a2e642205d488feaceacf Mon Sep 17 00:00:00 2001
From: Yu Zhao <yuzhao@google.com>
Date: Sat, 19 Oct 2024 22:22:12 -0600
Subject: [PATCH] mm: allow set/clear page_type again

Some page flags (page->flags) were converted to page types
(page->page_types).  A recent example is PG_hugetlb.

From the exclusive writer's perspective, e.g., a thread doing
__folio_set_hugetlb(), there is a difference between the page flag and
type APIs: the former allows the same non-atomic operation to be repeated
whereas the latter does not.  For example, calling __folio_set_hugetlb()
twice triggers VM_BUG_ON_FOLIO(), since the second call expects the type
(PG_hugetlb) not to be set previously.

Using add_hugetlb_folio() as an example, it calls __folio_set_hugetlb() in
the following error-handling path.  And when that happens, it triggers the
aforementioned VM_BUG_ON_FOLIO().

  if (folio_test_hugetlb(folio)) {
    rc = hugetlb_vmemmap_restore_folio(h, folio);
    if (rc) {
      spin_lock_irq(&hugetlb_lock);
      add_hugetlb_folio(h, folio, false);
      ...

It is possible to make hugeTLB comply with the new requirements from the
page type API.  However, a straightforward fix would be to just allow the
same page type to be set or cleared again inside the API, to avoid any
changes to its callers.

Link: https://lkml.kernel.org/r/20241020042212.296781-1-yuzhao@google.com
Fixes: d99e3140a4d3 ("mm: turn folio_test_hugetlb into a PageType")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1b3a76710487..cc839e4365c1 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -975,12 +975,16 @@ static __always_inline bool folio_test_##fname(const struct folio *folio) \
 }									\
 static __always_inline void __folio_set_##fname(struct folio *folio)	\
 {									\
+	if (folio_test_##fname(folio))					\
+		return;							\
 	VM_BUG_ON_FOLIO(data_race(folio->page.page_type) != UINT_MAX,	\
 			folio);						\
 	folio->page.page_type = (unsigned int)PGTY_##lname << 24;	\
 }									\
 static __always_inline void __folio_clear_##fname(struct folio *folio)	\
 {									\
+	if (folio->page.page_type == UINT_MAX)				\
+		return;							\
 	VM_BUG_ON_FOLIO(!folio_test_##fname(folio), folio);		\
 	folio->page.page_type = UINT_MAX;				\
 }
@@ -993,11 +997,15 @@ static __always_inline int Page##uname(const struct page *page)		\
 }									\
 static __always_inline void __SetPage##uname(struct page *page)		\
 {									\
+	if (Page##uname(page))						\
+		return;							\
 	VM_BUG_ON_PAGE(data_race(page->page_type) != UINT_MAX, page);	\
 	page->page_type = (unsigned int)PGTY_##lname << 24;		\
 }									\
 static __always_inline void __ClearPage##uname(struct page *page)	\
 {									\
+	if (page->page_type == UINT_MAX)				\
+		return;							\
 	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
 	page->page_type = UINT_MAX;					\
 }


