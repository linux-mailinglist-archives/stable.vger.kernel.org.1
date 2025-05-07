Return-Path: <stable+bounces-142082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7CFAAE3E2
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 17:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC8AB7B92A1
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 15:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2825728A1E0;
	Wed,  7 May 2025 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IhPIAGv+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362622874E7
	for <stable@vger.kernel.org>; Wed,  7 May 2025 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746630437; cv=none; b=Wo0F94RSg0kOhlTDuFMYCx1T206Vzm8K/sYv4p7r7Ebb7nrVysUr0pAO4SYe753bXKYHwFhLb9qWDDl0z0+KqjGRjIclfFdu1a4HSNENNKaOS+Jyxlwx30XvoY/1raG90wQl0uwg+2LEH5fY4EXKlMQeeHPAhEd/f+blcpAWKhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746630437; c=relaxed/simple;
	bh=pz8ye5e7M9XObP3UChOTHfnACy3PA0Ye6tCjNjm3k0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmnZXsdYV3NQ2RtoVIP1RtEvdGmm9JRIVqZfc6ybFFnTXnr+aQopQ3Z4QTgNopOOl2p7SQfPv75CEcL7kUsT9fKTZsyF4lR5unBa9yUaWdIfV/aeOfgOBYvbmXlQNQ2yU3t79u04rYzWa9smt068LgF7kOI2SUT3jNI6mtN3gZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IhPIAGv+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d0782d787so45115635e9.0
        for <stable@vger.kernel.org>; Wed, 07 May 2025 08:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746630434; x=1747235234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c0SsKd1Kg0MlyI8m8KzDXP/8dIexMnrpuvni7IgTwUM=;
        b=IhPIAGv+BadjeIGmE9UfOxWFUkWWVew1DM+20lDkEAPyw3bPsgAJfHPxdVoWUSxdrZ
         1+JvoTl+WdxMeZtbjCcWLAgldPnfORMZRGmk9VVPzfRI4+HM5+o8uopsh1QptYe0EXYH
         URwlTiNVsWkZmQ+jeA/VeM8bMWBt6RmwOy0o/LGslUGEDOJnhbsrsh+w1JHiB/NfAmiO
         cb1KKERXfe2WOxvU8sIF3BknVc/F6V/+Ui76l2yfmZCdOusXC1fEO0fhrvoRZJQOvamC
         qlLOCbkTNsms/P19BVxtFCfkNqttMzy3iPoXyukpTDW4cH70OQeESqe5mI9NbjnCBGJZ
         6r2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746630434; x=1747235234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0SsKd1Kg0MlyI8m8KzDXP/8dIexMnrpuvni7IgTwUM=;
        b=D5MZrDS+NB22Pk3qBnqJFsFyCXxNamKa0j4xQLs633JRQodG48jKN3jVamzmBKLXHa
         UjmbNTOfA+NffpKi6tfGhnns+ECLA8XvpKc5yr9qfaztghi7/ONnT2zgk24D82qgkipN
         HADX1qs29o6BbYL6Ou1LXWaAB2iF5c1Q5OdOdymEoXzTcuCU4Q8A8Ye1/Rzc21hrlQZM
         H1K6rMJwqJE2s0ecJSeh/ULt2YWXvKmHn3jqXtVW+YyVQPl9Q2+wUqpbM6XVl5xHH4Dw
         fPG5POBkHLEoo/uwZfreGoQ9I9L9V6UklRvhsZGHSg4XDvy2E1A8bGNSA2NpPDvALnz2
         RpZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAXhejFlX9ypnDx5+4PAF0wthDKX/62vzxY2Ab/DdGT4DysNouLk8t5CjKECTaekNvlms3VUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyzBaAH1+6ukGWIKj/Y2J5pitCd7q4I94q7QQ42Ke87X26cqeN
	jsL7m9czVkYOOV60AE2gMtfu8tHsjj2uvJ7XKTCQwlm9vt8MK3z+VPw5gRLxUbE=
X-Gm-Gg: ASbGnctDu7y1sU0k4x29NSFsJWnftRqjnc8cR/czV3H7Hm1uh7Jx8WFZ3nPPXrRGGF3
	XE3IGeLFrxGS7BOH2oycOPGERjRD+wSSdeYhVdkJI3argfx+k21g64jWZdu1aBXKInjVYG5xbCL
	C8/9FLwAlHojC+jkL9/vtUJn5v6DbkRObBXfXIwKCA8tgaKef+eH3nK5GjK+YPK97CeUiJ9yXok
	kWXv9aB0rER43QluvSXHW7SI/RkTiLQBX8f8/sPQRTfcuGtF3EYygGP3nzigRuwpY/e39nL3efY
	y8BnsYi2+kXepaM/kiHQz0tcB8Bc8o1K6AJodKUSvLJ9Ao4Yq6P680TQ5aR4RQawBO8Sbkc2D9t
	CY47e9Q==
X-Google-Smtp-Source: AGHT+IFe/RN371zSOT3geyllQKE/3rmj0Va8MGOVysneZBCiRZTbhKgyS/SuJAtLvsGkoEeFtxE4JQ==
X-Received: by 2002:a05:600c:1384:b0:43d:b32:40aa with SMTP id 5b1f17b1804b1-441d44bc67dmr36585625e9.3.1746630434334;
        Wed, 07 May 2025 08:07:14 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae7caasm17416290f8f.54.2025.05.07.08.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 08:07:13 -0700 (PDT)
Message-ID: <dae06ff6-afd9-46a4-bd37-25bb367ba545@linaro.org>
Date: Wed, 7 May 2025 16:07:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/25] media: iris: Skip destroying internal buffer if
 not dequeued
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Stefan Schmidt <stefan.schmidt@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org
References: <20250507-video-iris-hevc-vp9-v4-0-58db3660ac61@quicinc.com>
 <20250507-video-iris-hevc-vp9-v4-1-58db3660ac61@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250507-video-iris-hevc-vp9-v4-1-58db3660ac61@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/05/2025 08:39, Dikshita Agarwal wrote:
> Firmware might hold the DPB buffers for reference in case of sequence
> change, so skip destroying buffers for which QUEUED flag is not removed.
> Also, make sure that all buffers are released during streamoff.
> 
> Cc: stable@vger.kernel.org
> Fixes: 73702f45db81 ("media: iris: allocate, initialize and queue internal buffers")
> Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

I'll take your word for it on firmware respecting the software contract 
on close() wrt to DMA - however I think you should split this patch into 
two separate patches along the lines of the "also" in your commit log.

1. Skip destroying buffers for QUEUED flag
2. Make sure all buffers are released during stream off

These are two separate fixes IMO.

---
bod

