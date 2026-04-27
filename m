Return-Path: <stable+bounces-241318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLb0Oh1g72mHAwEAu9opvQ
	(envelope-from <stable+bounces-241318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:09:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC86A4732BB
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FB64305660F
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97F83BE650;
	Mon, 27 Apr 2026 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="GNOO97M6"
X-Original-To: stable@vger.kernel.org
Received: from smtp153-170.sina.com.cn (smtp153-170.sina.com.cn [61.135.153.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB112F25F0
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295076; cv=none; b=pVpwjK0vZme+RlaZk9lW9lxFnYUZHH0NWOGbCbN9RFcfm/eQK+YhwBtMy2YwBPEueafsogyWTE3mS3iLKqx4Bd3GWxc+GT/jJ14ub3XyjkH8jb+0bzzYUYnE22F/wpCl7hbPtvL410HspaZk6AZD+af3fMPq73LQAc9IcU4Nztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295076; c=relaxed/simple;
	bh=Dy2W72v9QHHxADVgHAVxuwFsDk39ZtNfk/RvM6kgZq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WiUOV+iyg3LfSr6mL4urlC1XnAAkP4HT62E4qxnR+bNvGcGBmsLKtj87/f2C8w2Mx8QSXXXzRErrWgVFNyBmmXoOt98OpjBXQFYGcCbSnCBjijzhpDOKI+OhyC40NPy949Sj1cETlj7hAmWwmvARyl9MHSxWOtxCpSWwLqt/XaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=GNOO97M6; arc=none smtp.client-ip=61.135.153.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1777295069;
	bh=E2HCd8PPa/eyqaR8OgCAmZ78sa8kIlUHz9Iq+BnfnE4=;
	h=Message-ID:Date:Subject:From;
	b=GNOO97M6D/QsOsnnBVBKN5q9yUcPrVJuEtfUH/T4W9xwDapbzAZrSayrbIFqfagnx
	 fZmL41uW9dMJRVO7AlburB/YPfx0ZrOEk+JDCVp/vmJpjdezk7bNi0jmxJdTabeUD+
	 cvxJZtLM+OAjxCntgeSf5mKs1FyihrNSfBzFviIY=
X-SMAIL-HELO: [10.189.138.37]
Received: from unknown (HELO [10.189.138.37])([114.247.175.249])
	by sina.com (10.54.253.34) with ESMTP
	id 69EF5ECF00004D4C; Mon, 27 Apr 2026 21:04:16 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=monty_pavel@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 3110686291986
X-SMAIL-UIID: B0872C6E8D264607BEF976B6699FC3C1-20260427-210416-1
Message-ID: <d96abb88-b437-4eb8-a8d4-342154f346ba@sina.com>
Date: Mon, 27 Apr 2026 21:04:15 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix incorrect FI_NO_EXTENT handling in
 __destroy_extent_node()
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20260422073525.2063784-2-monty_pavel@sina.com>
 <206a897a-2860-40b5-bbb8-829954d7e568@kernel.org>
 <8f3dee76-6094-421f-bb32-a059815b405c@sina.com>
 <3550618a-4a16-4f1d-b8cb-4d7ff96f6ed7@kernel.org>
Content-Language: en-US
From: Yongpeng Yang <monty_pavel@sina.com>
In-Reply-To: <3550618a-4a16-4f1d-b8cb-4d7ff96f6ed7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CC86A4732BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241318-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/27/26 15:38, Chao Yu via Linux-f2fs-devel wrote:
> On 4/24/26 17:45, Yongpeng Yang wrote:
>>
>> On 4/22/26 20:33, Chao Yu via Linux-f2fs-devel wrote:
>>> On 4/22/2026 3:35 PM, Yongpeng Yang wrote:
>>>> From: yangyongpeng <yangyongpeng@xiaomi.com>
>>>>
>>>> When __destroy_extent_node() sets the inode flag FI_NO_EXTENT, it does
>>>> not reset the length of the largest extent to 0 and update the inode
>>>> folio. Since modifications to the extent tree are disallowed afterward,
>>>> the cached largest extent may become stale. This can trigger the
>>>> following error in xfstests generic/388:
>>>>
>>>> F2FS-fs (dm-0): sanity_check_extent_cache: inode (ino=1761) extent
>>>> info [220057, 57, 6] is incorrect, run fsck to fix
>>>>
>>>> In the f2fs_drop_inode path, __destroy_extent_node() does not need to
>>>> guarantee that et->node_cnt is 0, because concurrency with writeback
>>>> is expected in this path, and writeback may update the extent cache.
>>>>
>>>> This patch updates __destroy_extent_node() to avoid setting the inode
>>>> flag FI_NO_EXTENT, and to remove the check zero of et->node_cnt.
>>>>
>>>> Fixes: ed78aeebef05 ("f2fs: fix node_cnt race between extent node
>>>> destroy and writeback")
>>>> Cc: stable@vger.kernel.org
>>>> Reported-by: Chao Yu <chao@kernel.org>
>>>> Suggested-by: Chao Yu <chao@kernel.org>
>>>> Signed-off-by: yangyongpeng <yangyongpeng@xiaomi.com>
>>>> ---
>>>>    fs/f2fs/extent_cache.c | 4 ----
>>>>    1 file changed, 4 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>>>> index 87169fd29d89..3adbead27953 100644
>>>> --- a/fs/f2fs/extent_cache.c
>>>> +++ b/fs/f2fs/extent_cache.c
>>>> @@ -645,14 +645,10 @@ static unsigned int __destroy_extent_node(struct
>>>> inode *inode,
>>>>          while (atomic_read(&et->node_cnt)) {
>>>>            write_lock(&et->lock);
>>>> -        if (!is_inode_flag_set(inode, FI_NO_EXTENT))
>>>> -            set_inode_flag(inode, FI_NO_EXTENT);
>>>
>>> We'd better revert all change lines in "f2fs: fix node_cnt race between
>>> extent node destroy and writeback"?
>>
>> The others all check whether FI_NO_EXTENT is set. When it is set,
>> inserting an age extent is disallowed, so nothing was removed.
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 87169fd29d89..0ed84cc065a7 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -119,10 +119,9 @@ static bool __may_extent_tree(struct inode *inode,
> enum extent_type type)
>         if (!__init_may_extent_tree(inode, type))
>                 return false;
> 
> -       if (is_inode_flag_set(inode, FI_NO_EXTENT))
> -               return false;
> -
>         if (type == EX_READ) {
> +               if (is_inode_flag_set(inode, FI_NO_EXTENT))
> +                       return false;

This should be revert. The EX_BLOCK_AGE extent tree type was added later
and has never been governed by FI_NO_EXTENT. After reverting the commit
ed78aeebef05, having FI_NO_EXTENT set no longer implies that the inode
needs to be evicted, so rejecting updates to EX_BLOCK_AGE extents based
on this flag no longer makes sense. Therefore, this part of the change
should be dropped.

>                 if (is_inode_flag_set(inode, FI_COMPRESSED_FILE) &&
>                                  !f2fs_sb_has_readonly(F2FS_I_SB(inode)))
>                         return false;
> 
> ...
> 
> @@ -691,12 +688,12 @@ static void __update_extent_tree_range(struct
> inode *inode,
> 
>         write_lock(&et->lock);
> 
> -       if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
> -               write_unlock(&et->lock);
> -               return;
> -       }

This also should be revert. All callers of this function already invoke
__may_extent_tree() to verify whether FI_NO_EXTENT is set. So, this
check are dead code.

> -
>         if (type == EX_READ) {
> +               if (is_inode_flag_set(inode, FI_NO_EXTENT)) {
> +                       write_unlock(&et->lock);
> +                       return;
> +               }
> +
>                 prev = et->largest;
>                 dei.len = 0;
> 
> Hmm, I'm not sure I understood you correctly, if you want to keep above
> codes, what
> about changing in another patch w/ correct commit message?

Yes, I mean that, but I was mistaken. I'll fix above issue in v2 patch.

Thanks
Yongpeng,

> 
> Thanks,
> 
> 
>>
>> Thanks
>> Yongpeng,
>>
>>>
>>> Thanks,
>>>
>>>>            node_cnt += __free_extent_tree(sbi, et, nr_shrink);
>>>>            write_unlock(&et->lock);
>>>>        }
>>>>    -    f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
>>>> -
>>>>        return node_cnt;
>>>>    }
>>>>    
>>>
>>>
>>>
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


