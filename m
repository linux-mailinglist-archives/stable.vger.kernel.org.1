Return-Path: <stable+bounces-133203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27573A92018
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 16:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544743BBE2C
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D751C2517A4;
	Thu, 17 Apr 2025 14:47:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC5251786
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901230; cv=none; b=YPugVgTYXtfITjEYrDu3NwF6liVjeJGnkrrCkAKu1Xv5iqXVnZcGpT1zcJn+gbHERyzMyZAOgK+NSvK7SS4uMXm3vTkDABr0kKEcSZcuRiKbdrUmhz70JraC5fWf8vtQtAPZjaqnezy+LtWOhWEoCITJJ/Jup71w6koPrOV3O64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901230; c=relaxed/simple;
	bh=4JCtk5cnw1LGOxz4JpBhwU49li4nzsGlhAMFrf1ax/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rmDmcP19O5rxfD2FPQSHr3ShH36525w8sCcaD5K2QfcpZWxKkjsOnfEJUE9sCUUnWA7r/kxnotofM3bcdo1ZdOS1Jim6HkQ/RJ3aTP+G8w6I9ZJVnbrXO0wr6H5Q8B0AZ7T2okJuMeTHO8596TmKnBpUJ2EjfrAcXzVCPYG4ESI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZdggB4X4nznfbn;
	Thu, 17 Apr 2025 22:45:42 +0800 (CST)
Received: from kwepemd200024.china.huawei.com (unknown [7.221.188.85])
	by mail.maildlp.com (Postfix) with ESMTPS id C3F57180468;
	Thu, 17 Apr 2025 22:47:04 +0800 (CST)
Received: from [10.67.120.171] (10.67.120.171) by
 kwepemd200024.china.huawei.com (7.221.188.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 17 Apr 2025 22:47:04 +0800
Message-ID: <b74de255-9550-484b-9e1a-7adc23f77e7e@huawei.com>
Date: Thu, 17 Apr 2025 22:47:03 +0800
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
	<stable@vger.kernel.org>
References: <767571bc-1a59-4f7c-a9c7-fb23b79303a9@windriver.com>
 <4725f8e8-7f46-48f6-9869-8bf16eca6f1a@windriver.com>
From: huangchenghai <huangchenghai2@huawei.com>
In-Reply-To: <4725f8e8-7f46-48f6-9869-8bf16eca6f1a@windriver.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200024.china.huawei.com (7.221.188.85)

Hello，


I'm not sure if the 5.10 branch has this problem, I remember the debugfs 
function was not implemented in 5.10.

I will take a check tomorrow.


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

