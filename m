Return-Path: <stable+bounces-59394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E64093217C
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 09:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D121F21DB6
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 07:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1062BB02;
	Tue, 16 Jul 2024 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CHT5CYEA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E9224DD
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116202; cv=none; b=VvQhhmEscyIRd5eHCDBHNMZFIlWtlWvg+G3i4ZsrOIJjjEa976NqJlnPFsxLXvGEQRuf5xreZIsAuN33vQavpF/XnR7lEv+mItbHy+2Y2ptMkjlSbti7FanuORl5UExYGnx11T61ZMOMWxIyCih8S/Nm4qrvdG+NjU25KAZpb6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116202; c=relaxed/simple;
	bh=9WEOPNxxZLiUQpUPT3lCFVhiBuJN/xAzOgIHuyhfUZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/mzHOQzd2Lee9sfAsYy2GuYESy0w4WnB+ZRBhY8+9fOAjgPaf4Cz47yNrsFFkTdCeLuEnm0UquvGQu4zFf6zdlrKcSBZFiQ3AQ7xYJOOEl2FSynbH3TJcnP8LZlZjMmTlbPu+bFPXLlVEmzQMhOr4dSiQKoKNkYa49HJPRSopE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CHT5CYEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C75CC116B1;
	Tue, 16 Jul 2024 07:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721116202;
	bh=9WEOPNxxZLiUQpUPT3lCFVhiBuJN/xAzOgIHuyhfUZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CHT5CYEAU6cu2uA+9GvMmzbQ/1Bi9sCm5k4Ayvw2+TH8Dby0iCQxZAvyHx1fWfEyi
	 5jqQ/4Su3h4tNycH6xPNey/Vu+excW5zUkPrfANRdaRxTxsQEnKxms+b+K7IbOnQ4j
	 fFDj1nuvkfeTVtKp0t7r8R5Ih0cbc9hxBdqQcDm8=
Date: Tue, 16 Jul 2024 09:49:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: sashal@kernel.org, yangerkun@huawei.com, Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>, stable@vger.kernel.org
Subject: Re: [PATCH 6.6/6.9 v2 2/2] ext4: fix slab-out-of-bounds in
 ext4_mb_find_good_group_avg_frag_lists()
Message-ID: <2024071615-alienable-flirt-4ba6@gregkh>
References: <20240619121952.3508695-1-libaokun@huaweicloud.com>
 <20240619121952.3508695-2-libaokun@huaweicloud.com>
 <c8784653-bd67-4839-b2a4-bbbfbfa3ba14@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8784653-bd67-4839-b2a4-bbbfbfa3ba14@huaweicloud.com>

On Tue, Jul 16, 2024 at 10:11:55AM +0800, Baokun Li wrote:
> On 2024/6/19 20:19, libaokun@huaweicloud.com wrote:
> > From: Baokun Li <libaokun1@huawei.com>
> > 
> > [ Upstream commit 13df4d44a3aaabe61cd01d277b6ee23ead2a5206 ]
> > 
> > We can trigger a slab-out-of-bounds with the following commands:
> > 
> >      mkfs.ext4 -F /dev/$disk 10G
> >      mount /dev/$disk /tmp/test
> >      echo 2147483647 > /sys/fs/ext4/$disk/mb_group_prealloc
> >      echo test > /tmp/test/file && sync
> > 
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in ext4_mb_find_good_group_avg_frag_lists+0x8a/0x200 [ext4]
> > Read of size 8 at addr ffff888121b9d0f0 by task kworker/u2:0/11
> > CPU: 0 PID: 11 Comm: kworker/u2:0 Tainted: GL 6.7.0-next-20240118 #521
> > Call Trace:
> >   dump_stack_lvl+0x2c/0x50
> >   kasan_report+0xb6/0xf0
> >   ext4_mb_find_good_group_avg_frag_lists+0x8a/0x200 [ext4]
> >   ext4_mb_regular_allocator+0x19e9/0x2370 [ext4]
> >   ext4_mb_new_blocks+0x88a/0x1370 [ext4]
> >   ext4_ext_map_blocks+0x14f7/0x2390 [ext4]
> >   ext4_map_blocks+0x569/0xea0 [ext4]
> >   ext4_do_writepages+0x10f6/0x1bc0 [ext4]
> > [...]
> > ==================================================================
> > 
> > The flow of issue triggering is as follows:
> > 
> > // Set s_mb_group_prealloc to 2147483647 via sysfs
> > ext4_mb_new_blocks
> >    ext4_mb_normalize_request
> >      ext4_mb_normalize_group_request
> >        ac->ac_g_ex.fe_len = EXT4_SB(sb)->s_mb_group_prealloc
> >    ext4_mb_regular_allocator
> >      ext4_mb_choose_next_group
> >        ext4_mb_choose_next_group_best_avail
> >          mb_avg_fragment_size_order
> >            order = fls(len) - 2 = 29
> >          ext4_mb_find_good_group_avg_frag_lists
> >            frag_list = &sbi->s_mb_avg_fragment_size[order]
> >            if (list_empty(frag_list)) // Trigger SOOB!
> > 
> > At 4k block size, the length of the s_mb_avg_fragment_size list is 14,
> > but an oversized s_mb_group_prealloc is set, causing slab-out-of-bounds
> > to be triggered by an attempt to access an element at index 29.
> > 
> > Add a new attr_id attr_clusters_in_group with values in the range
> > [0, sbi->s_clusters_per_group] and declare mb_group_prealloc as
> > that type to fix the issue. In addition avoid returning an order
> > from mb_avg_fragment_size_order() greater than MB_NUM_ORDERS(sb)
> > and reduce some useless loops.
> > 
> > Fixes: 7e170922f06b ("ext4: Add allocation criteria 1.5 (CR1_5)")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > Link: https://lore.kernel.org/r/20240319113325.3110393-5-libaokun1@huawei.com
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > ---
> >   fs/ext4/mballoc.c |  4 ++++
> >   fs/ext4/sysfs.c   | 15 ++++++++++++++-
> >   2 files changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 714f83632e3f..66b5a68b0254 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -831,6 +831,8 @@ static int mb_avg_fragment_size_order(struct super_block *sb, ext4_grpblk_t len)
> >   		return 0;
> >   	if (order == MB_NUM_ORDERS(sb))
> >   		order--;
> > +	if (WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)))
> > +		order = MB_NUM_ORDERS(sb) - 1;
> >   	return order;
> >   }
> > @@ -1008,6 +1010,8 @@ static void ext4_mb_choose_next_group_best_avail(struct ext4_allocation_context
> >   	 * goal length.
> >   	 */
> >   	order = fls(ac->ac_g_ex.fe_len) - 1;
> > +	if (WARN_ON_ONCE(order - 1 > MB_NUM_ORDERS(ac->ac_sb)))
> > +		order = MB_NUM_ORDERS(ac->ac_sb);
> >   	min_order = order - sbi->s_mb_best_avail_max_trim_order;
> >   	if (min_order < 0)
> >   		min_order = 0;
> > diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> > index ca820620b974..d65dccb44ed5 100644
> > --- a/fs/ext4/sysfs.c
> > +++ b/fs/ext4/sysfs.c
> > @@ -29,6 +29,7 @@ typedef enum {
> >   	attr_trigger_test_error,
> >   	attr_first_error_time,
> >   	attr_last_error_time,
> > +	attr_clusters_in_group,
> >   	attr_feature,
> >   	attr_pointer_ui,
> >   	attr_pointer_ul,
> > @@ -207,13 +208,14 @@ EXT4_ATTR_FUNC(sra_exceeded_retry_limit, 0444);
> >   EXT4_ATTR_OFFSET(inode_readahead_blks, 0644, inode_readahead,
> >   		 ext4_sb_info, s_inode_readahead_blks);
> > +EXT4_ATTR_OFFSET(mb_group_prealloc, 0644, clusters_in_group,
> > +		 ext4_sb_info, s_mb_group_prealloc);
> >   EXT4_RW_ATTR_SBI_UI(inode_goal, s_inode_goal);
> >   EXT4_RW_ATTR_SBI_UI(mb_stats, s_mb_stats);
> >   EXT4_RW_ATTR_SBI_UI(mb_max_to_scan, s_mb_max_to_scan);
> >   EXT4_RW_ATTR_SBI_UI(mb_min_to_scan, s_mb_min_to_scan);
> >   EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
> >   EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
> > -EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
> >   EXT4_RW_ATTR_SBI_UI(mb_max_linear_groups, s_mb_max_linear_groups);
> >   EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
> >   EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
> > @@ -392,6 +394,7 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
> >   				(unsigned long long)
> >   			percpu_counter_sum(&sbi->s_sra_exceeded_retry_limit));
> >   	case attr_inode_readahead:
> > +	case attr_clusters_in_group:
> >   	case attr_pointer_ui:
> >   		if (!ptr)
> >   			return 0;
> > @@ -469,6 +472,16 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
> >   		else
> >   			*((unsigned int *) ptr) = t;
> >   		return len;
> > +	case attr_clusters_in_group:
> 
> Hi Greg,
> 
> > +		if (!ptr)
> > +			return 0;
> 
> I've found that the commit that eventually gets merged in doesn't have this
> judgment.
> 
> 6.6: 677ff4589f15 ("ext4: fix slab-out-of-bounds in
> ext4_mb_find_good_group_avg_frag_lists()")
> 6.9: b829687ae122 ("ext4: fix slab-out-of-bounds in
> ext4_mb_find_good_group_avg_frag_lists()")
> 
> This may result in a null pointer dereference.
> 
> 
> History:
> https://lore.kernel.org/all/0d620010-c6b4-4f80-a835-451813f957e3@huawei.com/
> https://lore.kernel.org/all/20240619121952.3508695-2-libaokun@huaweicloud.com/
> https://lore.kernel.org/all/20240625085542.189183696@linuxfoundation.org/

I don't understand, can you send a patch that fixes this?

Or should we just revert the original commits?  If so, what commit ids
need to be reverted?

thanks,

greg k-h

