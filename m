Return-Path: <stable+bounces-89835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3E09BCE70
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 14:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23E428378F
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7E01D799D;
	Tue,  5 Nov 2024 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8keVdc9"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0421D6DA1
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730815118; cv=none; b=dKeYKWcUuqvNckV9sWElmOmt8MZQdABWhYUK+If2abQuVfscWf6uhqx3SUIFPJKWNN91vik9rJOSiYhN+deIk7mgEzJ8eu6Kzu//rs1yESsaujYLH3J0SVHoLd5og2rPutFXlFZiviirrhnV2XJavPKTFZ3/+HClMzwiE1LqaoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730815118; c=relaxed/simple;
	bh=V63t4pvhRFbfBGHeJ8KN/yUWANqDhwLslKgn+5Wn2vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndVzoW0wfilofwHtIIL/SZbT9x7xgBxM3qsqniGfhFnTjjhdtV2RH9s58nt/rxq6NSI5f6Er9UrlkquPqXRcgcRaAn6Qx9KZ/01E6eL/uJ8x+Sq6TfafRKCx0iVjzUBjTCyechZVBwJXNeRkAVPkZM4sRzCr/vfsQnjbGMQPFks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V8keVdc9; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb49510250so55810331fa.0
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 05:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730815115; x=1731419915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EcCSA4vz0FwBZVePOHpQk1Nupy1Yh2zKcJd0XIdACvM=;
        b=V8keVdc9daO84+ND7OtsskJVZuF9V6tNtYCTKWi+dneWvdDDljLHL+WIRwyLmW3zEl
         dY7xLw+E4XwKG6qwqlICG/N2EDyAesAdIQSvSdzE8o8HyvLZZ1sTuRv6Fo0///egVl7R
         EK8QLdQY7yBq1PFc6kkWB7tYpRN8ft+UkrV0B805f7gpoa2dd918WwAQh4ZNWmpO56dr
         +RwJXZbDK0qHn/sCJxpj4zJshaGBIBKR70eu3a9DIh0QGCSBYkTRKkP+/i/E6UOB2ymK
         eqEh0KOi9SMt2uLYAUuG7QnbOK0IJk9tj855+1EMaP6ScID/y9/eExMj8JuMT17Ob48H
         sUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730815115; x=1731419915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcCSA4vz0FwBZVePOHpQk1Nupy1Yh2zKcJd0XIdACvM=;
        b=pQGu7wUvrlV0tzF7GyGxH5iToRrRcyJuMNVZpVd1SPzvC+nj+YHUNG9FNCNY8dmPtI
         /P5/zVMfZ8GgzUyS4uefRMUcMgpHfYNpcadNZU5ffyjUG5cRK7FjvXk54PvdEDM39u/+
         k7HbMyXOQlU2Vqkz9v1cx2v7XObU5SzL//2N+b51K21BQmrUnejWr7EYQsySsqrAYqtC
         OkZeLN/ZidxWvuKVWcJD6oI6ax94JJlvDeX0ONJc1c9oqlTQevtp+I9R9OPQNvekzKaz
         babf7A8UKMHkkHPrf49/bTNLLhdI9UfqbFSr9YnP/TU8YKpOMvV9YYgNv25wUksjW8H6
         to4g==
X-Forwarded-Encrypted: i=1; AJvYcCWIOFnP81DdTD26E6J0qaTBLGffW6b6zyNLzgWjPQrA03oMxvY1qo3KkI/PNhZjntQ68/EOa1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCg3XhWh4kH3o+qFQ6KIgJBoIkSHMC6y25JowkIOxg67tnduhh
	4BdEb/0Uuv+nNOtQbD6WUFMnlvC2GS2/EpDcIW9JgOOPmVoFmcrh2HU5uoaLx8lG+qF6TiXxurH
	4m48=
X-Google-Smtp-Source: AGHT+IGiGe2ltuoXZLk1KaJTuzqgfBHcsNoa1UMEXJNNJdEx6qmiUXxLSizaNHVF+37tGwj2h5Wa5A==
X-Received: by 2002:a05:651c:556:b0:2f6:649e:bf5c with SMTP id 38308e7fff4ca-2fdec726444mr87441111fa.17.1730815114600;
        Tue, 05 Nov 2024 05:58:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8c3367sm20261101fa.103.2024.11.05.05.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 05:58:32 -0800 (PST)
Date: Tue, 5 Nov 2024 15:58:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 4/4] media: venus: hfi: add a check to handle OOB in sfr
 region
Message-ID: <mthuolorbcsykmetqpfaaoyuxgjskwvtvtv4mfl235enlq7win@jdhn2s2cgmui>
References: <20241105-venus_oob-v1-0-8d4feedfe2bb@quicinc.com>
 <20241105-venus_oob-v1-4-8d4feedfe2bb@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105-venus_oob-v1-4-8d4feedfe2bb@quicinc.com>

On Tue, Nov 05, 2024 at 02:24:57PM +0530, Vikash Garodia wrote:
> sfr->buf_size is in shared memory and can be modified by malicious user.
> OOB write is possible when the size is made higher than actual sfr data
> buffer.
> 
> Cc: stable@vger.kernel.org
> Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/hfi_venus.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index 50d92214190d88eff273a5ba3f95486f758bcc05..c19d6bf686d0f31c6a2f551de3f7eb08031bde85 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -1041,18 +1041,23 @@ static void venus_sfr_print(struct venus_hfi_device *hdev)
>  {
>  	struct device *dev = hdev->core->dev;
>  	struct hfi_sfr *sfr = hdev->sfr.kva;
> +	u32 size;
>  	void *p;
>  
>  	if (!sfr)
>  		return;
>  
> -	p = memchr(sfr->data, '\0', sfr->buf_size);
> +	size = sfr->buf_size;
> +	if (size > ALIGNED_SFR_SIZE)
> +		return;

Why can't you just limit size to ALIGNED_SFR_SIZE, still allowing the
data to be captured?

> +
> +	p = memchr(sfr->data, '\0', size);
>  	/*
>  	 * SFR isn't guaranteed to be NULL terminated since SYS_ERROR indicates
>  	 * that Venus is in the process of crashing.
>  	 */
>  	if (!p)
> -		sfr->data[sfr->buf_size - 1] = '\0';
> +		sfr->data[size - 1] = '\0';
>  
>  	dev_err_ratelimited(dev, "SFR message from FW: %s\n", sfr->data);
>  }
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

