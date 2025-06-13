Return-Path: <stable+bounces-152602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4912DAD8250
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 07:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB3E1894BAF
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 05:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDDE222575;
	Fri, 13 Jun 2025 05:09:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB567082A;
	Fri, 13 Jun 2025 05:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749791351; cv=none; b=JgJ+cXR0f9Bd1poLGwhCe8kKBhogx5sqKTM0sj7IFhmeFksvlmR48+elwz2Ybo7iPmVWtOETtcbZ7TckSM3nWQZM6IVnLh5FldDcjCnR2/GxHQGIUd/uJ0flh6qs125sfYM3/J+502yqYoMbEUMXAXbufOUaBskdDV2szBtyqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749791351; c=relaxed/simple;
	bh=uljXu3OjtlOKXiTrLwjCLapjiDP/HCxN+NtIcKqWWlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TuojAwY8FlfyIPyS032IV5u8SdHiSoMKoJnmoaWyLojSPT6W0OMYNEvvfKjFLiD+dcLDmTetzRex4hRubry2Wx9sVmeqhHStGI0e8psqY0GdrDe8ZU6t/BNCkLPdkH0HMDMHco0acwF/LAtK7KXU2XXcBCh1TsQmM1dvuvCRjQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 290A31D14;
	Thu, 12 Jun 2025 22:08:48 -0700 (PDT)
Received: from [10.164.146.16] (J09HK2D2RT.blr.arm.com [10.164.146.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEB693F66E;
	Thu, 12 Jun 2025 22:09:05 -0700 (PDT)
Message-ID: <5c22c792-0648-4ced-b0ed-86882610b4be@arm.com>
Date: Fri, 13 Jun 2025 10:39:02 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/ptdump: Ensure memory hotplug is prevented during
 ptdump_check_wx()
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
 Dev Jain <dev.jain@arm.com>
References: <20250609041214.285664-1-anshuman.khandual@arm.com>
 <20250612145808.GA12912@willie-the-truck>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250612145808.GA12912@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/06/25 8:28 PM, Will Deacon wrote:
> On Mon, Jun 09, 2025 at 05:12:14AM +0100, Anshuman Khandual wrote:
>> The arm64 page table dump code can race with concurrent modification of the
>> kernel page tables. When a leaf entries are modified concurrently, the dump
>> code may log stale or inconsistent information for a VA range, but this is
>> otherwise not harmful.
>>
>> When intermediate levels of table are freed, the dump code will continue to
>> use memory which has been freed and potentially reallocated for another
>> purpose. In such cases, the dump code may dereference bogus addresses,
>> leading to a number of potential problems.
>>
>> This problem was fixed for ptdump_show() earlier via commit 'bf2b59f60ee1
>> ("arm64/mm: Hold memory hotplug lock while walking for kernel page table
>> dump")' but a same was missed for ptdump_check_wx() which faced the race
>> condition as well. Let's just take the memory hotplug lock while executing
>> ptdump_check_wx().
> 
> How do other architectures (e.g. x86) handle this? I don't see any usage
> of {get,put}_online_mems() over there. Should this be moved into the core
> code?

Memory hot remove on arm64 unmaps kernel linear and vmemmap mapping while
also freeing page table pages if those become empty. Although this might
not be true for all other architectures, which might just unmap affected
kernel regions but does not tear down the kernel page table.

