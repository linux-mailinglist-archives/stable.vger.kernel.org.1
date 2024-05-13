Return-Path: <stable+bounces-43739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 410778C47DF
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 21:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5592B20958
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 19:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0A477F0B;
	Mon, 13 May 2024 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TfGvOFUF"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B21D3BB30
	for <stable@vger.kernel.org>; Mon, 13 May 2024 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629878; cv=none; b=uNktAmD8yCh/tCWGZzqdjwMPDSmmUNkynefIXk/MycqP4oa1zt5NLnA4eviM9+Chs7w+yWYpMocMqfaGk+NbGuGYw7nF9L3PSiyC6RiKcU0e2J9sDsoDP/oLWAkwF/dxka3i/WLkKWhGBbQRbi2CrfN2oTnwvcZGdcJrcikzIGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629878; c=relaxed/simple;
	bh=7xZo4n+O9XljkqIHZhBKT7ffLeOTYmjOlmqg8KuI1QY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KOoBgtZOVSjmVdhoNJ+q6Ip9QTbX6OX/2m1XYp+x4MQzvqMiSSqzSDDKZ3Ht82+4GagWNsI+9VzJb3qEAKZHLSskxJ4Ne5UCQ7Tx3Xg7o+k6i2iJA9qsIN8rUg9Hug317GedHk3BXMSth/pcEP8DWYWGqq5f9Ie5+v6nY0rii04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TfGvOFUF; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=39JHj6g8QNo0qy7zyiT3ljAU072D0eLedOFJfrsrOfM=; b=TfGvOFUF5m/vlpEHXR3LHad8KA
	wKHB7045qGcVreRVjQu0RJRx42fONds6bicXnwANP3OeoqeJuhRlJ7OCgbkpe8SldCpSaPWFvjG5W
	WOSev2nR2fKFP7noZQnfguTw0dfw0f6Ns1475fNX0AGc8+6jZnvYwcSBP3AqySGWTbx13BZHI0Ki1
	wkSmCJCVWGyvjI32sXgQoV41sQYsjXXYFEFhWFZgr059Z3lGU9HblXJm4V95ryY0NV9z7PogFkQP/
	7tKZu3vG8yioC/rQWeQsrYbMOioUXmpzYwKfDGQaTs2j/jDur6YWRvaEiL6cKOzEWYSpPMC2GrQv5
	9YyEgGgg==;
Received: from [179.232.147.2] (helo=[192.168.0.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1s6bhU-007fsz-De; Mon, 13 May 2024 21:51:08 +0200
Message-ID: <fc7a7af9-b8b9-5fa5-288d-f04d1d7a6437@igalia.com>
Date: Mon, 13 May 2024 16:51:02 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5.4.y] ext4: fix bug_on in __es_tree_search
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, kernel@gpiccoli.net,
 kernel-dev@igalia.com
References: <20240511211306.895465-1-gpiccoli@igalia.com>
In-Reply-To: <20240511211306.895465-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

CCing the right stable ML address...
Apologies!


On 11/05/2024 18:10, Guilherme G. Piccoli wrote:
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
> 
> 
>  fs/ext4/extents.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 98e1b1ddb4ec..90b12c7c0f20 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -409,7 +409,7 @@ static int ext4_valid_extent_entries(struct inode *inode,
>  {
>  	unsigned short entries;
>  	ext4_lblk_t lblock = 0;
> -	ext4_lblk_t prev = 0;
> +	ext4_lblk_t cur = 0;
>  
>  	if (eh->eh_entries == 0)
>  		return 1;
> @@ -435,12 +435,12 @@ static int ext4_valid_extent_entries(struct inode *inode,
>  
>  			/* Check for overlapping extents */
>  			lblock = le32_to_cpu(ext->ee_block);
> -			if ((lblock <= prev) && prev) {
> +			if (lblock < cur) {
>  				pblock = ext4_ext_pblock(ext);
>  				es->s_last_error_block = cpu_to_le64(pblock);
>  				return 0;
>  			}
> -			prev = lblock + ext4_ext_get_actual_len(ext) - 1;
> +			cur = lblock + ext4_ext_get_actual_len(ext);
>  			ext++;
>  			entries--;
>  		}
> @@ -460,13 +460,13 @@ static int ext4_valid_extent_entries(struct inode *inode,
>  
>  			/* Check for overlapping index extents */
>  			lblock = le32_to_cpu(ext_idx->ei_block);
> -			if ((lblock <= prev) && prev) {
> +			if (lblock < cur) {
>  				*pblk = ext4_idx_pblock(ext_idx);
>  				return 0;
>  			}
>  			ext_idx++;
>  			entries--;
> -			prev = lblock;
> +			cur = lblock + 1;
>  		}
>  	}
>  	return 1;

