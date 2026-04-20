Return-Path: <stable+bounces-238711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFL6G73W5WnWoQEAu9opvQ
	(envelope-from <stable+bounces-238711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 09:33:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C94F0427C6B
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 09:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C56D03082ABA
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FFB385517;
	Mon, 20 Apr 2026 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnlqKjnt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB028385509
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670082; cv=none; b=rXG2hsNHStK1nOpJ5v6It57z4IP+X7WvWh8JfGmY3wSeMAceyA9dZitGV+BsxH7Juo2pG7LPT/EKKdu89YI7LGkpkF+JnI9OlL9FDbRQqrBM3lyxX+F0TcR0XF0gcBGM01zN+g0As6gZD5UTkHfZbYMy99muxMFyDsa3JQpkml4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670082; c=relaxed/simple;
	bh=VfNyN8J1po7I2Oq4NzVRZ4dNXszSRW8MHbghJgGs+hc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R7nWh4HNlgAX4rBelgDslme43Xy2KDZietiBxKqI8QzyQRUJPpdBwlVdovlzp8wM0Lz/8FSbzqe08o9FbHlwOVhwxhhNEIcFzeZ4DGcJOOZUcIiyNZY7B+/lpld8Obz3LjT0osHmlekoreqKKh/U3JxTass83XxBM/pFY2w8LDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnlqKjnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B24C19425;
	Mon, 20 Apr 2026 07:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776670082;
	bh=VfNyN8J1po7I2Oq4NzVRZ4dNXszSRW8MHbghJgGs+hc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YnlqKjnt9dP4wxw0fwrfPouQSCd/9z2n4zWVJzx5ACvwnrwJaWv6XR60Cxj0XLsjQ
	 YnCYOxtFfY5CLzD6cN+gkRS9B210EgJgqZFyu76Y6JxGcAYODDkHDZQuBQ13B1DC5K
	 H6d+Ty0IqKQirsOpBChCYd9lksPkOlBP23v2rdb5VOKCRvMs/1U+S45uwSBbo5bEs7
	 GlZKnlxiB8Qo/e3pkUS9qOSjHanwhzeIJ/ROpUF1Nillfn1Y7d5IvfDCGbJpA+uUhM
	 zQ9WI0tfQq+ztI5ORPyqj9wrkbUIDUwQgRxiWSjVUAADshEsFmHTPKcIId8NeYA9E2
	 453ycE+9TAw+w==
Message-ID: <bedd1951-681b-4364-80c9-c7fe6886c992@kernel.org>
Date: Mon, 20 Apr 2026 15:28:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix node_cnt race between extent node
 destroy and writeback
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260403144015.221811-3-monty_pavel@sina.com>
 <f997ceb6-85d1-4872-be06-2a50469b3b18@kernel.org>
 <5c222edf-6888-4007-9240-9e7988b2dc71@sina.com>
 <ac9d0f35-52dc-4371-a692-39c1d4ae5555@kernel.org>
 <a643b967-cb05-4de5-96f2-f1b783c9758d@sina.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <a643b967-cb05-4de5-96f2-f1b783c9758d@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[sina.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238711-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xiaomi.com:email]
X-Rspamd-Queue-Id: C94F0427C6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/19/2026 12:29 AM, Yongpeng Yang wrote:
> 
> On 4/18/26 8:51 AM, Chao Yu via Linux-f2fs-devel wrote:
>> On 4/17/26 21:26, Yongpeng Yang wrote:
>>>
>>> On 4/17/26 17:00, Chao Yu via Linux-f2fs-devel wrote:
>>>> On 4/3/26 22:40, Yongpeng Yang wrote:
>>>>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>>>>
>>>>> f2fs_destroy_extent_node() does not set FI_NO_EXTENT before clearing
>>>>> extent nodes. When called from f2fs_drop_inode() with I_SYNC set,
>>>>> concurrent kworker writeback can insert new extent nodes into the same
>>>>> extent tree, racing with the destroy and triggering f2fs_bug_on() in
>>>>> __destroy_extent_node(). The scenario is as follows:
>>>>>
>>>>> drop inode                            writeback
>>>>>     - iput
>>>>>      - f2fs_drop_inode  // I_SYNC set
>>>>>       - f2fs_destroy_extent_node
>>>>>        - __destroy_extent_node
>>>>>         - while (node_cnt) {
>>>>>            write_lock(&et->lock)
>>>>>            __free_extent_tree
>>>>>            write_unlock(&et->lock)
>>>>>                                           - __writeback_single_inode
>>>>>                                            - f2fs_outplace_write_data
>>>>>                                             -
>>>>> f2fs_update_read_extent_cache
>>>>>                                              -
>>>>> __update_extent_tree_range
>>>>>                                               // FI_NO_EXTENT not set,
>>>>>                                               // insert new extent node
>>>>>           } // node_cnt == 0, exit while
>>>>>         - f2fs_bug_on(node_cnt)  // node_cnt > 0
>>>>>
>>>>> Additionally, __update_extent_tree_range() only checks FI_NO_EXTENT for
>>>>> EX_READ type, leaving EX_BLOCK_AGE updates completely unprotected.
>>>>>
>>>>> This patch set FI_NO_EXTENT under et->lock in __destroy_extent_node(),
>>>>> consistent with other callers (__update_extent_tree_range and
>>>>> __drop_extent_tree) and check FI_NO_EXTENT for both EX_READ and
>>>>> EX_BLOCK_AGE tree.
>>>>
>>>> I suffered below test failure, then I bisect to this change.
>>>>
>>>>       generic/475  84s ... [failed, exit status 1]- output mismatch
>>>> (see /
>>>> share/git/fstests/results//generic/475.out.bad)
>>>>       --- tests/generic/475.out   2025-01-12 21:57:40.279440664 +0800
>>>>       +++ /share/git/fstests/results//generic/475.out.bad 2026-04-17
>>>> 12:08:28.000000000 +0800
>>>>       @@ -1,2 +1,6 @@
>>>>        QA output created by 475
>>>>        Silence is golden.
>>>>       +mount: /mnt/scratch_f2fs: mount system call failed: Structure
>>>> needs
>>>> cleaning.
>>>>       +       dmesg(1) may have more information after failed mount
>>>> system
>>>> call.
>>>>       +mount failed
>>>>       +(see /share/git/fstests/results//generic/475.full for details)
>>>>       ...
>>>>       (Run 'diff -u /share/git/fstests/tests/generic/475.out /share/git/
>>>> fstests/results//generic/475.out.bad'  to see the entire diff)
>>>>
>>>>
>>>>       generic/388  73s ... [failed, exit status 1]- output mismatch
>>>> (see /
>>>> share/git/fstests/results//generic/388.out.bad)
>>>>       --- tests/generic/388.out   2025-01-12 21:57:40.275440602 +0800
>>>>       +++ /share/git/fstests/results//generic/388.out.bad 2026-04-17
>>>> 11:58:05.000000000 +0800
>>>>       @@ -1,2 +1,6 @@
>>>>        QA output created by 388
>>>>        Silence is golden.
>>>>       +mount: /mnt/scratch_f2fs: mount system call failed: Structure
>>>> needs
>>>> cleaning.
>>>>       +       dmesg(1) may have more information after failed mount
>>>> system
>>>> call.
>>>>       +cycle mount failed
>>>>       +(see /share/git/fstests/results//generic/388.full for details)
>>>>       ...
>>>>       (Run 'diff -u /share/git/fstests/tests/generic/388.out /share/git/
>>>> fstests/results//generic/388.out.bad'  to see the entire diff)
>>>>
>>>>
>>>>       F2FS-fs (dm-0): sanity_check_extent_cache: inode (ino=1761) extent
>>>> info [220057, 57, 6] is incorrect, run fsck to fix
>>>>
>>>> I suspect we may miss any extent updates after we set FI_NO_EXTENT in
>>>> __destroy_extent_node(), result in failing in
>>>> sanity_check_extent_cache().
>>>>
>>>> Can we just relocate f2fs_bug_on(node_cnt) rather than complicated
>>>> change?
>>>> Thoughts?
>>>
>>> Oh, I overlooked largest extent. How about relocate
>>> f2fs_bug_on(node_cnt) to __destroy_extent_tree?
>>>
>>> static void __destroy_extent_tree(struct inode *inode, enum extent_type
>>> type)
>>>
>>>           /* free all extent info belong to this extent tree */
>>>           node_cnt = __destroy_extent_node(inode, type);
>>> +       f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
>>
>>       /* free all extent info belong to this extent tree */
>>       node_cnt = __destroy_extent_node(inode, type);
>>
>>       /* delete extent tree entry in radix tree */
>>       mutex_lock(&eti->extent_tree_lock);
>>       f2fs_bug_on(sbi, atomic_read(&et->node_cnt));  <---
>>
>> Oh, it has already checked node_cnt, so, maybe we can just remove the
>> check in
>> __destroy_extent_node()?
> 
> Yes. BTW, is it correct to remove the call to f2fs_destroy_extent_node()
> in f2fs_drop_inode()? It seems this call is unnecessary, since
> f2fs_evict_inode() will eventually delete all extent nodes properly.

I think it's fine to keep it according to original intention "destroy
extent_tree for the truncation case" introduced from 3e72f721390d
("f2fs: use extent_cache by default"). It helps the performance w/
in batch extent node release.

Thanks,

> 
> Thanks
> Yongpeng,
> 
>>
>> Thanks,
>>
>>
>>>
>>> Thanks
>>> Yongpeng,
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>> Fixes: 3fc5d5a182f6 ("f2fs: fix to shrink read extent node in batches")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>>>> ---
>>>>>     fs/f2fs/extent_cache.c | 17 ++++++++++-------
>>>>>     1 file changed, 10 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>>>>> index 0ed84cc065a7..87169fd29d89 100644
>>>>> --- a/fs/f2fs/extent_cache.c
>>>>> +++ b/fs/f2fs/extent_cache.c
>>>>> @@ -119,9 +119,10 @@ static bool __may_extent_tree(struct inode
>>>>> *inode, enum extent_type type)
>>>>>         if (!__init_may_extent_tree(inode, type))
>>>>>             return false;
>>>>>     +    if (is_inode_flag_set(inode, FI_NO_EXTENT))
>>>>> +        return false;
>>>>> +
>>>>>         if (type == EX_READ) {
>>>>> -        if (is_inode_flag_set(inode, FI_NO_EXTENT))
>>>>> -            return false;
>>>>>             if (is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
>>>>>                      !f2fs_sb_has_readonly(F2FS_I_SB(inode)))
>>>>>                 return false;
>>>>> @@ -644,6 +645,8 @@ static unsigned int __destroy_extent_node(struct
>>>>> inode *inode,
>>>>>           while (atomic_read(&et->node_cnt)) {
>>>>>             write_lock(&et->lock);
>>>>> +        if (!is_inode_flag_set(inode, FI_NO_EXTENT))
>>>>> +            set_inode_flag(inode, FI_NO_EXTENT);
>>>>>             node_cnt += __free_extent_tree(sbi, et, nr_shrink);
>>>>>             write_unlock(&et->lock);
>>>>>         }
>>>>> @@ -688,12 +691,12 @@ static void __update_extent_tree_range(struct
>>>>> inode *inode,
>>>>>           write_lock(&et->lock);
>>>>>     -    if (type == EX_READ) {
>>>>> -        if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
>>>>> -            write_unlock(&et->lock);
>>>>> -            return;
>>>>> -        }
>>>>> +    if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
>>>>> +        write_unlock(&et->lock);
>>>>> +        return;
>>>>> +    }
>>>>>     +    if (type == EX_READ) {
>>>>>             prev = et->largest;
>>>>>             dei.len = 0;
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-f2fs-devel mailing list
>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 


