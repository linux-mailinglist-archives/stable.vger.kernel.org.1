Return-Path: <stable+bounces-192856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD56C444E9
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 19:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDFA188A028
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 18:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F416226CF1;
	Sun,  9 Nov 2025 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lplzJktL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591191F4174;
	Sun,  9 Nov 2025 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762712999; cv=none; b=ppphssfqQPsS/tb215T459yRk0AXOPo5f9jtNB/PYnDX5Kr+/wYdV4tNWd4ygX3LJlTIrpsnLgpijgXsvF3TNmySY3Vp/tseg9jOnjid5LXwbmfP2MwDLMsS+Ex9sCZXfaKX/sy9g/PjvlzlgyJNYnYfCHDge2TvhuNQxdiBYeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762712999; c=relaxed/simple;
	bh=mHR/ho0o0u86I8iOcC4+T6OlKLMAwI9YRhfp+RQtWAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bzkxvq6NoDOoOdyQKM2st3fvnQM9To1I5/0AMNMUHjgxzfiV76kglcrTASNbIZeoC5pLSbtd7z5iyQSJsibY+x6zgvi4W3Hszz2unLMjog7kpI0z02Ae5+5iw0eun3d+/g/6Hi0Iotv9eOo3X1Bhq31+ylrPodmt+x8wcSx5eK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lplzJktL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEB3C4CEFB;
	Sun,  9 Nov 2025 18:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762712999;
	bh=mHR/ho0o0u86I8iOcC4+T6OlKLMAwI9YRhfp+RQtWAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lplzJktLl3LH4ONQH5sTX/jp4B8Z+fFdmrZ9DoWqp2YXCvagQOJgRK/JtJ4qCvOs9
	 51xoMPIz0tOWFsf+r35ElfkBC1jRqM6mEvCiQMiFaIK5nPV7qMq6doYgwzg3NvcNTX
	 fz5WYCy83kxdqi1saHPriwgjljGKd6B/8Gp7nt3cF5D6MjS65kaMXCgBAdo9IEORqe
	 o+2mgr5dFpwlqavKzh4dKy+VM08HHMt0yhtcoonJJoQbb9liVQDg1skNclugWhSgqA
	 0gSmI3BaLJ5Jb7FLgIdIw1+/qJiwviAD8hJHbTN27o3KZIlnpL1n4RJmdEiMXGVCxV
	 adGjNt01NH+yQ==
Message-ID: <cac46c65-4510-4988-8ba2-507540363ad4@kernel.org>
Date: Sun, 9 Nov 2025 19:29:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] w1: therm: Fix off-by-one buffer overflow in
 alarms_store
To: Thorsten Blum <thorsten.blum@linux.dev>,
 David Laight <david.laight.linux@gmail.com>,
 Huisong Li <lihuisong@huawei.com>, Akira Shimahara <akira215corp@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030155614.447905-1-thorsten.blum@linux.dev>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251030155614.447905-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/2025 16:56, Thorsten Blum wrote:
> -	/* Convert 2nd entry to int */
> -	ret = kstrtoint (token, 10, &temp);
> -	if (ret) {
> -		dev_info(device,
> -			"%s: error parsing args %d\n", __func__, ret);
> -		goto free_m;
> +	p = endp + 1;
> +	temp = simple_strtol(p, &endp, 10);
> +	if (temp < INT_MIN || temp > INT_MAX || p == endp) {
> +		dev_info(device, "%s: error parsing args %d\n",
> +			 __func__, -EINVAL);
> +		goto err;
>  	}
> +	/* Cast to short to eliminate out of range values */
> +	th = int_to_short((int)temp);
>  
> -	/* Prepare to cast to short by eliminating out of range values */
> -	th = int_to_short(temp);
> -
> -	/* Reorder if required th and tl */
> +	/* Reorder if required */
>  	if (tl > th)
>  		swap(tl, th);
>  
> @@ -1897,35 +1870,30 @@ static ssize_t alarms_store(struct device *device,
>  	 * (th : byte 2 - tl: byte 3)
>  	 */
>  	ret = read_scratchpad(sl, &info);
> -	if (!ret) {
> -		new_config_register[0] = th;	/* Byte 2 */
> -		new_config_register[1] = tl;	/* Byte 3 */
> -		new_config_register[2] = info.rom[4];/* Byte 4 */
> -	} else {
> -		dev_info(device,
> -			"%s: error reading from the slave device %d\n",
> -			__func__, ret);
> -		goto free_m;
> +	if (ret) {
> +		dev_info(device, "%s: error reading from the slave device %d\n",
> +			 __func__, ret);
> +		goto err;
>  	}
> +	new_config_register[0] = th;		/* Byte 2 */
> +	new_config_register[1] = tl;		/* Byte 3 */
> +	new_config_register[2] = info.rom[4];	/* Byte 4 */

How is this change related?

>  
>  	/* Write data in the device RAM */
>  	if (!SLAVE_SPECIFIC_FUNC(sl)) {
> -		dev_info(device,
> -			"%s: Device not supported by the driver %d\n",
> -			__func__, -ENODEV);
> -		goto free_m;
> +		dev_info(device, "%s: Device not supported by the driver %d\n",
> +			 __func__, -ENODEV);

Do not introduce other formatting changes. This patch is already
difficult to read.

> +		goto err;
>  	}

Best regards,
Krzysztof

