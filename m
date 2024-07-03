Return-Path: <stable+bounces-57598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A208925D29
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41DB29725C
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A3117BB13;
	Wed,  3 Jul 2024 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="lTaJyjns"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D02E61FE7;
	Wed,  3 Jul 2024 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005365; cv=none; b=TOKxfCoBrJ/rk1giVIEOHUjCDxTRWDwXvdj4ePnLqgVYwNyL3TUHtQGVhenUyP3IYbdDasObwJs7AA4ktZ0NIOkgZNXrK4p+xkPPS3vGsVGXGty5br4zD20cLbC3AMiWjdz17jig8PP8Dy+14K0xtJ6B8q0wqerqEp+phd0Qk8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005365; c=relaxed/simple;
	bh=juOIZ9AODlDarDJeGQRbnLsc+RdH2QSf6K1bsVyvsMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCjdDQrp82KEgiJWAYKx4j56BLH1IKaa61V1rn2ahQnjoV+pYPjFH1w5GQXza/hw9aQLePG9oQSnTojippKoWD2Mt4iNs4eB6UcwqhZ+HlCgyXqtbOZjBCK332VLSeL4TVLLiQvkIcQW8BybdpX4O4PpvUP+QDjZksR+myJOCCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=lTaJyjns; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Q42ysf7Ux/6y3GzYGr+UkZ7htmtWB+6tElFWJ0Z5Pms=;
	b=lTaJyjnscpY+tCKv9KDv6VVgz1qPRpLaCGQAP2wCQRniqxAczMJQSyL47PBpu8
	pt9mpA/C7OF6auqyvKe9qOyPWiWDcCqGmqcL4VvbbPcpSlrGqpVnYkDq7QlhQTS7
	bwY/0Wkx6enOxqxAzmMXkwcA9VUFZXXJo0rVU34WOINYY=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wD3P4_UMoVmXL0xAQ--.30814S2;
	Wed, 03 Jul 2024 19:15:33 +0800 (CST)
Message-ID: <b3d041ab-6f0f-4cd9-81a5-bf20bddc88ea@126.com>
Date: Wed, 3 Jul 2024 19:15:32 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, david@redhat.com,
 baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
References: <1719038884-1903-1-git-send-email-yangge1116@126.com>
 <CAGsJ_4yO5NJ4kSDPaS-QdRyKfw-A52HE+Jn38vQpbonFSE8ZoQ@mail.gmail.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <CAGsJ_4yO5NJ4kSDPaS-QdRyKfw-A52HE+Jn38vQpbonFSE8ZoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P4_UMoVmXL0xAQ--.30814S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF4UGrWfGr15Jr48GFW8tFb_yoW7ZFW8pF
	WxGrnIqFWDGFsrur47Xr15AF1Fk393XF4UAFWxGFy7AFn8Z3WqkF1xKw1Uua9xAr15uFn7
	u3WUXFnYg3WUJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYOJ5UUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWRURG2VLbI6TgQABsZ



在 2024/7/3 17:46, Barry Song 写道:
> On Sat, Jun 22, 2024 at 6:48 PM <yangge1116@126.com> wrote:
>>
>> From: yangge <yangge1116@126.com>
>>
>> If a large number of CMA memory are configured in system (for example, the
>> CMA memory accounts for 50% of the system memory), starting a virtual
>> virtual machine, it will call pin_user_pages_remote(..., FOLL_LONGTERM,
>> ...) to pin memory.  Normally if a page is present and in CMA area,
>> pin_user_pages_remote() will migrate the page from CMA area to non-CMA
>> area because of FOLL_LONGTERM flag. But the current code will cause the
>> migration failure due to unexpected page refcounts, and eventually cause
>> the virtual machine fail to start.
>>
>> If a page is added in LRU batch, its refcount increases one, remove the
>> page from LRU batch decreases one. Page migration requires the page is not
>> referenced by others except page mapping. Before migrating a page, we
>> should try to drain the page from LRU batch in case the page is in it,
>> however, folio_test_lru() is not sufficient to tell whether the page is
>> in LRU batch or not, if the page is in LRU batch, the migration will fail.
>>
>> To solve the problem above, we modify the logic of adding to LRU batch.
>> Before adding a page to LRU batch, we clear the LRU flag of the page so
>> that we can check whether the page is in LRU batch by folio_test_lru(page).
>> Seems making the LRU flag of the page invisible a long time is no problem,
>> because a new page is allocated from buddy and added to the lru batch,
>> its LRU flag is also not visible for a long time.
>>
>> Cc: <stable@vger.kernel.org>
> 
> you have Cced stable, what is the fixes tag?

Thanks，I will add it in next version.

> 
>> Signed-off-by: yangge <yangge1116@126.com>
>> ---
>>   mm/swap.c | 43 +++++++++++++++++++++++++++++++------------
>>   1 file changed, 31 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/swap.c b/mm/swap.c
>> index dc205bd..9caf6b0 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -211,10 +211,6 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
>>          for (i = 0; i < folio_batch_count(fbatch); i++) {
>>                  struct folio *folio = fbatch->folios[i];
>>
>> -               /* block memcg migration while the folio moves between lru */
>> -               if (move_fn != lru_add_fn && !folio_test_clear_lru(folio))
>> -                       continue;
>> -
>>                  folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
>>                  move_fn(lruvec, folio);
>>
>> @@ -255,11 +251,16 @@ static void lru_move_tail_fn(struct lruvec *lruvec, struct folio *folio)
>>   void folio_rotate_reclaimable(struct folio *folio)
>>   {
>>          if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
>> -           !folio_test_unevictable(folio) && folio_test_lru(folio)) {
>> +           !folio_test_unevictable(folio)) {
>>                  struct folio_batch *fbatch;
>>                  unsigned long flags;
>>
>>                  folio_get(folio);
>> +               if (!folio_test_clear_lru(folio)) {
>> +                       folio_put(folio);
>> +                       return;
>> +               }
>> +
>>                  local_lock_irqsave(&lru_rotate.lock, flags);
>>                  fbatch = this_cpu_ptr(&lru_rotate.fbatch);
>>                  folio_batch_add_and_move(fbatch, folio, lru_move_tail_fn);
>> @@ -352,11 +353,15 @@ static void folio_activate_drain(int cpu)
>>
>>   void folio_activate(struct folio *folio)
>>   {
>> -       if (folio_test_lru(folio) && !folio_test_active(folio) &&
>> -           !folio_test_unevictable(folio)) {
>> +       if (!folio_test_active(folio) && !folio_test_unevictable(folio)) {
>>                  struct folio_batch *fbatch;
>>
>>                  folio_get(folio);
>> +               if (!folio_test_clear_lru(folio)) {
>> +                       folio_put(folio);
>> +                       return;
>> +               }
>> +
>>                  local_lock(&cpu_fbatches.lock);
>>                  fbatch = this_cpu_ptr(&cpu_fbatches.activate);
>>                  folio_batch_add_and_move(fbatch, folio, folio_activate_fn);
>> @@ -700,6 +705,11 @@ void deactivate_file_folio(struct folio *folio)
>>                  return;
>>
>>          folio_get(folio);
>> +       if (!folio_test_clear_lru(folio)) {
>> +               folio_put(folio);
>> +               return;
>> +       }
>> +
>>          local_lock(&cpu_fbatches.lock);
>>          fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate_file);
>>          folio_batch_add_and_move(fbatch, folio, lru_deactivate_file_fn);
>> @@ -716,11 +726,16 @@ void deactivate_file_folio(struct folio *folio)
>>    */
>>   void folio_deactivate(struct folio *folio)
>>   {
>> -       if (folio_test_lru(folio) && !folio_test_unevictable(folio) &&
>> -           (folio_test_active(folio) || lru_gen_enabled())) {
>> +       if (!folio_test_unevictable(folio) && (folio_test_active(folio) ||
>> +           lru_gen_enabled())) {
>>                  struct folio_batch *fbatch;
>>
>>                  folio_get(folio);
>> +               if (!folio_test_clear_lru(folio)) {
>> +                       folio_put(folio);
>> +                       return;
>> +               }
>> +
>>                  local_lock(&cpu_fbatches.lock);
>>                  fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate);
>>                  folio_batch_add_and_move(fbatch, folio, lru_deactivate_fn);
>> @@ -737,12 +752,16 @@ void folio_deactivate(struct folio *folio)
>>    */
>>   void folio_mark_lazyfree(struct folio *folio)
>>   {
>> -       if (folio_test_lru(folio) && folio_test_anon(folio) &&
>> -           folio_test_swapbacked(folio) && !folio_test_swapcache(folio) &&
>> -           !folio_test_unevictable(folio)) {
>> +       if (folio_test_anon(folio) && folio_test_swapbacked(folio) &&
>> +           !folio_test_swapcache(folio) && !folio_test_unevictable(folio)) {
>>                  struct folio_batch *fbatch;
>>
>>                  folio_get(folio);
>> +               if (!folio_test_clear_lru(folio)) {
>> +                       folio_put(folio);
>> +                       return;
>> +               }
>> +
>>                  local_lock(&cpu_fbatches.lock);
>>                  fbatch = this_cpu_ptr(&cpu_fbatches.lru_lazyfree);
>>                  folio_batch_add_and_move(fbatch, folio, lru_lazyfree_fn);
>> --
>> 2.7.4
>>


