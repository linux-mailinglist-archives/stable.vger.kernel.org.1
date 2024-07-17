Return-Path: <stable+bounces-60455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481EF934009
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 17:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FFDD1C21265
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 15:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D996B1E86F;
	Wed, 17 Jul 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eMcV0Fg7"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7121E87C
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231632; cv=none; b=Uvw4VfFEbmhJ5qwcvujoUiDZTLcFWNzLXmHshvq+mo7fKAX0iwe3RkVO2a3RNG2HRb/vJXHrklO1BP2pXrh85u/LMsa6fh6SsYvjuveAd5bJhz2kuVOILq/c0YAZSG6tb0WGTzm/fFZ2Ljh+8c8+5sv3Lzn72S7RZpdhzHirg5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231632; c=relaxed/simple;
	bh=MBMtHLJ+DVr4ag594rJE0YlnuRz+2AXsrDuPKfiYZqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGE9YdssKOt+FYU5xPUwTvQhCNrqpjuSfhVmccwJOUU5XWzQm+FximuXkZnI/GmlTLVBahazqNHamiEKSY+M6PdPkUpv/2IRvnV2TA7Cu7O1VHOrVFdUXZIWEahfOlvTwJ/IWMM25NgCiiWTdkuGFStOgNkarAdIKN2RngylTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eMcV0Fg7; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-804bc63afe2so4355039f.2
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721231630; x=1721836430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obXgQINbVfqbboodSk/JMK7xhpmmi58PT/EBrAmmKbI=;
        b=eMcV0Fg7PkMfMvQ+D/4sNQMIasI4k+6DvkoUTL8zCaRvhJ7sy6Fc40HWgic78csol6
         gCB5lNKqONCrlG3hSU/DaLRoa3amyXAhrkB+1Ohh2DF0y8lBg8pjTQN3niP018xSHG7E
         yAPAn3Z6KaDnPcq1REcOVaP0MSkEuHOKbK570=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721231630; x=1721836430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obXgQINbVfqbboodSk/JMK7xhpmmi58PT/EBrAmmKbI=;
        b=lju3xZ5A4UQ9oIopMjUOK66G4t9upVdt5bdMCRQgLl9n7vgVP6zVnv1aFVU4g9D1DN
         69GaqufjFoxpKah/OH3f4+SKfm1cmQk+xuzgpp7TPtlHy9HDPRhzWu6CRPN1qy5V3SAn
         zjjQQl1rfnG0qmdUAU80hrVAxKGzoDejk0oVzAVK4/FfcJfeb1H3MM3c8RG+WapRRA5f
         Utn8bvuGJo4SThGPVk7Ft6BWXAwSwoCKcjqMQfl/ZizDDc67PRHv0+3imJh6ZdW2BjQ7
         qjUmHHW20aH7XfyuLfVj32ll9onjPeFgRm/RoAWaO9rQqoqcJ8WpNQLtFYdLVe9jsKme
         n20g==
X-Forwarded-Encrypted: i=1; AJvYcCW3M8ypt/rox+EK6+Pf3OudhMHNq/wrcBx+HwEmIe21nytAUaIo2TOrbuA8+WsTr/voQRY1o3AD8CeJeAOZAdmmFB6+nl4k
X-Gm-Message-State: AOJu0YyheLXxQHPhSTuZot45th51lDx1nPzjwjW/qKtvyNNxY1K+5za7
	i/cnWJrCi6xUM0XILg8zMhurAMnpONUnhYpUGbxMkKv8NuUA66sYG4pMxipuzHDlckV4IBdcnK+
	u
X-Google-Smtp-Source: AGHT+IEFW7pms3EBMhQHP3lyWtsxOEdybprANsdD9ByPmbsmX7K4OKOQoHB3AaTr7G3d46U0Wi+Ngg==
X-Received: by 2002:a6b:ed13:0:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-81711e195e9mr150596739f.2.1721231630317;
        Wed, 17 Jul 2024 08:53:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c210f21da3sm736469173.113.2024.07.17.08.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 08:53:49 -0700 (PDT)
Message-ID: <ebbfa660-149d-45e0-a39e-a267095bae39@linuxfoundation.org>
Date: Wed, 17 Jul 2024 09:53:49 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/144] 5.15.163-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240716152752.524497140@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240716152752.524497140@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 09:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.163 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.163-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

