Return-Path: <stable+bounces-159252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9030FAF5BEC
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 16:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093AD1C44486
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 14:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB4230B9B2;
	Wed,  2 Jul 2025 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iIjCKHzV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E316D2620D5
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468319; cv=none; b=eGzh704HE5IIyHCSeT/2lN7RK9+4MbAHnJAx4+6khBu/LsXKu7KQTkxICoulVAZ4qbxI3dRRR2Ir63ZdqefyuOI5cG4rz2dnVOUExa1bhKsRer3EL7wiUEyFmeg7UgOpUn4goWpQaJGkbvWtN7C5CJmjZe6gYzS+zfwwvmp8oCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468319; c=relaxed/simple;
	bh=jmdo0wtlEM9OGtqiUmj8GSs9s2w3JeA5xOWYKMd/baE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqYQqO2JfnHRIpG8/P13FHwAFbyINqqjAdl/de6E4u9EbRTDz8oJX3mXNwU8CuJHu8MqsfiwCWakqmq/+miE6hoiWrfZ+zU1XC6xwb/I310DmfrJg86grxULnVYsHt3y76dL29RgJWRXQwG/QjAKqhNATq566zzLokc2xTHsB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iIjCKHzV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450cfb79177so42045105e9.0
        for <stable@vger.kernel.org>; Wed, 02 Jul 2025 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751468314; x=1752073114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JO+LYkjBSv6Ibw6vZ1z2UPxJ2+RcrEARZpMlMoEjCbw=;
        b=iIjCKHzVmgD9ddqjWVzRYA66hWINjAVkj+uAh5e+xoNYufqoojFWsAolb4Hh88lmOC
         6pVKTFkGAGwfPBrz2CNnmUoy4+FdK7pbrwdcqPqSgakMPgnljxc1t6XAcaHuNxfLVIiP
         WNszDQbv+Cr6HuqdtqxtX65GUBiEA/+1AV/sa37fntaTI7UznF8Deu1MLQfdGwEKw8P8
         VWea/7OVxY97m+HPrWqMxOzjxpcdufhTElopGmDQBAYKh89NKzZ8Va6tGw/GlzwIq6hr
         jpVAG0D7E6vbWN+Pguxiu/Qxkupnmk+zQjdz7lKnqxHKs5jD12Wu9cEa3rStz0RbcvwE
         9OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751468314; x=1752073114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JO+LYkjBSv6Ibw6vZ1z2UPxJ2+RcrEARZpMlMoEjCbw=;
        b=Z+9TTgdrXFXv6qDIk1145GTSSptnQUk4PAt9H1moct9mXEwz80XCMAMPpr9V2xZoKx
         7JrXyvDZ4Pmwf/gijN4P5kOGyVGn9Di/geohrKbPuEU8zrcH65VOJCJhA/7R5bD6DJOa
         MRl8TSgECVvWzy+UbAKXTPtnE1k/+qRMb9eCGXF+NOpOn5Dl4CkwKdhsVkvgviuShacR
         qjkui4Clp/eEjM6cyVs+hSUOcbM98ASMbA+I8fZhRHOPBaFpqWv7Nle1JFbkecG1sxqe
         c6WSKO7Dkc+LxRRMCNLVh5W52XRloycoPZqeu2leiDtxaDcI06wyrY4PF+uz16t49l6J
         M/Cg==
X-Gm-Message-State: AOJu0YxLjnnLZKaS/naeyPYxW7WqryGIdi4iQI9GioEmOdi0gUSerVhU
	LHaQiMIB2evLMDLYln3sDVjkl/t0EdaeYGIAWz91+zh9ueNX+B2zdRDE8CYvTbwce1I=
X-Gm-Gg: ASbGncsgzOe3m5s605DszqXNIy9Ff130tw98uF4ukT9ra3vjVipaYv7iUiNWv1s1vlO
	muTZPSafXSFk/PBy+TeYckVM2daZE95dfNYkywLYCL18c4Y8ilvvYCynuIgOOXGNgdJBRIkT33D
	CAq8rKpuDlaqC/+alR+34wDTQwHpmyqGhCO+Cu1wJcYTh+W0TCEuqw7Q0AoqpEwd6+Qgmdd37vj
	XEnlQT9JopEztiGeNqF0eA+MFnCOvioXt8CaqNwes7jYcAXsoXhQuQs4LByUPCFkOIoRHRtUcmg
	dWXVB62fkwMiPNL+K+jxPi8ofzqxUa23BzVuakbNxBGzBM+zeprSKKYuVa475HnB/QbI8iIm0FJ
	4dH2+rx2Hi6eN5aPopWLvAEzZKX+A4nD0LrABuKk=
X-Google-Smtp-Source: AGHT+IG8IhnVjdqSTayA9JUM4Fr5GDQ3JacEz/LaBYGYa1zzNjcnf1n3rb9PZrhs50FB927OOVq7Hw==
X-Received: by 2002:a05:600c:6389:b0:450:d019:263 with SMTP id 5b1f17b1804b1-454a370c053mr34926805e9.18.1751468314016;
        Wed, 02 Jul 2025 07:58:34 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a99668c5sm582525e9.5.2025.07.02.07.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 07:58:33 -0700 (PDT)
Message-ID: <8e7e0b5b-28a0-49db-9acc-f3a4c7d90559@linaro.org>
Date: Wed, 2 Jul 2025 15:58:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: iris: Call correct power off callback in cleanup
 path
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250702134158.210966-2-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250702134158.210966-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/07/2025 14:41, Krzysztof Kozlowski wrote:
> Driver implements different callbacks for the power off controller
> (.power_off_controller):

The driver

> 
>   - iris_vpu_power_off_controller,
>   - iris_vpu33_power_off_controller,
> 
> The generic wrapper for handling power off - iris_vpu_power_off() -
> calls them via 'iris_platform_data->vpu_ops', so shall the cleanup code
> in iris_vpu_power_on().
> 
> This makes also sense if looking at caller of iris_vpu_power_on(), which
> unwinds also with the wrapper calling respective platfortm code (unwinds
> with iris_vpu_power_off()).

platfortm/s//platform

> Otherwise power off sequence on the newer VPU3.3 in error path is not
> complete.
> 
> Fixes: c69df5de4ac3 ("media: platform: qcom/iris: add power_off_controller to vpu_ops")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> index 268e45acaa7c..42a7c53ce48e 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> @@ -359,7 +359,7 @@ int iris_vpu_power_on(struct iris_core *core)
>   	return 0;
>   
>   err_power_off_ctrl:
> -	iris_vpu_power_off_controller(core);
> +	core->iris_platform_data->vpu_ops->power_off_controller(core);

Correct.

>   err_unvote_icc:
>   	iris_unset_icc_bw(core);
>   err:
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

