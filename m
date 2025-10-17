Return-Path: <stable+bounces-186247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A10DBE6DDA
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 09:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94D71561B3E
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 06:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDE0310644;
	Fri, 17 Oct 2025 06:59:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AECC30F818;
	Fri, 17 Oct 2025 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684353; cv=none; b=DicXas159e3icKPDmpmiknnLb+WvJux6wZ+YXdqGLzYlU0WksOF+pwPL5vhh6n7EBu5bi0YqZA7Xvg4pPMtOJHWgPzSmTUPUl9ycvn8cp7av5IoOivywndXVs+ajMWDu4LdrBSFBz5Dei4w37KtLHxeeHzlnEp43bR57orcDH7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684353; c=relaxed/simple;
	bh=7KQCiMeUm0jv/ezwrpS6Hqv6DGlgy82Q5Ni41ylA/M4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eI878WZ9tFaRw2qBa3OtXaG4xr/gnCU5a4hCjCm3xkPrIBeAygMUsMTHwrbRxBBe2GeOrjDPhkrgsE3QO+qRxvDPGwqm4PsK3CmeyikxoKCSLkR3qpk16/SYci9dmdln0UaRXcRf95EX5JGrxFvMPkMI2iy/+jKJ9qJacSQp7x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FF541595;
	Thu, 16 Oct 2025 23:59:01 -0700 (PDT)
Received: from [10.57.66.216] (unknown [10.57.66.216])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 000D03F66E;
	Thu, 16 Oct 2025 23:59:05 -0700 (PDT)
Message-ID: <47f246e1-7c18-45f9-acc0-32cf45cb8816@arm.com>
Date: Fri, 17 Oct 2025 08:59:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64/mm: Allow __create_pgd_mapping() to
 propagate pgtable_alloc() errors
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Linu Cherian <linu.cherian@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>, Dev Jain <dev.jain@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Chaitanya S Prakash <chaitanyas.prakash@arm.com>, stable@vger.kernel.org
References: <20251015112758.2701604-1-linu.cherian@arm.com>
 <20251015112758.2701604-2-linu.cherian@arm.com>
 <91a246e6-1efb-43d9-80a4-8445549f47cc@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <91a246e6-1efb-43d9-80a4-8445549f47cc@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/2025 07:24, Anshuman Khandual wrote:
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index b8d37eb037fc..638cb4df31a9 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -49,6 +49,8 @@
>>  #define NO_CONT_MAPPINGS	BIT(1)
>>  #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
>>  
>> +#define INVALID_PHYS_ADDR	(-1ULL)
>> +
> Should this be defined as (~(phys_addr_t)0) instead ? Probably
> INVALID_PHYS_ADDR macro should be made generic as well as this
> is being used in multiple places. But that's besides the point
> here.

This patch is simply moving the definition higher in the file, so I
think it should leave it unchanged. Moving the definition to a generic
header (in a separate patch/series) would clearly be a good idea though.

- Kevin

> arch/arm64/mm/mmu.c			#define INVALID_PHYS_ADDR   (-1ULL)
> arch/s390/boot/vmem.c			#define INVALID_PHYS_ADDR (~(phys_addr_t)0)
> drivers/vdpa/vdpa_user/iova_domain.h	#define INVALID_PHYS_ADDR (~(phys_addr_t)0)
> kernel/dma/swiotlb.c			#define INVALID_PHYS_ADDR (~(phys_addr_t)0)

