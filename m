Return-Path: <stable+bounces-166536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83185B1AF8A
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 09:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D023AAD55
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 07:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C9921ADCB;
	Tue,  5 Aug 2025 07:44:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0225F3595B
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754379855; cv=none; b=sPc3EB1dca7KjyKGmFBwgbEQSp29RiQVVafhwDoHvrgj3ktLVOBEqUgKdVVcvmTgEoZQdsGCfp8d8gMbMCt3V0Klw3GOnyEb1nl2OJLy3ipUra3igCkc37V4RBSKKaUdEthheqPaqmbPOV7H55PCluv/RDobkAcDbmtVaEU0QaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754379855; c=relaxed/simple;
	bh=pMYbBCAaIbiBbn5GNYpl1OuPiJMI6RX5uuSCHXRqdEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FjoYDYrRlJtPtI/v555aSoUlvhx4FOzcxCfvlUyjjfkNmiqYkVHdBJdOG9nnwbJFMnXq6RjctCXXPEZyBqrp4l5ISsyqeh/G7wcqUL+HdP9jM35iJ2okxkWOqD2tt1cE0U2QYhv94FWDhhocrtnvGR3tC6O8hOZMb/n+XF8S8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bx5154bWKz14MFl;
	Tue,  5 Aug 2025 15:39:53 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id D2456140155;
	Tue,  5 Aug 2025 15:44:09 +0800 (CST)
Received: from [10.67.111.31] (10.67.111.31) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 5 Aug
 2025 15:44:09 +0800
Message-ID: <d9128aac-1731-4cf6-ae04-0a86bc761b5b@huawei.com>
Date: Tue, 5 Aug 2025 15:44:08 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix possible deadlock in console_trylock_spinning
To: Catalin Marinas <catalin.marinas@arm.com>, Breno Leitao
	<leitao@debian.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Waiman Long <llong@redhat.com>,
	<stable@vger.kernel.org>, <linux-mm@kvack.org>, Lu Jialin
	<lujialin4@huawei.com>
References: <20250730094914.566582-1-gubowen5@huawei.com>
 <20250801153303.cee42dcfc94c63fb5026bba0@linux-foundation.org>
 <5ca375cd-4a20-4807-b897-68b289626550@redhat.com>
 <20250801205323.70c2fabe5f64d2fb7c64fd94@linux-foundation.org>
 <aJCir5Wh362XzLSx@arm.com>
 <o2gpvdtxqrdfrsbayorvzvjqcreb45puojpgfye7dimbuuvbdt@gxquukahrxo7>
 <aJD72syGyJs203Mw@arm.com>
Content-Language: en-US
From: Gu Bowen <gubowen5@huawei.com>
In-Reply-To: <aJD72syGyJs203Mw@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemh100007.china.huawei.com (7.202.181.92)



On 8/5/2025 2:28 AM, Catalin Marinas wrote:
> On Mon, Aug 04, 2025 at 05:34:10AM -0700, Breno Leitao wrote:
>> On Mon, Aug 04, 2025 at 01:08:15PM +0100, Catalin Marinas wrote:
>>
>> weird enought, lockdep never picked this issue, and I have a few set of
>> hosts running kmemleak and lockdep for a while.
>>
>> This time was different because I have decided to invstiage the code,
>> and found the deadlock. Still, no lockdep complain at all.
> 
> I guess it's because kmemleak is quiet in general, unless problems are
> found, and lockdep never registered this combination - printk() called
> with the kmemleak_lock held.

As you have guessed, this issue occurred right after the kmemleak warning.

Thanks for the reminder about printk_deferred_* and the suggestion 
regarding code comments..

I will send a new version after verification.

Best regards,
Guber

