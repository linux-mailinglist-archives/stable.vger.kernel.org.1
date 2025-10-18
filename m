Return-Path: <stable+bounces-187811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5209ABEC679
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 05:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF476E33ED
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 03:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD5D2777E4;
	Sat, 18 Oct 2025 03:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMcGH68m"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FD521858D
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 03:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760758268; cv=none; b=fv2WxsMiH0+RbramItxDZtqr5/fH4f+3LZulvsDOzR+ygAZkx/ZzhSJXXbBdjnnkf8mQBChwsiibRgCgcT0hBiKgx39HfF6D9195qDIHG+kh8ouu78/Glzd6Sg1Yp3nzqdVgYDsJyS643KnjYv3EE0QOVJL3C/7rybstY4YqCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760758268; c=relaxed/simple;
	bh=+10+GeTAtzffLGH8zcKVrCr0sCkofSw5csfm87HIomc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fufGbWQJm+gsrSDKmH/LDFcWhel3AmaKk0MqydlXKO07vyEqQIdq0ODLcLBgV9tyQuBQRziSNLnXCI7nX9A5MeKO9b8ddYJ8y+zgAHhPXqf/IUwrNo8yBjjrr4i/pZQL+3v+/vb988ZNULYG6N465a5aitWB5n24haawbF7nTbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMcGH68m; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so2617533a91.1
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 20:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760758264; x=1761363064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v6vOeL0Ti9p0IbinEayIS2aVQiUiE4kHXsDaP64c+YY=;
        b=fMcGH68m1sJqGtwHQ+pYV+VsTY7UM8Dwby7tLA2VuZuCSoC0oSmurMprWz+5vuUtAY
         O9OYI0D3MbFsePEueWQ5+/nWIfZ5mYRBEsYEJvr5pRpJGoM7vtR5QsrvPe+33nWjultG
         hHqQjX4KO5M1x2l2TeXEF7WofQ7Ws3dS4tfBmp/1YbjGcbfb3Snw1+mxHNCv5Vusztab
         XX9FE428wXVWcRMw5F7uWBGeRY0Svuz1XTrzGmjILBSnZIprsMoWr3u3rZeqGI5m50xA
         5TdtLZClsRPTBGf4cyIxI23GKLmHS66uGzjJUxtanwEVTHVueMcbu0wWVn+FXPwZ57vB
         eeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760758264; x=1761363064;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6vOeL0Ti9p0IbinEayIS2aVQiUiE4kHXsDaP64c+YY=;
        b=jXa0/Kdb+igrQU+qhDdwhmSZY/E51Z3OiOXdkwWCpZhspdoAfawY9ATfah4Bzv5b1z
         4wNdA3F6bfmQOxG8SZIy6oreUKk5LtYhNTFj8+xnjMH2vripzkvn67eFPWyHpbhmhrx+
         7hiP6ZevPhwVs3i4j1/myuXd4cN0pUcy3AFgnK9b0TCb7KRe7V0bqQONBjdRXhkKdJYH
         WZtam9Q0dfqqDy1Em4dt60YUbf22TZKtb6fck0TxF7CAni0R0EaiFYNqdhgp/SwKenBz
         946WEBHd/MIsc/RTwIsfLyYdfko6XrD5imlzanzl7iPAhIlTNIMj/H4S3dUkUaGalWNx
         y7iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCZ4HUzQ5Mob5ioSMzICI72Hqday+8UwJ28rTzudGFi2F5JGeAmty+L9cJ7wtsHekcSlAEv2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpEqKXx9GLO2gtRV1J94I23NUGQdYD9IT+m/WTJQEX+CaDXPxh
	NySmk1+QSRLjFI0/Q0aNH6MzCS8c9V2Acgk1ae9nIDSbtxsuHzzJttxf
X-Gm-Gg: ASbGncvB5AfFpiU6y5Bi5CfDoBxlEZ4LN6JYpBuvAD6nk3Sh7Nnp86mLKvArciFdZbe
	UeEWb2c2iHMDLvlVS4hkaQNkLJTKIlVo8on7EV+yDG8eJsfz4c7VzSNWqgKWiRsGp/olxu/VN2o
	a5PNy1MCYHfMa9EbPQTwpNpYS/KXMA3YinQJxPeSat116uQ+8cksotoca1MqUE9XsdRDo8Wl0CR
	olboljKTXvSDPFEhn+2JqqVcWGS4L6Sg/xOOdE9LSiGDS3Y8PQxuyYSSN27higam/M5/V2ZPfK4
	0ch5kw9P5+MDHctlBa1PHYps8BqMoHdcohyHLEAIVeV9wO70azcM5L8wwc0fMsxYaZYMxZvzFpF
	DLeWSzL3BtZGLO4+RaXJWSmjDs8z+YANNUvAaizqNg1N9V+txcFyyC01/Jpxgz6qC728237U0nu
	A9iBjUg0G4KX5ZrWlrdQM6m12MtTThwLOvyfCygNyj34ChT05dv9YF
X-Google-Smtp-Source: AGHT+IF2jhP8EBwcp7ssUhyFGBfyHgpvEdDxNhJAUMzEUUmdrL/VUU+PTz7bDljFsV81pHEH+14dIA==
X-Received: by 2002:a17:90b:498f:b0:33b:cfac:21d1 with SMTP id 98e67ed59e1d1-33bcfac21e6mr6838380a91.32.1760758264085;
        Fri, 17 Oct 2025 20:31:04 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bae113eb3sm3899336a91.2.2025.10.17.20.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 20:31:03 -0700 (PDT)
Message-ID: <201bd632-344c-4a89-8870-6cfd2f3bac13@gmail.com>
Date: Fri, 17 Oct 2025 20:31:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.12 000/277] 6.12.54-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251017145147.138822285@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 07:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.54 release.
> There are 277 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.54-rc1.gz
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

