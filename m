Return-Path: <stable+bounces-104145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EDB9F1365
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 18:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4231C16B021
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 17:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849991E47A6;
	Fri, 13 Dec 2024 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wglq7siq"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38D41E285A
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110077; cv=none; b=qg3Aojn4IngglbNJ8+ilWAo+otft3irenTi2vppBQ654fPtkEMDERupJ2T6WqEk/Y41/HYLIAFFx73BNGqrxjTT/MIMx2dFtYQj22CC9FZT0f87/2Lqvl9Ya8PKzLlwKYWrpsOm72yTk+5Wfd/mGr158/UmjR/PdK7hSIRmhYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110077; c=relaxed/simple;
	bh=nEQAJ7tMAVKoPCrSrHaaafwI82XnnJ+HSEY0wGbZcJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nT0fgxvu5gkV/LlwghhDf/EeYEwcyBU5TgE0jIr1Gz1cp/0HXWkVhcd52ybaWxY/Isw1mvuJ2utIEDKX5gp/A/8hyXHbHWuho3aF99/6q7FQkvKk9GFvpdYn4gNMDGLqVAmCcW09L7RH44CbBp6TydvuH4Sbs9JIXbiwXzp2iRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wglq7siq; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a8c7b02d68so15821255ab.3
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 09:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734110075; x=1734714875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HhPL9NYTRXT2OymQSUELSnul5634w4kN0UX4t+krxe8=;
        b=Wglq7siqvFHpT52GbQe123lMtX7kiFzUhci7nAIi3BvFt18YZVpA3i+KsXoRdnxBKK
         TLW57Cg4thcGYD+ew1bkEnltRP7/Ga6jxFLcIwj4DUq2aTLqde1opKTe4Fj9oc4fyMQH
         9AiBDKHpZx0VZmqujmQqpckB8JIInFmVTfl10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734110075; x=1734714875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhPL9NYTRXT2OymQSUELSnul5634w4kN0UX4t+krxe8=;
        b=h4ZlCbcXvL+Pjzkr19Jz7Z5sHBbiUXxGf1vAyXMSF/JKNs/uSxLrgFOWTVHHeUsBXP
         boSI74UfFO6bS6/OTtbHV4JJTY0wgFDoeub2bpu1ZD7GyZUCFbQtIzrpMyH+U+N8oe4u
         op/Q69fLKCjD3jWDfLZsxXuUQJfd25lgZSlpe+omwJJzbC2F0/GDH8gQWKFVgjvVfB+6
         cemAnQlcFAUr+NpOkfZac6oovgsiAs+kCA2Jx8zla7kd733/Y5WJc0igEV9imJgYBjbD
         fTMN8MleC8KQgtpmYkhVGr65ksKMGHpLhqgymIe8dNKc5BWl2wfGoRUD6gHeExT6JwDX
         gdXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQi12tC+mpYD09degilfQKylyQJlDWB7tHgkUM7bOntzpfWroHOdn6GlJdNTicQ2m/JEJTiTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLY9hLHFWSIVbGjf28RxNW6i2t/rpIZTNCEjkGVIhYf77LWr0r
	ppT7eJPIj37An7jvvThfXWgCNohhMviDrZjCW9Ncsr8a8gC+ZUDeckVutyp+e6Y=
X-Gm-Gg: ASbGnctaqoutGoI0s2FNGz98mYys5KpLRL1npuYU0AEmJTaY0mHDTl15+M31zfC+jyA
	WyYm/7qhZPr1ykqqh0Xq/p3pdQEWuliNNMP0gJXJe+1koHs8obvKdb+Q85RfwaWMPQyw7adjvUn
	CqIxpjXgpfMUsxabEcm/eY/qcA34KkgqsguLnJORKDYNcTj6CeFsdNXS7c+0nDZ3wVlvlbHBh73
	2cs2m9kDKvcdfy9YkYxUi4yU0iu8ogrB2pY+AQTDsH5z1rkQdEUhNv7EW+pScgs9UtZ
X-Google-Smtp-Source: AGHT+IE787W9PHbVdoivn28P7E8AqG8a0BDD76LSQQ9TR7ermXtOOZEn/BIwAAOAjlwDZ7A+ZBGldA==
X-Received: by 2002:a05:6e02:1aa8:b0:3a7:d84c:f2b0 with SMTP id e9e14a558f8ab-3aff50b340emr41233965ab.8.1734110074882;
        Fri, 13 Dec 2024 09:14:34 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2c835a054sm2288061173.77.2024.12.13.09.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 09:14:34 -0800 (PST)
Message-ID: <b71d9339-4b5e-43a7-a728-8016daf4a90f@linuxfoundation.org>
Date: Fri, 13 Dec 2024 10:14:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/565] 5.15.174-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 07:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.174 release.
> There are 565 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.174-rc1.gz
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

