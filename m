Return-Path: <stable+bounces-211287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGIaN91icmnfjQAAu9opvQ
	(envelope-from <stable+bounces-211287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:48:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 459B76BA3A
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D1B3000FC8
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FED342503;
	Thu, 22 Jan 2026 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ekzaEtyL"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4903019B0
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104086; cv=none; b=SjzAePAw8uIdmQ/2i5c/g2UnZgKs1vwrw7G0dEhQTnuiXw7XEg8ryti4m2lJOQvmZWjmQy/cnbe0Y94JOOg3lMlkvdVXbJzyPk12L7KO5aKaIf4WvHMuY+AWh6u3J79yA+ZgImLrLX5rUqPqqPheENfFbyVc6ZSBJp3tSZPXYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104086; c=relaxed/simple;
	bh=49srhGImsId0QkHe5QH0OscT6JWTVDJqrGDDcteRD6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZZ9Zf2enc/J85fLaL8OjvLTM3EHQqX3TTB0hkIqLyKjWu3IKK5xVmtmlfkTlO8xlnFyTl2f+L65cYGXMjZ3+6Q4GFJPn1DFXONsS3f/Hi0K0iulUGlT/DS1C5qxvyy6trM4h1JYzl7FRonT28Mm1skHuHdTVH7fdrM1yCSB56A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ekzaEtyL; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-45c733ccc32so423935b6e.0
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 09:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769104078; x=1769708878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAqYu3xB4La4CDsCFBPKH7jgCHbWvIT5wooh5c1w7TA=;
        b=ekzaEtyLptFcVPJZAjKX7EgwWmXjs3Z6bghpmwtqTaQFBQNjEP4pClwtVM7ivKOQf9
         cshxFBn8t1VRJU3K59EO0uHoa3h4NZDdLHrWVgpYhzDHG9TSZCzIwZYh2je3QyODV1Yx
         eQH9a+vRSxV7veydJuyfrmPac32UGUjWN06xLXl3Rb7XpLwXtU6HysIQNNzr+1g14tnu
         kWRAMP5TuaQzY17XJWNygas/hISnT3NPSjt4a7y+gDvfoDnrxupAYCYdFHtm0+UHG+m9
         80XZ2OdvhDt+jovYQHow9X9Ir5JB997scPDKmzGqCI4gviTBPTWqkmSvoqn6cmHhTAqd
         S0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104078; x=1769708878;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAqYu3xB4La4CDsCFBPKH7jgCHbWvIT5wooh5c1w7TA=;
        b=JzwtOpOL2TT5RMKUwqobiuy4j/UpTaPkGcHM/JVg17Iq6V4F/eHmNZ8wifcKPx1Ww9
         dSNLTTYAZQRiCN5tYkfcqrAVrp+IViQ4Bvs6kBfZffyVkJjKXznkwdm6KIr+x/xG8MKk
         HP0v44ZhfBV3HSw7qi6sZHYIHr2/UwxOYEz4DV3SJgs77M9plhvSXHM/nCjR5u5Lr7ip
         pKxsQUpAnBKhJ1gQ0BjXwSEuiEkwT8H+rAOeqQ9fL03cGLYB+7QdyrL5DimBOynFuc6o
         xD9i6gc0Wp+HLsD/poyB6FXXBk4I3ZrrEQuqzVDI/DfIxXlsJQxpt74rpebdvvfUan1j
         fJ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnV49iJ7eywNFlmKIBve8rEdKVO/Y1o8itWOIiD1Tzvz5cs0X6lZtb96Lqw9p1J/Wh2BcnPD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF2U+uWA3fs1joVuQX88CXvNjXI6E1os47L0vRDHd/exE0urAG
	zpF+RHluhttUyLlsG6Gx5dFJintisuJpRNMSNzLRAWA9VrHah2BWmQdrYdsjOMdVu2o=
X-Gm-Gg: AZuq6aK0GTomf8wCjp2u6/xENC0IcebuU+jvWMu5JbcRM2yL0y9UZshErQjZOhpLmNZ
	pQ2ZrS98/DA0InLLzk5xJPpz1/G4A19wNAm4AIO4AQ3Cf3orOF+/wD24CK5MbfzWeLpfmHKvuLZ
	Bfai4YBAY16bMwR/GQRd66VPfwaEaIrM3kN6CHPNvHkR3Ygota5w565tdZiu5i3Ly7HENBj1hUh
	NuPebbOclTJ+AbkvDJdqjxSqUZF9px4nWLuj5ec8ZsHVMyi9JwlwVyT/MeWrDyg+gTr3AhiomAw
	8Vdgt7E5Ax8uA72nqxv2v6w7cmN5jAK5zGMG100CLNBSfEx33I8wF0xJ3hkz/U4HU2vzmocFDW+
	aVdmWc2suS/bKPNlcZ3S+HvgYCwP2gXASqjRWtL49VpC9GAT/6FuFgSyN+KmwVSxLDxcBmvk8pl
	UQF1dp8SRtluL2N9GFqLO5g8Wa7VTZs9niXQU8TYHLBKCliDgyFEnUKoPzMBEcH53huR1M
X-Received: by 2002:a05:6808:4482:b0:450:474b:2736 with SMTP id 5614622812f47-45eb1cf6dc0mr193617b6e.45.1769104078250;
        Thu, 22 Jan 2026 09:47:58 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9e08943csm10644269b6e.20.2026.01.22.09.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 09:47:57 -0800 (PST)
Message-ID: <3b7e6088-7d92-4d5c-96c7-f8c0e2cc7745@kernel.dk>
Date: Thu, 22 Jan 2026 10:47:56 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] io_uring/rsrc: fix RLIMIT_MEMLOCK bypass by removing
 cross-buffer accounting
To: Pavel Begunkov <asml.silence@gmail.com>,
 Yuhao Jiang <danisjiang@gmail.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260119071039.2113739-1-danisjiang@gmail.com>
 <bc2e8ec1-8809-4603-9519-788cfff2ae12@kernel.dk>
 <CAHYQsXTHfRKBuTDYWus9r5jDLO2WLBeopt4_bGH_vVm=0z7mWw@mail.gmail.com>
 <2919f3c5-2510-4e97-ab7f-c9eef1c76a69@kernel.dk>
 <CAHYQsXQK4nKu+fcni71__=V241RN=QxUHrvNQMQtPMzeL_z=BA@mail.gmail.com>
 <d8d28435-2a89-4b25-925e-14fdb346839b@gmail.com>
 <8c6a9114-82e9-416e-804b-ffaa7a679ab7@kernel.dk>
 <2be71481-ac35-4ff2-b6a9-a7568f81f728@gmail.com>
 <2fcf583a-f521-4e8d-9a89-0985681ca85b@kernel.dk>
 <d2fc2ff2-98d9-49f8-af95-968100174d55@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <d2fc2ff2-98d9-49f8-af95-968100174d55@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211287-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 459B76BA3A
X-Rspamd-Action: no action

On 1/22/26 4:43 AM, Pavel Begunkov wrote:
> On 1/21/26 14:58, Jens Axboe wrote:
>> On 1/20/26 2:45 PM, Pavel Begunkov wrote:
>>> On 1/20/26 17:03, Jens Axboe wrote:
>>>> On 1/20/26 5:05 AM, Pavel Begunkov wrote:
>>>>> On 1/20/26 07:05, Yuhao Jiang wrote:
>>> ...
>>>>>>
>>>>>> I've been implementing the xarray-based ref tracking approach for v3.
>>>>>> While working on it, I discovered an issue with buffer cloning.
>>>>>>
>>>>>> If ctx1 has two buffers sharing a huge page, ctx1->hpage_acct[page] = 2.
>>>>>> Clone to ctx2, now both have a refcount of 2. On cleanup both hit zero
>>>>>> and unaccount, so we double-unaccount and user->locked_vm goes negative.
>>>>>>
>>>>>> The per-context xarray can't coordinate across clones - each context
>>>>>> tracks its own refcount independently. I think we either need a global
>>>>>> xarray (shared across all contexts), or just go back to v2. What do
>>>>>> you think?
>>>>>
>>>>> The Jens' diff is functionally equivalent to your v1 and has
>>>>> exactly same problems. Global tracking won't work well.
>>>>
>>>> Why not? My thinking was that we just use xa_lock() for this, with
>>>> a global xarray. It's not like register+unregister is a high frequency
>>>> thing. And if they are, then we've got much bigger problems than the
>>>> single lock as the runtime complexity isn't ideal.
>>>
>>> 1. There could be quite a lot of entries even for a single ring
>>> with realistic amount of memory. If lots of threads start up
>>> at the same time taking it in a loop, it might become a chocking
>>> point for large systems. Should be even more spectacular for
>>> some numa setups.
>>
>> I already briefly touched on that earlier, for sure not going to be of
>> any practical concern.
> 
> Modest 16 GB can give 1M entries. Assuming 50ns-100ns per entry for the
> xarray business, that's 50-100ms. It's all serialised, so multiply by
> the number of CPUs/threads, e.g. 10-100, that's 0.5-10s. Account sky
> high spinlock contention, and it jumps again, and there can be more
> memory / CPUs / numa nodes. Not saying that it's worse than the
> current O(n^2), I have a test program that borderline hangs the
> system.

It's definitely not worse than the existing system, which is why I don't
think it's a big deal. Nobody has ever complained about time to register
buffers. It's inherently a slow path, and quite slow at that depending
on the use case. Out of curiosity, I ran some stilly testing on
registering 16GB of memory, with 1..32 threads. Each will do 16GB, so
512GB registered in total for the 32 case. Before is the current kernel,
after is with per-user xarray accounting:

before

nthreads 1:      646 msec
nthreads 2:      888 msec
nthreads 4:      864 msec
nthreads 8:     1450 msec
nthreads 16:    2890 msec
nthreads 32:    4410 msec

after

nthreads 1:      650 msec
nthreads 2:      888 msec
nthreads 4:      892 msec
nthreads 8:     1270 msec
nthreads 16:    2430 msec
nthreads 32:    4160 msec

This includes both registering buffers, cloning all of them to another
ring, and unregistering times, and nowhere is locking scalability an
issue for the xarray manipulation. The box has 32 nodes and 512 CPUs. So
no, I strongly believe this isn't an issue.

IOW, accurate accounting is cheaper than the stuff we have now. None of
them are super cheap. Does it matter? I really don't think so, or people
would've complained already. The only complaint I got on these kinds of
things was for cloning, which did get fixed up some releases ago.

> Look, I don't care what it'd be, whether it stutters or blows up the
> kernel, I only took a quick look since you pinged me and was asking
> "why not". If you don't want to consider my reasoning, as the
> maintainer you can merge whatever you like, and it'll be easier for
> me as I won't be wasting more time.

I do consider your reasoning, but you also need to consider mine rather
than assuming there's only one answer here, or that yours is invariably
the correct one and being stubborn about it. The above test obviously
isn't the end-all be-all of testing, but it would show if we had issues
with scaling to the extent that you assume.

Also worth considering that for these kinds of parallel setups running,
the (by far) common use case is threads. And hence you're going to be
banging on the shared mm anyway for a lot of these memory related setup
operations.

-- 
Jens Axboe

