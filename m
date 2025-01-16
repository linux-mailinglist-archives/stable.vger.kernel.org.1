Return-Path: <stable+bounces-109251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC90BA13912
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 12:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FE73A7A27
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 11:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAFF1DE4FA;
	Thu, 16 Jan 2025 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="SBylZs2J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35B1DE2B1
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737027250; cv=none; b=VACQTlaizCbLioKsRKShZ9U6tH2lKjWWBc9DUeYkQN4+yjPNQq5NlMNiiELBcq8eRoj4meHKTCQle1O07xNgxs0Rxe5dIcX+q+nI/6ZuKJywmPpHUzkCJrd40l/CAEvxGLg1PqzwGbf/GqcmqIdjyKXvspuVJHljboTOxHRDjYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737027250; c=relaxed/simple;
	bh=hXneXuQ61cYntgNn/sssniG0GrUQ4hSFAcED56KHbH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUHUSgXHgDRVgOXY/wCoKJV1oZnfUX2zoTcvbfMqHJxJQLyULiSEiw7LiYFfOM5SWnTf8QdrqoBRoYxFTnC6r8p6zSgVZ8O+T4j9qtOVXqLAjZYTVsSbZ1gi5VUr2dcS+71N2quJ+FdqOMZHr/+wXfqxq5XKxVVW9TcE56WeBgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=SBylZs2J; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2163b0c09afso12935755ad.0
        for <stable@vger.kernel.org>; Thu, 16 Jan 2025 03:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1737027248; x=1737632048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YktfQbK04MmcrLOtepFIXUYlByhE6kzjeLH7SfhVzM=;
        b=SBylZs2J7hpeLVZwrZt16G7iExemqMiAuJSLkmccRPiEG9QoNUYsGVJehBMyyERSN2
         46/R66vz6hudpyjQEAT5R36uHBV53ne4UTuf5JcYEoB2HwlGlvu4H168ONvfF/Tptxfr
         5V/pMeotn8F7iAIMLdqHTQ6vwg46bq4TNUgodwmjZrdK66uvwSvTo72auwOIZQn2aop3
         JD4nFxk8nOi5MYX4QTbbEyEabaoK0+cJXBl0sEwBZ+FhEfv+FpkOolgRBWB2nm/w0xAp
         mLfEmRLHstZyJ/e/9rwzNVMkQLhyLTM02v5wpxaFWZHl40VnsPONSpL6clacJ3wX4Wb7
         KmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737027248; x=1737632048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YktfQbK04MmcrLOtepFIXUYlByhE6kzjeLH7SfhVzM=;
        b=jnfl0y+FbdjqmBLA/5c7bGf/FIpCVuWblS/hse4Agc7/7lP1/i6j3UWKfZj98b/DzS
         60OZU1DIxNyBxVn4Vf7Yz4Qt06psRaH7xPQhinm3uHIjBQc6/vYriVFcFW3TiaEOq5zj
         Yu4jdeTC9C7Ox29X59dKFDqCOLNXXY5qTGI5QrpYGsi2ecqpVsXfhFYqWKxJNLWNdsXD
         gc/ljOtmcUEJsm+nrOCURjLbW3UhtOBKVNCj7Z/d3WKfDFnYu2SCCaopVCEGSidLgtDL
         ofOIBBTwM9lZWk+W2fg7Vvxa9ZebaHaAOfqDIlo7Np/OLTEhVxIaeDyUzbwHHN/vBmMF
         XYsA==
X-Forwarded-Encrypted: i=1; AJvYcCWtkWnqqLzMtJV6T9a5e2Zk+qgIjPktuD1HULkIGrUStIZE/jja16k/OH7Rv1g3BJ/KHu/5+sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPPLW/T0tzAixKdlUddjddXDKougc3oxgeHA8wEj7+ft4mhWVP
	9pCUtu1lpSBrr4yRTuksQdaWqFpeHVuR2f4p280SSa2NlXu3lNdkVFSLUPCyewg=
X-Gm-Gg: ASbGncv+GJBlBtj/DnJiuoUJ/xG3OrWhY91G8Hdn9nwWH2SxZvAoOHDSWXHAFhoA/Hq
	3YAwwG53i1iYe9YCPPD0ZkyRWbo6SyJcSqvc/KZwxpXuLhbN3zafz83XzIwF4P0UnhlYyHW+26u
	UfANf+DK1OmwfozD1rzuF1O/yngAiz+awl48MA3wUG0WZhcnoprXURfQVHBkIrNHRInrB4VlbLz
	oXTqIcHXPa0Zb0MX12bS9Z2EU2+oUIIbSqIKOLizeBm2LY8YXR8oskhgRRr81PFBg9MUFLba7Az
X-Google-Smtp-Source: AGHT+IHn0LVg8saEn8D4DZWe1zUwgh/bi1Q+v/D6XJ0zjNhEGPRiwLuR9bIWFuiS8tWZKmN8T2HC6A==
X-Received: by 2002:a05:6a00:858b:b0:728:8c17:127d with SMTP id d2e1a72fcca58-72d21f2da93mr50495307b3a.8.1737027247871;
        Thu, 16 Jan 2025 03:34:07 -0800 (PST)
Received: from [192.168.50.161] ([180.150.112.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a317b761b9asm11387383a12.12.2025.01.16.03.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 03:34:07 -0800 (PST)
Message-ID: <ad1b01ba-53c0-4adf-aee4-a9bc0ff88ae0@tweaklogic.com>
Date: Thu, 16 Jan 2025 22:04:01 +1030
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: apds9306: fix max_scale_nano values
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, stable@vger.kernel.org
References: <20250112-apds9306_nano_vals-v1-1-82fb145d0b16@gmail.com>
Content-Language: en-US
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20250112-apds9306_nano_vals-v1-1-82fb145d0b16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/1/25 10:38, Javier Carrasco wrote:
> The two provided max_scale_nano values must be multiplied by 100 and 10
> respectively to achieve nano units. According to the comments:
> 
> Max scale for apds0306 is 16.326432 → the fractional part is 0.326432,
> which is 326432000 in NANO. The current value is 3264320.
> 
> Max scale for apds0306-065 is 14.09721 → the fractional part is 0.09712,
> which is 97120000 in NANO. The current value is 9712000.
> 
> Update max_scale_nano initialization to use the right NANO fractional
> parts.
> 
> Cc: stable@vger.kernel.org
> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   drivers/iio/light/apds9306.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index 69a0d609cffc91cc3daba160f309f511270be385..5ed7e17f49e76206609aba83c85e8144c536d17d 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -108,11 +108,11 @@ static const struct part_id_gts_multiplier apds9306_gts_mul[] = {
>   	{
>   		.part_id = 0xB1,
>   		.max_scale_int = 16,
> -		.max_scale_nano = 3264320,
> +		.max_scale_nano = 326432000,
>   	}, {
>   		.part_id = 0xB3,
>   		.max_scale_int = 14,
> -		.max_scale_nano = 9712000,
> +		.max_scale_nano = 97120000,
>   	},
>   };
>   
> 
> ---
> base-commit: 577a66e2e634f712384c57a98f504c44ea4b47da
> change-id: 20241218-apds9306_nano_vals-d880219a82f2
> 
> Best regards,
Hi Javier,

You are correct.
  From iio_gts_linearize() function in industrialio-gts-helper.c
*lin_scale = (u64)scale_whole * (u64)scaler + (u64)(scale_nano / (NANO / scaler));
where "scaler" equals NANO (1000000000UL)

I tested it, no issues. The values did not deviate much as this is nano scale.

Tested-by: subhajit.ghosh@tweaklogic.com

Regards,
Subhajit Ghosh


