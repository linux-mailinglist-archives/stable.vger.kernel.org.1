Return-Path: <stable+bounces-131878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAC8A81B56
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 04:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4F58874B2
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 02:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC0713B280;
	Wed,  9 Apr 2025 02:55:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7277F8C1E
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 02:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744167343; cv=none; b=hIvYXuvtGszSux3PyhYgYez7nDGhzqxb4adP8WgVq0vEzdsDGEVghyyYcOl51WxaXdimQLBc6t0pm4/qWu+cPffWodMR8jTrHKAxptgVdugoctjq1dF7QnKPTmeAxHlfX77Glj6xOB6xWc/q1Vck5qLUmVfaWkMsXawC52o6FM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744167343; c=relaxed/simple;
	bh=XcjBH5FUkAE7W4GnSTrR1txQLXwvG2RnyI5ilWaI8Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fv7etvpjXGNpToM2r3KyNaRsH1w3cCEnGUyvO1sKEbS1X9paKiD3EvQK2Ovuhs20+IulEIdZpu9aUlGP1ZZVeLUnsmFFCPmEotJZ8h9YX/wOC2B2Dssi+hB9Ms/gYPMu54iZhDv1+6CgRIAFKhVUaXlFOu/4Jld2Cz9vLjZRLFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBE331688;
	Tue,  8 Apr 2025 19:55:39 -0700 (PDT)
Received: from [10.162.42.12] (a077893.blr.arm.com [10.162.42.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E5773F694;
	Tue,  8 Apr 2025 19:55:37 -0700 (PDT)
Message-ID: <0460258c-527e-4564-8bde-c33c5f36b814@arm.com>
Date: Wed, 9 Apr 2025 08:25:34 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13.y 0/7] arm64/boot: Enable EL2 requirements for
 FEAT_PMUv3p9
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 will@kernel.org, robh@kernel.org, mark.rutland@arm.com
References: <20250408093859.1205615-1-anshuman.khandual@arm.com>
 <2025040816-frequent-unbundle-7415@gregkh>
 <d3a5589f-a231-4d60-9d70-5e0f01dff125@arm.com> <Z_VObETYYOHdym9N@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Z_VObETYYOHdym9N@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/8/25 21:57, Catalin Marinas wrote:
> On Tue, Apr 08, 2025 at 03:34:51PM +0530, Anshuman Khandual wrote:
>> On 4/8/25 15:23, Greg KH wrote:
>>> On Tue, Apr 08, 2025 at 03:08:52PM +0530, Anshuman Khandual wrote:
>>>> This series adds fine grained trap control in EL2 required for FEAT_PMUv3p9
>>>> registers like PMICNTR_EL0, PMICFILTR_EL0, and PMUACR_EL1 which are already
>>>> being used in the kernel. This is required to prevent their EL1 access trap
>>>> into EL2.
>>>>
>>>> The following commits that enabled access into FEAT_PMUv3p9 registers have
>>>> already been merged upstream from 6.13 onwards.
>>>>
>>>> d8226d8cfbaf ("perf: arm_pmuv3: Add support for Armv9.4 PMU instruction counter")
>>>> 0bbff9ed8165 ("perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control")
>>>>
>>>> The sysreg patches in this series are required for the final patch which
>>>> fixes the actual problem.
>>>
>>> But you aren't going to fix the 6.14.y tree?  We can't take patches that
>>> skip newer stable releases for obvious reasons.
>>>
>>> And 6.13.y is only going to be alive for a few more days, is there some
>>> specific reason this is needed now for 6.13.y?
>>
>> I have also sent same series for 6.14 stable version as well. It will be
>> great to have these patches applied both on 6.13 as well 6.14. Thank you.
> 
> TBH, 6.13 is end of life soon, so not sure it's worth carrying those
> patches. Do you have a reason for this Anshuman?

Not particularly for 6.13.

We can just skip these from 6.13 if that is not going to be around for long.
I was under the impression that all maintained stable releases starting from
where this problem got introduced upto now, need to be covered for this back
porting.

