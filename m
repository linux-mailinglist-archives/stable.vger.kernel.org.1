Return-Path: <stable+bounces-58017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149F1927092
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 09:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FE00B2447B
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 07:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2951A0B0B;
	Thu,  4 Jul 2024 07:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN5Psmmj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB5FBF6
	for <stable@vger.kernel.org>; Thu,  4 Jul 2024 07:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078173; cv=none; b=r8gOnITw55JADnhfXvfAB9/sTfCgJkPcRI2JjeIvfJJK8C0Ulk1vVYANGZaJ5YNSTPIlnA0PlWBIwN79isDMUE1TleEPQQ3RLqZmsCY90a833K7yFSjeQNCE3BhduI6dIOOrQgzzVEde4s+SVx8SHSlyvVfO4yWoHNrJ6kZTxHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078173; c=relaxed/simple;
	bh=rXlG36XXP03P3vm34Nm3zetfWK4IvqNBp3LU4LgW9ZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LB1yo1UgWKEzZH04qwA9XN9OKM/7z+MlIiF5j+tf7AOn2yxV0169mUCtVrBTCDyLFLOy3NHfAqVOEF+bRl8Wq8e9UM/iUaIxcaPp+UoFWfs7Ry3y8d0kwANG7qf7NDkyTluKYaNDiqTMnPZ7YwWyiqXTvUXTO8NBnG+EbTDS0eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN5Psmmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB94C3277B;
	Thu,  4 Jul 2024 07:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720078173;
	bh=rXlG36XXP03P3vm34Nm3zetfWK4IvqNBp3LU4LgW9ZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eN5Psmmjywz+WsV1Qc9tL7H5W/NKERKpwbh7wtrlaq/VHCPk0TfWgb6VlUCVzFshK
	 bK/jKRnnpCv/1CPZzsNIZPAWxm6Dl4iQNYSIHv0cK8a6w93JF+11NeD56Ek/B27LY+
	 onAUti07AVh06i8+Y342T/XX+hG0jbgDu1hdKMly0pzFp5m6KEvGbJy1YE3bZVuDWj
	 kgPslXe0p6H9TOZNyf/cy/XCbgoh+UX60pk87NhZFeTiPKMyIAZ1uijgBUnvsCPOuC
	 CfwsMM83dtrWmOq04l/63Qvff9NBJdp/FUT0AmjwpOec5zB3tlLI4aXudP9QpTQFwE
	 FD81yAoQDeSlA==
Message-ID: <5d8802d6-0132-4986-8238-9385d1758719@kernel.org>
Date: Thu, 4 Jul 2024 15:29:28 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] f2fs: use meta inode for GC of atomic file
To: Sunmin Jeong <s_min.jeong@samsung.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, daehojeong@google.com,
 stable@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
 Yeongjin Gil <youngjin.gil@samsung.com>
References: <CGME20240702120631epcas1p1c7044f77b56009471e2dc07d4e135a99@epcas1p1.samsung.com>
 <20240702120624.476067-1-s_min.jeong@samsung.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240702120624.476067-1-s_min.jeong@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/2 20:06, Sunmin Jeong wrote:
> The page cache of the atomic file keeps new data pages which will be
> stored in the COW file. It can also keep old data pages when GCing the
> atomic file. In this case, new data can be overwritten by old data if a
> GC thread sets the old data page as dirty after new data page was
> evicted.
> 
> Also, since all writes to the atomic file are redirected to COW inodes,
> GC for the atomic file is not working well as below.
> 
> f2fs_gc(gc_type=FG_GC)
>    - select A as a victim segment
>    do_garbage_collect
>      - iget atomic file's inode for block B
>      move_data_page
>        f2fs_do_write_data_page
>          - use dn of cow inode
>          - set fio->old_blkaddr from cow inode
>      - seg_freed is 0 since block B is still valid
>    - goto gc_more and A is selected as victim again
> 
> To solve the problem, let's separate GC writes and updates in the atomic
> file by using the meta inode for GC writes.
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Cc: stable@vger.kernel.org #v5.19+
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
> ---
>   fs/f2fs/f2fs.h    | 5 +++++
>   fs/f2fs/gc.c      | 6 +++---
>   fs/f2fs/segment.c | 4 ++--
>   3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index a000cb024dbe..59c5117e54b1 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4267,6 +4267,11 @@ static inline bool f2fs_post_read_required(struct inode *inode)
>   		f2fs_compressed_file(inode);
>   }
>   
> +static inline bool f2fs_meta_inode_gc_required(struct inode *inode)
> +{
> +	return f2fs_post_read_required(inode) || f2fs_is_atomic_file(inode);
> +}
> +
>   /*
>    * compress.c
>    */
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index a079eebfb080..136b9e8180a3 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1580,7 +1580,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>   			start_bidx = f2fs_start_bidx_of_node(nofs, inode) +
>   								ofs_in_node;
>   
> -			if (f2fs_post_read_required(inode)) {
> +			if (f2fs_meta_inode_gc_required(inode)) {
>   				int err = ra_data_block(inode, start_bidx);
>   
>   				f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> @@ -1631,7 +1631,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>   
>   			start_bidx = f2fs_start_bidx_of_node(nofs, inode)
>   								+ ofs_in_node;
> -			if (f2fs_post_read_required(inode))
> +			if (f2fs_meta_inode_gc_required(inode))
>   				err = move_data_block(inode, start_bidx,
>   							gc_type, segno, off);
>   			else
> @@ -1639,7 +1639,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>   								segno, off);
>   
>   			if (!err && (gc_type == FG_GC ||
> -					f2fs_post_read_required(inode)))
> +					f2fs_meta_inode_gc_required(inode)))
>   				submitted++;
>   
>   			if (locked) {
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 7e47b8054413..b55fc4bd416a 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3823,7 +3823,7 @@ void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr)
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	struct page *cpage;
>   
> -	if (!f2fs_post_read_required(inode))
> +	if (!f2fs_meta_inode_gc_required(inode))
>   		return;
>   
>   	if (!__is_valid_data_blkaddr(blkaddr))
> @@ -3842,7 +3842,7 @@ void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	block_t i;
>   
> -	if (!f2fs_post_read_required(inode))
> +	if (!f2fs_meta_inode_gc_required(inode))
>   		return;
>   
>   	for (i = 0; i < len; i++)

f2fs_write_single_data_page()
...
		.post_read = f2fs_post_read_required(inode) ? 1 : 0,

Do we need to use f2fs_meta_inode_gc_required() here?

Thanks,

