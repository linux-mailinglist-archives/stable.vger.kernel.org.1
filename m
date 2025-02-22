Return-Path: <stable+bounces-118665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECFDA40996
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 16:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A623AD9C3
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4832E1CB31D;
	Sat, 22 Feb 2025 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNgOvqAz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B2069D2B
	for <stable@vger.kernel.org>; Sat, 22 Feb 2025 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239617; cv=none; b=R1ytL80HScCsr4chH3qruPpdCm5suMkqQ+C/8vp9CzqmtAkveq6qFsqy9gAb3Z8oiWQqbkn0mr7AV41wKDIQF+f7M1WYCKUi5uePxC2/lhhdzjCs6FU98jFb85/l76Rg1c8C3Y2hNxIzAzeqMU4aTqo9LTjZWRu/iFnCGai09lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239617; c=relaxed/simple;
	bh=ScCj6KhwAus4VmeWE+CXmH4d/df0t1pGKD2vFo95uWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bX9/ZjKpvXcR+xkRcR6RpJxYeB9r3KUCz8+joWJ7EFW3X19XdvjbDjOYPLIXbwcaOuMk6/588LMU1uzRw/oDod9MyCWQanESY7f04fqD1ZV1raMLcw9dTRj5ezZHc9o1URJLfUQE9Y7Ogs/4Kjy72yBABTwj8/oEFwIxqw8zWT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNgOvqAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B6FC4CEE4;
	Sat, 22 Feb 2025 15:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740239616;
	bh=ScCj6KhwAus4VmeWE+CXmH4d/df0t1pGKD2vFo95uWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tNgOvqAzzNt9/MwfPyqa9PiBLdihiZQuXJmTRD6pSBBvim75+9kMgVVJgafUCz3/D
	 lC0Y+UN5LLDqob3YhUCf6nvvkv/0rVJqJAxlG2Yv15MW7lFomfQ9S8prZSIFGJN3LX
	 CsudIohKBXL91MO82fl7kZqm7tLt4s2gt8QKIXzSqCrJvR3lGclGoWaeTpCuEjEljc
	 tD4emg6IxVIqn9kOsOwq2oxRaJ37IiK5+o8AnrqOB/MaqgsmAlZZTvguRCIyiB+s01
	 FQUEvG3ERZbSCZha+lESIss/jDhwvss20rEYGcZ0VJh9Cb85Nl9UX+xmPsWHMWlt4r
	 mPT7Es72Drz8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 3/3] nilfs2: handle errors that nilfs_prepare_chunk() may return
Date: Sat, 22 Feb 2025 10:53:35 -0500
Message-Id: <20250222105033-5217e0c7af62156b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250221133848.4335-4-konishi.ryusuke@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues and notes:
ℹ️ This is part 3/3 of a series

The upstream commit SHA1 provided is correct: ee70999a988b8abc3490609142f50ebaa8344432

Note: The patch differs from the upstream commit:
---
1:  ee70999a988b8 ! 1:  1d6894c5f5775 nilfs2: handle errors that nilfs_prepare_chunk() may return
    @@ Metadata
      ## Commit message ##
         nilfs2: handle errors that nilfs_prepare_chunk() may return
     
    +    commit ee70999a988b8abc3490609142f50ebaa8344432 upstream.
    +
         Patch series "nilfs2: fix issues with rename operations".
     
         This series fixes BUG_ON check failures reported by syzbot around rename
         operations, and a minor behavioral issue where the mtime of a child
         directory changes when it is renamed instead of moved.
     
    -
         This patch (of 2):
     
         The directory manipulation routines nilfs_set_link() and
    @@ Commit message
         Fix this issue by adding missing error paths in nilfs_set_link(),
         nilfs_delete_entry(), and their caller nilfs_rename().
     
    +    [konishi.ryusuke@gmail.com: adjusted for page/folio conversion]
         Link: https://lkml.kernel.org/r/20250111143518.7901-1-konishi.ryusuke@gmail.com
         Link: https://lkml.kernel.org/r/20250111143518.7901-2-konishi.ryusuke@gmail.com
         Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
    @@ fs/nilfs2/dir.c: int nilfs_inode_by_name(struct inode *dir, const struct qstr *q
      
     -void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
     +int nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
    - 		    struct folio *folio, struct inode *inode)
    + 		    struct page *page, struct inode *inode)
      {
    - 	size_t from = offset_in_folio(folio, de);
    + 	unsigned int from = (char *)de - (char *)page_address(page);
     @@ fs/nilfs2/dir.c: void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
      
    - 	folio_lock(folio);
    - 	err = nilfs_prepare_chunk(folio, from, to);
    + 	lock_page(page);
    + 	err = nilfs_prepare_chunk(page, from, to);
     -	BUG_ON(err);
     +	if (unlikely(err)) {
    -+		folio_unlock(folio);
    ++		unlock_page(page);
     +		return err;
     +	}
      	de->inode = cpu_to_le64(inode->i_ino);
    - 	de->file_type = fs_umode_to_ftype(inode->i_mode);
    - 	nilfs_commit_chunk(folio, mapping, from, to);
    - 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
    + 	nilfs_set_de_type(de, inode);
    + 	nilfs_commit_chunk(page, mapping, from, to);
    + 	dir->i_mtime = inode_set_ctime_current(dir);
     +	return 0;
      }
      
      /*
    -@@ fs/nilfs2/dir.c: int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct folio *folio)
    - 		from = (char *)pde - kaddr;
    - 	folio_lock(folio);
    - 	err = nilfs_prepare_chunk(folio, from, to);
    +@@ fs/nilfs2/dir.c: int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
    + 		from = (char *)pde - (char *)page_address(page);
    + 	lock_page(page);
    + 	err = nilfs_prepare_chunk(page, from, to);
     -	BUG_ON(err);
     +	if (unlikely(err)) {
    -+		folio_unlock(folio);
    ++		unlock_page(page);
     +		goto out;
     +	}
      	if (pde)
    @@ fs/nilfs2/namei.c: static int nilfs_rename(struct mnt_idmap *idmap,
      			err = PTR_ERR(new_de);
      			goto out_dir;
      		}
    --		nilfs_set_link(new_dir, new_de, new_folio, old_inode);
    -+		err = nilfs_set_link(new_dir, new_de, new_folio, old_inode);
    - 		folio_release_kmap(new_folio, new_de);
    +-		nilfs_set_link(new_dir, new_de, new_page, old_inode);
    ++		err = nilfs_set_link(new_dir, new_de, new_page, old_inode);
    + 		nilfs_put_page(new_page);
     +		if (unlikely(err))
     +			goto out_dir;
      		nilfs_mark_inode_dirty(new_dir);
    @@ fs/nilfs2/namei.c: static int nilfs_rename(struct mnt_idmap *idmap,
      	 */
      	inode_set_ctime_current(old_inode);
      
    --	nilfs_delete_entry(old_de, old_folio);
    +-	nilfs_delete_entry(old_de, old_page);
     -
     -	if (dir_de) {
    --		nilfs_set_link(old_inode, dir_de, dir_folio, new_dir);
    --		folio_release_kmap(dir_folio, dir_de);
    +-		nilfs_set_link(old_inode, dir_de, dir_page, new_dir);
    +-		nilfs_put_page(dir_page);
     -		drop_nlink(old_dir);
    -+	err = nilfs_delete_entry(old_de, old_folio);
    ++	err = nilfs_delete_entry(old_de, old_page);
     +	if (likely(!err)) {
     +		if (dir_de) {
    -+			err = nilfs_set_link(old_inode, dir_de, dir_folio,
    ++			err = nilfs_set_link(old_inode, dir_de, dir_page,
     +					     new_dir);
     +			drop_nlink(old_dir);
     +		}
     +		nilfs_mark_inode_dirty(old_dir);
      	}
    --	folio_release_kmap(old_folio, old_de);
    +-	nilfs_put_page(old_page);
     -
     -	nilfs_mark_inode_dirty(old_dir);
      	nilfs_mark_inode_dirty(old_inode);
    @@ fs/nilfs2/namei.c: static int nilfs_rename(struct mnt_idmap *idmap,
     -
      out_dir:
      	if (dir_de)
    - 		folio_release_kmap(dir_folio, dir_de);
    + 		nilfs_put_page(dir_page);
      out_old:
    - 	folio_release_kmap(old_folio, old_de);
    + 	nilfs_put_page(old_page);
      out:
     -	nilfs_transaction_abort(old_dir->i_sb);
     +	if (likely(!err))
    @@ fs/nilfs2/namei.c: static int nilfs_rename(struct mnt_idmap *idmap,
      
     
      ## fs/nilfs2/nilfs.h ##
    -@@ fs/nilfs2/nilfs.h: struct nilfs_dir_entry *nilfs_find_entry(struct inode *, const struct qstr *,
    - int nilfs_delete_entry(struct nilfs_dir_entry *, struct folio *);
    - int nilfs_empty_dir(struct inode *);
    - struct nilfs_dir_entry *nilfs_dotdot(struct inode *, struct folio **);
    --void nilfs_set_link(struct inode *, struct nilfs_dir_entry *,
    --			   struct folio *, struct inode *);
    +@@ fs/nilfs2/nilfs.h: nilfs_find_entry(struct inode *, const struct qstr *, struct page **);
    + extern int nilfs_delete_entry(struct nilfs_dir_entry *, struct page *);
    + extern int nilfs_empty_dir(struct inode *);
    + extern struct nilfs_dir_entry *nilfs_dotdot(struct inode *, struct page **);
    +-extern void nilfs_set_link(struct inode *, struct nilfs_dir_entry *,
    +-			   struct page *, struct inode *);
     +int nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *de,
    -+		   struct folio *folio, struct inode *inode);
    ++		   struct page *page, struct inode *inode);
      
    - /* file.c */
    - extern int nilfs_sync_file(struct file *, loff_t, loff_t, int);
    + static inline void nilfs_put_page(struct page *page)
    + {
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

