Return-Path: <stable+bounces-151865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E355AD0FB9
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 22:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9EF16CE2E
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 20:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2531E1E766F;
	Sat,  7 Jun 2025 20:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhMW1trr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B61F0E25;
	Sat,  7 Jun 2025 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749327607; cv=none; b=Qz90YkriOu7THCImv7McXUiLVPEjtkIs1PYygd4NssaQzpwdY2lGpFg4CNKkyDYyRGdwZC4+lNsXMSRnEHtIOCezIMBnHS6eI6UH1TI/mbStAgUEL5V/ia2Ex9qpnpVlnzPpCkuKkLF81xYLifhkgz8RLCuekl9sAzIV1YrCU00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749327607; c=relaxed/simple;
	bh=j67PlnEfqbvwkbFIcNp7D2Hb21IvSpJVcC0OXzmk+lQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XoeQplqwQ4fCIcAIICZ2CtL91RZq7RjKn97H4n2hlYl0cHk0hOUbuSFI+lOabO/S7KEXXI3QFw6wxeLvxxabwzKw7VEJ6MNMpTEU4j1yr5TIV5fuHiRuAv4G26tMBMziPgajztfrIJNOtabqUbw8HLXogmvE8XmWSTaGIao7zYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhMW1trr; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2f603b0f0dso1328000a12.1;
        Sat, 07 Jun 2025 13:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749327606; x=1749932406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1JCuA/KJ1/RmFLQaJiC7CE/5YPs/dtb6ADPS+mr7YTo=;
        b=GhMW1trrP/ExMFruZgyEh8NaNuRNt4SXGIT0/5VoYIFbeNY8gXCr4lBP06ZiXVshHc
         XwoZdUR/vIXxKr2c6/YpcZU9BS7vGnGVOQ8F5aC36HJEyQ0qQhkHr7JYWxlnTaCiK6UU
         J8FhOxyuDkDir+v11a7/313qSlECGPHjP9XYqu3vqr3U0kE1m2KIhVc9+3yHMFQeoVol
         Lx2TPm2nUTDPYkHOE2Qg5U9projwbXyr35v+iYUefSvJtwQYECortW+u+NNKHIZg+hDG
         EAB9h/9TDoeWP5wiL2VtoNiEasGZsUMhxXUH1Kcr44iDd0hsANjshiQ8aO7pb4Zy72az
         SdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749327606; x=1749932406;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JCuA/KJ1/RmFLQaJiC7CE/5YPs/dtb6ADPS+mr7YTo=;
        b=cjb/iBs7i53RsZZxbD1/csaQ/92/je5bAffKB1jSFPsW3mONpvmA8NhFBizr045DlN
         K9s3/uWK8efoRgwltGLVNiKgv1DkESmtyBAT8XGuqZxUg6x6c8c2esDL7K2ql8Uju20L
         RuHn+Qi3PjfcUjhegntMBOUlhPIKwJU6obAtmzlnIDnKjVTJN133K3tMMFAuxEqt0iwR
         05aJpdBFbA5zlDeO1ZpLzyWZJ+WdheDaSRV0K/ZPVazmIEvYM5DSP2GgxkEHtKg9No9J
         eb/TODgdI5M6DpJ+cgXVu5UYzBMXEOEfGhxK2sctmL2+K/32l709avbXnzi9W4jkQS7M
         XlnA==
X-Forwarded-Encrypted: i=1; AJvYcCWGNI6w+/OvTxXCU8yBsu2YYamftCDPF5tYeOqMg9jnK1Cj/Bwjm3CaCXmQ5tTdgJWkGSNvwN4H@vger.kernel.org, AJvYcCXKfKS8zJbvMuKQ2lafh2ZOqhJSpGJnxCBKUt4fLjpmOaK4Cfza3RvnOtuLh7DkbP3aq96nF5DrDZoWvo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPhgMPgIJn0xGqDJDmNrWN8C1f2igAeNa+UfZ0RwJcXTEdq5nA
	MKkg78UPx54Xuorm6u1k1lsMRpauMkH1N7Tl83qUQd4xMvH+XdAI4rWY
X-Gm-Gg: ASbGnctk8+QGWLWFHWRXWE7UKWyVfApxAelWun8vFTsXnnUluUBF6ZRXOv1N+In7B8Y
	Pc1QpAWh1QpDLIMenEjslkcUbc4lL8zZypJ3rI006F4iWqF5e54O3a9OzfIqj5xD5HB37KdpQZx
	FZfYuR5R+/jZMPyLjHSuEzHk3gPwMFOElyxL0yrIHlw4ygjvSdtn4+BnhceiIvIF4MBvsRQpeAy
	M9oOjjUc+WHwmZHVoQZ4/1CN5vMqU5nTn/5jYx6mBkwDTnRrZHR8ZBuC2hpgltOKGdEC2Kwu63C
	DsQBre2cY4hCPX1GIgcNtICoNJWoO8r2JYgXTPPBwjXlHv5I+5QTJiGw6Cthhq3R77qqZhly+Wn
	KL5J4EeprqqY/qRTajmUlmNnrdl9SxBEOIxcoo/Q=
X-Google-Smtp-Source: AGHT+IGD4clp9fPtWjceXrKZpN/02Voy2xyMYrequhlApMSZn1dDDHAu/V8zk7Y5YGUSPCpSdUjScw==
X-Received: by 2002:a17:902:f545:b0:235:129a:175f with SMTP id d9443c01a7336-23601dbfe92mr113590005ad.34.1749327605732;
        Sat, 07 Jun 2025 13:20:05 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603078007sm30644365ad.44.2025.06.07.13.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jun 2025 13:20:05 -0700 (PDT)
Message-ID: <f0ef7d23-29e6-4478-a7e1-0421ef7456d2@gmail.com>
Date: Sat, 7 Jun 2025 13:19:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 00/34] 6.15.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250607100719.711372213@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250607100719.711372213@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/7/2025 3:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 09 Jun 2025 10:07:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


