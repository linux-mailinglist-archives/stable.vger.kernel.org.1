Return-Path: <stable+bounces-169911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3D1B29703
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 04:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D601F5E0436
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 02:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34164253B58;
	Mon, 18 Aug 2025 02:24:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396902472B1
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 02:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483892; cv=none; b=pSEHFyDZvVqpiIiSZRvSSDp41KvAzqELpgA81EUo8C0+4WiBnNnGpru3o8vUxBOZyks74hfn3yxTj3hOWXXCBZUVRcOkbM8L0X+4QIuCN/btElmC0/QqFH79BquPT9Mt0vBt89R8OR4x+urFbUMJdyei1ONk2vLBMzDc+IKBfe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483892; c=relaxed/simple;
	bh=h1/oODU4WsYOo1tCfWWOLJdyleSNN7nXAkQtmf2z2xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E5k3MxCl0Xrms9rHY5jPwBA1Xy2ELcapP8k/fecRibwq6DAH4D7bl4ZnF/FVyKFHA68b03UsubEA5kE7K448jd0gFbaY4jjjPyolpTuG9Ct1vUfrJWDBgCKdMtWtrQ0yF9BR5y7PnWpgjAvArQH4zDolNrR2LoKDeSAZN5FUCLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c4xJL1VT8zdcLg;
	Mon, 18 Aug 2025 10:20:18 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D6EE1402C8;
	Mon, 18 Aug 2025 10:24:40 +0800 (CST)
Received: from [10.67.111.31] (10.67.111.31) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Aug
 2025 10:24:39 +0800
Message-ID: <2285c764-e6b3-4cb4-ae12-0bfaa1e67358@huawei.com>
Date: Mon, 18 Aug 2025 10:24:38 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: Fix possible deadlock in console_trylock_spinning
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <stable@vger.kernel.org>,
	<linux-mm@kvack.org>, Waiman Long <llong@redhat.com>, Breno Leitao
	<leitao@debian.org>, John Ogness <john.ogness@linutronix.de>, Lu Jialin
	<lujialin4@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250813085310.2260586-1-gubowen5@huawei.com>
 <20250813155616.d7e5a832ce7cda7764942d10@linux-foundation.org>
 <f3e631dc-245a-4efe-98e5-cbe94464daec@huawei.com> <aJ3f05Dqzx0OouJa@arm.com>
Content-Language: en-US
From: Gu Bowen <gubowen5@huawei.com>
In-Reply-To: <aJ3f05Dqzx0OouJa@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemh100007.china.huawei.com (7.202.181.92)



On 8/14/2025 9:08 PM, Catalin Marinas wrote:
> On Thu, Aug 14, 2025 at 10:33:56AM +0800, Gu Bowen wrote:
>> On 8/14/2025 6:56 AM, Andrew Morton wrote:
>>> I'm not sure which kernel version this was against, but kmemleak.c has
>>> changed quite a lot.
>>>
>>> Could we please see a patch against a latest kernel version?  Linus
>>> mainline will suit.
>>>
>>> Thanks.
>>
>> I discovered this issue in kernel version 5.10. Afterwards, I reviewed the
>> code of the mainline version and found that this deadlock path no longer
>> exists due to the refactoring of console_lock in v6.2-rc1. For details on
>> the refactoring, you can refer to this link :
>> https://lore.kernel.org/all/20221116162152.193147-1-john.ogness@linutronix.de/.
>> Therefore, theoretically, this issue existed before the refactoring of
>> console_lock.
> 
> Oh, so you can no longer hit this issue with mainline. This wasn't
> mentioned (or I missed it) in the commit log.
> 
> So this would be a stable-only fix that does not have a correspondent
> upstream. Adding Greg for his opinion.
> 

I have discovered that I made a mistake, this fix patch should be merged 
into the mainline. Since we have identified two types of deadlocks, the 
AA deadlock [1] and the ABBA deadlock[2], the latter's deadlock path no 
longer exists in the mainline due to the 40 patches that refactored 
console_lock. However, the AA deadlock issue persists, so I believe this 
fix should be applied to the mainline.

[1] 
https://lore.kernel.org/all/20250731-kmemleak_lock-v1-1-728fd470198f@debian.org/#t
[2] https://lore.kernel.org/all/20250730094914.566582-1-gubowen5@huawei.com/

Best Regards,
Guber


