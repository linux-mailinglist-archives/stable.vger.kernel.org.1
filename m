Return-Path: <stable+bounces-169420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE0FB24D34
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 17:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF23E3B26D3
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 15:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E2B1F12E9;
	Wed, 13 Aug 2025 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="giIE6ZUz"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829261DE3C3
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098198; cv=none; b=P+r12DZM+XT5/tAXJyhL8q2I+INpAQa40CqGMoVN/xS7MMqnrpZ3K0qx26uT36wErFov91oXRMjHyKVb7elaqSB5bnojXrxaysDhXhh1YLTAawrBgsHL/07zfn6CfcEA7tiJJkKXnHDrwGkW2kc2lVMk7s/G4taeCJXL9j7PnOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098198; c=relaxed/simple;
	bh=YWu6QysTTta+ygIB5yJvbhmovNUrZ+mY2Zbvv1O16X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anJHFREawQAL0+POhZJls4HolamH9XUft/durdRXAoz5qxHqKlbEQ9J4my49V47fVeMc3HuWzTsjxqjMCkihkoEhHpNYPhJQODR+ySv8kqkZcgWv79jtKPTv6tJRY5aFAM7dyC4BhfXZNasDgcvdkIVad1f0TgpT7X4mmbFPai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=giIE6ZUz; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e56aff470bso2985355ab.3
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 08:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755098194; x=1755702994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=shieCgzmVFkz48fGZIWPswfofiSSkJbIXRswAa1EobQ=;
        b=giIE6ZUzXsy5BiSrQL0MfvrHmTJC/QgApadMRKTwaz5RCeH3bFX1XkJg4DAPaMkPNx
         5jHBIHwNtjpYMhOsC84f+8FOmxNP7AsSp0Q19UPDWDXnMvmhAGzeq+cEa4ZOS8LG9tuB
         4hHh/jkYrI4URct0zsXCw8q01h4FIT26RpE7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098194; x=1755702994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shieCgzmVFkz48fGZIWPswfofiSSkJbIXRswAa1EobQ=;
        b=eEGM6fD3vqi4pgceM9y70RCIBWHS/LKQWLdfrv+JMFJ64pj6FyDNs7t+zz6MqgOju5
         RMmVcWlA3ukWwdF+vcQBNbN+T24/qUd4CHbi4/ZHlO1jsWxIdwwTp3SLwau5D/KO+zHY
         alZr3SsYOCeZZay1Yl2EDdQJLAIu5V+TKhG7stXxIzHVtQor1obOoB4GqwkmpOzpIffN
         EXp2arp3Bbb25I9tw4lPPGPIE7ukNd8dKRSdJmWzxkNJC6J5LyCLP83953SB//ahvYOX
         cj4nKmQ+44sTspmVUm6tL3CB3erUnG9+dpaGuR1Ca+LiAnjzPV2HfH+yr73LQXOsonJs
         5E8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsG9hZyBqSRMm6YbBoIqnu0eQCzcuS9gaYgR5/5dm8c7gl5grFZy5OedNPYmg+BLLfL0yp3Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDXSRtCpTMIorNsZSqlbgMPh3kFvppGi0Ris53D3ZGuOoc2J+3
	rZ6Q4Ix7v3mcGQxwQKNaADcmWICf9tMZy5xxIdL9ExeBt+NT+VJ2raRCnepccmjkC9U=
X-Gm-Gg: ASbGncsJdxh7y2/4IPTQQruvC4vtg15aUMFdxIkiJHJi4oKFPr+KeANgVydKhIGmsB5
	2257angeQFRtvKDW1a2M/DnmuvQr3bkvh3ch1D0enz28jPmtUxzxcOKmFRSrFOZ7Hnt4BJKu4L/
	skb5wwnC69sntIrOgDVjRF8qkovRm2XUz7fvqrQsBRojV+iNVVMZLMWTDxcRLb+y0IctYgbei4a
	aWx81J08HGX/h7Uo3rHEqu3gOUz6H9yt8O6tqbmZVUk9bmfHOyjlKusMM4LJVGnHQIq0Cgv/Df8
	RGzDJr1ZAEc5GnNf/JqAtoDfnzOjMkhxQdNq1mW2KZJp91CR3569TEf5ZllF/mWPYR9gj+wM3O8
	yBtPFYXcGXaPRiSKNZwSI3aCjGwCsgpQV8w==
X-Google-Smtp-Source: AGHT+IH3h+VIDrQjN5ai4jcK9ftE/5NNjveL7L/XQI2ggB2zwH69RAmhjvCcKUG170OJcY5Gh8frWA==
X-Received: by 2002:a05:6e02:1fe6:b0:3e5:4b2e:3b05 with SMTP id e9e14a558f8ab-3e56739e3b5mr58175045ab.2.1755098194414;
        Wed, 13 Aug 2025 08:16:34 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e54270f79fsm43167685ab.7.2025.08.13.08.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:16:33 -0700 (PDT)
Message-ID: <0e8e6d86-1fd8-449b-aca7-5ec86b049267@linuxfoundation.org>
Date: Wed, 13 Aug 2025 09:16:33 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/253] 6.1.148-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 11:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.148 release.
> There are 253 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:27:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.148-rc1.gz
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

