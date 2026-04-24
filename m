Return-Path: <stable+bounces-240619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HCpLJc862mWKAAAu9opvQ
	(envelope-from <stable+bounces-240619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:49:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF3745C75A
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC8E43010514
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378652D2488;
	Fri, 24 Apr 2026 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Cs4SohD+"
X-Original-To: stable@vger.kernel.org
Received: from r3-21.sinamail.sina.com.cn (r3-21.sinamail.sina.com.cn [202.108.3.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82E292B44
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024117; cv=none; b=cA2aiSL2EaOit1uot2bkzaOAEA/H1UjQc3CH9RcpWEvm265Em9ZLRJLGhqQnAvl/ULAybfFJXDbTWl9zabo/Kk87nwwQKTfQ+d1oy7P+XuKg+SCgK2SIjDaVF/rTQxuDer5C9PlNAOEIYmRO3f3ml3iuvN201q9bl6QMtsfXFzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024117; c=relaxed/simple;
	bh=y0lENNfXcfad3lb7NW0MseI0zloT0NbBY5/dLInqywY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTjN1QJK+OjECJ/aVYTT8qVlvMEt+z2vRjaX+JX4rtwozm2d97GX0F0qV2rDheC2i1ETYV95HIBIng/UkHeJHiVYp24BimzjHygzXSX7TR/lGs07MxKa6tvKy9A4NEbU1PJcQM1hy3xny576RHxZNjbpc3O7YjOMwvqovLST9Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Cs4SohD+; arc=none smtp.client-ip=202.108.3.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1777024113;
	bh=59EqtpJy4/2gF4KeCUUvmFmLqxMdJYSoXzV/Rf0zN6Q=;
	h=Message-ID:Date:Subject:From;
	b=Cs4SohD+ilEer+3uZpsUUNdrYUJMmZC4LnDsSnV0UvggsjDVImeuul/OotjskZPGd
	 S+4c2+cDSewC0/DhK/3gg5sLe5xKIC+tPrt9eI0OtqdTW3syD5Y75olyUKxIxt2zgi
	 QjzUpPmciC7td8/v+d0RQuxqohafmo43kBcyQ83Y=
X-SMAIL-HELO: [10.189.138.37]
Received: from unknown (HELO [10.189.138.37])([114.247.175.249])
	by sina.com (10.54.253.33) with ESMTP
	id 69EB3BC100002ABD; Fri, 24 Apr 2026 17:45:39 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=monty_pavel@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 4387756685161
X-SMAIL-UIID: 1CEC3BD731DF4B128E69BBDA3B45E8C9-20260424-174539-1
Message-ID: <8f3dee76-6094-421f-bb32-a059815b405c@sina.com>
Date: Fri, 24 Apr 2026 17:45:37 +0800
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
Content-Language: en-US
From: Yongpeng Yang <monty_pavel@sina.com>
In-Reply-To: <206a897a-2860-40b5-bbb8-829954d7e568@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7AF3745C75A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-240619-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,sina.com:dkim,sina.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


On 4/22/26 20:33, Chao Yu via Linux-f2fs-devel wrote:
> On 4/22/2026 3:35 PM, Yongpeng Yang wrote:
>> From: yangyongpeng <yangyongpeng@xiaomi.com>
>>
>> When __destroy_extent_node() sets the inode flag FI_NO_EXTENT, it does
>> not reset the length of the largest extent to 0 and update the inode
>> folio. Since modifications to the extent tree are disallowed afterward,
>> the cached largest extent may become stale. This can trigger the
>> following error in xfstests generic/388:
>>
>> F2FS-fs (dm-0): sanity_check_extent_cache: inode (ino=1761) extent
>> info [220057, 57, 6] is incorrect, run fsck to fix
>>
>> In the f2fs_drop_inode path, __destroy_extent_node() does not need to
>> guarantee that et->node_cnt is 0, because concurrency with writeback
>> is expected in this path, and writeback may update the extent cache.
>>
>> This patch updates __destroy_extent_node() to avoid setting the inode
>> flag FI_NO_EXTENT, and to remove the check zero of et->node_cnt.
>>
>> Fixes: ed78aeebef05 ("f2fs: fix node_cnt race between extent node
>> destroy and writeback")
>> Cc: stable@vger.kernel.org
>> Reported-by: Chao Yu <chao@kernel.org>
>> Suggested-by: Chao Yu <chao@kernel.org>
>> Signed-off-by: yangyongpeng <yangyongpeng@xiaomi.com>
>> ---
>>   fs/f2fs/extent_cache.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>> index 87169fd29d89..3adbead27953 100644
>> --- a/fs/f2fs/extent_cache.c
>> +++ b/fs/f2fs/extent_cache.c
>> @@ -645,14 +645,10 @@ static unsigned int __destroy_extent_node(struct
>> inode *inode,
>>         while (atomic_read(&et->node_cnt)) {
>>           write_lock(&et->lock);
>> -        if (!is_inode_flag_set(inode, FI_NO_EXTENT))
>> -            set_inode_flag(inode, FI_NO_EXTENT);
> 
> We'd better revert all change lines in "f2fs: fix node_cnt race between
> extent node destroy and writeback"?

The others all check whether FI_NO_EXTENT is set. When it is set,
inserting an age extent is disallowed, so nothing was removed.

Thanks
Yongpeng,

> 
> Thanks,
> 
>>           node_cnt += __free_extent_tree(sbi, et, nr_shrink);
>>           write_unlock(&et->lock);
>>       }
>>   -    f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
>> -
>>       return node_cnt;
>>   }
>>   
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


