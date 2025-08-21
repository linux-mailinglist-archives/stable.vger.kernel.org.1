Return-Path: <stable+bounces-171971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBC5B2F705
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75451C247A5
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 11:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FDC20B1F4;
	Thu, 21 Aug 2025 11:45:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B40428850B
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776715; cv=none; b=ZV3RZ/GtH+3elUXq0oo2ZSyXcUgM0cZ7zcgCRF48P/wiqnSpNmNqznhIdK/Kkt1DHxcjPljDIowuiEM70/DtyZYbkQBI0Af45ac3vMkOBGbO50YTATbRYaKZa8gMmQF+FSHDSt71BxdkNLPDx8fUqApdY8nJUI/6+YQm9hgZg6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776715; c=relaxed/simple;
	bh=MrjNNdvvSuktu3/ih2wU8zngQEKeLSkhZj4XEosZEFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PMay63ZpDboORYM0Hz4F/XLUMc5Fk25QIWXRnSHpfW/RucTeml0419VEO2sSK52hgA3k7wOmMJgS0umvn4hCk4gm0EUmg0EUYR55KeBQyDiyaRgrOkpA8xcywyzf0rP23IsFdA7b84mk0AgbbBPD68bEY4FCJb9btZKcvVubP8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c71bf3S3MzdcPl;
	Thu, 21 Aug 2025 19:40:46 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id EE962140279;
	Thu, 21 Aug 2025 19:45:09 +0800 (CST)
Received: from [10.67.111.31] (10.67.111.31) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 21 Aug
 2025 19:45:09 +0800
Message-ID: <a038cd3a-2491-4a0c-aa7c-120ea7e58341@huawei.com>
Date: Thu, 21 Aug 2025 19:45:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: Fix possible deadlock in kmemleak
To: Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <llong@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <stable@vger.kernel.org>, <linux-mm@kvack.org>,
	Breno Leitao <leitao@debian.org>, John Ogness <john.ogness@linutronix.de>, Lu
 Jialin <lujialin4@huawei.com>
References: <20250818090945.1003644-1-gubowen5@huawei.com>
 <113a8332-b35c-4d00-b8b1-21c07d133f1f@redhat.com> <aKWrSfLD5f1r5rg_@arm.com>
 <fed73718-8001-4db6-af36-86c60e85d224@redhat.com> <aKX_HvAK6ZopNX35@arm.com>
Content-Language: en-US
From: Gu Bowen <gubowen5@huawei.com>
In-Reply-To: <aKX_HvAK6ZopNX35@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemh100007.china.huawei.com (7.202.181.92)

On 8/21/2025 1:00 AM, Catalin Marinas wrote:
>
>> Anyway, I am not against using printk_deferred_enter/exit here. It is just
>> that they should be used as a last resort if there is no easy way to work
>> around it.
> 
> This works for me if Gu respins the patch
> 
This is indeed a better form, and I will send a new patch later.

Thanks,
Guber

