Return-Path: <stable+bounces-41690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA838B5751
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE701C21508
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152B553385;
	Mon, 29 Apr 2024 12:02:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623C4D5A2;
	Mon, 29 Apr 2024 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392120; cv=none; b=dNvdhkhe16yAkLqedDXO3R8pSdI37mFn3ncqzFch1byR3+iP2YHrEiD+i2wuKh2rljU+n03mpHS3ZldQIN83+OS/LF7GOjA7U4CJyxeWxbbrOBh2xRxg50Jz20aBDkTBkkHzj2qHyzPETBbDmaOQxHRbnUaXOu7lg6ffET/bq3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392120; c=relaxed/simple;
	bh=9iIjYXaYSEZUrN1U0/0CwWcV7X6cCzRScr7qz8f2e64=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aZUKr/B3W9lsmwgx8lKtMr26Q648ck2o/PvsFO8uifRy5XC/N6zaHM0O7BWYZF2O5fhRRbD+DtZWj7iEnqzxQf1vZdCUNkQuQ7YoXP2m46J8b8DsCQ3d3JALBRVglByHI0aglHdCZlnqLr0LoD/DoldjOMvrEVdZamF7BgioW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VShgJ2JTwzwVsK;
	Mon, 29 Apr 2024 19:58:36 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C46D1400D1;
	Mon, 29 Apr 2024 20:01:52 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 20:01:52 +0800
Message-ID: <ee497098-6a14-f833-3c6f-a8b31259ad36@huawei.com>
Date: Mon, 29 Apr 2024 20:01:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH stable,5.10 0/2] introduce stop timer to solve the problem
 of CVE-2024-26865
To: Greg KH <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>, <kuba@kernel.org>,
	<edumazet@google.com>, <kuniyu@amazon.com>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>
References: <20240428034948.3186333-1-shaozhengchao@huawei.com>
 <2024042934-dreadful-litigate-9064@gregkh>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <2024042934-dreadful-litigate-9064@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)


Hi Greg KH:
   Thanks for the heads-up. I will work for 5.15.y and 4.19.y.

Thank you.

Zhengchao Shao

On 2024/4/29 19:11, Greg KH wrote:
> On Sun, Apr 28, 2024 at 11:49:46AM +0800, Zhengchao Shao wrote:
>> For the CVE-2024-26865 issue, the stable 5.10 branch code also involves
>> this issue. However, the patch of the mainline version cannot be used on
>> stable 5.10 branch. The commit 740ea3c4a0b2("tcp: Clean up kernel
>> listener' s reqsk in inet_twsk_purge()") is required to stop the timer.
> 
> This is also needed for 5.15.y, so we can not take a 5.10.y only patch,
> you know this :(
> 
> Please also provide a working set of 5.15.y patches and then I'll be
> glad to queue these 5.10.y ones up.
> 
> thanks,
> 
> greg k-h

