Return-Path: <stable+bounces-114192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2DDA2B7CB
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 02:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DEF1671E3
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 01:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DD512E1CD;
	Fri,  7 Feb 2025 01:23:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168EFEAE7;
	Fri,  7 Feb 2025 01:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738891407; cv=none; b=UOrDwd0UJQpylI+CoM6PYAnPR2yzBvgjQiANFZTUYtvxNmLzz4vDhaPpPRuUkITHscJlW5SC3mxRAJ4iLEfjMWmtKHGYtUrrM2tbwDdxEEiA1l/y17Pj2pLvdkgdOl5/Gq/VILS2B7IzNyshJd6SqqScK9U7fXuNgczVKUX/6po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738891407; c=relaxed/simple;
	bh=yW/bitBzJ9mbKepctE1RNJx1uG4S4BG+625p1lFbGic=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a3K4JYj1E1s/i9sZaA0i1uF+okLLhkEbNWAjNIcQSXP6vbh5cJFqJLAEO4e2dy57mTFNYutvOoy081LkQvZXk+FuSCYIp6dWORsmY9pXkMoBi0ZKnLoPDLzlEKrBvc9hEp53gV65Li4rOFH+19AqWo++9cth3iMByGrIYWBTS9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ypx331WHRz1l0hC;
	Fri,  7 Feb 2025 09:19:43 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 0669E1402C1;
	Fri,  7 Feb 2025 09:23:22 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Feb 2025 09:22:35 +0800
Message-ID: <273cccc0-bbb1-4377-9ae6-a9c54ed64527@huawei.com>
Date: Fri, 7 Feb 2025 09:22:34 +0800
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
To: Greg KH <gregkh@linuxfoundation.org>
CC: <sashal@kernel.org>, <stable@vger.kernel.org>,
	<stable-commits@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg
	<johannes@sipsolutions.net>
References: <20250203162734.2179532-1-sashal@kernel.org>
 <e71dbfcd-317e-43b0-8e67-2a7ea3510281@huawei.com>
 <2025020534-family-upgrade-20fb@gregkh>
 <52c4c9a3-73a8-40df-ab37-e15b2f4f8496@huawei.com>
 <2025020654-worst-numbness-ca31@gregkh>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <2025020654-worst-numbness-ca31@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemo500009.china.huawei.com (7.202.194.199)



On 2025/2/6 11:54, Greg KH wrote:
> On Thu, Feb 06, 2025 at 09:09:17AM +0800, Hongbo Li wrote:
>> Well, by the way, is the patch added because there are use cases for the new
>> mount API in hostfs?
> 
> I am sorry, I don't understand the question.
> 

Sorry for my poor expression, I just wonder why this patch should be 
backported to the 6.6-stable tree. :)

Thanks,
Hongbo

> greg k-h

