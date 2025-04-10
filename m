Return-Path: <stable+bounces-132061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B50A83B76
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 09:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C8817192F
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 07:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1964920487F;
	Thu, 10 Apr 2025 07:41:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23451EEA5D
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270864; cv=none; b=CT06OaEqWAO2jgb8UnhVTbK/anKLLWWLcQYup5CDAxZXFU9f01lTcRQ3zPUWgr6zZesx5i4YR+gTClBY+yX4GMEAqsVJ1mJQ12azRA+JGKhDP/shvPROt4WcMkhRBrzj9enQNG6Lzdkaj6o21MuOr+dZi5nRffm0arpjN7RWViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270864; c=relaxed/simple;
	bh=Avw5NvV/yYzKa3bko/X8H/YRnUJOhH6xDIgXwjhs3gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YYKE9EefDZJTWPCJJTnR/a6G/RhxgjLeFGAkVbTvE6d6failRLDmXTmOSNvn0yXc/fGcv5MLeiDTM3Yf7LluDbjghhg5FnLzdV8dt0BJC6BpLW9+ur1YBgsD9obpxDZIdSTYxUr22i3H2N7zFiHHfQvhNM9lOE/8nlM/GRsHcj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZYBXm2pTGznfcj;
	Thu, 10 Apr 2025 15:39:36 +0800 (CST)
Received: from kwepemo200002.china.huawei.com (unknown [7.202.195.209])
	by mail.maildlp.com (Postfix) with ESMTPS id 03E22180B49;
	Thu, 10 Apr 2025 15:41:00 +0800 (CST)
Received: from [10.174.179.13] (10.174.179.13) by
 kwepemo200002.china.huawei.com (7.202.195.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Apr 2025 15:40:58 +0800
Message-ID: <df87e867-ede5-c57a-2ffa-c6245a56d1bf@huawei.com>
Date: Thu, 10 Apr 2025 15:40:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.6 046/152] x86/mm/tlb: Only trim the mm_cpumask once a
 second
To: Greg KH <gregkh@linuxfoundation.org>, <riel@surriel.com>
CC: <mingo@kernel.org>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <oliver.sang@intel.com>,
	<patches@lists.linux.dev>, <peterz@infradead.org>, <sashal@kernel.org>,
	<stable@vger.kernel.org>, <wangkefeng.wang@huawei.com>
References: <20250219082551.866842270@linuxfoundation.org>
 <20250410011329.2597888-1-tujinjiang@huawei.com>
 <2025041010-scope-endorse-e1a9@gregkh>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <2025041010-scope-endorse-e1a9@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemo200002.china.huawei.com (7.202.195.209)


在 2025/4/10 15:03, Greg KH 写道:
> On Thu, Apr 10, 2025 at 09:13:29AM +0800, Jinjiang Tu wrote:
>> Hi,
>>
>> I noticed commit 6db2526c1d69 ("x86/mm/tlb: Only trim the mm_cpumask once a second")
>> is aimed to fix performance regression introduced by commit 209954cbc7d0
>> ("x86/mm/tlb: Update mm_cpumask lazily")
>>
>> But commit 209954cbc7d0 isn't merged into stable 6.6, it seems merely
>> merging commit 6db2526c1d69 into stable 6.6 is meaningless.
> If you revert it, does everything still work properly?  If so, can you
> submit a patch to revert it if you think it should be removed, from all
> affected branches?

 From theoretical analysis, I think reverting it won't introduce any regression.

Rik, could you please confirm it?

Thanks.

>
> thanks,
>
> greg k-h
>

