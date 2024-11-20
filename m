Return-Path: <stable+bounces-94110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5443C9D393B
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 12:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0217F1F26D9F
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 11:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0309619CD1B;
	Wed, 20 Nov 2024 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xh6euSmW"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE871953A9
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101238; cv=none; b=G0w+Os1tYuXzGVtH2nvOoO1uOiACK0fCrzFQqRRbF67zgcPkSUABdUyWVC51Qy+37KYzJBfV+xY+iM0gNa9rvsV8f58nSpM6XWKtNNNPbr+YGAHMGkbhvMU5iUVqvle//cizfcv40otmDcZ7qXq7b5Y2KyZqSWbnfhnv/0U7q4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101238; c=relaxed/simple;
	bh=2R7MrlSbXdsIoKmQ8B225gvAC/SXbSoY+2vtlQPNGnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8hDJGQICXjylPt8msVfMjDxCbOS0MzP7Ifz+TnC6OKmNzoe6Bl8d8YPc9lRXMqQ1C/SQ8rHRQI1HqcBgozrQTbjGIteIvjb43dUGv12gnx1K9/Ro6Ct19lmSvkYcn8chN//KsQss3pp5kite/su/3qrPYQIcnUYu6/nWsi5/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xh6euSmW; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53da5511f3cso6630397e87.3
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 03:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732101235; x=1732706035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSBDmYSFXuA2s69SSkdK3qaRDlUBpjefVOog6k4GCqA=;
        b=Xh6euSmWSI183aFHWmbJUcgYbM7Z4O1/VFPWRSHd8I1nkw3etu3zRfaJ2RchUv7p1/
         m+QoQF9GilXji8STASehIi4MlaijBwdVrp99EiVv3xG804YAbKob7YH8bcX6G3V/33DX
         je8TVUVDamfu1ouKGm6Lm9iTNhl9oidfrVKHJLwHXjq/QxOb9blKdd58E2pzF5cqdjiV
         LzrVy9Xav5Nu7+tadoxM6AzXe1OMfYrQWt1pVquVt3PDR6oRbKrHJnQWR4bEdvh2dlR8
         0REDI7bohd3lUIi9FnayMGAQKgRjdEdAGjw+3qeESX+19wTqcmEdWobXbtjBGJ3B5N+A
         m4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732101235; x=1732706035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSBDmYSFXuA2s69SSkdK3qaRDlUBpjefVOog6k4GCqA=;
        b=aBpb7HJ6DeEZLKtWGSqSXgFm0TlOJbBhnSwtmtConHQamkec1aNQQ/RhQSFKFwsShB
         7Oh/YweC/aI8W556SHEM1l+m/rRF1NCTlN6nCLt3WPCjZM5hEpvqwpFGAMXQ2BEjWO+9
         jCeiRabEi5OfZDhS37C6ALlm+vD5XcsqN8WdiOf8Ypt/Bh5AUXiBBDoJ83y3q+N9btqR
         FiIOBIIgb+BBF4jMTwajdX5fzwQd3faVrortDsRlJ0wqoqO+uk0VkcN+TuTyjVha4RTv
         Bbj19vM8VbgcyP4phqJhRFWBlLsBEmCpIAOCL7kELA0zwq8nrYbud6uNUt0GJdO+MBgg
         QeOg==
X-Forwarded-Encrypted: i=1; AJvYcCUDHL3q23Y7ASXPgNgIqyBHCmocoxvOCUGaxtYk8UUYpc49soDqCTE6ssCyAQ6D1GYClaVedLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1t34yBIoU9aUVRgp+INtx112nfD3UE9fMYCyyPFDV2XHUBIpA
	nsVnxENujHEQPDyfeVbXhF1sz/lk2+BQlJG9iZ4WNYlsRXY2kF1W6xcQXP6y6kM=
X-Google-Smtp-Source: AGHT+IGYdVlXPyYW57Sact665A1h86qBYlsDUr8EZ6uXwnZYrcEpnGp/EwmAPkJR1t4j3+9iwpyGLg==
X-Received: by 2002:a05:6512:b0d:b0:539:e3d8:fa33 with SMTP id 2adb3069b0e04-53dc13742c2mr907280e87.54.1732101235338;
        Wed, 20 Nov 2024 03:13:55 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd3edcd5sm597600e87.44.2024.11.20.03.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:13:53 -0800 (PST)
Date: Wed, 20 Nov 2024 13:13:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Kuldeep Singh <quic_kuldsing@quicinc.com>, Elliot Berman <quic_eberman@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Avaneesh Kumar Dwivedi <quic_akdwived@quicinc.com>, 
	Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 0/6] firmware: qcom: scm: Fixes for concurrency
Message-ID: <vr64bidkdzoebqmkq3f5jnpqf2hqcf2nvqc27vhu53ave3bced@3ffd2wqtxrvd>
References: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-v1-0-7056127007a7@linaro.org>

On Tue, Nov 19, 2024 at 07:33:16PM +0100, Krzysztof Kozlowski wrote:
> SCM driver looks messy in terms of handling concurrency of probe.  The
> driver exports interface which is guarded by global '__scm' variable
> but:
> 1. Lacks proper read barrier (commit adding write barriers mixed up
>    READ_ONCE with a read barrier).
> 2. Lacks barriers or checks for '__scm' in multiple places.
> 3. Lacks probe error cleanup.
> 
> I fixed here few visible things, but this was not tested extensively.  I
> tried only SM8450.
> 
> ARM32 and SC8280xp/X1E platforms would be useful for testing as well.

ARM32 devices are present in the lab.

> 
> All the issues here are non-urgent, IOW, they were here for some time
> (v6.10-rc1 and earlier).
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (6):
>       firmware: qcom: scm: Fix missing read barrier in qcom_scm_is_available()
>       firmware: qcom: scm: Fix missing read barrier in qcom_scm_get_tzmem_pool()
>       firmware: qcom: scm: Handle various probe ordering for qcom_scm_assign_mem()
>       [RFC/RFT] firmware: qcom: scm: Cleanup global '__scm' on probe failures
>       firmware: qcom: scm: smc: Handle missing SCM device
>       firmware: qcom: scm: smc: Narrow 'mempool' variable scope
> 
>  drivers/firmware/qcom/qcom_scm-smc.c |  6 +++-
>  drivers/firmware/qcom/qcom_scm.c     | 55 +++++++++++++++++++++++++-----------
>  2 files changed, 44 insertions(+), 17 deletions(-)
> ---
> base-commit: 414c97c966b69e4a6ea7b32970fa166b2f9b9ef0
> change-id: 20241119-qcom-scm-missing-barriers-and-all-sort-of-srap-a25d59074882
> 
> Best regards,
> -- 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

-- 
With best wishes
Dmitry

