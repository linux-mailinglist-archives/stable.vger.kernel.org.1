Return-Path: <stable+bounces-244748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPVJOOPX/Wl2jgAAu9opvQ
	(envelope-from <stable+bounces-244748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:32:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4132D4F665F
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 14:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D1C230053DF
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 12:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6211C3DD51F;
	Fri,  8 May 2026 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="KZoHR+wi"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE373DBD4F
	for <stable@vger.kernel.org>; Fri,  8 May 2026 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243432; cv=none; b=Ap3PxesIuvIBljGlJoYn0V/8y8HZ6UGhgyc6uBiJr0pxOckMhM2FknKn7NDxWlIJ7XgxZqcJj1o956fpWyMtVduWeJAaSYyFAD0q8+tm/pou9PygPjeXnirTQwXE6+PebkThQK8upf53RrR9cU6OaXIPTy10c4W0Ga+wCNaq+0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243432; c=relaxed/simple;
	bh=Fu44Pcx+tl0oULl+foyJnaY9isQucoTCVOiPbuoQv84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=soGapN3QHT123osGPzvyy6cA+IjHC7PtJGaJ7joHUiozZIIh9guJc1xSDy/kblSZkPMTIjB5LEVt9AytEQt+kK9D8BDZza0VVzers9ok82ambBEkMQLTk7F+bsDVUjF4m2XAq3Vt7zAXPVkJPxa/TTDK9rC+yxQmgUA3ODaB7fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=KZoHR+wi; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dcd689829eso1710454a34.3
        for <stable@vger.kernel.org>; Fri, 08 May 2026 05:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778243428; x=1778848228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FdtA54XuqgKXS3L2FBe4Ar0i33j6G8LkoDwD5ZQdqBo=;
        b=KZoHR+wirrkVawHP0Ft8CvEJlkBr6hvXBMONR9TsUsYM+Xqq7mKOQHj6iAWgI2NjIF
         xfNuPnllyRZZ4/VKoBgrQpA1tSnhAIIg1b9Z+W3zYJdOtM8aFh/bzJgx6Fj7OwQ3FSnn
         4DH0l2yumAZrMnh5IwWVRsGWTFei+kVTc4iP9nhn14FyaB4Zxb6mlx/OxbpBx5bHaBbj
         Hm2w9QOVJIlr5fa4RvTScuHeKB01omKi9IrdwNzNcu9Aw59MDdezdS66E0+ZUJyFds+x
         Gt2ecaZqIZFb/lEfbVCOp31IKB+wQBqe6QhULOvc3mUkobno+SJLPHgmdEgYWDGKKPJ0
         CuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778243428; x=1778848228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdtA54XuqgKXS3L2FBe4Ar0i33j6G8LkoDwD5ZQdqBo=;
        b=BQWOAsDEut67TZVZVvONsyqSZx8XAyXOan4jfUdRJcFfdq76SfRyNm1WeYwd9wLXTf
         KvTgDDh/TYK/WQTNAvCPNku5RrM41I1o4wPN5JqEdZZqOw3A07LCld5bOStwqphH5CaQ
         qvCHobKH1KwXP64rTJZSeGgFSd+SVTJFUcOvwRl8zd0BrsbbN40ahqjTlB5NwO+mhvy2
         22V7pUVxjfsheSybI9kc90aaAm+Defxi66W10fZoxcV5kHlFh9ldxXQEUWM3a/kx4pYg
         dZSdddZVu15gb5sJAhzymhxx0eZEKbH4hFaVPENjVaPfPAGcX/eFhLW4mQ9mjhzULvPS
         Cmig==
X-Forwarded-Encrypted: i=1; AFNElJ/u5pbICfRyo+Jd+/GzjJOU+9mmJaBY8H7RkHyGf7Bja90s70rXZTr6Uvm1t0BXJLrA6RNcadE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTc+79alP5YFHWSN22CBkFYnxN/B/fQ97bEiRt8dmrIbap9BG4
	LqryarA3U7r99Gt5F9f9HEzcOJPI3lg8Oo4/1dBLVcw+qWZ8DlFotvQ49xdvmNIGJ2o=
X-Gm-Gg: AeBDieuj3zoizjT2BaJEal4UHje0GwY1lYrMmYsPa9O0z+v/Bb6SYnywc8/8Q5K2QHO
	0wiNS4aqSsCBBHI0JZGPfb1D8bNxyexX9HUFuAcsobnzME1E3mOa90mxDaDG8uAr5QlRvnrEmLd
	+5QYJCKqbGu5V3rxiy04Pr2hmtd+OAFH/CPR3/61mBr1nm9Hqbz/jvZhFUVgJMWMEgCgcoIrBSr
	0urIVjYXjNpdL02vcXFY8CC9faLNPv7WqZ68pbGT67gvvmdfDtJhLEHiwVmMCodqvSCun6T9ic8
	c3LedGCYOHctQrRC18M4LdQjh6NUiGn0FsDt6/SJwZjuog/v1frBJWyBUqfWnm1Gnw4csvGscWk
	sn0bIMj+N2BBNRpFbUv0N9gDQ0nHnzX7UOx80IaZcg5dQsc/4XTB+p+Q0mg16S0Oe1T8H9xb7Oi
	rckYgYSp3KIogbxyYgw6kAjTOsqfwfiyWX1hWozoZa24zwNJilocLPhJl2H2OsDxRhP7Rjkw7GV
	gDllAAG3g==
X-Received: by 2002:a05:6830:67ca:b0:7d7:ef0a:1ce9 with SMTP id 46e09a7af769-7e3666ccfe9mr1690822a34.14.1778243428168;
        Fri, 08 May 2026 05:30:28 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367be2238sm1068902a34.6.2026.05.08.05.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 05:30:27 -0700 (PDT)
Message-ID: <38f6d1f7-7869-4d2f-863b-77056f9ef6ff@kernel.dk>
Date: Fri, 8 May 2026 06:30:26 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0.y,6.18.y 0/2] Backport io_uring commit to affected
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Pavel Begunkov <asml.silence@gmail.com>, stable@vger.kernel.org
Cc: Vegard Nossum <vegard.nossum@oracle.com>
References: <20260507124253.97596-1-harshit.m.mogalapalli@oracle.com>
 <5fed66f0-ea72-4f36-bf50-2d7c39c4fdeb@kernel.dk>
 <12c809f5-1326-4cd3-9d4d-2bfb011b23e4@kernel.dk>
 <33d232bb-29be-4f6d-b148-3daae9df0776@gmail.com>
 <b2cd99e4-2369-44bb-a7fd-0035241ad0d7@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b2cd99e4-2369-44bb-a7fd-0035241ad0d7@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4132D4F665F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244748-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[oracle.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel-dk.20251104.gappssmtp.com:dkim,kernel.dk:mid,ze3tar.github.io:url]
X-Rspamd-Action: no action

On 5/8/26 1:52 AM, Harshit Mogalapalli wrote:
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
> Sure, thanks for sharing this. I was reading this:
> https://ze3tar.github.io/post-zcrx.html and thought of sending
> backports to affected-stated stable branches. I looked up at the fix
> and checked probable broken commit and sent these backports. If the
> report is bogus, I think we should leave these but if its safe to
> backport these I think we should ?

I already told that guy that his hallucinated garbage is just plain
wrong. Did you notice in that post how part of the procedure is writing
to /proc/sys/kernel/modprobe? Which you need to be CAP_SYS_ADMIN/root to
do? And if you are root already, then wtf is the point of it. It's also
flagging the wrong commit, the related one fixing an actual bug is:

003049b1c4fb ("io_uring/zcrx: fix user_ref race between scrub and refill paths")

which is why I said this series is fine to do a consistency backport, as
it may make further backports easier, but in no way is it actually
fixing anything.

tldr - blog post is mostly hallucinated garbage made to look like some
novel or new thing, when it very much is not. Author said he'd update
it.

-- 
Jens Axboe

