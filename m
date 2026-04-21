Return-Path: <stable+bounces-240095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDKKHKQ952no5QEAu9opvQ
	(envelope-from <stable+bounces-240095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:04:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9D5438942
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06C50300D4DF
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04E035837E;
	Tue, 21 Apr 2026 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmwCklvL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C834E746
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762271; cv=none; b=loZjGcWDCOBAts605/wXYLrKCKjK+bOqt1XOPqBMAGjPfJ+pw3d68AXhSuQmiEKAZmnzbpz5UQyXwIkhdh9ZuU5pkOEAu1HpdqNuqiPZPgxtDBeL/uh9ixbcyaI84Rt5ValQHG9v9t7rK3zyoUZFT1TIxiUVqTN0P7e29D7BV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762271; c=relaxed/simple;
	bh=A/KWQMopmFsUYglVJ2p0D/NDGUpoQO0F3Mg9epddvf0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HxH+87FuENczocJnb9SxWJHprMHEFoHkpC1VPKvno0dm00UcXqm4N9tkkIWLJlo/S4mvcCSZrrEI6H6CPdSfSiGICCMD6kpI63oQrkWRtsUXOf5vUJCSjahHYt9yviMBPX+3k8XKqmZo0FrIGLviOxT71ePUh7VfR8tAyYslSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmwCklvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9795AC2BCB0;
	Tue, 21 Apr 2026 09:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776762271;
	bh=A/KWQMopmFsUYglVJ2p0D/NDGUpoQO0F3Mg9epddvf0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=DmwCklvLzUKJH3u3+dzoMYnUG5sBHGSyhQPQf/nRr6aUEYcm2iT8F1g+EMK86wRfi
	 QmWO5pVnQ5aJvD2vAWaCnJlFj+TvAu34UwDK9SvwBbXAT+RF468hH4JY7fcrW9pJZP
	 peEtrrcllyU/wlrpZSox+z43E6aoMaZ0QtZgriixk/J0wU6nTdiOaB+wQ5sOD6m+OI
	 7ImaoR+a19GcLS7EZIyvZFjVZsMJwnMu0A4iW9aExHSZww52UaroU3Fwf9UoFay/YG
	 kdbzq73rzolHO7s2UPVHC9l3ffF9quSVK/2xif77PTZXkJjX5+KUovIiLxB9IIPfDX
	 /Cfn2Tic+c+pg==
Message-ID: <9b518ad1-18ad-4eb4-86d4-3a27e40a7635@kernel.org>
Date: Tue, 21 Apr 2026 17:04:25 +0800
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
 <bedd1951-681b-4364-80c9-c7fe6886c992@kernel.org>
 <252cb446-e313-417b-b780-85dcdcf34a87@sina.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <252cb446-e313-417b-b780-85dcdcf34a87@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[sina.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240095-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED9D5438942
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/2026 4:44 PM, Yongpeng Yang wrote:
> 
> On 4/20/26 15:28, Chao Yu via Linux-f2fs-devel wrote:
>> On 4/19/2026 12:29 AM, Yongpeng Yang wrote:
>>>
>>> On 4/18/26 8:51 AM, Chao Yu via Linux-f2fs-devel wrote:
>>>> On 4/17/26 21:26, Yongpeng Yang wrote:
>>>>>
>>>>> On 4/17/26 17:00, Chao Yu via Linux-f2fs-devel wrote:
>>>>>> On 4/3/26 22:40, Yongpeng Yang wrote:
>>>>>>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>>>>>>
>>>>>>> f2fs_destroy_extent_node() does not set FI_NO_EXTENT before clearing
>>>>>>> extent nodes. When called from f2fs_drop_inode() with I_SYNC set,
>>>>>>> concurrent kworker writeback can insert new extent nodes into the
>>>>>>> same
>>>>>>> extent tree, racing with the destroy and triggering f2fs_bug_on() in
>>>>>>> __destroy_extent_node(). The scenario is as follows:
>>>>>>>
>>>>>>> drop inode                            writeback
>>>>>>>      - iput
>>>>>>>       - f2fs_drop_inode  // I_SYNC set
>>>>>>>        - f2fs_destroy_extent_node
>>>>>>>         - __destroy_extent_node
>>>>>>>          - while (node_cnt) {
>>>>>>>             write_lock(&et->lock)
>>>>>>>             __free_extent_tree
>>>>>>>             write_unlock(&et->lock)
>>>>>>>                                            - __writeback_single_inode
>>>>>>>                                             - f2fs_outplace_write_data
>>>>>>>                                              -
>>>>>>> f2fs_update_read_extent_cache
>>>>>>>                                               -
>>>>>>> __update_extent_tree_range
>>>>>>>                                                // FI_NO_EXTENT not
>>>>>>> set,
>>>>>>>                                                // insert new extent
>>>>>>> node
>>>>>>>            } // node_cnt == 0, exit while
>>>>>>>          - f2fs_bug_on(node_cnt)  // node_cnt > 0
>>>>>>>
>>>>>>> Additionally, __update_extent_tree_range() only checks
>>>>>>> FI_NO_EXTENT for
>>>>>>> EX_READ type, leaving EX_BLOCK_AGE updates completely unprotected.
>>>>>>>
>>>>>>> This patch set FI_NO_EXTENT under et->lock in
>>>>>>> __destroy_extent_node(),
>>>>>>> consistent with other callers (__update_extent_tree_range and
>>>>>>> __drop_extent_tree) and check FI_NO_EXTENT for both EX_READ and
>>>>>>> EX_BLOCK_AGE tree.
>>>>>>
>>>>>> I suffered below test failure, then I bisect to this change.
>>>>>>
>>>>>>        generic/475  84s ... [failed, exit status 1]- output mismatch
>>>>>> (see /
>>>>>> share/git/fstests/results//generic/475.out.bad)
>>>>>>        --- tests/generic/475.out   2025-01-12 21:57:40.279440664 +0800
>>>>>>        +++ /share/git/fstests/results//generic/475.out.bad 2026-04-17
>>>>>> 12:08:28.000000000 +0800
>>>>>>        @@ -1,2 +1,6 @@
>>>>>>         QA output created by 475
>>>>>>         Silence is golden.
>>>>>>        +mount: /mnt/scratch_f2fs: mount system call failed: Structure
>>>>>> needs
>>>>>> cleaning.
>>>>>>        +       dmesg(1) may have more information after failed mount
>>>>>> system
>>>>>> call.
>>>>>>        +mount failed
>>>>>>        +(see /share/git/fstests/results//generic/475.full for details)
>>>>>>        ...
>>>>>>        (Run 'diff -u /share/git/fstests/tests/generic/475.out /
>>>>>> share/git/
>>>>>> fstests/results//generic/475.out.bad'  to see the entire diff)
>>>>>>
>>>>>>
>>>>>>        generic/388  73s ... [failed, exit status 1]- output mismatch
>>>>>> (see /
>>>>>> share/git/fstests/results//generic/388.out.bad)
>>>>>>        --- tests/generic/388.out   2025-01-12 21:57:40.275440602 +0800
>>>>>>        +++ /share/git/fstests/results//generic/388.out.bad 2026-04-17
>>>>>> 11:58:05.000000000 +0800
>>>>>>        @@ -1,2 +1,6 @@
>>>>>>         QA output created by 388
>>>>>>         Silence is golden.
>>>>>>        +mount: /mnt/scratch_f2fs: mount system call failed: Structure
>>>>>> needs
>>>>>> cleaning.
>>>>>>        +       dmesg(1) may have more information after failed mount
>>>>>> system
>>>>>> call.
>>>>>>        +cycle mount failed
>>>>>>        +(see /share/git/fstests/results//generic/388.full for details)
>>>>>>        ...
>>>>>>        (Run 'diff -u /share/git/fstests/tests/generic/388.out /
>>>>>> share/git/
>>>>>> fstests/results//generic/388.out.bad'  to see the entire diff)
>>>>>>
>>>>>>
>>>>>>        F2FS-fs (dm-0): sanity_check_extent_cache: inode (ino=1761)
>>>>>> extent
>>>>>> info [220057, 57, 6] is incorrect, run fsck to fix
>>>>>>
>>>>>> I suspect we may miss any extent updates after we set FI_NO_EXTENT in
>>>>>> __destroy_extent_node(), result in failing in
>>>>>> sanity_check_extent_cache().
>>>>>>
>>>>>> Can we just relocate f2fs_bug_on(node_cnt) rather than complicated
>>>>>> change?
>>>>>> Thoughts?
>>>>>
>>>>> Oh, I overlooked largest extent. How about relocate
>>>>> f2fs_bug_on(node_cnt) to __destroy_extent_tree?
>>>>>
>>>>> static void __destroy_extent_tree(struct inode *inode, enum extent_type
>>>>> type)
>>>>>
>>>>>            /* free all extent info belong to this extent tree */
>>>>>            node_cnt = __destroy_extent_node(inode, type);
>>>>> +       f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
>>>>
>>>>        /* free all extent info belong to this extent tree */
>>>>        node_cnt = __destroy_extent_node(inode, type);
>>>>
>>>>        /* delete extent tree entry in radix tree */
>>>>        mutex_lock(&eti->extent_tree_lock);
>>>>        f2fs_bug_on(sbi, atomic_read(&et->node_cnt));  <---
>>>>
>>>> Oh, it has already checked node_cnt, so, maybe we can just remove the
>>>> check in
>>>> __destroy_extent_node()?
>>>
>>> Yes. BTW, is it correct to remove the call to f2fs_destroy_extent_node()
>>> in f2fs_drop_inode()? It seems this call is unnecessary, since
>>> f2fs_evict_inode() will eventually delete all extent nodes properly.
>>
>> I think it's fine to keep it according to original intention "destroy
>> extent_tree for the truncation case" introduced from 3e72f721390d
>> ("f2fs: use extent_cache by default"). It helps the performance w/
>> in batch extent node release.
> 
> Oh, I see. This patch has already been merged into the dev branch. Which
> of the following approaches would be more appropriate?
> 1. Drop the current patch from the dev branch, then submit a patch to
> remove the f2fs_bug_on() in __destroy_extent_node.
> 2. Send two patches: the first reverts the change, and the second
> removes the f2fs_bug_on() in __destroy_extent_node().

It's near the end of merge window, I think we need to keep dev as
it is, and create another patch to revert previous change and drop
the f2fs_bug_on() as well, what do you think?

To Jaegeuk, thoughts?

Thanks,

> 
> Thanks
> Yongpeng,
> 
>>
>> Thanks,
>>
>>>
>>> Thanks
>>> Yongpeng,
>>>
>>>>
>>>> Thanks,
>>>>
>>>>
>>>>>
>>>>> Thanks
>>>>> Yongpeng,
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>>
>>>>>>> Fixes: 3fc5d5a182f6 ("f2fs: fix to shrink read extent node in
>>>>>>> batches")
>>>>>>> Cc: stable@vger.kernel.org
>>>>>>> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>>>>>> ---
>>>>>>>      fs/f2fs/extent_cache.c | 17 ++++++++++-------
>>>>>>>      1 file changed, 10 insertions(+), 7 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>>>>>>> index 0ed84cc065a7..87169fd29d89 100644
>>>>>>> --- a/fs/f2fs/extent_cache.c
>>>>>>> +++ b/fs/f2fs/extent_cache.c
>>>>>>> @@ -119,9 +119,10 @@ static bool __may_extent_tree(struct inode
>>>>>>> *inode, enum extent_type type)
>>>>>>>          if (!__init_may_extent_tree(inode, type))
>>>>>>>              return false;
>>>>>>>      +    if (is_inode_flag_set(inode, FI_NO_EXTENT))
>>>>>>> +        return false;
>>>>>>> +
>>>>>>>          if (type == EX_READ) {
>>>>>>> -        if (is_inode_flag_set(inode, FI_NO_EXTENT))
>>>>>>> -            return false;
>>>>>>>              if (is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
>>>>>>>                       !f2fs_sb_has_readonly(F2FS_I_SB(inode)))
>>>>>>>                  return false;
>>>>>>> @@ -644,6 +645,8 @@ static unsigned int __destroy_extent_node(struct
>>>>>>> inode *inode,
>>>>>>>            while (atomic_read(&et->node_cnt)) {
>>>>>>>              write_lock(&et->lock);
>>>>>>> +        if (!is_inode_flag_set(inode, FI_NO_EXTENT))
>>>>>>> +            set_inode_flag(inode, FI_NO_EXTENT);
>>>>>>>              node_cnt += __free_extent_tree(sbi, et, nr_shrink);
>>>>>>>              write_unlock(&et->lock);
>>>>>>>          }
>>>>>>> @@ -688,12 +691,12 @@ static void __update_extent_tree_range(struct
>>>>>>> inode *inode,
>>>>>>>            write_lock(&et->lock);
>>>>>>>      -    if (type == EX_READ) {
>>>>>>> -        if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
>>>>>>> -            write_unlock(&et->lock);
>>>>>>> -            return;
>>>>>>> -        }
>>>>>>> +    if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
>>>>>>> +        write_unlock(&et->lock);
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>>      +    if (type == EX_READ) {
>>>>>>>              prev = et->largest;
>>>>>>>              dei.len = 0;
>>>>>>
>>>>>>
>>>>>>
> 


