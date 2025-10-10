Return-Path: <stable+bounces-184039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5EFBCEB0E
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 00:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327225458AE
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 22:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3079B2737FB;
	Fri, 10 Oct 2025 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dDP/9T42"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CC6275AF3
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760134902; cv=none; b=Brx2N2ll6DMqkEW6/gN9YgTFPMz2fjgSvRk1Nwsy4U43dNAvcm7UTH37vx5gNvNLglHWAeLYfjADH4qngmCGqeQwH59otmSd0rTavjuLYDYMyJd27SVtmbzhhSg3MMBHTxymjovZFidXAsT3IoFpNSbbCrGvvFHBue5a246793c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760134902; c=relaxed/simple;
	bh=XhP/COLjObDz+ZGPI9jHrKcT9w6Zfqb+6aYc6UIknSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZNEU7q+fZr8Dy6oCKuseUMoPxv13a2Y10VpAe/9R6iI8wMxtdf8nugJAr1la8v5X7oO9JbRvFBF23ZvCPnyYSapXMP+pBcu3X4Ak7pHS4lUGIbaJ26sCQGhwt+/korFLqUdZ6GCixu7VfIvCBr/0kNvljCIIBj39fFyl9Ok/cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dDP/9T42; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-42d8ad71a51so26868565ab.1
        for <stable@vger.kernel.org>; Fri, 10 Oct 2025 15:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760134899; x=1760739699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1XN8BJ2wM10+ueceH639Pxl3TfZtOWY8UGM70jB/ZlU=;
        b=dDP/9T42hjBTOwLrz5iyBZtdmpoLadYP6g1PiyqTgBfk2heNHoHlB2Oif9LFSzwaO/
         iZZrj7GnvRXllUKTczi5NkY9g0LEceJMobyxTIlK5Ub4fQWhQf9n+V5bzImJ3GY/bWMn
         wvZaBKwv3dhijnS2R6CY/KDkdmtm75SGs8NQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760134899; x=1760739699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XN8BJ2wM10+ueceH639Pxl3TfZtOWY8UGM70jB/ZlU=;
        b=n8YjUmc4A+XV+qw52Yv6z8G1RnCezyxdG1mkE/dbnQFbIiiFS9gAW5WTjPdiboA2i7
         XlrFCzEQecnymsVY7lxUxGZq/geORK8s0cILldFdn1dABTvzDDrSL6ekm41fCijetptj
         2DwSKYrtoYP/P+3j3AAPGXtZoTtZxrA/2NBpVaggSKah/plaR9jRr0GzZW65KdM7l1xJ
         /R6vN82HPa4Emqq8k6JD07nzzJo7Gg26qIw+dKlNOw8GeZ8JR+BIVX1s6PckT3zx/Q9v
         RgKTlqmhl0962CgOrNvBOSY1wBwU8oheg6H5BHb8Kh3dz3DVfZ66RqApViLTrmSxTEfR
         6tLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWxqt8AAkgGm2jsXH7l6MQGr7nRCTlOwWMQRSy0tweste0bOQM14VgGDiLszAeYTDxorGjWsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyps33gRNmIk28Rsw/6kNwFjzj582JrK/gsj/h69+kl+wiMJhR+
	2l7IMjMsgKOmPC/l7gE/OV9OuRo6aTxKx0xRZCIfAEW8zyIKZDC+npxMODkGU3bBnrw=
X-Gm-Gg: ASbGnctHcKYCWIJHBl1KSrJGcBQSxTvDvCUX82rkgVpHFm6u8G6OdIu1dXx26VK/QQe
	HaVDnUfXnrKar+ialptYFgaUF8q0rDn19ihLC8j9YId/lNqIcbXzgFpleajh2Vy9JxH/jyk2oC/
	DNZNtejowIdCB99ssDWO0kOAHOmagbqgDjqmIgXnnnmRw7TO6RjKgW4kzBmG/7VVzfgAkQODRx5
	nlhbXOATXhMLttR2sO6hDcHYbLwtWjkwwM0SAiwWbbV9vn4WdNlZub0KXGIBfGHKybnd+4Hgnk2
	Qkx1AXBXnVCuG5lcdF3meBce3geeS4pryHtz29hYdRP0H+KyrYtraDvBgqdj4vGS4icTc5zQ0Ot
	EMa8N6fWFhLQwZFvfiKWGGttNUUYS7SR7C/4F2ci6vNgLaWd3aC3RQQ==
X-Google-Smtp-Source: AGHT+IEaOdM6AjtKS6UO4o7mdcrBSBEqizYrTv7AtuOpOFMXKvh2X+ICbaotUhVQZwNOfyX/mRTl/g==
X-Received: by 2002:a05:6e02:2286:b0:42f:94f5:465f with SMTP id e9e14a558f8ab-42f94f5485emr99584845ab.29.1760134899305;
        Fri, 10 Oct 2025 15:21:39 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f90367296sm23828295ab.30.2025.10.10.15.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 15:21:38 -0700 (PDT)
Message-ID: <1c714af6-fc9c-4de9-8f8e-347c3ca14b34@linuxfoundation.org>
Date: Fri, 10 Oct 2025 16:21:38 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/28] 6.6.111-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251010131330.355311487@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251010131330.355311487@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/25 07:16, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.111 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.111-rc1.gz
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

