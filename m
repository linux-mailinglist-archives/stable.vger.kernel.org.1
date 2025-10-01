Return-Path: <stable+bounces-182967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF11BB1368
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 18:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35063C4947
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 16:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20DD26D4F7;
	Wed,  1 Oct 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OSAFeM4Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA186286892
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334762; cv=none; b=PNHLJoJ7+vB3pshVFR53n1GEjzbOP9dmGwlCoSDy8wsqS+reFmDneyOHTALPv405Ni3Bye39XisTOIhte65gUROizvDLWlC+eHQsZGm3eknVx4j6OHBxhFvWDGQxdZZHbju46DmWLajFAVPybI/WU39g0Zzb5rE3LDuVo1S2tN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334762; c=relaxed/simple;
	bh=VJHEaNZgpUqWWb3y7GCl9yOli6rthjNjxN6lV8kjhCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqLUbyhu2/hTNSJUKlJKOPd6f88dAlJAXBJGDDv9AJsUTVq+wsxy0uQiPtwUnCE/6Uti0T6g27/uJSh5kFAZ0QgmFmhaAMxGID2sXLSHN1SkRwAI/w/L8rlIHeaAL+4RoZhYHUjCz4O3HeyoLk2KJuJLw1XzgV7a1HQ4WgdWcW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OSAFeM4Z; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-92aee734585so146881539f.3
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759334760; x=1759939560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VcoX46bwfl5dQYwcLHAK7OapTp8NlFOAbc6NCmLaSLA=;
        b=OSAFeM4ZGlo4fJWksfZhr749AZLbZ6ebGTQMgar+oipRBk0YiimQewEu8LnrXqxTnD
         OZDgwh8nPTm2sPi4uUwABYYS3kh+92XSvybo7rcowxCLq5Vu29idnz8EQdd+FgxjnUr8
         jbPxAXc+8Vd2EXjsB3/CCb0g6hRG6cIFt4mkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759334760; x=1759939560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VcoX46bwfl5dQYwcLHAK7OapTp8NlFOAbc6NCmLaSLA=;
        b=wFwRAfS64uUo1MX33MEEZ798f0upVNfRJP5DgMrLyrimcGiznCN0/8waf9BblPJRud
         5X3EC0e+EPAlm8qPqSuz45FtMFAQ4H14/OGbmeEVAHMctmPZZtO1dErSzcKFq1uTIyie
         NHpwwrldXDPtRACKQXCqg1ocFUL8HXvH5mMdf+3oCCDCpvfIqVkjP0QA14ZTHKt+8oRa
         l6N6k5ynu01EBTyCKlweqlW7+swctD2lvn+nJZQZnMbPSmZz/h0fEUYBwQAGPN9zqw2C
         pbQ1L5ojOU09KGrdm9Py4EhPyurDSIjI5Yao6jJKnnKHDO+4ugWoZ2qK3Dw1jkYOGW5p
         06uA==
X-Forwarded-Encrypted: i=1; AJvYcCVMApM/BsZFrukzxxvoT+QgAABs1gB8+47O8CeXohQBWdiaCDB43dfRqz1p46TWqs7b3j+vhAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCVMUjVyxaifoCtcacnEmkaHdI9rwyCHWyhqO7WqawIUmYtLus
	eDGqg3y5gpXTcD4OUARCaUh6Z5kxO5gGyxUTl1K4hCDMp8dR2+kngtBL7uEPQC/Kk3M=
X-Gm-Gg: ASbGncvT0CcQI4Ti+udaWCnfMW7JmhnEGh1f3zQ3C8s47uc66u+yIrONU19CBxgmyWC
	gljRluPZlGhc0wZ2rrGQXTK6EOWxSpAxHmEMKVHANVQpE/7o1z6+ywaxui0E0S4CQAU/NRymBxF
	p4x3FByfjwFCl4TozcVtvkHsEdhTx74aYwbNSLs4deAxkmwKNmusn/PXu11vI5m9i1ZgkwkCXoM
	7nysXegFf/vqxfyswGJH+I5LQHkT2EPgYAHAt9CmHDkT4kNoYH1YdJbuMm60aEQBjY9Xbq0ME3n
	gNBt2NbBhsLf0Rzo3z1sE2N6l/99D1pvAdQw7MFFo1nhauUvBPcbWwjHzJw+68GlP6iLtn3/uJ0
	Yl/6q3gRI06trFfqo2JTWcoTjClV+Q0gM3Tmeu/fv7jRde5l1Gsw0VouvFyc=
X-Google-Smtp-Source: AGHT+IFHk4Xwk9RArCCX+gxR924eyLozP8mlXDS8m3rsfRvOu87qimTOaq2cLVy5Bc0FK8NNNeMH3g==
X-Received: by 2002:a05:6e02:17c7:b0:425:73c6:9041 with SMTP id e9e14a558f8ab-42d81617930mr55114785ab.17.1759334759664;
        Wed, 01 Oct 2025 09:05:59 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-575e72881b9sm2514685173.47.2025.10.01.09.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 09:05:59 -0700 (PDT)
Message-ID: <9c617b3a-7978-4906-a749-98d6ea1a944d@linuxfoundation.org>
Date: Wed, 1 Oct 2025 10:05:58 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/89] 6.12.50-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250930143821.852512002@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 08:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.50 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.50-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

