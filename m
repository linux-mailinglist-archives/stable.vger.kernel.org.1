Return-Path: <stable+bounces-75628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE64973641
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F2B1F2638E
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A0918C02E;
	Tue, 10 Sep 2024 11:31:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909511DFE8;
	Tue, 10 Sep 2024 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725967876; cv=none; b=Yc0GB3XMifHgxEGZ47UHRBtG84MGlQpALhK7dMp+fUk6GOAKhTSdLM3D8jR41ranB+QQn8enLuIeyMmiJpovTSoZCBzs1reqmZSkIyu8GxBeVViprBW5QO4lbBL5liQtsm8538oyt3g8l8FOw2aNJM6n+YpV/MNMz76y7U6KRdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725967876; c=relaxed/simple;
	bh=umTf7L04+EULSCtHP+OsTzwZGys+FKvlYJE6T9XSSWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JA9uaJjX3Ltr3AyhPVUIpe4j346/Xm8qkoQwQQhkEvCtmLPq6PBCYA4k8ZbkT7M/UAslKcAOl0LSfvGwJFauH2qvUpFNeD2SFCV2UicyaU99wJUXBY4br+bU6wHljB0VW9bFbr291rbOac2RLUPO8ZuqwmsLUtOUqj8iWG6KMqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1FC604000B;
	Tue, 10 Sep 2024 11:31:04 +0000 (UTC)
Message-ID: <364e0e33-68ad-4f0c-86f1-f6a95def9a30@ghiti.fr>
Date: Tue, 10 Sep 2024 13:31:04 +0200
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
To: Greg KH <gregkh@linuxfoundation.org>, WangYuli <wangyuli@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, parri.andrea@gmail.com,
 mathieu.desnoyers@efficios.com, palmer@rivosinc.com,
 linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, nathan@kernel.org, ndesaulniers@google.com,
 trix@redhat.com, linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
 paulmck@kernel.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, brauner@kernel.org, arnd@arndb.de
References: <10F34E3A3BFBC534+20240909025701.1101397-1-wangyuli@uniontech.com>
 <2024091002-caution-tinderbox-a847@gregkh>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <2024091002-caution-tinderbox-a847@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Greg,

On 10/09/2024 09:32, Greg KH wrote:
> On Mon, Sep 09, 2024 at 10:57:01AM +0800, WangYuli wrote:
>> From: Andrea Parri <parri.andrea@gmail.com>
>>
>> [ Upstream commit d6cfd1770f20392d7009ae1fdb04733794514fa9 ]
>>
>> The membarrier system call requires a full memory barrier after storing
>> to rq->curr, before going back to user-space.  The barrier is only
>> needed when switching between processes: the barrier is implied by
>> mmdrop() when switching from kernel to userspace, and it's not needed
>> when switching from userspace to kernel.
>>
>> Rely on the feature/mechanism ARCH_HAS_MEMBARRIER_CALLBACKS and on the
>> primitive membarrier_arch_switch_mm(), already adopted by the PowerPC
>> architecture, to insert the required barrier.
>>
>> Fixes: fab957c11efe2f ("RISC-V: Atomic and Locking Code")
>> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
>> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Link: https://lore.kernel.org/r/20240131144936.29190-2-parri.andrea@gmail.com
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Signed-off-by: WangYuli <wangyuli@uniontech.com>
>> ---
>>   MAINTAINERS                         |  2 +-
>>   arch/riscv/Kconfig                  |  1 +
>>   arch/riscv/include/asm/membarrier.h | 31 +++++++++++++++++++++++++++++
>>   arch/riscv/mm/context.c             |  2 ++
>>   kernel/sched/core.c                 |  5 +++--
>>   5 files changed, 38 insertions(+), 3 deletions(-)
>>   create mode 100644 arch/riscv/include/asm/membarrier.h
> Now queued up, thanks.


The original patch was merged in 6.9 and the Fixes tag points to a 
commit introduced in v4.15. So IIUC, this patch should have been 
backported "automatically" to the releases < 6.9 right? As stated in the 
documentation (process/stable-kernel-rules.html):

"Note, such tagging is unnecessary if the stable team can derive the 
appropriate versions from Fixes: tags."

Or did we miss something?

Thanks,

Alex


>
> greg k-h
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

