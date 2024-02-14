Return-Path: <stable+bounces-20130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D221A8540BA
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 01:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FC7288EA6
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 00:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2035E7F;
	Wed, 14 Feb 2024 00:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J4JtaeP/"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9E8821
	for <stable@vger.kernel.org>; Wed, 14 Feb 2024 00:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869610; cv=none; b=VpQ/a9y5SwXBZJRQd2VK6ztfyn39jka8sxM1zeCTapHwPXIlr8+FNbsvQ/DlEcDRg16m4T5hKM31MVYcCiq1WpiNtajokN1B/nhpiCGGY0qFCcp9qnleRcJPUNDGdwqXoJcUWJVlWig88IdPV3Tou9W++P1BfJoc/dV2x4a2zYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869610; c=relaxed/simple;
	bh=blGoqFSG+bM4MY2OkxkXog0upiI3/Y+AsY70uk/SFk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bI/6B86B3qtb97p1Qrb55YDCUs78s5Le6b/CFj6UP3prnf3Lk+O3y+UCrJwllUC1o/N6ycRfp641ITN4nPvqDi6RF6tEOkestk1/zyKpsyYfHxWsQJ59wj4M2TLABxPKwDFeNPU6+bi49+Agp72E8U2IVPU4Q/AEGdjYGpH8/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J4JtaeP/; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-363e7d542f4so4491655ab.0
        for <stable@vger.kernel.org>; Tue, 13 Feb 2024 16:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1707869608; x=1708474408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yPDqGsGVRBXi/v9PW7ctsmPDNaShTV4LQ+ip6JTA0Hk=;
        b=J4JtaeP/x+wuBKqvEEml+awb8N6ipO6TEuNzML7LOHwn8uofV6SX7YHnGSlNXBwZXd
         +DgkjEkH4DusgRJl8yU3eR8lX1sEJTpKHeclf2X35Kyq5Kmk/FAjLnccSrvEwVrbacDq
         h7d+C4/4jOj13rsJ5OpuvnTXw4QV1cUabFY24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707869608; x=1708474408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yPDqGsGVRBXi/v9PW7ctsmPDNaShTV4LQ+ip6JTA0Hk=;
        b=LNq3icGxcyC+pIPaJwgTNoA2d+OhE+gGXDJ7MzjLaGZVFhSCRXwYQNImOkAXnm+f1J
         fcogks4X3C+cN9S5HoseaNfD0biXnG9zHCI3WBStQh8vKjBTPHGtju0+7rQD5KahICaX
         8U1U2aFgNXt2n57bR5ZNm7q9fZWoKm3AbOWEPv0ovX/4VlkRACvyhqyolTRQBc3ERdIC
         8ekAIIZS7zvluPvQMar0evWnSyAW2CP9f0jj9OxDpJ6kqQtS/SnTauTIThJvQWI3vj5r
         T+0AABDLOa+e5BnBRQGWAGcVnJM76axPpMG+BE1RFt5aKkiwVUZRz5t2yI/t36SHgmp+
         +kPg==
X-Forwarded-Encrypted: i=1; AJvYcCUL6JC1r+aF1+GrJHbdohFFU6TntCm3bLt2DwjG4mb5l3vRqKvQ9PzgG99XPkiJtnYI+MP2JnbaU8WKVLGKqGiOxGNIRk3e
X-Gm-Message-State: AOJu0Yz7WpL4AsvQXd68nE+NVnZ5A/3jH06g1W8PERqiOlV9G1DzVCkK
	TwtyeEqTtzBlDWHf3CNlNPU+EygIP76JnFt/8ufimwhtx5D0fYZuEjjcZPPdVRI=
X-Google-Smtp-Source: AGHT+IFj3DIzE8TUG3KuUciUIn0QgQ8h3JK6FQ/JtamGNxaKJ+e6Cs9gS1k8YQ4vLigeLUxYKfVwKA==
X-Received: by 2002:a05:6e02:1b8e:b0:35f:bc09:c56b with SMTP id h14-20020a056e021b8e00b0035fbc09c56bmr1410174ili.2.1707869608280;
        Tue, 13 Feb 2024 16:13:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUlRfBRzl53Qpa1e5k4sZBQjm6mmkehiuSVkzvDmLjCCxZQ6dHTfpladZ0qu8fqLi1FYonvVXAq6JIvnnis3b9fJP2R9/PyLh/9m1L8dIuVQyxdu7uF7RDTs93CIzbrWK+VWnsngZyogbd8xrT7rObS57nyqilAWdEJ5ZDDSBVcsjE/qnFrLF82j9BPBVfawKiua8L/me31gsAVPjjS8Dq6M/qqFfRIeJOvopZdAVFd9a4TgwmChgW4H94d/N6Or9jquGBsAsehslOf/e3hZoC5j2nh2+EsICBXI/VdXAMoZMEt5n93zilacIgQO3aamtPQ8qHCqZrlLvVErTIHIjsUpQkTNplO9dGK1h4STPhC1jRuGb5Frc7wewX5OeaZV55ynWOza4hEWEbI1KruA6q4f5/NxBAytyaajsCoEb9jCDV/LOx4whuZHuFE/KPnC46iNS+xgNcAj5lpY444OMhrU98CAV6OleVbascJRkIuHGBPakBcOM/VBgvHx93G14retu6GQQujrRtL8mfGENKH4n4HvNksgyfD3Mn1CxsgYbSAzykZXyCCgr8xuDUBM0qcbuM1epZcJw==
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id z11-20020a92da0b000000b00363ea1209basm2752707ilm.11.2024.02.13.16.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 16:13:28 -0800 (PST)
Message-ID: <5ff3912d-abb5-4049-831c-81a3bc8da929@linuxfoundation.org>
Date: Tue, 13 Feb 2024 17:13:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/124] 6.7.5-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240213171853.722912593@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240213171853.722912593@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 10:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.5 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.5-rc1.gz
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

