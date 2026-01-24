Return-Path: <stable+bounces-211459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AkpB+nhdGnB+gAAu9opvQ
	(envelope-from <stable+bounces-211459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 16:14:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 655957E045
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 16:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59953300DDF5
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 15:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243C93191C8;
	Sat, 24 Jan 2026 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="t7PBKbTS"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DAC21C9F9
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769267682; cv=none; b=r2QLxXrOmqU51ESOEqmmuvFfBxdRL0M8G8p0n3MY28bIrvQvbP5zc4SsNOBFdb6IBnXBMTX6dCSezks4c2/tCPF8pJKeocx59OtNICRbl8v6GwOZvoBqqsHTPVfpRLx5bPrunkdT1QvbwRL1I3JiJnIxrgWrm2dsDrvkfNDeDfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769267682; c=relaxed/simple;
	bh=mlxg/+Y14geNE63XB5dcfGiprcSJzXI8gCcwNwhvaI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLBfwXdRgnUbKmOnpMXuFn0wHLIEh3dUh6svKRzUTyFsBlBRZXJTYp7X0dPpS/bojOKxE1ySwbHGn1eDzFKryyHhtR0SiPZgeyPqYSDYwLJVsSfb9izxhVp8mpTeSpTwu62NiPnWEbyX+Yiwe5rcOIRToRxPLbwS/KE5Q2e8xaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=t7PBKbTS; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-404308dd5d6so1084002fac.1
        for <stable@vger.kernel.org>; Sat, 24 Jan 2026 07:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769267680; x=1769872480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=twHLCrUFaWNPEY9IZbwbr71SXMraJnqj5vi/Tu8ErvI=;
        b=t7PBKbTSmHOPGZmQZCox4D1TWi+hTLozNalpz3VDQB2bC6t/drMI1GPmzf+VFZII3a
         12h7BwwmSPugrR9YWWEo0zQsXEJIbJwiV8H/arLFwQ8N8gijyd11hej9qd79yz7AF0lj
         vnVWh3724bxAkj6PjW/qBNnu+ySPRE2RI02karRa281EgVvr6thZoFuBWPGSWhnE7ucg
         7pclMzhQFCPWi9a3AqvxJnCc9aA7WcZ/hq/O3ZWa3vZfWx736ahJiNXPp7hmopCuW+UG
         nMfsdo3IWXpfsZwSBB1Q6r12PPw5dY9gcP+CeA5Aq5dQO3/KJFtcfWmOn3/XPcpDAewO
         7LpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769267680; x=1769872480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twHLCrUFaWNPEY9IZbwbr71SXMraJnqj5vi/Tu8ErvI=;
        b=C7d3wxUk5PjdXUNwVm1/4/ugrf1zmTz+R+uaiXrzVD8YDybIWcUvoypy63gGxmmxbw
         g1RMCKZRKxDlym5RgLWwRCC2KiZ4vm5BmzuPXH7nGDqL8XPCQbtk0gD1IN3auJVxhWLA
         pvNGUxF4n+kDfKcM8CCLTtEXTmgpcCdCSNeMYglr0UiMKPpHpR5TWM26asQAKgzkO083
         5TBSecXmX0PEX3VTf83RBLekBu7mpGIQZFu9SPjyu3IU2DuOJcfuks/3LN+RrAVXf48U
         mbqo2fOxq4v5G49RQNomnxqzhM3r3L0w6sFQmf7uoUMiEg5e5UZuD0vriTk/0ltcHEL0
         3G7A==
X-Forwarded-Encrypted: i=1; AJvYcCXnpl9eYot1aB242sMsRrj/wXE178QAwSnM012f1ufePcYNQLmzGPtQI0KRKfo6WgYft+VIvIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnvdlv6YdanQaQNdD0ypWASHVlwIM6Ra79nKUDtHoNMJyOD7Va
	SpPgR4lRMWqfCzx62ZKU856J6p2gsEj/Ow2CZvareYHahqOsqfaeQoLjgaMBDMKNPBLXndBbGES
	RFwYkmg5Ncw==
X-Gm-Gg: AZuq6aIPfqUAaiOYjjMfr2MnfNtT6ESu1cXu0WltANhn42AXWmceySvGFdDZ2Rc789q
	jBTkkRYuTlFM+vqbszTc9SL45Hpd2yzta6oaq9qHLtyHUbRYfS2vKxO08EvqJZRWJFqEe2M+98A
	2GoJyrTYEUZ2Opf249Oa5tC//Tq7HDAm2T3wFHNFkewaxfZCFbhVVHvPToPsA/cctNUZWH1hww4
	KqVFStbfjyi3lI11X2KGzPDzwT4woh7qKDIZHM1SrBCcG+p97DgqwPCi8qs3op80opoEBrZYe3+
	TKp1ZBsoWgCojZerug0t7Juf5rWFHMkrBBuylaPEz5Zoxbc+c5opMDGCITIysoRqmUzaVyA86+4
	25Akguo83k4+/NYZJUQ2U9xv7qKODJIR1quKr+izkdmwhuYDciKVurwS4lCwHp8GTfs4cerdZdo
	k9xlF6rlsw7M+awwDW+snGR72ASHPoLczIDB1oXR2Lg8lxVo+1q8pvSF/sj+8N6ZaPisfFuQ==
X-Received: by 2002:a05:6820:16a5:b0:662:c5c5:4fa8 with SMTP id 006d021491bc7-662cab5253cmr2834549eaf.39.1769267678481;
        Sat, 24 Jan 2026 07:14:38 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662cb4e5b2fsm2507135eaf.1.2026.01.24.07.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 07:14:37 -0800 (PST)
Message-ID: <74f2ec89-ca40-44a0-8df7-de404063a1a3@kernel.dk>
Date: Sat, 24 Jan 2026 08:14:35 -0700
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
 <3b7e6088-7d92-4d5c-96c7-f8c0e2cc7745@kernel.dk>
 <efe080c9-5176-4fa1-9f65-5be44074779e@gmail.com>
 <596bc7ac-3d24-43a7-9e7e-e59189525ebc@gmail.com>
 <fc8664bb-7769-48a2-b470-71fb81828e26@kernel.dk>
 <654fe339-5a2b-4c38-9d2d-28cfc306b307@kernel.dk>
 <eea0d7c3-9aed-4c1f-8146-23b82e611899@kernel.dk>
 <9317bad6-aa89-4e93-b7d2-9e28f5d17cc8@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <9317bad6-aa89-4e93-b7d2-9e28f5d17cc8@gmail.com>
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
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211459-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:mid]
X-Rspamd-Queue-Id: 655957E045
X-Rspamd-Action: no action

On 1/24/26 4:04 AM, Pavel Begunkov wrote:
> On 1/23/26 16:52, Jens Axboe wrote:
>> On 1/23/26 8:04 AM, Jens Axboe wrote:
>>> On 1/23/26 7:50 AM, Jens Axboe wrote:
>>>> On 1/23/26 7:26 AM, Pavel Begunkov wrote:
>>>>> On 1/22/26 21:51, Pavel Begunkov wrote:
>>>>> ...
>>>>>>>>> I already briefly touched on that earlier, for sure not going to be of
>>>>>>>>> any practical concern.
>>>>>>>>
>>>>>>>> Modest 16 GB can give 1M entries. Assuming 50ns-100ns per entry for the
>>>>>>>> xarray business, that's 50-100ms. It's all serialised, so multiply by
>>>>>>>> the number of CPUs/threads, e.g. 10-100, that's 0.5-10s. Account sky
>>>>>>>> high spinlock contention, and it jumps again, and there can be more
>>>>>>>> memory / CPUs / numa nodes. Not saying that it's worse than the
>>>>>>>> current O(n^2), I have a test program that borderline hangs the
>>>>>>>> system.
> ...
>>> Should've tried 32x32 as well, that ends up going deep into "this sucks"
>>> territory:
>>>
>>> git
>>>
>>> good luck
> 
> FWIW, current scales perfectly with CPUs, so just 1 thread
> should be enough for testing.
> 
>>> git + user_struct
>>>
>>> axboe@r7625 ~> time ./ppage 32 32
>>> register 32 GB, num threads 32
>>>
>>> ________________________________________________________
>>> Executed in   16.34 secs    fish           external
> 
> That's as precise to the calculations above as it could be, it
> was 100x16GB but that should only be differ by the factor of ~1.5.
> Without anchoring to this particular number, the problem is that
> the wall clock runtime for the accounting will linearly depend on
> the number of threads, so this 16 sec is what seemed concerning.
> 
>>>     usr time    0.54 secs  497.00 micros    0.54 secs
>>>     sys time  451.94 secs   55.00 micros  451.94 secs
>>
> ...
>> and the crazier cases:
> 
> I don't think it's even crazy, thinking of databases with lots
> of caches where it wants to read to / write from. 100GB+
> shouldn't be surprising.

I mean crazier in terms of runtime, not use case. 32G is peanuts in
terms of memory these days.

>> axboe@r7625 ~> time ./ppage 32 32
>> register 32 GB, num threads 32
>>
>> ________________________________________________________
>> Executed in    2.81 secs    fish           external
>>     usr time    0.71 secs  497.00 micros    0.71 secs
>>     sys time   19.57 secs  183.00 micros   19.57 secs
>>
>> which isn't insane. Obviously also needs conditional rescheduling in the
>> page loops, as those can take a loooong time for large amounts of
>> memory.
> 
> 2.8 sec sounds like a lot as well, makes me wonder which part of
> that is mm, but it mm should scale fine-ish. Surely there will be
> contention on page refcounts but at least the table walk is
> lockless in the best case scenario and otherwise seems to be read
> protected by an rw lock.

Well a lot of that is also just faulting in the memory on clear, test
case should probably be modified to do its own timing. And iterating
page arrays is a huge part of it too. There's no real contention in that
2.8 seconds.

-- 
Jens Axboe

