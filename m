Return-Path: <stable+bounces-73687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1278E96E6CD
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 02:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DE91C20756
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 00:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C666E10A0C;
	Fri,  6 Sep 2024 00:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eMeB9p90"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289E7335C7
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725582352; cv=none; b=VBeT0dZ3R2aFB3PQBGSxZgouBNp03gKOm4vLWC/RoCVVa3N5ZUvjMzf88hXEVnhxZXdnyktHTCsDfyyYQaqV2CYu/y5lIRbkJO434izzlsyEtBgO+XNspV8trtKS7w4SANB+90Vh1bAdPe5wqkYCnBvJ3GLAsMZHjdljAY8BW3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725582352; c=relaxed/simple;
	bh=TceHKBuOWdShqn26e+E2114vw+BkWXu/eFJXoMvYLXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWuaTCHn6eo6pE6GGLq6Jda9m5jQbT66o56TG5Duta9VSYBx2V5lNKzwXyd+CSvBghZtCIjagc2gx7XVV+upB0dfFaP82vOA0+hx5zVnJhNEcZQiAE8L9VfpCwZTQbS4xkr7YZgEk2a6IXYphutAR/9fbe6qSRJjJi6x7LoRL6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eMeB9p90; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-205722ba00cso13975125ad.0
        for <stable@vger.kernel.org>; Thu, 05 Sep 2024 17:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725582350; x=1726187150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ApnYfKTQtuBNhNyBR6dUfgNS3EzyFjj/3NfY//JSza4=;
        b=eMeB9p903JKij/zrPsAXML7Sx8IA19S8P9/UiMfaQfjbDdLGnGiLSEHiTwWEsniZGx
         SJpRvIDgfl/CjVoEnbva7a23gprQ2QRDgCjS1TSt5fv6UnsGPKAjvvElm1VgzL8JIFOF
         hbe1M0Fg2T7yvPXJ6h75b8I31oQVwbo+lXy40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725582350; x=1726187150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApnYfKTQtuBNhNyBR6dUfgNS3EzyFjj/3NfY//JSza4=;
        b=UZazSHNPSYJ19kI9eFgLcYzVw1hNVPGVuHpWGDgA7qVFkHwh+HoqN5v/X8sWguusp4
         CbT4pLng5Q4aTG8H3QGpMoaeolm++OAwrxQCDSBx+DTYEa2UianJGBSNJXtxe1MVtBgR
         XzruSg64074eZBvZau21aPAow9bgTWM4am/3wnahUd1BJ6szDVBy1FwG1o4FZY1CRRAg
         /I6FaA+SwPX63+sLlgCsECaVssNS0AsyUji5bjdQ0wnw9VMb7eW5z1RsoCLsjA45SPfP
         GFKd+Vl+mzxM/UJJ3PEyVbkEkr1BlXpZidCXiVZEnedKPfIAEDnyQt7SfRtQcdzPKHGV
         Jrww==
X-Forwarded-Encrypted: i=1; AJvYcCXhRRUcQEzFKNA1UmcCTEdAxcPt0PGV0nu/4KX+dqQE3tPBMQplofqrFWP0UTLtMbZTL5ud4CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtCWACWzwXO1t9AANDJh3YEk3V/RqnWFquAqTPxL6ZFu//Pqmu
	+oMXebKlRDEQxCh1xj7iphlvSEc6nOdydd7WjMvJdtqC2DUdKruv1654OtAGAWg=
X-Google-Smtp-Source: AGHT+IG2trqvH/COo0RmJGlhBeKlb575jX/M+2KRWkBWiacIcq6FUsdWSbhSiWrvOR9/Vv2rNHU6Jg==
X-Received: by 2002:a17:902:ce82:b0:206:a913:96a7 with SMTP id d9443c01a7336-206f05e55b7mr10488645ad.44.1725582350205;
        Thu, 05 Sep 2024 17:25:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea37cc2sm33928925ad.160.2024.09.05.17.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 17:25:49 -0700 (PDT)
Message-ID: <da10663d-0496-4419-9ab7-91da3fd87199@linuxfoundation.org>
Date: Thu, 5 Sep 2024 18:25:48 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/101] 6.1.109-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240905093716.075835938@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240905093716.075835938@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 03:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.109 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 07 Sep 2024 09:36:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.109-rc1.gz
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


