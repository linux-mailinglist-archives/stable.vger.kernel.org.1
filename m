Return-Path: <stable+bounces-142872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 030D0AAFDD3
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57223B25FE7
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 14:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22A0278E5A;
	Thu,  8 May 2025 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LVufCD7o"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBA9278E41
	for <stable@vger.kernel.org>; Thu,  8 May 2025 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716015; cv=none; b=jj4ukd1AWqQTgwWrPndpMCh1HxW6bJHvNpNI2pKOUXl+2ZgtWc72qeYPkAbKVmYydPdVre0/0xgHsy4SZAXFhOzJ7GAnaBWro6p87J+g5C7ehaIU/5uyW9mWv9ehwlPu9aYgad55onF/KUxP7z5kVItDQ2n166onq6mu49O1GrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716015; c=relaxed/simple;
	bh=odtgSXwh0bCzCfLwxDrlyXiDnmGY2jKlNaMTO9n4Odo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/8Wgx19ooNLL4faWJVemZtd+35TrPaLNYClh7ADotXbP57w+FDnCt3+lbK7EHxGWMiCNR6NJAay6/eHw7AuGeyl+Fx1r583+BrwoTrwdXE4JkZW9Y4F2D4SmKtfsLRk8sqnieRHfuCv73ELY1Dy1wvHd50YLlCRb3R/LP3plLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LVufCD7o; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-86135ac9542so42805339f.1
        for <stable@vger.kernel.org>; Thu, 08 May 2025 07:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746716012; x=1747320812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gWrVVNVJo/P+Yuo62NX1HsdonWLhPO6Bwy/uZRZodUc=;
        b=LVufCD7oxqvo45XAn+KFDNfLyUt3OST1xWy4mL6JVYzjvbAqqPuH95oiE3fgC0L1q4
         nhZAgRYtF8wxphb+wPJRgDgTXgt4XNJT+6a+4yVY9DU1MXXKdCzgqUXpbxOoBIX4oIBS
         roeiTBU0WMr4RF+wbuvhxlMj36iDPldipV4WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746716012; x=1747320812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWrVVNVJo/P+Yuo62NX1HsdonWLhPO6Bwy/uZRZodUc=;
        b=kHDR5QChLxNNWxW+VsjHaqZGBNfcLdW8PaQG+nob89ayBjHxEHFXoQ30DbdueiJoOr
         sxK87/vmzP4R9uYJ48LMnKBrtzO96MWY+7pYmiBqL22JfDc0KaLD1VH4/adbRwgi08R5
         9yhrPuJsLR0kG6hbHXwUQ8Web8p551cJiMO03ZWJX8ubEgEj922wrsg5ne17l1dMGF0/
         3k5qgHIrSO86C1uwA+O05SQQga0yt7cdWtOCY+Z48Ao62NQK0hvyZBpATGMb3LprBP1J
         x93hjrBTDtq/kyxD2jBUf7ci2N8f6ZSN8HjcijFxD1WZs21HSaBwL7udonQGqaFnWT4G
         7Ccg==
X-Forwarded-Encrypted: i=1; AJvYcCU9VKmqtCi60svVwL6KzWOcn+4TAtmeEMg1e+Fu8cGHkcsCNUOEu1ezt/RxIpbaIEJ2kZtw8qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGjWB4oyjWvIfDZ8HftrbulhlwlkyUaxKHRO/ycGxKr+WsUKC
	E3K/Ndnu5DQZLhGNtpz8qFHHlLgr8r9B2WfGYxm3m/QVcJGytJ1dbIjDOWrWqA4=
X-Gm-Gg: ASbGncuyXTIyKgeFjRBjP9jDoQ+4bEzHM/TnaT9X16se4IoYpXL7TD8Ff/ACOv9ucZM
	6QeYT9bHe33y7N7asUKO0c7sEPeDz3ipxx323kDo6XD4AuOITPECMPDBXZUJjwlko44NpF5T7E+
	mycRORjO6WfFQ+XJ8p1mZD+h/C8ET6pAVsQ8jSonO5ErWQ0ewaJxIUMoRjCphNK2hZKuCJeyATj
	IQKitPW+A4Nd4W5AOKPdddYrq6loS1qGNQYkt5aIwoJ7mN2oTlfA72VfhXVjVtIe1BTyj8MHRFq
	fXB8mrUDQ8Z82plWa5dMh4VmCKMd61k3yNmTc43DAjAysQZ8Q0M=
X-Google-Smtp-Source: AGHT+IEwWmhE/+y7H/n+FT285k0C9IJ/JV2prQ46n2CbFOH6T/B5DegUcSij7J/6yY3M2ZKgO7icBg==
X-Received: by 2002:a05:6602:29c9:b0:85e:16e9:5e8d with SMTP id ca18e2360f4ac-867550e2fdemr524506239f.7.1746716012533;
        Thu, 08 May 2025 07:53:32 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a917564sm3250822173.49.2025.05.08.07.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 07:53:32 -0700 (PDT)
Message-ID: <62541900-5287-4fe5-b2d7-7ae182d22331@linuxfoundation.org>
Date: Thu, 8 May 2025 08:53:31 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/129] 6.6.90-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250507183813.500572371@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250507183813.500572371@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/25 12:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.90 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 May 2025 18:37:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.90-rc1.gz
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

