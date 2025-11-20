Return-Path: <stable+bounces-195381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F108BC75E40
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A68052B1E3
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639243242AC;
	Thu, 20 Nov 2025 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aybjsCaX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67D1F4CB3
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662753; cv=none; b=d7r3GAmAv4pcTvY6oEHFBrWHDKCsWxB4vPIX5ONg/4FUDVmhMEzpm7nfmSZK9+hR3NaB8JZYR4/hLtgchYGjD11gSp1R0CfzXV/w4Ha1oGh8xJfT3ZQ1I0xbeCuQ+2ziwNvArpJgfQYurtClk8Ul33xbC3lUxXmZ6t3li9QsS/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662753; c=relaxed/simple;
	bh=XNp9hvnBNiH+CfEzYh8MQ7Xme8cL9HaQ1lDp5Gn6Fz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfEZ7tfoB7Is2vYW0rEjbeqG3MRzXeceBYNbl8ulymfLNWyb+pg+ORmfp0REXsyZIpenJwn1WQ005BYRCNzl12XDTJeIFcxTeB3pxeKPuH/3fnqyAGuaJIMEQcfJ4aylBeK1rnfmR9r64wde+2jmUzkiFJT45BLOMgrBwKrZAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aybjsCaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD360C4AF0B;
	Thu, 20 Nov 2025 18:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763662747;
	bh=XNp9hvnBNiH+CfEzYh8MQ7Xme8cL9HaQ1lDp5Gn6Fz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aybjsCaXjaxnABkNnxIuHRarEiKV93ytDKuRAKOyyarVzU6fV4fNDSdWB2XyeB8ML
	 BC98rySaBXVjzv6eirqvBlVp4r323H3yffEcc3xRhGCaKiR3IdHHfj1v0sKKC7Us9o
	 kg0YSfSBkSkrFQUJzebdT/BtFf7JkqsQoD2wh17LHW290eYbgM6Od/o70lJm6aPJA/
	 wUGHmox09RHLY18W2gip+G01AWKKO91uJ6SHnEI30U6N2pClO/dwg0bUqBYtrNP+Lk
	 s8+OdudUjUWHGT/RSx06LYBuIS1MNyfrtIaLwLSSCqwlEsv2nckcZQUXLofr5CGXCL
	 DeUwAPmRTbzvg==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id E55ADF4006D;
	Thu, 20 Nov 2025 13:19:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 20 Nov 2025 13:19:05 -0500
X-ME-Sender: <xms:mVsfaaXPT6d74J-CiXn-FhMxsElqbm5D6SAmpwQLGMPm_zYDiquvew>
    <xme:mVsfaSf2qE9Wv1uJJIVRQBuSZfnfHaypTNZH_VSlCepzL0QkaPgAyeRo6kE3g3CP9
    wcW4FUc7Jcr22Li8Tzcc-5Q8PG6ZrA5PNhjaeC9DJ-22vZ55WSFXd0>
X-ME-Received: <xmr:mVsfaZ6_H38A3TYiDA5cwen-tnyhHy3LHDG2r15MCuyIgXx59hG0HoOEmJb4oA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejjeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:mVsfaVR0x6P2FOtvZuX3fWyErA1nlcDtvl0ShoSJovAveiXhiOlyHA>
    <xmx:mVsface4S39_F-0oDzk4c-o3GozRnfitGT0Tpf89UCLtjvQ90wQmBw>
    <xmx:mVsfaVQNEOURllVhjUzD7jaWfn4drDhmNubA6mT-0hvsPmvfdTlI0w>
    <xmx:mVsfaVNGCR9v2xML1ASc9kSSepkWsCMrwfbkb2u9L85Gg3QLVi23-Q>
    <xmx:mVsfaYU3tCTSrldgZlyP8TckhOm1_npQ5IAoIQB976FA94Pn2xAGlwDz>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 13:19:05 -0500 (EST)
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
Subject: [PATCH 6.6.y] mm/truncate: unmap large folio on split failure
Date: Thu, 20 Nov 2025 18:19:00 +0000
Message-ID: <20251120181900.967792-1-kas@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112038-designate-amino-d210@gregkh>
References: <2025112038-designate-amino-d210@gregkh>
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
index 70c09213bb92..6a82e981b63c 100644
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


