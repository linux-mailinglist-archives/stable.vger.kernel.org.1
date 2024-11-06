Return-Path: <stable+bounces-90102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 275989BE42E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 11:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5904C1C23A24
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 10:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797C61DDC0F;
	Wed,  6 Nov 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oiGmJ5CE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA0D188CAE
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730888611; cv=none; b=FmYBVTYNyyTTNcyPZ1otCZfXjA1aQPXFXMeWVk42GtsT9113uR8KZn+QaOI3LYhjB90ZwS+T3u9yEREUN4bLpYSmpSPi8kfiK6NnRpsnbdkKHNEG391fHmoKOwfjYXhL/VivuWaTgj4PkqOPHlKUmyU8APrzU/BQip0A/ig8KGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730888611; c=relaxed/simple;
	bh=5ZTdlscXjwXdZc28p/Of+HAHBUGlSUNLJL2+POeD/0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7tl8FvzMO/6bJWJuX0+fuE3VTnzwcwVFBqZXxrQN8bHScBhaiOD0U5BuAnccVdzQ4W2ByE78o0xS6wWmA9GvH72DKxnEVubF1BeDUy8MPEdoAwLh9fnFf0eu7XOIJjrJPEDnp1Xmha4KoGqXf0c7ZRsiBy6sCbJOK25IRq6dlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oiGmJ5CE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so4270898f8f.2
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 02:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730888608; x=1731493408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=alvW05AqLZBKVkpX7PrdplTn/4fsq+k1H0ntLD4wbXM=;
        b=oiGmJ5CEao4H6rKyhsxFpBjCTur5f4gOHB+/e6XUgD3noEyw41iKZGX7HYDd5g0GHw
         UzvV4yb4kOzQvXHGlh8wtFU/8LCZs8C63ZsLmO6EDihFOoc8fgZY6mDh3yd+p8ZzEhTB
         H2+yOAKGPNw2IIB0JAf8nng/IvRQBabEZrIOweUm1EeNZMYLMP1sOckai1KCF+gJOZ2v
         AsNU1I+tdVe5RBEoXn1tzxSsM2phQCIR0wFChh3gbnXdBzrg1EjjyvwE18anJ8KVlUnC
         xPKdCtx6IOPMWr/gk+rzfRmjFbrTg/BDLOVmz5QEo53HENphwDVA0Jj9nT2abnNgFMXP
         nUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730888608; x=1731493408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=alvW05AqLZBKVkpX7PrdplTn/4fsq+k1H0ntLD4wbXM=;
        b=gEEq8esVmJvxpC7rxhPVewtg8aeFWQr3sX7kl2/V3Nqatyx9pv9xTS3chZmf0cfgrL
         CpL4Fb3b0BQIv/KKnq4GP7EkpjRVVTbMcPcGmYhOIoVgBUba6c0o06MKbJ/+Hy+UQMzi
         IYzEYDrUrqq3bFzmOfiCbr9Wv5pNoTjTyJIfNRadPNyb5+WsrnFyrAIgJzGoVtxD11D5
         K6xW6Lx43CfGSFPzuF46wkxO01YpZ8c8HkBquPuK1Yf2HUPOKTZ5M2JM8rGFbGaTag5d
         C/lvHgPZ8UAz24ajeuttV2NCkl/b5klfuHPt1f7SS1zOXSciePcQojIT80g98eFoJQPd
         onZg==
X-Forwarded-Encrypted: i=1; AJvYcCVCsdDujjBgOmcY/HSOShqy5UA6sG+RfZTk0zSF+40dPYr4NXWlZyTvdBopJpWdqP2OdGVi4SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEtTPElPcDUaxdck4snofUMgcz9OOnh3aeU1aVcGUsAW/SyCM8
	r9LdgQC9kObQSQHeRcDtn/UkUNDv2BxXUqAhXotbNyZ59bHXADriP0GqhBwZfRo=
X-Google-Smtp-Source: AGHT+IFM/sNFa+KEx8YfPwmIWtaTMMW7EIUGwvTNJkiyP0jY1dX7JPo3+l8pDyMtrZbP5YVgM2SUvA==
X-Received: by 2002:adf:f28f:0:b0:37d:4b73:24c0 with SMTP id ffacd0b85a97d-38061190da2mr24474893f8f.35.1730888608072;
        Wed, 06 Nov 2024 02:23:28 -0800 (PST)
Received: from [172.16.24.72] ([154.14.63.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e61f9sm18666123f8f.58.2024.11.06.02.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 02:23:27 -0800 (PST)
Message-ID: <d39c7613-fda1-417c-a205-daddbc378bc3@linaro.org>
Date: Wed, 6 Nov 2024 10:23:26 +0000
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
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241105-venus_oob-v1-0-8d4feedfe2bb@quicinc.com>
 <20241105-venus_oob-v1-1-8d4feedfe2bb@quicinc.com>
 <640fe933-078d-4bf5-815c-7db0eb8b9de4@linaro.org>
 <7f350d73-65dd-097e-8b4a-e9a23472aa28@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <7f350d73-65dd-097e-8b4a-e9a23472aa28@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/11/2024 07:25, Vikash Garodia wrote:
>>>            cap = &caps[core->codecs_count++];
>>>            cap->codec = BIT(bit);
>>>            cap->domain = VIDC_SESSION_TYPE_ENC;
>>>
>> I don't see how codecs_count could be greater than the control, since you
>> increment by one on each loop but >= is fine too I suppose.
> Assume the payload from malicious firmware is packed like below
> HFI_PROPERTY_PARAM_CODEC_SUPPORTED
> HFI_PROPERTY_PARAM_CODEC_SUPPORTED
> HFI_PROPERTY_PARAM_CODEC_SUPPORTED
> .....
> for 32 or more instances of above type

But you do this

           cap = &caps[core->codecs_count++];

for each bit.

Anyway consider Dmitry's input re only calling this function once instead.

---
bod

