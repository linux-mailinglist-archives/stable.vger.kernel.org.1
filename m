Return-Path: <stable+bounces-60452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D37933FD7
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 17:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF431F22000
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33724181BBA;
	Wed, 17 Jul 2024 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fh9U029Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61780181BBC
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230938; cv=none; b=LtNCP1ZVdVrZDPuDuvQSE/OfS8E5uyhbJs+aDCS87mtgdO1hvsqYJFUfWqpOaqle+cQgnjUa/EeKExo2Pl0AONyVxnc8XNiUpBTxfs4dyNPSaT3bK4YqG43UGeu+9aZBJCAJqzJv+DZlIWP2cHE0a7Z4a5vzPVccWuWUAn9HgFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230938; c=relaxed/simple;
	bh=vuHvG5Bw01x9b75iXfvM8x7eQfEWf59Y3BamQMGwG/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehRx8fMRkTjGoZTWsLNuaxS/3XQQPXar5CIYy6X8adyhh1RR/VS6WOKH7M4rnmcBBObfLqTAcwBkK2tGnXVeUdYPzJ15BN0s9gOUSKcYk8YZ+aPyx/gOBWPw8KA2oo8zdh/c5RrzWbX9rfc44vrkNYEnyW6hlS2/HmCrfKg+eGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fh9U029Y; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7fb4ac767c7so3763039f.1
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 08:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721230935; x=1721835735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cPjwCBYBm9qF0338CZIKw1PFkwmH858FXYIGOpiO0M=;
        b=fh9U029YEAmJbPZ+irdN4d/xbuY0b0l52SMiHBLTliJ1tg4PUXB0A8DJ9iGAIkAXay
         r9dzp29olJ7MHeqRQWVaJuKNkNhMO3iRiinkOX95D3MwNwri/Y5fqJXXwQBoCg16mZHO
         N9Gj/Kt/IlPLNHq+bbemreZjsRjosZ4Iufjf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721230935; x=1721835735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1cPjwCBYBm9qF0338CZIKw1PFkwmH858FXYIGOpiO0M=;
        b=f55ishT/d/YS+Hx6W4SUFg6LU8Sln2kjBRgVtVVWsvTd/PcA7QE/VeMK3sIqaYRBVV
         MZ4qp5HEtpG08JYz4ajxfDYQk/uALR7BCy0Kron+IjjF2/H2Ifjl7oox7WC9X1r2y6sZ
         rk0TmDihoF1Tf5AdzpmsutunXjsYg4uujvQDi3BIf8NOeKk8jz2ZQSSe/Lo/jmTqSOKL
         vMmt1klWB24VAQTC1i9Ydakm/7dtNfjrZGZH1fy80pzoV3mxF+LBqDjPW0WHXDLwLm31
         xQKSx4s8dQ0RtDh3JuHx8oRpXiTo/76dI5t8mfW4daNXcNiNpGqM3Rk3jaCnlDWPji7g
         HfyA==
X-Forwarded-Encrypted: i=1; AJvYcCWBv+iytH22tPIlSs04tHKQjINWGOfjvjnJsXnNZ7Jjx9l6qfiuz06bXhiw4NzQQq1qajtTveCl2WLzyJDqH9TLcmIdZrhA
X-Gm-Message-State: AOJu0YyTMPQu7k3lkQ9BmbQcnvuttw/1AL274HjrtkrGWWQ3yGFbNN8t
	aooIunO6swVuIArBuUMOKzHU+NH5Sg8k81OQcSWb9N4rjJNshU2UhL2bpFHc6+g=
X-Google-Smtp-Source: AGHT+IF/J+Fr5qIJKCpkhnuE7FiXLaULtb21qr9MB3cIRutKC2vqJEtVHOTobpt6Y2/K0mg1P4vPzg==
X-Received: by 2002:a05:6e02:b4f:b0:38e:cdf9:8877 with SMTP id e9e14a558f8ab-395579e88cdmr15685405ab.4.1721230935456;
        Wed, 17 Jul 2024 08:42:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3950aee0d17sm8345205ab.8.2024.07.17.08.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 08:42:14 -0700 (PDT)
Message-ID: <c843e23b-5a8f-4f58-825b-7faaa2988841@linuxfoundation.org>
Date: Wed, 17 Jul 2024 09:42:13 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/143] 6.9.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240716152755.980289992@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240716152755.980289992@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 09:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.10 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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

