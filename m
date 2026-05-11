Return-Path: <stable+bounces-245170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ApHCuCmAWpDhQEAu9opvQ
	(envelope-from <stable+bounces-245170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:52:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C74050B5D9
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE56530CEF56
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D8C3BADA3;
	Mon, 11 May 2026 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUZnHh6I"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7AD2F0C45
	for <stable@vger.kernel.org>; Mon, 11 May 2026 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491532; cv=none; b=KDe7T0Zi8VfYBon3kKnXqO7vzsrBDZXa+x8N8XXzLLpqJDjM9jODM2IUAaocZs2ioz3R2asWQvIO9+OmaIuEeORd3fUna1S8hdMdAzh4RdUa3EJ7ZPP7J+mnh18h6D7v3344sRYOfGbgZPrSfHFnohS1lj8L+VCUA81vtORaxoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491532; c=relaxed/simple;
	bh=DxErux1vzJTqACLId2fAvDAUWfPv1d+38MuIAhw994M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2bPn0tSD+6BTenKMfWdWu2/b2CBFwC2EL7G7YwGAKka/Ryh6vyYFOpQPzS9+jDVK1eO7pYjOA49whTNwLWK7EGhwGVowgodfraDWab7gcoLPaUX2P8vh2aI2rAHDBpxPWg2VR1LRkp5gs5IKvKEzIScUdjWEK05Cw4u7WoaIuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sUZnHh6I; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so641693366b.2
        for <stable@vger.kernel.org>; Mon, 11 May 2026 02:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778491529; x=1779096329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEhjZ96fzEc8ISDty0mOFnkVTniZLZTuZl2n2NDV7gE=;
        b=sUZnHh6Ik+FRcQyQs9yqDFW17jYKbL+t75hhtPCBFu2xictKrFjfyIc7AHUIXkkIjj
         nViJ2wEnuCUgbQ+v4MkhsiGoG+j17yYmfAMiEDOW8HIEiPf6d/3QA1N9IIj9NbqT8zkD
         Uke0FAxNW3qUOJ3yEgPbgPOYy0kmZYpXkhNxV522FrU/bhz1yjgxEGmsQuHDmj+DpbFd
         HsGGM6r4XWA+gG/ib7U8zuB4uIF04f27n9lIp1uH3fqYUamq46U6/xlFQtPu4+gg1OCK
         DdNChj4OHIpzhHmBYi6TtpUyvJwYv2s9NyCs/WT9GGDumvScLcIAPb6Coxr38UbTtBN5
         vF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778491529; x=1779096329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEhjZ96fzEc8ISDty0mOFnkVTniZLZTuZl2n2NDV7gE=;
        b=c65Zn7QrTgVS0ZB8pTOX+R+MzUgkFsm3iTqVjVBCxxEQRyKscT47cKioVVM8NVBJoy
         4tXbjuClYse1Li7gMDEUAnBGgyAypkU7uix1hBCKeRkOmctBq/BTStm4DJWRiK9I6Pyd
         vHYU6QvJqF0z6InVu8eMo4qbrCcvXHliyTDw/wu02BV/eHDpeaFGhkRixwz5S0Rl+Nq/
         nOS63e7tmjcekh7DblIKYcu1jbyQwymrp+64V6vUKuZU7Z1jumg3jCTaxT4q2bh7LP12
         jY9A2q0yA+OK0x+0+/sL2x+irQez4n5LIX01fqK7cgtRrKW495oJS7ydXLKN8d9jkT2Z
         QUpA==
X-Forwarded-Encrypted: i=1; AFNElJ8agioE4kfj5Z93aJ0qc8r4Ahf67cnicSh/EDNs6itJKho3ckV5B15uZB6lQRVhmQ5LLO69NRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRb5YUxiGFqs9ybQcpfasSLUB+cEVHWW8u4LYYoZisNNtiEw4v
	czR9NmzhPxZ1pdBntf3VuTifKWvy3DeTU1mMkyIgbZYoGArhek5+6ScCPd9k/g==
X-Gm-Gg: Acq92OEUYSH4mU6+HdJBfYJanRnKcffcaQEWX7YUXBQwO1jEWGiXDzhkQc4D0DAmRTg
	bZIkX2H3UEHTfl5pYRtxmARuatmJIF3fJfU8nDjl20qoEaJ+6w7Axv0ba1PEOaAzQNLl3UMyhpR
	G2jpN+KK7lw+CehV/yS2HJAgBhVYBe8s+WXmQzsWHCM0Nzo2M6/R9rupl54QiOwOeHyVlK+cwen
	X/ibNU2Gm7KIdYTQ2SURiHrak8Rj1Uub5/HcP/q92CXRqY2KiLWfzvffZw5IBB6vU58XyQ974y9
	uGf2fvXIQtqRhTtwgxGoH/mMdREd0dv/1tQ8lCOI0xCSMll9g6CzQG1YUl05fA0d2UpoyTxEZa2
	mkmXGtUHX49W9cD71NjvCmUX/0WgIE1IvOINPDyYZcJstRgEetSIJH0ut/5aLGqXb8BWaJnY7m+
	Sqbhjmrb8INz00ZJnRO652lW0pOQeQ1SXxabkkHhiUCknHOy9kbU33ardrNTtk1L498LgXudzDM
	+WEVXN4hHzz74hR+IX+RHXL1FmkqusqILOiAB4=
X-Received: by 2002:a17:906:9fc4:b0:bc3:c6f5:1d47 with SMTP id a640c23a62f3a-bc56ad31a92mr1405945066b.11.1778491528541;
        Mon, 11 May 2026 02:25:28 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::33a? ([2620:10d:c092:600::1:efb3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac02c7a16sm474725466b.12.2026.05.11.02.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 02:25:27 -0700 (PDT)
Message-ID: <852aa66e-60c8-4270-9908-1e72182a6988@gmail.com>
Date: Mon, 11 May 2026 10:25:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0.y,6.18.y 0/2] Backport io_uring commit to affected
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Cc: Vegard Nossum <vegard.nossum@oracle.com>
References: <20260507124253.97596-1-harshit.m.mogalapalli@oracle.com>
 <5fed66f0-ea72-4f36-bf50-2d7c39c4fdeb@kernel.dk>
 <12c809f5-1326-4cd3-9d4d-2bfb011b23e4@kernel.dk>
 <33d232bb-29be-4f6d-b148-3daae9df0776@gmail.com>
 <b2cd99e4-2369-44bb-a7fd-0035241ad0d7@oracle.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <b2cd99e4-2369-44bb-a7fd-0035241ad0d7@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8C74050B5D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245170-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ze3tar.github.io:url]
X-Rspamd-Action: no action

On 5/8/26 08:52, Harshit Mogalapalli wrote:
> Hi Jens and Pavel,
> 
> On 08/05/26 07:37, Pavel Begunkov wrote:
>> On 5/7/26 23:46, Jens Axboe wrote:
>>> On 5/7/26 4:41 PM, Jens Axboe wrote:
>>>> On 5/7/26 6:42 AM, Harshit Mogalapalli wrote:
>>>>> Hi Jens and stable maintainers,
>>>>>
>>>>> The intent of this series is to backport commit: 770594e78c39
>>>>> ("io_uring/zcrx: warn on freelist violations") to 6.18.y and 7.0.y.
>>>>>
>>>>> This above commit likely is fixing commit: 34a3e60821ab ("io_uring/ zcrx:
>>>>> implement zerocopy receive pp memory provider") in 6.18.y and 7.0.y.
>>>>>
>>>>> Pulled in a prerequisite to cleanly apply the fix. Only build tested.
>>>>
>>>> I don't think these are actually required, but at the same time it does
>>>> not hurt to add them. I'll leave that to Pavel to decide.
>>>>
>>>> In any case, thanks for doing the backports!
>>>
>>> Adding Pavel, I had assumed he was already on the email, as he's the
>>> maintainer for that file.
>>
>> What's motivation for this? I don't mind to have it (after review),
>> but it's not a fix, and I know people want it in stable to claim a
>> hallucinated CVE, and the CVE part is not going to happen.
>>
> 
> Sure, thanks for sharing this. I was reading this: https://ze3tar.github.io/post-zcrx.html and thought of sending backports to affected-stated stable branches. I looked up at the fix and checked probable broken commit and sent these backports. If the report is bogus, I think we should leave these but if its safe to backport these I think we should ?

Got it, thanks for sending the patches, it's better than potentially
overlooking a problem. I'll take a look at as hardening, but the
article refers to non-existent code, the reproducer doesn't reproduce,
it doesn't even do what it says it does, there are one mistake after
another. I took a closer look a week+ ago, and I believe it's all
hallucinations that has never been actually run / validated.

-- 
Pavel Begunkov


