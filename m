Return-Path: <stable+bounces-166758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5346B1D132
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 05:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C4617E3E9
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 03:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC899195808;
	Thu,  7 Aug 2025 03:22:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849B0189
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754536937; cv=none; b=gCh10oU4f2VdTtIcio2vwtWLZGPnBPEw9/qzYfTWiP9tZomcFd1bDmXPjnGFJ4l8uTOX6DAtNbG1kDvRqa2W9HDyVToODoO7YakDo8fwZaG0vgBr5VUkYSQ9uT155MMVM6f0rGHgXzFYa+1iaB4Ht4yaUuGNfQSaB2C5uZASRwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754536937; c=relaxed/simple;
	bh=5vetXlUeZ271OyFd8Sf5lLjPOcD+N4tqQ1pNC6qBDZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hbU03gZBsx5f0YIkBtx7BBzL2oSL7KTeD6/QqWviRwVzcEiPOm0JZhpdkEjBfMp76yLnOveu54nVlkPGQUZ+db2ODUpCJmpGa/O4l8APNAhIj+1rxjE1ABFJJw2jwqSqh//IJk5wmkWdoDABYZ77VeRTcnyq8n9i3JrVXufZNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4byC7t67Q6z2RW7C;
	Thu,  7 Aug 2025 11:19:38 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B0341A0171;
	Thu,  7 Aug 2025 11:22:11 +0800 (CST)
Received: from [10.67.111.31] (10.67.111.31) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 Aug
 2025 11:22:10 +0800
Message-ID: <6e278baf-c6e4-49ee-9880-6c15a2c1b996@huawei.com>
Date: Thu, 7 Aug 2025 11:22:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix possible deadlock in console_trylock_spinning
To: John Ogness <john.ogness@linutronix.de>, Waiman Long <llong@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, <stable@vger.kernel.org>,
	<linux-mm@kvack.org>, Lu Jialin <lujialin4@huawei.com>, Breno Leitao
	<leitao@debian.org>
References: <20250730094914.566582-1-gubowen5@huawei.com>
 <20250801153303.cee42dcfc94c63fb5026bba0@linux-foundation.org>
 <5ca375cd-4a20-4807-b897-68b289626550@redhat.com>
 <84h5yko44i.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Gu Bowen <gubowen5@huawei.com>
In-Reply-To: <84h5yko44i.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemh100007.china.huawei.com (7.202.181.92)



On 8/6/2025 11:34 PM, John Ogness wrote:

> 
> printk no longer works like this. There are no special per-CPU
> buffers. As correctly pointed out by Longman, the proper interface is
> printk_deferred_enter()/printk_deferred_exit().
> 
> With the deferred interface, the printk message is still immediately
> stored in the printk ringbuffer (which is lockless) and only the console
> printing itself is deferred.
> 

Hi,
I agree that printk_deferred_enter()/printk_deferred_exit() is a better 
interface, but I noticed that in stable-5.10, the printk safety mode 
still uses a per-CPU buffer to store messages through the 
printk_safe_log_store function.

Additionally, the mainline version has already refactored printk, so 
this issue no longer exists.

