Return-Path: <stable+bounces-240086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ9VKFk552no5QEAu9opvQ
	(envelope-from <stable+bounces-240086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:46:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3359F43854C
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAC6D302D94A
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A0E399019;
	Tue, 21 Apr 2026 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Ik8p5+Nn"
X-Original-To: stable@vger.kernel.org
Received: from mail3-164.sinamail.sina.com.cn (mail3-164.sinamail.sina.com.cn [202.108.3.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB45939446D
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761108; cv=none; b=T21NcYHHZ+pDXjLvypu4mgwOn7h6hKn6Jlr2oDMpJkkRssPpG67A3spHdCwNGHts8S9qH6WoixW+eSmBMOv0kl5DjE4FN//pJl8VAMqtT+FwJkNnQKhFAW0cNumozWY8P4H58PNUucmWZGkfmpn9NKDtYdd98ByLS/1XZXcDpwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761108; c=relaxed/simple;
	bh=aqWysQGaJW+xB67eAREth+WtVfxeizO4vhCxxJN3bEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5z6dr8xgMLcEbnYVsu2OM7xSkR0ZGBxfGAk5e6t9XfWW3+cqa1xepAGs7jlqHZNQ6f7dB3AeowYMhHnWjFBK99lnp9PPGk+1M7Gy0IqZnTImS9w3bSgEkgoJLPhF+pPepcx5fC2wrXtuv2vLN2kUGLtgo3e7h1Z1NAn/Wb9FbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Ik8p5+Nn; arc=none smtp.client-ip=202.108.3.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1776761103;
	bh=E2sUUyzl/czcG49TlhncKVUKZFEb4ZnT0W3kUUQuXsU=;
	h=Message-ID:Date:Subject:From;
	b=Ik8p5+NnDPhCzSkx7xxLPj3X3DaEoek9bYGiTa+4q2sC4A/RJmJPMhe7XmE+NRaIV
	 Ije7/xIuYaQrsQlwuSqod1oBCeKKVD/kEB9Bpooz2+MBgmQglO+t+jLNZNCpVSf32x
	 1ZePD64KGdWFY9erjTHdbsRFd3cSVYsyGbJOR0Nw=
X-SMAIL-HELO: [10.189.138.37]
Received: from unknown (HELO [10.189.138.37])([114.247.175.249])
	by sina.com (10.54.253.32) with ESMTP
	id 69E7390000004791; Tue, 21 Apr 2026 16:44:49 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=monty_pavel@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 7061554456623
X-SMAIL-UIID: 363ED1C54E7D49C7898FF01356C99AC9-20260421-164449-1
Message-ID: <252cb446-e313-417b-b780-85dcdcf34a87@sina.com>
Date: Tue, 21 Apr 2026 16:44:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix node_cnt race between extent node
 destroy and writeback
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20260403144015.221811-3-monty_pavel@sina.com>
 <f997ceb6-85d1-4872-be06-2a50469b3b18@kernel.org>
 <5c222edf-6888-4007-9240-9e7988b2dc71@sina.com>
 <ac9d0f35-52dc-4371-a692-39c1d4ae5555@kernel.org>
 <a643b967-cb05-4de5-96f2-f1b783c9758d@sina.com>
 <bedd1951-681b-4364-80c9-c7fe6886c992@kernel.org>
Content-Language: en-US
From: Yongpeng Yang <monty_pavel@sina.com>
In-Reply-To: <bedd1951-681b-4364-80c9-c7fe6886c992@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240086-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[sina.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[monty_pavel@sina.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sina.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sina.com:dkim,sina.com:mid,xiaomi.com:email]
X-Rspamd-Queue-Id: 3359F43854C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/20/26 15:28, Chao Yu via Linux-f2fs-devel wrote:
> On 4/19/2026 12:29 AM, Yongpeng Yang wrote:
>>
>> On 4/18/26 8:51 AM, Chao Yu via Linux-f2fs-devel wrote:
>>> On 4/17/26 21:26, Yongpeng Yang wrote:
>>>>
>>>> On 4/17/26 17:00, Chao Yu via Linux-f2fs-devel wrote:
>>>>> On 4/3/26 22:40, Yongpeng Yang wrote:
>>>>>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>>>>>
>>>>>> f2fs_destroy_extent_node() does not set FI_NO_EXTENT before clearing
>>>>>> extent nodes. When called from f2fs_drop_inode() with I_SYNC set,
>>>>>> concurrent kworker writeback can insert new extent nodes into the
>>>>>> same
>>>>>> extent tree, racing with the destroy and triggering f2fs_bug_on() in
>>>>>> __destroy_extent_node(). The scenario is as follows:
>>>>>>
>>>>>> drop inode                            writeback
>>>>>>     - iput
>>>>>>      - f2fs_drop_inode  // I_SYNC set
>>>>>>       - f2fs_destroy_extent_node
>>>>>>        - __destroy_extent_node
>>>>>>         - while (node_cnt) {
>>>>>>            write_lock(&et->lock)
>>>>>>            __free_extent_tree
>>>>>>            write_unlock(&et->lock)
>>>>>>                                           - __writeback_single_inode
>>>>>>                                            - f2fs_outplace_write_data
>>>>>>                                             -
>>>>>> f2fs_update_read_extent_cache
>>>>>>                                              -
>>>>>> __update_extent_tree_range
>>>>>>                                               // FI_NO_EXTENT not
>>>>>> set,
>>>>>>                                               // insert new extent
>>>>>> node
>>>>>>           } // node_cnt == 0, exit while
>>>>>>         - f2fs_bug_on(node_cnt)  // node_cnt > 0
>>>>>>
>>>>>> Additionally, __update_extent_tree_range() only checks
>>>>>> FI_NO_EXTENT for
>>>>>> EX_READ type, leaving EX_BLOCK_AGE updates completely unprotected.
>>>>>>
>>>>>> This patch set FI_NO_EXTENT under et->lock in
>>>>>> __destroy_extent_node(),
>>>>>> consistent with other callers (__update_extent_tree_range and
>>>>>> __drop_extent_tree) and check FI_NO_EXTENT for both EX_READ and
>>>>>> EX_BLOCK_AGE tree.
>>>>>
>>>>> I suffered below test failure, then I bisect to this change.
>>>>>
>>>>>       generic/475  84s ... [failed, exit status 1]- output mismatch
>>>>> (see /
>>>>> share/git/fstests/results//generic/475.out.bad)
>>>>>       --- tests/generic/475.out   2025-01-12 21:57:40.279440664 +0800
>>>>>       +++ /share/git/fstests/results//generic/475.out.bad 2026-04-17
>>>>> 12:08:28.000000000 +0800
>>>>>       @@ -1,2 +1,6 @@
>>>>>        QA output created by 475
>>>>>        Silence is golden.
>>>>>       +mount: /mnt/scratch_f2fs: mount system call failed: Structure
>>>>> needs
>>>>> cleaning.
>>>>>       +       dmesg(1) may have more information after failed mount
>>>>> system
>>>>> call.
>>>>>       +mount failed
>>>>>       +(see /share/git/fstests/results//generic/475.full for details)
>>>>>       ...
>>>>>       (Run 'diff -u /share/git/fstests/tests/generic/475.out /
>>>>> share/git/
>>>>> fstests/results//generic/475.out.bad'  to see the entire diff)
>>>>>
>>>>>
>>>>>       generic/388  73s ... [failed, exit status 1]- output mismatch
>>>>> (see /
>>>>> share/git/fstests/results//generic/388.out.bad)
>>>>>       --- tests/generic/388.out   2025-01-12 21:57:40.275440602 +0800
>>>>>       +++ /share/git/fstests/results//generic/388.out.bad 2026-04-17
>>>>> 11:58:05.000000000 +0800
>>>>>       @@ -1,2 +1,6 @@
>>>>>        QA output created by 388
>>>>>        Silence is golden.
>>>>>       +mount: /mnt/scratch_f2fs: mount system call failed: Structure
>>>>> needs
>>>>> cleaning.
>>>>>       +       dmesg(1) may have more information after failed mount
>>>>> system
>>>>> call.
>>>>>       +cycle mount failed
>>>>>       +(see /share/git/fstests/results//generic/388.full for details)
>>>>>       ...
>>>>>       (Run 'diff -u /share/git/fstests/tests/generic/388.out /
>>>>> share/git/
>>>>> fstests/results//generic/388.out.bad'  to see the entire diff)
>>>>>
>>>>>
>>>>>       F2FS-fs (dm-0): sanity_check_extent_cache: inode (ino=1761)
>>>>> extent
>>>>> info [220057, 57, 6] is incorrect, run fsck to fix
>>>>>
>>>>> I suspect we may miss any extent updates after we set FI_NO_EXTENT in
>>>>> __destroy_extent_node(), result in failing in
>>>>> sanity_check_extent_cache().
>>>>>
>>>>> Can we just relocate f2fs_bug_on(node_cnt) rather than complicated
>>>>> change?
>>>>> Thoughts?
>>>>
>>>> Oh, I overlooked largest extent. How about relocate
>>>> f2fs_bug_on(node_cnt) to __destroy_extent_tree?
>>>>
>>>> static void __destroy_extent_tree(struct inode *inode, enum extent_type
>>>> type)
>>>>
>>>>           /* free all extent info belong to this extent tree */
>>>>           node_cnt = __destroy_extent_node(inode, type);
>>>> +       f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
>>>
>>>       /* free all extent info belong to this extent tree */
>>>       node_cnt = __destroy_extent_node(inode, type);
>>>
>>>       /* delete extent tree entry in radix tree */
>>>       mutex_lock(&eti->extent_tree_lock);
>>>       f2fs_bug_on(sbi, atomic_read(&et->node_cnt));  <---
>>>
>>> Oh, it has already checked node_cnt, so, maybe we can just remove the
>>> check in
>>> __destroy_extent_node()?
>>
>> Yes. BTW, is it correct to remove the call to f2fs_destroy_extent_node()
>> in f2fs_drop_inode()? It seems this call is unnecessary, since
>> f2fs_evict_inode() will eventually delete all extent nodes properly.
> 
> I think it's fine to keep it according to original intention "destroy
> extent_tree for the truncation case" introduced from 3e72f721390d
> ("f2fs: use extent_cache by default"). It helps the performance w/
> in batch extent node release.

Oh, I see. This patch has already been merged into the dev branch. Which
of the following approaches would be more appropriate?
1. Drop the current patch from the dev branch, then submit a patch to
remove the f2fs_bug_on() in __destroy_extent_node.
2. Send two patches: the first reverts the change, and the second
removes the f2fs_bug_on() in __destroy_extent_node().

Thanks
Yongpeng,

> 
> Thanks,
> 
>>
>> Thanks
>> Yongpeng,
>>
>>>
>>> Thanks,
>>>
>>>
>>>>
>>>> Thanks
>>>> Yongpeng,
>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>> Fixes: 3fc5d5a182f6 ("f2fs: fix to shrink read extent node in
>>>>>> batches")
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>>>>> ---
>>>>>>     fs/f2fs/extent_cache.c | 17 ++++++++++-------
>>>>>>     1 file changed, 10 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>>>>>> index 0ed84cc065a7..87169fd29d89 100644
>>>>>> --- a/fs/f2fs/extent_cache.c
>>>>>> +++ b/fs/f2fs/extent_cache.c
>>>>>> @@ -119,9 +119,10 @@ static bool __may_extent_tree(struct inode
>>>>>> *inode, enum extent_type type)
>>>>>>         if (!__init_may_extent_tree(inode, type))
>>>>>>             return false;
>>>>>>     +    if (is_inode_flag_set(inode, FI_NO_EXTENT))
>>>>>> +        return false;
>>>>>> +
>>>>>>         if (type == EX_READ) {
>>>>>> -        if (is_inode_flag_set(inode, FI_NO_EXTENT))
>>>>>> -            return false;
>>>>>>             if (is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
>>>>>>                      !f2fs_sb_has_readonly(F2FS_I_SB(inode)))
>>>>>>                 return false;
>>>>>> @@ -644,6 +645,8 @@ static unsigned int __destroy_extent_node(struct
>>>>>> inode *inode,
>>>>>>           while (atomic_read(&et->node_cnt)) {
>>>>>>             write_lock(&et->lock);
>>>>>> +        if (!is_inode_flag_set(inode, FI_NO_EXTENT))
>>>>>> +            set_inode_flag(inode, FI_NO_EXTENT);
>>>>>>             node_cnt += __free_extent_tree(sbi, et, nr_shrink);
>>>>>>             write_unlock(&et->lock);
>>>>>>         }
>>>>>> @@ -688,12 +691,12 @@ static void __update_extent_tree_range(struct
>>>>>> inode *inode,
>>>>>>           write_lock(&et->lock);
>>>>>>     -    if (type == EX_READ) {
>>>>>> -        if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
>>>>>> -            write_unlock(&et->lock);
>>>>>> -            return;
>>>>>> -        }
>>>>>> +    if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
>>>>>> +        write_unlock(&et->lock);
>>>>>> +        return;
>>>>>> +    }
>>>>>>     +    if (type == EX_READ) {
>>>>>>             prev = et->largest;
>>>>>>             dei.len = 0;
>>>>>
>>>>>
>>>>>


