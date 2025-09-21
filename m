Return-Path: <stable+bounces-180802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA712B8DB4F
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF307AA5F2
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51C2259CA3;
	Sun, 21 Sep 2025 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J+Lp/Sfc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8331A1E51D
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758459133; cv=none; b=PtaO1Ahi9/wmYgoGQlX6nwy3lJ5mMdJW/ngTY0VLVjTpGe2/fkMeS0wpchMIGvcCQyGXicMoBeminoihYapjl6oJsldxWLYHcqFs6t/iUuCZRUbJ+3Eh5Nh9zDlYZcbc0XKwZbo6x93SNrt+YIoSonONAgLwaYShJMXKkhZJqDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758459133; c=relaxed/simple;
	bh=2HpWmETmDUJ4oQZquGfyMRsc1lttRj/HSN95R7a+jtU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Pqp57CUSEmvc5FhRtlMA38vOoN8mzHkuCXQSuwKVGniKPLF8J89LEctLX/3kNT41VqiTnvaLhtdHB/1eOKOtyvu/5J5fhGRoiCzKOchuVf1s9rD19CFVyMRNDHN6lexmk01BOtD88Tka6gX1mKcGRRIdAkrZvhunPG8BEkPHM/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J+Lp/Sfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066ADC4CEE7;
	Sun, 21 Sep 2025 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758459133;
	bh=2HpWmETmDUJ4oQZquGfyMRsc1lttRj/HSN95R7a+jtU=;
	h=Subject:To:Cc:From:Date:From;
	b=J+Lp/Sfc8Ofz2aVC8R4FYt+al9P0+O4uXhV5lE6U0xpxBCnIYCNlK3GlsDlitMk6m
	 lQJp+l/yaR8GaCK00c67PCcu3qCUfOeq5+C7qu+7RmUezuNbKFah+wpk2mHJRoudBc
	 VhJ8VKQq3t4TQ2J7dR8F0p+KL0azqCIqZIMYXxFs=
Subject: FAILED: patch "[PATCH] mm/gup: local lru_add_drain() to avoid lru_add_drain_all()" failed to apply to 6.12-stable tree
To: hughd@google.com,akpm@linux-foundation.org,aneesh.kumar@kernel.org,axelrasmussen@google.com,chrisl@kernel.org,david@redhat.com,hannes@cmpxchg.org,hch@infradead.org,jgg@ziepe.ca,jhubbard@nvidia.com,keirf@google.com,koct9i@gmail.com,lizhe.67@bytedance.com,peterx@redhat.com,riel@surriel.com,shivankg@amd.com,stable@vger.kernel.org,vbabka@suse.cz,weixugc@google.com,will@kernel.org,willy@infradead.org,yangge1116@126.com,yuanchu@google.com,yuzhao@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:52:10 +0200
Message-ID: <2025092110-music-knoll-828f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a09a8a1fbb374e0053b97306da9dbc05bd384685
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092110-music-knoll-828f@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a09a8a1fbb374e0053b97306da9dbc05bd384685 Mon Sep 17 00:00:00 2001
From: Hugh Dickins <hughd@google.com>
Date: Mon, 8 Sep 2025 15:16:53 -0700
Subject: [PATCH] mm/gup: local lru_add_drain() to avoid lru_add_drain_all()

In many cases, if collect_longterm_unpinnable_folios() does need to drain
the LRU cache to release a reference, the cache in question is on this
same CPU, and much more efficiently drained by a preliminary local
lru_add_drain(), than the later cross-CPU lru_add_drain_all().

Marked for stable, to counter the increase in lru_add_drain_all()s from
"mm/gup: check ref_count instead of lru before migration".  Note for clean
backports: can take 6.16 commit a03db236aebf ("gup: optimize longterm
pin_user_pages() for large folio") first.

Link: https://lkml.kernel.org/r/66f2751f-283e-816d-9530-765db7edc465@google.com
Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Keir Fraser <keirf@google.com>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Li Zhe <lizhe.67@bytedance.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Shivank Garg <shivankg@amd.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Wei Xu <weixugc@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: yangge <yangge1116@126.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/gup.c b/mm/gup.c
index 82aec6443c0a..b47066a54f52 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2287,8 +2287,8 @@ static unsigned long collect_longterm_unpinnable_folios(
 		struct pages_or_folios *pofs)
 {
 	unsigned long collected = 0;
-	bool drain_allow = true;
 	struct folio *folio;
+	int drained = 0;
 	long i = 0;
 
 	for (folio = pofs_get_folio(pofs, i); folio;
@@ -2307,10 +2307,17 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
-		if (drain_allow && folio_ref_count(folio) !=
-				   folio_expected_ref_count(folio) + 1) {
+		if (drained == 0 &&
+				folio_ref_count(folio) !=
+				folio_expected_ref_count(folio) + 1) {
+			lru_add_drain();
+			drained = 1;
+		}
+		if (drained == 1 &&
+				folio_ref_count(folio) !=
+				folio_expected_ref_count(folio) + 1) {
 			lru_add_drain_all();
-			drain_allow = false;
+			drained = 2;
 		}
 
 		if (!folio_isolate_lru(folio))


