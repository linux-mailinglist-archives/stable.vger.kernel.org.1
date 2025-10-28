Return-Path: <stable+bounces-191539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C91C1699B
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 20:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019E61A25443
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 19:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8C234DCCF;
	Tue, 28 Oct 2025 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="huIY+8IS"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED234E750
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679494; cv=none; b=Cp4PArm7OC0l8pvBL1f0dpO/r7iU5VW1BtDiqTsRsB7CldKAiGYxfZ7eQvxG56wBXR5YhomYsUd8wZWXjAocVmEsrI9Odx4KgD+3riRESrPBs90Cm2FlR430hrVJ1jxoQegMDTnWLOMnoi5i7oNfPbcGlE7iRF/+P4O3H2tC2Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679494; c=relaxed/simple;
	bh=YOYUi7F/Hythc5A0zuG6/J5WGc9v5JfX+zO66GNLWY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mlo2o4JdSxvcvAXz7wYKC6EgTvEoSN9MNKvBljrCJJITl2fzvBIHM8KdovERDe0zVKk92kkcPnWqn4/qNUBeS5vZnTFyyDLHILJff+fbCMOrz0AAFcIG3b6s5lwByhVwkZUE6vIpAEZnK4PkxLLVBSkcW5RipXeBEJMcJiLpMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=huIY+8IS; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-92c781fd73aso614193539f.1
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761679491; x=1762284291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lqnf9jST7x/NcmXslhQQGVDr5TfMAmtc49PlrfRjlHI=;
        b=huIY+8ISk4MuXmEBTyxPOVCt4ybIQWqPK50G4+y55z0IBIsCGw7EWMorKa9+c3Ad8A
         GIbrkvIZUJGg1xg5syuRrbkACLKy11QlM05+LtNXxWx/7j3epgrMaXbrK8rAVJ41IArw
         Ik+Q4cimZApbHqx8gJdnCC0M7l6irtucl3sr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679491; x=1762284291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqnf9jST7x/NcmXslhQQGVDr5TfMAmtc49PlrfRjlHI=;
        b=NkJzF4ahcetjEfns5Sqh/QyqBOA9iii2bFM+QOamPSqwwytX52DsL+PewdGIxMAPIm
         89DrZ4v3biSAePpHIsJiRnAG6z89FwPxVDyD0h51YVszHWxZkkE9Sz1c7tudEZGoh4im
         lXlzyST+XevH3Em/P8/4QkxVsPGtAM0ClqB/axThDxJ94ZuOCLwJ00954TV5uyBU2neO
         bLyxIf9D5xmEpEwE/DhuhU0RE1VcS5J6rF/l85648BTNrWskT5LJNBtOzXXDQkofSm2Q
         zeTbRXzD5CuO5eXM0+4yTOvGf+Bl5i6p4LH8YyQy4WVomJ62V/oy8/CoHzVsPShBVq8P
         mDWA==
X-Forwarded-Encrypted: i=1; AJvYcCVBaPTd2yYOZAbSXBejZyiz/eXp0iruAVTHrXapo8BXsdmNQTYjcWTJ4nDMSvDqZr1DqkjSZXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyJK+/p0am891u34SdFfMhS/K07p3wTmAlhhmCEs/hCsewQ1G5
	ynfxLPLR0j6xm1o7yzUKm9mOzILVftFa0n81Mec8SQvdDSWXWpgEaoEDqyri5uw5ePU=
X-Gm-Gg: ASbGncuHWyD8hnCU3/zWFHlLSRJa3gHgRpz7895ukm/2G1x4ZhTcDYodU//O36ADIjk
	dJtkHPwjrMuAi61ZPTBsE9g8UBtGWfrAoZmPBm7VmHFg6Y3Dm3xVwuhZW5qKpKrngUIvEM3OLtX
	ub7OhLSgwAPknev7x/mfD9yrIophE+dgk+Y+RvFZ03Bh/sclvZU09diFkEe6NsS9plknNdaDI0L
	ej70ypj2GD9uKzkALn87lJPu4tSQQQqO/ifbatyK4pB+4ttIfrAg/zYquxxt4iyVTRTI3f4ZtG7
	vAg8IN86sz+zsWucPR4uZYn4Pjrs+VOpNG2EoCHNZhUHQa189I9Fhj+6xG32SRfiMJzOMH5ltgu
	9DHRoqY+nJUB8J22s2ATn3js0DUpLOf1zg+f4ZaTZMGN/6wGlvbDe+Xg+W3dpZAbDdrd1c6ObUA
	gz1FpYxUIyw5+Z
X-Google-Smtp-Source: AGHT+IHJRAuHzK+xQWLlPVLuJq+hr1sweTNjUYhc4Dc2I5aDW71o9ZnEGmf8KK1Q7LnIfXad4QIGZA==
X-Received: by 2002:a05:6e02:348a:b0:427:a3ef:5701 with SMTP id e9e14a558f8ab-432f8fad698mr6072985ab.14.1761679491258;
        Tue, 28 Oct 2025 12:24:51 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f68747b2sm46442155ab.17.2025.10.28.12.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:24:50 -0700 (PDT)
Message-ID: <ac5ddf39-d8e6-4655-829f-708547bd0fdf@linuxfoundation.org>
Date: Tue, 28 Oct 2025 13:24:49 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/117] 6.12.56-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251027183453.919157109@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 12:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.56 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.56-rc1.gz
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

