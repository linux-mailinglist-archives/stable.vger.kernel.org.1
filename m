Return-Path: <stable+bounces-75743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716649742DF
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 20:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336052889BD
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7913C1A76A4;
	Tue, 10 Sep 2024 18:59:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0D1A7043;
	Tue, 10 Sep 2024 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994760; cv=none; b=dlsulBIoCCjrxNNPYzKTij8sLsROnwT5FYXphzyYq0uvuU5oFOVXOXiaknV26XlGp6vFuxcXi5BpkWpk6LtahQllZwpRmBcQcRLAqIeXXyP14+zE9wlqwLs5M6gny/+pTmMQGsmmDH4wh6VRpP9T9Yg3X8eVwx9pG0/c1u6tZhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994760; c=relaxed/simple;
	bh=lZdWc1QdGCBc0gphOiz83m01CLzb0fC3FjmmjOJIe9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVdpW4S88a8XyKQ/YXDyVZdr9248oomT8eLl1VVihBPGWROnM9/WwPkSprCroUMEXilWu+dnqQvRttSjWCzjfYww9t/2V5Ga+DLYs+3OG5MTVTDrzwRJp5zSPlxui11gMY4P8YVGT8jYhaxLh0sIGhex60nNlYFhuaZABeCO87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDCA3FF803;
	Tue, 10 Sep 2024 18:59:09 +0000 (UTC)
Message-ID: <77d0f59f-554b-4cd9-ae1c-4c89a76058ef@ghiti.fr>
Date: Tue, 10 Sep 2024 20:59:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6] membarrier: riscv: Add full memory barrier in
 switch_mm()
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: WangYuli <wangyuli@uniontech.com>, stable@vger.kernel.org,
 sashal@kernel.org, parri.andrea@gmail.com, mathieu.desnoyers@efficios.com,
 palmer@rivosinc.com, linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, nathan@kernel.org,
 ndesaulniers@google.com, trix@redhat.com, linux-riscv@lists.infradead.org,
 llvm@lists.linux.dev, paulmck@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 brauner@kernel.org, arnd@arndb.de
References: <10F34E3A3BFBC534+20240909025701.1101397-1-wangyuli@uniontech.com>
 <2024091002-caution-tinderbox-a847@gregkh>
 <364e0e33-68ad-4f0c-86f1-f6a95def9a30@ghiti.fr>
 <2024091037-errant-countdown-4928@gregkh>
 <5d486ff8-2ab5-4ed5-a1da-c2817927b3a2@ghiti.fr>
 <2024091056-bogus-whoops-4bde@gregkh>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <2024091056-bogus-whoops-4bde@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 10/09/2024 15:25, Greg KH wrote:
> On Tue, Sep 10, 2024 at 02:35:06PM +0200, Alexandre Ghiti wrote:
>> On 10/09/2024 13:58, Greg KH wrote:
>>> On Tue, Sep 10, 2024 at 01:31:04PM +0200, Alexandre Ghiti wrote:
>>>> Hi Greg,
>>>>
>>>> On 10/09/2024 09:32, Greg KH wrote:
>>>>> On Mon, Sep 09, 2024 at 10:57:01AM +0800, WangYuli wrote:
>>>>>> From: Andrea Parri <parri.andrea@gmail.com>
>>>>>>
>>>>>> [ Upstream commit d6cfd1770f20392d7009ae1fdb04733794514fa9 ]
>>>>>>
>>>>>> The membarrier system call requires a full memory barrier after storing
>>>>>> to rq->curr, before going back to user-space.  The barrier is only
>>>>>> needed when switching between processes: the barrier is implied by
>>>>>> mmdrop() when switching from kernel to userspace, and it's not needed
>>>>>> when switching from userspace to kernel.
>>>>>>
>>>>>> Rely on the feature/mechanism ARCH_HAS_MEMBARRIER_CALLBACKS and on the
>>>>>> primitive membarrier_arch_switch_mm(), already adopted by the PowerPC
>>>>>> architecture, to insert the required barrier.
>>>>>>
>>>>>> Fixes: fab957c11efe2f ("RISC-V: Atomic and Locking Code")
>>>>>> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>>>>>> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>>> Link: https://lore.kernel.org/r/20240131144936.29190-2-parri.andrea@gmail.com
>>>>>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>>>>>> Signed-off-by: WangYuli <wangyuli@uniontech.com>
>>>>>> ---
>>>>>>     MAINTAINERS                         |  2 +-
>>>>>>     arch/riscv/Kconfig                  |  1 +
>>>>>>     arch/riscv/include/asm/membarrier.h | 31 +++++++++++++++++++++++++++++
>>>>>>     arch/riscv/mm/context.c             |  2 ++
>>>>>>     kernel/sched/core.c                 |  5 +++--
>>>>>>     5 files changed, 38 insertions(+), 3 deletions(-)
>>>>>>     create mode 100644 arch/riscv/include/asm/membarrier.h
>>>>> Now queued up, thanks.
>>>> The original patch was merged in 6.9 and the Fixes tag points to a commit
>>>> introduced in v4.15. So IIUC, this patch should have been backported
>>>> "automatically" to the releases < 6.9 right? As stated in the documentation
>>>> (process/stable-kernel-rules.html):
>>>>
>>>> "Note, such tagging is unnecessary if the stable team can derive the
>>>> appropriate versions from Fixes: tags."
>>>>
>>>> Or did we miss something?
>>> Yes, you didn't tag cc: stable at all in this commit, which is why we
>>> did not see it.  The documentation says that :)
>>
>> Ok, some patches seem to make it to stable without the cc: stable tag (like
>> the one below for example), so I thought it was not necessary.
> Yes, they do, because many maintainers and developers don't follow the
> normal rules, so we sweep the tree when we have a chance and do a "best
> effort" backport at times.
>
> But again, it is NOT guaranteed that this will happen, and even if it
> does, you will NOT get emails saying the attempt-at-backporting fails,
> if it fails, as obviously the developers involved weren't explicitly
> asking for it to be backported.
>
> So in short, just properly tag things for stable, and all will be fine.


Great, thank you, I'll make sure we tag the fixes to backport properly!

Thanks again,

Alex


>
> thanks,
>
> greg k-h

