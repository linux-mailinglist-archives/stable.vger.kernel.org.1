Return-Path: <stable+bounces-154698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B0EADF575
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 20:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942591726AA
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 18:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE533085A0;
	Wed, 18 Jun 2025 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSNy2qHz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1353085A1
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270010; cv=none; b=WjDNuWLtkc7Rq0+IUINiRR+4dgCTeLzBIM7+ItDcPrvd4scYCANyW0FHMc0aQV9F6NFMT2UVstZdwbGRpbPtP5iGp7QhFCbtZPzg1Kdbr8hZJV7R4mIFz3WfG3ZF00TGp6utSH2SDbtqMLiJSbLnN53H6CxkQXBDnThz+KMPDEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270010; c=relaxed/simple;
	bh=4UxIorS9u/2wr6VbykR0LVGJhqyFnyu9BzNhtKoDquM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0tqqeZ61WxMJRECVoUt+SOdULbxf/qPOIvpiC5yhr9U9r+ddzuwsdTI8PoowCXc2x0vzWcUaBUtnF2hMGv9PsLsAv8CgM1qNPrtIMkmEMLhq2SWkQvFDYOrCw5eab8XcOB+f+cmBUCMY/apaUkFX8VLwIlQMLWoCiAni4JbAx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VSNy2qHz; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0290f8686so116294666b.2
        for <stable@vger.kernel.org>; Wed, 18 Jun 2025 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750270007; x=1750874807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVsnoAaBCTIdKKJkVTQB78TAIaC0K0blIS1rLndiaXA=;
        b=VSNy2qHz3HqAZc3Yct9kVXdJ144YYKRxNq+r5Vef6FS9eExk2KdlrSCPpShEmmUJ6I
         gFYUnRyWqppdREUlHgktk5y6zcnotLl40Kc62hmsDsanwWGNte6x95IOCq9GW4mr1Lef
         tm2Fw+7cLLJLgn2qLy3+in0nxZZTYLIq2SmBYSG8Tsos5hjvTYc2x96y3mA+AnwRDZVT
         y3nU8WRcXbL8Cx9xbsiZkVgI9OnKXR0m4J7+lZMqbKgRTzD6TTtmTelhN1FN8hoVfAPl
         GxUFwsVmLWJkHB5TRPsdeSCbQzB6ySqI5d3jfxK3IYhS5wK8QXdJJ/NOiom2tWFDdG7M
         wrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750270007; x=1750874807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVsnoAaBCTIdKKJkVTQB78TAIaC0K0blIS1rLndiaXA=;
        b=RsyUBXUJ6xGJx5Q0y/LMoETLiJTiVXPx8ivGNiBIjsS/OyUtEHvrSftOJCynMDfWwm
         0fcJBOujadyvSlYftoZHkOYq3jwpO5kxeQoyBRRseUM7O/plsCNf8NmZIzoIkR+/kQh/
         fvipT0ryag+MInNd5B6/qxjQdyZ1BfU8Yf5fFxrmd1v+d8BgmpLxDpuoqIYtgOESbWrG
         M9pX0e49ITD36UQARCnTrIXouT99Fas0IHV/qHI49yJHhFDj9FY54rPsjwsW8eS4bxK3
         FoQV7mVhAmhGPmO7ibMI3e3bYPb5TeQMUQQFgwATnMgX8AC7+cMFlLp69mZJG5FgDNSZ
         Flmg==
X-Forwarded-Encrypted: i=1; AJvYcCXUIiChigNp0/ua2XSjT+zz6nfnmN7j+W5VlTRaIP6q4v5s6JbgidmK875j0lvMUoTFqEkVjTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlSEWQ5ExcT6LsKZtslu5XSDgYydR8xWUwIj/kUA2kYL9sEAIi
	jnRONMWHuZePJ+0Nken9fRns+1P4FJx9CqMzWYSVlpqAatzckb98Az/cTHhgE7rLBPU=
X-Gm-Gg: ASbGncuv6eNwvIua0qA9xunamAoDqL2nChHRxZgY4IIEG1i2boG/sZvdfICo3OntanF
	e9szc+TFmZ7n7NRVFfmOt2XumurNtQFIZ/BSUfc1t8wxZQKiyE2HdHB6wrKA6aNqmc5/zjo3Hzw
	hAHHKrbpDzw8JW/BE18IHA6N1bOMTBf8dbUl/xOnyfdFyVjDtWwsyp5rYPlXkjuT1PwtkbEceKg
	LG71QSHIHeDwNAy8vFJHMAMSu2XAhQErePYxRZL9xXVmorSCz2ckTo9rChrSabdj8Rg9ao7OqKs
	MjRolkOYIxxpJ6c3tGSndx2kFlntf0JJvkfEdxCIoQH+lTVedDdU7GeYEGBgaL7cqjAiOnGWRSY
	Tojy3r1DxxB9DXDhcthr5zG1c8OUpmEVOMm3bGlmgCbcvJHA82eI=
X-Google-Smtp-Source: AGHT+IHf7Susr5VjmYbzL3tuCAynwWMlblBJ1gw7Rc53j97yh7bCjJFvjkknlqgE5T/JBDjzuzcbqw==
X-Received: by 2002:a17:907:2d26:b0:ad2:4b33:ae70 with SMTP id a640c23a62f3a-adfad43868bmr1934234366b.31.1750270007014;
        Wed, 18 Jun 2025 11:06:47 -0700 (PDT)
Received: from [192.168.23.225] (ip-037-024-206-101.um08.pools.vodafone-ip.de. [37.24.206.101])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec8158d8esm1090533766b.5.2025.06.18.11.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 11:06:46 -0700 (PDT)
Message-ID: <a91ca229-0603-4385-9f9e-01f3c3ede855@linaro.org>
Date: Wed, 18 Jun 2025 20:06:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 296/356] ath10k: snoc: fix unbalanced IRQ enable in
 crash recovery
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Caleb Connolly <caleb.connolly@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Sasha Levin <sashal@kernel.org>
References: <20250617152338.212798615@linuxfoundation.org>
 <20250617152350.087643471@linuxfoundation.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250617152350.087643471@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/17/25 17:26, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Caleb Connolly <caleb.connolly@linaro.org>
> 
> [ Upstream commit 1650d32b92b01db03a1a95d69ee74fcbc34d4b00 ]
> 
> In ath10k_snoc_hif_stop() we skip disabling the IRQs in the crash
> recovery flow, but we still unconditionally call enable again in
> ath10k_snoc_hif_start().
> 
> We can't check the ATH10K_FLAG_CRASH_FLUSH bit since it is cleared
> before hif_start() is called, so instead check the
> ATH10K_SNOC_FLAG_RECOVERY flag and skip enabling the IRQs during crash
> recovery.
> 
> This fixes unbalanced IRQ enable splats that happen after recovering from
> a crash.
> 
> Fixes: 0e622f67e041 ("ath10k: add support for WCN3990 firmware crash recovery")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

If fixing my name is acceptable, that would be appreciated...

Otherwise I believe this patch makes sense for 6.6

Thanks,

> Tested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Link: https://patch.msgid.link/20250318205043.1043148-1-caleb.connolly@linaro.org
> Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/net/wireless/ath/ath10k/snoc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index 2c39bad7ebfb9..1d06d4125992d 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -937,7 +937,9 @@ static int ath10k_snoc_hif_start(struct ath10k *ar)
>   
>   	dev_set_threaded(&ar->napi_dev, true);
>   	ath10k_core_napi_enable(ar);
> -	ath10k_snoc_irq_enable(ar);
> +	/* IRQs are left enabled when we restart due to a firmware crash */
> +	if (!test_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags))
> +		ath10k_snoc_irq_enable(ar);
>   	ath10k_snoc_rx_post(ar);
>   
>   	clear_bit(ATH10K_SNOC_FLAG_RECOVERY, &ar_snoc->flags);

-- 
Casey (she/they)


