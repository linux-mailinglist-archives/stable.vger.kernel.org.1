Return-Path: <stable+bounces-114317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287C4A2D0EE
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC623AA606
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4FA1C6FF4;
	Fri,  7 Feb 2025 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTbTkTq7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2A1AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968642; cv=none; b=fIM/TEBSo4YLyBzwSB1mdUEb9GPSw8YRapJWQnQSRmI2sZ0Djht1grocD7U86ovLuoloQ+r3jCi13whxJ2WXa0mt5oy4SVI8odi/UFbfm85nZIJypIdNh4h3yNVr+gJCF88W4WdcDUlD/vfV6zQab9HvAq8Gt4PweHLtLQdSvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968642; c=relaxed/simple;
	bh=dSrVn0ArMveBB1eKBKHIysNrx6UrQFd0+POEYlyne7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LVsuNDPRLJb9mmWihhVthlUOrkQAgLhVp1dik+OYhMBUXF+Wcd9P1C9BkNoCmFp/0gJl8ej9i/K4DcTiNMKEdLtwHd4+8Ps3UvNWSo2CHRxo4RxNIDECum0K3NUQUcLBAQWF8t8LsW7b+mZ4gIZo4s2ofIaKPvj5yYkAxnzF//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTbTkTq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D8FC4CED1;
	Fri,  7 Feb 2025 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968642;
	bh=dSrVn0ArMveBB1eKBKHIysNrx6UrQFd0+POEYlyne7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTbTkTq79u4lXXUczJrYSOJjM71G8jrTtGQ7XJyyK4SySUWfJi8pdjkVjywGcxnu2
	 w+0csFpf/6+11pmKwZnPLo5LfK3NvxHxyW3ChSrHNgHuPX46QfYOpvmslsFdvh6MPA
	 Rr3wHCr3pOy7YwbDMBUjruNz5HRciwLd6tccJaA8l4cXee2ZlgVucUBCUJG5GY6PRB
	 qarzgT+zcaHavfRTU5CmZeSdnbFN/280w77rYpn268mXm4hvLc2D8cNAwYQNC+YFXw
	 GsA0EbwmAjxacQRPwQ4deN5db4jR0LlqlrukxeuDQ+VTmR7bw2hBJuUtHcaGro/mot
	 +xHScGV6kdpUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 1/3] nilfs2: do not output warnings when clearing dirty buffers
Date: Fri,  7 Feb 2025 17:50:40 -0500
Message-Id: <20250207164504-482769f206367594@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250206181559.7166-2-konishi.ryusuke@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 299910dcb4525ac0274f3efa95278=
76315ba4f67


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  299910dcb4525 ! 1:  d790b43c64680 nilfs2: do not output warnings when c=
learing dirty buffers
    @@ Metadata
      ## Commit message ##
         nilfs2: do not output warnings when clearing dirty buffers
=20=20=20=20=20
    +    commit 299910dcb4525ac0274f3efa9527876315ba4f67 upstream.
    +
         After detecting file system corruption and degrading to a read-onl=
y mount,
         dirty folios and buffers in the page cache are cleared, and a larg=
e number
         of warnings are output at that time, often filling up the kernel l=
og.
    @@ Commit message
         that suppresses the warning output, but since it is not currently =
used
         meaningfully, remove both the silent argument and the warning outp=
ut.
=20=20=20=20=20
    +    [konishi.ryusuke@gmail.com: adjusted for page/folio conversion]
         Link: https://lkml.kernel.org/r/20240816090128.4561-1-konishi.ryus=
uke@gmail.com
         Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Stable-dep-of: ca76bb226bf4 ("nilfs2: do not force clear folio if =
buffer is referenced")
=20=20=20=20=20
      ## fs/nilfs2/inode.c ##
     @@ fs/nilfs2/inode.c: static int nilfs_writepages(struct address_space=
 *mapping,
    @@ fs/nilfs2/inode.c: static int nilfs_writepage(struct page *page, str=
uct writebac
      		 * have dirty pages that try to be flushed in background.
      		 * So, here we simply discard this dirty page.
      		 */
    --		nilfs_clear_folio_dirty(folio, false);
    -+		nilfs_clear_folio_dirty(folio);
    - 		folio_unlock(folio);
    +-		nilfs_clear_dirty_page(page, false);
    ++		nilfs_clear_dirty_page(page);
    + 		unlock_page(page);
      		return -EROFS;
      	}
=20=20=20=20=20
      ## fs/nilfs2/mdt.c ##
     @@ fs/nilfs2/mdt.c: nilfs_mdt_write_page(struct page *page, struct wri=
teback_control *wbc)
    - 		 * have dirty folios that try to be flushed in background.
    - 		 * So, here we simply discard this dirty folio.
    + 		 * have dirty pages that try to be flushed in background.
    + 		 * So, here we simply discard this dirty page.
      		 */
    --		nilfs_clear_folio_dirty(folio, false);
    -+		nilfs_clear_folio_dirty(folio);
    - 		folio_unlock(folio);
    +-		nilfs_clear_dirty_page(page, false);
    ++		nilfs_clear_dirty_page(page);
    + 		unlock_page(page);
      		return -EROFS;
      	}
     @@ fs/nilfs2/mdt.c: void nilfs_mdt_restore_from_shadow_map(struct inod=
e *inode)
    @@ fs/nilfs2/page.c: void nilfs_copy_back_pages(struct address_space *d=
map,
     -void nilfs_clear_dirty_pages(struct address_space *mapping, bool sile=
nt)
     +void nilfs_clear_dirty_pages(struct address_space *mapping)
      {
    - 	struct folio_batch fbatch;
    + 	struct pagevec pvec;
      	unsigned int i;
     @@ fs/nilfs2/page.c: void nilfs_clear_dirty_pages(struct address_space=
 *mapping, bool silent)
      			 * was acquired.  Skip processing in that case.
      			 */
    - 			if (likely(folio->mapping =3D=3D mapping))
    --				nilfs_clear_folio_dirty(folio, silent);
    -+				nilfs_clear_folio_dirty(folio);
    + 			if (likely(page->mapping =3D=3D mapping))
    +-				nilfs_clear_dirty_page(page, silent);
    ++				nilfs_clear_dirty_page(page);
=20=20=20=20=20=20
    - 			folio_unlock(folio);
    + 			unlock_page(page);
      		}
     @@ fs/nilfs2/page.c: void nilfs_clear_dirty_pages(struct address_space=
 *mapping, bool silent)
      /**
    -  * nilfs_clear_folio_dirty - discard dirty folio
    -  * @folio: dirty folio that will be discarded
    +  * nilfs_clear_dirty_page - discard dirty page
    +  * @page: dirty page that will be discarded
     - * @silent: suppress [true] or print [false] warning messages
       */
    --void nilfs_clear_folio_dirty(struct folio *folio, bool silent)
    -+void nilfs_clear_folio_dirty(struct folio *folio)
    +-void nilfs_clear_dirty_page(struct page *page, bool silent)
    ++void nilfs_clear_dirty_page(struct page *page)
      {
    --	struct inode *inode =3D folio->mapping->host;
    +-	struct inode *inode =3D page->mapping->host;
     -	struct super_block *sb =3D inode->i_sb;
    - 	struct buffer_head *bh, *head;
    -=20
    - 	BUG_ON(!folio_test_locked(folio));
    +-
    + 	BUG_ON(!PageLocked(page));
=20=20=20=20=20=20
     -	if (!silent)
     -		nilfs_warn(sb, "discard dirty page: offset=3D%lld, ino=3D%lu",
    --			   folio_pos(folio), inode->i_ino);
    +-			   page_offset(page), inode->i_ino);
     -
    - 	folio_clear_uptodate(folio);
    - 	folio_clear_mappedtodisk(folio);
    -=20
    -@@ fs/nilfs2/page.c: void nilfs_clear_folio_dirty(struct folio *folio,=
 bool silent)
    - 		bh =3D head;
    + 	ClearPageUptodate(page);
    + 	ClearPageMappedToDisk(page);
    + 	ClearPageChecked(page);
    +@@ fs/nilfs2/page.c: void nilfs_clear_dirty_page(struct page *page, bo=
ol silent)
    + 		bh =3D head =3D page_buffers(page);
      		do {
      			lock_buffer(bh);
     -			if (!silent)
    @@ fs/nilfs2/page.c: void nilfs_clear_folio_dirty(struct folio *folio, =
bool silent)
      		} while (bh =3D bh->b_this_page, bh !=3D head);
=20=20=20=20=20
      ## fs/nilfs2/page.h ##
    -@@ fs/nilfs2/page.h: void nilfs_folio_bug(struct folio *);
    +@@ fs/nilfs2/page.h: void nilfs_page_bug(struct page *);
=20=20=20=20=20=20
      int nilfs_copy_dirty_pages(struct address_space *, struct address_spa=
ce *);
      void nilfs_copy_back_pages(struct address_space *, struct address_spa=
ce *);
    --void nilfs_clear_folio_dirty(struct folio *, bool);
    +-void nilfs_clear_dirty_page(struct page *, bool);
     -void nilfs_clear_dirty_pages(struct address_space *, bool);
    -+void nilfs_clear_folio_dirty(struct folio *folio);
    ++void nilfs_clear_dirty_page(struct page *page);
     +void nilfs_clear_dirty_pages(struct address_space *mapping);
      unsigned int nilfs_page_count_clean_buffers(struct page *, unsigned i=
nt,
      					    unsigned int);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.1.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

