Return-Path: <stable+bounces-209972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A39D29365
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 00:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0D24301B49A
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 23:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4C52D7DF5;
	Thu, 15 Jan 2026 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/1/JcLK"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBFC289E06
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768519086; cv=none; b=kET7cA+jhUqZ3Cf0mbszPZ2vrpYZITKvQHf/OLoT2iEkcBElLNKe7aJVBdk5CWhHNdE1NnD6kQjLbOSaBTbOhOEYr1gU5Jg+uDRi4MPTMuT5KtkCGG08juXq137Gi1Pj2N2gnipo+C9VvLueYdjLOyN9/Pr9fMlQGOwy/udG2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768519086; c=relaxed/simple;
	bh=/a5h1NXFNbjOAe8WM6ey6/NlRR2UbEGzdPSE2qtiYFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGEFGFtRhCZESdfIboqRB2vaoeuBsf8kk5os2mogbkUtijAgkhxAAY0CPoXBE1E2tEETXQx4bHHVb0up4bjVMNIv44MriyEDEcaqb+RqDEHbXSlJiBA0oGCJhHDnCUQrTuPA1dwVUAuURn4AMkTCncZJXCzLo5wzs9iJWrmWjAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/1/JcLK; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1233b172f02so1819726c88.0
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 15:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768519084; x=1769123884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y4+b7fv+uiyrdpvSXYwwLEsO8D8We+5a8qlvZcop0Ug=;
        b=N/1/JcLKa96/5EI2z7DJBYmWVMvJ87Zb/+pIs13eLx9jZYLn03SEfEPlDYSs/x++bv
         uWwacgBJl4VDjDgJHkUSh+KxuHu2+jagMBFLh9D1Sb5TBjpylNKxXuCUXl7CvYhquiGC
         UeMdJDRCt36+0154kywHf1aoWIyfbZgU7CHojUNAY+4fYtv+DLGbqRZBMfO2/+V0XUiH
         a369BlA3XEm6yHjBWil8wMUfpPG6ny5cTR/8PoeVMceQTKbrckXacQxKyIQgOzrpJHg1
         +9bV2IXGpApWzBUu4tzLY5de89RD89AgPRF9xK0eGH9kwZaVPb8SYFX30mNrDhG/QyBn
         uEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768519084; x=1769123884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4+b7fv+uiyrdpvSXYwwLEsO8D8We+5a8qlvZcop0Ug=;
        b=Yud7pzD+SC5bLridTz6GqvSzi5BKM6xF9UXZBNpEP1sMGb9DskhXsYMQH5LlAnuUN7
         Y8G1bzWos1RySeU1CTXxZ/tEJbDsLyoRVKgqnS6FRDa+juUHoPUu1wYsP17+zLK7SBqD
         r31yEVQGT6yxld6fKHrwyKGZG1TJdD166z320gjcbtiZFryZqlLDUaRxrcyDGiTPCfDP
         P786AGHORELIZXp4jPF66XGRzWnHykLdsN6+eHmJy0rF0EShLUwNgi3Iq/XeqJ00yix8
         jeJ+fJ8eyESIOOhzMlCmLE8XKRaII5qnimE2e0tyiWxLyZpOFCSjnp7zbSW7B8YJpAH0
         8Thw==
X-Forwarded-Encrypted: i=1; AJvYcCUE0lsvaHHNdRJKaNczhvWwnsfu8RPQlJccSHCf88AvtFKxXi6Dd1N0kqyTKqRkQm2c6m8oDHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMf3LuU1Jh0I6I4g9F+iopc9KcCjP7gAI8tL7xZDV6jWma9OWg
	8PPXVfXScJNC0aiGiiUQVR9mYJlerJnHq7zXIyyv8qqhIFqVkyeCp4c2
X-Gm-Gg: AY/fxX5k4lasO1rv5Olm2BJBHanJnv82NwgP9emZ4EGkYrli+FDzXxCJjITLZYiBO03
	vyzD0aR8cTpKpEp3veHYGft9W7Fd1dz2a8fB3JvsuO7P0HWvyHB7GmADcQwNbcDOv3pLi2WoN6w
	gzn9U5J+zy4b6JSyDYKm/05a3tD5b4V2iDSUJQZSOVU0Kg6aDX/KegZm/rAdTeapI/1ajll39Lz
	8g1rjOhVoSStbL6Ez7UjtI6hJVFpT4G1erG8E1PKCqgBomriF1WIqwue9P8p1Xc2KQI7KDqVN3E
	v5x4F7WQZlu3syJzMWIaM9Royi9090+Yb90xB4u/RhIJC1KLYuls446GD1WH5iLPjWo6jlutY1s
	j0PeMU/3VuyFUDZD91TtX/eM2VypAbS6xAbS9dlId71ev+f23reoInkQRBx41q+kPn2SstJBaBj
	Hnm7gpWeS84ZdM7PMOCxsjgJpbcwUUyVeQiI0uFA==
X-Received: by 2002:a05:7022:6884:b0:11b:9386:826d with SMTP id a92af1059eb24-1244a747274mr1225642c88.42.1768519084181;
        Thu, 15 Jan 2026 15:18:04 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbd4sm676532eec.33.2026.01.15.15.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 15:18:03 -0800 (PST)
Message-ID: <004572e6-5238-4226-9a2f-50078383c838@gmail.com>
Date: Thu, 15 Jan 2026 15:18:01 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/119] 6.12.66-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260115164151.948839306@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260115164151.948839306@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 08:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.66 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.66-rc1.gz
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

