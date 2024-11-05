Return-Path: <stable+bounces-89813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854369BCB01
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 11:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73E11C223DC
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 10:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AA91D3633;
	Tue,  5 Nov 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikfewV4C"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB04B1D3195
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803889; cv=none; b=Uz3KmZHNzgLev7nEtBqI8rTj/MMr9Drwnps+pVe5OnTxbDNhqPbFwtcwryA9TJu9lIwUr4DN8MRAfI3PU3qdT2R0CvHiJHOu2JJ+zCarqTClL1DQAWVtseRj3m4qpKYmgzTRlbxBluo8w52yT3Rcf4jAzIMsLLlqjtCLswt4iRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803889; c=relaxed/simple;
	bh=HD+BgOOVBl5mx7chCMOpk4RtL2B+f8ert3pkr1zMpqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxGeur5hVIjd7bXciPrZWCum8RExpEey1PEhyS0mYnIfeJBRuYccL8sYyAoF1IZ1ju3BPfZUUAJVDMW6XctSgQ/eeQNHKMGsut34cVllB9JZ75C5mHER1CjW22hkeyw5S0kMIQHuLOyg8D5TWDIKr75f7/ITPLmPDH25+afwwYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ikfewV4C; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so62766045e9.2
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 02:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730803886; x=1731408686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ATNs/B/w+2yp0EYeoeJF01EDXlRzVZxzeXpZEXEEfY=;
        b=ikfewV4COefm9gwaIO0IxX3dbvV2S1d9cgPiGAJMVw2DFMm9voM9DE0lpEL+Me6AYl
         j7akomgGodRuAvryorhtNuFXzdFfAOX4qxEdVl4vxynWy8V4QdZphz5bdDy8JKEoT8Me
         ksWHuPDWGniPKqTT9/l2ekyjoxKwgLalxsLGfdlqAb5zNFwX+VMpVzsi/emgy9Jk+6dJ
         7/zK+xbnfMIRTmSDPaW6sJiI7fDuTfzOUkXecz1UaQIy/JTTWeL9/ejQaG+FzJfUE8bd
         Nfo49EWgcFAb701SbNqiUuTt2iT42xkfRk4Qy7GViIHP1q8Mls5yCRaUUlD3AR6ZPUNt
         2Rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730803886; x=1731408686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ATNs/B/w+2yp0EYeoeJF01EDXlRzVZxzeXpZEXEEfY=;
        b=wCUc6EqiTa1ZnZy00WyHUjE6oNKy2Czs/P+Z+xll+25SFsLEnrxcmzcuCo1S9WSm3n
         fHcnOYmNSQ3A2/RSi50sF3Li+mBAQNWuRjm85Yp6Vd2Jjuuizq6rV3ZBoN/F2Jwd04LU
         rfNUbdEw9q1zFh5IPu4FiyAqHhaIy0kPmaBhDLy5vs28bIKGoUT3maG5aasajwEtwEhC
         ce9/oSp4LLq/130R4tncjmgDNtWav7aNjEjapG0nYHlWRC8nKXrYGpdAxQwQvQZwzg6k
         +VZvJBnvpxvvgfyMEFXKBOEchaJzG13opZYnHZaM3V5A4/2agtkZ9fZSHQsPdbdZmv6t
         n4TA==
X-Forwarded-Encrypted: i=1; AJvYcCUpQUSfCBWgdjxB51t7F6rcVpESyCG+UXdHx0kYFlvbzwZR0JQP4t1uqCMq0DsJRfrOeyNuvbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnGQvMHidX1GN5AgX8mFmtB9Z2rsdCgFLA2MYiMRYiSOSRLs5b
	FA4K3Oc6yIOoak0Ls9Eiw/5pTodQ65qqpNits72R3maJEllM86SKkQH74pvos4U=
X-Google-Smtp-Source: AGHT+IH71ZuNZKuI+PZhGTdJo4OsIY4DbJKX5pqqVUQT1HsIyvod98087dQv/2ssVzIfDzdbe8PZUg==
X-Received: by 2002:a05:600c:1d1e:b0:431:604d:b22 with SMTP id 5b1f17b1804b1-43283255922mr160211525e9.16.1730803884606;
        Tue, 05 Nov 2024 02:51:24 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116af7esm15800883f8f.103.2024.11.05.02.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 02:51:24 -0800 (PST)
Message-ID: <640fe933-078d-4bf5-815c-7db0eb8b9de4@linaro.org>
Date: Tue, 5 Nov 2024 10:51:22 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] media: venus: hfi_parser: add check to avoid out of
 bound access
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241105-venus_oob-v1-0-8d4feedfe2bb@quicinc.com>
 <20241105-venus_oob-v1-1-8d4feedfe2bb@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241105-venus_oob-v1-1-8d4feedfe2bb@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/11/2024 08:54, Vikash Garodia wrote:
> There is a possibility that init_codecs is invoked multiple times during
> manipulated payload from video firmware. In such case, if codecs_count
> can get incremented to value more than MAX_CODEC_NUM, there can be OOB
> access. Keep a check for max accessible memory before accessing it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1a73374a04e5 ("media: venus: hfi_parser: add common capability parser")
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>   drivers/media/platform/qcom/venus/hfi_parser.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
> index 3df241dc3a118bcdeb2c28a6ffdb907b644d5653..27d0172294d5154f4839e8cef172f9a619dfa305 100644
> --- a/drivers/media/platform/qcom/venus/hfi_parser.c
> +++ b/drivers/media/platform/qcom/venus/hfi_parser.c
> @@ -23,6 +23,8 @@ static void init_codecs(struct venus_core *core)
>   		return;
>   
>   	for_each_set_bit(bit, &core->dec_codecs, MAX_CODEC_NUM) {
> +		if (core->codecs_count >= MAX_CODEC_NUM)
> +			return;
>   		cap = &caps[core->codecs_count++];
>   		cap->codec = BIT(bit);
>   		cap->domain = VIDC_SESSION_TYPE_DEC;
> @@ -30,6 +32,8 @@ static void init_codecs(struct venus_core *core)
>   	}
>   
>   	for_each_set_bit(bit, &core->enc_codecs, MAX_CODEC_NUM) {
> +		if (core->codecs_count >= MAX_CODEC_NUM)
> +			return;
>   		cap = &caps[core->codecs_count++];
>   		cap->codec = BIT(bit);
>   		cap->domain = VIDC_SESSION_TYPE_ENC;
> 

I don't see how codecs_count could be greater than the control, since 
you increment by one on each loop but >= is fine too I suppose.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

