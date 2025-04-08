Return-Path: <stable+bounces-128893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3465A7FAF5
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 590FF7A5493
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A80C3C0C;
	Tue,  8 Apr 2025 10:04:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D4026560E
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106698; cv=none; b=fJsHPDgzHknduELlvhoA9TjfiWZhzCneXTJRED+rAIpdhbE66RZgPrd0nfLrSJvA/CcHNXrWETX0A+yM0CFT0/1GrOEe8KHorZCejrCKZTUJz5a8uv8zwOwMfPOIRO/2krIQd5NFj4nTInLvwSDBG4GkowefOshwG3gtaVo90qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106698; c=relaxed/simple;
	bh=Rgb+ILyCXg4BqxhBeMZW7W7cKibIWp0/boT9eSrPUvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=taznbmPeQLwTMXM3iBCIxFJgN3C27NRwDRoWxkUE7nXsGpnyPC3yhPrReZA72JT+lmUPrijn2P6ORBzVKRWWgM0EbPMEoH3TWoT+yWjWemYq+8M9nCAPXYGBTxwieG5/r84sLwqjNVnkjcaWxlRZ1rg70GGDkQMeg81V8naGPmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2D951688;
	Tue,  8 Apr 2025 03:04:57 -0700 (PDT)
Received: from [10.163.48.241] (unknown [10.163.48.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D005C3F6A8;
	Tue,  8 Apr 2025 03:04:54 -0700 (PDT)
Message-ID: <d3a5589f-a231-4d60-9d70-5e0f01dff125@arm.com>
Date: Tue, 8 Apr 2025 15:34:51 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13.y 0/7] arm64/boot: Enable EL2 requirements for
 FEAT_PMUv3p9
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 robh@kernel.org, mark.rutland@arm.com
References: <20250408093859.1205615-1-anshuman.khandual@arm.com>
 <2025040816-frequent-unbundle-7415@gregkh>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <2025040816-frequent-unbundle-7415@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/8/25 15:23, Greg KH wrote:
> On Tue, Apr 08, 2025 at 03:08:52PM +0530, Anshuman Khandual wrote:
>> This series adds fine grained trap control in EL2 required for FEAT_PMUv3p9
>> registers like PMICNTR_EL0, PMICFILTR_EL0, and PMUACR_EL1 which are already
>> being used in the kernel. This is required to prevent their EL1 access trap
>> into EL2.
>>
>> The following commits that enabled access into FEAT_PMUv3p9 registers have
>> already been merged upstream from 6.13 onwards.
>>
>> d8226d8cfbaf ("perf: arm_pmuv3: Add support for Armv9.4 PMU instruction counter")
>> 0bbff9ed8165 ("perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control")
>>
>> The sysreg patches in this series are required for the final patch which
>> fixes the actual problem.
> 
> But you aren't going to fix the 6.14.y tree?  We can't take patches that
> skip newer stable releases for obvious reasons.
> 
> And 6.13.y is only going to be alive for a few more days, is there some
> specific reason this is needed now for 6.13.y?

I have also sent same series for 6.14 stable version as well. It will be
great to have these patches applied both on 6.13 as well 6.14. Thank you.

