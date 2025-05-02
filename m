Return-Path: <stable+bounces-139468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84217AA71A9
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 14:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684A89C7EC4
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 12:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DD4253F0C;
	Fri,  2 May 2025 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYvtdJzm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE92E246785
	for <stable@vger.kernel.org>; Fri,  2 May 2025 12:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188558; cv=none; b=m5ne45hypnLqs8gnVFfPObsUrNlUs9f7VJQ8x111y3j8J6c7l9KINcg4UdrBr4odo6gpogeoa0dQotbR3q+d1OjUahEjGdQyp9mAHmZXLuVZYXPRfYbRXFC3s+4TnLZr8W7zahldsS3dIVmzB/4aYW3vIC+rCfbaWOkaSzoSIy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188558; c=relaxed/simple;
	bh=GKN/zeU/yMVetfdzvS9ozuLJj3zYNqyKb2B/40dRc0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODdi6j0cfMh1sgyHGIVxz8ZojaDjRIKZU0LpSEQa6j0sIN+6f8X9PDiUGFGdIZe4dFFZbuh1OwLd8OHbgDplXg8PZznPtBWpraaF+9cWqVgvguuiVHDvEE5XEjdCfMlMqK9vj3Z0XgbX4kqGvGpsdpGkhQoLsQxNHbvzz1rn0nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZYvtdJzm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so14123915e9.1
        for <stable@vger.kernel.org>; Fri, 02 May 2025 05:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746188554; x=1746793354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AGAl7iJZhzrMd/4At9r/NfBVUJdFKiTG2vzkbY4stpw=;
        b=ZYvtdJzmbGavJoWIl8GcdrkE7MzoQoyYflFbCUpnPBoAwR96tZlBipxnOcbMduh6sN
         XEWe19C79yIVGr9uskUSyvhEmW3keesVD1YRXJsRx2FopQ96c1XijWeEig/h1uM8lcy6
         1rNWvL99zJHUYRYDelqfjl4Vxj5GEMW0tws7hVfDyNjfVaAPBTHXpcUebceRFrU2exG6
         B82es7vxpWeWuxSQWogaCCRhwhAsS8wQU8QtzwZXAYDAViD20oK9F07wguV+F6tYoiAT
         nt+efd9rGjwP8w8WnJNcN0rbkXI0BzGpSfxrIM5Q5BgnSnLWSPBeNip19V4tx1Dc+BRX
         tkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746188554; x=1746793354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGAl7iJZhzrMd/4At9r/NfBVUJdFKiTG2vzkbY4stpw=;
        b=fjVycy2nr1NdS0nKQu5Hft+oB+SpCMiv7dffY7Rv4TaFptKlnCWTMBZJWrWeOgwPmA
         HMSuUpjxZdDYzPwZJvOfbB0GsZE8fMQQyaJ0Qj/ZlnRIxOwFRORXKpIC/Op2P/esK0Mt
         j4b5pdTu5jJ0wwlXETu8i/nZQCpB85p+p2alqGAS1zxCXHnrpmW0M24ziFsIDfDJsCsM
         aqJxuwRGzjCWv6UcuCxjkpfx25UHsBre7GEKhT/VDXnDVLApRLp21u+d0kkbbjEJfkyz
         MdUCORvl/+zlJ6fT7BbLAt5n/4pbrfroRpCxVyPiy5VETMwBLS5pLdtLCvTJ7kKfV6cf
         HDzw==
X-Forwarded-Encrypted: i=1; AJvYcCUSJ+N5AXyVSIOfNQHDxX3CDkbFpGlIQzZA/n/16sXgldzpWdkdoOlwaMj5jRwfux7z3CGcK+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOUiTkXxrp2lpe3zlHD0XpfyNcmbVxDFg5CK/kvLZcZ/vrGSy9
	jpDZ74/0A7gtCkIKphBDDUy/HJLlY/8w2FYU/zNSziU2B66upFxyis7g90TWOMo=
X-Gm-Gg: ASbGncuDvRu5KMeS5bSX5GgrMu6QlpR7Ne/6Kduq7K1jir5QUf6InCcGgEkgGQYs8xd
	IMXv3sby1bQE3zfgKZRcpoI4fHICqdQHH8G7CAv1rCBPgCgC6jpLkVq6zs49DMcBEvcA07Q2MoV
	xpSEh5FitaqbxeWC2zfvKEO3b8kuH6XRUVvqvaRgHB61P7Ja5AnuVDTxk2ejZQVUVe+xW2jMNXj
	CPzwEyNYOOAgAbuqH1e9HE/S6UVL1AkFuCkBCjZqUW4fEYBZVTnKNqeO5sJR9A2qgXH+FPFIKab
	Oq1wE1k7Dt8WsiogiyuLmr+XUyGP81YQIcfLzdsqg6tPjMrLa8GiDYScYE3RCvwKyENiag/Em4f
	dKNXmd8HkaO5vPNoL
X-Google-Smtp-Source: AGHT+IGAup8pZea6zJCXydbst81V1n8k/rAt9qOxSfiYhbAH8b2I5VdLjLvIPf6UJhHnoRz5UGJn7Q==
X-Received: by 2002:a05:600c:820a:b0:43d:7588:6688 with SMTP id 5b1f17b1804b1-441bbeb30aemr25881475e9.12.1746188554115;
        Fri, 02 May 2025 05:22:34 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2af4546sm90036325e9.22.2025.05.02.05.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 05:22:33 -0700 (PDT)
Message-ID: <250cdec3-1437-4c45-aab1-0428218b9437@linaro.org>
Date: Fri, 2 May 2025 13:22:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/23] media: iris: Prevent HFI queue writes when core
 is in deinit state
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
 <20250502-qcom-iris-hevc-vp9-v3-5-552158a10a7d@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250502-qcom-iris-hevc-vp9-v3-5-552158a10a7d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/2025 20:13, Dikshita Agarwal wrote:
> -	if (core->state == IRIS_CORE_ERROR)
> +	if (core->state == IRIS_CORE_ERROR || core->state == IRIS_CORE_DEINIT)
>   		return -EINVAL;

Instead of checking for 2/3 of the states why not just check for the 1/3 ?

enum iris_core_state {
         IRIS_CORE_DEINIT,
         IRIS_CORE_INIT,
         IRIS_CORE_ERROR,
};

if (core->state != IRIS_CORE_INIT)
	return -EINVAL;

Cleaner and more explicit - declaring the state you must be in, as 
opposed to a list of states you should not be in.

Assuming you accept that suggested change:

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

