Return-Path: <stable+bounces-25395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5549C86B543
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90161F28B56
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234511CAAB;
	Wed, 28 Feb 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CODotAl2"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD4D1E890
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138830; cv=none; b=f/UfgBuNWC/5nZwUUY0nUM2+A6PamVoR17dVUZR22QeTUDR6l+4XMpq1cjfwqwca6EUrOJEHRawtZyR2BzVJ7pboa8BpH9b0kTUAT3kEnNY6tQNL5MWqaD39sbYPV8lzMdNiYnnacKsLZzLAxu/9gA78wj1EPcKU7woGwFD2PNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138830; c=relaxed/simple;
	bh=KPcr3OYgCWifWKWVCw+LkHgjmcQMX1AVYds8fD7Ng2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCdjXRh/Ura3DberT5O0l4gEKVCv6b+mYaNb8GOp7698EDz/ZNYx6aYKF3AL8WsoWeNp9zuwxuqfwnrCZ117yIoyHlLhpkiSoBoDwxonR5/kTGlJSqi5ai/p9QleZ9D1JpXyqcu3O+Q5e9s75nTI5P5RicMLUA0LXERA2HNVAVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CODotAl2; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso114100039f.1
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 08:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709138828; x=1709743628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gg6+Y4Ou57ZP9qky7zAH6w6hyVIm255CnHs2R3W5bvA=;
        b=CODotAl2/o/Xh8Iieb2QG1mklO5f1lcGx8plvkft7TjV8XDMH5nRl50NZiOjaZhiFc
         FX4njPGIf98r6PmQaLGP8Nnm4wwfvkkY60uDZvrPkuxXqnkHl8NmE+0Jd/GKw7vGntfv
         +1W1Mdc1dpspB9bmJTe9TBaqj0dk3rcSQP9fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709138828; x=1709743628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gg6+Y4Ou57ZP9qky7zAH6w6hyVIm255CnHs2R3W5bvA=;
        b=ELTRE7lodaGyU22fYDmWTEHK7u/2asdh2kLmkevt7n2fsCE0V6QXhEzHLPPUsT+47Y
         B2k25X3jt1yqVi76mTL0B6cTcBdRU32cpx27uSsxVaRBFizpCXmNwZUVFzMUZB8Vjh++
         nfzU4LaSwymBBwwyhwiwT2JHM3NIqZs+SS28fftLKvsUe1gehUe81O+bPJFuH/4DdV+A
         +/laE/tCAhdZFGYLsqvNHhPxYlJNhx4znp2A4BdVFYFsxa5b90cZg2jjThN/V7CxNQA3
         QgoOT2K9cJ3aiK6B+5qwby/JR74cTEHoELNvC6xg1lEAeKSxK5bW150/qn5gP2ka0Wjr
         CLLg==
X-Forwarded-Encrypted: i=1; AJvYcCW91+5Vw84b/kUWPmLilJ/pY/bvob9lR+JnGYRpfwy/IrC/48cBANmDLBUe7ynxAnla5GseVwGZE75AO3VFXVUSrzFQjZIX
X-Gm-Message-State: AOJu0Yxf0S+dp3j9o/cZO51iQVbGk2QbQaahAWcKwrVhp16E+W+CEfaT
	A0flcvZZgO2jdAIdJRvX/ZMuWw0O+T7NMSwkDr3gP69rU4oePOMrWY4AFHPMc/I=
X-Google-Smtp-Source: AGHT+IFyRi8ePLaDpHmfI4NdCrm2iguFd4j4XQ4lNdB8vjhzI30N6HVQfNXNEev9wmy/CVVP0uQLaQ==
X-Received: by 2002:a05:6602:2195:b0:7c7:ce93:f532 with SMTP id b21-20020a056602219500b007c7ce93f532mr7742919iob.1.1709138828341;
        Wed, 28 Feb 2024 08:47:08 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id gj21-20020a0566386a1500b004748cbf37a0sm1376484jab.132.2024.02.28.08.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:47:07 -0800 (PST)
Message-ID: <17bdbb9e-5c3b-40cd-a13b-e4cfcb7ea0a1@linuxfoundation.org>
Date: Wed, 28 Feb 2024 09:47:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/245] 5.15.150-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240227131615.098467438@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 06:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.150 release.
> There are 245 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.150-rc1.gz
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

