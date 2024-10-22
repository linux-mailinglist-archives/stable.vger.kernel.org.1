Return-Path: <stable+bounces-87704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E199A9F3E
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 11:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACEA7B21259
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 09:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8F219992E;
	Tue, 22 Oct 2024 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b="NZ4YvN2P"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6E155330
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590830; cv=none; b=IREAFV6FQhIOUH8otkb6dXuqgr14ttaHVLDgI4LpcQmS3XFBEETenoOcuH35Ri1xMsTpBO+CQPk8qEb2ZPqxTFgxllH047rAJhmGzGZRybdi01bp+Sj1GlJBYGGzZ57RT6GhLEJdPt/hTtdBzLbnU3oNSVdzX5Sm5/CjFxqu9Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590830; c=relaxed/simple;
	bh=Y46DtbVTP0E38ObjD6CzbJEhXZgRp0JJH6MXGub6VHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+yxQjxmtQnJs/Fmvp1kHM+7EtdNt0VJPJpLAoiUZHz67tXHS1gAB0mTAV7B/0qHgxDK5we8Bp1kj0m1RUVwjoZ1xVHrcQjM2+twPFBniclexZdHTATqCnwxr0LMPiFWBB5Ix1wSu5Vrh2coOrizmekraSc8lBJ4EnGOtsJj8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie; spf=none smtp.mailfrom=nexus-software.ie; dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b=NZ4YvN2P; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexus-software.ie
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c9709c9b0cso7126663a12.1
        for <stable@vger.kernel.org>; Tue, 22 Oct 2024 02:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1729590825; x=1730195625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=op1FRSJCS1vPXD/9QYtg2XAEFEXZ1E8zhO4zRpuc9J0=;
        b=NZ4YvN2PeZshISEcqNa3Nlg645xxyP+W9AWrRdUOsNeaoGle4GtDXukfoXNh0070xR
         zQMr9ms7/Zqtvdyrb0uTTgmVHfaKUWi4g9z10P97X0S5XozstAZEwNEQUgXqsjB2O739
         52hiy824yC2Z5CDXH3UJO7t8xtA++8YSYkYIOOSUqur5smrdeRyRfBTBsGreOpcSecd2
         ahiL6K4KM7ii8d6Oj7bjaO5AbvUXs7lIrbCFpFMSTyonVYYCLE6kQ/pPu7/oYZOJUXi7
         N+HS2hpyCZTYgEpGjwnSwCLgFNzVw/djOusmZJk3+rpoEuGN/2LXSuG3dju0VDpAb6mQ
         Dr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590825; x=1730195625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=op1FRSJCS1vPXD/9QYtg2XAEFEXZ1E8zhO4zRpuc9J0=;
        b=T1xgtr8bp2ZAvM+aimKJ9K9WssmxrP4bMG3EF1pb43YmUu8/q4f5h5WpLvuuusdb5B
         TYG5MDUyLjRHtCTGR5l6y8ZxXxW1FyKJb88H+UTlsViJWuhHu2MToqY2wy3If1sI6n9I
         SCdIlMPiXi8lHyZoRN6qAv03ary5i9G4NWE1YoLeZU8d6QA6JmsFqrzvg3+Yg7LwDuLS
         Q22GYk0yCvUeM1fS6XPURYSMSrmzwevK4au+Ht7JwPztVmW1ax0gwQbp+YO0Mi5PrTTw
         sn2aLCfghnRC9VRgQlyE17520aVrkBgMhs+s9jC8YngsYEyqgKrKbks4DLbbclc3Z7cn
         WB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMJBK4cjw8E79vIeUK46RLLAJt8mji6hNFWRovpLTCYR2Xh076UawZl50NGZ0VHCcGUf7+ZcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZmp/CcyiJx5A5YDo8sHKXGOLvTtsQR8DhRb8rAvexwnyzpCDk
	TWKLskFIM3+A1t/KOvtPl0u4LaVYDkH0A+rMyrKUA2GsDcvITfNwcwTX08WiF5A=
X-Google-Smtp-Source: AGHT+IEcLQwkHk5o2k7sioZOXKjv6teIn45f2gmoiG+SvQugsEWBRSFoR1zkrhOzSxxQycfl1GyexQ==
X-Received: by 2002:a17:907:72d2:b0:a9a:c82:d76e with SMTP id a640c23a62f3a-a9aa88cb1a7mr251886366b.12.1729590824875;
        Tue, 22 Oct 2024 02:53:44 -0700 (PDT)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912f6644sm313292666b.81.2024.10.22.02.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 02:53:44 -0700 (PDT)
Message-ID: <8ec5512b-a8ea-432c-84aa-f920470c056d@nexus-software.ie>
Date: Tue, 22 Oct 2024 10:53:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc-qcs404: fix initial rate of GPLL3
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Taniya Das <quic_tdas@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241022-fix-gcc-qcs404-gpll3-v1-1-c4d30d634d19@gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20241022-fix-gcc-qcs404-gpll3-v1-1-c4d30d634d19@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/10/2024 10:45, Gabor Juhos wrote:
> The comment before the config of the GPLL3 PLL says that the
> PLL should run at 930 MHz. In contrary to this, calculating
> the frequency from the current configuration values by using
> 19.2 MHz as input frequency defined in 'qcs404.dtsi', it gives
> 921.6 MHz:
> 
>    $ xo=19200000; l=48; alpha=0x0; alpha_hi=0x0
>    $ echo "$xo * ($((l)) + $(((alpha_hi << 32 | alpha) >> 8)) / 2^32)" | bc -l
>    921600000.00000000000000000000
> 
> Set 'alpha_hi' in the configuration to a value used in downstream
> kernels [1][2] in order to get the correct output rate:
> 
>    $ xo=19200000; l=48; alpha=0x0; alpha_hi=0x70
>    $ echo "$xo * ($((l)) + $(((alpha_hi << 32 | alpha) >> 8)) / 2^32)" | bc -l
>    930000000.00000000000000000000
> 
> The change is based on static code analysis, compile tested only.
> 
> [1] https://git.codelinaro.org/clo/la/kernel/msm-5.4/-/blob/kernel.lnx.5.4.r56-rel/drivers/clk/qcom/gcc-qcs404.c?ref_type=heads#L335
> [2} https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/blob/kernel.lnx.5.15.r49-rel/drivers/clk/qcom/gcc-qcs404.c?ref_type=heads#L127
> 
> Cc: stable@vger.kernel.org
> Fixes: 652f1813c113 ("clk: qcom: gcc: Add global clock controller driver for QCS404")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
It should be possible to test / verify this change with debugcc on qcs404

https://github.com/linux-msm/debugcc/blob/master/qcs404.c

---
bod

