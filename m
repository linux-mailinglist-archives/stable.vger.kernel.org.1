Return-Path: <stable+bounces-47616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645A08D2F02
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 09:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927161C22CC2
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9A3167DAA;
	Wed, 29 May 2024 07:59:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A1C1C286;
	Wed, 29 May 2024 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969578; cv=none; b=BLKQ+a25nB2G9rR1sqqKyhU8w+oGeLvjQQq+zTNj96vEs0wF+UkYHmMFxsyufFU6a7TyybnvbckMhszoO8UbdE+EmfbmwuzaFmLpoHFbcKLcCzbO/ZXMj1J84aTw9+7bXRc8jQFofn5tgLhxWnEmUEsXLroSQ6oqkSA6SdvbLQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969578; c=relaxed/simple;
	bh=52nx6xhUrNv87tj2Sy/A2uqQVo0t70Lsvg3WQr26J3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WWF5GrstqAxqRGOEWF3dLIXH/lL3o1wOGq8vRIsnor3tDI/bX1O+WZ6CZhef/CSuzC23jWm7r1fzpIsCRJ3KLACKA/i64eZdKPRvHmdZoQGqX7dOWJEoBY9Q9heEwuYQIjftMCjti4PpkUZ6OEIRnag94diaixOsezz4R3nAD70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Vq1sz4Xtzz1ysjV;
	Wed, 29 May 2024 15:56:23 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id CCF0C1400F4;
	Wed, 29 May 2024 15:59:32 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 29 May 2024 15:59:32 +0800
Message-ID: <7430832a-d5ca-da76-6e41-e17ba5b5f190@huawei.com>
Date: Wed, 29 May 2024 15:59:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH stable,5.15 0/2] Revert the patchset for fix
 CVE-2024-26865
To: Greg KH <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>, <kuba@kernel.org>,
	<edumazet@google.com>, <kuniyu@amazon.com>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>
References: <20240506030554.3168143-1-shaozhengchao@huawei.com>
 <2024052355-doze-implicate-236d@gregkh>
 <92bc4c96-9aaa-056c-e59a-4396d19a9f58@huawei.com>
 <2024052511-aflutter-outsider-4917@gregkh>
 <9940d719-ee96-341d-93e6-ffd04b6fddba@huawei.com>
 <2024052526-reference-boney-1c67@gregkh>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <2024052526-reference-boney-1c67@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2024/5/25 18:42, Greg KH wrote:
> On Sat, May 25, 2024 at 06:21:08PM +0800, shaozhengchao wrote:
>>
>>
>> On 2024/5/25 17:42, Greg KH wrote:
>>> On Sat, May 25, 2024 at 05:33:00PM +0800, shaozhengchao wrote:
>>>>
>>>>
>>>> On 2024/5/23 19:34, Greg KH wrote:
>>>>> On Mon, May 06, 2024 at 11:05:52AM +0800, Zhengchao Shao wrote:
>>>>>> There's no "pernet" variable in the struct hashinfo. The "pernet" variable
>>>>>> is introduced from v6.1-rc1. Revert pre-patch and post-patch.
>>>>>
>>>>> I do not understand, why are these reverts needed?
>>>>>
>>>>> How does the code currently build if there is no variable here?
>>>>>
>>>>> confused,
>>>>>
>>>>> greg k-h
>>>> Hi greg:
>>>>     If only the first patch is merged, compilation will fail.
>>>> There's no "pernet" variable in the struct hashinfo.
>>>
>>> But both patches are merged together here.  Does the released kernel
>>> versions fail to build somehow?
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>> Work well, as I know.
> 
> Ok, then why send these reverts?  Are they needed, or are they not
> needed?  And if needed, why?
> 
> still confused,
> 
> greg k-h
> 
Hi greg:
   If the patchset is merged together, and the compilation is normal. I'm
just concerned that some people only put in one of the patchset and 
forget to put in both of them, which will be a problem.

Thank you.

Zhengchao Shao

