Return-Path: <stable+bounces-89717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B35F9BB99C
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 16:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6E6282A37
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 15:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1631C07D4;
	Mon,  4 Nov 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ba6U4nWj"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14A41BF804
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730735940; cv=none; b=tzDbv07vd/tCCBiRjqCTSs4Y35TjzxFS4OR5CkgqXqQRMPiji6xx7+JgC1I5GTHuT5KZ5e9/4jlD2nBFmiBiQdlWQU4Wz2QG91l50+14VRuiKwjVXEHEvyRWcmrS+JDMCIyHgqhO4tlumm9B7bE8M6K0Yi/4HmM1do0Es2nWXGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730735940; c=relaxed/simple;
	bh=NhaHiQLeeM5U8QY1u4TUnjkgyHHUp39DbT0trsmIeHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oEdqOKcNGzZcyhv6Kwg2qYhOnChTzuGr46R3hfBBLqpH8n7PZgyPsXoG8MS2BldUZz1OXp6WRmAYTDhdHkYkwBp1eKL/tBX1bb1tBEGeadHnAVg8lw1eJTWVzvn2KmroOz0duP7hRcagBihju32RpUn9fnPu6TIlQ13/XOiqEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ba6U4nWj; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-83ac817aac3so172086039f.0
        for <stable@vger.kernel.org>; Mon, 04 Nov 2024 07:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730735937; x=1731340737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6e/nD16lDPHQ4FWyFr7ZRP80M+oYReyHPvPL/Qu3Gpc=;
        b=Ba6U4nWjPdg/2Ud+VGDcC3g63KmznGYKUKDZgpCrPyiWGRviKNQZtLi0Q/hldik1c3
         G4Vk9bftN5RhEWayvvsWgWwEU0iM4hh/6IXXu3rNLc1+cTifQ24HNHxTPjwft5Nt/16i
         JARm7GW9Ze9bHG9P/H6S8YoPIBjK4W3pGtT28IEJ1ckyLZc8n+3wUeKAEvnQsDb2i4zm
         G52hfvWOpGyat5TgiamO8azpJiiVCJeBw2dRc9X3S7mhggjCJhLeC/gdv0Dbje0qeOEV
         P2a9Y9xCSrZ1PpX8MTuO7lUJGLjHHr78EXw4OsWPk4Lmy9wbGnVTOV3iR/+n/jtojMQP
         BnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730735937; x=1731340737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6e/nD16lDPHQ4FWyFr7ZRP80M+oYReyHPvPL/Qu3Gpc=;
        b=AoRaWVOQDIkIYIoWF3U/RRr2l3ni3utIjyy08ylrM//wgcpDqOQj6T3u8eKAstNclw
         h85VMCxdGe75vgocb+plxQHJwK6WrKt7GBH+HTdr9WAlCFzfGtVm2uevRxpLQIOqprkC
         3WTtR0PNp2CmLvQxLKD/3VBz/5vBy6wXypro+KEuYjHxL/0CWS74L+FuX1RFm/fedInM
         aQX1UOgtUr6cGN8Fxs+hW2SfvPEaFxIv641s21oUiJVB2V2SJKnshH37ddcyPwVBasDr
         0VcmIsSWnsO4goGKhxLjci8OeOXj14xYELDQ6olo7aDJLpUvT2pM4n7J9oJM9LJGtfx7
         H2tA==
X-Forwarded-Encrypted: i=1; AJvYcCV6v7Ax13cbo1b5JNEd3ZL2X0TSNLLqgucArgu86NUZiL6Zwof+8pvxX2tNsiagzHW+28cnVyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxG/pyY0L5SgG2W+nYUsf79zkhMkB8Y3Gac70Fk73/ly6f9hzy
	4jBTLCTZ8e8EZO7h5P4RoJs2/GlxZO+xC2WCbhOspdstXpVYWnwVBw3wKfouUtk=
X-Google-Smtp-Source: AGHT+IFCIzXlcRK0iv0dqWzv0axbztsx3wQi11UA2IJi94+9Axq7TMobh1ZDbgrBwrebzDSPAn0Ieg==
X-Received: by 2002:a05:6602:1592:b0:83a:b7a2:74e6 with SMTP id ca18e2360f4ac-83b56605610mr2554651839f.0.1730735937063;
        Mon, 04 Nov 2024 07:58:57 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048881e8sm1985667173.15.2024.11.04.07.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 07:58:56 -0800 (PST)
Message-ID: <3282cea4-a47c-4e62-9d1f-5c0321676fd5@kernel.dk>
Date: Mon, 4 Nov 2024 08:58:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stable backport (was "Re: PROBLEM: io_uring hang causing
 uninterruptible sleep state on 6.6.59")
To: Andrew Marshall <andrew@johnandrewmarshall.com>,
 Keith Busch <kbusch@kernel.org>
Cc: io-uring@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>
References: <3d913aef-8c44-4f50-9bdf-7d9051b08941@app.fastmail.com>
 <cc8b92ba-2daa-49e3-abe6-39e7d79f213d@kernel.dk>
 <ZygO7O1Pm5lYbNkP@kbusch-mbp>
 <25c4c665-1a33-456c-93c7-8b7b56c0e6db@kernel.dk>
 <c34e6c38-ca47-439a-baf1-3489c05a65a8@kernel.dk>
 <98907a37-81dd-463e-b5ef-9190bf0f33be@app.fastmail.com>
 <23b02882-6f23-4b19-b39d-fd4ef09429ad@app.fastmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <23b02882-6f23-4b19-b39d-fd4ef09429ad@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/24 6:17 AM, Andrew Marshall wrote:
> On Sun, Nov 3, 2024, at 23:25, Andrew Marshall wrote:
>> On Sun, Nov 3, 2024, at 21:38, Jens Axboe wrote:
>>> On 11/3/24 5:06 PM, Jens Axboe wrote:
>>>> On 11/3/24 5:01 PM, Keith Busch wrote:
>>>>> On Sun, Nov 03, 2024 at 04:53:27PM -0700, Jens Axboe wrote:
>>>>>> On 11/3/24 4:47 PM, Andrew Marshall wrote:
>>>>>>> I identified f4ce3b5d26ce149e77e6b8e8f2058aa80e5b034e as the likely
>>>>>>> problematic commit simply by browsing git log. As indicated above;
>>>>>>> reverting that atop 6.6.59 results in success. Since it is passing on
>>>>>>> 6.11.6, I suspect there is some missing backport to 6.6.x, or some
>>>>>>> other semantic merge conflict. Unfortunately I do not have a compact,
>>>>>>> minimal reproducer, but can provide my large one (it is testing a
>>>>>>> larger build process in a VM) if needed?there are some additional
>>>>>>> details in the above-linked downstream bug report, though. I hope that
>>>>>>> having identified the problematic commit is enough for someone with
>>>>>>> more context to go off of. Happy to provide more information if
>>>>>>> needed.
>>>>>>
>>>>>> Don't worry about not having a reproducer, having the backport commit
>>>>>> pin pointed will do just fine. I'll take a look at this.
>>>>>
>>>>> I think stable is missing:
>>>>>
>>>>>   6b231248e97fc3 ("io_uring: consolidate overflow flushing")
>>>>
>>>> I think you need to go back further than that, this one already
>>>> unconditionally holds ->uring_lock around overflow flushing...
>>>
>>> Took a look, it's this one:
>>>
>>> commit 8d09a88ef9d3cb7d21d45c39b7b7c31298d23998
>>> Author: Pavel Begunkov <asml.silence@gmail.com>
>>> Date:   Wed Apr 10 02:26:54 2024 +0100
>>>
>>>     io_uring: always lock __io_cqring_overflow_flush
>>>
>>> Greg/stable, can you pick this one for 6.6-stable? It picks
>>> cleanly.
>>>
>>> For 6.1, which is the other stable of that age that has the backport,
>>> the attached patch will do the trick.
>>>
>>> With that, I believe it should be sorted. Hopefully that can make
>>> 6.6.60 and 6.1.116.
>>>
>>> -- 
>>> Jens Axboe
>>> Attachments:
>>> * 0001-io_uring-always-lock-__io_cqring_overflow_flush.patch
>>
>> Cherry-picking 6b231248e97fc3 onto 6.6.59, I can confirm it passes my 
>> reproducer (run a few times). Your first quick patch also passed, for 
>> what it?s worth. Thanks for the quick responses!
> 
> Correction: I cherry-picked and tested
> 8d09a88ef9d3cb7d21d45c39b7b7c31298d23998 (which was the change you
> identified), not 6b231248e97fc3. Apologies for any confusion.

Thanks for clarifying, so it's as expected. Hopefully -stable can pick
this backport up soonish, so the next stable release will be sorted.
Thanks for reporting the issue!

-- 
Jens Axboe

