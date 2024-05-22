Return-Path: <stable+bounces-45588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31968CC48D
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 17:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1DE281DA9
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 15:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675016EB5D;
	Wed, 22 May 2024 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SAOZ7srD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2522B25753
	for <stable@vger.kernel.org>; Wed, 22 May 2024 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716393301; cv=none; b=oM03YVuS/XxZLpssP2p7K9lM1p9OA3e+0QRMlEtICTRUOVN8SYMlSn0vn3ueponEE/qKVaHs6ycJMIkkCFPkYOwKh2JgNcJG2gVyUoNYCfT7Hc7JyVeAqumnvtNr/yNfZJ/OS5Onig1Sgj6FECKolm9QttjG2aCTuR57Lnmmi6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716393301; c=relaxed/simple;
	bh=3zo8tZSpH9rxa6ijsBN/H4ynAQMx3zvpSHgKaUPpEGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiERF5LY9dwJp0xUGM3B3pwFIPFapy4/qLXisHL2wM9UyN2GWLT1F4JNdZz8vK4betrZP9VS4s+weE7mULpNnTQ5ziDPNjJHUUbETAQAQbwKydp7bEcePI6JeEhmtvzRa7N35LVTDqkhAploE2KXZ1l5qjoNUWJ92zxbmZ+muFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SAOZ7srD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827C6C2BBFC;
	Wed, 22 May 2024 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716393300;
	bh=3zo8tZSpH9rxa6ijsBN/H4ynAQMx3zvpSHgKaUPpEGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAOZ7srDRIeTxMOfaUVeTzc0goivboPxW/UWbPIf/uWiB2aGXOliigakcLMI/90Bq
	 M9n9XOl6+2bCT2Cw1bU4HdLNL6nnBaaSJoqoEYcrFwnaKij0Sr/fMy9EdrovcAzwE0
	 XMr1y7TlQuXHVJ48cl4GSHG/S+bh8mbKY+0Bqbik=
Date: Wed, 22 May 2024 17:54:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, kernel@gpiccoli.net,
	kernel-dev@igalia.com
Subject: Re: [PATCH RESEND 5.4.y] ext4: fix bug_on in __es_tree_search
Message-ID: <2024052250-pledge-unvisited-3e8c@gregkh>
References: <20240513210211.929582-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513210211.929582-1-gpiccoli@igalia.com>

On Mon, May 13, 2024 at 05:59:31PM -0300, Guilherme G. Piccoli wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> commit d36f6ed761b53933b0b4126486c10d3da7751e7f upstream.
> 
> Hulk Robot reported a BUG_ON:
> ==================================================================
> kernel BUG at fs/ext4/extents_status.c:199!
> [...]
> RIP: 0010:ext4_es_end fs/ext4/extents_status.c:199 [inline]
> RIP: 0010:__es_tree_search+0x1e0/0x260 fs/ext4/extents_status.c:217
> [...]
> Call Trace:
>  ext4_es_cache_extent+0x109/0x340 fs/ext4/extents_status.c:766
>  ext4_cache_extents+0x239/0x2e0 fs/ext4/extents.c:561
>  ext4_find_extent+0x6b7/0xa20 fs/ext4/extents.c:964
>  ext4_ext_map_blocks+0x16b/0x4b70 fs/ext4/extents.c:4384
>  ext4_map_blocks+0xe26/0x19f0 fs/ext4/inode.c:567
>  ext4_getblk+0x320/0x4c0 fs/ext4/inode.c:980
>  ext4_bread+0x2d/0x170 fs/ext4/inode.c:1031
>  ext4_quota_read+0x248/0x320 fs/ext4/super.c:6257
>  v2_read_header+0x78/0x110 fs/quota/quota_v2.c:63
>  v2_check_quota_file+0x76/0x230 fs/quota/quota_v2.c:82
>  vfs_load_quota_inode+0x5d1/0x1530 fs/quota/dquot.c:2368
>  dquot_enable+0x28a/0x330 fs/quota/dquot.c:2490
>  ext4_quota_enable fs/ext4/super.c:6137 [inline]
>  ext4_enable_quotas+0x5d7/0x960 fs/ext4/super.c:6163
>  ext4_fill_super+0xa7c9/0xdc00 fs/ext4/super.c:4754
>  mount_bdev+0x2e9/0x3b0 fs/super.c:1158
>  mount_fs+0x4b/0x1e4 fs/super.c:1261
> [...]
> ==================================================================
> 
> Above issue may happen as follows:
> -------------------------------------
> ext4_fill_super
>  ext4_enable_quotas
>   ext4_quota_enable
>    ext4_iget
>     __ext4_iget
>      ext4_ext_check_inode
>       ext4_ext_check
>        __ext4_ext_check
>         ext4_valid_extent_entries
>          Check for overlapping extents does't take effect
>    dquot_enable
>     vfs_load_quota_inode
>      v2_check_quota_file
>       v2_read_header
>        ext4_quota_read
>         ext4_bread
>          ext4_getblk
>           ext4_map_blocks
>            ext4_ext_map_blocks
>             ext4_find_extent
>              ext4_cache_extents
>               ext4_es_cache_extent
>                ext4_es_cache_extent
>                 __es_tree_search
>                  ext4_es_end
>                   BUG_ON(es->es_lblk + es->es_len < es->es_lblk)
> 
> The error ext4 extents is as follows:
> 0af3 0300 0400 0000 00000000    extent_header
> 00000000 0100 0000 12000000     extent1
> 00000000 0100 0000 18000000     extent2
> 02000000 0400 0000 14000000     extent3
> 
> In the ext4_valid_extent_entries function,
> if prev is 0, no error is returned even if lblock<=prev.
> This was intended to skip the check on the first extent, but
> in the error image above, prev=0+1-1=0 when checking the second extent,
> so even though lblock<=prev, the function does not return an error.
> As a result, bug_ON occurs in __es_tree_search and the system panics.
> 
> To solve this problem, we only need to check that:
> 1. The lblock of the first extent is not less than 0.
> 2. The lblock of the next extent  is not less than
>    the next block of the previous extent.
> The same applies to extent_idx.
> 
> Cc: stable@kernel.org
> Fixes: 5946d089379a ("ext4: check for overlapping extents in ext4_valid_extent_entries()")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/r/20220518120816.1541863-1-libaokun1@huawei.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Reported-by: syzbot+2a58d88f0fb315c85363@syzkaller.appspotmail.com
> [gpiccoli: Manual backport due to unrelated missing patches.]
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
> 
> 
> Hey folks, this one should have been backported but due to merge
> issues [0], it ended-up not being on 5.4.y . So here is a working version!
> Cheers,
> 
> Guilherme
> 
> [0] https://lore.kernel.org/stable/165451751147179@kroah.com/

Now queued up, thanks.

greg k-h

