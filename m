Return-Path: <stable+bounces-212726-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGroIo/FemmY+QEAu9opvQ
	(envelope-from <stable+bounces-212726-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 03:27:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF706AB1D1
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 03:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BCE4300E3BF
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 02:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7614B355059;
	Thu, 29 Jan 2026 02:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A7n8oLFl"
X-Original-To: stable@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0AD1F0E34;
	Thu, 29 Jan 2026 02:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769653643; cv=none; b=q1aOJU64mBM78psvl5awYLfMM1zzNnapTiqmiCu8bty00JCq5E2TKY9VoR8MMwQrq53HLE00szxDvhYXCz6K/1d4WV/i6HRiYAS8tcsQnlr1aitT+xeQ/AvO3w+VFV03hILPOY4jECj5XXN2lBCLzBuppZIgFwBYDFsvsN0DtbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769653643; c=relaxed/simple;
	bh=Kt+U9etTlRK7FPmd+yjpvcZQ/Gu3ew0Zc/m2PNdE7V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhIWiTFR/mFuBSYN1C1H6SAKg6Kkjt9EF3Hqo+yb/prYc1P5LhvZ0BIRLJjiMtMmyEROt4Fo2wDMvTQe7Mq8LIu1o0DIdRg1IGZQKNRlDoU/bZrzhq+A7N+hpGOuUZnc3yF3gLesg6TdEFA7XciE/K3JKP2h76n73OsgKzKxvcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A7n8oLFl; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769653632; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Vb061Q+F4cvQBZq/IQQ6DiA8ZyO7PXBJm0zl3HtzTo4=;
	b=A7n8oLFlHuB6s1jqrz9q1y67HBWNvp6Lx6y6KmWSlx9P0PGlRMyTrBzPHJ8LSIs6ZYmnVaataIdO2HFCoWv9IPiHtxH8T3xF2TdT3pTo9wWYtirS06AVVSGEgEDO6ISLseRoDokXA3/YIaDSfPCu292Pt/qELWcutrvt1O0E4Q0=
Received: from 30.74.144.124(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wy5ZpTV_1769653630 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Jan 2026 10:27:10 +0800
Message-ID: <5db265de-b069-41c0-b8c2-a119dfb83485@linux.alibaba.com>
Date: Thu, 29 Jan 2026 10:27:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/shmem, swap: fix race of truncate and swap entry
 split
To: Kairui Song <ryncsn@gmail.com>, Chris Mason <clm@meta.com>,
 linux-mm@kvack.org
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>,
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
 stable@vger.kernel.org
References: <20260120-shmem-swap-fix-v3-1-3d33ebfbc057@tencent.com>
 <20260128130336.727049-1-clm@meta.com> <aXo6ltB5iqAKJzY8@KASONG-MC4>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <aXo6ltB5iqAKJzY8@KASONG-MC4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212726-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,meta.com,kvack.org];
	FREEMAIL_CC(0.00)[google.com,linux-foundation.org,huaweicloud.com,gmail.com,kernel.org,redhat.com,vger.kernel.org,tencent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DF706AB1D1
X-Rspamd-Action: no action



On 1/29/26 12:52 AM, Kairui Song wrote:
> On Wed, Jan 28, 2026 at 05:02:34AM +0800, Chris Mason wrote:
>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>
>> [ ... ]
>>
>>> @@ -1191,12 +1203,23 @@
>>>   		folio = fbatch.folios[i];
>>>
>>>   		if (xa_is_value(folio)) {
>>> +			int order;
>>>   			long swaps_freed;
>>>
>>>   			if (unfalloc)
>>>   				continue;
>>> -			swaps_freed = shmem_free_swap(mapping, indices[i], folio);
>>> +			swaps_freed = shmem_free_swap(mapping, indices[i],
>>> +						      end - 1, folio);
>>>   			if (!swaps_freed) {
>>> +				/*
>>> +				 * If found a large swap entry cross the end border,
>>> +				 * skip it as the truncate_inode_partial_folio above
>>> +				 * should have at least zerod its content once.
>>> +				 */
>>> +				order = shmem_confirm_swap(mapping, indices[i],
>>> +							   radix_to_swp_entry(folio));
>>> +				if (order > 0 && indices[i] + (1 << order) > end)
>>> +					continue;
>>>   				/* Swap was replaced by page: retry */
>>>   				index = indices[i];
>>>   				break;
>>
>> Could this code infinite loop if a large swap entry crosses the START
>> boundary instead of the END boundary?
> 
> Thanks for the review! It's really helpful :)
> 
>> When shmem_free_swap() returns 0, it could be either because:
>> (a) The entry was replaced by a page, or
>> (b) The entry failed the boundary check (base < index ||
>>      base + nr_pages - 1 > end)
>>
>> The boundary check here only handles case (b) for entries crossing the
>> END boundary:
>>
>>      if (order > 0 && indices[i] + (1 << order) > end)
>>          continue;
>>
>> But what happens if the entry crosses the START boundary? If
>> find_get_entries() returns a large swap entry at indices[i] where
>> the entry's base (calculated as indices[i] & ~((1 << order) - 1)) is
>> less than the truncation start point, then shmem_free_swap() will
>> return 0 due to the "base < index" check. The code will then call
>> shmem_confirm_swap(), get the order, check if it crosses the END
>> boundary (which it doesn't), and retry with the same index:
>>
>>      index = indices[i];
>>      break;
>>
>> The next iteration will find the same entry again at the same index,
>> leading to an infinite loop. For example:
>>
>> - Truncating range [18, 30]
>> - Large swap entry at [16, 23] (order 3, 8 pages)
>> - indices[i] = 18
>> - shmem_free_swap() sees base=16 < index=18, returns 0
>> - Check: 18 + 8 > 30 is false (26 <= 30)
>> - Retries with index=18
>> - Loop repeats indefinitely
> 
> I think this is a valid issue. And it's worse than that, during the `while (index < end)` loop a new large entry can land anywhere in the range, if one interaction's starting `index` points to the middle of any large entry, an infinite loop will occur: indices[0] are always equal to the `index` iteration value of that moments, shmem_free_swap will fail because the swap entry's index doesn't match indices[0], and so the `index = indices[i]; break;` keep it loop forever.
> 
> The chance seems very low though.
> 
>> Should the boundary check also handle the START case, perhaps:
>>
>>      if (order > 0) {
>>          pgoff_t base = indices[i] & ~((1UL << order) - 1);
>>          if (base + (1 << order) - 1 > end || base < start)
>>              continue;
>>      }
> 
> This still doesn't cover the case when a new large entry somehow lands in the range during the loop.
> 
>> where 'start' is preserved from before the loop?
> 
> How about following patch:
> 
>  From 863f38c757ee0898b6b7f0f8c695f551a1380ce8 Mon Sep 17 00:00:00 2001
> From: Kairui Song <kasong@tencent.com>
> Date: Thu, 29 Jan 2026 00:19:23 +0800
> Subject: [PATCH] mm, shmem: prevent infinite loop on truncate race
> 
> When truncating a large swap entry, shmem_free_swap() returns 0 when the
> entry's index doesn't match the given index due to lookup alignment. The
> failure fallback path checks if the entry crosses the end border and
> aborts when it happens, so truncate won't erase an unexpected entry or
> range. But one scenario was ignored.
> 
> When `index` points to the middle of a large swap entry, and the large
> swap entry doesn't go across the end border, find_get_entries() will
> return that large swap entry as the first item in the batch with
> `indices[0]` equal to `index`. The entry's base index will be smaller
> than `indices[0]`, so shmem_free_swap() will fail and return 0 due to
> the "base < index" check. The code will then call shmem_confirm_swap(),
> get the order, check if it crosses the END boundary (which it doesn't),
> and retry with the same index.
> 
> The next iteration will find the same entry again at the same index with
> same indices, leading to an infinite loop.
> 
> Fix this by retrying with a round-down index, and abort if the index is
> smaller than the truncate range.
> 
> Reported-by: Chris Mason <clm@meta.com>
> Closes: https://lore.kernel.org/linux-mm/20260128130336.727049-1-clm@meta.com/
> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> Fixes: 8a1968bd997f ("mm/shmem, swap: fix race of truncate and swap entry split")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

Thanks. The fix looks good to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

(BTW, I think we can simplify the logic by moving the boundary 
validation into shmem_free_swap() in the future).

>   mm/shmem.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b9ddd38621a0..fe3719eb5a3c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1211,17 +1211,22 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>   				swaps_freed = shmem_free_swap(mapping, indices[i],
>   							      end - 1, folio);
>   				if (!swaps_freed) {
> -					/*
> -					 * If found a large swap entry cross the end border,
> -					 * skip it as the truncate_inode_partial_folio above
> -					 * should have at least zerod its content once.
> -					 */
> +					pgoff_t base = indices[i];
> +
>   					order = shmem_confirm_swap(mapping, indices[i],
>   								   radix_to_swp_entry(folio));
> -					if (order > 0 && indices[i] + (1 << order) > end)
> -						continue;
> -					/* Swap was replaced by page: retry */
> -					index = indices[i];
> +					/*
> +					 * If found a large swap entry cross the end or start
> +					 * border, skip it as the truncate_inode_partial_folio
> +					 * above should have at least zerod its content once.
> +					 */
> +					if (order > 0) {
> +						base = round_down(base, 1 << order);
> +						if (base < start || base + (1 << order) > end)
> +							continue;
> +					}
> +					/* Swap was replaced by page or extended, retry */
> +					index = base;
>   					break;
>   				}
>   				nr_swaps_freed += swaps_freed;


