Return-Path: <stable+bounces-81542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C25389943F5
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A8B1C22289
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 09:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006316DEB4;
	Tue,  8 Oct 2024 09:17:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB413C827
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379079; cv=none; b=Ldt05F66CaCgug7tBniYzd+q0W11dRYzaNTv5zi8zTzhLH/mFjS5RbOUFnOlqxdyguBLrZzML55/sL0nHzbUM5oMYeegYzLOXqIvKx8MyAsaOJBd0J30XLxHQZR0YV6YMS52HVJ/fpb5n3+XQaU4e6pzwFVbgmlf3Fh1xhmMPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379079; c=relaxed/simple;
	bh=ePH6PW23AU097SZNcxtUJsCdOlZBVdJHYcRef3Shofo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QLQZgOBe+XAS+SZihtv+LLEZMGkPJByskQYt9z3rqFC4jVW7f3VemnWTrN07ANypH3tSnOA1IcSbX3LjdhrLJBqYG6voghBW1AgBc69l5NJ+TgYe3E5o//FtRI3ILx7MSG6P3f8og4ADRchRU5z6PvK0gM7tHv4TiJ0I2iXylto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XN9QQ5Csjz20pc7;
	Tue,  8 Oct 2024 17:17:18 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 212BD1401F1;
	Tue,  8 Oct 2024 17:17:54 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpeml100021.china.huawei.com
 (7.185.36.148) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Oct
 2024 17:17:53 +0800
Message-ID: <d745523b-5fa5-411e-8799-f74affd0f6a8@huawei.com>
Date: Tue, 8 Oct 2024 17:17:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] ext4: fix slab-use-after-free in
 ext4_split_extent_at()" failed to apply to 4.19-stable tree
To: <gregkh@linuxfoundation.org>
CC: <tytso@mit.edu>, <jack@suse.cz>, <ojaswin@linux.ibm.com>,
	<stable@vger.kernel.org>, Yang Erkun <yangerkun@huawei.com>
References: <2024100717-untrue-mockup-9fb4@gregkh>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <2024100717-untrue-mockup-9fb4@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100021.china.huawei.com (7.185.36.148)

Hi greg,

On 2024/10/7 20:28, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 4.19-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
> git checkout FETCH_HEAD
> git cherry-pick -x c26ab35702f8cd0cdc78f96aa5856bfb77be798f
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100717-untrue-mockup-9fb4@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..
>
> Possible dependencies:
>
> c26ab35702f8 ("ext4: fix slab-use-after-free in ext4_split_extent_at()")
> 082cd4ec240b ("ext4: fix bug on in ext4_es_cache_extent as ext4_split_extent_at failed")
>
> thanks,
>
> greg k-h
The dependency for this patch is:
3f5424790d43 ("ext4: fix inode tree inconsistency caused by ENOMEM")

After applying this commit, there is no conflict when applying the
following two commits on the linux-4.19.y and linux-5.4.y branches:

c26ab35702f8 ("ext4: fix slab-use-after-free in ext4_split_extent_at()")
5b4b2dcace35 ("ext4: update orig_path in ext4_find_extent()")

Regards,
Baokun
>
> ------------------ original commit in Linus's tree ------------------
>
>  From c26ab35702f8cd0cdc78f96aa5856bfb77be798f Mon Sep 17 00:00:00 2001
> From: Baokun Li <libaokun1@huawei.com>
> Date: Thu, 22 Aug 2024 10:35:23 +0800
> Subject: [PATCH] ext4: fix slab-use-after-free in ext4_split_extent_at()
>
> We hit the following use-after-free:
>
> ==================================================================
> BUG: KASAN: slab-use-after-free in ext4_split_extent_at+0xba8/0xcc0
> Read of size 2 at addr ffff88810548ed08 by task kworker/u20:0/40
> CPU: 0 PID: 40 Comm: kworker/u20:0 Not tainted 6.9.0-dirty #724
> Call Trace:
>   <TASK>
>   kasan_report+0x93/0xc0
>   ext4_split_extent_at+0xba8/0xcc0
>   ext4_split_extent.isra.0+0x18f/0x500
>   ext4_split_convert_extents+0x275/0x750
>   ext4_ext_handle_unwritten_extents+0x73e/0x1580
>   ext4_ext_map_blocks+0xe20/0x2dc0
>   ext4_map_blocks+0x724/0x1700
>   ext4_do_writepages+0x12d6/0x2a70
> [...]
>
> Allocated by task 40:
>   __kmalloc_noprof+0x1ac/0x480
>   ext4_find_extent+0xf3b/0x1e70
>   ext4_ext_map_blocks+0x188/0x2dc0
>   ext4_map_blocks+0x724/0x1700
>   ext4_do_writepages+0x12d6/0x2a70
> [...]
>
> Freed by task 40:
>   kfree+0xf1/0x2b0
>   ext4_find_extent+0xa71/0x1e70
>   ext4_ext_insert_extent+0xa22/0x3260
>   ext4_split_extent_at+0x3ef/0xcc0
>   ext4_split_extent.isra.0+0x18f/0x500
>   ext4_split_convert_extents+0x275/0x750
>   ext4_ext_handle_unwritten_extents+0x73e/0x1580
>   ext4_ext_map_blocks+0xe20/0x2dc0
>   ext4_map_blocks+0x724/0x1700
>   ext4_do_writepages+0x12d6/0x2a70
> [...]
> ==================================================================
>
> The flow of issue triggering is as follows:
>
> ext4_split_extent_at
>    path = *ppath
>    ext4_ext_insert_extent(ppath)
>      ext4_ext_create_new_leaf(ppath)
>        ext4_find_extent(orig_path)
>          path = *orig_path
>          read_extent_tree_block
>            // return -ENOMEM or -EIO
>          ext4_free_ext_path(path)
>            kfree(path)
>          *orig_path = NULL
>    a. If err is -ENOMEM:
>    ext4_ext_dirty(path + path->p_depth)
>    // path use-after-free !!!
>    b. If err is -EIO and we have EXT_DEBUG defined:
>    ext4_ext_show_leaf(path)
>      eh = path[depth].p_hdr
>      // path also use-after-free !!!
>
> So when trying to zeroout or fix the extent length, call ext4_find_extent()
> to update the path.
>
> In addition we use *ppath directly as an ext4_ext_show_leaf() input to
> avoid possible use-after-free when EXT_DEBUG is defined, and to avoid
> unnecessary path updates.
>
> Fixes: dfe5080939ea ("ext4: drop EXT4_EX_NOFREE_ON_ERR from rest of extents handling code")
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Link: https://patch.msgid.link/20240822023545.1994557-4-libaokun@huaweicloud.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 4395e2b668ec..fe6bca63f9d6 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3251,6 +3251,25 @@ static int ext4_split_extent_at(handle_t *handle,
>   	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
>   		goto out;
>   
> +	/*
> +	 * Update path is required because previous ext4_ext_insert_extent()
> +	 * may have freed or reallocated the path. Using EXT4_EX_NOFAIL
> +	 * guarantees that ext4_find_extent() will not return -ENOMEM,
> +	 * otherwise -ENOMEM will cause a retry in do_writepages(), and a
> +	 * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
> +	 * an incorrect ee_len causing the i_reserved_data_blocks exception.
> +	 */
> +	path = ext4_find_extent(inode, ee_block, ppath,
> +				flags | EXT4_EX_NOFAIL);
> +	if (IS_ERR(path)) {
> +		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
> +				 split, PTR_ERR(path));
> +		return PTR_ERR(path);
> +	}
> +	depth = ext_depth(inode);
> +	ex = path[depth].p_ext;
> +	*ppath = path;
> +
>   	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
>   		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
>   			if (split_flag & EXT4_EXT_DATA_VALID1) {
> @@ -3303,7 +3322,7 @@ static int ext4_split_extent_at(handle_t *handle,
>   	ext4_ext_dirty(handle, inode, path + path->p_depth);
>   	return err;
>   out:
> -	ext4_ext_show_leaf(inode, path);
> +	ext4_ext_show_leaf(inode, *ppath);
>   	return err;
>   }
>   
>


