Return-Path: <stable+bounces-172491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4595B3223F
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203ADB06B94
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 18:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3FC2BEFF8;
	Fri, 22 Aug 2025 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeQHMJdi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DA12BE62E;
	Fri, 22 Aug 2025 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886933; cv=none; b=SBbHB43EcQfStO8iAILJg+w5TXR3lkbhsjnV1U3SF7pZQScvdVjFFFrmia9H1xoATbxX7FMYulNWJLA/sOi6ByXIJxpIyFB8qCH0DE4GsiGtZHAivj5mXi+aDvKD0lqHJ+/8Tz6XzDm8j9YP4WB2dlBtEk1x+lCJMq2t2/37dt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886933; c=relaxed/simple;
	bh=osV2o6UYjlsQwHXzqzJJ4tgzt89Hql8Y6hnVDqbztsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rimZ3/WrzPQDIGa2huPQEY5NAWCk5oeO4uGQxP0wKewHGNI48i45SXR0TMwTJD2Mc4Il4Zpj7BXkVsY58DVokpUjdNdRw6InxJGKclyoIWE6rBoBjijrorkItLlbeCwpk9UMRo80tcO3e4vSrol1i8DiBpkvaqvaYekdOgJiZ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeQHMJdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C3DC4CEED;
	Fri, 22 Aug 2025 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755886932;
	bh=osV2o6UYjlsQwHXzqzJJ4tgzt89Hql8Y6hnVDqbztsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TeQHMJdig06kIGyAgupEQ/aCVBqkZVloYJhv2Jbyxod8MGw3Mbd28AcbLmaYzi0Ju
	 ZFmldXW6x/3UBK3W51YauY7Yw6RN3HkISR6QkM056NPT+pxls7uYLtwDTf3ZmNT+PF
	 k/pr2j9tplDKMJJjJODTSpfJKjD+Dj0dl0xO5yX4ETGUmttdLPypv3xKzQiZnRJ4y2
	 KeI+1qtORxHjDI9iCEDdcjJHwOBXxYwo7KgJPBdDNS2idAPSRdkWO3hxf5KWhl6aye
	 HWmdFjIJtOEs+df+Um6RPnjz+VbrQwmU6WIpVN/xnF2QwkBXnadTgxBj4FHfXOCUkG
	 FAIgpvDrS6hig==
Message-ID: <bb130ab0-d63c-4273-8778-3a6c4f27143d@kernel.org>
Date: Fri, 22 Aug 2025 13:22:08 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd: hfi: Fix pcct_tbl leak in
 amd_hfi_metadata_parser()
To: Zhen Ni <zhen.ni@easystack.cn>, perry.yuan@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
References: <20250822083329.710857-1-zhen.ni@easystack.cn>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250822083329.710857-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/2025 3:33 AM, Zhen Ni wrote:
> Fix a permanent ACPI table memory leak when amd_hfi_metadata_parser()
> fails due to invalid PCCT table length or memory allocation errors.
> 
> Fixes: d4e95ea7a78e ("platform/x86: hfi: Parse CPU core ranking data from shared memory")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>

Great catch, thanks.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/platform/x86/amd/hfi/hfi.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 4f56149b3774..a465ac6f607e 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -385,12 +385,16 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
>   	amd_hfi_data->pcct_entry = pcct_entry;
>   	pcct_ext = (struct acpi_pcct_ext_pcc_slave *)pcct_entry;
>   
> -	if (pcct_ext->length <= 0)
> -		return -EINVAL;
> +	if (pcct_ext->length <= 0) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>   
>   	amd_hfi_data->shmem = devm_kzalloc(amd_hfi_data->dev, pcct_ext->length, GFP_KERNEL);
> -	if (!amd_hfi_data->shmem)
> -		return -ENOMEM;
> +	if (!amd_hfi_data->shmem) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
>   
>   	pcc_chan->shmem_base_addr = pcct_ext->base_address;
>   	pcc_chan->shmem_size = pcct_ext->length;
> @@ -398,6 +402,8 @@ static int amd_hfi_metadata_parser(struct platform_device *pdev,
>   	/* parse the shared memory info from the PCCT table */
>   	ret = amd_hfi_fill_metadata(amd_hfi_data);
>   
> +out:
> +	/* Don't leak any ACPI memory */
>   	acpi_put_table(pcct_tbl);
>   
>   	return ret;


