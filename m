Return-Path: <stable+bounces-114016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1DCA29E40
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 02:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3989218876CD
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 01:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FC61CD3F;
	Thu,  6 Feb 2025 01:09:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6E216419;
	Thu,  6 Feb 2025 01:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738804166; cv=none; b=OF7MrxHAYQlJo/rq21mu18oEWmKeBOB6OUXnRHLQCDXpXxPaNyCf22HwJsqfT69NDJaBNT7C5HLx8o0ZpooNemYevft3WM1lZVJ/Ny3oO1GjsEhYAG7CcKmfrk+rCm+BiqKd3ksQsgfUsN0KVXoNk99GKijAHj1t8IjF22BHDhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738804166; c=relaxed/simple;
	bh=p94TJUTkfuyaYNBRpvAY9s5HxWySYEpVyT+rqC2BZM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qFDAVmSqwl9Buofh/qPwmkAxhtUP5JZ85Agz1/n/7MJdwoObCGek1YwPIiwIpwc0ucyN5p7C2uvlodf/wUiH8BrmTAcdGCiUrmwGmNsusdNz7bDygjrKY0CuyO+EcqYP+tkILhFY1NOx2yyrxD2sliJSh9SoMdlaY633dfK3tV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YpJr21SnQz1JJdc;
	Thu,  6 Feb 2025 09:08:02 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 646961A016C;
	Thu,  6 Feb 2025 09:09:18 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Feb 2025 09:09:17 +0800
Message-ID: <52c4c9a3-73a8-40df-ab37-e15b2f4f8496@huawei.com>
Date: Thu, 6 Feb 2025 09:09:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "hostfs: convert hostfs to use the new mount API" has been
 added to the 6.6-stable tree
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>, <sashal@kernel.org>
CC: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
References: <20250203162734.2179532-1-sashal@kernel.org>
 <e71dbfcd-317e-43b0-8e67-2a7ea3510281@huawei.com>
 <2025020534-family-upgrade-20fb@gregkh>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <2025020534-family-upgrade-20fb@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Well, by the way, is the patch added because there are use cases for the 
new mount API in hostfs?

Thanks,
Hongbo

On 2025/2/5 16:53, Greg KH wrote:
> On Wed, Feb 05, 2025 at 09:13:33AM +0800, Hongbo Li wrote:
>>
>>
>> On 2025/2/4 0:27, Sasha Levin wrote:
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>       hostfs: convert hostfs to use the new mount API
>>>
>>> to the 6.6-stable tree which can be found at:
>>>       http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>
>>
>> Hi Sasha,
>>
>> If this, the fix : ef9ca17ca458 ("hostfs: fix the host directory parse when
>> mounting.") also should be added. It fixes the mounting bug when pass the
>> host directory.
> 
> I've swept the queues and have added the "fixes for the fixes" commits
> like this one now, thanks!
> 
> greg k-h

