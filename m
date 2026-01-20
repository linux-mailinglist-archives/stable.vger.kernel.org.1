Return-Path: <stable+bounces-210608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IubOI78b2mUUgAAu9opvQ
	(envelope-from <stable+bounces-210608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 23:07:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F774CBD4
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 23:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 541B492C5D5
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 21:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5173C197B;
	Tue, 20 Jan 2026 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOy0STUX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72A3BBA10
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945515; cv=none; b=lPwsi/fUdfPf4aHllV9TI+/mwAV7RCt5ae3QbVJZLCnE4J6fXKf1s7efHS10Xrt07x+gNq7odRasC1BUwvE9PHL6fDty+XDI41N1xk0s7ZMeIGqF4UISO6T/IfDP4AoSkrF1074Fb+2vynhakmwuzaVsNZVIen85f/gApukBC9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945515; c=relaxed/simple;
	bh=IA85NpiEAZDIPExWUQuK3efPNcrbbelJ5Re9MvHChCY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WPiWBCNGbm3xFAC2tIZH4aBT5epQjyUbaL26lTEApUCsQ39fd9OyRe+vv2ZsQBPv9tHjL9MQRU/fBsV0PgnZJdANpIjO/ZygwgpQdaPsSRKgSvUmrJcO1oIqYayRPQCB3JJK95fGF6iSWEkdq3ku6zkx3HYzXeC7lfHz296lIss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOy0STUX; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so2231395e9.0
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 13:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768945511; x=1769550311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=76GjIwmmNHDMhjPHVEUL/aP6yXjFQm32bCZZwJGshzI=;
        b=cOy0STUXyfkIA+payp5Ls08sBadmogXDqpUYqFHgWdikw2AGH9R8qslDu2mrMjaCRW
         S4RgtluReHUmRKQR+JWkZkD/r5cdaVjjHeIRDlK9wLH4Jq/X/G7L2x+qhbU1MHSh1WxA
         aek3V90/9CI1Cfi/IeLIFNFPrTlgsSk7YfRiMF4+vUEkr4V18EJlSN/zFjsi6QO1mWS7
         wfN/yKa337pDAh4fGByx9Zj2l2c/xwlVDS5i81luAPff9yLdSGksGjPb0RUR5fAAVcNn
         JS2gTJ6etLB2F6Ss7t+oEIiT7iD8dJqROLlGgg384j9joMu1rkGXJQedNPyNlXHc//Oj
         XFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768945511; x=1769550311;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76GjIwmmNHDMhjPHVEUL/aP6yXjFQm32bCZZwJGshzI=;
        b=S/eupKKM9AoJUE+ItvMWJ4GJbQqMnKFhuzAw04RGw+bosfCqZGLPqdNauRg4GdCNLk
         NHgUvwfnehaqQw5gGqISBytnmFcHY0U1CtkWxPmgfUuX+g1TZ2lD1Ffrj8bgOqEqOoC3
         qXy1f5UfsZhhblYc2AGarVJKy7+r6aW6guLTCeO2UkSW3+7VNqi04oKAKcay7MO4vDVG
         Tpfqc34y04hMbvFLbexWJlfc/K9h09PC8tx6dMo6z2N+9EY5hSx9Y7FlW7wH9uV+utPI
         I08myrAsxqoCzDIXDs+O1XZFIokC50Ut1mk7SBv0cZ+0xq1drLGzEr8j96iDHZunsefJ
         jMBA==
X-Forwarded-Encrypted: i=1; AJvYcCVUe0/q9KYhRYfXqhFa6bMA9P5jkt/GEWJyEBBML0Sn+hTKhBoumooM2CMk0xm9whtZM4ZxHsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YytXW2w1buWivKZQu6oXhcs2lyd/5C+rz+pm8csUFXUwaSMNP/O
	WQnuEY0+/nIU9oWbyvLgFitZoZwfp29M9SaYD9TYPzRSHZrxuSIX6Nog
X-Gm-Gg: AY/fxX6t4hc9ERQpg8Fz7QcUg1nd4DfpPNPoANQHpKRXsI3VrUOhhzDclS8OvkfdCx7
	Mzwn6ggngiIVbi09vBp4kql9MV2ifHBNN0scqYfEszVFwGWZOv3uSr0mSiDim9XPI6hqteDFx20
	770BTS/v23b5OxqBH62Unm9Yql1qEAo+yVgmuTxO2YQpHOyLH8kTp/st04Ih4Se4Fgg3V+aU5ja
	S/sl4Cu0hpcIoFkRmHqf5j7O+LkxCqjuGpHVwMkL724DDaSBB4lrJJZDnrkXyqXBmE4svMs4EnR
	9Dzmk/RHbfiwVIQOYKFuAXbitQzHd1edTEMNqMtHy8YSfSfkv7MXYJXxCn8twStOeaxuY2tRcKD
	jcBgZNWKYo84KwaKNHq/qK9gy6AXTXZqz6SdMlkXT4rHsinrrZKW9nxNuDrW27GUwYzS1RVh668
	FA7qiPLIe+1PM69MOEFMUXflIa3N4uHDj7BgkFyOV45dlLSIz0p3lyrvWA1ToaP/HGRjqlxG6D7
	AOt0so1UPriNIN9hzMN2+k8mcKT6k5ah3Ms6zL4wtpPF9bsNvnx6QYq3bwZNcGH/g==
X-Received: by 2002:a05:600c:17d6:b0:47e:e97e:11aa with SMTP id 5b1f17b1804b1-47f4289ac52mr168292055e9.4.1768945511265;
        Tue, 20 Jan 2026 13:45:11 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e886829sm264939395e9.8.2026.01.20.13.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 13:45:07 -0800 (PST)
Message-ID: <2be71481-ac35-4ff2-b6a9-a7568f81f728@gmail.com>
Date: Tue, 20 Jan 2026 21:45:05 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
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
Content-Language: en-US
In-Reply-To: <8c6a9114-82e9-416e-804b-ffaa7a679ab7@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210608-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.dk,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B2F774CBD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/20/26 17:03, Jens Axboe wrote:
> On 1/20/26 5:05 AM, Pavel Begunkov wrote:
>> On 1/20/26 07:05, Yuhao Jiang wrote:
...
>>>
>>> I've been implementing the xarray-based ref tracking approach for v3.
>>> While working on it, I discovered an issue with buffer cloning.
>>>
>>> If ctx1 has two buffers sharing a huge page, ctx1->hpage_acct[page] = 2.
>>> Clone to ctx2, now both have a refcount of 2. On cleanup both hit zero
>>> and unaccount, so we double-unaccount and user->locked_vm goes negative.
>>>
>>> The per-context xarray can't coordinate across clones - each context
>>> tracks its own refcount independently. I think we either need a global
>>> xarray (shared across all contexts), or just go back to v2. What do
>>> you think?
>>
>> The Jens' diff is functionally equivalent to your v1 and has
>> exactly same problems. Global tracking won't work well.
> 
> Why not? My thinking was that we just use xa_lock() for this, with
> a global xarray. It's not like register+unregister is a high frequency
> thing. And if they are, then we've got much bigger problems than the
> single lock as the runtime complexity isn't ideal.

1. There could be quite a lot of entries even for a single ring
with realistic amount of memory. If lots of threads start up
at the same time taking it in a loop, it might become a chocking
point for large systems. Should be even more spectacular for
some numa setups.

2. Most likely it'll further relax accounting (i.e. one way
road), and I don't believe that's the right thing. Could even
be unexpected if consolidated w/o any explicit communication
b/w rings (like buffer cloning).

3. Map keys will need to be {page, user, mm}, so I suspect
impl is not going to be exactly trivial either way. Maybe some
nested xarrays + something for counting middle layer entries.

-- 
Pavel Begunkov


