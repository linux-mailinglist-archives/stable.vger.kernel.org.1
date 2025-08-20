Return-Path: <stable+bounces-171868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB05B2D15B
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 03:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF5831C42A19
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 01:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8844420F08C;
	Wed, 20 Aug 2025 01:23:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC5D20B7F9
	for <stable@vger.kernel.org>; Wed, 20 Aug 2025 01:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755653020; cv=none; b=DMP+JhTzl76JFMTzDaBLNNqEneJE6YeUGI6dU/DRceu2OYg+LT3rqqM4NeSbEauGT89m5p2+8FZMPb42d2HDCGIUJGnPa3fjUXGpq4cr5CqsCKYLnAreh+rtXusJzvH8tlCWnZkJiawWlYbthHP20yeQ0jlHcVLAgNbfqMYxPLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755653020; c=relaxed/simple;
	bh=8cA/ZutztZQCDJ0/mW1ddsFhUDqnnYK0n+6T6YoVO7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DivoygINDz7T8XcvkQKpK5pOfzGuWxBKi6jI06+A4iU8QZt3eVBIpCkTjQ4ZaU6fTGFCJmFiG5TTybxUJ9zBoDDcWYpjWtcdfE9sJBVkviyB/Zh2b7PVj0Uvhja/iOyd2YwgG1vgV6hjHfpeiVTGBSYI/ZIXlPKdSQ+vxI2pB/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c67z43SRvz27jJ5;
	Wed, 20 Aug 2025 09:24:32 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id 37C4A1A016C;
	Wed, 20 Aug 2025 09:23:27 +0800 (CST)
Received: from [10.67.111.31] (10.67.111.31) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 20 Aug
 2025 09:23:26 +0800
Message-ID: <a7829822-42dc-499a-b092-b9003a0e156b@huawei.com>
Date: Wed, 20 Aug 2025 09:23:26 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: Fix possible deadlock in kmemleak
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <stable@vger.kernel.org>, <linux-mm@kvack.org>,
	Waiman Long <llong@redhat.com>, Breno Leitao <leitao@debian.org>, John Ogness
	<john.ogness@linutronix.de>, Lu Jialin <lujialin4@huawei.com>
References: <20250818090945.1003644-1-gubowen5@huawei.com>
 <aKSYq17EUrXRGFPO@arm.com>
Content-Language: en-US
From: Gu Bowen <gubowen5@huawei.com>
In-Reply-To: <aKSYq17EUrXRGFPO@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemh100007.china.huawei.com (7.202.181.92)

On 8/19/2025 11:30 PM, Catalin Marinas wrote:
> On Mon, Aug 18, 2025 at 05:09:44PM +0800, Gu Bowen wrote:
>> Our syztester report the lockdep WARNING [1], which was identified in
>> stable kernel version 5.10. However, this deadlock path no longer exists
>> due to the refactoring of console_lock in v6.2-rc1 [2]. Coincidentally,
>> there are two types of deadlocks that we have found here. One is the ABBA
>> deadlock, as mentioned above [1], and the other is the AA deadlock was
>> reported by Breno [3]. The latter's deadlock issue persists.
> 
> It's better to include the lockdep warning here rather than linking to
> other threads. Also since we are targeting upstream with this patch,
> I don't think we should mention lockdep warnings for 5.10.
> 
>> To solve this problem, switch to printk_safe mode before printing warning
>> message, this will redirect all printk()-s to a special per-CPU buffer,
>> which will be flushed later from a safe context (irq work), and this
>> deadlock problem can be avoided. The proper API to use should be
>> printk_deferred_enter()/printk_deferred_exit() [4].
>>
>> [1]
>> https://lore.kernel.org/all/20250730094914.566582-1-gubowen5@huawei.com/
>> [2]
>> https://lore.kernel.org/all/20221116162152.193147-1-john.ogness@linutronix.de/
>> [3]
>> https://lore.kernel.org/all/20250731-kmemleak_lock-v1-1-728fd470198f@debian.org/#t
>> [4]
>> https://lore.kernel.org/all/5ca375cd-4a20-4807-b897-68b289626550@redhat.com/
>> ====================
>>
> 
> I suggest you add the 5.10 mention here if you want, text after "---" is
> normally stripped (well, not sure with Andrew's scripts).
> 
> Otherwise the patch looks fine.
> 

Thank you for your advice, I will pay attention to these points in the 
future.

Best Regards,
Guber

