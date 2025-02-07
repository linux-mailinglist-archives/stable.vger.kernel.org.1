Return-Path: <stable+bounces-114342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5861CA2D107
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD0D3AA644
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ECC1BD03F;
	Fri,  7 Feb 2025 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="an0aET6/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298021BC062
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968693; cv=none; b=CUNrDJe94dql4cQKQ1Cnz6e0cbrN3pWq28rB+zluGGaMiCuHviesvCxSCkOFe42rT7qVUlH/uwOpKYhOuvv8Xt2IcxN3kbp+rQ26eXK3EEyc/b2cQnkb3zW0XxzrTvluSIcZop/D0Ir8NCQcRWsmx6ITsT8Ru4o6gRiZq7A0d64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968693; c=relaxed/simple;
	bh=Mbw+1z761jtyWvZOW9CM07tvzkjS949qFSINnhWQ17M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WulQUC0y+rxmbx7wylyqDY+Y/8fWbkxB9XjidLDNC8F7XAa+iMdC+wWjc2ieM9Y7OVJfPX9tpqnMarpxlvOca/rzbhMgFHYbqsn0gN3wG2RdXq5/Wjj0Jj11+2yZF9XtEHeMAcswJwmXObNQgGZ3P/A58fXXlqYAXIBqQk8E43A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=an0aET6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975D1C4CED1;
	Fri,  7 Feb 2025 22:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968693;
	bh=Mbw+1z761jtyWvZOW9CM07tvzkjS949qFSINnhWQ17M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=an0aET6/ci5fkdcQPyQQKX0hLI5fs19FdNEbAHxiFcAXAEvUD1672dCcUZ56wgxgW
	 qtvMC2IMd/jJ/sJ1YZ2j4d/kSwE8L9afhz4NL/5xGsnz/yRhzb1vibVNAnsk1eKkCg
	 0kfVmmcHL03SIqfPQgZ5LAtvc18omwHySUfXHFX/NS6BH6VIqSHwUlBsaV0147H80W
	 E4WtOuYyO6hbTELjDQJqZEQr1Gi26afkwqHo7gPgz75yE48b6dtnqxO9QKmZxtd/Id
	 ZKP7RSY0DvrJoaoospWYhqzbZ+ae/EJ+Vv61k/FuSkI+kfMX/zazG89TiC0clP9nXk
	 +6Se4JegMo6SA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 5.10 5.15 1/3] nilfs2: do not output warnings when clearing dirty buffers
Date: Fri,  7 Feb 2025 17:51:31 -0500
Message-Id: <20250207164045-972882c161d33629@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250207142512.6129-2-konishi.ryusuke@gmail.com>
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
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  299910dcb4525 ! 1:  3d3719013c717 nilfs2: do not output warnings when c=
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
    + void nilfs_mapping_init(struct address_space *mapping, struct inode *=
inode);
      unsigned int nilfs_page_count_clean_buffers(struct page *, unsigned i=
nt,
      					    unsigned int);
    - unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Failed    |
| stable/linux-5.10.y       |  Success    |  Failed    |
| stable/linux-5.4.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.15.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

Build error for stable/linux-5.10.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

Build error for stable/linux-5.4.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

