Return-Path: <stable+bounces-134529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AA6A93226
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 08:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67ED33B3BF4
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 06:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366D0268C76;
	Fri, 18 Apr 2025 06:36:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0687268FF2
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744958170; cv=none; b=Zv5YidZMUy0ZUkFpd2KE//kNsfeARxsWogxNHjnCLN6SewG7aEDGnBMUtk/CJ/AEpj2SGVKnnkRJnXE3d6VLuuO0FEHFHPeK34qflkiOoAuEt1B7528FYnRfqXiTb3FsfYoJjXM7ErJREIuLDf9dYQBQJOGho3FnAQqoS5sdMq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744958170; c=relaxed/simple;
	bh=weC7cuEa1zTGOfnjA1TrVtJBt5n4hraa8K3MSCnuc3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MVimEI8wSYL1ShGS3YD2v9mZCnvaJ0NakPEKjnBvOH4R0dOzFKSAlDnUUBxiGxyFGvG0KljKwuKcVRVUarrlXY4ti56vYqTSm+Q8qdV4FyxSuZ2xu5cMQddRMQwrrcfejZCNQM7PGqXec1g0Cc97QLjewyaHcRF4lXwDiOdBOL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Zf4gg4TSczHrFR;
	Fri, 18 Apr 2025 14:32:31 +0800 (CST)
Received: from kwepemd200024.china.huawei.com (unknown [7.221.188.85])
	by mail.maildlp.com (Postfix) with ESMTPS id EDE961402E0;
	Fri, 18 Apr 2025 14:35:58 +0800 (CST)
Received: from [10.67.120.171] (10.67.120.171) by
 kwepemd200024.china.huawei.com (7.221.188.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 18 Apr 2025 14:35:58 +0800
Message-ID: <bbb04362-c67e-438e-b15c-85da61563b0f@huawei.com>
Date: Fri, 18 Apr 2025 14:35:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about back-porting '8be091338971 crypto:
 hisilicon/debugfs - Fix debugfs uninit process issue'
To: Cliff Liu <donghua.liu@windriver.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<stable@vger.kernel.org>, <qianweili@huawei.com>, "fanghao (A)"
	<fanghao11@huawei.com>
References: <767571bc-1a59-4f7c-a9c7-fb23b79303a9@windriver.com>
 <4725f8e8-7f46-48f6-9869-8bf16eca6f1a@windriver.com>
From: huangchenghai <huangchenghai2@huawei.com>
In-Reply-To: <4725f8e8-7f46-48f6-9869-8bf16eca6f1a@windriver.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200024.china.huawei.com (7.221.188.85)

Hello,


Sorry to reply late, I checked, 5.10 and 5.15 do not have the diff regs 
function.

So there's no need to fix this in 5.10 and 5.15.

Thank you for your attention.


Thanks,

ChengHai


在 2025/4/17 14:51, Cliff Liu 写道:
> Hi,
>
> I think this patch is not applicable for 5.15 and 5.10.
> Could you give me any opinions?
>
> Any helps from maintainers are very appreciated.
>
> Thanks,
>
>   Cliff
>
> On 2025/4/8 15:45, Cliff Liu wrote:
>> Hi Chenghai,
>>
>> I am trying to back-port commit  8be091338971 ("crypto: 
>> hisilicon/debugfs - Fix debugfs uninit process issue") to 5.15.y and 
>> 5.10.y.  After reviewed the patch and code context, I found there is 
>> no "drivers/crypto/hisilicon/debugfs.c" on both 5.15 and 5.10. So I 
>> think the fix is not suitable for 5.15 and 5.10.
>>
>> What do you think? Your opinion is very important to me.
>>
>> Thanks,
>>
>>  Cliff
>>

