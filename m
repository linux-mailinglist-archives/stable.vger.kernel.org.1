Return-Path: <stable+bounces-185716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9D4BDAE09
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 20:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6D43AEB78
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 18:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629FD30B509;
	Tue, 14 Oct 2025 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oz2Mo6R3"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969533074A2
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464806; cv=none; b=kLmsSlZZRyISZO/y8xn41jZ8rqI7qscirIbP+9jNNgbuJHbfaF8h1X7EFOkQGRg3lq69q6tJR///tf/FvHZ0KrsCNMn0iYnR8DGqw7H0pEfHGf9YNunQM2L42EZdJZDjnjIyh97IxCvGpk9Yk3OPyVUAAMfOxeB75Qq++n58vAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464806; c=relaxed/simple;
	bh=21ukBTCCWgadknZW2SMkQg2BIIiZPeGfnkE/wF+Fy9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=baUg587nUpJCwg+UAITRcyzxn+VSbe3eAD00xoE+iYvXxz/3hiwgc8VqE33ZOnZeUzksO799+qTzkVs4dz8ZR0y0tDSSC6NjKE38YZUiK5zl26I7MrgvqhPSSXCl2n+a7+L6aaAaJa1jYyZewN0xJ27v7yQTdm0pgRFmHOYqerA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oz2Mo6R3; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-430abca3354so425755ab.2
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760464803; x=1761069603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WoAS4TyvZHgjNFjXDlSUMotpNCainLerBGX8bzDNj1k=;
        b=Oz2Mo6R3hoIpdbJpBi/6B0wo3OIU5/djPpobSyGGKIEHQ4XVcftOYFADm192yejjOO
         bwxlQLcymw1tnJFS8+iWkoisDy3yWral8fLhjDsW/mkQ+YJ9fPqYRlXTEclUBs/i05Fe
         2NjWx0+JZ7e83cuGfrolAINeEm+4an6w2TnpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760464803; x=1761069603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WoAS4TyvZHgjNFjXDlSUMotpNCainLerBGX8bzDNj1k=;
        b=e7CyHD2XXf7E9V+rfz4WJYpIAvAgYo3PMjLbL1cLAreie/X/fts9wpFAhN1+ekio5z
         seCRjpdxaT50KdNCFB4SJJ/MXKN6iHaLOR6VMn3146K6Ojakk23zApSlL2Ruhd1nvjyS
         1mp9ocSKH7tp+LpdtOXro9lIqOSU66z9ljwifzKGphBIzRTI6EPjQGCUAmVFm4E5PDVs
         u362rasVPjjM6cJj69/fE/J5ePhMKUUz+flhiRDH7BUt+U9VjWp75hAtTUQ/suVzUeje
         sQVKeifqo32MKb00k6N7/EQ0wF+MkM2we2EhPvwqx0aGwO8rCVjNoYS/dxvMnYq+m1P5
         U7wA==
X-Forwarded-Encrypted: i=1; AJvYcCX9KnM1E+G7nCWIuBiipkmaIRwxsKb0vrDNc1ia62RxK9IwBCoxbOoHgjJ4EDMeZw0MAQHVHsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqIUNAfl0DTWr8vptztJFrLCOmK2UTNT6J4D2gNBi0JFPHaoxH
	mdTpwJZv/KFrsxPZL65Mb+oQvO+/xvzWzw+EfmVEHCl4qOaC28q47Feq9m3DFYZFzNM=
X-Gm-Gg: ASbGncv2xtvryqnNb/sAg8SdxfgqhPQD/tEWZ3qC+YXCd7u16MCEelTpcBcGkBLo4II
	WlzVINtQ2dtju7MhWRwzoY5qjkUIQPHKwuNTBkD9z+5NVRf8UNMmj6TbdgNHa8NljEx6+r6JMsH
	cL7qQ1RbloLtUWffYoTUqtSURfRwElDmNvtMP/QBpFQ4+tjFsPN3gkFLuHcZ4tTGqcpkpVe+kFN
	WjvxQvjI1AZ66diNTo3ZPUaU9WDvDw8VFg2js3l1ttVnkurFhBmfSVbvGaJCatInekFoZ2qcWAe
	D7R2LaZ+FUl0DUhBXFONbedhJ9mCKNb3DDKlPkl14LInV0QMUVsy8b4/z6LUErEDW5ij0eLnqY8
	pUM9mub/2PCdQp7HgnlZI4Gju1ZBzDbS9UF6UlmR8PE+3HaBfMnzl/vxqlQ8U864w
X-Google-Smtp-Source: AGHT+IGs+0qZ3roynS5JzK/onWLpnh+nlFehYpcK9FuZyG1lduY4TIIg1ukL/IPrYrEz/ELyjmlwjw==
X-Received: by 2002:a05:6e02:2501:b0:42d:8598:410c with SMTP id e9e14a558f8ab-42f8736931bmr330675805ab.10.1760464802510;
        Tue, 14 Oct 2025 11:00:02 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430a3869174sm8014535ab.15.2025.10.14.11.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 11:00:02 -0700 (PDT)
Message-ID: <24b09edf-7f27-4f01-b745-8918da8b3c37@linuxfoundation.org>
Date: Tue, 14 Oct 2025 12:00:01 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/196] 6.1.156-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251013144314.549284796@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251013144314.549284796@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 08:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.156 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.156-rc1.gz
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

