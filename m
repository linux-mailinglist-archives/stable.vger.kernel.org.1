Return-Path: <stable+bounces-96005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 381B69E01EA
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65670168E8F
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20278207A08;
	Mon,  2 Dec 2024 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GUe85AoL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C9207A00
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141299; cv=none; b=i3e2GRL9gZs6YZHoOz16LXvZEARP3Xiy0/LZMiSe3cywlYNd6EFPvfWDXhbpJqu/52hiMHCgtiDJSejFGvkAntX3OZKWmiG05PRqkoktu0Ub6GcgBHD45riStMPXwcM1CbP7uos0+nvyetKZvr8dLQgP4AbWCfuC6JsTIthtbk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141299; c=relaxed/simple;
	bh=cGAQSWJepBzc0MT/FCsHTfnVoA3MyBRgT1+4kNWkF+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQErDAlM00XhWaNLW6g42Hx67Z0cx5YWm5XwasgNzSTau2vIkIyZwxQQdLJrb/8EHGuT4IkYssk1hipGleN/4yPSnARH5mnsrc2XIFEfZmXQsgOLvOti/n0mCcgLibEl3g5HbssC68GKjon7Of6H+H5/GnFasWiCU7qw2wqdFVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GUe85AoL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434aa472617so34986695e9.3
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 04:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733141296; x=1733746096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1vgAdGJhbCaRsQHQEZj6qz9LHLA0TDdshcMw+CfT8UI=;
        b=GUe85AoLq10mPQKAmqXwklw5rFe3YEMW5lRva/HHjuQfRZx6hh7ljOQJfvxbMoiORi
         9YCH7vw3mJfEdeJkXVu2HqnI4fFSHvOWsk+317eqtwVt/YnIE67yS8nVcuGraKL005mz
         89Td+RPAgQJi0VBT34OoRLXTnY5v3Xp1cvR3LdquxoZa214A8Hs52qM38V9MrpBJD84T
         bZSUSx9JI+DnsMU0Nj9OY2FXNiJyst3oBZQSQPfl4Nid8xGU9awP+CUNm2byvteOEJaU
         PNJ+CpxnLBoNjuyuF8bvKa3OiXVnZTqOy3AfNI6vgVe0y5UMdYMx64XbJNed7FP3DkVv
         uLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733141296; x=1733746096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1vgAdGJhbCaRsQHQEZj6qz9LHLA0TDdshcMw+CfT8UI=;
        b=ppEQZ/cB2uPdh4yjNylTDcUl2qLHxOsJ3AYDQ0FsmQNUeEPBqfJ6NMqu7A7tRWkHT0
         BiK1EIC0gAIggPxEjG/5070kH4vCSxkidOx03f1oestkDo+exsMALwVfLan1ktsWU5C3
         1f4vCR+LDWIxtBf5g3cmBjJ+2pgzkLHGRtJ1miZDOvo3zY/57nR8y2liCZAFg3o+o6Gi
         7AqOlkSMU2YcJLrjCCBm3rO7rKUoF4Mfqj1zgzPWzuai1sA/VAM5mXTj6+PAw0cIpY6K
         NpCLNIjUaUC5uJzbn3xSp9pqkR2CbpWfo+o/mEttiVuEhbbXiO28Gb9xPtT4j032v67E
         Ro/A==
X-Forwarded-Encrypted: i=1; AJvYcCV9SOWe7E+0eVeaZkehZxmdPPU9JP5VoOYpy9WCa2aNUnZTmVy+L02Pbs3NzmfZSy3KrTovZwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR2ppXZRoRSdpGvIYzNdSmGdPwlwD7qjSxkvfawhrDDAI12OQk
	S1xiOIkz38APrraEoe/tcjFdurN/4A3kG5aCb6dR9HSHRLGwojUzFqwwwDlVdyQ=
X-Gm-Gg: ASbGnctn8l1JcTad/J9Xa0u9d8TYJp/IVC9KIzIITeXpWV+74pEwgVGgGpi0hWFx06L
	9JIhWw0h/G+QuoQfxrfjdZhA3rRxfjpar4pqGfnLmc63rNTwV6zLUpbhcsJDXrWjL5IAx9dlJEJ
	RdUTc+alR2UTbliLw9LGbc/fBimkseuSDN6oktEAPJL7Y08srbCWvT/spvJBHBxpE1PwRJqacr4
	vKP67THMTsC8IxY6uoMn+65a2TxxldmKDrCFt5zjt7VL0Byjig3SbSl/E0QCkU=
X-Google-Smtp-Source: AGHT+IHwCI1uRKBu+CoSDtG3FpsX3X/yGCnxOmulEY/MrLWnsn3+gjARG1kvTaE8N/uMJfcAAEFB4w==
X-Received: by 2002:a05:600c:1c8d:b0:42c:bae0:f05b with SMTP id 5b1f17b1804b1-434a9db7e8dmr172697185e9.1.1733141296136;
        Mon, 02 Dec 2024 04:08:16 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d1a90sm180872265e9.32.2024.12.02.04.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 04:08:15 -0800 (PST)
Message-ID: <65002924-3b8b-47ab-aa90-4733ccc2f728@linaro.org>
Date: Mon, 2 Dec 2024 12:08:14 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] media: venus: hfi_parser: avoid OOB access beyond
 payload word count
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Tomasz Figa
 <tfiga@chromium.org>, Hans Verkuil <hans.verkuil@cisco.com>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241128-venus_oob_2-v2-0-483ae0a464b8@quicinc.com>
 <20241128-venus_oob_2-v2-2-483ae0a464b8@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241128-venus_oob_2-v2-2-483ae0a464b8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/11/2024 05:05, Vikash Garodia wrote:
> words_count denotes the number of words in total payload, while data
> points to payload of various property within it. When words_count
> reaches last word, data can access memory beyond the total payload. This
> can lead to OOB access. Refactor the parsing logic such that the
> remaining payload is checked before parsing it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1a73374a04e5 ("media: venus: hfi_parser: add common capability parser")
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>   drivers/media/platform/qcom/venus/hfi_parser.c | 57 +++++++++++++++++++++-----
>   1 file changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
> index 1cc17f3dc8948160ea6c3015d2c03e475b8aa29e..14349c2f84b205a8b79dee3acff1408bb63ac54a 100644
> --- a/drivers/media/platform/qcom/venus/hfi_parser.c
> +++ b/drivers/media/platform/qcom/venus/hfi_parser.c
> @@ -282,8 +282,8 @@ static int hfi_platform_parser(struct venus_core *core, struct venus_inst *inst)
>   u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
>   	       u32 size)
>   {
> +	u32 *words = buf, *payload, codecs = 0, domain = 0;
>   	unsigned int words_count = size >> 2;
> -	u32 *word = buf, *data, codecs = 0, domain = 0;
>   	int ret;
>   
>   	ret = hfi_platform_parser(core, inst);
> @@ -301,36 +301,71 @@ u32 hfi_parser(struct venus_core *core, struct venus_inst *inst, void *buf,
>   	}
>   
>   	while (words_count) {
> -		data = word + 1;
> +		payload = words + 1;
>   
> -		switch (*word) {
> +		switch (*words) {
>   		case HFI_PROPERTY_PARAM_CODEC_SUPPORTED:
> -			parse_codecs(core, data);
> +			if (words_count < sizeof(struct hfi_codec_supported))
> +				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
> +
> +			parse_codecs(core, payload);
>   			init_codecs(core);
> +			words_count -= sizeof(struct hfi_codec_supported);
> +			words += sizeof(struct hfi_codec_supported);
>   			break;
>   		case HFI_PROPERTY_PARAM_MAX_SESSIONS_SUPPORTED:
> -			parse_max_sessions(core, data);
> +			if (words_count < sizeof(struct hfi_max_sessions_supported))
> +				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
> +
> +			parse_max_sessions(core, payload);
> +			words_count -= sizeof(struct hfi_max_sessions_supported);
> +			words += sizeof(struct hfi_max_sessions_supported);
>   			break;
>   		case HFI_PROPERTY_PARAM_CODEC_MASK_SUPPORTED:
> -			parse_codecs_mask(&codecs, &domain, data);
> +			if (words_count < sizeof(struct hfi_codec_mask_supported))
> +				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
> +
> +			parse_codecs_mask(&codecs, &domain, payload);
> +			words_count -= sizeof(struct hfi_codec_mask_supported);
> +			words += sizeof(struct hfi_codec_mask_supported);
>   			break;
>   		case HFI_PROPERTY_PARAM_UNCOMPRESSED_FORMAT_SUPPORTED:
> -			parse_raw_formats(core, codecs, domain, data);
> +			if (words_count < sizeof(struct hfi_uncompressed_format_supported))
> +				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
> +
> +			parse_raw_formats(core, codecs, domain, payload);
> +			words_count -= sizeof(struct hfi_uncompressed_format_supported);
> +			words += sizeof(struct hfi_uncompressed_format_supported);
>   			break;
>   		case HFI_PROPERTY_PARAM_CAPABILITY_SUPPORTED:
> -			parse_caps(core, codecs, domain, data);
> +			if (words_count < sizeof(struct hfi_capabilities))
> +				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
> +
> +			parse_caps(core, codecs, domain, payload);
> +			words_count -= sizeof(struct hfi_capabilities);
> +			words += sizeof(struct hfi_capabilities);
>   			break;
>   		case HFI_PROPERTY_PARAM_PROFILE_LEVEL_SUPPORTED:
> -			parse_profile_level(core, codecs, domain, data);
> +			if (words_count < sizeof(struct hfi_profile_level_supported))
> +				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
> +
> +			parse_profile_level(core, codecs, domain, payload);
> +			words_count -= sizeof(struct hfi_profile_level_supported);
> +			words += sizeof(struct hfi_profile_level_supported);
>   			break;
>   		case HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE_SUPPORTED:
> -			parse_alloc_mode(core, codecs, domain, data);
> +			if (words_count < sizeof(struct hfi_buffer_alloc_mode_supported))
> +				return HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
> +
> +			parse_alloc_mode(core, codecs, domain, payload);
> +			words_count -= sizeof(struct hfi_buffer_alloc_mode_supported);
> +			words += sizeof(struct hfi_buffer_alloc_mode_supported);
>   			break;
>   		default:
>   			break;
>   		}
>   
> -		word++;
> +		words++;
>   		words_count--;
>   	}
>   
> 

I like the changes made here.

Let me suggest you have the parse_something() return the size of the 
buffer consumed or an error code.

If you calculate the maximum pointer instead of the words_count

frame_size = payload + max;

/* Your while can look like this */

while (words < frame_size)
switch(*words){
case HFI_PROPERTY_X:
     /* if the function returns the bytes consumed */
     ret = parse_x();
     break;
case HFI_PROPERTY_X:
     ret = parse_x();
     break;
}

if (ret < 0)
     return -ret;

/* you can increment the pointer once at the bottom of the loop */
words += ret;
}


That way you can

1. Get rid of words_count and not have to decrement it
2. Have one variable words which is checked against the maximum
    size while(words < frame_size)
3. Have the function that consumes the data return
    how much buffer it has consumed, instead of inlining in the
    switch
4. Increment at the bottom of the switch once instead
    of several times in the switch

IMO it would be clearer/neater that way. Please consider.

---
bod

