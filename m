Return-Path: <stable+bounces-107917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE34A04D4D
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 00:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC51B18832F2
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 23:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B389C194A45;
	Tue,  7 Jan 2025 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QSvCah86"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1EA1DFD9C
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291769; cv=none; b=ScYKTQ035tqZedO5n/AfY5mG33XfjjYjJAqkThiaMhawo/06AxbU+TUnbwbwQSSS+rl1Gn+0SW0j7crF9BaOMFg/VZZUiPAD4gLDWbmDoWoyyKR33U0BnsVOjqGubTSpw4/Kj3KeI9vALcugk2+N/CKB7zgQE1x+RMuDysh61Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291769; c=relaxed/simple;
	bh=Y40xGJr+8Qy07UYA1aftHu5Xx5x9WHeBEJ/VXZGg47E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzEpcSB83XKM2/4+2JjfTgSGIMASMisVPbCYqxYvm9i96vDjH1ZT26swH8dI8t3mECjfh7UKem1s0DaauMKMLxyX36bALPJBKus7N9DEHGgl71DFGN+aqWOcXrU9txnpNFM+DMJvB97gurFGwRBaSeNmfIoAisAhTOnvp6a/tOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QSvCah86; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ce34c6872aso8698255ab.0
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 15:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736291767; x=1736896567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkz+oAlIsB7kUQO3nBdLz6Ks/ioiSSPBbNR2F9IzyzQ=;
        b=QSvCah864a2zPbihbB1AOkwC2VoPyPw8A3f+c/Pf/4Nr9eJWiIMc7ZZOIQ5UWU9oRT
         ELtcZJk/3qIeem11KjvKeq9mGZ6hVsFakXAGKECDBs7AGIq31Ej56vA4rIy5DENurb2h
         eTCdNMoJrnRY+Ln6XWNTQNjQZSlp0e607FTOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736291767; x=1736896567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkz+oAlIsB7kUQO3nBdLz6Ks/ioiSSPBbNR2F9IzyzQ=;
        b=RctU+Tc9wdab1Sv6bZx89FbiRgh4/3y6rlvBKvm1s9p0CQpsu3K1pTAAgq/tnCng3O
         iVS3A+QkT0iJ8hiszZ1+0P7rOaPW7DQGzyf7XJpTqcRJ8EFYivezzrrVj8ateIeNR6Or
         OFq+ikq/KBBWkF6VoEJXw5p1rUvpyzg8FtcwQLugA3u2ixvd8rNBgLD2LaSxOthnXNLk
         Ik4t/a9ETV+EQ8/WD08yPcGroTiZaHvF8/aQ/gk5hOOVoWNLtT3AEXYrKaiIBetp1elz
         S4NvQMECLtr+GhCI6BLu62gT4OthxqntmKd+VgX/UejF0k9yJsEtVqTeOikk6sg+asy3
         XkNg==
X-Forwarded-Encrypted: i=1; AJvYcCXw5IIT5yVBZ93mhBZ63tuqfT5MEv78QfTz/3XrSehH1Z2CwiPfjRFcBX9ur+b9xfWMQajgNwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/bzChJi/vxUuvSnbjELQUDXHXALNZ/GPC5nWwCrHve8ZZtiS
	ykjk1dFOU7xT6awWYESTt/FClqQazAJjb6vrjgkFisl81gVNjSv433sC3QgivC4=
X-Gm-Gg: ASbGncuU2q3wwWsHRMJJcRkEPta3HyApy8nXx9IkpZnrfAw3/CG/KLBbqd4A/8Or/aN
	4Q+AjpSzM7KIc2OpPe696IZ5kV8bOhPp4wCccskAaNJfCsNVc3zWZSSMA5Qy7JC826XuqU/dW2k
	4tLmUbd08Y69Vf0D1ItiwbS4X2awammN5r9jBqYSoh96JVBGFYIJnaZKxgg7CEdcvX+yuzjBQ6L
	uLFLkw1Q1/LCwvcK0ILJK65Eo9SwwMvb9lb+0hILXas/uG8zSW7s2lgGub0raKmkzTw
X-Google-Smtp-Source: AGHT+IFe1SigtLgqoIISiAXp5oU/0Hxt7+fEOLTKBe4MS9n7FzMWJWdBr472Vr6VjGHqDAj5d6oI4w==
X-Received: by 2002:a05:6e02:1a6f:b0:3a7:8720:9e9f with SMTP id e9e14a558f8ab-3ce3a86a4e0mr8199665ab.2.1736291766810;
        Tue, 07 Jan 2025 15:16:06 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ce2d260971sm8859775ab.79.2025.01.07.15.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:16:06 -0800 (PST)
Message-ID: <01883752-11d7-4195-94e4-27719ffa2235@linuxfoundation.org>
Date: Tue, 7 Jan 2025 16:16:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/81] 6.1.124-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250106151129.433047073@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250106151129.433047073@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/25 08:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.124 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.124-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

