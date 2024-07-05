Return-Path: <stable+bounces-58102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39D99280F2
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 05:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89445285FC1
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 03:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDEF17571;
	Fri,  5 Jul 2024 03:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Whrx3S79"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDF54C70
	for <stable@vger.kernel.org>; Fri,  5 Jul 2024 03:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720150302; cv=none; b=UotvLj2X7MY2EhE3hPU7HoohdbfpBk6C417bUXZe1LeiypMZSvfbZQd67Eleq2Y1yG7+D2p7KALLCLeoAzm4w82dXj62AE8Y+u2v0gxnZ0LnOoVXaOrviaJQAes4yuaqxjGKQmz/KcZLf4VxqqnwdSOWFtbWT9UDlxvcWuJ0RCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720150302; c=relaxed/simple;
	bh=ewvGDXC/oaZqmx9YwPZQma7o8HkfeSCNzB4HQ1lQ2gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqH7beMhalYc0YTaIbXc5ZNCPPY1M+uD20JAZHGB0yPP0Ku4G23bwTAZ6qv43ZGmcF8Z0bApmS47DPh9EcZgx/Eg/W5fxtQ/zR6y6NEWyEk3mWY80FCxjj1PeR+B3UMmid/7WIS7FC+2n4jUKNp7k9RgmiTzOopMAzgqGiaO28I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Whrx3S79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32267C116B1;
	Fri,  5 Jul 2024 03:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720150302;
	bh=ewvGDXC/oaZqmx9YwPZQma7o8HkfeSCNzB4HQ1lQ2gg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Whrx3S79MpSMHptgttRWKx90wBdprGvI0F7s9iuTS1Wz/8FkFIU/zkBAlJ4mNJEaY
	 cJXAIfe6SfuJGNV85Jgwp5Zu7RYtZy3nLmvXMCufyDYJ27vYUqNQ7XtKOy6Fe/OoZm
	 +qhWSvIJYG2waLz4jEfvWv/V+v6rsTa4IpTspnEJl50+n7zOvivR+Sp2/dKZ7xQs2x
	 2BEryv9EoLwuzNMymVZgTCT29YBvhKRSwwCdPwbLmbj8HP9dWv0E2AMZ8pRVK0rg1+
	 8sUIHVWt7rbyxV6cJAR5XD/EF+/EP+4wHSmpw58W1eqacSQdb/k0IKUZKF2hMMDVUa
	 cHmxRh76OPG4g==
Message-ID: <b8db6396-3f44-4a58-a4ef-c413c4a1ea1b@kernel.org>
Date: Fri, 5 Jul 2024 11:31:36 +0800
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
 stable@vger.kernel.org, 'Sungjong Seo' <sj1557.seo@samsung.com>,
 'Yeongjin Gil' <youngjin.gil@samsung.com>
References: <CGME20240702120631epcas1p1c7044f77b56009471e2dc07d4e135a99@epcas1p1.samsung.com>
 <20240702120624.476067-1-s_min.jeong@samsung.com>
 <5d8802d6-0132-4986-8238-9385d1758719@kernel.org>
 <000001dace8a$f97d2d30$ec778790$@samsung.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <000001dace8a$f97d2d30$ec778790$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/5 11:25, Sunmin Jeong wrote:
> Hi Chao Yu,
> 
>>> The page cache of the atomic file keeps new data pages which will be
>>> stored in the COW file. It can also keep old data pages when GCing the
>>> atomic file. In this case, new data can be overwritten by old data if
>>> a GC thread sets the old data page as dirty after new data page was
>>> evicted.
>>>
>>> Also, since all writes to the atomic file are redirected to COW
>>> inodes, GC for the atomic file is not working well as below.
>>>
>>> f2fs_gc(gc_type=FG_GC)
>>>     - select A as a victim segment
>>>     do_garbage_collect
>>>       - iget atomic file's inode for block B
>>>       move_data_page
>>>         f2fs_do_write_data_page
>>>           - use dn of cow inode
>>>           - set fio->old_blkaddr from cow inode
>>>       - seg_freed is 0 since block B is still valid
>>>     - goto gc_more and A is selected as victim again
>>>
>>> To solve the problem, let's separate GC writes and updates in the
>>> atomic file by using the meta inode for GC writes.
>>>
>>> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
>>> Cc: stable@vger.kernel.org #v5.19+
>>> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
>>> Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
>>> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
>>> ---
>>>    fs/f2fs/f2fs.h    | 5 +++++
>>>    fs/f2fs/gc.c      | 6 +++---
>>>    fs/f2fs/segment.c | 4 ++--
>>>    3 files changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h index
>>> a000cb024dbe..59c5117e54b1 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -4267,6 +4267,11 @@ static inline bool f2fs_post_read_required(struct
>> inode *inode)
>>>    		f2fs_compressed_file(inode);
>>>    }
>>>
>>> +static inline bool f2fs_meta_inode_gc_required(struct inode *inode) {
>>> +	return f2fs_post_read_required(inode) || f2fs_is_atomic_file(inode);
>>> +}
>>> +
>>>    /*
>>>     * compress.c
>>>     */
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c index
>>> a079eebfb080..136b9e8180a3 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -1580,7 +1580,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi,
>> struct f2fs_summary *sum,
>>>    			start_bidx = f2fs_start_bidx_of_node(nofs, inode) +
>>>    								ofs_in_node;
>>>
>>> -			if (f2fs_post_read_required(inode)) {
>>> +			if (f2fs_meta_inode_gc_required(inode)) {
>>>    				int err = ra_data_block(inode, start_bidx);
>>>
>>>    				f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>> @@ -1631,7 +1631,7 @@ static int gc_data_segment(struct f2fs_sb_info
>>> *sbi, struct f2fs_summary *sum,
>>>
>>>    			start_bidx = f2fs_start_bidx_of_node(nofs, inode)
>>>    								+ ofs_in_node;
>>> -			if (f2fs_post_read_required(inode))
>>> +			if (f2fs_meta_inode_gc_required(inode))
>>>    				err = move_data_block(inode, start_bidx,
>>>    							gc_type, segno, off);
>>>    			else
>>> @@ -1639,7 +1639,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi,
>> struct f2fs_summary *sum,
>>>    								segno, off);
>>>
>>>    			if (!err && (gc_type == FG_GC ||
>>> -					f2fs_post_read_required(inode)))
>>> +					f2fs_meta_inode_gc_required(inode)))
>>>    				submitted++;
>>>
>>>    			if (locked) {
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c index
>>> 7e47b8054413..b55fc4bd416a 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -3823,7 +3823,7 @@ void f2fs_wait_on_block_writeback(struct inode
>> *inode, block_t blkaddr)
>>>    	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>    	struct page *cpage;
>>>
>>> -	if (!f2fs_post_read_required(inode))
>>> +	if (!f2fs_meta_inode_gc_required(inode))
>>>    		return;
>>>
>>>    	if (!__is_valid_data_blkaddr(blkaddr))
>>> @@ -3842,7 +3842,7 @@ void f2fs_wait_on_block_writeback_range(struct
>> inode *inode, block_t blkaddr,
>>>    	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>    	block_t i;
>>>
>>> -	if (!f2fs_post_read_required(inode))
>>> +	if (!f2fs_meta_inode_gc_required(inode))
>>>    		return;
>>>
>>>    	for (i = 0; i < len; i++)
>>
>> f2fs_write_single_data_page()
>> ...
>> 		.post_read = f2fs_post_read_required(inode) ? 1 : 0,
>>
>> Do we need to use f2fs_meta_inode_gc_required() here?
>>
>> Thanks,
> 
> As you said, we need to use f2fs_meta_inode_gc_required instead of
> f2fs_post_read_required. Then what about changing the variable name
> "post_read" to another one such as "meta_gc"?

Sunmin, yes, I think so.

Thanks,

> struct f2fs_io_info {
>      unsigned int post_read:1;   /* require post read */
> 
> Thanks,
> 

