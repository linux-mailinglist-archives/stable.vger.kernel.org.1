Return-Path: <stable+bounces-171620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 669CCB2ACAF
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 17:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B198188C288
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53D5254864;
	Mon, 18 Aug 2025 15:21:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3062550D5
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530507; cv=none; b=ki9O2V4Ptkv/ZVOwOWI3+XPTVQhXPo1gfIEvzYzAPhyo4oy8qeTO/ky7mEPokQvHsggvyy4ZvHFit7OEZdnbAC9AkgxDt0FwFxr76D912EIsPK2PrpA2VlJ4iZ8FsHzvMR5wyuZaBGRJKT62W3AERAi45p1BXQnaY0Xg7pWPOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530507; c=relaxed/simple;
	bh=ajF6dI1WEKymvKZQIVA5H5QTnniRbM09c3AZ4+lES7w=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OPjuijHk0ABwU6VMuFo8eP/+9R8IX0sgpE2a2djgM4QQKU+24cKU9EhbEqReJpq+EMU4q2trTeZMvejaHG6ygxP5iCwQvjDiKZL/RzQ0bSYPl1XSxHcmLcB+a8uiPQEsLD/Ghqd3yfH+EGF/6anvv4FHN5YwyC3n0iaF9nEyiH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c5GXx2HCmzdcRP;
	Mon, 18 Aug 2025 23:17:21 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 86F081402C8;
	Mon, 18 Aug 2025 23:21:43 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 23:21:42 +0800
Subject: Re: [PATCH 6.12 222/444] ACPI: Suppress misleading SPCR console
 message when SPCR table is absent
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, Li Chen <chenl311@chinatelecom.cn>, Catalin
 Marinas <catalin.marinas@arm.com>, Sasha Levin <sashal@kernel.org>
References: <20250818124448.879659024@linuxfoundation.org>
 <20250818124457.168346613@linuxfoundation.org>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <559e5f67-0fc9-8c62-4820-7523d9c52f07@huawei.com>
Date: Mon, 18 Aug 2025 23:21:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250818124457.168346613@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Hi Greg,

On 2025/8/18 20:44, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> [ Upstream commit bad3fa2fb9206f4dcec6ddef094ec2fbf6e8dcb2 ]
> 
> The kernel currently alway prints:
> "Use ACPI SPCR as default console: No/Yes"
> 
> even on systems that lack an SPCR table. This can
> mislead users into thinking the SPCR table exists
> on the machines without SPCR.
> 
> With this change, the "Yes" is only printed if
> the SPCR table is present, parsed and !param_acpi_nospcr.
> This avoids user confusion on SPCR-less systems.
> 
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> Acked-by: Hanjun Guo <guohanjun@huawei.com>
> Link: https://lore.kernel.org/r/20250620131309.126555-3-me@linux.beauty
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   arch/arm64/kernel/acpi.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index e6f66491fbe9..862bb1cba4f0 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -197,6 +197,8 @@ static int __init acpi_fadt_sanity_check(void)
>    */
>   void __init acpi_boot_table_init(void)
>   {
> +	int ret;
> +
>   	/*
>   	 * Enable ACPI instead of device tree unless
>   	 * - ACPI has been disabled explicitly (acpi=off), or
> @@ -250,10 +252,12 @@ void __init acpi_boot_table_init(void)
>   		 * behaviour, use acpi=nospcr to disable console in ACPI SPCR
>   		 * table as default serial console.
>   		 */
> -		acpi_parse_spcr(earlycon_acpi_spcr_enable,
> +		ret = acpi_parse_spcr(earlycon_acpi_spcr_enable,
>   			!param_acpi_nospcr);
> -		pr_info("Use ACPI SPCR as default console: %s\n",
> -				param_acpi_nospcr ? "No" : "Yes");
> +		if (!ret || param_acpi_nospcr || !IS_ENABLED(CONFIG_ACPI_SPCR_TABLE))

We also need to backport this preparing patch:

b9f58d3572a8 ACPI: Return -ENODEV from acpi_parse_spcr() when SPCR 
support is disabled

Or it will print the wrong message.

It applies for 6.15 and 6.16 kernel as well.

Thanks
Hanjun

