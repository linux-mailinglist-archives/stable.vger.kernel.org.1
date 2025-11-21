Return-Path: <stable+bounces-196322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3070EC79E62
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6466434ABC5
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F0C33C526;
	Fri, 21 Nov 2025 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ov2liOqb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019981C5D77
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733176; cv=none; b=ZvSjpUuZHGWw+QayxD+JLOLBxFY2vyH9nn0tq7nrkEzn8Ll1i+BLYkETciqyl/cwd77jz/Q9Echr/HNwFoiPTIo+qJ9SYgpgTJlgZ7B5l471VHIkEbM6w5inh7uHY7xxTtTcENKSxRvIf+/xmTKmaM15Rsl9RkFfG02BNpid9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733176; c=relaxed/simple;
	bh=wKqpdMD6s0gGLkOHMKiIJBLTco0ZvUoc5W9ZqMG9o/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGmjShYxUOb30QCctkx2JjEftrorpvHqciMci0UOt37npOVu5xzy/7u1bzWq2IQ0BRUzysSqvxEZemxipT1xqhZsH2gAuxc+GNYMzY/WnFNO7MOTh8oVARpvj2EYNhG43cqKFlSa8CBNCH/PTFnJhgXyZsmmRHmbK+aYFX6d9cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ov2liOqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322A3C4CEF1;
	Fri, 21 Nov 2025 13:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763733175;
	bh=wKqpdMD6s0gGLkOHMKiIJBLTco0ZvUoc5W9ZqMG9o/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ov2liOqbKUO/u6asaj27lfheZmcsKAv9PH6dR33a6EsM0xzcv6JO5Ql822/ETks3R
	 cgOttwfZrh8GfWGB9tzn42OT6JLV/po8r2ji+0kp3qXxMjURHWXA7iXiMHZJMw1xdn
	 v1VOIGPj2G/zAKocTgjrKpQIu00YRtmEUEbRr/q9HLnh16qSRzj5ES4U8CmbVpwnIO
	 vttGPkGqjWJ4ZZfYn4MFB+GGkR8N/WMoT5nZOpTphE8MbVVu60sn+O2chnS5oIAuoc
	 CpvKEyWIJualpBl6lHFwtar0Pn48PS4RZa8TJVQZBKB0wP5LlQKQGWVahK2/Igm2of
	 95V9YIZVTX8CA==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7EF02F40068;
	Fri, 21 Nov 2025 08:52:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 21 Nov 2025 08:52:54 -0500
X-ME-Sender: <xms:tm4gaQ0G0hZUjYGjaAaA34IzrpGPvbk-KtFNPkf-deLgUk7q4oOgpA>
    <xme:tm4gaW-Q2x52J_CigFrdDc7ac4zO1GKA8wGW8j-FEu13j0Fh36iXb2CTizfzgrhGz
    laSopumSS7YArcsZgWotoh6PZXebv6rhdOQArqIt-FWdfz6gQLfJN4>
X-ME-Received: <xmr:tm4gaUYgqNjK0xAGenRMhXOzo4Tb9CrEG9PcvaU-OFdIxJpJLzYyuH6WQ2o1LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepgeejffehvdeltdefteejieehveeuffeuteevhfehvdejieelteffleefleeiffeh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkh
    gvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrsheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhope
    gsrgholhhinhdrfigrnhhgsehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthht
    ohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughjfihonhhgse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvihgusehfrhhomhhorhgsihhtrdgt
    ohhmpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohephh
    hughhhugesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:tm4gadyLjxQa67wAToWcQ_Eqo7Ui0wjDXvCMginmuJnRvkkP_qL2RQ>
    <xmx:tm4gaa_tAes_dMCX-ABBwhFt17AmHtlwAwvsMlv0cQtg9QU8L22Qfg>
    <xmx:tm4gaRwEDWspo9MxZziGQoDTQCkhSZQXYy6ZuDh7bPEwTNiKu5p-zQ>
    <xmx:tm4gaXsJ1mGpGI8MUUDQRadUApDI-6oRZNFq3gcvXeEpV0_6Ac3lOQ>
    <xmx:tm4gaY0_GSZW_xzV2gd0PUJ--Nz-UzrvkvTwAE9yjxQ1of658dGMgWPA>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 08:52:53 -0500 (EST)
From: Kiryl Shutsemau <kas@kernel.org>
To: stable@vger.kernel.org
Cc: Kiryl Shutsemau <kas@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/truncate: unmap large folio on split failure
Date: Fri, 21 Nov 2025 13:52:52 +0000
Message-ID: <20251121135252.1069609-1-kas@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112039-theatrics-moodiness-1de3@gregkh>
References: <2025112039-theatrics-moodiness-1de3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
supposed to generate SIGBUS.

This behavior might not be respected on truncation.

During truncation, the kernel splits a large folio in order to reclaim
memory.  As a side effect, it unmaps the folio and destroys PMD mappings
of the folio.  The folio will be refaulted as PTEs and SIGBUS semantics
are preserved.

However, if the split fails, PMD mappings are preserved and the user will
not receive SIGBUS on any accesses within the PMD.

Unmap the folio on split failure.  It will lead to refault as PTEs and
preserve SIGBUS semantics.

Make an exception for shmem/tmpfs that for long time intentionally mapped
with PMDs across i_size.

Link: https://lkml.kernel.org/r/20251027115636.82382-3-kirill@shutemov.name
Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit fa04f5b60fda62c98a53a60de3a1e763f11feb41)
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 mm/truncate.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 96e9812667db..7297ad6b5aac 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -196,6 +196,31 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 	return 0;
 }
 
+static int try_folio_split_or_unmap(struct folio *folio)
+{
+	enum ttu_flags ttu_flags =
+		TTU_SYNC |
+		TTU_SPLIT_HUGE_PMD |
+		TTU_IGNORE_MLOCK;
+	int ret;
+
+	ret = split_folio(folio);
+
+	/*
+	 * If the split fails, unmap the folio, so it will be refaulted
+	 * with PTEs to respect SIGBUS semantics.
+	 *
+	 * Make an exception for shmem/tmpfs that for long time
+	 * intentionally mapped with PMDs across i_size.
+	 */
+	if (ret && !shmem_mapping(folio->mapping)) {
+		try_to_unmap(folio, ttu_flags);
+		WARN_ON(folio_mapped(folio));
+	}
+
+	return ret;
+}
+
 /*
  * Handle partial folios.  The folio may be entirely within the
  * range if a split has raced with us.  If not, we zero the part of the
@@ -239,7 +264,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		folio_invalidate(folio, offset, length);
 	if (!folio_test_large(folio))
 		return true;
-	if (split_folio(folio) == 0)
+	if (try_folio_split_or_unmap(folio) == 0)
 		return true;
 	if (folio_test_dirty(folio))
 		return false;
-- 
2.51.0


