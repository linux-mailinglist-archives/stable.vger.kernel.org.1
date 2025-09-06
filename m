Return-Path: <stable+bounces-178011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63551B47800
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 00:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E831C23E4E
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 22:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3141FECCD;
	Sat,  6 Sep 2025 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aQVnWsKQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F8A15D3
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757198383; cv=none; b=f78DWBEWPzceshKrTN/WkPIojSCpuwbInTGiM3dN3tikk2Vc9gx54rJpQRAAmcIF30NwzHNM3dnCx+LodGodreG2TQrNpPqlHk5ZopQmA0st+2aLzKKQ9GnQIjFqQaf2uD0ZDnOSSV+X4qZZzn//HF2BVxFQ2RYCYVXJFaiySSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757198383; c=relaxed/simple;
	bh=g2Ej3kH2PgbNKrN4UlD1enBJMQ/Q1QllWxYMZ+p2cMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cpfy112OwLw7a5SK9WQrgb0GUnnyEEXGycjYs6gcppP9AetYeKdbRxcLpwQFonzKFxhu3Q92Tz9xH0pLmTdOFVscJKX+G9OQHC1OshydgjTgr7iXBi6+KRvmTMQbgqMuKkVzHvzkayQKr4dE6LUU+p1O7OJ0SdHKIpEZOGFTWqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aQVnWsKQ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e96c48e7101so2969968276.2
        for <stable@vger.kernel.org>; Sat, 06 Sep 2025 15:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757198379; x=1757803179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WpScVjVFXrYeXUUiZLwbK+kmVpAjYKe9a7aO30lwuow=;
        b=aQVnWsKQNAxmPiISiCsyEyK5UEg4WP+YsjseZe3MVap+qUyCRHlCI/W+31U1M+Fahp
         dviE6dL3mXV6xSf7VfpLYhnR4UY6LpNEymjaSq8mHwe2rSrwNhLFT2zUiON/A6mfJajU
         WJ+p10wM5lZBOT3+wvBnlLKiVOXdP5SC1AMWupWdIuqUbOiOKMNSwWlcGQixN+tJjU4q
         lYZ++sqed91yCm30kYjE/rwDb0Vai2EfJCWjeDmLHoGdU/3PokG7+K4Sm1VvJoK++QjQ
         a399P5VEft2eY2dUQ12jKJLhy4+/lzY+Ad1a6HBdLloRMTdosk6wBchzoxTKJzO5LOMz
         7fLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757198379; x=1757803179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WpScVjVFXrYeXUUiZLwbK+kmVpAjYKe9a7aO30lwuow=;
        b=kE4MGeCxSAhr7+4/trYboRzG8JcaYO87O37QhDdFBIvrisuVqMG7H2hXKT84SzUyLs
         2/Brj548zXuLoaUyxoJZFqx1pz6AqlCggj2FLxxtmmcdxMohgjcwRwtta6tGSWj9jcU+
         9tasr4/P39+8sP32hnpZZ+p6PtGoSdHN5gsDUVCA69NmOkCYavtggSuKkJYK/i6C+Cdf
         Kwg15UtRA3LygIZHRlCmYDRVK6vRwq9Gff4BF725Gc/P3MIKsjce9VZRnz0RYMvj03dx
         fuuL6XREdfN0ZmQuLT/2wx3kmsjAdIq06VZsGNMc5t+0i34vG0/OBId9fSfTGC3xjYHs
         O+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXBGtf4bhdVMu+aQ+EFMzxuSHBA/4a7pLeP2z/18pikBUbT/5/msobJZSHsyJIG1qDqKdPyFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLRMfyBUS2KZomzVPNZm31Ymddy0Q7zlJQP9pRoodhwn8rXL0X
	2cefSVhEtunyVRw1E0rhKZn2ULM6aCmxJ60midhb7/ndICrdDyr8NNZKHKxiTOg5g0O8EV2l1NK
	3xlxc
X-Gm-Gg: ASbGncsdi2C+5Ixxtd8VrdDCxdItEgmMcX7M+MYm5glozJbOf4UbLPppge/qyD7AETA
	0gZNRVskz0deKUZUKOEYfBRHQecZthYtQZfOBUOV3snx97sc14QyCsmpLWu4SKH8yhwGMCty8i5
	Prgl5RE3W8s6DlOW76/CWszs6m2ysB2GlQrr6hBukBiiGx0oBn+F9doBYQAK+xmKtlMhphXX6A7
	yXnZffBQD4w0XZZdk256c1/GuzU849r/3ZU7sZer6mQUrqBtRaSuaYjei41oXnLTE4U81l1DXHS
	9khB8muKsMJoIymp1DN19cq2SnEKftthItej8hyLeS6sFpKlK+YiJ8C/IU2b7m4QZpLZLhnZacV
	x+Ju42WYw8FE3GnybSvDodg6a+VjMQQ==
X-Google-Smtp-Source: AGHT+IEEA0tjhFTqGHv+BYSoaglxufDYFmA0WjS8DVJXWwBBUhxBbkVGz4YzOAcju+oru5As5F/F6g==
X-Received: by 2002:a05:6902:6284:b0:e90:543a:fbf0 with SMTP id 3f1490d57ef6-e9f67991e21mr2360426276.29.1757198378856;
        Sat, 06 Sep 2025 15:39:38 -0700 (PDT)
Received: from [172.17.0.109] ([50.168.186.2])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbdf22ff7sm4248224276.5.2025.09.06.15.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 15:39:38 -0700 (PDT)
Message-ID: <f25bf35c-6b9f-4094-98c6-99a6effcd5a7@kernel.dk>
Date: Sat, 6 Sep 2025 16:39:37 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 11/15] io_uring/msg_ring: ensure io_kiocb freeing
 is deferred for RCU
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 stable@vger.kernel.org, vegard.nossum@oracle.com,
 syzbot+54cbbfb4db9145d26fc2@syzkaller.appspotmail.com
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
 <20250905110406.3021567-12-harshit.m.mogalapalli@oracle.com>
 <f43fe976-4ef5-4dea-a2d0-336456a4deae@kernel.dk>
 <96857683-167a-4ba8-ad26-564e5dcae79b@kernel.dk>
 <2025090622-crispy-germproof-3d11@gregkh>
 <368617ee-8e77-4fec-81cd-45ee3d3532bb@kernel.dk>
 <2025090635-charger-grader-8fdf@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025090635-charger-grader-8fdf@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/25 3:04 PM, Greg KH wrote:
> On Sat, Sep 06, 2025 at 02:47:04PM -0600, Jens Axboe wrote:
>> On 9/6/25 12:36 PM, Greg KH wrote:
>>> On Fri, Sep 05, 2025 at 07:23:00PM -0600, Jens Axboe wrote:
>>>> On 9/5/25 1:58 PM, Jens Axboe wrote:
>>>>> On 9/5/25 5:04 AM, Harshit Mogalapalli wrote:
>>>>>> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
>>>>>> index 5ce332fc6ff5..3b27d9bcf298 100644
>>>>>> --- a/include/linux/io_uring_types.h
>>>>>> +++ b/include/linux/io_uring_types.h
>>>>>> @@ -648,6 +648,8 @@ struct io_kiocb {
>>>>>>  	struct io_task_work		io_task_work;
>>>>>>  	/* for polled requests, i.e. IORING_OP_POLL_ADD and async armed poll */
>>>>>>  	struct hlist_node		hash_node;
>>>>>> +	/* for private io_kiocb freeing */
>>>>>> +	struct rcu_head		rcu_head;
>>>>>>  	/* internal polling, see IORING_FEAT_FAST_POLL */
>>>>>>  	struct async_poll		*apoll;
>>>>>>  	/* opcode allocated if it needs to store data for async defer */
>>>>>
>>>>> This should go into a union with hash_node, rather than bloat the
>>>>> struct. That's how it was done upstream, not sure why this one is
>>>>> different?
>>>>
>>>> Here's a test variant with that sorted. Greg, I never got a FAILED email
>>>> on this one, as far as I can tell. When a patch is marked with CC:
>>>> stable@vger.kernel.org and the origin of the bug clearly marked with
>>>> Fixes, I'm expecting to have a 100% reliable notification if it fails to
>>>> apply. If not, I just kind of assume patches flow into stable.
>>>>
>>>> Was this missed on my side, or was it on the stable side? If the latter,
>>>> how did that happen? I always ensure that stable has what it needs and
>>>> play nice on my side, but if misses like this can happen with the
>>>> tooling, that makes me a bit nervous.
>>>>
>>>
>>> This looks like a failure on my side, sorry.  I don't see any FAILED
>>> email that went out for this anywhere, so I messed up.
>>>
>>> sorry about that, and Harshit, thanks for noticing it.
>>
>> Thanks for confirming, because I was worried it was on my side. But I
>> thought these things were fully automated? I'm going to add something on
>> my side to catch these in the future, just in case.
> 
> Hah, "fully automated", I wish...
> 
> Just because "learning how the sausage is made" is something that some
> people are curious about, here's how I apply stable patches:

Was hoping to learn this :-)

>   - I get a mbox full of patches that are in Linus's tree with a
>     cc:stable in them, when he applies them to his tree.  How that
>     happens is another story...
>   - In mutt, I open the mbox, and pick a patch to look at.  if it seems
>     sane (almost all do), I look for a "Fixes:" tag.  if it's there, I
>     press a key and a script of mine + a local database I've hacked
>     together, tells me just how far back that "Fixes: " commit went.  I
>     try to remember that version number.
>   - I press a different key, and the mail is turned into a patch, and
>     then attempted to be applied to each branch of the currently active
>     stable trees using quilt.  It tells me about fuzz, or failures, or
>     other things, and can let me resolve failures if I want to, one per
>     branch (I have to manually continue on after each attempt because I
>     can cancel it all if it stops applying).
>   - If the patch didn't apply all the way back, I go to a different
>     terminal window and run 'bad_stable GIT_ID' with GIT_ID the id from
>     the original commit which I had selected in the original email.  I'm
>     then offered up which tree to say it failed for by the script, and
>     it sends the email off.
> 
> Notice the "I try to remember how far back" stage.  Normally that works
> just fine.  Sometimes it doesn't.  This time it didn't.  Overall my % is
> pretty good in the past 20+ years of doing this.  Or no one is really
> paying attention and my % is way worse, hard to tell...

OK I can see how mistakes would creep in. I do pay pretty good
attention, and I think perhaps (I'd need to dig through emails) I've
caught missing patches 1-2 before. Which isn't too bad. But the manual
parts of the above does mean that I need to check if things fell through
the crack. I naively just assumed that if it has cc stable and either a
version marker or a fixes tag, that it'd be a guarantee that it a) it
gets applied, or b) I get a FAILED email. Nothing in between.

> And yes, I've tried to make the "send the failed email" happen directly
> from the failure to apply, but that gets into some combinations of "did
> it really want to go that far back" (some patches do not have Fixes:
> tags) and sometimes Fixes is actually wrong (hit that just a few minutes
> ago with a drm patch), and there's some messy terminal/focus issues with
> running interactive scripts from within a mutt process that sometimes
> requires me to spawn separate windows to work around, but then I lost
> the original email involved as that was piped from mutt, and well, it's
> a mess.  So I stick to this process.
> 
> I can process stable patches pretty fast now, I'm only rate limited by
> my test builds, not the "apply from email" dance.  And the failure rate
> is generally pretty low, with the exception of the -rc1 DRM subsystem
> merge nightmare, but that's another issue...
> 
> Anyway, sorry for the wall of text that you weren't looking for :)

Actually really appreciated, this helps manage my expectations and what
I can do better on my side. Do I think your setup needs improving?
Definitely! But like you said, the failure rate is pretty darn low. I
mostly thinks it needs improving so it isn't too much manual work on
your side, and that means better automation for this. And that would
then also solve (or at least reduce) the gaps of where it can go wrong
and reliably give me either success or failure, not missed backport.
Which is then less work for me, too :-)

-- 
Jens Axboe

