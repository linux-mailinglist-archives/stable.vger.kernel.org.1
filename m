Return-Path: <stable+bounces-60524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105CB934A6D
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 10:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414251C217AE
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 08:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3EB8175E;
	Thu, 18 Jul 2024 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L620DYJ2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9B581728
	for <stable@vger.kernel.org>; Thu, 18 Jul 2024 08:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292603; cv=none; b=qi4TLbNYei6mublvXmTrcegld2x72SWji2WRAICHTDfKhnlvBya9tVyIPhTd57bVJ8aWJE3NL/pYYcTGLpmaYxLfbE8fnqaLKK3rSxAdm2TvOVTioqMZF/37lhry3NAn1XGt1JX50C47QFRQy1PZnyhgiTzwOQnbGf2ooLQWxag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292603; c=relaxed/simple;
	bh=xU9PgZjATJTgeGVb3zkgiWRPKhFL8Pot0cTuFhsbMYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AW0CheSH/n/2YoHGuqKSyptjbyvNzxltk2Z1P2tCD2gcFJmPvxTP10ng5x1IbP9UIfrRVviNYmrV4rFEBYOaR7mru80SONOuFJy0tuuaDoVXT6mJ9OY/qOcKY8GL9cGlTSO54DuPVk98K/9eVAVQvwwG+L5J5txPjolgSHcUDQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L620DYJ2; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a10835480bso639370a12.2
        for <stable@vger.kernel.org>; Thu, 18 Jul 2024 01:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721292600; x=1721897400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKVAbydblk8W4SNZYSxcfG3UIlWqFYP7xjT78K0eLCU=;
        b=L620DYJ21hhtwVtq7CgbTRRYEt/9AWy57XCIVSMZyqjJr/fGZvfhbIVqNGgQtPcX32
         J6cQCul7w47kRuUW+etTSYOlJb3ZQoNixdazImUxql8YeEkAoaI+W+wu95qZDhfNWcek
         827Fa6TtNbIOuHxtBbVc6pcmJNlo+JvVHV7YgjTYqb9dZrWzRBIHktCCILBF3eytAaHH
         3gm3VyTCtxU8dRdva1+ALhdUIyCuqld5RnrkKWxh28ALv+EPmOFwuBX3YgqYCd4ZAS8o
         gevm9RyPaUbUM23L4MImtJoMhQUsrmcHgvGRjqNxZznLaOb54QlTG93Rxj+znxi27paW
         MjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721292600; x=1721897400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKVAbydblk8W4SNZYSxcfG3UIlWqFYP7xjT78K0eLCU=;
        b=bODC69Bniv/ebYY5Z2Szst547auSA7EPoT1LWGqPPZFp2s0HiyUx6ApPQvXDjJZdam
         fGLZ6szIjZ8Bgur3KkBzWufemltXuZNB32jA37BXWivuc5r38HX2nOuoQL1f0/WTn8SB
         40um7CD25143ZawrsrwuUzoZUadQ6mVMakNIIJsnfk4j5XKVjN78/1GQdudQR1L5s708
         ngJx+rI0D+5wbaP7QEVpNyQunjtw5MsAYrb+edqRF/6UwPqKB5BkVF8Gh0aX488hC/4W
         MT2O0BVJxazNCGfvr6zveK12I041JGK7SnXEnL09jNbWsfOXkcCMgipUCngQFMZ65sBV
         0vNA==
X-Forwarded-Encrypted: i=1; AJvYcCVzhUYSbovlLJAiDlZf33UTOwS+IxBtgs0OtNHsGx12AuzHVmqIeHZmqcylAZS4vpUlVDCTw4NNXcb4VLNeDf1kLbfVCfuP
X-Gm-Message-State: AOJu0YxGDIRVs9v/lfaRVF/JoXJ8EHpUmIOrkIYwNmk+NeuXlQ2rEjtS
	7uEUnTjJB3sRR1hapBAkWArq84fMrdIeF4PycKYcpKB+ZjKStJTjO3j1ADcKe4c=
X-Google-Smtp-Source: AGHT+IGy7dpukOH0Ine9zKVAKnODt6FZYUwekNOac+p/AsUJFd7XuGKLKmL8QouKVqCwrNOpsziXJg==
X-Received: by 2002:a50:9e29:0:b0:5a1:22d:b0ff with SMTP id 4fb4d7f45d1cf-5a1022db20emr2073507a12.35.1721292600104;
        Thu, 18 Jul 2024 01:50:00 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b26f62bd9sm8112269a12.94.2024.07.18.01.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 01:49:59 -0700 (PDT)
Message-ID: <83f721bf-b2a6-4c05-b142-3473ffc86fde@linaro.org>
Date: Thu, 18 Jul 2024 10:49:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: cmd-db: Map shared memory as WC, not WB
To: Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc: Maulik Shah <quic_mkshah@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, stephan@gerhold.net,
 swboyd@chromium.org, dianders@chromium.org, robdclark@gmail.com,
 nikita@trvn.ru, quic_eberman@quicinc.com, quic_lsrao@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, stable@vger.kernel.org
References: <20240718-cmd_db_uncached-v2-1-f6cf53164c90@quicinc.com>
 <a49113a2-d7f8-4b77-81c7-22855809cee8@quicinc.com>
 <1c5b3f7f-95b6-4efb-aa16-11571b87c6c6@linaro.org>
 <de7930b1-6f33-4ff5-911d-e5156a020585@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <de7930b1-6f33-4ff5-911d-e5156a020585@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/07/2024 09:55, Pavan Kondeti wrote:
> On Thu, Jul 18, 2024 at 09:42:27AM +0200, Caleb Connolly wrote:
>> Hi Pavan,
>>
>>>
>>> Thanks Maulik for sharing the patch. It works as expected. Feel free to
>>> use
>>
>> Can I ask how you're testing this?
>>
>> Kind regards,
>>>
>>> Tested-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
>>>
>>
> 
> The QCM6490 RB3 board boots from upstream kernel. As part of releases
> here [1] we plan to support booting Linux in EL2. Currently, I have an
> internal board/build with firmware allowing this already. I have boot tested
> Maulik's patch (and as well v1 patch). The targets gets reset early in
> the boot up w/o this patch and I could boot w/ this patch.

Ahh awesome! Thanks for the info :)
> 
> Thanks,
> Pavan
> 
> [1] https://github.com/quic-yocto/qcom-manifest

-- 
// Caleb (they/them)

