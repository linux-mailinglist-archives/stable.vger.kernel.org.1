Return-Path: <stable+bounces-152012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3075AD1C3B
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 13:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D23F3A9E27
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 11:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1775F254845;
	Mon,  9 Jun 2025 11:10:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E5F1FC7E7;
	Mon,  9 Jun 2025 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749467434; cv=none; b=n5s38ar5e08jexyFclHQqErc9XpWihilgcwb37d9u6xra3rYrr3VYNqjrDEulZM4CtJwkNrsoIirr+4QhYqSciZ1fKAvY+c6sBU0pBFLdm7mwAQIJqdm0Hbkw5vZLfEOLrZNVXDOoYaNQrncYe/JLLT8OP6Qo9NmAiLq3Abf62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749467434; c=relaxed/simple;
	bh=OtuITT+i8YfVsB92HRFIK/5RvmgL0pQolfsZtD3LzPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwSvEj0Og7eJUVT16kSmt/Fn0kgiOfMW6HrVhRkMnuobDPocQ6XQTDLchbg3/MkitcIl27Z4am7DJCUfELKMJAD8LTe2jOTbyh+jFSWYao47EoTkWYjLtCJVUhkd4mHxeMSoltzMyu78ySqYYdTi/pzNTzCj4p9hsC45k/hyzZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83909113E;
	Mon,  9 Jun 2025 04:10:13 -0700 (PDT)
Received: from [10.1.39.162] (XHFQ2J9959.cambridge.arm.com [10.1.39.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AB223F59E;
	Mon,  9 Jun 2025 04:10:31 -0700 (PDT)
Message-ID: <5f6085d9-0ceb-489c-89a6-3666be994549@arm.com>
Date: Mon, 9 Jun 2025 12:10:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/ptdump: Ensure memory hotplug is prevented during
 ptdump_check_wx()
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Dev Jain <dev.jain@arm.com>
References: <20250609041214.285664-1-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250609041214.285664-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/06/2025 05:12, Anshuman Khandual wrote:
> The arm64 page table dump code can race with concurrent modification of the
> kernel page tables. When a leaf entries are modified concurrently, the dump
> code may log stale or inconsistent information for a VA range, but this is
> otherwise not harmful.
> 
> When intermediate levels of table are freed, the dump code will continue to
> use memory which has been freed and potentially reallocated for another
> purpose. In such cases, the dump code may dereference bogus addresses,
> leading to a number of potential problems.
> 
> This problem was fixed for ptdump_show() earlier via commit 'bf2b59f60ee1
> ("arm64/mm: Hold memory hotplug lock while walking for kernel page table
> dump")' but a same was missed for ptdump_check_wx() which faced the race
> condition as well. Let's just take the memory hotplug lock while executing
> ptdump_check_wx().
> 
> Cc: stable@vger.kernel.org
> Fixes: bbd6ec605c0f ("arm64/mm: Enable memory hot remove")
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Reported-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
> This patch applies on v6.16-rc1
> 
> Dev Jain found this via code inspection.
> 
>  arch/arm64/mm/ptdump.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index 421a5de806c62..551f80d41e8d2 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -328,7 +328,7 @@ static struct ptdump_info kernel_ptdump_info __ro_after_init = {
>  	.mm		= &init_mm,
>  };
>  
> -bool ptdump_check_wx(void)
> +static bool __ptdump_check_wx(void)
>  {
>  	struct ptdump_pg_state st = {
>  		.seq = NULL,
> @@ -367,6 +367,16 @@ bool ptdump_check_wx(void)
>  	}
>  }
>  
> +bool ptdump_check_wx(void)
> +{
> +	bool ret;
> +
> +	get_online_mems();
> +	ret = __ptdump_check_wx();
> +	put_online_mems();
> +	return ret;
> +}
> +
>  static int __init ptdump_init(void)
>  {
>  	u64 page_offset = _PAGE_OFFSET(vabits_actual);


