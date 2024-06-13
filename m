Return-Path: <stable+bounces-50406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0DB906557
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27A11C22F6A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC46413C3EB;
	Thu, 13 Jun 2024 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+XNb2Vq"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD9E136997
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264359; cv=none; b=jCCshbVdLxEZ8CAlacz6m4O7M4xVbnjARdhQpp9ephMzSOUoNDU11+Xwexm0vAe2YnouXoZcTwvcMKQeQWToX5o0u5qOOxVfOnY2V45TY4Gtp+vufHcJ6le6ObWJgH5T/mPU0WrkTqCUIoBmQW5UObtRnJSJEKnqyWNf8gO88QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264359; c=relaxed/simple;
	bh=gvd3iJZhXkv3oS3HiOW3qGIdtOu46n2nNHFMDvtAZ4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4t0kK3Ha9DzXuHxs3yFVWnPD1++vBN/FTf0g2i7fwQY58ZCC0Th7HDNN7gUB1HYzzV8ekhIZsJF2+YqehHcXQT0e8MMDl4MSCr08AP8q4zFt9m1VcDYpdpepSWqgxxtqAxZThU4HYIo2l7sMf8ogLfF8HNS6DzW0ceD1xCGar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q+XNb2Vq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52bc121fb1eso1001377e87.1
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 00:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718264356; x=1718869156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oZ8kTSJ2fttE0Jg9Brzhxa9VkzxRO9QjtCb/V2tPU30=;
        b=q+XNb2VqD/glMgMtdcGr7VlsQvaS6QtUDsiPGGXw6pBbsi1GWuOSFTR92gFRodlPdm
         KnelBpeNVgOLXv6lvgwT86ICFh8BUXOQ+ZNRa3fcf8mGTeJuhwNq5/co6yoVrkHOArgR
         SVKevhgENtkwS8upOOT6rLBL7y1l0EYWcGcnVkJXjZV1YzBzJDyrQ4DFrY4OSXKcCwVy
         8xodQqMlsh2FTDxgpQe8Q3GECOy0Na/tpU38D3XYAFbUgixQ8U2YoWj3/EAbze3MJRSZ
         EHu3y+nHJ3eckLT1GifAgn4nxM7yS7pQR/xmYoAHrHd84OhXpH03E2QaHQjeOJXy6XHz
         Nhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718264356; x=1718869156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZ8kTSJ2fttE0Jg9Brzhxa9VkzxRO9QjtCb/V2tPU30=;
        b=lKLtN0OUE9LuIkOUqcypa7TP/dfCqHZS3Oa6ttoxVWG7UbrlihVEgNQhV1aZyT/7sg
         o3eRcG5OxBv4AVRLeJVjIlwHlxHekNPKKtPtcVtjr1OdoJ7wgnRrP3ElrLkp/02h6FAa
         j7YzeKtLU+UukNCBUWkZdZGS9jVe4No92qnD0kvi9nZzRYXMZKqThXxruW6LlsDbjeAf
         chqzTzAwab9lN76c9ql+yTXvzIyfpWv4kUdHdCLOJeC6hwGKVSmQME2KYrjiRu4PlxGR
         497Qao+7ufE+PUC192wrHGf4jLWVz2zo6U7jf9PjIrXLCtrqifFS6Qe08OZQN6uTPHZQ
         id+w==
X-Forwarded-Encrypted: i=1; AJvYcCVbxoq3SwAoSjBdS80m2BVKUN6vLy3WujvH9SHFx4FzPJT5SmSuPUG5No0WJNo3OP8Vv84tQkV/m/9vzjQKVAKLFcsM1YCn
X-Gm-Message-State: AOJu0Yw6m0C9PRMP0Jx5pRli/pkWJNRg29/wOHDKBZJJe8UGMf1ts7a5
	wMdDjCmMOn1qJ6On5alIQE3MGHIQ4I5y+R7RgUaFaVFaZIRxicYdm68fBdHR7hM=
X-Google-Smtp-Source: AGHT+IGcPXEciBUgZAJMu6A19p7a0FAIiSQHe4SAYEBWGWog4rrglEIKAByhDs97NDz3T+Vmd3FT/Q==
X-Received: by 2002:a05:6512:2353:b0:52c:1c56:a230 with SMTP id 2adb3069b0e04-52c9a3b99a2mr2873051e87.5.1718264355932;
        Thu, 13 Jun 2024 00:39:15 -0700 (PDT)
Received: from ?IPV6:2a00:f41:900a:a4b1:c71b:4253:8a9f:c478? ([2a00:f41:900a:a4b1:c71b:4253:8a9f:c478])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282dd55sm117491e87.65.2024.06.13.00.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 00:39:15 -0700 (PDT)
Message-ID: <43d4f973-2768-41f1-900f-a24afe280bc4@linaro.org>
Date: Thu, 13 Jun 2024 09:39:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom_scm: Mark get_wq_ctx() as atomic call
To: quic_uchalich@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com, Murali Nalajala <quic_mnalajal@quicinc.com>,
 stable@vger.kernel.org
References: <20240611-get_wq_ctx_atomic-v1-1-9189a0a7d1ba@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240611-get_wq_ctx_atomic-v1-1-9189a0a7d1ba@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/11/24 20:27, Unnathi Chalicheemala via B4 Relay wrote:
> From: Murali Nalajala <quic_mnalajal@quicinc.com>
> 
> Currently get_wq_ctx() is wrongly configured as a standard call.
> Here get_wq_ctx() must be an atomic call and can't be a standard
> SMC call because get_wq_ctx() should not sleep again. This
> situation lead to a deadlock. Hence mark get_wq_ctx() as
> atomic call.

That's quite a word salad.. could you try to make it clearer what
you're trying to achieve?

Konrad

