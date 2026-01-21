Return-Path: <stable+bounces-210774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJtRNwH/cGmgbAAAu9opvQ
	(envelope-from <stable+bounces-210774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:29:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F0F59E68
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 581B39AE80D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6CB4D9900;
	Wed, 21 Jan 2026 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kAKiXTat"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F864D90A2
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007494; cv=none; b=SufYuY7DpzzT3yzx6wTYanVXKwXTIxCrCl97WJvcHXCkNIlXtkstnGI0bVgKeIILyIW7EEZHLXu+eE+f9LUu9pSs0N/bLyOA8d4z4e8cLtyUeHFmVCMIOsEVmmnVRpcRayLwhqTbyfyD/R9HEOyLS+rhg/759NW+yaiXVEyp8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007494; c=relaxed/simple;
	bh=FhRF4TprwvtpTNTyA7ahJyGZxuy3UAIoj1FV/RjFo1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTeYRnjtSsQZtFaqA2g9/jYGHGvLyFcZepOZyK2Pvndv8A/kHkVDgDzRx5+9zABBCLLrIPW7AV4340au3/o5cPnmzlL/FhNgjmkbzZR7Qs8XnxZoq82qkSTa8DmsfWTBoX8ebgytQhrE0YN89bJhzpqhS1fRG9gFIEkkR1Z8EiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kAKiXTat; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7cfd95f77a3so4267172a34.0
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 06:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769007491; x=1769612291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMSymaMx0zUSENRKlkjeR2DpFwBjeuqiJTkmHDD+xpM=;
        b=kAKiXTatDKxpAxSiH9fd+b/rCdVJrZ1OHPDsk/LYiasSz3OQRyR6DaC/L+IL+BufxJ
         nidRxsfO8DQH+obMq3qIEjDNepxBkJm2dMklRkV4X1Oa9/7zJwoHju1I4JPaSosHunjd
         Fsmv7pEqJV4wbiZUaUxP0MxSEkJp7yaIHJNyaBTdkCEZhNsGVq/zaZavG8aqUvcUBSlG
         ImsCZmEGbGybh8JNQeAzi8AV4FXuTdGM2tQ7TCRISGiJW4aMoCeRXE9Z4Zl7d1cERrBM
         w30gq+3eZZ6LTPQAAAp1h6TtvT9EyDvLftrfiLeh1ij6pFxFR1KAQrlNioLKoysFxIve
         dpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007491; x=1769612291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMSymaMx0zUSENRKlkjeR2DpFwBjeuqiJTkmHDD+xpM=;
        b=hzId2M7ytXRngO+dAGI0xPOWUCsg0XcOPDX5BlUISwrc3Th574UvgLZA5bldJOeVYp
         /RDSBZpY1rk6LS050AFiDJBoNFfX2ZOp5Qv7nnw0xcGMd+QGD1CjN/ycKZ3Bb/pqD//G
         ZZ1AKDD+vOvuGHiSq8uQhVSQvgBAnKkx43ch0GwFzHYlHYKaeC0G1doeY3rkrllPZlTd
         fSBjlNoZeLYjLmi1w4qEPfrfu/bosP9Fy4nuGBVokYM9RKHXxS5snAUd9eLRFOXpqv3x
         ucIKmT6vgZifOKKeORvFseUaYkh7K2TazFi4mRAFj/NHW3dBTWjcFlzIZD3Lfv4xLRYF
         aWKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWThXl22Hm1WZ8DZi0htLaeXvgs/xFMDG4Jya7jsnpadaydiFpnZNvQGHENP6tWpDXWYOwA1o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP2nanTUMD1XjfIfwp3hHEfqvyYvUknNAQ8tufgRF9yOOT4w4c
	d6cNZOKxi0Ox6yCMlWTW5KXnkTWT32nmNIuy3+RVxoO6STtv2Z81ClSn/XK8140iQEPXTMZ+Jhk
	TBWGz5XyIxw==
X-Gm-Gg: AZuq6aIue7pUzsOHMOTCckeAiilvFxeHTUPrIinevwe1e+UEjSQW4WL09BxQJBwdLqt
	cPP/x3fMHs3FAOASksTb8daC8vgnBXwz3I83kScU3jZ5jVnCFhhUd4oIcUSylnSmkI/wH+UZKTq
	J006bPXSR5YZX6Og4a+tT4VZf5Vp3O3cZZZ8AikT+hqMBPJC5/F05GIxSIW+/j9mbDUrNtEp3i/
	NaQM9QIsPvvgsabAEVND0nA8Sw/VpqpzD4qF5NROCg/jOfHXUS03nWaYRg+iHrOyhMzMQ/y4dB6
	UjybS+bEU+55zjUe56eOEVZQHxkW/1lrXIIs0QeyqVRZYAnWXNntqSLKJMR2qjDUb5I257Rl4l2
	2x3Xv7rXvVaTnPPQqE3gkEiT4C/wleQb9V1COwuIN4ogNH0Zz8AcQAb8zxb49tdE2Hf25evMtbX
	KOyDNvDBfDppyHOzu2QhIRa1SdshpgFoLpgraNZjQ4ol/UQZSREEWypdVjYVCn2R9BDXmh
X-Received: by 2002:a05:6830:82ea:b0:7cf:f7c1:d9ac with SMTP id 46e09a7af769-7cff7c1da6dmr8425940a34.9.1769007491402;
        Wed, 21 Jan 2026 06:58:11 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2a5f6dsm10709783a34.20.2026.01.21.06.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 06:58:10 -0800 (PST)
Message-ID: <2fcf583a-f521-4e8d-9a89-0985681ca85b@kernel.dk>
Date: Wed, 21 Jan 2026 07:58:10 -0700
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
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2be71481-ac35-4ff2-b6a9-a7568f81f728@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-210774-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,kernel.dk:mid,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 52F0F59E68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/20/26 2:45 PM, Pavel Begunkov wrote:
> On 1/20/26 17:03, Jens Axboe wrote:
>> On 1/20/26 5:05 AM, Pavel Begunkov wrote:
>>> On 1/20/26 07:05, Yuhao Jiang wrote:
> ...
>>>>
>>>> I've been implementing the xarray-based ref tracking approach for v3.
>>>> While working on it, I discovered an issue with buffer cloning.
>>>>
>>>> If ctx1 has two buffers sharing a huge page, ctx1->hpage_acct[page] = 2.
>>>> Clone to ctx2, now both have a refcount of 2. On cleanup both hit zero
>>>> and unaccount, so we double-unaccount and user->locked_vm goes negative.
>>>>
>>>> The per-context xarray can't coordinate across clones - each context
>>>> tracks its own refcount independently. I think we either need a global
>>>> xarray (shared across all contexts), or just go back to v2. What do
>>>> you think?
>>>
>>> The Jens' diff is functionally equivalent to your v1 and has
>>> exactly same problems. Global tracking won't work well.
>>
>> Why not? My thinking was that we just use xa_lock() for this, with
>> a global xarray. It's not like register+unregister is a high frequency
>> thing. And if they are, then we've got much bigger problems than the
>> single lock as the runtime complexity isn't ideal.
> 
> 1. There could be quite a lot of entries even for a single ring
> with realistic amount of memory. If lots of threads start up
> at the same time taking it in a loop, it might become a chocking
> point for large systems. Should be even more spectacular for
> some numa setups.

I already briefly touched on that earlier, for sure not going to be of
any practical concern.

> 2. Most likely it'll further relax accounting (i.e. one way
> road), and I don't believe that's the right thing. Could even
> be unexpected if consolidated w/o any explicit communication
> b/w rings (like buffer cloning).

Well the aim is to make the accounting actually correct.

> 3. Map keys will need to be {page, user, mm}, so I suspect
> impl is not going to be exactly trivial either way. Maybe some
> nested xarrays + something for counting middle layer entries.

Honestly I think the xarray just needs to go into struct user_struct.

-- 
Jens Axboe

