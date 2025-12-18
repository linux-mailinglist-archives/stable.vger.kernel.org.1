Return-Path: <stable+bounces-203011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 440A5CCCE8A
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 18:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 328C63029BA7
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE83136D4FF;
	Thu, 18 Dec 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhOYVXGx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67679376BF5;
	Thu, 18 Dec 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073661; cv=none; b=OPqonMQ5ntZF6/cfmHV2Fxf4al3Tqi/H+eA8xWpuoqOz+TiDWJdVikMwCCUCLWfp3BeCFdebApGhrkhrheaXbTN4cYxlrAO+ihUCfuHsXkgGTjqc2omgoUoyLSZH3WnESdlh5H/FLsxf/YYmVRVSvBWDwaAtxrxeYVAhg0u5bwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073661; c=relaxed/simple;
	bh=JiRanrjlwCgapuCfimp4TtHSB9yJdz1fUajbBEpVy4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvxVBnf3Ur9z0znu2QvmmnK1ccF5Q8fw4RzMswzapu9AY8jepqVe4L7n7VtnofMyUKOgowUSWyKQR5fQpt88vhZlrp6bHbZ/TFu27H5rDnQS2PjuFB5H1ymneDHm5C92BonjImgBHGJgUFbv9St7BmfqGxGPnK1kDMwB2v5YhNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhOYVXGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C19C4CEFB;
	Thu, 18 Dec 2025 16:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766073661;
	bh=JiRanrjlwCgapuCfimp4TtHSB9yJdz1fUajbBEpVy4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LhOYVXGxi1b0lDqVFk2XXCGl9jm41PVL1fycrIcYjSWO9mWszwOzABR7V5XK1gPSv
	 AtDqlpJMjjnm7i0TUo7fCaLFvQsT3+8PO+RW675bsDS8NuoUcDQYBgAbd1au3RkzXB
	 wgtY/tmfnKOL4/x+oLBlbCYmvbmudY4meE4PnddrFhrrpfdAOJ0c6cZu+z1+g8ujs6
	 xI6h0Sn28/UmVA8UkHy+ajebMOSG1obSdu+a7GrGxsB8ZR3xMEfalRjwBwsrN/M9w1
	 m8oW7sAuQGB75D/LrzNAwzXX647hazKvG4qgtB8xdqgy9qDzb8jCIHg+UMG/GLIcmO
	 LNfrCHq3e3HNQ==
Message-ID: <ad221cac-0b1c-41f0-9fd9-b2717de3ea06@kernel.org>
Date: Thu, 18 Dec 2025 17:00:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] w1: therm: Fix off-by-one buffer overflow in
 alarms_store
To: Thorsten Blum <thorsten.blum@linux.dev>,
 David Laight <david.laight.linux@gmail.com>,
 Huisong Li <lihuisong@huawei.com>, Akira Shimahara <akira215corp@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251216145007.44328-2-thorsten.blum@linux.dev>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251216145007.44328-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/12/2025 15:50, Thorsten Blum wrote:
> The sysfs buffer passed to alarms_store() is allocated with 'size + 1'
> bytes and a NUL terminator is appended. However, the 'size' argument
> does not account for this extra byte. The original code then allocated
> 'size' bytes and used strcpy() to copy 'buf', which always writes one
> byte past the allocated buffer since strcpy() copies until the NUL
> terminator at index 'size'.
> 
> Fix this by parsing the 'buf' parameter directly using simple_strtoll()
> without allocating any intermediate memory or string copying. This
> removes the overflow while simplifying the code.
> 
> Cc: stable@vger.kernel.org
> Fixes: e2c94d6f5720 ("w1_therm: adding alarm sysfs entry")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Compile-tested only.
> 
> Changes in v5:
> - Replace gotos with return size (Krzysztof)
> - Link to v4: https://lore.kernel.org/lkml/20251111204422.41993-2-thorsten.blum@linux.dev/
> 
> Changes in v4:
> - Use simple_strtoll because kstrtoint also parses long long internally
> - Return -ERANGE in addition to -EINVAL to match kstrtoint's behavior
> - Remove any changes unrelated to fixing the buffer overflow (Krzysztof)
>   while maintaining the same behavior and return values as before
> - Link to v3: https://lore.kernel.org/lkml/20251030155614.447905-1-thorsten.blum@linux.dev/
> 
> Changes in v3:
> - Add integer range check for 'temp' to match kstrtoint() behavior
> - Explicitly cast 'temp' to int when calling int_to_short()
> - Link to v2: https://lore.kernel.org/lkml/20251029130045.70127-2-thorsten.blum@linux.dev/
> 
> Changes in v2:
> - Fix buffer overflow instead of truncating the copy using strscpy()
> - Parse buffer directly using simple_strtol() as suggested by David
> - Update patch subject and description
> - Link to v1: https://lore.kernel.org/lkml/20251017170047.114224-2-thorsten.blum@linux.dev/
> ---
>  drivers/w1/slaves/w1_therm.c | 63 ++++++++++++------------------------
>  1 file changed, 20 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
> index 9ccedb3264fb..5c4e40883400 100644
> --- a/drivers/w1/slaves/w1_therm.c
> +++ b/drivers/w1/slaves/w1_therm.c
> @@ -1836,55 +1836,36 @@ static ssize_t alarms_store(struct device *device,
>  	struct w1_slave *sl = dev_to_w1_slave(device);
>  	struct therm_info info;
>  	u8 new_config_register[3];	/* array of data to be written */
> -	int temp, ret;
> -	char *token = NULL;
> +	long long temp;
> +	int ret = 0;
>  	s8 tl, th;	/* 1 byte per value + temp ring order */
> -	char *p_args, *orig;
> -
> -	p_args = orig = kmalloc(size, GFP_KERNEL);
> -	/* Safe string copys as buf is const */
> -	if (!p_args) {
> -		dev_warn(device,
> -			"%s: error unable to allocate memory %d\n",
> -			__func__, -ENOMEM);
> -		return size;
> -	}
> -	strcpy(p_args, buf);
> -
> -	/* Split string using space char */
> -	token = strsep(&p_args, " ");
> -
> -	if (!token)	{
> -		dev_info(device,
> -			"%s: error parsing args %d\n", __func__, -EINVAL);
> -		goto free_m;
> -	}
> -
> -	/* Convert 1st entry to int */
> -	ret = kstrtoint (token, 10, &temp);
> +	const char *p = buf;
> +	char *endp;
> +
> +	temp = simple_strtoll(p, &endp, 10);
> +	if (p == endp || *endp != ' ')
> +		ret = -EINVAL;
> +	else if (temp < INT_MIN || temp > INT_MAX)
> +		ret = -ERANGE;
>  	if (ret) {
>  		dev_info(device,
>  			"%s: error parsing args %d\n", __func__, ret);
> -		goto free_m;
> +		return size;
>  	}
>  
>  	tl = int_to_short(temp);
>  
> -	/* Split string using space char */
> -	token = strsep(&p_args, " ");
> -	if (!token)	{
> -		dev_info(device,
> -			"%s: error parsing args %d\n", __func__, -EINVAL);
> -		goto free_m;
> -	}
> -	/* Convert 2nd entry to int */
> -	ret = kstrtoint (token, 10, &temp);
> +	p = endp + 1;
> +	temp = simple_strtoll(p, &endp, 10);
> +	if (p == endp)
> +		ret = -EINVAL;
> +	else if (temp < INT_MIN || temp > INT_MAX)
> +		ret = -ERANGE;
>  	if (ret) {
>  		dev_info(device,
>  			"%s: error parsing args %d\n", __func__, ret);
> -		goto free_m;
> +		return size;
>  	}
> -

That's another unusual change appearing in v5. Please pay attention to
differences you introduce between versions, so to what you exactly do.

>  	/* Prepare to cast to short by eliminating out of range values */
>  	th = int_to_short(temp);
>  
> @@ -1905,7 +1886,7 @@ static ssize_t alarms_store(struct device *device,
>  		dev_info(device,
>  			"%s: error reading from the slave device %d\n",
>  			__func__, ret);
> -		goto free_m;


Best regards,
Krzysztof

