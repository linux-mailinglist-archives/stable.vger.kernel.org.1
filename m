Return-Path: <stable+bounces-19017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE5884C022
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 23:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A38B241C6
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 22:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223C41BF58;
	Tue,  6 Feb 2024 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZZhFz0F"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226B31C291
	for <stable@vger.kernel.org>; Tue,  6 Feb 2024 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258993; cv=none; b=WgY80lKEANvIVo+uHyhT5i2DpcDwv3VH0qxxofc2A9/9x81FMVON+uiNB/fHjw9OBNr66SSVyvw+SGLWo6xfAZfGVzulEQv1DlKDYf53fFyEel8gxYlrPuL/rqXYJQWEBw8vBVoi+8uj06pg2eYymDewAbEjl7HPTyHjP/PexuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258993; c=relaxed/simple;
	bh=7QrIMERdjq61vUpc9OT4JVGI9Rs0/Mmw9Vd9BvIWxRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKqEdQExYCuE3DzldM+TYV8JnY+jw/v6KyHeunQB9SqIsldX9pMh7TaknpJKbClLbAlDHjdtDM27Bvq3A+CUUtppPn5GfX9x4mVcWJiMDQ0nTTkyCZRslQVVSTsoJvxs4TDBNYP1quPv1porVvnIqkb6Dohm854XrO2uBe9Y5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aZZhFz0F; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41009a16ccdso48875e9.2
        for <stable@vger.kernel.org>; Tue, 06 Feb 2024 14:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707258989; x=1707863789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iRhZMOmAA7TAbkhcDCFrfmA34xC8BxSwITTbUht8po0=;
        b=aZZhFz0FNYNOqWNBZEI+ipBQyMo2dYp8HAWJ6M8r8s40O7n7hp24U1GFxZXhmLVGpA
         cP2E/Poh70k0dJjJK6rOgNQnu6e8/yh7Qre3xnF2kWXFD2puFXcxJlwgn4vWgcg38FpN
         O3UzLI0FZc2LkrU4OVMVLVznSWY+DJOUA0wxueSqISkdGxDXf08g2otmxse2pc7xdVQu
         N2s4bAS7KBT2aD85pu6Si51aERhWWFsQr9/efWoc3EGNl1Q3QpNptcFJ1M8GLB6vjyOb
         hweRv2GZQDwg3lx1JELKmzan8ucUoIzhJOgwTTK4drRo4+/NFZlJARhCb6QylGEqgop7
         J7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707258989; x=1707863789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRhZMOmAA7TAbkhcDCFrfmA34xC8BxSwITTbUht8po0=;
        b=IRKxyanpPVwrtwIdSulJ6VeFr3ChE4rvErG90bUVIK9Tf1IKZNMjvUfXneOSL6M/yB
         nS7UKSVozOHnTqEtwmLpAt3VUalFKfjt/CkmIstzAJk92uMKbjvUGGb1CYWOznjHDug2
         cuxVbb4VR/0r8xkSB1nrFPc6IBfcwDA7Y6QQHPxpcFwiVQs8XZTYAmUcnSq+a66TVoda
         IZAu3Y1FI+Wd+WtBthzNu51it9oTcAw5BtxZfTHjiOAlkpqsBBfNdmtAiAjs9ZfrNeH6
         olIdNKzczxgJqRCX+rq8Zhk/HqbwZx+asB5PL7ech6JxEaa/nMYbrBmgHgZtccHsDbyd
         WQfg==
X-Forwarded-Encrypted: i=1; AJvYcCU7e3ht3Aw32Y/J66AmrFJttwa3NlYelAFCjbMTg0DEAJbfumSIJDcwfIdduTQK9R3a+keOqTKMGYbSTBei/kWym61wjHOa
X-Gm-Message-State: AOJu0YxJqBC7DPgMPCf2vnu4UIf/yGnxOGJbi2TEF52eFk+g1HFy7dWO
	zqIV7PVZBATocCj8SzHwyU+E9X/B2gpIiEZ2Fe7EQqJ6cjQOTtadeFm/DKG0hg8=
X-Google-Smtp-Source: AGHT+IG+M0GeCEMLYAfdfVbjtiqILEHWEct0zaNDN1ZCbuPUKTdgkLnarP4CjTcQuyBjHA/2Vted/w==
X-Received: by 2002:a05:6000:232:b0:33a:f521:7066 with SMTP id l18-20020a056000023200b0033af5217066mr2168070wrz.9.1707258989239;
        Tue, 06 Feb 2024 14:36:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVY4nXap1SU4OIfmVLgiP1qLcGYEnhmtYm/id3EjbIFbKKY79D2JTpAXrkAD/X8SmOhXvtJLB9wDMnyf2RQvUf5sZOPwh+FMXB2szWl9+Hhkv1OkrPk/d8TPLtb892G7TH1YHgbBy56lXH6zrt67l2bMDL0sS+0btQqWeM2l7PoK32CHFKuan6JBw7gZF7r/zBndaBKxw1aJ8dn2/Wu
Received: from [192.168.43.244] ([213.215.212.194])
        by smtp.googlemail.com with ESMTPSA id w13-20020a5d680d000000b0033afcc069c3sm40059wru.84.2024.02.06.14.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 14:36:28 -0800 (PST)
Message-ID: <1ecb3744-7baf-4bdd-a01c-8c87fa0a42b3@linaro.org>
Date: Tue, 6 Feb 2024 22:36:27 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
Content-Language: en-US
To: Joy Chakraborty <joychakr@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: linux-kernel@vger.kernel.org, manugautam@google.com,
 stable@vger.kernel.org
References: <20240206042408.224138-1-joychakr@google.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240206042408.224138-1-joychakr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/02/2024 04:24, Joy Chakraborty wrote:
> reg_read() callback registered with nvmem core expects an integer error
> as a return value but rmem_read() returns the number of bytes read, as a
> result error checks in nvmem core fail even when they shouldn't.
> 
> Return 0 on success where number of bytes read match the number of bytes
> requested and a negative error -EINVAL on all other cases.
> 
> Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvmem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> ---
>   drivers/nvmem/rmem.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
> index 752d0bf4445e..a74dfa279ff4 100644
> --- a/drivers/nvmem/rmem.c
> +++ b/drivers/nvmem/rmem.c
> @@ -46,7 +46,12 @@ static int rmem_read(void *context, unsigned int offset,
>   
>   	memunmap(addr);
>   
> -	return count;
> +	if (count != bytes) {

How can this fail unless the values set in priv->mem->size is incorrect

Only case I see this failing with short reads is when offset cross the 
boundary of priv->mem->size.


can you provide more details on the failure usecase, may be with actual 
values of offsets, bytes and priv->mem->size?


> +		dev_err(priv->dev, "Failed read memory (%d)\n", count);
> +		return -EINVAL;
> +	}
> +

> +	return 0;

thanks,
srini

>   }
>   
>   static int rmem_probe(struct platform_device *pdev)

