Return-Path: <stable+bounces-35518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 769048947CB
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 01:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5D51F2284D
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 23:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628D42E822;
	Mon,  1 Apr 2024 23:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G1lqbLKf"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE4257300
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712014617; cv=none; b=tOnKzvaeAMO6QAfT2peRzXfvkMtMzJUOyY0oaYaXLxNRmuhQKZl1foHVWAIwuXH1gwykWABQkQot3MFDBCv0C3uCcSELagiPYNJIrPG1k5XrSTcSaaMQDJ8TdUy14V84v4XFVkKY2gpEVrmWwwbx98nMsatOnvwNJg8+Zi1gQ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712014617; c=relaxed/simple;
	bh=CqfeARlug8+zcjr8pia+tcq62XchzGu/UcL4fzI7plM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGTxG/aykEtNZc1NnIHOpIVypKz0+0upGd5J2QE9tN4LFKXxa8Puv0uXhLwM6iNVgwHtXc4qJlobXfoRnBVUHIvysLDeoA4F1y80IXxvgakP801gjSXUVV8jjWUUVctu6acLYKWHSGbsZbHxfkJx+/wmxK708yk/HyQ5PkANc+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G1lqbLKf; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7cc67249181so35848539f.1
        for <stable@vger.kernel.org>; Mon, 01 Apr 2024 16:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712014614; x=1712619414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RwQzHTQg7aKASMwhwisC553WH/Sq/sNTw6BLGLLQEgs=;
        b=G1lqbLKf3SRoT8O1nrQVgZYcHiPCsHOFEO/iXPBDJRwjuoWpBUaeDUNdERpHMpGll9
         syKyykJg9HxrYdakpO0J4uwADGFDWuOaRzk0YI6yss7HeEB+rU+/eeLT3z0BjfQrVtx+
         7AefySGK/lA7ZdN16oI79rjwxNws3lZGAcNVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712014614; x=1712619414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwQzHTQg7aKASMwhwisC553WH/Sq/sNTw6BLGLLQEgs=;
        b=ZQ76Up+i7wMuYMTeW8+U6lTJS4LwVs8P+eiLJpYM8sThBG76ACbEc3+LMnQ15H5HBO
         8LygRUPtiiWDR+/3T0kryOqCbkdjjrTOsSX0d04/OWxdCznGsH3Kd3DpQJNK3Qe8Jm0h
         sT5K+AHKYw4W5Nnezj8ugDamW5WiLckRhAQkGeXMQ/149aLY6a6gJiQxPvORgwlOWxi4
         +UK5YuZi2ONv9q9t4OgPgcnLsLm9KEhsOaEy0R9tw/HttUiwl1LOENiOTG5S+4CaJ+YL
         +Tkpk88gz1LL57DT2cRNrJkukOV6UetISLEtvQCNtGVwI+zZBE9CRKHcLYo69gKqGZAe
         YZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoHZBZhCfTJawbdi+BN9qfWfNhNDIL3iPb19EEem0elnA+VliC98oSXZhRN+6CiupUuUCEW0Gz7u3qtZ/MWca2C97QKqRa
X-Gm-Message-State: AOJu0YyTyzIgBGIOlsJJDN92LRJkJqRM6pbd6G/X1s8TjTzK/fOcWkc5
	zC1oxR/5k2PNN8ohdx8h9susiKETvNq9/GepO4fPq7MFGx9c86ZHUlAAi0ON0UY=
X-Google-Smtp-Source: AGHT+IF9VDrAkw8zM+JlSY1VR4/oU7l/OgNtFNLNupYNJ/J4MEr7YxZTlgnNdnDmkWerLIX7U/KH+g==
X-Received: by 2002:a92:cc46:0:b0:368:9b64:fa7a with SMTP id t6-20020a92cc46000000b003689b64fa7amr9893308ilq.0.1712014614629;
        Mon, 01 Apr 2024 16:36:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id v2-20020a92c6c2000000b00366a9dc823dsm2959187ilm.55.2024.04.01.16.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 16:36:54 -0700 (PDT)
Message-ID: <92c40e6d-3db6-4cbb-838b-f4c875e747ea@linuxfoundation.org>
Date: Mon, 1 Apr 2024 17:36:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/432] 6.7.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/24 09:39, Greg Kroah-Hartman wrote:
> Note, this will be the LAST 6.7.y kernel release.  After this one it
> will be end-of-life.  Please move to 6.8.y now.
> 
> ------------------------------------------
> 
> This is the start of the stable review cycle for the 6.7.12 release.
> There are 432 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

