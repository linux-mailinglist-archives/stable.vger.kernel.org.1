Return-Path: <stable+bounces-89834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 211CA9BCE60
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 14:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D931F227AA
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE691D6DDD;
	Tue,  5 Nov 2024 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqCYQvXe"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE81D6DA1
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730814918; cv=none; b=aYYZXJSkQIGqByYVpR6Y6k5PNTauqBn8MJfIGtjVuea2UsWD5b6OTSU565OK37MqoyPWhz/lTFk2S91CLwg6rDvxDdb+MPE5RiIUdFpTJ8WGTCKurFoHGzlm907tnDjZATYLn8Z6EDMKsXswua0GUjdvaGfwX3tEIB82yXybzvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730814918; c=relaxed/simple;
	bh=q3GUUlKx9/4DSdIfudTo/BHl0hN1/E6WoZ6HBZQcFBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCLyLfx6sFUeF9yA/HmrxmVx8vRsjpqs8Kc1zgE43H33nH3GM8cXwW+t0nmH33TNJ7VL3d4DOiWWSatEki0nSAAJcGyhijZFxddcF66iQ074Q7gRGdLDKX/UCmCSlrYEkC6Z7e27bmee+Wi/DZKluJ3z5SwZFsoL98U6IchN/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eqCYQvXe; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539eb97f26aso3369514e87.2
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 05:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730814915; x=1731419715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYPfDLl1JujNUnzUwabCMz6D5QPnpcJrxkCJPH1YFNY=;
        b=eqCYQvXeHRGvRxdW7FlF+UFkmDn712x9y6/xZvjDPZW18kfuCoG1q4XMpfFuowGLJ3
         F4XDD296dEQCO/C/iuKCwkPKErI9dBWhJeMFx7P1OgKY4ATUg2TphS3tzP4HaH1R8Wnv
         NdDQpfhFnhQGsUmSUoENwpWmdBVFvf/Cy21ouNt4UfIBGfjWOkJQurqz1KdkNA9XjcD9
         jaxq+uQ7keCMJb0qOYRURV/lqe50825ln2WjFyt9LUz93wFMC68s2UrY/OAb6F0zqxqX
         WpvT0uTiRiHZjPBGrS+HytlrzdSBsJONgCnfOZ2PqtenqX+8PEqIpUkS6MofwR0bGT0R
         2H6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730814915; x=1731419715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYPfDLl1JujNUnzUwabCMz6D5QPnpcJrxkCJPH1YFNY=;
        b=RAwbNyblPE/FJ0EKkvCb4FYUTz/PMfApD94lNY08MFIUWBA61ejs8VQxISSqc7Dxd9
         VfqWJd6On0UVN6wOKfwdP23uRjI3pgWKMAIorgWXEzJnWIJnkmzhOUWT1AgCwIo4AknX
         shxNY2pSUN2HcuInpPtcxcn5Kqjd+PxM96RQRpgjRS1rXPs4raomD5u0ZvzvO+U0MDEG
         DD6QoCpEHz6JCZWOBER0CrDLINyweF7UN/SheqhaXwP/WhYtvBcIgNzolXgzEp4kEJgt
         lYeAPXUvhRYdiEvdbb4WyDFsZLygGpCY6NO3HekudsQx1itggOQ0pyCx+xnPsjyUXgRV
         iMdg==
X-Forwarded-Encrypted: i=1; AJvYcCXOT50t466+NRZNsrk+NMRZ5yzeZUD24/wW6MfDC+0+gZB/5shW6thNZmAhXheG99fHg9LT/5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeWrmpBcSG9xxzUxIoZ1Lf4+LwWfMRa2XOeVFd52wSkBhZISQ2
	z75jhQudg7diEUJIeV3MVZiwgRWicfesn9RpiVlSftLAUtUhKVbw7j+SalLmiPE=
X-Google-Smtp-Source: AGHT+IEpdU8rDqLX+DIyNpSfiPybyrFjFo19IbFA9Zw/IdLK8a2VdSMO8JD0bOCCp6sr0LFzmU0S1w==
X-Received: by 2002:a05:6512:e9b:b0:539:fbfd:fc74 with SMTP id 2adb3069b0e04-53b7ed185a8mr13160964e87.40.1730814914500;
        Tue, 05 Nov 2024 05:55:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdcbfa6sm2103558e87.208.2024.11.05.05.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 05:55:13 -0800 (PST)
Date: Tue, 5 Nov 2024 15:55:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] media: venus: hfi_parser: add check to avoid out of
 bound access
Message-ID: <b2yvyaycylsxo2bmynlrqp3pzhge2tjvtvzhmpvon2lzyx3bb4@747g3erapcro>
References: <20241105-venus_oob-v1-0-8d4feedfe2bb@quicinc.com>
 <20241105-venus_oob-v1-1-8d4feedfe2bb@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105-venus_oob-v1-1-8d4feedfe2bb@quicinc.com>

On Tue, Nov 05, 2024 at 02:24:54PM +0530, Vikash Garodia wrote:
> There is a possibility that init_codecs is invoked multiple times during
> manipulated payload from video firmware. In such case, if codecs_count
> can get incremented to value more than MAX_CODEC_NUM, there can be OOB
> access. Keep a check for max accessible memory before accessing it.

No. Please make sure that init_codecs() does a correct thing, so that
core->codecs_count isn't incremented that much (or even better that
init_codecs() doesn't do anything if it is executed second time).

> 
> Cc: stable@vger.kernel.org
> Fixes: 1a73374a04e5 ("media: venus: hfi_parser: add common capability parser")
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/hfi_parser.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
> index 3df241dc3a118bcdeb2c28a6ffdb907b644d5653..27d0172294d5154f4839e8cef172f9a619dfa305 100644
> --- a/drivers/media/platform/qcom/venus/hfi_parser.c
> +++ b/drivers/media/platform/qcom/venus/hfi_parser.c
> @@ -23,6 +23,8 @@ static void init_codecs(struct venus_core *core)
>  		return;
>  
>  	for_each_set_bit(bit, &core->dec_codecs, MAX_CODEC_NUM) {
> +		if (core->codecs_count >= MAX_CODEC_NUM)
> +			return;
>  		cap = &caps[core->codecs_count++];
>  		cap->codec = BIT(bit);
>  		cap->domain = VIDC_SESSION_TYPE_DEC;
> @@ -30,6 +32,8 @@ static void init_codecs(struct venus_core *core)
>  	}
>  
>  	for_each_set_bit(bit, &core->enc_codecs, MAX_CODEC_NUM) {
> +		if (core->codecs_count >= MAX_CODEC_NUM)
> +			return;
>  		cap = &caps[core->codecs_count++];
>  		cap->codec = BIT(bit);
>  		cap->domain = VIDC_SESSION_TYPE_ENC;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

