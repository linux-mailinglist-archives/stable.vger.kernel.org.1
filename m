Return-Path: <stable+bounces-238490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JhhKTI14mm13QAAu9opvQ
	(envelope-from <stable+bounces-238490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:27:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2919C41B9F8
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34624304E0E8
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B652949E0;
	Fri, 17 Apr 2026 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="fETvqKIn"
X-Original-To: stable@vger.kernel.org
Received: from r3-21.sinamail.sina.com.cn (r3-21.sinamail.sina.com.cn [202.108.3.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA0E1C84D7
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432419; cv=none; b=VAQn7iCiyNwdOKo2WZXauuf6lNsjqxw9sUOOV6iP9Mo8uR5I+Pp/V4TI3oNJzOH1kOA93pl+kQMAR2YsNUn+RIiaulTf8NNpjTMSqaFt5KCGae9rd1Mp2pSk7uP3hVhx9nm1uP2eBrOYNIrHWA6V5MDYaT9rXUL1q7pv0ugGiNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432419; c=relaxed/simple;
	bh=8gVQcCg3eO9nvnrQRajBfaOB5Drsnu4liUiTD+Foww4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cs3655EtZxiX5jjtcY7VkVrhPrbKhjE6OFFTJqkM5JlWE2fMWGncTGq2mqJbkIfBojwuRc3e42Nvje1nCXrOpAb0zP3szLKQAfkfKEhuvHHCb//wTmXpov5IHz6qAK/GkOuiIg0pMVLzfJ7iVkfdvnuaAae5jy2nVI8ZNZrT65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=fETvqKIn; arc=none smtp.client-ip=202.108.3.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1776432415;
	bh=Z+O9I/As2wXd554PDOyLC79OK/LQa94BQasISuolRP8=;
	h=Message-ID:Date:Subject:From;
	b=fETvqKInvKUjQ4ZA5R70nt2Pb7ykSo7FeFXSLC5Bsui7ZNsjsyeLhi0PUTB5w3ZE4
	 LnfOZDI2cI1BLMN/gaqJucrs5oarBv1GUWH0C2oHKVIU9mhMG1G/B4z63xgwcKusVA
	 7FoNBqTHzrIcCR3fGYaCqQwiLf1g+bifgf5sG5Lg=
X-SMAIL-HELO: [10.189.138.37]
Received: from unknown (HELO [10.189.138.37])([114.247.175.249])
	by sina.com (10.54.253.33) with ESMTP
	id 69E23511000004F3; Fri, 17 Apr 2026 21:26:43 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=monty_pavel@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 167296685210
X-SMAIL-UIID: 5C524A06982C4DD1A6AE6495D6EFA55B-20260417-212643-1
Message-ID: <5c222edf-6888-4007-9240-9e7988b2dc71@sina.com>
Date: Fri, 17 Apr 2026 21:26:41 +0800
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
Content-Language: en-US
From: Yongpeng Yang <monty_pavel@sina.com>
In-Reply-To: <f997ceb6-85d1-4872-be06-2a50469b3b18@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238490-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sina.com:dkim,sina.com:mid]
X-Rspamd-Queue-Id: 2919C41B9F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/17/26 17:00, Chao Yu via Linux-f2fs-devel wrote:
> On 4/3/26 22:40, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> f2fs_destroy_extent_node() does not set FI_NO_EXTENT before clearing
>> extent nodes. When called from f2fs_drop_inode() with I_SYNC set,
>> concurrent kworker writeback can insert new extent nodes into the same
>> extent tree, racing with the destroy and triggering f2fs_bug_on() in
>> __destroy_extent_node(). The scenario is as follows:
>>
>> drop inode                            writeback
>>   - iput
>>    - f2fs_drop_inode  // I_SYNC set
>>     - f2fs_destroy_extent_node
>>      - __destroy_extent_node
>>       - while (node_cnt) {
>>          write_lock(&et->lock)
>>          __free_extent_tree
>>          write_unlock(&et->lock)
>>                                         - __writeback_single_inode
>>                                          - f2fs_outplace_write_data
>>                                           - f2fs_update_read_extent_cache
>>                                            - __update_extent_tree_range
>>                                             // FI_NO_EXTENT not set,
>>                                             // insert new extent node
>>         } // node_cnt == 0, exit while
>>       - f2fs_bug_on(node_cnt)  // node_cnt > 0
>>
>> Additionally, __update_extent_tree_range() only checks FI_NO_EXTENT for
>> EX_READ type, leaving EX_BLOCK_AGE updates completely unprotected.
>>
>> This patch set FI_NO_EXTENT under et->lock in __destroy_extent_node(),
>> consistent with other callers (__update_extent_tree_range and
>> __drop_extent_tree) and check FI_NO_EXTENT for both EX_READ and
>> EX_BLOCK_AGE tree.
> 
> I suffered below test failure, then I bisect to this change.
> 
>     generic/475  84s ... [failed, exit status 1]- output mismatch (see /
> share/git/fstests/results//generic/475.out.bad)
>     --- tests/generic/475.out   2025-01-12 21:57:40.279440664 +0800
>     +++ /share/git/fstests/results//generic/475.out.bad 2026-04-17
> 12:08:28.000000000 +0800
>     @@ -1,2 +1,6 @@
>      QA output created by 475
>      Silence is golden.
>     +mount: /mnt/scratch_f2fs: mount system call failed: Structure needs
> cleaning.
>     +       dmesg(1) may have more information after failed mount system
> call.
>     +mount failed
>     +(see /share/git/fstests/results//generic/475.full for details)
>     ...
>     (Run 'diff -u /share/git/fstests/tests/generic/475.out /share/git/
> fstests/results//generic/475.out.bad'  to see the entire diff)
> 
> 
>     generic/388  73s ... [failed, exit status 1]- output mismatch (see /
> share/git/fstests/results//generic/388.out.bad)
>     --- tests/generic/388.out   2025-01-12 21:57:40.275440602 +0800
>     +++ /share/git/fstests/results//generic/388.out.bad 2026-04-17
> 11:58:05.000000000 +0800
>     @@ -1,2 +1,6 @@
>      QA output created by 388
>      Silence is golden.
>     +mount: /mnt/scratch_f2fs: mount system call failed: Structure needs
> cleaning.
>     +       dmesg(1) may have more information after failed mount system
> call.
>     +cycle mount failed
>     +(see /share/git/fstests/results//generic/388.full for details)
>     ...
>     (Run 'diff -u /share/git/fstests/tests/generic/388.out /share/git/
> fstests/results//generic/388.out.bad'  to see the entire diff)
> 
> 
>     F2FS-fs (dm-0): sanity_check_extent_cache: inode (ino=1761) extent
> info [220057, 57, 6] is incorrect, run fsck to fix
> 
> I suspect we may miss any extent updates after we set FI_NO_EXTENT in
> __destroy_extent_node(), result in failing in sanity_check_extent_cache().
> 
> Can we just relocate f2fs_bug_on(node_cnt) rather than complicated change?
> Thoughts?

Oh, I overlooked largest extent. How about relocate
f2fs_bug_on(node_cnt) to __destroy_extent_tree?

static void __destroy_extent_tree(struct inode *inode, enum extent_type
type)

        /* free all extent info belong to this extent tree */
        node_cnt = __destroy_extent_node(inode, type);
+       f2fs_bug_on(sbi, atomic_read(&et->node_cnt));

Thanks
Yongpeng,

> 
> Thanks,
> 
>>
>> Fixes: 3fc5d5a182f6 ("f2fs: fix to shrink read extent node in batches")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
>> ---
>>   fs/f2fs/extent_cache.c | 17 ++++++++++-------
>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>> index 0ed84cc065a7..87169fd29d89 100644
>> --- a/fs/f2fs/extent_cache.c
>> +++ b/fs/f2fs/extent_cache.c
>> @@ -119,9 +119,10 @@ static bool __may_extent_tree(struct inode
>> *inode, enum extent_type type)
>>       if (!__init_may_extent_tree(inode, type))
>>           return false;
>>   +    if (is_inode_flag_set(inode, FI_NO_EXTENT))
>> +        return false;
>> +
>>       if (type == EX_READ) {
>> -        if (is_inode_flag_set(inode, FI_NO_EXTENT))
>> -            return false;
>>           if (is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
>>                    !f2fs_sb_has_readonly(F2FS_I_SB(inode)))
>>               return false;
>> @@ -644,6 +645,8 @@ static unsigned int __destroy_extent_node(struct
>> inode *inode,
>>         while (atomic_read(&et->node_cnt)) {
>>           write_lock(&et->lock);
>> +        if (!is_inode_flag_set(inode, FI_NO_EXTENT))
>> +            set_inode_flag(inode, FI_NO_EXTENT);
>>           node_cnt += __free_extent_tree(sbi, et, nr_shrink);
>>           write_unlock(&et->lock);
>>       }
>> @@ -688,12 +691,12 @@ static void __update_extent_tree_range(struct
>> inode *inode,
>>         write_lock(&et->lock);
>>   -    if (type == EX_READ) {
>> -        if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
>> -            write_unlock(&et->lock);
>> -            return;
>> -        }
>> +    if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
>> +        write_unlock(&et->lock);
>> +        return;
>> +    }
>>   +    if (type == EX_READ) {
>>           prev = et->largest;
>>           dei.len = 0;
>>   
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


