Return-Path: <stable+bounces-32354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7F388CAAE
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 18:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A22A32511C
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 17:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2D41CD2E;
	Tue, 26 Mar 2024 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A8A2gPTq"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36C1CAA0
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473901; cv=none; b=P/OOUSxG77W/EPNpWK3dkF1PXr/24Zw6tElRQwdQtGp33zJ2eDAKOb4NVsdfEbmRp4TH+GTWxWnOS3xH15LdnWii/OLSgkgsrFdxL4Dj42sAnEHMR+mk0sQ2ZCMqS5FWCRAa99/UkOSgWw/jIgJFOp2YM4fgV04eUWotFfBnX2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473901; c=relaxed/simple;
	bh=pTRSIDC/KA3phaqH7soVU09XNC0+BCvPg1utlTY8gxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWTk4SofM1qOLw6BDfghrWrg3xrOfTopEP7Z9ccHkGbFFKZjqprFcV8zTB9pCVuLQZyPZ8TlbbpfABdiXvN5XxRJLyTiyzCuWJzsz+8xZvv2xCumSkwif5EQYi5E/EJFqA3UpyUA+88dJWm3Q1nj8rtC0zO8CFkdA3QAh72oYOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A8A2gPTq; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso37445739f.1
        for <stable@vger.kernel.org>; Tue, 26 Mar 2024 10:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711473899; x=1712078699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r0fnUPNSHODh3//ksumlK/ktfhggOKBHEL5RMOBDJnw=;
        b=A8A2gPTqq8Sz9xbvbKx4RhvGT1s4wdod1JGXZcuR9+g3YcHG8gIAOEZA4PysWnAuKd
         RV/iHzHoVZ9O/ZFlx/6GbmIoNeO6uZWxxO6UEMNNf85Nxa/iyfDkpU5UC0kMZn8ncaa9
         A2JSawl3SGiJWulttIDM9O1XIsYKvrbFOziQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711473899; x=1712078699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0fnUPNSHODh3//ksumlK/ktfhggOKBHEL5RMOBDJnw=;
        b=wvFP6r/nh7wpCoiRvoBl9/uCCc5U9BihyJMgKUoUsBGQQr/d373yF2G3FjrUm6Ov2U
         L3remXo9EpA9mR3PkgaqyiSZOe0UYKOMtLfBlig3TfFUd6c/cyIU0mcDPXR0n9d5618m
         HQbocn6oAB+k0GY264n9TmTDNmF9mOonCwxvXUMfKow1ZHu3NL0ETZyvS4YyRZwuJ2xm
         zX02kUxM139NN33Mbg1YnUa8xHUy5y9wM7Yzob4GLQ0Bi+NdQuOQ0lOcpLOTDI8E9sdq
         +6orKrvRH39WEAxfF9qOygJ53F1skFetEMUiKBYe+NqyYF1AtPZ3WY8nzGVOOyHo+dLO
         GHNg==
X-Forwarded-Encrypted: i=1; AJvYcCVB7JdE3drCypHCHanzFeXIQAmbNddGID+BpeKkjj5vPnvnAgIhbcZOVpW/QO0/57wFXZLWu6+4e9z94VUjd6RKGeMbcmQI
X-Gm-Message-State: AOJu0YyKce/3CDnrZ551Yu6f9LFfV2qTCs3YuL/w5nEj9v3vbf7Kid2V
	CNu2fheUfCEFTHh6ikD0eig4XzPfspNiVtvjWRkxeulNVs45q4t94iLwz48v4vE=
X-Google-Smtp-Source: AGHT+IHWKEzcKaaOUZum8ea8j9NQGZMvaLf33hOIuTOAABsizWeIhvWwZU1+m/1KGq54/Le9+eCvAQ==
X-Received: by 2002:a05:6602:14ce:b0:7d0:5b47:8f57 with SMTP id b14-20020a05660214ce00b007d05b478f57mr6062639iow.1.1711473899406;
        Tue, 26 Mar 2024 10:24:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id k13-20020a02a70d000000b0047c0c7b6c6esm1912654jam.175.2024.03.26.10.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 10:24:59 -0700 (PDT)
Message-ID: <cd4aed58-4552-48c9-baa8-53b9d28682fb@linuxfoundation.org>
Date: Tue, 26 Mar 2024 11:24:58 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 000/147] 4.19.311-rc2 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240325115854.1764898-1-sashal@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240325115854.1764898-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 05:58, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 4.19.311 release.
> There are 147 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:58:33 AM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-4.19.y&id2=v4.19.310
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

