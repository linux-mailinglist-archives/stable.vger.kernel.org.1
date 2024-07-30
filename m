Return-Path: <stable+bounces-62628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370C89402E3
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 02:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7E31C20E93
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 00:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0E123C9;
	Tue, 30 Jul 2024 00:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="MRM0gzB5"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AE053BE;
	Tue, 30 Jul 2024 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722301106; cv=none; b=Ap3S7orW4m58HprPDO+hEUFbk1BPkOvt18cxTaAEFMSDz3kwZJb/RypJQo1QaKsPUfz+zXE8vQyoxyMEcmaZCCRv6fOJCjrjQ9CGzm5B9u9hzLqTJj/v736TfeoZ8tcBk3cjESnH2Jk8cWPw6rA4wSGlY6mAmbeDaem0L9LEuYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722301106; c=relaxed/simple;
	bh=9suAbGPU+QWmDDx2guOwlCO/7fzUsJs//9uO7oGcidY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zuba78fGqRWuIzBjYEgWL4xeYrPiSpJqTpDhXNtyzUt34F6uKoHGyKnGfL+ZfHzXPWk6gb97dUN+zMgqi1eciMHI2ahmYQfMuF8dZfc53lyfLb89LaekiAPyqxXnaKnTrHANf9TaLzEwdeV2ayXf0vvg3oUUnhfqEOVBMazuQp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=MRM0gzB5; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=gnQaqa4yRlIvwZVmQDp4+I96iPATKoWO64nJkQY4TyU=;
	b=MRM0gzB5Zgu+ITtWJW+yO6ygMqxVKANYjUW9z9fuc9/0sJUcPZBuG6qZzYxPPn
	JG4ihN++h7eyHAIaqHJB7Y/2nuzo7bTHqX9+RCFLMAyKO8mGmY7x2ci0U1KkWS6H
	EOTD6LawM/Sv8LacS3X2aHLcCKPOYFaXNMKbObjgBRLLQ=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wD3_wmQOqhm4E3MAw--.13651S2;
	Tue, 30 Jul 2024 08:57:54 +0800 (CST)
Message-ID: <79234eac-d7cc-424b-984d-b78861a5e862@126.com>
Date: Tue, 30 Jul 2024 08:57:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
References: <1719038884-1903-1-git-send-email-yangge1116@126.com>
 <3a2ab0ea-3a07-45a0-ae0e-b9d48bf409bd@redhat.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <3a2ab0ea-3a07-45a0-ae0e-b9d48bf409bd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_wmQOqhm4E3MAw--.13651S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFW7ZF1kGw1kXFyrGw1Utrb_yoW7ur43pF
	WxGrnIqFWDJFsrur47Xr15AF1Fk393XF4UAFWxGFy7AFn8Zw1qkF1xKw1UGa9xJr15uF1x
	Z3WUXFn5W3WUJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5CzZUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWRMsG2VLbxqygQABsU



在 2024/7/29 22:04, David Hildenbrand 写道:
> On 22.06.24 08:48, yangge1116@126.com wrote:
>> From: yangge <yangge1116@126.com>
>>
>> If a large number of CMA memory are configured in system (for example, 
>> the
>> CMA memory accounts for 50% of the system memory), starting a virtual
>> virtual machine, it will call pin_user_pages_remote(..., FOLL_LONGTERM,
>> ...) to pin memory.  Normally if a page is present and in CMA area,
>> pin_user_pages_remote() will migrate the page from CMA area to non-CMA
>> area because of FOLL_LONGTERM flag. But the current code will cause the
>> migration failure due to unexpected page refcounts, and eventually cause
>> the virtual machine fail to start.
>>
>> If a page is added in LRU batch, its refcount increases one, remove the
>> page from LRU batch decreases one. Page migration requires the page is 
>> not
>> referenced by others except page mapping. Before migrating a page, we
>> should try to drain the page from LRU batch in case the page is in it,
>> however, folio_test_lru() is not sufficient to tell whether the page is
>> in LRU batch or not, if the page is in LRU batch, the migration will 
>> fail.
>>
>> To solve the problem above, we modify the logic of adding to LRU batch.
>> Before adding a page to LRU batch, we clear the LRU flag of the page so
>> that we can check whether the page is in LRU batch by 
>> folio_test_lru(page).
>> Seems making the LRU flag of the page invisible a long time is no 
>> problem,
>> because a new page is allocated from buddy and added to the lru batch,
>> its LRU flag is also not visible for a long time.
>>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: yangge <yangge1116@126.com>
>> ---
>>   mm/swap.c | 43 +++++++++++++++++++++++++++++++------------
>>   1 file changed, 31 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/swap.c b/mm/swap.c
>> index dc205bd..9caf6b0 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -211,10 +211,6 @@ static void folio_batch_move_lru(struct 
>> folio_batch *fbatch, move_fn_t move_fn)
>>       for (i = 0; i < folio_batch_count(fbatch); i++) {
>>           struct folio *folio = fbatch->folios[i];
>> -        /* block memcg migration while the folio moves between lru */
>> -        if (move_fn != lru_add_fn && !folio_test_clear_lru(folio))
>> -            continue;
>> -
>>           folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
>>           move_fn(lruvec, folio);
>> @@ -255,11 +251,16 @@ static void lru_move_tail_fn(struct lruvec 
>> *lruvec, struct folio *folio)
>>   void folio_rotate_reclaimable(struct folio *folio)
>>   {
>>       if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
>> -        !folio_test_unevictable(folio) && folio_test_lru(folio)) {
>> +        !folio_test_unevictable(folio)) {
>>           struct folio_batch *fbatch;
>>           unsigned long flags;
>>           folio_get(folio);
>> +        if (!folio_test_clear_lru(folio)) {
>> +            folio_put(folio);
>> +            return;
>> +        }
>> +
>>           local_lock_irqsave(&lru_rotate.lock, flags);
>>           fbatch = this_cpu_ptr(&lru_rotate.fbatch);
>>           folio_batch_add_and_move(fbatch, folio, lru_move_tail_fn);
>> @@ -352,11 +353,15 @@ static void folio_activate_drain(int cpu)
>>   void folio_activate(struct folio *folio)
>>   {
>> -    if (folio_test_lru(folio) && !folio_test_active(folio) &&
>> -        !folio_test_unevictable(folio)) {
>> +    if (!folio_test_active(folio) && !folio_test_unevictable(folio)) {
>>           struct folio_batch *fbatch;
>>           folio_get(folio);
>> +        if (!folio_test_clear_lru(folio)) {
>> +            folio_put(folio);
>> +            return;
>> +        }
>> +
>>           local_lock(&cpu_fbatches.lock);
>>           fbatch = this_cpu_ptr(&cpu_fbatches.activate);
>>           folio_batch_add_and_move(fbatch, folio, folio_activate_fn);
>> @@ -700,6 +705,11 @@ void deactivate_file_folio(struct folio *folio)
>>           return;
>>       folio_get(folio);
>> +    if (!folio_test_clear_lru(folio)) {
>> +        folio_put(folio);
>> +        return;
>> +    }
>> +
>>       local_lock(&cpu_fbatches.lock);
>>       fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate_file);
>>       folio_batch_add_and_move(fbatch, folio, lru_deactivate_file_fn);
>> @@ -716,11 +726,16 @@ void deactivate_file_folio(struct folio *folio)
>>    */
>>   void folio_deactivate(struct folio *folio)
>>   {
>> -    if (folio_test_lru(folio) && !folio_test_unevictable(folio) &&
>> -        (folio_test_active(folio) || lru_gen_enabled())) {
>> +    if (!folio_test_unevictable(folio) && (folio_test_active(folio) ||
>> +        lru_gen_enabled())) {
>>           struct folio_batch *fbatch;
>>           folio_get(folio);
>> +        if (!folio_test_clear_lru(folio)) {
>> +            folio_put(folio);
>> +            return;
>> +        }
>> +
>>           local_lock(&cpu_fbatches.lock);
>>           fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate);
>>           folio_batch_add_and_move(fbatch, folio, lru_deactivate_fn);
>> @@ -737,12 +752,16 @@ void folio_deactivate(struct folio *folio)
>>    */
>>   void folio_mark_lazyfree(struct folio *folio)
>>   {
>> -    if (folio_test_lru(folio) && folio_test_anon(folio) &&
>> -        folio_test_swapbacked(folio) && !folio_test_swapcache(folio) &&
>> -        !folio_test_unevictable(folio)) {
>> +    if (folio_test_anon(folio) && folio_test_swapbacked(folio) &&
>> +        !folio_test_swapcache(folio) && 
>> !folio_test_unevictable(folio)) {
>>           struct folio_batch *fbatch;
>>           folio_get(folio);
>> +        if (!folio_test_clear_lru(folio)) {
>> +            folio_put(folio);
>> +            return;
>> +        }
> 
> Looking at this in more detail, I wonder if we can turn that to
> 
> if (!folio_test_clear_lru(folio))
>      return;
> folio_get(folio);
> 
> In all cases? The caller must hold a reference, so this should be fine.
> 

Seems the caller madvise_free_pte_range(...), calling 
folio_mark_lazyfree(...), doesn't hold a reference on folio.


