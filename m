Return-Path: <stable+bounces-119888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58149A490AE
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 06:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50402188CD31
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 05:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F591B040E;
	Fri, 28 Feb 2025 05:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b74lYbUL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67641662FB
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 05:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740718806; cv=none; b=qLI1AmH6KU099hktZF9zHZPfb0wjKKQb/lN5vkmYpQhZ9y+P+z43vpsf7U2KzckohJwnZGmo7MJ7pQ2bIruDwcOueloIPlL+h/nhrmYgMZ69yw09/4mVwBIzVxZ5mIsvUuLea8kiNhK4//ikSvs5NH6ZAHMhx91z6CAKeySXICk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740718806; c=relaxed/simple;
	bh=J2SbxlYIpTl054nAOG51fbD3KT6YxqGIYPx8Xx1XfRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UkTNMBSXy2Ya7wzUA6Il7AjgUhj/0fbxU59s/E6AR1BvlpQz4Iuquu2PxVeY2LJL+MtTdmg8ZfMIoE6XFDB+uvOh7woWw9KJTrhfyuJaSrrEhZIQ776QDlK2OjIW+NSBGff5l5DBTJtYyIEfguT5tGzTz3t0QBDSSCM5V8QkZQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b74lYbUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D2AC4CED6;
	Fri, 28 Feb 2025 05:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740718806;
	bh=J2SbxlYIpTl054nAOG51fbD3KT6YxqGIYPx8Xx1XfRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b74lYbULAEhsEguGKKDUtj8D1OxjVKYY9x0W+S9i+/8qhgobysQOfWhEacA6SeMtV
	 04wSMJgDQIpmXQ6w6wI2uG6MPrI/fkP4qog5Nz09CnPMB058T/hcLvKvubAjpN/b+C
	 q0LrDv3aP1/zEtYsjlnvREFS3lDZYLx630BzBWgwpbzbofwY8jx5Wxm1oy8TaSoTL7
	 W4HA9r61OPNG9oUTrlvOBXNSYOOtak304URPW7x5J7Pmga5vZNkUyAx8tFupTP9wSw
	 92lMaMEwtESg+oPQHNhzJjjgiR+ORzJM1jkcgSOHONC32k3D7vivInFjKcr/6Vexy/
	 cdaOInHjJjjNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	konishi.ryusuke@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 5.10 5.15 6.1 1/3] nilfs2: move page release outside of nilfs_delete_entry and nilfs_set_link
Date: Thu, 27 Feb 2025 23:56:21 -0500
Message-Id: <20250227200402-587d02fe6761bf54@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250226180247.4950-2-konishi.ryusuke@gmail.com>
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

Summary of potential issues:
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

The upstream commit SHA1 provided is correct: 584db20c181f5e28c0386d7987406ace7fbd3e49

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 944a4f8f0b07)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  584db20c181f5 ! 1:  e7803a5bf15f3 nilfs2: move page release outside of nilfs_delete_entry and nilfs_set_link
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
    + 	dir->i_mtime = dir->i_ctime = current_time(dir);
      }
      
     @@ fs/nilfs2/dir.c: int nilfs_add_link(struct dentry *dentry, struct inode *inode)
    @@ fs/nilfs2/dir.c: int nilfs_add_link(struct dentry *dentry, struct inode *inode)
      {
     @@ fs/nilfs2/dir.c: int nilfs_delete_entry(struct nilfs_dir_entry *dir, struct page *page)
      	nilfs_commit_chunk(page, mapping, from, to);
    - 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
    + 	inode->i_ctime = inode->i_mtime = current_time(inode);
      out:
     -	nilfs_put_page(page);
      	return err;
    @@ fs/nilfs2/namei.c: static int nilfs_do_unlink(struct inode *dir, struct dentry *
      	if (err)
      		goto out;
      
    -@@ fs/nilfs2/namei.c: static int nilfs_rename(struct mnt_idmap *idmap,
    - 		if (!new_de)
    +@@ fs/nilfs2/namei.c: static int nilfs_rename(struct inode *old_dir, struct dentry *old_dentry,
      			goto out_dir;
    + 		}
      		nilfs_set_link(new_dir, new_de, new_page, old_inode);
     +		nilfs_put_page(new_page);
      		nilfs_mark_inode_dirty(new_dir);
    - 		inode_set_ctime_current(new_inode);
    + 		new_inode->i_ctime = current_time(new_inode);
      		if (dir_de)
    -@@ fs/nilfs2/namei.c: static int nilfs_rename(struct mnt_idmap *idmap,
    - 	inode_set_ctime_current(old_inode);
    +@@ fs/nilfs2/namei.c: static int nilfs_rename(struct inode *old_dir, struct dentry *old_dentry,
    + 	old_inode->i_ctime = current_time(old_inode);
      
      	nilfs_delete_entry(old_de, old_page);
     +	nilfs_put_page(old_page);
    @@ fs/nilfs2/namei.c: static int nilfs_rename(struct mnt_idmap *idmap,
      		drop_nlink(old_dir);
      	}
      	nilfs_mark_inode_dirty(old_dir);
    -@@ fs/nilfs2/namei.c: static int nilfs_rename(struct mnt_idmap *idmap,
    +@@ fs/nilfs2/namei.c: static int nilfs_rename(struct inode *old_dir, struct dentry *old_dentry,
      	return err;
      
      out_dir:
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

