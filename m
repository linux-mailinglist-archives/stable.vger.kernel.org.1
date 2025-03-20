Return-Path: <stable+bounces-125683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DC4A6ACFD
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 19:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0726884341
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 18:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F83A2253A4;
	Thu, 20 Mar 2025 18:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOQzhtM+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC4D2AD20;
	Thu, 20 Mar 2025 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494633; cv=none; b=km/K3omJ9H6YUuxD34rYFNfnAqW8nHxPRZVrNzwUqQjonaoGuHOh+04h2RrQpD+X6uaJXWdeML2KU6drQaVwbCuTfZsMHSyvsCbaDf1lmmxVjKKW5071/qYM1BDH/h9/o2TRMBi02Xv/N4s4nCIQfd6lI6HLLtxI9LZPqgvdEKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494633; c=relaxed/simple;
	bh=iRqQPUjm4Jbck/ZDDtEyyulsp6kilrBZXBH5jUjm3NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0A9q5GZdfIR+BU/i03Nz1WuRni9oQvadLaayBJhvXY06ZRCuPvjfzBTMS5O7DX76kJoM3OeHsPdHGjIl8/KV3G+M07FMoXS6hMe1DwsIIDV4ys0plRPkU6edgDEEDri0EImmJmJ+OS6Cc2Y1ZrEE0y1dr0ShgLhJdaFSwUeqX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOQzhtM+; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-728a433ec30so1300259a34.1;
        Thu, 20 Mar 2025 11:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742494631; x=1743099431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CwDBAT/Af0zZKGRrNblLi7yCCzM9eZLOIICuPIX/dME=;
        b=eOQzhtM+e9yez6EWSNDEw3wpteDGa6xLZE1b2M6fliw3w7d9xzz8ObRURhv7j8fmF2
         5HjBLVpOiuyUkhhMdh7ajMWqNbL9ZPUBbreS4fDeAo3YpGY81mEf8qRKVD5uRuj7aQcf
         fc8nv6eN+/Id1GigW8XhL/B4JO0LVuBx193MK7OaljmnxCQ670KNOBvJXXb2YuTN4R/V
         ar+YqSotoul/rNknIR6gFfkLPGGWCSubEoy11XSlItpEJEgcqOsIsKyR0cObJ3YK7wKx
         IIHhZYEoVmP8nF8FAnEnwpLXYtklOEna/2XRCx3OASLrvLJ3DtXattd9raUJ4Cu6deN7
         YERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742494631; x=1743099431;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwDBAT/Af0zZKGRrNblLi7yCCzM9eZLOIICuPIX/dME=;
        b=hXFjuQVU3ZPUabjWGSJ60TO2DOsGzWftqKTbQJm3Wc6dgVyY5RI3SYBCp7VR5Yrw/P
         5cFXfCVyz4kLW72J0RagS/Gg+3xhNCbyuQMQeNavDm60BbpQdTkiCR5kUhZ/U4mJWLt8
         n/QlWleDFpja/CxiWzUQUxNtwT7fumYpZ5Zf9z/G9gErH3E9KjXAiVyjC/CmYX/GW34O
         tuEv7snPiEVHRDYmLaf609iLrwnIcKxZayJLngZryuk/0jbhnhQwiaBTn/e9MSo+xoJc
         w64fz/Zqm8wkWxpcyas7VIhIAJ1oGHZQzEDFFwc8OrIXthBY+hC37wfdfEsprUJ8Ll1E
         8AEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFDbZqvaAsOsJUIEV9uWPX7SBwAK5GJO38PkpXTuU3aNjdlPXxa88ZIEoEInsf4Th6H2yh+Nzk@vger.kernel.org, AJvYcCXkuDEMkNsA42wzkfjYu1j2pUV7GtJqJFAz+SAQfRQHv6BBuCKRCW6eJ9tfFwZyXrs2UXojC79+GBO09Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRyPH7e+5duyRsjJp2XR1v3hKVHih1dM1OTQUDcMgW+opECj0X
	hSjRy076vyNhISOH7FQ+YeehGafZy/1DTBHTsUobX1RFOKcVv2r1uN2Bdg==
X-Gm-Gg: ASbGncsbUyOWO0zgzzgUbTquaS9q1SKczuMj8wmUNIYlWses+8t0G4U26VOlg16LYU0
	KPTfvy/RibVGmsVTc/SIkF/1NDFRpFUXnh5nfgNwyk/8o2PkH4p6+bIJYWuyYf5dznC2aiyeJcK
	TVzW/g3zZ9dw0v+PA1537Zq/+g+ZGVAWTbX/AArSNTad+yhHu1OD9vid/ws9ZonDPjHxhWqsWap
	Yo7NWnyh6FGVjE6dYvqYLF4nl9OHu/5pTIg37vLcNOMKVquW2+DkusEXCz0dkZEyW8E/8a3MbYr
	ub27df9tLiOU6MidVGRaZDJNlXrSd6l8euLSuSAjcUPckV7RUcb+6gSH9bwDrsS+Km8p9OeuEA9
	zVusQd65hoqYOKXry4w==
X-Google-Smtp-Source: AGHT+IHbp/7z5rPkbfY68AYtLKag4JCSYiCpNSTmkp7RimhDVoA4ABpc1+i3KgZ8wUJH69bErxJbfA==
X-Received: by 2002:a05:6830:dc4:b0:72b:9fb2:2abd with SMTP id 46e09a7af769-72c0af02785mr261325a34.20.1742494630680;
        Thu, 20 Mar 2025 11:17:10 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c0ac7b966sm39887a34.60.2025.03.20.11.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 11:17:10 -0700 (PDT)
Message-ID: <3e1ef48f-9336-47fe-8331-a12152fdbe22@gmail.com>
Date: Thu, 20 Mar 2025 11:17:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/231] 6.12.20-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250319143026.865956961@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/19/2025 7:28 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.20 release.
> There are 231 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Mar 2025 14:29:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.20-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


