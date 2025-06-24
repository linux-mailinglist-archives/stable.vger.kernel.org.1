Return-Path: <stable+bounces-158440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6E4AE6D4B
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 19:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B3E1897C65
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 17:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9834C74;
	Tue, 24 Jun 2025 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXr8xeo7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE900292936;
	Tue, 24 Jun 2025 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784904; cv=none; b=kAMpZUj2382ncfy8RVk/vmDXj7wvVPvYLbY3gy2itzHfmUlc1m0E9Yoc17DEq6Yw3wWMUw5/YWksoUnajwKeZBG1EU0Pov7dNsQK4JgfcPcdLq8fyxbEGpQDdBLlT4AhTDnTwu4/aEXXVQv0hVXhc/ZJVbt+4nnPW+rwjpz0ef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784904; c=relaxed/simple;
	bh=BBSCZ7Ix/i3Fc9zDGTb1wONqoagD2goADTxZ5BaWQmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuAPwGEej1Mc6jB50MGrTz4A0e2HA6zem6IKyhZR3GxLF5gloBeVFVHOSfU8kppMA2nQIovmFUzxvNvAMPAGC9sP5wqj4+wKj9dfftW8x5VgWhFUiWWA9PaiUiWDlXeuwyoe6MWAwI2YJlRI+G3DCQg1eojjL53f+RRGdZPzGlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXr8xeo7; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b2c4476d381so130443a12.0;
        Tue, 24 Jun 2025 10:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750784902; x=1751389702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6dYRhcAYfTDsGP9JY8wO+5LEhvxbiOhwjDxUJP+jJnc=;
        b=FXr8xeo7rzpH8un6GngGoZCTCRYp739HHzPzQ3N+Jt3PYa6/0KpZn0jSj27n2gJ4GI
         GxhiuSclWBskfcqEWk/rWn4eA12Pmirz5vM/8awtgOqcgYF6tKiv2XwbbUPFueFq6kmt
         PJ03DMGV2lIcHDDWG6qYsRRG9SEROoXGd2qsY1ui4l+H2EaSWnBC6motlxYefykXwe7l
         uBks2ooxVmhpEx5sJmFeIp5geeVUdQmdKlo76bwhnsRTWLoFF+Eg1biZewAOOS26smzo
         naPqM1Bf6WCWS1oKwoQcfwaNsuYJ33dAlALBsCtai7FwpwWoWTfb8Pd8CDK7pPaQ/xUA
         PJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750784902; x=1751389702;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dYRhcAYfTDsGP9JY8wO+5LEhvxbiOhwjDxUJP+jJnc=;
        b=FGNQ0t8A6A/R7FmTIoeTwHAsVm7nGhmyrd1UGbRGr1wdP1T9MAFcEdkiZ/t1rOdycR
         GuzIQcy9gubX8t6Vd2YvBG1lXGZ/cgwUqgWLBn0Eq79lOH69/ejdxM4Irf0Mb5BMoDHQ
         0hhyO7/dN4HLl+UZiwun5AdWKPvq+Kzve/vS7eoLcPIv7XBUARSHfq+V03WLGyPeFcPu
         x+EZU8eSpGoNJLEmbx+6uHYfa8XvOQJbcebGQqXllp8pk0wJzc9VPf8p9lhjQR0zi4F6
         M1lPNrYZ2AxkVoShxGy48g0sLu3d02dMyt+s04A5GSvC90+YaU8oRXmzKyh+JPMOhJ0s
         r2Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVQfh7MiGCNBpcHEdcKj7+9+wAMpD+0aYt6txWIyFHUK22tgLFUb+3ffD7q+UKZXu7F1/SmbkX8raMYPx8=@vger.kernel.org, AJvYcCWPH5R3WqWxeYEZmr5vCk3OxSkDJoM/s0/FLpLeSxBgdkfK43v7EjeCH1sNwK/iGOc+b9aD//qb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6iNJI/4cdU/0Iv46j8O+rnhAoY3XVF1xTNfnbWyw13PPVLCO
	ss6rwBvVLsksZtLXr7/KGz2PDlS3ZvNR9XQUz/NjFfhCER5sf8dtujI/XoHMfLCX
X-Gm-Gg: ASbGncuUeBhyit4kyUwLKhimnSh259IDXp1Qel+Cesz05+GcixHfa9+drW8t0fOFduR
	iJFvbOEKd8nO089vu6nvoQaV8YTuacJayV1NBmgBVzxDMJsqwU6S0E6IMDAsTm7EYvjEyH9pXSl
	wOZBS1hrGQGE8jDcCWZdk10EMeI3uyUTZREL3qGcHGhaC9gFnwtsVjEcXa2QMZjuhp5yBASOOMc
	XclH+ixohGs1yrg4T67cPGrGl8MGREhVLE/GnFfKXiCFl3pZosNX5ZS3b8/naN5ikM9RUuIQ51c
	FIHFhRHSjJXjPFoXicXG4lPD+Pwl9OhsL+wXWAt/RbATnUuSEYiEW5DB4S6kSmoWQb88LmnPVPG
	bi3ALtuuYhh86rA==
X-Google-Smtp-Source: AGHT+IFcO5jpseICA2lmX5M55SH9lONU2KlJEDVkSwjL/phn/zjIynFNss6DM7aRXNpEvi9UAm8vFw==
X-Received: by 2002:a05:6a00:4b11:b0:748:6a12:1b47 with SMTP id d2e1a72fcca58-74955d5459amr5696196b3a.10.1750784901971;
        Tue, 24 Jun 2025 10:08:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f126a2aesm10732693a12.67.2025.06.24.10.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 10:08:21 -0700 (PDT)
Message-ID: <c128400c-d096-4bee-94ac-f3a8762ed29c@gmail.com>
Date: Tue, 24 Jun 2025 10:08:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/507] 6.1.142-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250624123036.124991422@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250624123036.124991422@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 05:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.142 release.
> There are 507 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Jun 2025 12:29:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.142-rc2.gz
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

