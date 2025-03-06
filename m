Return-Path: <stable+bounces-121274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A4EA55008
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 17:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83113188A6B3
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 16:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F59119B5B4;
	Thu,  6 Mar 2025 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J0wMIuyh"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D13120ADD1
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277019; cv=none; b=O0paxVAJKgCvHecklSsfF0Uoe09vlJtAcWg7ug2vSLToKsRpUKGQjzrPZL/wVKiDtph18Th7iooycEsevJJG6gJgBX9oGXzQH0azkIFeeyi8SeZZ6iIcultBfme/TgBCfb6yL5ZqL2URM30erwcSje14VzjrYB7CehW0KBu+Muo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277019; c=relaxed/simple;
	bh=xVNSnb0jyNfDW//8xinTnXuPgEPSTDWwEpiqXIaFplw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivB+A2Om7L5GodgX7rV1qHka0zoJNwxojARP9rXaci7ccCNjqaLMKyJsK8z+oTWlJGaYY8mQqya+oz7Xjp5TELrNaMeEgl4uJytX0pElJZCwL+paK7BN9cpAxw/o1adIy4x6AZKq2te2VP+0sPL+x5wskxsOuxsNEltOGNSLYEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J0wMIuyh; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3cfcf8b7455so9322315ab.3
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 08:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741277016; x=1741881816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcNdPRCInpMj0KbnCBF2KUxDA1QurFq8iTZjeemnwJ4=;
        b=J0wMIuyhYdwsdaBtaYJBwc5FmTuVswJ6OYz6GiM2dtuGfDIzkPx1wCe15uHd6LWcnj
         X8qtQHgCDqyqum9Fj+dK1OI1Rt59zNJlWQin4hZFVMUtcqHIQaiUkAL3ndJ0ZguZXIAF
         NIMJH0i/KLy2ZJZqsPoJACRePFqRnt9tBOHvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741277016; x=1741881816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BcNdPRCInpMj0KbnCBF2KUxDA1QurFq8iTZjeemnwJ4=;
        b=sxthGHtjTAiN/fkh+xHRtIPnDhXx/pQh67fEG+/Npy5ax5R4cg021dvFaSJ3oBfb/r
         fmSepmuduIrsYYXFTNQwvHBOWTsuBWBFTrZ6/rKTQg5yLWAtTA/xRtcIcqHG7xSI/KPZ
         zY5Zuh5NA2sFk+U5JCruuolrXEhxDD98R7nbzqM7iTjuZ0m2OFPSg2Dky0MCnmLXgGXD
         4mNzIgllMmuNc7iRlf6fK/8Czlgs+yhyPRPeTQ0Ah19o72kRZLln3qywqO8iN/CNUPo/
         AZES481gq+94NY6j+gb3/D+3+mA5jPET2HmCAUPnpnW/dsqqRy3ECqhB4QBayS/qAPEg
         KgYw==
X-Forwarded-Encrypted: i=1; AJvYcCVqecxPsj79cAqkb6RBjYv0zU9OJlD6s4pWXu6o2njw9wG4R9n9/0PIf7gDhUXNfidgaveLj/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOSDlIR7zGx6y4Qu0AAOzwo1Swf9sOT9mEIPNlxLhOwdSwxNto
	TgHO8b6S8TroaPo+qQ7YQP52GegEkTPbv3VHhcDbtKl39sidNw9IhcKPB+bb3TQ=
X-Gm-Gg: ASbGncuZ2nNm3XlUnmLocnDQFiX2dIDZplZFYnPt8Yv9RYCHvk72t10GVnGZIR+3Vtg
	A/EZ1/ZIQX2AWORZv4fXXCeigbftLwqRuQdLpzd33SD9En6jVVHPuzCmebduLCb9dEk6K+PHD8Y
	9XJ8r1TWIUmZ1aTz1OxWwSdVnr0SFHu0Vv2CA4uo5GmI3ldRSME1CLCFmecXhaRayksvkOtdQC7
	YFrbOsTvdICNyVHb2X8vEkEw15L/hbOEZdPIqzJmyaD4D718pCA01Z/OpiNi9bHt+mUjRcz9jnr
	eRA2L+daIJH3HwKH/YImJjuO3A1GlGeBdWQU9f3RNKPp6FtI/XO+oAY=
X-Google-Smtp-Source: AGHT+IGQHGUCX/DcHAB0f8MKsKPYCnuinUn3LSlGNP0ULjdmmx+23Lb00DxVmOwmlf9J59UO66TIrQ==
X-Received: by 2002:a05:6e02:164a:b0:3d2:b0f1:f5b5 with SMTP id e9e14a558f8ab-3d44187c021mr799245ab.3.1741277016390;
        Thu, 06 Mar 2025 08:03:36 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d43b586ba3sm3501015ab.45.2025.03.06.08.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 08:03:35 -0800 (PST)
Message-ID: <dc1e2731-cfeb-422f-8243-95746aafc889@linuxfoundation.org>
Date: Thu, 6 Mar 2025 09:03:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/176] 6.1.130-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250305174505.437358097@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/25 10:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.130 release.
> There are 176 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.130-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

