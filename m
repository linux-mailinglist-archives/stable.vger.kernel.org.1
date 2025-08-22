Return-Path: <stable+bounces-172345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15833B312FE
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 11:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACDF1C25454
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C942E22B2;
	Fri, 22 Aug 2025 09:25:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF80217F31;
	Fri, 22 Aug 2025 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854751; cv=none; b=I1rpmzwEeyy2yMVbAeWIo72sdlSKCH92IK4QFCQkIqDTvYCfacH5gC4AGRbrzrrbjXzaXpRkHrVfx7JXa3ymFsznGY6ZUPdsGI2/nqxmpoT8LqH3HJXc+LWIWLJhiQIz/rePGtOXDsAuc/PgVz3Czf8T4egxTeceHk5mkKfhf9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854751; c=relaxed/simple;
	bh=Sskxxpf7pAkfsCjmaSxzRMPr+cHajhONtFolJ2RddB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m8DaEUD3P5GSXu9Xh0mG8OGPC+xH2/eFl2NSaGDBu9kx67d0ZPSZZ5Rdg/QIknmSYNec8yTYBQ8/QRgDTNAYrPmxEpK/xceQ5Un0k4W1EsBhC+0FD9tYcEopG2iTjtvpRDxMWmnv7o28hb+m/cnFrfQ5AJNiZEUBKaVWiBmYlE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c7ZV54gqsz2VRPB;
	Fri, 22 Aug 2025 17:22:53 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C3DA140297;
	Fri, 22 Aug 2025 17:25:45 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Aug 2025 17:25:44 +0800
Message-ID: <9fa1c126-00f1-95db-93a0-cee52a70062e@huawei.com>
Date: Fri, 22 Aug 2025 17:25:56 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v6.6 RESEND 2/2] x86/irq: Plug vector setup race
To: Greg KH <gregkh@linuxfoundation.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <prarit@redhat.com>,
	<x86@kernel.org>, <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250822033825.1096753-1-ruanjinjie@huawei.com>
 <20250822033825.1096753-3-ruanjinjie@huawei.com>
 <2025082243-urging-outdoors-aa35@gregkh>
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <2025082243-urging-outdoors-aa35@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/8/22 16:57, Greg KH wrote:
> On Fri, Aug 22, 2025 at 03:38:25AM +0000, Jinjie Ruan wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>>
>> commit ce0b5eedcb753697d43f61dd2e27d68eb5d3150f upstream.
>>

[...]

>>  
>>  /*
>> @@ -273,7 +308,9 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
>>  	/* entry code tells RCU that we're not quiescent.  Check it. */
>>  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
>>  
>> -	call_irq_handler(vector, regs);
>> +	if (unlikely(!call_irq_handler(vector, regs)))
>> +		apic_eoi();
>> +
> 
> This chunk does not look correct.  The original commit did not have
> this, so why add it here?  Where did it come from?
> 
> The original patch said:
> 	-       if (unlikely(call_irq_handler(vector, regs)))
> 	+       if (unlikely(!call_irq_handler(vector, regs)))
> 
> And was not an if statement.
> 
> So did you forget to backport something else here?  Why is this not
> identical to what the original was?

The if statement is introduced in commit 1b03d82ba15e ("x86/irq: Install
posted MSI notification handler") which is a patch in patch set
https://lore.kernel.org/all/20240423174114.526704-1-jacob.jun.pan@linux.intel.com/,
but it seems to be a performance optimization patch set, and this patch
includes additional modifications. The context conflict is merely a
simple refactoring, but the cost of the entire round of this patch set
is too high.

> 
> thanks,
> 
> greg k-h

