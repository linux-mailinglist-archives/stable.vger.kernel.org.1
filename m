Return-Path: <stable+bounces-139302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E5AAA5D4A
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 12:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596C71BA7D21
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 10:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11438219E8C;
	Thu,  1 May 2025 10:34:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755F51D89FD
	for <stable@vger.kernel.org>; Thu,  1 May 2025 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746095694; cv=none; b=EP7LLv0vGjKBmIUJDCITQeQr2rrA5WIHid1vjFsATIwiwsrqJVBwfq6vOzOH7lnwbYoPIgVAchEha4Q3N2o1PfAfjmicWZxVxW3VCi4+XvcvA+oMqyVN1mC3BE2BKchjmRZsCVmDlLuDPzsVdlEQDfoN9JS0mazTsHNwX+SWVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746095694; c=relaxed/simple;
	bh=2BDzTfz08AA+JV96xVhzBJFduZIkpiRvekW7A3f2vxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USp+EwAr9VfnPH2WyQ//5ALKnAVsdZgF/VyLigPpPapF4ig0BIRoZr+ONwc7YD1vyNHZL/tg1W7u3AAvCDrudna5Z/T/2/C+197kd4GiNiN3ghSYVDwsKpgdOLl7sfY0PuTzkYuh7kMZc3hQRl+e4WVzwXKgXpKlF39Bz/8zsSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47CE7106F;
	Thu,  1 May 2025 03:34:45 -0700 (PDT)
Received: from [10.57.71.241] (unknown [10.57.71.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6B753F673;
	Thu,  1 May 2025 03:34:51 -0700 (PDT)
Message-ID: <2cad04c2-0c4d-4f05-ad3b-23d82ae42a13@arm.com>
Date: Thu, 1 May 2025 11:34:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6.6] iommu: Handle race with default domain setup
To: Greg KH <gregkh@linuxfoundation.org>, Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>
References: <f0cac3a642f34d0d239f8d7870e33881fc7081d6.1745923148.git.robin.murphy@arm.com>
 <2025042954-factual-vengeful-6614@gregkh>
 <8b202837-b759-4d66-8e1a-a15ac22049cc@arm.com>
 <2025042921-banish-detached-4d91@gregkh>
 <2025050141-coagulant-flail-8060@gregkh>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <2025050141-coagulant-flail-8060@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-05-01 8:46 am, Greg KH wrote:
[...]
>> Great, all now queued up.
> 
> And now there's reports it is causing problems in the 6.6-stable queue:
> 	https://lore.kernel.org/r/1903a129-6e06-47d9-862b-ab23f72a9fea@nvidia.com
> so I'm going to drop it from the 6.6.y tree now, sorry.
> 
> Can you work with Jon to to get this figured out?

Oh fiddle... Jon, are you able to test if adding c8cc2655cc6c 
("iommu/tegra-smmu: Implement an IDENTITY domain") makes it work OK? It 
cherry-picks cleanly, and I reckon it's just about small enough to be 
reasonable to take as a dependency. Indeed I had forgotten the subtlety 
of Tegra being the one driver which is used with CONFIG_IOMMU_DMA but 
still didn't support default domains at that point...

Thanks
Robin,

