Return-Path: <stable+bounces-107969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3145AA05306
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 07:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8353A3665
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 06:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ECA153836;
	Wed,  8 Jan 2025 06:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WL5blAvy"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B64F2E40E
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 06:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736316065; cv=none; b=SMrEK1DuJIjmapu65Dd/BNVSzKrbMHG23xmxqNJSW40Rle9EZonVY+RGVizhdN/7oCorPgztqIJYWWwKO+ISt7RwSY32mMOww2Eqs6ykE71wtmA78PXyBzcQwuceO/M3Eftsgw4Rtoq9urc+R1hGue+LE7Zap0kJFAx3AwnVEKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736316065; c=relaxed/simple;
	bh=rtR2YHwE7AV6xVlSWkJyb8bR60yi1JXO4YlbdoYiI8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6DkS9BaTIhPlZK2unNR9eomcTr27dgDHEN3t+XVl1oLzaVJjauYuhAae8aPqUTBtI69TeSIe5ozl11jWi8fkahG1ez/nXZKlBu9+vXM2KyHk7p8F2y1qrSbAz6284T2HRVxHlTghqZPLJ7gA9dlYGHcS4HLnB6uyLqwPcux4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WL5blAvy; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <038d3db8-a56c-469e-804a-c258731f3362@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736316058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tz/X7zQuq6YwE0g7vrq1zjJ6XRCK9g30OEfwcIt8haI=;
	b=WL5blAvyMkK3Ncv/kDGTuLen+GVccgkpnWvRlS2J3GtcVnsb5/F3OkbgVFX7ZmwllHpTqs
	gUvOYBFhXKECV2a/tJO7DPr3+5h+qzE9XMJZe06uAYQOevXVCuIyVSUxvu5sCAd5yArMeL
	4q15F5uW9NmibvfywVibuejVQ9kQ3Qk=
Date: Wed, 8 Jan 2025 14:00:40 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU
 acomp_ctx
To: Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>
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
 <857acdc4-c4b7-44ea-a67d-2df83ca245ed@linux.dev>
 <CAJD7tkZ+UeXXvFc+M9JssooW_0rW-GVgUMo3GVcSMCxQhndZuA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <CAJD7tkZ+UeXXvFc+M9JssooW_0rW-GVgUMo3GVcSMCxQhndZuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025/1/8 13:34, Yosry Ahmed wrote:
> On Tue, Jan 7, 2025 at 9:00 PM Chengming Zhou <chengming.zhou@linux.dev> wrote:
>>
>> On 2025/1/8 12:46, Nhat Pham wrote:
>>> On Wed, Jan 8, 2025 at 9:34 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>>>>
>>>>
>>>> Actually, using the mutex to protect against CPU hotunplug is not too
>>>> complicated. The following diff is one way to do it (lightly tested).
>>>> Johannes, Nhat, any preferences between this patch (disabling
>>>> migration) and the following diff?
>>>
>>> I mean if this works, this over migration diasbling any day? :)
>>>
>>>>
>>>> diff --git a/mm/zswap.c b/mm/zswap.c
>>>> index f6316b66fb236..4d6817c679a54 100644
>>>> --- a/mm/zswap.c
>>>> +++ b/mm/zswap.c
>>>> @@ -869,17 +869,40 @@ static int zswap_cpu_comp_dead(unsigned int cpu,
>>>> struct hlist_node *node)
>>>>           struct zswap_pool *pool = hlist_entry(node, struct zswap_pool, node);
>>>>           struct crypto_acomp_ctx *acomp_ctx = per_cpu_ptr(pool->acomp_ctx, cpu);
>>>>
>>>> +       mutex_lock(&acomp_ctx->mutex);
>>>>           if (!IS_ERR_OR_NULL(acomp_ctx)) {
>>>>                   if (!IS_ERR_OR_NULL(acomp_ctx->req))
>>>>                           acomp_request_free(acomp_ctx->req);
>>>> +               acomp_ctx->req = NULL;
>>>>                   if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
>>>>                           crypto_free_acomp(acomp_ctx->acomp);
>>>>                   kfree(acomp_ctx->buffer);
>>>>           }
>>>> +       mutex_unlock(&acomp_ctx->mutex);
>>>>
>>>>           return 0;
>>>>    }
>>>>
>>>> +static struct crypto_acomp_ctx *acomp_ctx_get_cpu_locked(
>>>> +               struct crypto_acomp_ctx __percpu *acomp_ctx)
>>>> +{
>>>> +       struct crypto_acomp_ctx *ctx;
>>>> +
>>>> +       for (;;) {
>>>> +               ctx = raw_cpu_ptr(acomp_ctx);
>>>> +               mutex_lock(&ctx->mutex);
>>>
>>> I'm a bit confused. IIUC, ctx is per-cpu right? What's protecting this
>>> cpu-local data (including the mutex) from being invalidated under us
>>> while we're sleeping and waiting for the mutex?
> 
> Please correct me if I am wrong, but my understanding is that memory
> allocated with alloc_percpu() is allocated for each *possible* CPU,
> and does not go away when CPUs are offlined. We allocate the per-CPU
> crypto_acomp_ctx structs with alloc_percpu() (including the mutex), so
> they should not go away with CPU offlining.

Ah, right! I missed that only buffer and req is dynamically allocated
by the cpu online callback.

Then your fix is safe to me, thanks for your explanation!

> 
> OTOH, we allocate the crypto_acomp_ctx.acompx, crypto_acomp_ctx.req,
> and crypto_acomp_ctx.buffer only for online CPUs through the CPU
> hotplug notifiers (i.e. zswap_cpu_comp_prepare() and
> zswap_cpu_comp_dead()). These are the resources that can go away with
> CPU offlining, and what we need to protect about.
> 
> The approach I am taking here is to hold the per-CPU mutex in the CPU
> offlining code while we free these resources, and set
> crypto_acomp_ctx.req to NULL. In acomp_ctx_get_cpu_locked(), we hold
> the mutex of the current CPU, and check if crypto_acomp_ctx.req is
> NULL.
> 
> If it is NULL, then the CPU is offlined between raw_cpu_ptr() and
> acquiring the mutex, and we retry on the new CPU that we end up on. If
> it is not NULL, then we are guaranteed that the resources will not be
> freed by CPU offlining until acomp_ctx_put_unlock() is called and the
> mutex is unlocked.
> 
>>
>> Yeah, it's not safe, we can only use this_cpu_ptr(), which will disable
>> preempt (so cpu offline can't kick in), and get refcount of ctx. Since
>> we can't mutex_lock in the preempt disabled section.
> 
> My understanding is that the purpose of this_cpu_ptr() disabling
> preemption is to prevent multiple CPUs accessing per-CPU data of a
> single CPU concurrently. In the zswap case, we don't really need that
> because we use the mutex to protect against it (and we cannot disable
> preemption anyway).

Yes, your fix is correct, preemption disable is not needed in this case.

Thanks.

