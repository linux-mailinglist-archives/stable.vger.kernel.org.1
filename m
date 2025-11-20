Return-Path: <stable+bounces-195378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1A8C75E13
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 774FE343115
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7967035A95A;
	Thu, 20 Nov 2025 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJmA9aEO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374261A9FB3
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662630; cv=none; b=c/kG6g6PYZ5HifeSREDQvzp4t/w8HmYUPelKN5kTyvGELDbgTbZnIczdc1blHGLBlftQLpApQikduIH9fQgWk21FJrBkyGlNy/pRfuOxJGWHgyp4xQt8Xmj/Jxn881IaLJsY6xiT172MV6PnUnLe6otH+x/w9EZAQNoPmJHvgSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662630; c=relaxed/simple;
	bh=lJP5Z6DQW/2upXb1SZlTUYb0itSkP/xOebZDXhs/i78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgfT+GWBQhJBt0zI8nxy4KmkLk4PyVNtB2WxfIikyQVyrM5BlNm97Znult+y6RfgNz/tZtFH+dxb71SVWN6094V0FcnjR2rvQtyaovwjJ5dHJRVtPMZtvE7dIYD0uu6pBpraD7p5jA/E9TwnzoceZLVj5mKtVHG5xzBBUxl4qmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJmA9aEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF9AC4CEF1;
	Thu, 20 Nov 2025 18:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763662627;
	bh=lJP5Z6DQW/2upXb1SZlTUYb0itSkP/xOebZDXhs/i78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJmA9aEOJxGBB4ECxcEwYmA7F8XH1SuA9Gc1bol8Uh9CnhXtsOveL6V7emYzM6ve8
	 6mZLrTLPqYrKgHPeKz5ko9uEeyuhsRU20oYJdzJyqaoHSgup1b3eYhaWejFwMFKl22
	 5NP+JYfLUYroSCvrBjFvfr2t65nyf0A5o5BGdZR6qiCL4CYwYHvQv7JxGoR3/x9W/4
	 f6J3lsyHztlzxnprmZk6+p5cdOFp1GK7LcA3hvJaSHPyOPp9VVnm/lE7b41iLUZz0M
	 DxF660ZXouD++It8Ky9rlYub7KADJUXieQLouNVKUbnPqrrLC60/ntNFS9VNrAIr34
	 jW2o3SQ+A76wA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 993C1F4006D;
	Thu, 20 Nov 2025 13:17:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 20 Nov 2025 13:17:05 -0500
X-ME-Sender: <xms:IVsfaWN_SG8ciIrN8GM-S_1k5faQHHfL8NQW6HegJiixpqpbF_kw2w>
    <xme:IVsfadI_B5AuuGeHzKTM1Yl1Yx2OF1mxw0x5VBbSArEts12E4XSqiiX8LD7WDi7J-
    KmqNEMoBwPUxI-kENhm5pZHX8EMfVF698v4HvIDMQSvly5aCmb6d9o>
X-ME-Received: <xmr:IVsfaY2af1GeZnVBdqOOByXq4Qk7J3R9vxmiKTwO51_ArMJooMYW6ns6lEormw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepgeejffehvdeltdefteejieehveeuffeuteevhfehvdejieelteffleefleeiffeh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkh
    gvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedu
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphdrrhgrghhhrghvsehsrghmshhunhhgrdgt
    ohhmpdhrtghpthhtohepmhgtghhrohhfsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    guhhhofigvlhhlshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughjfihonhhgsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehhrghrvgesshhushgvrdguvgdprhgtphhtth
    hopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggrrdhgohhm
    vgiisehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepuggthhhinhhnvghrsehrvgguhh
    grthdrtghomh
X-ME-Proxy: <xmx:IVsfaRUCpHpVmYraOWcZTOeJbbfEXdAii9-s2eXitlc-zVqnfJx2sg>
    <xmx:IVsfaaMEXqrZns_2sO72PfPlUEthgSKEft7RR9TKyZJ70qjEJhrK8g>
    <xmx:IVsfaU0-W5mIfITCX6SH8WTChl7D00lqvA_v4mlvAXDxPRP8pwiHjg>
    <xmx:IVsfaeTPmUpvrs4NT5vX3wK-0z7F6NlYyOCvLDnMskuNrGJt3PYmDg>
    <xmx:IVsfafnGpQ8uWcc7uvBCMe66UeNk9ROthQfmC9rKMv1wVLdJmo9LSMrm>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 13:17:05 -0500 (EST)
From: Kiryl Shutsemau <kas@kernel.org>
To: stable@vger.kernel.org
Cc: Pankaj Raghav <p.raghav@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	David Howells <dhowells@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Chinner <dchinner@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCH 6.6.y 1/2] filemap: cap PTE range to be created to allowed zero fill in folio_map_range()
Date: Thu, 20 Nov 2025 18:16:56 +0000
Message-ID: <20251120181657.964919-1-kas@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112025-voucher-hexagram-61bf@gregkh>
References: <2025112025-voucher-hexagram-61bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Usually the page cache does not extend beyond the size of the inode,
therefore, no PTEs are created for folios that extend beyond the size.

But with LBS support, we might extend page cache beyond the size of the
inode as we need to guarantee folios of minimum order. While doing a
read, do_fault_around() can create PTEs for pages that lie beyond the
EOF leading to incorrect error return when accessing a page beyond the
mapped file.

Cap the PTE range to be created for the page cache up to the end of
file(EOF) in filemap_map_pages() so that return error codes are consistent
with POSIX[1] for LBS configurations.

generic/749 has been created to trigger this edge case. This also fixes
generic/749 for tmpfs with huge=always on systems with 4k base page size.

[1](from mmap(2))  SIGBUS
    Attempted access to a page of the buffer that lies beyond the end
    of the mapped file.  For an explanation of the treatment  of  the
    bytes  in  the  page that corresponds to the end of a mapped file
    that is not a multiple of the page size, see NOTES.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Link: https://lore.kernel.org/r/20240822135018.1931258-6-kernel@pankajraghav.com
Tested-by: David Howells <dhowells@redhat.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
(cherry picked from commit 743a2753a02e805347969f6f89f38b736850d808)
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 mm/filemap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ab24dbf5e747..7d4d3bea4e1e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3608,7 +3608,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct vm_area_struct *vma = vmf->vma;
 	struct file *file = vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
-	pgoff_t last_pgoff = start_pgoff;
+	pgoff_t file_end, last_pgoff = start_pgoff;
 	unsigned long addr;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct folio *folio;
@@ -3632,6 +3632,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		folio_put(folio);
 		goto out;
 	}
+
+	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
+	if (end_pgoff > file_end)
+		end_pgoff = file_end;
+
 	do {
 		unsigned long end;
 
-- 
2.51.0


