Return-Path: <stable+bounces-132200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6DAA85276
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 06:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE93E19E6D55
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 04:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588351E0DD9;
	Fri, 11 Apr 2025 04:24:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEF21581E0
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 04:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744345475; cv=none; b=ZgARMqZLCI4u+auCA914Lgx0eNib5/1zMAlABDkK9Oar0wjfK+QIl30ujbE5sCvQy9bxs9wGVzt4krPlxa3OwQ9ezNCxGFvH1XMDNQOfSV2s10pA7c3VEFztfTQji6Ij9L7YFXSKMo6+XTygLPRhXaOwl7aA3GBoHER8sFT/5XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744345475; c=relaxed/simple;
	bh=UtRK7Za4w9ScPDZET+AplQkEELDH+EQEwgcN+2eiq9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l35N1mEQhHZ+NGlqYJuMzRfy1OXcuMD5Hyx3m6VzqmjMFVe51bp5J4r7te7V20acYdziKBPzVF3ae4Aj0eNmLRa3lskTQ74ZpoBOI0h1txcm9Ab1Pja3Ok1GzK4L5VhCkaXI/qCpDehrqrqOQlSXdqQchyYUyn+WzLQo7gx33H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EE07106F;
	Thu, 10 Apr 2025 21:24:32 -0700 (PDT)
Received: from [10.163.44.254] (unknown [10.163.44.254])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53E923F694;
	Thu, 10 Apr 2025 21:24:30 -0700 (PDT)
Message-ID: <f9c54759-6e4e-4c00-8c68-ea73c8fe1fa5@arm.com>
Date: Fri, 11 Apr 2025 09:54:27 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 1/8] perf/arm_pmuv3: Add PMUv3.9 per counter EL0
 access control
To: Rob Herring <robh@kernel.org>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 mark.rutland@arm.com
References: <20250410035543.1518500-1-anshuman.khandual@arm.com>
 <20250410035543.1518500-2-anshuman.khandual@arm.com>
 <CAL_JsqKNf5JOWDocjOqmKTi0DMzn1Q_=er1W9JNFuya6Awpikg@mail.gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAL_JsqKNf5JOWDocjOqmKTi0DMzn1Q_=er1W9JNFuya6Awpikg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/10/25 22:20, Rob Herring wrote:
> On Wed, Apr 9, 2025 at 10:55 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> From: "Rob Herring (Arm)" <robh@kernel.org>
>>
>> Armv8.9/9.4 PMUv3.9 adds per counter EL0 access controls. Per counter
>> access is enabled with the UEN bit in PMUSERENR_EL1 register. Individual
>> counters are enabled/disabled in the PMUACR_EL1 register. When UEN is
>> set, the CR/ER bits control EL0 write access and must be set to disable
>> write access.
>>
>> With the access controls, the clearing of unused counters can be
>> skipped.
>>
>> KVM also configures PMUSERENR_EL1 in order to trap to EL2. UEN does not
>> need to be set for it since only PMUv3.5 is exposed to guests.
>>
>> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>> Link: https://lore.kernel.org/r/20241002184326.1105499-1-robh@kernel.org
>> Signed-off-by: Will Deacon <will@kernel.org>
>> [cherry picked from commit 0bbff9ed81654d5f06bfca484681756ee407f924]
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> This one doesn't belong in 6.12. It's a feature that landed in 6.13.
> It's only the fixed instruction counter support that landed in 6.12.

Are you suggesting that this patch is not required for 6.12.y backport ?
We need this commit for ID_AA64DFR0_EL1_PMUVer_V3P9 definition. Should
this change be added in the last commit itself in the series instead ?

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8d637ac4b7c6..74fb5af91d4f 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1238,6 +1238,7 @@ UnsignedEnum	11:8	PMUVer
 	0b0110	V3P5
 	0b0111	V3P7
 	0b1000	V3P8
+	0b1001	V3P9
 	0b1111	IMP_DEF
 EndEnum
 UnsignedEnum	7:4	TraceVer
@@ -2178,6 +2179,13 @@ Field	4	P
 Field	3:0	ALIGN
 EndSysreg

