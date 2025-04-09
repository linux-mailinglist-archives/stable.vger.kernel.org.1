Return-Path: <stable+bounces-131880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD754A81B9E
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 05:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B7E7B6569
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 03:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1F41A3159;
	Wed,  9 Apr 2025 03:36:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF2014D29B
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 03:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744169806; cv=none; b=n30zSyd3DKuUMzKvSrhvekQnSh7zURvn8b5uluZt4UOS5GWyie6qOqdp5gjAQp0rrARtj3IxNQF1D2054dN4ZMutIf2V0uH6Ev6VkdTsdPBFs7bFcTNHlcT24+AEG985EhNO+03/Osv1VCOt008d9kQplYtFAqNloku79r4k4qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744169806; c=relaxed/simple;
	bh=51NooNV8cOnJyJA0XhV5/W6tV+PG06R6bC7CraiQ0mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CuQ0G1SEkDWNka4umRAKY5CnwgzkqRkZF2694FabYuSOXsyNjcP9zrOlXhSxU3d+WrI1rX64VPk7DtuTP7Fz9UjwMfMCixYePkXje55kjwZvoiMggdkSlbaenDB6NzIgFFMcl24hi7jlHIzPXFp8Y9geM1ERILpgZrfFj9PpMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94E6A1688;
	Tue,  8 Apr 2025 20:36:43 -0700 (PDT)
Received: from [10.162.42.12] (a077893.blr.arm.com [10.162.42.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2787B3F694;
	Tue,  8 Apr 2025 20:36:40 -0700 (PDT)
Message-ID: <697bde50-24a3-458d-8431-b78942e77d77@arm.com>
Date: Wed, 9 Apr 2025 09:06:38 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13.y 0/7] arm64/boot: Enable EL2 requirements for
 FEAT_PMUv3p9
To: Rob Herring <robh@kernel.org>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 mark.rutland@arm.com
References: <20250408093859.1205615-1-anshuman.khandual@arm.com>
 <CAL_JsqKYPgfjaBy848NAkDg7v5t7B-gcrLRrumemVYWThkk5cA@mail.gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAL_JsqKYPgfjaBy848NAkDg7v5t7B-gcrLRrumemVYWThkk5cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/8/25 23:10, Rob Herring wrote:
> On Tue, Apr 8, 2025 at 4:39 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> This series adds fine grained trap control in EL2 required for FEAT_PMUv3p9
>> registers like PMICNTR_EL0, PMICFILTR_EL0, and PMUACR_EL1 which are already
>> being used in the kernel. This is required to prevent their EL1 access trap
>> into EL2.
>>
>> The following commits that enabled access into FEAT_PMUv3p9 registers have
>> already been merged upstream from 6.13 onwards.
>>
>> d8226d8cfbaf ("perf: arm_pmuv3: Add support for Armv9.4 PMU instruction counter")
> 
> This landed in v6.12, not 6.13. As 6.12 is LTS, it needs the backport.

You are right, missed that. I will send this series for 6.12 stable as well.

BTW also need to backport the following commit for ID_AA64DFR0_EL1_PMUVer_V3P9
symbol which is required in __init_el2_fgt2(). Because this commit is not part
of the current v6.12 stable tree.

a40e1ec92e46 ("perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control")

> 
>> 0bbff9ed8165 ("perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control")
>>
>> The sysreg patches in this series are required for the final patch which
>> fixes the actual problem.
>>
>> Anshuman Khandual (7):
>>   arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
>>   arm64/sysreg: Add register fields for HDFGRTR2_EL2
>>   arm64/sysreg: Add register fields for HDFGWTR2_EL2
>>   arm64/sysreg: Add register fields for HFGITR2_EL2
>>   arm64/sysreg: Add register fields for HFGRTR2_EL2
>>   arm64/sysreg: Add register fields for HFGWTR2_EL2
>>   arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
>>
>>  Documentation/arch/arm64/booting.rst |  22 ++++++
>>  arch/arm64/include/asm/el2_setup.h   |  25 +++++++
>>  arch/arm64/tools/sysreg              | 103 +++++++++++++++++++++++++++
>>  3 files changed, 150 insertions(+)
>>
>> --
>> 2.30.2
>>

