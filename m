Return-Path: <stable+bounces-195365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87639C757F9
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 220983450CF
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D886636B041;
	Thu, 20 Nov 2025 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU24d2/Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E093644DE
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763657550; cv=none; b=SUS4do2Rq5bTt1ruSx3UOyHnk6P7eC8Y3YkVKxO2ynW7PFIPYeMrI5kPX24ZlKFN/p9NQhUUzMUOdsFaCZV0tJnD/pwmZ4YxBqBLPziKmm23MVW4j1yJGhfzMCLSCu+F5q6vrEMaFPd0Fx780ftHeskUl1xT7FFyOAmTD/bUI4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763657550; c=relaxed/simple;
	bh=N+K3lg+dXve7J1ZBkHqK/XJmq06JJMJQcDco4KZUEe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOyJAzlGnjJZaO7Nd009zq7Wo+RQzG2aQNIbOhnLVYvAGdlAt/60z47Qky83ZMzN5u8GKGFlnFC5+qP2HVAc3h4bDVlHuCCaYeVS2S+2H0AStp+g3j/r7wdaTFAGV+dAZzBNNQx4CqoL6HyFtkW8ejIhjpXtPAc6oOtpmkG8Fes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU24d2/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12501C116C6;
	Thu, 20 Nov 2025 16:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763657550;
	bh=N+K3lg+dXve7J1ZBkHqK/XJmq06JJMJQcDco4KZUEe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QU24d2/QoVJ2/U+fQFbkqISCLTxcUFMr7U4QxaTBOhvWBa+FzVWg4oJ+FCq1yKMkO
	 NiBayXqVuK7NX7QUlAv8lFfSbGQONcWNlkUm64WHFf5rknJtcLU2WAEdFKBJnOiLfQ
	 zb7R9TnHF4+yyfJly4biwdmAIsFm8z/JLjhYYGOaUMzqLpYaUu+5WCbtjpGQGPd/lk
	 /g6yYr0+X8zAaQsvwUzRAGmMVRpeMAZg5jxE9vKtFhwtg0qq09C/le75E+p4MGg+YF
	 n4hz3kgBtSpQONzys244+9fxzJOReNo09nOSftcx0HrpsN+STFYI/tzFKbnKU5bHt0
	 2YvxFhJUI7H0Q==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 54607F4006A;
	Thu, 20 Nov 2025 11:52:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 20 Nov 2025 11:52:29 -0500
X-ME-Sender: <xms:TUcfaeZ3UXE5OrugdGbT1lZQjSh1Cu0QNBD9XiI9C9cw7X5G9bjmXw>
    <xme:TUcfadT_c0mEg0QeIjQqUHK3McBuUMHRphM30TnDGF_ZSI7SFWGb_H9O1cdUbEcFb
    vrWKUua65O3Ppr3UMHCUifmnXyUNCIaYOBZlEvUMqRfMtzCaXdyAZWz>
X-ME-Received: <xmr:TUcfaUdMwDajJi5ZqTz2_bdMojS-82tevHfqVaKIADqsgFe-MMf8YUFkp7yKQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejieduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:TUcfaUkuT0vCRX8jiOtl7n_lMz7oCdBnqT6r9ky_3uwjY-34bnIs_Q>
    <xmx:TUcfaRgEBKnfwhFpM4DSb-HAeQTB4hmJljJSTEXtQTlcl3Jp83kXwA>
    <xmx:TUcfadHk3uhaZ9WixPd8YDSnPFohXrrb6AN21nXGkjoeT_4Xrfn5_w>
    <xmx:TUcfaYxU8aBVUBOgFkc3k3TsD7w6UrgiTr-ZxPJG2Vw8BbLj9_dUqw>
    <xmx:TUcfacp71XtCKrGsMGLtjfpX_igMg54s5zsf8JOKrT9-avlG88ktFZX_>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 11:52:28 -0500 (EST)
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
Subject: [PATCH 6.17.y] mm/truncate: unmap large folio on split failure
Date: Thu, 20 Nov 2025 16:52:21 +0000
Message-ID: <20251120165221.892852-1-kas@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112037-resurface-backlight-da75@gregkh>
References: <2025112037-resurface-backlight-da75@gregkh>
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
 mm/truncate.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 91eb92a5ce4f..95fb291526fc 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -177,6 +177,31 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 	return 0;
 }
 
+static int try_folio_split_or_unmap(struct folio *folio, struct page *split_at)
+{
+	enum ttu_flags ttu_flags =
+		TTU_SYNC |
+		TTU_SPLIT_HUGE_PMD |
+		TTU_IGNORE_MLOCK;
+	int ret;
+
+	ret = try_folio_split(folio, split_at, NULL);
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
@@ -224,7 +249,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		return true;
 
 	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
-	if (!try_folio_split(folio, split_at, NULL)) {
+	if (!try_folio_split_or_unmap(folio, split_at)) {
 		/*
 		 * try to split at offset + length to make sure folios within
 		 * the range can be dropped, especially to avoid memory waste
@@ -248,13 +273,10 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		if (!folio_trylock(folio2))
 			goto out;
 
-		/*
-		 * make sure folio2 is large and does not change its mapping.
-		 * Its split result does not matter here.
-		 */
+		/* make sure folio2 is large and does not change its mapping */
 		if (folio_test_large(folio2) &&
 		    folio2->mapping == folio->mapping)
-			try_folio_split(folio2, split_at2, NULL);
+			try_folio_split_or_unmap(folio2, split_at2);
 
 		folio_unlock(folio2);
 out:
-- 
2.51.0


