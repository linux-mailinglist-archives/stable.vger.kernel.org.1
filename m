Return-Path: <stable+bounces-37770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC0689C717
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5751C21262
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 14:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB71E13A87A;
	Mon,  8 Apr 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tjk8btpd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943D713A3EC
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586634; cv=none; b=pfBn2+izz/69fIMswr2Bj3S0C7A0IsvCvBVbic6pz0kMxQyL2h2wHFaTQEAB1wyR5VNMNJrFgGLUIwJbeqoxQpxnds/vrTSb+hF4EUzve4Ws89V6NeqU2BWljsxf9ZENKzxhg7sA6hZMA489DShGX2pLrfH4djPj+dmCyJ3tWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586634; c=relaxed/simple;
	bh=RgNAfYk0IeW8ozwHqAQ2FZbXTFcFsxgUeSwFe0Lwusw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwPP7Hp/XQ8s/jeGkpatfcRJCDSynuWW81CuJGKuMhrTEZZAfVpQWKN469xCaz8eZb5WWYJF9TxYhPhJu5w6q8pVMvYVYOsUkdE79Z/ryTBF1IbRjfbJ/FSil5dLWmQq2kb29Xx/SdqwqmupXMUmjGo//opGCsIlal73t/poimU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tjk8btpd; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d536f6f2so3126003e87.2
        for <stable@vger.kernel.org>; Mon, 08 Apr 2024 07:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712586629; x=1713191429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JbNAL/GJwarHvPTE1x3HLG2P6WbYMjHYM5jL5CYr4Ds=;
        b=Tjk8btpdi8oW0O+vu/IgWiRPrT2YVgIyDH4UIsNfcAsIA4tOamR/FL4mvfheKSGZP0
         2GS+uW6COhiteIFmi5kAOQ7AoK8nwHfyFlvGelOc1vEv25DUVaIxCK0cfQud5Fu1Tfm3
         w7nOQVC7i2x75W9+NrOb+jgEejxxF+1Cy+5HghURx8ipA8dUPb3Fln2PslCMRBKz2zFF
         T8sW/ZkQfioWl9a7v7TvGEfFzLFDE/d/Oxu6oFFTka76t3VypUJOh1HagnjzAtkoxpLX
         5CPcj2U24khPVGBfzuP93lWhJ7j5iT53P87dqsF/srPk/VBNx20F4QVAfqEtdzovKS2n
         q6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712586629; x=1713191429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbNAL/GJwarHvPTE1x3HLG2P6WbYMjHYM5jL5CYr4Ds=;
        b=pC02dcReu57yvAf3RpDMVmLrEGBtXcS4r23UTL/yf9f945pjT+31Q5gKVDJadx/66K
         c+3aLFa5MB/bvJw8Ee1PJW4aDFa2x+c+u6NOQ5SZFS5Z05UsjT5zV7LTBxOU5UyAIdxg
         3eQMOaZ5gfi9i2EYOIxsuWF2GbdSAradNM3A+/BP4nWWKGzlzAUO5CbhQ8DWDHd8pGPh
         7fqCPbpyJ/RY5odM+vUEKSUTKceEvMGQO8EgWTQYCLss2j8xohFz8PvetPORndQP7eAA
         lpbmgYub8Huf/mihaP/WzPJod6sOXrAUdLdFue4vvd14BkMpckcRwGttUpXPnDdaeLYz
         ZWdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSVEQQjZvrhDTk1+n6uhHXs0NiclKk5HWDOMarIMqSgPVd46QP2p5OsLC6iKpkCxVSmNelf/UvBIHjBbJTbfAdr4xWLgqg
X-Gm-Message-State: AOJu0YybKgTwS2FR3KJcUvenJ3TTpIfx+OFWitD+cU8W76pmC0c/b04x
	9Q5KAcNS9e71jsOWATMyNQG2oKU54wRTU1Hd943U74AJNLnsfRA96CtJyQIMCbo=
X-Google-Smtp-Source: AGHT+IHC2GoNZnZz63pJWddMfVDcEqhdjGlleVnBgtGQ2PFqmRbP3jcpGS5qBPiJXHTsSKRRqsifyA==
X-Received: by 2002:a19:2d43:0:b0:516:d18b:eae8 with SMTP id t3-20020a192d43000000b00516d18beae8mr5691961lft.41.1712586628967;
        Mon, 08 Apr 2024 07:30:28 -0700 (PDT)
Received: from [172.30.204.201] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q20-20020a194314000000b00516c5eef5c7sm1209811lfa.243.2024.04.08.07.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 07:30:28 -0700 (PDT)
Message-ID: <dbe5562d-9850-4a25-b279-f8fcffd9291e@linaro.org>
Date: Mon, 8 Apr 2024 16:30:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firmware: qcom: uefisecapp: Fix memory related IO
 errors and crashes
To: Maximilian Luz <luzmaximilian@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
 Johan Hovold <johan+linaro@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Guru Das Srinagesh <quic_gurus@quicinc.com>, Ard Biesheuvel
 <ardb@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240406130125.1047436-1-luzmaximilian@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240406130125.1047436-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/6/24 15:01, Maximilian Luz wrote:
> It turns out that while the QSEECOM APP_SEND command has specific fields
> for request and response buffers, uefisecapp expects them both to be in
> a single memory region. Failure to adhere to this has (so far) resulted
> in either no response being written to the response buffer (causing an
> EIO to be emitted down the line), the SCM call to fail with EINVAL
> (i.e., directly from TZ/firmware), or the device to be hard-reset.
> 
> While this issue can be triggered deterministically, in the current form
> it seems to happen rather sporadically (which is why it has gone
> unnoticed during earlier testing). This is likely due to the two
> kzalloc() calls (for request and response) being directly after each
> other. Which means that those likely return consecutive regions most of
> the time, especially when not much else is going on in the system.
> 
> Fix this by allocating a single memory region for both request and
> response buffers, properly aligning both structs inside it. This
> unfortunately also means that the qcom_scm_qseecom_app_send() interface
> needs to be restructured, as it should no longer map the DMA regions
> separately. Therefore, move the responsibility of DMA allocation (or
> mapping) to the caller.
> 
> Fixes: 759e7a2b62eb ("firmware: Add support for Qualcomm UEFI Secure Application")
> Cc: stable@vger.kernel.org  # 6.7
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---
> 
> Changes in v2:
> - rename DMA related variables
>    - replace _phys suffix with _dma
>    - drop _virt suffix
> - use DMA-based naming in comments instead of referring to physical
>    addresses/memory
> 
> ---

Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # X13s

I've been running this for quite some time now, no explosions so far

Konrad

