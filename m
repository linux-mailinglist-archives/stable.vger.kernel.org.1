Return-Path: <stable+bounces-46118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EA68CEE4F
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 11:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427642816B3
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 09:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DB918E02;
	Sat, 25 May 2024 09:33:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B099D208CA;
	Sat, 25 May 2024 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716629593; cv=none; b=JnwZxJ9OZJOx6Pdxva1nC5CRiXeBE6bJzIK45K9H2SHdvPkQ5EZaZA4yaxWiEJjzalDLs9ywiLxF7gEnDJz0Gft6DfnzQqdbOKDUipPIolID4DaLewdYbDzfhjZ6++1k4ESCAJ959TePkhnCaVq0MgJLktitqVAxRAa3t8gzW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716629593; c=relaxed/simple;
	bh=3KU+N5w5b+nXWgR3j9pvDZ1+lQWYW70U6jBOnLm+zBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u5M1xNRWiGXImWRoqTXJf4nHDe95e8myKXQImaS5hw9UbVzTO2aZf1CRRVgHTII5N6nt3TjeOsXwdKByZZiaezNM1pHD2RAV8dpUtxM49kZVq9HfdzI74+OJECZzGCnJIQbWgCBwP44cNZ5s/V+nW5VM8ubM4SHBBgws5GMa0XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Vmc6P3PC8zkXdT;
	Sat, 25 May 2024 17:28:45 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id E32C618007A;
	Sat, 25 May 2024 17:33:01 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 25 May 2024 17:33:01 +0800
Message-ID: <92bc4c96-9aaa-056c-e59a-4396d19a9f58@huawei.com>
Date: Sat, 25 May 2024 17:33:00 +0800
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
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <2024052355-doze-implicate-236d@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)



On 2024/5/23 19:34, Greg KH wrote:
> On Mon, May 06, 2024 at 11:05:52AM +0800, Zhengchao Shao wrote:
>> There's no "pernet" variable in the struct hashinfo. The "pernet" variable
>> is introduced from v6.1-rc1. Revert pre-patch and post-patch.
> 
> I do not understand, why are these reverts needed?
> 
> How does the code currently build if there is no variable here?
> 
> confused,
> 
> greg k-h
Hi greg:
   If only the first patch is merged, compilation will fail.
There's no "pernet" variable in the struct hashinfo.

Thank you

Zhengchao Shao

