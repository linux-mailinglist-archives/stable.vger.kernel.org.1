Return-Path: <stable+bounces-61925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC9D93D983
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 22:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B081C21EFF
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 20:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8C24EB2B;
	Fri, 26 Jul 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwSe4L8r"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED79D383BF;
	Fri, 26 Jul 2024 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024167; cv=none; b=inq/hvBUI0WiJ+vjEb86udy/iYWLF63rW6lv7ztWITlPNn40iXVBGcd6hIa+JV4KiqJsB/PjGJRBxgGfMlwtOjh/adkkvaPVhuZg3Ze8izMp+sWpVfi9e4nHlV0LkCjK73v7Dhiswff3Kily12O6t9oiLEieN5TE4uw1fFPlOII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024167; c=relaxed/simple;
	bh=GFsF+jKskuhgGnBjr3n4TRAHhLbxgaBJyMzCDsYbsn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIynP6bkO8irCw0fYF7bYwpyoEUUZJDmCUnuYLFWglXrQgPFO9iFVy8NbOrL83BdcIWSuPzVGextXlhkzHcXxVFHLtR4LF2m0vN2ubmQm3syV0zPjeTHTblviIe3fJVKdBHnmTqfvM3sA/JcDc4OdVrW61+FYJEOYYfpri8mzJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwSe4L8r; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b79fc76d03so5968966d6.1;
        Fri, 26 Jul 2024 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722024165; x=1722628965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJxI3RUALg6qvPeKhK5g5YhXu5vNqGOcbCAXjfUdd6M=;
        b=GwSe4L8rVXH0t51SQtGgecGOktchOgmjsR/Sb2B6lR1dMH6FVxPk/UeMtXIHAsKLnH
         oVNJ/uGi0sxrMaTUKKvHjpI2zitYBSiRx9PWzxPsJYplhhvlcjZQEBPZtSAHZstfGSc8
         y1N0oX80COw3xGguWtjISGIkLiEcWy0DPo5Z3Tdbzw9fUjR5yln9umPHDHlU8TSoA+Ng
         b2FGVFoY+tnYGcifCM5KSfm6sAlsdhQG3ZGCfCIl5WF2M2wxemt3LavfknS0jlWXyA4q
         TY74mGng8MVBr99TGDLm+y0d2T3jHJJi7C1gUqWidA+c9ViJR8PAYBhZ6ZnC5GQj4+ic
         nzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722024165; x=1722628965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJxI3RUALg6qvPeKhK5g5YhXu5vNqGOcbCAXjfUdd6M=;
        b=cD8VpRrXQkyq8lJ0Y2196WFkfahLkY2og/3F39hDtKLVkeAin+0VSyLuBRhK2Y3yjX
         cRDYgKd/6f9cXrWQB7nV9CXcSN1/GcJjIHVoN7lCLQKgF83afpbYUTWrS+IW8ilnObJs
         Yycb1/PupC3wg9cHA5pIKjN6UlgM4QMPPcEj+aKDLLzkt3HQBAg7IPRP8+frBBuGxI3o
         M24zYM4GMXv9h5/G0mlh8oBGYBpIccLVkNBAMwMZAo6NBdQCszOhN4CmPsZiAz/3Wp7K
         0vTog4sX1sM8en4rOJabXpC682IjS3sISiXqzEfsOoTFj8lFBSxNTtTOL91pPmlU09me
         W2YQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/89Ud8YwZi544eyJbofpnqtZOf6oWLfPTwc6vuFQn92M7QUGPGhPcTAJUCghju4wIzWXsGg/OaxQNtDkmqtVYsbfGvsQB614gRW8+U7RSKSP/jA9ndavm0Xw0lYEzCcW759Kv
X-Gm-Message-State: AOJu0YzQHG6jVzp0xo5lQyiUym89GeBrIKLpq/+sfNnbE7LNDrRsWz8u
	6pPCgS21wt/NOdzr47bE8wU4JLC/pIwRXfyYX4VmGU3xpFTWcRO/
X-Google-Smtp-Source: AGHT+IHB6Z+lbg7XWIRMElM0+HtT1YAvNgKpK/ewPBfnsocH6+ThAkHe4XJsJe9r0X4FQZXNDw/HEw==
X-Received: by 2002:a05:6214:2a47:b0:6b7:b2eb:ae82 with SMTP id 6a1803df08f44-6bb55a44de6mr9274016d6.29.1722024164770;
        Fri, 26 Jul 2024 13:02:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6bb3fa94e63sm19727426d6.76.2024.07.26.13.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 13:02:43 -0700 (PDT)
Message-ID: <d873b5f1-4208-4e9f-9846-965ba27073e2@gmail.com>
Date: Fri, 26 Jul 2024 13:02:38 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 00/29] 6.9.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240725142731.678993846@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240725142731.678993846@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 07:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.12 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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


