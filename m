Return-Path: <stable+bounces-211456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJn7JkindGmu8QAAu9opvQ
	(envelope-from <stable+bounces-211456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 12:04:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0377D579
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 12:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2909C300CFC0
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 11:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ADA2882C9;
	Sat, 24 Jan 2026 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2gksqst"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B73519992C
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769252676; cv=none; b=npaDk7s0WGiCBCyDNjDtPmoJ7aDOFQe25e6KrIE74jw8C7/Yur3hZP3lWRshm+VUaZV5E3KNVuFRkuH0sM8Usp6G5rTme6A/oOVv8sRYLOM0kogTNOtqKuidnU3vSWIS9DpnAmPLO6mpoH99jUkAUXmuDikWqaGcbn+a7O6edO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769252676; c=relaxed/simple;
	bh=QvepxcoI9HsfH9a32eqNoIUE7TeRCrEjtB6GukarcdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2Z7Rnv1zFDqOiJ7dtEPfUtOWc42vKzuZ+m+pPVGxQQ9clvDa30zqXBbPH0DBiephNEtl3JOALnJIbTQFz9IuQJgSgGnCcvHk1ZxbQ567lN7Sj/UFex0i4OyOl/SJJVsr/itCTrRQb4fmi3e7fjsX5rJ2G2eVQXW9n4oS+oDRLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2gksqst; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-432da746749so1619662f8f.0
        for <stable@vger.kernel.org>; Sat, 24 Jan 2026 03:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769252674; x=1769857474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYJt6/0BCXAzZx2pq7NPVuk1wGb1eMVM+qNktItIKjs=;
        b=V2gksqstJFJgiEb3ZL72YYVRWyceCx2xOv9axwAvMhDOAXn34el0peAQ+bVajnmzA3
         0ndKXnF//Q81WblmmY42kWKJDJp07iVBtjSPg4xFVgfiTvRVzyIaieb3yvIm2tJblvW0
         dmIQGEIwcyZwijzap8HXjOg9j/SYu+QAwWfNttvNN2pSzKqz4/cahh8nzV4FOIOWqX6y
         b2lGdi0DLiHoczsQxu+CTFFm1EGJulAlBJ5rLhKQlwWJhs2VD6r7CMJ7clLItZ/XgdzJ
         FTBuaI79gAs+KAJJGw0+SuFhKBkQzulbnFujMgU2ee1H2yl0rn1/EUpUxqbfwa2y1yD0
         5jDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769252674; x=1769857474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYJt6/0BCXAzZx2pq7NPVuk1wGb1eMVM+qNktItIKjs=;
        b=lHNtI+euPQzKQxzXSP3YD2c37ndfPvntudajmjNvobIS+FrSu7RnQsyrvV4+HC/Y3N
         7K3FHN9eHR6zK7+65kdwwRHdSI7IRnNqGObhXnF2t1U+tyW4DFb3kOBXNTRXOWwWqbKR
         egCXypbsKqkTvlXsUkQya/sjKID/poHGlKHr/U3JMQTnb0jo6gv27RzlMhlWrdseinCr
         LuM1YL6rA+EMkuA4M5zMgk7pIXviatXS7f6HHUswdwLqYZGwkYeT1brjrXuAGV3G1zfm
         1PDhrPCzbLTFL9hfG5CgWxrggJzwRPQG98u5GUn1Zuh9iV1kspjOwaZEppaw5K+rtgxN
         wQbg==
X-Forwarded-Encrypted: i=1; AJvYcCXarBgvJRaTbCfTLnIidwO6HN1fN41FL4kVvUpAb1mThWTUpQCKbZNCMHQQUaLmWcPre/shY5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAhxY1d5FJThm3eOfme6RsQ+txDdLBXeEuNQq7ZKdpQ3HfZ6r+
	+EAES6iKQctnCMjz8csRPOKmCW6J/F5AvOCrAO3awvlqW+YLgDjvYqvI
X-Gm-Gg: AZuq6aK3r92eJ+eA3JtWXmBS9ePFkwLzP/HLLJe/3fexaRwtMqw6gDuxoUw3+ud7X1c
	Cxeons0C1qZROs/5TGmlBa+1DxFLVG1beo1IM94BiOs4JRffVdPyby7m8UmZTw3MIheqO8vqYWx
	6eqaCWUdJWnMunWoWfmBQZFy/prvrcA++1diNvGhBHr8wUNdqSx0t+O9jD9TykdrAUDLMd0QNGm
	Eq7Qqr+zYTTpd9E9gKNT1gYygGsm+b9WlVFmL4JuQsdMT33bU/VdFT0G+TTDueiGz97X9l5lnNy
	i+wzE/93tZPQXoDi11F1JBTbHybYdyziXl9XvgvU0ruVqVkz7sjeVgWwU9krokM3XS9FAVz5eNM
	pFTYR08BBCvji89tGUaSBdgDNtWCKHmG4yXSZa3fXcvpcTu82uQBR9hwWIfKAXdFk3KFdIAYyL+
	mMmNACnkXziNigv+H9qFUCAhflrGTaeK5BI9cuJDC0m3x53cY3obQEBlcZ4aLwJZNXpnM8zk2CJ
	wOD6KREOrocYgptMUmg3o4e2p8+WybWlKqOW6Za5dxj0wc467Fd1sBNcz21hAz6Tw==
X-Received: by 2002:a05:6000:420e:b0:432:aa61:a06e with SMTP id ffacd0b85a97d-435b9658ccemr7315702f8f.32.1769252673590;
        Sat, 24 Jan 2026 03:04:33 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02c91sm13843795f8f.9.2026.01.24.03.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 03:04:32 -0800 (PST)
Message-ID: <9317bad6-aa89-4e93-b7d2-9e28f5d17cc8@gmail.com>
Date: Sat, 24 Jan 2026 11:04:31 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] io_uring/rsrc: fix RLIMIT_MEMLOCK bypass by removing
 cross-buffer accounting
To: Jens Axboe <axboe@kernel.dk>, Yuhao Jiang <danisjiang@gmail.com>
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <eea0d7c3-9aed-4c1f-8146-23b82e611899@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-211456-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.dk,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 0A0377D579
X-Rspamd-Action: no action

On 1/23/26 16:52, Jens Axboe wrote:
> On 1/23/26 8:04 AM, Jens Axboe wrote:
>> On 1/23/26 7:50 AM, Jens Axboe wrote:
>>> On 1/23/26 7:26 AM, Pavel Begunkov wrote:
>>>> On 1/22/26 21:51, Pavel Begunkov wrote:
>>>> ...
>>>>>>>> I already briefly touched on that earlier, for sure not going to be of
>>>>>>>> any practical concern.
>>>>>>>
>>>>>>> Modest 16 GB can give 1M entries. Assuming 50ns-100ns per entry for the
>>>>>>> xarray business, that's 50-100ms. It's all serialised, so multiply by
>>>>>>> the number of CPUs/threads, e.g. 10-100, that's 0.5-10s. Account sky
>>>>>>> high spinlock contention, and it jumps again, and there can be more
>>>>>>> memory / CPUs / numa nodes. Not saying that it's worse than the
>>>>>>> current O(n^2), I have a test program that borderline hangs the
>>>>>>> system.
...
>> Should've tried 32x32 as well, that ends up going deep into "this sucks"
>> territory:
>>
>> git
>>
>> good luck

FWIW, current scales perfectly with CPUs, so just 1 thread
should be enough for testing.

>> git + user_struct
>>
>> axboe@r7625 ~> time ./ppage 32 32
>> register 32 GB, num threads 32
>>
>> ________________________________________________________
>> Executed in   16.34 secs    fish           external

That's as precise to the calculations above as it could be, it
was 100x16GB but that should only be differ by the factor of ~1.5.
Without anchoring to this particular number, the problem is that
the wall clock runtime for the accounting will linearly depend on
the number of threads, so this 16 sec is what seemed concerning.

>>     usr time    0.54 secs  497.00 micros    0.54 secs
>>     sys time  451.94 secs   55.00 micros  451.94 secs
> 
...
> and the crazier cases:

I don't think it's even crazy, thinking of databases with lots
of caches where it wants to read to / write from. 100GB+
shouldn't be surprising.

> axboe@r7625 ~> time ./ppage 32 32
> register 32 GB, num threads 32
> 
> ________________________________________________________
> Executed in    2.81 secs    fish           external
>     usr time    0.71 secs  497.00 micros    0.71 secs
>     sys time   19.57 secs  183.00 micros   19.57 secs
> 
> which isn't insane. Obviously also needs conditional rescheduling in the
> page loops, as those can take a loooong time for large amounts of
> memory.

2.8 sec sounds like a lot as well, makes me wonder which part of
that is mm, but it mm should scale fine-ish. Surely there will be
contention on page refcounts but at least the table walk is
lockless in the best case scenario and otherwise seems to be read
protected by an rw lock.

-- 
Pavel Begunkov


