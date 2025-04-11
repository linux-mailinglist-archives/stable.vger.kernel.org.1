Return-Path: <stable+bounces-132199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E6BA8526F
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 06:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B170460505
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 04:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3641327C85B;
	Fri, 11 Apr 2025 04:13:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5882046AF
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744344824; cv=none; b=ldsaANC5Eg11rA2/UnmoSZcacLKQsZFt8QnBUyBWZTni9J5UV/vVQkWs0MwGeZ9YOfBA/hiqzM7hGFGLUyn3gf4CMNEvtzp7Rbw+U9MDbFdKUZ7bZ7K9FLLh/5r9+3qdwV5MhUo+oPVwrnrpAMkTagk30UCDN5QcctU6XMklmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744344824; c=relaxed/simple;
	bh=03Nwmt+bjvX7bEk04GnwHEk8Rj+BUlYQAaydgiQCum8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aWJhzj1gVtsi1r48IQfxydG7bAx4B32t4S2iclPsb+E2rjI7YQThzFus8K9oF1uezTtXnFKAMl5C6/aCxT2OM2E2JpeNWvnNAQxDFgDehn/p3ajNFnhpD5hn42ev9wYFqWu9+ovmKPSeLM9khHJM+efAgx3xBMNqFj7Tn5ZB2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CB48106F;
	Thu, 10 Apr 2025 21:13:40 -0700 (PDT)
Received: from [10.163.44.254] (unknown [10.163.44.254])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5F103F694;
	Thu, 10 Apr 2025 21:13:38 -0700 (PDT)
Message-ID: <f1153021-846b-4fb1-8c4d-9fa813f982d3@arm.com>
Date: Fri, 11 Apr 2025 09:43:34 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14.y 1/7] arm64/sysreg: Update register fields for
 ID_AA64MMFR0_EL1
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20250410095210-5dc25849962b4acf@stable.kernel.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250410095210-5dc25849962b4acf@stable.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/10/25 21:24, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> Summary of potential issues:
> ⚠️ Found matching upstream commit but patch is missing proper reference to it

What is the problem here ?

'[]' used to close the cherry picking statement instead of '()' ?

> 
> Found matching upstream commit: cc15f548cc77574bcd68425ae01a796659bd3705
> 
> Note: The patch differs from the upstream commit:
> ---
> 1:  cc15f548cc775 ! 1:  383b94dbb82a4 arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
>     @@ Commit message
>          Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>          Link: https://lore.kernel.org/r/20250203050828.1049370-2-anshuman.khandual@arm.com
>          Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>     +    [cherry picked from commit cc15f548cc77574bcd68425ae01a796659bd3705]
>     +    Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>      
>       ## arch/arm64/tools/sysreg ##
>      @@ arch/arm64/tools/sysreg: EndEnum
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-6.14.y       |  Success    |  Success   |

