Return-Path: <stable+bounces-118666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B681A4099C
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 16:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0A617406B
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 15:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFA51C8601;
	Sat, 22 Feb 2025 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0ALCk1Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B5369D2B
	for <stable@vger.kernel.org>; Sat, 22 Feb 2025 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239619; cv=none; b=ZLW6u6VrSsCJ8zNfK3/g+4Cci5c+0XlWSwVxt2+ouCNNGLYxUYaFRYk2+cDBeAQYuICw75MEJlSLo84WAj9EDkU07bgX4MjumssIZ+kPJ/S4aOe+wZmSN1RHv0dDVx0vFJBF3u8fy1sN4Y54ZDa8INmckVYighG9wm5VC1W4rzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239619; c=relaxed/simple;
	bh=YnLqIs2CX8/Ud8sCd4vqju40/wCyQwx04zVfE/uCSq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QrNGOsApAYLcdvtDTrloEfaFMcD+rUVe+zSnx9c8ZBd9xAhMo0FRu1bSgs+QQLt1S0h+iR1Dsfm6eRt7FPf+zDiz+tXnumq4Aj5zDc2htMTSZAZhyuP5ZdW+l0IF1Mba9+/yfDIaGW/BGFiSycLvUc92CrtTS3gDiI7pF0AzZxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0ALCk1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94601C4CED1;
	Sat, 22 Feb 2025 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740239619;
	bh=YnLqIs2CX8/Ud8sCd4vqju40/wCyQwx04zVfE/uCSq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J0ALCk1Q+CySL9P5WcTaJnHNdY8ujZPqwTDDzhsBIOWmUA7DLU9aELcill6+Fwe9C
	 IoIU7mVsU78qk/Y8oDWuo7X95FsBW/69JR7dprmnnWm4ShR7jqNhX+1RxtlPEk7ISw
	 2QwJrEpbGFWeuQi/Lb+DoM6qQHXO9d0accau4MhB2aFu5egbtCZ7RNiWgNmishWfKr
	 B7w/UeH0OcUB16ncBST6FfdpVS06bOgzwA28V5S2LPpXtWn7K2KfbeJEwAzZXtYEDr
	 nNybke3wMk+hKJktRAgxKs8XkyiGbeCxgqzGKP2Izg3hOc1bIBEP9mU4l7w/hjBPh8
	 3ruxPS5vQ0KJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 1/3] nilfs2: move page release outside of nilfs_delete_entry and nilfs_set_link
Date: Sat, 22 Feb 2025 10:53:37 -0500
Message-Id: <20250222103928-0f0d9d699a47f461@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250221133848.4335-2-konishi.ryusuke@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues and notes:


The upstream commit SHA1 provided is correct: 584db20c181f5e28c0386d7987406ace7fbd3e49

Note: The patch differs from the upstream commit:
---
1:  584db20c181f5 ! 1:  670766cc49f85 nilfs2: move page release outside of nilfs_delete_entry and nilfs_set_link
    @@ Metadata
      ## Commit message ##
         nilfs2: move page release outside of nilfs_delete_entry and nilfs_set_link
     
    +    commit 584db20c181f5e28c0386d7987406ace7fbd3e49 upstream.
    +
         Patch series "nilfs2: Folio conversions for directory paths".
     
         This series applies page->folio conversions to nilfs2 directory
    @@ Commit message
         sizes, both on machines with and without highmem mapping.  No issues
         found.
     
    -
         This patch (of 17):
     
         In a few directory operations, the call to nilfs_put_page() for a page
    @@ Commit message
         Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
         Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Stable-dep-of: ee70999a988b ("nilfs2: handle errors that nilfs_prepare_chunk() may return")
     
      ## fs/nilfs2/dir.c ##
     @@ fs/nilfs2/dir.c: static inline unsigned int nilfs_chunk_size(struct inode *inode)
    @@ fs/nilfs2/dir.c: static inline unsigned int nilfs_chunk_size(struct inode *inode
      /*
       * Return the offset into page `page_nr' of the last valid
       * byte in that page, plus one.
    -@@ fs/nilfs2/dir.c: ino_t nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr)
    - 	return res;
    +@@ fs/nilfs2/dir.c: int nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr, ino_t *ino)
    + 	return 0;
      }
      
     -/* Releases the page */
    @@ fs/nilfs2/dir.c: void nilfs_set_link(struct inode *dir, struct nilfs_dir_entry *
      	nilfs_set_de_type(de, inode);
      	nilfs_commit_chunk(page, mapping, from, to);
     -	nilfs_put_page(page);
    - 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
    + 	dir->i_mtime = inode_set_ctime_current(dir);
      }
      
     @@ fs/nilfs2/dir.c: int nilfs_add_link(struct dentry *dentry, struct inode *inode)
    @@ fs/nilfs2/dir.c: int nilfs_add_link(struct dentry *dentry, struct inode *inode)
      {
     @@ fs/nilfs2/dir.c: int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
      	nilfs_commit_chunk(page, mapping, from, to);
    - 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
    + 	inode->i_mtime = inode_set_ctime_current(inode);
      out:
     -	nilfs_put_page(page);
      	return err;
    @@ fs/nilfs2/namei.c: static int nilfs_do_unlink(struct inode *dir, struct dentry *
      		goto out;
      
     @@ fs/nilfs2/namei.c: static int nilfs_rename(struct mnt_idmap *idmap,
    - 		if (!new_de)
      			goto out_dir;
    + 		}
      		nilfs_set_link(new_dir, new_de, new_page, old_inode);
     +		nilfs_put_page(new_page);
      		nilfs_mark_inode_dirty(new_dir);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

