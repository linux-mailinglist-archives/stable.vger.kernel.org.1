Return-Path: <stable+bounces-39236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C49498A2262
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 01:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8064428302A
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 23:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7461E481D7;
	Thu, 11 Apr 2024 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z0KaXxnK"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF4481D1
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878801; cv=none; b=eFyJ1aJIB2I2AC7z7E1s6sVKJioo2VJub+q0fFhwHWokWC/SV2oK5ut6MBm3tl+9aGFlvZ8NI2uWLQkPNjlWPIyE0gGli2eZm12vMXXkHjmDWwvxOSX0ZVMak77TWHdUobe8pN478yZANtOktK07aBm5uta+89am5dyJY2wAxZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878801; c=relaxed/simple;
	bh=3JWDnoDfMPkjhXx88KBMxUpX/9HZtRbJH9rKO+JRuxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awCxtTAC+Z1pT8/2N6VoHUWfzTHXZ06LBu9fFneHFwmwcUFhGiiv0lf0GfvFGEvuxTQ9aRmRsh2pG9Gv/Lpc1+ykntQ5Xfu0Pr37y9nPqVEgmq10IOjBUNUJ152K2IjQ1tDkECtl305F59OG/z/3yX1D4ca/RCM+5yw2OalCU/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z0KaXxnK; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso7781839f.0
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712878799; x=1713483599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hc/GAob5w76tlQZgUUc4pUFMO+5LudlrplUXRVaDAdE=;
        b=Z0KaXxnKhit9y80K2KCeHCUzQOUtOaA9pIiegoC8chHHsSkOgoKsd5gU4xHtOPhjcv
         yWArSrxsOZoMYME6Bi4lM3AVGxIeBVa6Fq7wwZUUGvl7yEcL9c0nNXAFagkbQ9cyYeAn
         +0CSQC4Ku8ZmPckirHPe39CjdLjvkTT7JHoRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712878799; x=1713483599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc/GAob5w76tlQZgUUc4pUFMO+5LudlrplUXRVaDAdE=;
        b=XspGAxt4q8RADcHA1UcgBRIGvTITokf1nrGNkU61pTRXCxUxxuIaYQa+GNN7pxp5CI
         hIZuAkSf4bsrb2RdqaccySBoik5PwO0+LK1azNoFkUsHx18Y2/f+D70H0Cw+4Z9sW6Qx
         YmuSAAuOiVWpfv3Ey65fxXzwcSh5U2wjtHhmqDmbRYoZKJZPiwYXkMSmtmqXPo8lVFcL
         C6gztsIiOurH7UAFwpYjGc+vO9VETTvplOlLwVqOlfCUbSPCqrA6UeJHXdY+zU5Y54GG
         FsxuJp63VWcP/FJzhg0adwa9jos9jsWV1CvEqoH3NTDLO8IOGMBLxXTu2AYVeYV8guqw
         MlLw==
X-Forwarded-Encrypted: i=1; AJvYcCU9IV0D1/90CARO1dG5oGIcAokHRMtLAIzX6Pb/uF1XSOMoBo8ITn1x9lKZQUNW7R8fCn+eQzGVvfDlZHzC8Dudzh4ZN3zN
X-Gm-Message-State: AOJu0YxE7c5n70z/jYSbruWc5Orh7BqbOmXCW9eoZ14SpXZisTyUTesO
	DQzI06qmc/1Hrum8var/enL4YDFnSqKbpx9zuIVgPDb7H9aXQWa2qCv1rEYQN3g=
X-Google-Smtp-Source: AGHT+IHeqyhkA1lLsoFAE0ibKpNUK+X0VssnmLz1GgchJ8SMV8YCLDXLuO55xm6rUMnlvE7Fyq1z/g==
X-Received: by 2002:a05:6602:2cc6:b0:7d6:a792:3e32 with SMTP id j6-20020a0566022cc600b007d6a7923e32mr599539iow.1.1712878799132;
        Thu, 11 Apr 2024 16:39:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g6-20020a05663816c600b004828703cf44sm672846jat.95.2024.04.11.16.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 16:39:58 -0700 (PDT)
Message-ID: <f571fca0-ec78-464b-a42e-69ceae0b0860@linuxfoundation.org>
Date: Thu, 11 Apr 2024 17:39:57 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/114] 6.6.27-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240411095416.853744210@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240411095416.853744210@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 03:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.27 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.27-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

