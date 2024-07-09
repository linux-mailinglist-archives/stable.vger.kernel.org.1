Return-Path: <stable+bounces-58934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D220992C41A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 21:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883FE2829DE
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 19:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC44182A6A;
	Tue,  9 Jul 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC6/JKL7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2F18004F
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720554611; cv=none; b=R5lSoYH6/4XVnM40y63guiT2N6kYJkC7gE6OVjEUcIh2WL/+91tpBEdNjW5sUWB6anqUj6TFWZqVmyFIsY5Vs8AudLKeDrOUCxVPX9iEPxkZ8xGLuphO3prMPzZPo9bOO2nBlP04K2jzUWDgLl/gXtEZq8zZIMdAFkyg4xXWnxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720554611; c=relaxed/simple;
	bh=wTpFruy4QlOp+IaKu4ahKKLhcoqKRDGxWh3lrQmJap8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MF+aM7HPkhmGaoKlf8krwoQXEwzLU1PnJbcVeppyAegYgU51S9EcbmjDdZbF4E5JT7bLkupg474z/QHVeW25mCQXAXCP4zzLCWECqzZUNzr4g2h3+FoaNt7ZCY4h2XMxhYGGFkGNi3o7vii9tlkwg/z/dRLByF/wjaiCMHWItIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC6/JKL7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D582FC3277B;
	Tue,  9 Jul 2024 19:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720554611;
	bh=wTpFruy4QlOp+IaKu4ahKKLhcoqKRDGxWh3lrQmJap8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DC6/JKL7/m5e30Rv7QkrOmXcfknkCtJMTiGeLiKL9/A2rbunwmgPe/6kdNUTzITca
	 0Y+sclCBd31eu4PAyhydU9cyYHjMSfRLi39Epyw4kQHjv+bUHNBwFNcZRHPlZT5c3P
	 XFEsSxxCyHOnrDkyZXXehgmfHniFcg7EwbzAeaEYE0xbToEk+pwWwMKSeEic8ROp0T
	 AOmezV8EXPRcHxDOqxJt2KCf5jl2DHc9LwbTpe74japDxV+VmWYHBlpoqoiZ0GBv0v
	 05SnICsKKYsijXT6D7enAidAj35coMu5x6q+5u5I4siIx4RifTheXbY2JN5ZPuQB3G
	 L9VH130yHHRMA==
Date: Tue, 9 Jul 2024 19:50:09 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Sunmin Jeong <s_min.jeong@samsung.com>
Cc: chao@kernel.org, daehojeong@google.com,
	linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yeongjin Gil <youngjin.gil@samsung.com>
Subject: Re: [PATCH v2 2/2] f2fs: use meta inode for GC of COW file
Message-ID: <Zo2UcW4AtAp2WTOy@google.com>
References: <CGME20240705082511epcas1p24b7b63d5e714a25213dbe07affa52f69@epcas1p2.samsung.com>
 <20240705082503.805358-1-s_min.jeong@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705082503.805358-1-s_min.jeong@samsung.com>

On 07/05, Sunmin Jeong wrote:
> In case of the COW file, new updates and GC writes are already
> separated to page caches of the atomic file and COW file. As some cases
> that use the meta inode for GC, there are some race issues between a
> foreground thread and GC thread.
> 
> To handle them, we need to take care when to invalidate and wait
> writeback of GC pages in COW files as the case of using the meta inode.
> Also, a pointer from the COW inode to the original inode is required to
> check the state of original pages.
> 
> For the former, we can solve the problem by using the meta inode for GC
> of COW files. Then let's get a page from the original inode in
> move_data_block when GCing the COW file to avoid race condition.
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Cc: stable@vger.kernel.org #v5.19+
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
> ---
> v2:
> - use union for cow inode to point to atomic inode
>  fs/f2fs/data.c   |  2 +-
>  fs/f2fs/f2fs.h   | 13 +++++++++++--
>  fs/f2fs/file.c   |  3 +++
>  fs/f2fs/gc.c     | 12 ++++++++++--
>  fs/f2fs/inline.c |  2 +-
>  fs/f2fs/inode.c  |  3 ++-
>  6 files changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 9a213d03005d..f6b1782f965a 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2606,7 +2606,7 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>  		return true;
>  	if (IS_NOQUOTA(inode))
>  		return true;
> -	if (f2fs_is_atomic_file(inode))
> +	if (f2fs_used_in_atomic_write(inode))
>  		return true;
>  	/* rewrite low ratio compress data w/ OPU mode to avoid fragmentation */
>  	if (f2fs_compressed_file(inode) &&
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 796ae11c0fa3..4a8621e4a33a 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -843,7 +843,11 @@ struct f2fs_inode_info {
>  	struct task_struct *atomic_write_task;	/* store atomic write task */
>  	struct extent_tree *extent_tree[NR_EXTENT_CACHES];
>  					/* cached extent_tree entry */
> -	struct inode *cow_inode;	/* copy-on-write inode for atomic write */
> +	union {
> +		struct inode *cow_inode;	/* copy-on-write inode for atomic write */
> +		struct inode *atomic_inode;
> +					/* point to atomic_inode, available only for cow_inode */
> +	};
>  
>  	/* avoid racing between foreground op and gc */
>  	struct f2fs_rwsem i_gc_rwsem[2];
> @@ -4263,9 +4267,14 @@ static inline bool f2fs_post_read_required(struct inode *inode)
>  		f2fs_compressed_file(inode);
>  }
>  
> +static inline bool f2fs_used_in_atomic_write(struct inode *inode)
> +{
> +	return f2fs_is_atomic_file(inode) || f2fs_is_cow_file(inode);
> +}
> +
>  static inline bool f2fs_meta_inode_gc_required(struct inode *inode)
>  {
> -	return f2fs_post_read_required(inode) || f2fs_is_atomic_file(inode);
> +	return f2fs_post_read_required(inode) || f2fs_used_in_atomic_write(inode);
>  }
>  
>  /*
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index e4a7cff00796..547e7ec32b1f 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2183,6 +2183,9 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>  
>  		set_inode_flag(fi->cow_inode, FI_COW_FILE);
>  		clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
> +
> +		/* Set the COW inode's atomic_inode to the atomic inode */
> +		F2FS_I(fi->cow_inode)->atomic_inode = inode;
>  	} else {
>  		/* Reuse the already created COW inode */
>  		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index cb3006551ab5..61913fcefd9e 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1186,7 +1186,11 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
>  	};
>  	int err;

How about giving the right mapping like this?

	mapping = f2fs_is_cow_file() ?
		F2FS_I(inode)->actomic_inode->i_mapping : inode->i_mapping;
	page = f2fs_grab_cache_page(mapping, index, true);

>  
> -	page = f2fs_grab_cache_page(mapping, index, true);
> +	if (f2fs_is_cow_file(inode))
> +		page = f2fs_grab_cache_page(F2FS_I(inode)->atomic_inode->i_mapping,
> +						index, true);
> +	else
> +		page = f2fs_grab_cache_page(mapping, index, true);
>  	if (!page)
>  		return -ENOMEM;
>  
> @@ -1282,7 +1286,11 @@ static int move_data_block(struct inode *inode, block_t bidx,
>  				CURSEG_ALL_DATA_ATGC : CURSEG_COLD_DATA;
>  
>  	/* do not read out */

ditto?

> -	page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
> +	if (f2fs_is_cow_file(inode))
> +		page = f2fs_grab_cache_page(F2FS_I(inode)->atomic_inode->i_mapping,
> +						bidx, false);
> +	else
> +		page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
>  	if (!page)
>  		return -ENOMEM;
>  
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 1fba5728be70..cca7d448e55c 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -16,7 +16,7 @@
>  
>  static bool support_inline_data(struct inode *inode)
>  {
> -	if (f2fs_is_atomic_file(inode))
> +	if (f2fs_used_in_atomic_write(inode))
>  		return false;
>  	if (!S_ISREG(inode->i_mode) && !S_ISLNK(inode->i_mode))
>  		return false;
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 7a3e2458b2d9..18dea43e694b 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -804,8 +804,9 @@ void f2fs_evict_inode(struct inode *inode)
>  
>  	f2fs_abort_atomic_write(inode, true);
>  
> -	if (fi->cow_inode) {
> +	if (fi->cow_inode && f2fs_is_cow_file(fi->cow_inode)) {
>  		clear_inode_flag(fi->cow_inode, FI_COW_FILE);
> +		F2FS_I(fi->cow_inode)->atomic_inode = NULL;
>  		iput(fi->cow_inode);
>  		fi->cow_inode = NULL;
>  	}
> -- 
> 2.25.1

