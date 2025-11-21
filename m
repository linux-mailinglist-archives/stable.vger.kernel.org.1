Return-Path: <stable+bounces-196280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE02C79DFB
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2CAB6381A21
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CB934DB51;
	Fri, 21 Nov 2025 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ku99VeVP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68779350D79
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733062; cv=none; b=cg4zozBEebFlX0ooTJTuFM22Tpusx5QC6LmG63teCVHhCee9lEjMMlc3rT6isHcpYg7daxmEbgBs8dzjUwNevRWnzrX76db0vTpj9XiyPR8HMsehii3yPIGck9ogwSuC9tUqE5q6EZUiOPRL4cLsT1pPPdRvI6jEALnYczZWNKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733062; c=relaxed/simple;
	bh=FsN8dg8b1rr2fqKaSalfcB5Qcy4uafv9LubNJnVFFxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrebCEFsS7iNKcWTm1dwdDHEm0I3+xo+cM4z9OQSd3fJkEaQpKxk4Jvpd5ai178eofIyPdxGFwx97To7JdbyCIB5smTuXjw9414COXFDYGb4BNVYb5kE31OH6LEc6aaemXeD+cnGwQy8PznGgdzNbu74KFDKskt+O5b1hszz/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ku99VeVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43AEC4AF09;
	Fri, 21 Nov 2025 13:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763733062;
	bh=FsN8dg8b1rr2fqKaSalfcB5Qcy4uafv9LubNJnVFFxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ku99VeVPuNI5ll86xEmIaErzSLYJ9fGS2k7IeY5nUavZbwr5kizTrTkbCfg1tYI/j
	 RrR7fR2aZ/8S+16uD9Rh7xJxLtCPUSk/CCLvXiQHp7qpO2bRfIsvFzgTRAJWUq5DMf
	 c1Ux9qg8JFmP9cXJUtkFWhgFjY/IkVVSQtUdpcTzd/jokw2mYW5O0zYPPQlwH81uwe
	 ARhMvCm/B9SvtF284iAQpsDe8Z3OK79VG1V7v5v126AouUCFXiyqtLJxsyQpNysv6c
	 KPkwKHjWL17KlWkDqRgNnxZSUHNgG4k1CJc20pXj0yBub+gXvBKIYNjJSUJkiOvLHJ
	 XhZaEMAbh46cw==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 15DE7F40080;
	Fri, 21 Nov 2025 08:51:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 21 Nov 2025 08:51:01 -0500
X-ME-Sender: <xms:RG4gadGxL81SSS928UeU9jIR6rMmrU6Bfi2qEEboQlf8Ms184CwVMg>
    <xme:RG4gaaiMLiRxFgdt2ScdRRziaaKCrQjy0CpoHDiFthAlRodL9o0GNptbQBzGk0IrE
    OcmoQnVohaPl7IopbCa3_OLKUHYVZ5aVubn55EGQfP9BhIS1e9QiBc>
X-ME-Received: <xmr:RG4gaauVix4bkgbaVgpStnjImOqb4_VK3A80ppbr_aRU6WT8rujsQIaEfCq8DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucfrhhhishhhihhnghdqkffkrfgprhhtucdliedtjedmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhirhih
    lhcuufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepgeejffehvdeltdefteejieehveeuffeuteevhfehvdejieelteffleefleei
    ffehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspe
    epkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthho
    peduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtrggslhgvsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphdrrhgrghhhrghvsehsrghmshhunhhg
    rdgtohhmpdhrtghpthhtohepmhgtghhrohhfsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughjfihonhhg
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrghrvgesshhushgvrdguvgdprhgtph
    htthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepuggrrdhg
    ohhmvgiisehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepuggthhhinhhnvghrsehrvg
    guhhgrthdrtghomh
X-ME-Proxy: <xmx:RG4gadvhAhDNSJGmJ_jUDT_lQszyfwzD6WqepPaqUkbzqJO2g_y2Ig>
    <xmx:RG4gafEvV39rewKlaWb9bX6sczVRQaQglMg_CwXoK2M1_0tDFfVs5A>
    <xmx:RG4gaYPCQrSKQJCBXim-XeWFKMocGJNQaKKd17vbnpihKO8Qhpm-Uw>
    <xmx:RG4gaeKevXXZ2-tVwCeR7bOaC4c-aqLHvnPOxvFx5SFtEp-nn_zCKg>
    <xmx:RW4gaR8dBbDujv23HxO_86e05aI5vdExJ_7I1hDXDx8OyqksqLsOHmrj>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 08:51:00 -0500 (EST)
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
Subject: [PATCH 6.1.y 1/2] filemap: cap PTE range to be created to allowed zero fill in folio_map_range()
Date: Fri, 21 Nov 2025 13:50:56 +0000
Message-ID: <20251121135057.1062568-1-kas@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112026-substance-senator-8409@gregkh>
References: <2025112026-substance-senator-8409@gregkh>
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
index 2ae6c6146d84..bff0abf4c3a7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3433,7 +3433,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct vm_area_struct *vma = vmf->vma;
 	struct file *file = vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
-	pgoff_t last_pgoff = start_pgoff;
+	pgoff_t file_end, last_pgoff = start_pgoff;
 	unsigned long addr;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct folio *folio;
@@ -3453,6 +3453,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 
 	addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
+
+	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
+	if (end_pgoff > file_end)
+		end_pgoff = file_end;
+
 	do {
 again:
 		page = folio_file_page(folio, xas.xa_index);
-- 
2.51.0


