Return-Path: <stable+bounces-107963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC19FA05278
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 06:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03321619BC
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 05:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878DC13B797;
	Wed,  8 Jan 2025 05:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hVqksTQT"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E42F10E4
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 05:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736312463; cv=none; b=YUmUkS0eiXJI4VAOtQBlSBvqCztq11RhgOOMIA8RvTl0puSFIJJWO3EJ+QQu4VIOijOkdeiayv6/5LzgvYWZ2X4CGCR5DMTJ5S+MbEI1riFGcP4wDmWdeM/+j3fEhA4eYWF8X8xZ7aIpJTvHsju0Q7jYe32DqIBQeXFp+1nVa5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736312463; c=relaxed/simple;
	bh=0sAZ1cfHKuo9bVZGgP4ELfVOwJXyF7rVU9kKGA43QGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlO2ZnsM319B6qrFiXe2b5sDHN/f6H98JMj2FD1Yyb/nDoZkhNPGbJFOdFkIXpuuMi+0Uf6G51eYLTanJU8ZrfIbbnX18brRZwZlgojRmprBqww5Dys9aZERqK4wkQQgth4+KKnTeQHp8v3mhQWfuTPkXNi/1PrldGL+FZP4vH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hVqksTQT; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <857acdc4-c4b7-44ea-a67d-2df83ca245ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736312443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yFj1VXynprGXG6/ML3EG7dB5MksGwHIqxnVihq/iLvo=;
	b=hVqksTQT3AsE39BS5OnW9/CYbNPt6qWDh5JgS9OPpmtlLBkG0FNnSkssMNsCGWeDLz+JIF
	QczpuhzKlEivMit7xj4lDVwGxwsaL+qIRJ9W/VBOo6RPYuq/2en6RYRb28yqXKICkTZU4t
	/EExKhkWqwb1jbxv3Aphv6kPv6NvpPw=
Date: Wed, 8 Jan 2025 13:00:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU
 acomp_ctx
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Vitaly Wool
 <vitalywool@gmail.com>, Barry Song <baohua@kernel.org>,
 Sam Sun <samsun1006219@gmail.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
References: <20250107222236.2715883-1-yosryahmed@google.com>
 <20250107222236.2715883-2-yosryahmed@google.com>
 <DM8PR11MB567100328F56886B9F179271C9122@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkYqv9oA4V_Ga8KZ_uV1kUnaRYBzHwwd72iEQPO2PKnSiw@mail.gmail.com>
 <SJ0PR11MB5678847E829448EF36A3961FC9122@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYV_pFGCwpzMD_WiBd+46oVHu946M_ARA8tP79zqkJsDA@mail.gmail.com>
 <CAJD7tkYpNNsbTZZqFoRh-FkXDgxONZEUPKk1YQv7-TFMWWQRzQ@mail.gmail.com>
 <CAKEwX=OHcZB8Uy5zj8Dhq-ieiwpJFcqRXN_7=mbM1FD_h_uOOA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAKEwX=OHcZB8Uy5zj8Dhq-ieiwpJFcqRXN_7=mbM1FD_h_uOOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025/1/8 12:46, Nhat Pham wrote:
> On Wed, Jan 8, 2025 at 9:34 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>>
>>
>> Actually, using the mutex to protect against CPU hotunplug is not too
>> complicated. The following diff is one way to do it (lightly tested).
>> Johannes, Nhat, any preferences between this patch (disabling
>> migration) and the following diff?
> 
> I mean if this works, this over migration diasbling any day? :)
> 
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index f6316b66fb236..4d6817c679a54 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -869,17 +869,40 @@ static int zswap_cpu_comp_dead(unsigned int cpu,
>> struct hlist_node *node)
>>          struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
>>          struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
>>
>> +       mutex_lock(&acomp_ctx->mutex);
>>          if (!IS_ERR_OR_NULL(acomp_ctx)) {
>>                  if (!IS_ERR_OR_NULL(acomp_ctx->req))
>>                          acomp_request_free(acomp_ctx->req);
>> +               acomp_ctx->req = NULL;
>>                  if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
>>                          crypto_free_acomp(acomp_ctx->acomp);
>>                  kfree(acomp_ctx->buffer);
>>          }
>> +       mutex_unlock(&acomp_ctx->mutex);
>>
>>          return 0;
>>   }
>>
>> +static struct crypto_acomp_ctx *acomp_ctx_get_cpu_locked(
>> +               struct crypto_acomp_ctx __percpu *acomp_ctx)
>> +{
>> +       struct crypto_acomp_ctx *ctx;
>> +
>> +       for (;;) {
>> +               ctx = raw_cpu_ptr(acomp_ctx);
>> +               mutex_lock(&ctx->mutex);
> 
> I'm a bit confused. IIUC, ctx is per-cpu right? What's protecting this
> cpu-local data (including the mutex) from being invalidated under us
> while we're sleeping and waiting for the mutex?

Yeah, it's not safe, we can only use this_cpu_ptr(), which will disable
preempt (so cpu offline can't kick in), and get refcount of ctx. Since
we can't mutex_lock in the preempt disabled section.

Thanks.

> 
> If it is somehow protected, then yeah this seems quite elegant :)
> 
>> +               if (likely(ctx->req))
>> +                       return ctx;
>> +               /* Raced with zswap_cpu_comp_dead() on CPU hotunplug */
>> +               mutex_unlock(&ctx->mutex);
>> +       }
>> +}
>> +
>> +static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *ctx)
>> +{
>> +       mutex_unlock(&ctx->mutex);
>> +}
>> +
>>   static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>>                             struct zswap_pool *pool)
>>   {
>> @@ -893,10 +916,7 @@ static bool zswap_compress(struct page *page,
>> struct zswap_entry *entry,
>>          gfp_t gfp;
>>          u8 *dst;
>>
>> -       acomp_ctx = raw_cpu_ptr(pool->acomp_ctx);
>> -
>> -       mutex_lock(&acomp_ctx->mutex);
>> -
>> +       acomp_ctx = acomp_ctx_get_cpu_locked(pool->acomp_ctx);
>>          dst = acomp_ctx->buffer;
>>          sg_init_table(&input, 1);
>>          sg_set_page(&input, page, PAGE_SIZE, 0);
>> @@ -949,7 +969,7 @@ static bool zswap_compress(struct page *page,
>> struct zswap_entry *entry,
>>          else if (alloc_ret)
>>                  zswap_reject_alloc_fail++;
>>
>> -       mutex_unlock(&acomp_ctx->mutex);
>> +       acomp_ctx_put_unlock(acomp_ctx);
>>          return comp_ret == 0 && alloc_ret == 0;
>>   }
>>
>> @@ -960,9 +980,7 @@ static void zswap_decompress(struct zswap_entry
>> *entry, struct folio *folio)
>>          struct crypto_acomp_ctx *acomp_ctx;
>>          u8 *src;
>>
>> -       acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
>> -       mutex_lock(&acomp_ctx->mutex);
>> -
>> +       acomp_ctx = acomp_ctx_get_cpu_locked(entry->pool->acomp_ctx);
>>          src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>>          /*

