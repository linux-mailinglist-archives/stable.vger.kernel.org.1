Return-Path: <stable+bounces-139471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C86AA71C1
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 14:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E380D1BC36E9
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 12:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2DA248F46;
	Fri,  2 May 2025 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZmGfClC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B469253938
	for <stable@vger.kernel.org>; Fri,  2 May 2025 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188910; cv=none; b=bodG+4zwwmIpnJcL7xdJsk8Tk/Pz+KwDXu4xkVAjkXM1EfXNfnvPLCeTPZgIFUlSPWTBbd/5D+4XMhG7mKJXEoVameOHKzvb5oVJTFgD5/FbMctkEJAg002XEUlUbaRkh37fkMZE3X4Nn/JSo1EYm9+0EYwgdFouQfKhqMr/tDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188910; c=relaxed/simple;
	bh=uC44g044KcShpYumwGzfPKaaQH0BoggRjBL8awNC4zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkTLgvoGf9RcNypZH4a+fbNUaAz16hO/fRimAnfLcVs3825wm1AALyfqtkQdx7IyUmRLFJGYKfxHGoRRDIOc6LBcMi1GhysJ73coBiPIQl5OcIKA2mNpZ8n4rGq2RLwOThb2ETDR/k4glBK5Oz2KLImqyxSsCEgFizmKflcswZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uZmGfClC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so15182495e9.3
        for <stable@vger.kernel.org>; Fri, 02 May 2025 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746188906; x=1746793706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFKlbhYbOYEqU3Hx7LL1L8k4PnOc/LhcaLrz8KQ4fp4=;
        b=uZmGfClCc6k6ztUAMU3yvHwOaaFLzKN82E85imeept29LiiO9eOAAWDVECLmx7Ke8+
         ebT1bKwCSzl9Gnhn9yWL5MlY4rOD0XUUK3YEgEWAq9hSdvjfwOEeZ3ajevZWlAFZX61M
         3H+RdQMLTwpiGy7la5kLIsNQzANTtf7PxQ+s+X2syiwF0N57IDQzUa2EnbZdrteDDvQo
         NphFQvpSL5ClWP4cR6F+sF2vLFw3ZvsIAOP7xwkZbF4VLiG57/V/iOC8GE9R2helPMAz
         ZYsUMcqvYDbQzNoARKoJLINwIi3OPxSJ9tTKU8C/h3u60z086khAjEZurFNo/05+EkpB
         zSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746188906; x=1746793706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFKlbhYbOYEqU3Hx7LL1L8k4PnOc/LhcaLrz8KQ4fp4=;
        b=cC5wYlYlYCjBUuUtNcwx9OCtxPxGe9KS+rCljvL02gyrSppRwMV7alH488pKlqvMc6
         UV8+xHXfbSsZ630xX3Fv4o84a3LM6gOaFNpkdb1ZRl4U045IUzn7Rpp+kuSPXUVqL1Tr
         hgWQoVFgaFvTIQe1JWs3RNoUN1jhSO4TaMr9/cicZQx/7XntuQKbA5HzmaR/PJsDfdze
         aoYifrLJ94h8c6WyZZESYpQLPO6UDYf5bs1+M3L19JlnXozNyU0dB7P3NZEmQ4lUUv1J
         cp0Pe+GttBzvSSvYNMrcV8+SQxH/LDGU3BbcJIOaLzU6wPgsEnsEWhz6KFz1RXXhveaF
         01iw==
X-Forwarded-Encrypted: i=1; AJvYcCXYCLmTAxAPWQRI1nbxFWBPvZVq2gndPcD/PB/EHhUh4gDlFgG9+g/6bVjJrOpH24uuZWh4ktE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPxzISh6VT7QbMMeNe/htuam07T6lSMEO1lddzmz1eluoZqoWx
	zB6cM1HRM9Jx6JhW9yicr26W3q3yRTvFAEAPYzwP+KoeL/SPQtL7/YH8f/tgtEQ=
X-Gm-Gg: ASbGnct97cwJI31mcRdlRpUskLUJ/0UQab51wGx5JMCPIXEEQ/vcNfixfnXSM1swm54
	mCQjRb6WhjhSlpS8YCk2W8vN8Zs4d+yFW9u77ouTx7UxPz5s1Q+baX9hNTrNAZeyKXEFR/OLhL0
	fj2rOfe3zifbJtAolQEKHOwdBZd81j4E2Zn6hxUjBDQFMk51e2rGj3zmqv8VXF2oCq/c0cRv+aj
	PRGsSVBlvrDh9gIV7yjoYkZaEskYbCWIAwcoeD1ZtCp5pbxjtRx+NYcG+PW/ew03p5TjfXVhIGU
	4yl71IMzGdVUDJ7yyXnQoFDBRZBAkI9hpkUpnotF/M7itKsYRx1NISPs8ae308KijvU2PdwCXI4
	l5GLoqg==
X-Google-Smtp-Source: AGHT+IEkYYqC5HLJDXAnW5gzwBKk2/Wl+3ak0P8p7yEpFGbDPHanEhrJN2oVaPxj/s406NWQ0lakDw==
X-Received: by 2002:a05:600c:1f0a:b0:43c:efed:732d with SMTP id 5b1f17b1804b1-441bbec629emr22778825e9.16.1746188905909;
        Fri, 02 May 2025 05:28:25 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b8a31695sm43591945e9.40.2025.05.02.05.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 05:28:25 -0700 (PDT)
Message-ID: <b5179740-8717-4e5d-8adf-5f6d3f953fb5@linaro.org>
Date: Fri, 2 May 2025 13:28:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/23] media: iris: Fix missing function pointer
 initialization
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 20250417-topic-sm8x50-iris-v10-v7-0-f020cb1d0e98@linaro.org,
 20250424-qcs8300_iris-v5-0-f118f505c300@quicinc.com, stable@vger.kernel.org
References: <20250502-qcom-iris-hevc-vp9-v3-0-552158a10a7d@quicinc.com>
 <20250502-qcom-iris-hevc-vp9-v3-7-552158a10a7d@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250502-qcom-iris-hevc-vp9-v3-7-552158a10a7d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/2025 20:13, Dikshita Agarwal wrote:
> The function pointers responsible for setting firmware properties were
> never initialized in the instance capability structure, causing it to
> remain NULL. As a result, the firmware properties were not being set
> correctly.
> 
> Fix this by properly assigning the function pointers from the core
> capability to the instance capability, ensuring that the properties are
> correctly applied to the firmware.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3a19d7b9e08b ("media: iris: implement set properties to firmware during streamon")
> Acked-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>   drivers/media/platform/qcom/iris/iris_ctrls.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
> index 915de101fcba..13f5cf0d0e8a 100644
> --- a/drivers/media/platform/qcom/iris/iris_ctrls.c
> +++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
> @@ -157,6 +157,7 @@ void iris_session_init_caps(struct iris_core *core)
>   		core->inst_fw_caps[cap_id].value = caps[i].value;
>   		core->inst_fw_caps[cap_id].flags = caps[i].flags;
>   		core->inst_fw_caps[cap_id].hfi_id = caps[i].hfi_id;
> +		core->inst_fw_caps[cap_id].set = caps[i].set;
>   	}
>   }
>   
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

