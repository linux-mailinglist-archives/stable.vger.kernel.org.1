Return-Path: <stable+bounces-169491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8081B25987
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 04:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4425A046A
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 02:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10E445009;
	Thu, 14 Aug 2025 02:34:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E1918B12
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 02:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755138843; cv=none; b=mCHuJzzp6WFwPCcEfUZWHCHRXBhR3V0vTzqEOSjjhpCKsYOLHiCzFyUj9w18jyNIi8XL5odLScSoN21sInhNcBF2ljI//YctbdWOs5w2uoBYwEGGZ7VaV2UZ2q77AQBlpsjm8X+64+6VIXh0te3TekmYcvMoG1i8SrzckBMssic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755138843; c=relaxed/simple;
	bh=qGodillNr/lnSMBv35Uu5Ir54FmuFBR/0WZSqvIJpSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d8JiLh1ARFJvt9dKTfSM2AlsthVj8bAL1SCkPNUyn1ctEFfn6d6KcJ1A2s0JKDSogDk/DVFJDyNRdMq3j2TjbDtQn0GnYRXGCRtH09He5cJdaQLXMiZE1L0SjzlKsOBka5NtIIthDhcHlJdRRV9XxfZk0vftqDweoYhxFZzDSoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c2Thx5mSwz2Cg6M;
	Thu, 14 Aug 2025 10:29:37 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id B49FF1401F4;
	Thu, 14 Aug 2025 10:33:57 +0800 (CST)
Received: from [10.67.111.31] (10.67.111.31) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 10:33:57 +0800
Message-ID: <f3e631dc-245a-4efe-98e5-cbe94464daec@huawei.com>
Date: Thu, 14 Aug 2025 10:33:56 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: Fix possible deadlock in console_trylock_spinning
To: Andrew Morton <akpm@linux-foundation.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, <stable@vger.kernel.org>,
	<linux-mm@kvack.org>, Waiman Long <llong@redhat.com>, Breno Leitao
	<leitao@debian.org>, John Ogness <john.ogness@linutronix.de>, Lu Jialin
	<lujialin4@huawei.com>
References: <20250813085310.2260586-1-gubowen5@huawei.com>
 <20250813155616.d7e5a832ce7cda7764942d10@linux-foundation.org>
Content-Language: en-US
From: Gu Bowen <gubowen5@huawei.com>
In-Reply-To: <20250813155616.d7e5a832ce7cda7764942d10@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemh100007.china.huawei.com (7.202.181.92)

On 8/14/2025 6:56 AM, Andrew Morton wrote:
> 
> I'm not sure which kernel version this was against, but kmemleak.c has
> changed quite a lot.
> 
> Could we please see a patch against a latest kernel version?  Linus
> mainline will suit.
> 
> Thanks.
> 

I discovered this issue in kernel version 5.10. Afterwards, I reviewed 
the code of the mainline version and found that this deadlock path no 
longer exists due to the refactoring of console_lock in v6.2-rc1. For 
details on the refactoring, you can refer to this link :
https://lore.kernel.org/all/20221116162152.193147-1-john.ogness@linutronix.de/. 
Therefore, theoretically, this issue existed before the refactoring of 
console_lock.

Best Regards，
Guber

