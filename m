Return-Path: <stable+bounces-187805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE5DBEC65A
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 05:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB261A603CF
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 03:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522A727FD5A;
	Sat, 18 Oct 2025 03:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKSmcG0f"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CC9227B9F
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760757030; cv=none; b=VwtcIzA0gyY4BaFbEzzxbNcqky/QtSL8FeAHLdJCFErInKKLfWGw1xj9bymYUEMM6I2xTZSp2Ejfj/d69kWWVG3w9A8jARM19kb0PCBcKWAYUvhIqRvQglAUKzRvRHG1JcOsMajp/feKciiUK6xELAscWwpjWl8n+HwfbAJlZWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760757030; c=relaxed/simple;
	bh=CJQ76v/E/PHDdYgbR8fro6XXoFI3bbatRfKPbnF54mk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hgW/fiWxl1a01AxwsEvxTH5zTd1uQMgALhEx/s9QS0AMfboBP/Kd0mj5DUccA3wU20CiYBW3fIAmJxBTDJtTBZq/fvORY+1ttZ3MXAk6ZcwRku5LtaP2dnIJSMm7CpS3qlljebPexOrf0m0YDRY7ZdwD6EvKLL19JzXGhO1YjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKSmcG0f; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b5579235200so1600629a12.3
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 20:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760757028; x=1761361828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jf3FR3Gwahm6tMjH47zEEF5nx3T+VLl5Q8klA7mB664=;
        b=NKSmcG0fKsXM1aZj1emCJEwyQVrNtKpTfRZuIbjgXWefdOCQPh5ajic1TAkl3JuW1e
         Hf2dpEKkz/PPV0aA69MYyJp7cVaIZ9slgVXDpJ4qYBM1sarKygzNRXAJ+brY8POOYbz3
         ism5rzEJypVbSGmI6AN11aXimcvlmWmGktLjcN4MV6JK4tFRrPw0HXi6kUZ/qi8RbY+J
         +u0oJ5tKHsVyEOi3rVME1ncLPz9QOwc7BR1c5chGBD54uqqupeJu768W3QCB6t29iCXm
         3SgJnRiU9gWwXGtRYbXi0KMiJtiuiJWQXhFCS98C2S7w5ihT2gXTCNAIYf2hadzetgH3
         I+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760757028; x=1761361828;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jf3FR3Gwahm6tMjH47zEEF5nx3T+VLl5Q8klA7mB664=;
        b=rqBvMNcXK2K76MczgiUqFgEP3agJIBRzKsUu2sTzNkJDhaBN07G94WFWfLZu76lk3Z
         h69MH5K47EyGtY8WmObMo7S1Bg1lgMv8NZ2jXnS4iPD/sPpaIjLDAO7BPr5PiN1vc2BV
         90O7CL4YIC5Zpes/acshPOZWqDkNnvnASVE6H2JdAcourWW/5oOxd6Nee8i97V5JqC/+
         09l5koajcCDskTLkWizh5ctmiknp9WhFNYM+YPW8esLDTicAQz9Jgh7Owl7UsAVeOFot
         KFmg4U2uYYQitKrAtaczucUgOHPFFgt/ssUeS0N/VZYaOWYFj+4cGmM7DQgudhvadnwn
         8IYw==
X-Forwarded-Encrypted: i=1; AJvYcCXHQDhuj4lDuQagXn1MLaCQptgic/awRZ+fRoP4zE5J7vCwImMGj/bxwqEYMGDKk1oqpLZFRQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR+9J0YY0OcJjKn8o1pIcD2n/o8Ywy7Px5Bsg0dFXd+OlEme7u
	G16lvURuxtabueEUiXRLlkBi8P6kWWVZmptSvEgs3TVHN3m6HIpnbTjY
X-Gm-Gg: ASbGnctbX2kA3HRpyK7brII2TNnEAExBnsdjsKf3TFzY2AhVup7Ez/2M/7HsQn/RsRn
	+8fv9O4fqhK6dbCamU/jyQlkP85uYOS++bIsgHwom0xFsE1eNXhIuy73MpcHoQ1YmDCLPwX7+rJ
	c45s7Nf4rK03eNaLeRsJRX95NTCdOi/ztdGxu5rdi3Ayzwe+RPb1m/dFUufX/nK/o2R9UeXJVos
	bPLJs9OR1jgwdIZbrRBNcBrQ4di7BouBf2iWEoNlO8dsGj/nKaZXqsIDf0zRWOr8OF1CCdz5TPj
	KRoJRKFbAk0c6V3/4eMxlz7vPBqWofCVCgiK2r8UFRGlGLu6ZyzLvj0cL0t/CbE1Sr+5Z43CPdi
	oHjNWfDhKnadjKObDoPL9lG/wBQ4WA+USVyLPin2meWhlxoF334i0HghuITfAUjqHN9+2VEeNwj
	JyDV9KdMrZeiK8LNaTSJDgvklOamRWYkJgqz4n1HgLMiKaln+9fEAN
X-Google-Smtp-Source: AGHT+IEhbwIAKfabrUVIFmF5c3f4H0tzASZNULyMLnrkF3+58Kx389FBrjyRdsSR1s0BEE1Eo4vI4g==
X-Received: by 2002:a17:902:e549:b0:28e:756c:707e with SMTP id d9443c01a7336-290caf846e1mr76225645ad.33.1760757027966;
        Fri, 17 Oct 2025 20:10:27 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5868sm10321445ad.60.2025.10.17.20.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 20:10:27 -0700 (PDT)
Message-ID: <a7fa59d4-7c81-407b-bd1b-d6910f647443@gmail.com>
Date: Fri, 17 Oct 2025 20:10:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.1 000/168] 6.1.157-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251017145129.000176255@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20251017145129.000176255@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 07:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.157 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.157-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

