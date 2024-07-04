Return-Path: <stable+bounces-58020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAD59270D3
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 09:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E30A1C21AF9
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 07:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D75E19DF6C;
	Thu,  4 Jul 2024 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dChIPkp1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F534143871
	for <stable@vger.kernel.org>; Thu,  4 Jul 2024 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079085; cv=none; b=f4Au2S1zkdPtdf6D8NN6J0pVKsqcNTlsLM9ZjOEQ3pyOLRHvzTrfWKoXFZ4NFvL75x1oIT4BiaO37fdSW292TWHPkpFZp76HRWOh5poGhT5iYX0l/wg3hV6yMEErXlb2UY7Q2IeZZ2eu1G7gzjPB6I0hVbvUaiYZPoGI5XPmoXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079085; c=relaxed/simple;
	bh=QMYeZL7iAENWFwunV2w3darPwFTKFzKYMy4cqGU95WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLQqubBruvo42BAMjxMIhmPCUuOSuXrRbdsY/oc0jrV8Qw5CfjFiaz70s+jL9w2vHHhqauajm703uvBfpdmcHvUzUg4SQYZ/EYg1ZQvfLpKStnxfuOpm9h7mjZjjqZJO5XMMLxWVelAQLBwEbpk1owNDTv7s91tXi1MRuJQFznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dChIPkp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE88C3277B;
	Thu,  4 Jul 2024 07:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720079084;
	bh=QMYeZL7iAENWFwunV2w3darPwFTKFzKYMy4cqGU95WY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dChIPkp1IP3UVuUqCvOBH4x1lxjcnH5EjrU5yKtjGlWkkjN+VYMB/JQG8gr9GiSU9
	 CcDhsHnkTKWQLWmgUWBgc55898/Ks5bmp7J7tql3LrQIvVRyct0lh3ywT038+77O9m
	 jVI9ZzGw6MYXrqGgCouhHh4D5QGms8ks/tCbkwqYNE2/IlFT0rf9D0rDGhDxFh3yUq
	 AfT1C16DkdWhsvGea148AmHVPgUu5diX2OJcYkYbIchME3rBcMqs0cv2Mk6om1RLE0
	 8k2MNFhwZQQMQv0fPeDJkqVdwVPGE+vlMVfV+i7FTWWqgPiQNdEsruEwQluQxhaRjr
	 mWX9CthCcGq8Q==
Message-ID: <c9d66cc2-5990-450f-9ede-be8244c607a9@kernel.org>
Date: Thu, 4 Jul 2024 15:44:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] f2fs: use meta inode for GC of COW file
To: Sunmin Jeong <s_min.jeong@samsung.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, daehojeong@google.com,
 stable@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
 Yeongjin Gil <youngjin.gil@samsung.com>
References: <CGME20240702120643epcas1p4b98b4bfef3b3ef72cf50737697b67eeb@epcas1p4.samsung.com>
 <20240702120636.476119-1-s_min.jeong@samsung.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240702120636.476119-1-s_min.jeong@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/2 20:06, Sunmin Jeong wrote:
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
>   fs/f2fs/data.c   |  2 +-
>   fs/f2fs/f2fs.h   |  7 ++++++-
>   fs/f2fs/file.c   |  3 +++
>   fs/f2fs/gc.c     | 12 ++++++++++--
>   fs/f2fs/inline.c |  2 +-
>   fs/f2fs/inode.c  |  3 ++-
>   6 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 05158f89ef32..90ff0f6f7f7f 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2651,7 +2651,7 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>   		return true;
>   	if (IS_NOQUOTA(inode))
>   		return true;
> -	if (f2fs_is_atomic_file(inode))
> +	if (f2fs_used_in_atomic_write(inode))
>   		return true;
>   	/* rewrite low ratio compress data w/ OPU mode to avoid fragmentation */
>   	if (f2fs_compressed_file(inode) &&
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 59c5117e54b1..4f9fd1c1d024 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4267,9 +4267,14 @@ static inline bool f2fs_post_read_required(struct inode *inode)
>   		f2fs_compressed_file(inode);
>   }
>   
> +static inline bool f2fs_used_in_atomic_write(struct inode *inode)
> +{
> +	return f2fs_is_atomic_file(inode) || f2fs_is_cow_file(inode);
> +}
> +
>   static inline bool f2fs_meta_inode_gc_required(struct inode *inode)
>   {
> -	return f2fs_post_read_required(inode) || f2fs_is_atomic_file(inode);
> +	return f2fs_post_read_required(inode) || f2fs_used_in_atomic_write(inode);
>   }
>   
>   /*
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 25b119cf3499..c9f0ba658cfd 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2116,6 +2116,9 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>   
>   		set_inode_flag(fi->cow_inode, FI_COW_FILE);
>   		clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
> +
> +		/* Set the COW inode's cow_inode to the atomic inode */
> +		F2FS_I(fi->cow_inode)->cow_inode = inode;

How about adding a union fields as below for readability?

struct f2fs_inode_info {
...
	union {
		struct inode *cow_inode;	/* copy-on-write inode for atomic write */
		struct inode *atomic_inode;	/* point to atomic_inode, available only for cow_inode */
	};
...
};

Thanks,

>   	} else {
>   		/* Reuse the already created COW inode */
>   		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 136b9e8180a3..76854e732b35 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1188,7 +1188,11 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
>   	};
>   	int err;
>   
> -	page = f2fs_grab_cache_page(mapping, index, true);
> +	if (f2fs_is_cow_file(inode))
> +		page = f2fs_grab_cache_page(F2FS_I(inode)->cow_inode->i_mapping,
> +						index, true);
> +	else
> +		page = f2fs_grab_cache_page(mapping, index, true);
>   	if (!page)
>   		return -ENOMEM;
>   
> @@ -1287,7 +1291,11 @@ static int move_data_block(struct inode *inode, block_t bidx,
>   				CURSEG_ALL_DATA_ATGC : CURSEG_COLD_DATA;
>   
>   	/* do not read out */
> -	page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
> +	if (f2fs_is_cow_file(inode))
> +		page = f2fs_grab_cache_page(F2FS_I(inode)->cow_inode->i_mapping,
> +						bidx, false);
> +	else
> +		page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
>   	if (!page)
>   		return -ENOMEM;
>   
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index ac00423f117b..0186ec049db6 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -16,7 +16,7 @@
>   
>   static bool support_inline_data(struct inode *inode)
>   {
> -	if (f2fs_is_atomic_file(inode))
> +	if (f2fs_used_in_atomic_write(inode))
>   		return false;
>   	if (!S_ISREG(inode->i_mode) && !S_ISLNK(inode->i_mode))
>   		return false;
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index c26effdce9aa..c810304e2681 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -807,8 +807,9 @@ void f2fs_evict_inode(struct inode *inode)
>   
>   	f2fs_abort_atomic_write(inode, true);
>   
> -	if (fi->cow_inode) {
> +	if (fi->cow_inode && f2fs_is_cow_file(fi->cow_inode)) {
>   		clear_inode_flag(fi->cow_inode, FI_COW_FILE);
> +		F2FS_I(fi->cow_inode)->cow_inode = NULL;
>   		iput(fi->cow_inode);
>   		fi->cow_inode = NULL;
>   	}

