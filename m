Return-Path: <stable+bounces-274087-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iXOrMVugVWpvrAAAu9opvQ
	(envelope-from <stable+bounces-274087-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 04:35:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DE975064D
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 04:35:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b="j/5Zm3NP";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274087-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274087-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80DD83015A5E
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 02:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24C83812C7;
	Tue, 14 Jul 2026 02:34:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBEA370ADC;
	Tue, 14 Jul 2026 02:34:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996492; cv=none; b=kW61jBuse4++wG5Rg/q3fPm3z3MdZGAfvqGN+vdDUgJU9+7ewPiuNBcuFdYXTB9CNqwkzhItjB3k0d9xGnNs+VeihhTpVikUZlRqGFuDDmkOTboKjhY7pV9RO4PECNZJYQCsVAqbcbffC4jDg9ki4J9Ef/poLAjoHHfMdhVZ6PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996492; c=relaxed/simple;
	bh=Ckfg9XC4lOH3MTa+nIDgu9Kpua3n4ezmddyzDFgyNwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFsDUfucJzkDMaCGwXRnXKDnyf63DAEK/kBSqBzsY6tL0Zb2RgJ0/dZq4/mB/zYyyF3S36srrAA41HQ4eY+77ju44uQoIoxuICoDWtmMr8G0XfdyIXa86CUzauliVAu8TIPlXqpTCzesekOVKRHFciBVZJHlCzRr0F79t3VX4s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j/5Zm3NP; arc=none smtp.client-ip=115.124.30.97
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783996486; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=C6cPzGN0BhSGG+3mwai37V4K2Gl6btFijFkZKpQaE0Q=;
	b=j/5Zm3NPZHCKMdrKmhjYT2l63WFA/AHZ//PKl9dQsxnVjIkH9a3Op90ZSdRV7YJHwgELkwMkDw3QekBhgvzzo/VlmE813vz+zmZxET0hvHcxRxhprNjA17FH9F6/ZeHgRTXUaA4QjpxqVl72l6tBPAzyNJ0EQ4aOZYODXSE9VjI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X72TukA_1783996484;
Received: from 30.74.144.125(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X72TukA_1783996484 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jul 2026 10:34:45 +0800
Message-ID: <64aae758-bcf1-45f8-bb3d-bd732ada2b11@linux.alibaba.com>
Date: Tue, 14 Jul 2026 10:34:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0V4dGVybmFsIE1haWxdW1BBVENIIDYuMTgueSB2?=
 =?UTF-8?Q?2=5D_mm=3A_shmem=3A_fix_potential_livelock_issue_for_shmem_direct?=
 =?UTF-8?Q?_swapin?=
To: =?UTF-8?B?6ams6LaF?= <machao26@xiaomi.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "kasong@tencent.com" <kasong@tencent.com>,
 "baohua@kernel.org" <baohua@kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?55Sw5a2d5paM?= <tianxiaobin@xiaomi.com>, =?UTF-8?B?5L+e5Lic5paM?=
 <yudongbin@xiaomi.com>, =?UTF-8?B?5p2O6bmP56iL?= <xiaoyaoli@xiaomi.com>
References: <c0b158fe3f25709543b48a9d81b1933120a9e2ba.1783648317.git.baolin.wang@linux.alibaba.com>
 <636829064b674f71a11095603edcb20a@xiaomi.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <636829064b674f71a11095603edcb20a@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:machao26@xiaomi.com,m:akpm@linux-foundation.org,m:hughd@google.com,m:stable@vger.kernel.org,m:kasong@tencent.com,m:baohua@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:tianxiaobin@xiaomi.com,m:yudongbin@xiaomi.com,m:xiaoyaoli@xiaomi.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[baolin.wang@linux.alibaba.com,stable@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-274087-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33DE975064D



On 7/13/26 7:55 PM, 马超 wrote:
>> When skipping swapcache for synchronous IO swap devices, swapcache_prepare() is used to prevent parallel swapin from proceeding with the swap cache flag.
>> However, on PREEMPT kernels this can lead to a livelock, as reported by Chao[1]:
>>
>> Thread A starts direct swapin of a shmem folio and calls swapcache_prepare() to set SWAP_HAS_CACHE. It may then be preempted inside workingset_refault().
>> Meanwhile, a higher priority thread B also attempts direct swapin of the same shmem swap entry. Since swapcache_prepare() already marks the entry, thread B repeatedly gets -EEXIST and busy-loops waiting for thread A to finish. But as thread B runs at higher priority, thread A cannot preempt it, resulting in starvation and a livelock.
>>
>> Fix it by yielding the CPU with schedule_timeout_uninterruptible(1) when
>> swapcache_prepare() fails, following the same approach used in commit 029c4628b2eb ("mm: swap: get rid of livelock in swapin readahead") and commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache").
>>
>> However, commit 01626a1823 ("mm: avoid unconditional one-tick sleep when swapcache_prepare fails") found that the unconditional one-tick sleep can cause UI stuttering on latency-sensitive Android devices. So we can follow the same approach by adding a waitqueue to wake up tasks when needed, instead of always sleeping for a full tick.
>>
>> Note that mainline does not have this potential issue, which has already been resolved by Kairui's swap refactoring work[2].
>>
>> [1] https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xiaomi.com/
>> [2] https://lore.kernel.org/all/20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com/
>> Fixes: 1dd44c0af4fa ("mm: shmem: skip swapcache for swapin of synchronous swap device")
>> Reported-by: Ma Chao <machao26@xiaomi.com>
>> Closes: https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xiaomi.com/
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>> Changes from v1:
>> - Add a waitqueue to wake up tasks when needed.
>>
>> Hi Chao, could you try this patch to check if fix your issue? Thanks.
>> ---
>> mm/shmem.c | 14 +++++++++++++-
>> 1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 94c5b0d78ac3..3c329b794ae4 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2005,11 +2005,14 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
>>         return ERR_PTR(error);
>> }
>>
>> +static DECLARE_WAIT_QUEUE_HEAD(shmem_swapcache_wq);
>> +
>> static struct folio *shmem_swap_alloc_folio(struct inode *inode,
>>                 struct vm_area_struct *vma, pgoff_t index,
>>                 swp_entry_t entry, int order, gfp_t gfp)  {
>>         struct shmem_inode_info *info = SHMEM_I(inode);
>> +       DECLARE_WAITQUEUE(wait, current);
>>         int nr_pages = 1 << order;
>>         struct folio *new;
>>         gfp_t alloc_gfp;
>> @@ -2066,6 +2069,10 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
>>         if (swapcache_prepare(entry, nr_pages)) {
>>                 folio_put(new);
>>                 new = ERR_PTR(-EEXIST);
>> +               /* Relax a bit to prevent rapid repeated page faults */
>> +               add_wait_queue(&shmem_swapcache_wq, &wait);
>> +               schedule_timeout_uninterruptible(1);
>> +               remove_wait_queue(&shmem_swapcache_wq, &wait);
>>                 /* Try smaller folio to avoid cache conflict */
>>                 goto fallback;
>>         }
>> @@ -2423,6 +2430,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>         if (skip_swapcache) {
>>                 folio->swap.val = 0;
>>                 swapcache_clear(si, swap, nr_pages);
>> +               if (waitqueue_active(&shmem_swapcache_wq))
>> +                       wake_up(&shmem_swapcache_wq);
>>         } else {
>>                 swap_cache_del_folio(folio);
>>         }
>> @@ -2442,8 +2451,11 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>         if (folio)
>>                 folio_unlock(folio);
>> failed_nolock:
>> -       if (skip_swapcache)
>> +       if (skip_swapcache) {
>>                 swapcache_clear(si, folio->swap, folio_nr_pages(folio));
>> +               if (waitqueue_active(&shmem_swapcache_wq))
>> +                       wake_up(&shmem_swapcache_wq);
>> +       }
>>         if (folio)
>>                 folio_put(folio);
>>         put_swap_device(si);
>> --
>> 2.47.3
> 
> We have conducted stress tests on over 10 pcs for 40 hours each, and no relevant issues have been reproduced.

Thanks for testing. Could you add your 'Tested-by:' tag?

