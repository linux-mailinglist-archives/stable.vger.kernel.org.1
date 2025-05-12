Return-Path: <stable+bounces-143872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AF2AB4332
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99CD57BA110
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD8F2C1E16;
	Mon, 12 May 2025 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuRZ2gf8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0022C1E12
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073149; cv=none; b=FV2HTDC2iNxGui8ijjbG49TcnmFS3PCiWzlOOitOWkcq3cBmfVXx44Croi3G56oU8JP/eIDHp3Z2oyi//Q4bR1LtUN3wivNKMVQsCVOVwPzf/+/vNLMnvJ9ji3d77dg2m/KHNYN601flK1nUtCk/OQ4rxcrQidFtH3dt+eH+2mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073149; c=relaxed/simple;
	bh=Dl6aVg5Eps+jcfiPrbivMBtZSipX2ciXiZ4ReoNN3b4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I76mbCyIU0ZYlNrE/CYV6LORapNy1D7bIopSKtNITlRXzZxj5K8bgK35I0T8UlcKSR2n2yDWx7O4sfsnS13HYqcf74KkxzUjdAJVM53SdVGNM8swrWGwsPltMcw0jtKJ/iVXqwI8ejuLjhXnPhTWi53w3Dk3WMHMih4RwgJfeQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuRZ2gf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888DBC4CEF0;
	Mon, 12 May 2025 18:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073149;
	bh=Dl6aVg5Eps+jcfiPrbivMBtZSipX2ciXiZ4ReoNN3b4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NuRZ2gf8lz0aCWUEhvYGIOABKU/aSmPZyqFcNN4EtfgLW0CU/1FxR/CyQcyabu+7x
	 gF/1sFHXaIfZsIz3T8UiAFYfau1oRBvuEjuUs6EWWIFxoV66kGIS36CE8Jr19TdaU/
	 SLdOYhjgO7BB8pXQ0dGnD5OGXT12nJHOIVSe3tDlfGW8jbiWkpDHaJXsP1/V8S8Vzs
	 7JBRzc+cDXhP5R34IJv+9ITxgmqoIYhi3eirfpUgLrpA231sqnKdN44bXgSnhUbZ46
	 HHtSIVxsNFZZxxF394PmmsIUguZSHDr5b9hJHThs7vv55DfysDwaL+EQP7RP1xY8XZ
	 0a8oLrUbg5ovw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] f2fs: fix to cover read extent cache access with lock
Date: Mon, 12 May 2025 14:05:44 -0400
Message-Id: <20250511195936-bcaf6f53ebd59af9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509024654.3233384-1-jianqi.ren.cn@windriver.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: d7409b05a64f212735f0d33f5f1602051a886eab

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Chao Yu<chao@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 263df78166d3)

Note: The patch differs from the upstream commit:
---
1:  d7409b05a64f2 ! 1:  ac73e346ab4ec f2fs: fix to cover read extent cache access with lock
    @@ Metadata
      ## Commit message ##
         f2fs: fix to cover read extent cache access with lock
     
    +    [ Upstream commit d7409b05a64f212735f0d33f5f1602051a886eab ]
    +
         syzbot reports a f2fs bug as below:
     
         BUG: KASAN: slab-use-after-free in sanity_check_extent_cache+0x370/0x410 fs/f2fs/extent_cache.c:46
    @@ Commit message
         Closes: https://lore.kernel.org/linux-f2fs-devel/00000000000009beea061740a531@google.com
         Signed-off-by: Chao Yu <chao@kernel.org>
         Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
    +    [Minor conflict resolved due to code context change.]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## fs/f2fs/extent_cache.c ##
     @@
    @@ fs/f2fs/extent_cache.c
      {
      	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
     -	struct f2fs_inode_info *fi = F2FS_I(inode);
    --	struct extent_tree *et = fi->extent_tree[EX_READ];
     -	struct extent_info *ei;
    --
    --	if (!et)
    --		return true;
     +	struct f2fs_extent *i_ext = &F2FS_INODE(ipage)->i_ext;
     +	struct extent_info ei;
      
    --	ei = &et->largest;
    --	if (!ei->len)
    +-	if (!fi->extent_tree[EX_READ])
     -		return true;
     +	get_read_extent_info(&ei, i_ext);
      
    --	/* Let's drop, if checkpoint got corrupted. */
    --	if (is_set_ckpt_flags(sbi, CP_ERROR_FLAG)) {
    --		ei->len = 0;
    --		et->largest_updated = true;
    +-	ei = &fi->extent_tree[EX_READ]->largest;
     +	if (!ei.len)
    - 		return true;
    --	}
    ++		return true;
      
    --	if (!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE) ||
    --	    !f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
    +-	if (ei->len &&
    +-		(!f2fs_is_valid_blkaddr(sbi, ei->blk,
    +-					DATA_GENERIC_ENHANCE) ||
    +-		!f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
    +-					DATA_GENERIC_ENHANCE))) {
    +-		set_sbi_flag(sbi, SBI_NEED_FSCK);
     +	if (!f2fs_is_valid_blkaddr(sbi, ei.blk, DATA_GENERIC_ENHANCE) ||
     +	    !f2fs_is_valid_blkaddr(sbi, ei.blk + ei.len - 1,
    - 					DATA_GENERIC_ENHANCE)) {
    ++					DATA_GENERIC_ENHANCE)) {
      		f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
      			  __func__, inode->i_ino,
     -			  ei->blk, ei->fofs, ei->len);
    @@ fs/f2fs/extent_cache.c: void f2fs_init_read_extent_tree(struct inode *inode, str
     -		set_inode_flag(inode, FI_NO_EXTENT);
      }
      
    - void f2fs_init_age_extent_tree(struct inode *inode)
    + void f2fs_init_extent_tree(struct inode *inode)
     
      ## fs/f2fs/f2fs.h ##
     @@ fs/f2fs/f2fs.h: void f2fs_leave_shrinker(struct f2fs_sb_info *sbi);
    @@ fs/f2fs/f2fs.h: void f2fs_leave_shrinker(struct f2fs_sb_info *sbi);
       */
     -bool sanity_check_extent_cache(struct inode *inode);
     +bool sanity_check_extent_cache(struct inode *inode, struct page *ipage);
    - void f2fs_init_extent_tree(struct inode *inode);
    - void f2fs_drop_extent_tree(struct inode *inode);
    - void f2fs_destroy_extent_node(struct inode *inode);
    + struct rb_entry *f2fs_lookup_rb_tree(struct rb_root_cached *root,
    + 				struct rb_entry *cached_re, unsigned int ofs);
    + struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
     
      ## fs/f2fs/inode.c ##
     @@ fs/f2fs/inode.c: static int do_read_inode(struct inode *inode)
    @@ fs/f2fs/inode.c: static int do_read_inode(struct inode *inode)
      
     -	/* Need all the flag bits */
     -	f2fs_init_read_extent_tree(inode, node_page);
    --	f2fs_init_age_extent_tree(inode);
     -
     -	if (!sanity_check_extent_cache(inode)) {
     +	if (!sanity_check_extent_cache(inode, node_page)) {
    @@ fs/f2fs/inode.c: static int do_read_inode(struct inode *inode)
      
     +	/* Need all the flag bits */
     +	f2fs_init_read_extent_tree(inode, node_page);
    -+	f2fs_init_age_extent_tree(inode);
     +
      	f2fs_put_page(node_page, 1);
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

