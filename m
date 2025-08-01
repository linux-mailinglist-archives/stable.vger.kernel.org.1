Return-Path: <stable+bounces-165784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE7CB1891B
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 00:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D3B189F3CC
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 22:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2491A2264A1;
	Fri,  1 Aug 2025 22:06:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624CA222587;
	Fri,  1 Aug 2025 22:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754086008; cv=none; b=OBy1fbN3F4LVOqfIEeXU3OgEFlCRdXfXjFXCeptQwc7TNmY62oeVV+7lf9U+XfllMPq8djZ9dUD1R75VX9e0FOgfRV+l+7M/U7H4L6fbJ825bKAQJhDqQ3e5vXdiMCKDnPdUuikZLiFc5Ge8OB01d+UInRqXV7wEQcnpIxHfogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754086008; c=relaxed/simple;
	bh=ZltjpFSnN2A6MCKEllpU7lv7jCbFdpKQWqCcPTkW4R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1JCimyAsJh3ikXz34R9HhnnWvPiSSWsrwWlK2gqX+8maApDWwoJDL4/HYaVLD/5POGq+M6xCqs8WvqDENfzvkLT5baaulCQDXC5U063pnc+k0+WoY4aMh/y2tTjYgEZsHK/Q83+eXoqBl81aMIxO3Fc7c6nubF1LfeK0N7x8Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31ed2c4cfcbso132087a91.3;
        Fri, 01 Aug 2025 15:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754086006; x=1754690806;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGMI5UFLAL8h+XrJLA1qy7vAWgjKkChdeP7O9TQ3ZSg=;
        b=mi9zyW63yOFrQqsdqK5at/HwDTaUoW9GDhM2jLIHkQtus2hrSvCOoXkS3rtux85xJ4
         KHyW++5zpdMR4BroIyir3KcFFQWk6W51xh4ueaR0i1qa9S5gsCyc1QFS9Dgy2Nmbl+Pt
         IpoKQURmcFY7haIiU/nKYk69PELzNYcIDT/bhQI8N8m+zFCUdrnp0e+HKa+sGbHLNnr4
         9ZRDClz4BlBjv/ydN+FxBtI6cBU/luDqtvhdG48dxeSzE/bH0WfrelJazIWEVjIEUsqS
         GIG0mhnhFIy40HqByMMOb/0bSkO1mbRFZ7kSfDNuYQKr9uPE8VkjyM0deLE1aDYavkSY
         zwKw==
X-Forwarded-Encrypted: i=1; AJvYcCV4Gl38AiT1xD+6CrUiqgnxllf/Q1mwT/h9TSyHgmylAcTHrZ54mOHWR6prwDur2yYqLTTNJsW4CDPV@vger.kernel.org, AJvYcCXUXwRf/2z9mquY3FqeZBNHl0RmKu06j78J/vOZhLnZTdmewNx1vnmHCquShDZTZzhvR/8ioUXp@vger.kernel.org, AJvYcCXsDaXUrKNW/KyLaJutMULrgQGtVyfEzvmoLhWkv4SxALPsfGzAxqK6xJv5AJIfzCdnZlENRFFiu042TlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvoGJtq+3KHW/RqQ/DpoWtAKS5sR/mGnZzTbeBxt0E2/o3Mpmh
	Ie614Z+WvbaPT6kX0Z3lPim2PL/jOwWxO0ybdQE22QLo8vkDATcR2adN
X-Gm-Gg: ASbGncvz29VINN1nwTToTWOSyvgWm+4yo3adeoBMNoQvH1/MrXwFXcIyPkB5VWUGwXm
	2BfZax8nutLiufPJtR+YqXOmfW6xiMXgGtSkBkMQJlvuUqD96IwAIKi1OIIoLYVVtWzJLSJXXbR
	keXQ8HjAjcfRzmVvKF3+vDuoFz1Hc22a4fH5+rkAKOf2I7yQC/VetDSKeijUm1XC2Rzp3sP4ipB
	0c+OiJRynOnvtuZY8XnZNEH72lYgt874cJo07TEQsq0w3++kC4cTlsWmI1HY+1CTSisCcgImL6q
	9qjU0aVpQVL6DEHEdjGRmzVLX4sAox+nWD5xMmoicltD/ZtbW1Zp4I7f87dRJrVNEZ8HHQeWS3p
	1HQDjaDUIutttPJ5G1kMpIa2kI1Xq5JNs
X-Google-Smtp-Source: AGHT+IEAXTkTyBkkZYD4R916cckUDfUr/XXYQMRwRWE4wJM7FlBkmpZyjC7daXSA6NIjb9GvKXDLFQ==
X-Received: by 2002:a17:90b:38cf:b0:31f:23f0:2df8 with SMTP id 98e67ed59e1d1-321162c7222mr590990a91.6.1754086005463;
        Fri, 01 Aug 2025 15:06:45 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32115948a74sm827193a91.4.2025.08.01.15.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 15:06:45 -0700 (PDT)
Message-ID: <4834c0cf-b0e8-49c8-a13b-27c80921a03d@kzalloc.com>
Date: Sat, 2 Aug 2025 07:06:39 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kcov, usb: Fix invalid context sleep in softirq path on
 PREEMPT_RT
To: Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Byungchul Park <byungchul@sk.com>,
 max.byungchul.park@gmail.com, Yeoreum Yun <yeoreum.yun@arm.com>,
 Michelle Jin <shjy180909@gmail.com>, linux-kernel@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, stable@vger.kernel.org,
 kasan-dev@googlegroups.com, syzkaller@googlegroups.com,
 linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20250725201400.1078395-2-ysk@kzalloc.com>
 <2025072615-espresso-grandson-d510@gregkh>
 <77c582ad-471e-49b1-98f8-0addf2ca2bbb@I-love.SAKURA.ne.jp>
 <2025072614-molehill-sequel-3aff@gregkh> <87ldobp3gu.ffs@tglx>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <87ldobp3gu.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Huge thanks to everyone for the feedback!

While working on earlier patches, running syzkaller on PREEMPT_RT uncovered
numerous sleep-in-atomic-context bugs and other synchronization issues unique to
that environment. This highlighted the need to address these problems.

On 7/26/25 8:59 오후, Thomas Gleixner wrote:
> On Sat, Jul 26 2025 at 09:59, Greg Kroah-Hartman wrote:
>> On Sat, Jul 26, 2025 at 04:44:42PM +0900, Tetsuo Handa wrote:
>>> static void __usb_hcd_giveback_urb(struct urb *urb)
>>> {
>>>   (...snipped...)
>>>   kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum) {
>>>     if (in_serving_softirq()) {
>>>       local_irq_save(flags); // calling local_irq_save() is wrong if CONFIG_PREEMPT_RT=y
>>>       kcov_remote_start_usb(id) {
>>>         kcov_remote_start(id) {
>>>           kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_USB, id)) {
>>>             (...snipped...)
>>>             local_lock_irqsave(&kcov_percpu_data.lock, flags) {
>>>               __local_lock_irqsave(lock, flags) {
>>>                 #ifndef CONFIG_PREEMPT_RT
>>>                   https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/local_lock_internal.h#L125
>>>                 #else
>>>                   https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/local_lock_internal.h#L235 // not calling local_irq_save(flags)
>>>                 #endif
> 
> Right, it does not invoke local_irq_save(flags), but it takes the
> underlying lock, which means it prevents reentrance.
> 
>> Ok, but then how does the big comment section for
>> kcov_remote_start_usb_softirq() work, where it explicitly states:
>>
>>  * 2. Disables interrupts for the duration of the coverage collection section.
>>  *    This allows avoiding nested remote coverage collection sections in the
>>  *    softirq context (a softirq might occur during the execution of a work in
>>  *    the BH workqueue, which runs with in_serving_softirq() > 0).
>>  *    For example, usb_giveback_urb_bh() runs in the BH workqueue with
>>  *    interrupts enabled, so __usb_hcd_giveback_urb() might be interrupted in
>>  *    the middle of its remote coverage collection section, and the interrupt
>>  *    handler might invoke __usb_hcd_giveback_urb() again.
>>
>>
>> You are removing half of this function entirely, which feels very wrong
>> to me as any sort of solution, as you have just said that all of that
>> documentation entry is now not needed.
> 
> I'm not so sure because kcov_percpu_data.lock is only held within
> kcov_remote_start() and kcov_remote_stop(), but the above comment
> suggests that the whole section needs to be serialized.
> 
> Though I'm not a KCOV wizard and might be completely wrong here.
> 
> If the whole section is required to be serialized, then this need
> another local lock in kcov_percpu_data to work correctly on RT.
> 
> Thanks,
> 
>         tglx

After receiving comments from maintainers, I realized that my initial patch set
wasn't heading in the right direction.


It seems that the following two patches conflict on PREEMPT_RT kernels:

1. kcov: replace local_irq_save() with a local_lock_t
   Link: https://github.com/torvalds/linux/commit/d5d2c51f1e5f
2. kcov, usb: disable interrupts in kcov_remote_start_usb_softirq
   Link: https://github.com/torvalds/linux/commit/f85d39dd7ed8


My current approach involves:

* Removing the existing 'kcov_percpu_data.lock'
* Converting 'kcov->lock' and 'kcov_remote_lock' to raw spinlocks
* Relocating the kmalloc call for kcov_remote_add() outside kcov_ioctl_locked(),
  as GFP_ATOMIC allocations can potentially sleep under PREEMPT_RT.
  : As expected from further testing, keeping the GFP_ATOMIC allocation inside
  kcov_remote_add() still leads to sleep in atomic context.

This approach allows us to keep Andrey’s patch d5d2c51f1e5f while making
modifications as Sebastian suggested in his commit f85d39dd7ed8 message,
which I found particularly insightful and full of helpful hints.

The work I'm doing on PATCH v2 involves a number of changes, and I would truly
appreciate any critical feedback. I'm always happy to hear insights!


Best regards,
Yunseong Kim

