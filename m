Return-Path: <stable+bounces-111885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6293A24964
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 14:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F16B165E25
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 13:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDC91ADC87;
	Sat,  1 Feb 2025 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfC0WO5v"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89C31ADC9E;
	Sat,  1 Feb 2025 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738416610; cv=none; b=L3MIz8MqRTtctBQP4x6dpABth7G7nvGs9fYeb16D5bJFJLvVnJQlgATPoKE8+hs9QNMtQFT4KMsA46R1jzPU98xkWLrDdrBFKQ3HCDqVyZAfw2Nb/0JoJZyI9AojiOH/j4JXDydGHcQaXVAoGWWE6gnoNMau+ZD8+It2IBV+Tew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738416610; c=relaxed/simple;
	bh=5JVWdh18zv/858cHINYokqla91yfj58V2KK6eKXtoYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4BZL1Gg6/O5IaRxFe3L+2T5ZwJTZEH1+4lQbAjZIpulpOzBOGFRGb5EqmMvBc6/zS0HrNgqugKoWENSSM8JDVNA+Ih6V7nADRtBwXGqBIETtfwSuZogTzKDWQWVEAVkrhNmf3tS6sYT/ndGomuiEZ006mQlErFjf/6+XuU6fAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfC0WO5v; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2164b662090so58902325ad.1;
        Sat, 01 Feb 2025 05:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738416608; x=1739021408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UqAzzVKMehG5SuhDIkwv/5y6JXLHrq/vpSXxcFA6TbI=;
        b=IfC0WO5vRSuWR6TbiQEtIBhlg0L13A5du+GMbtS9BPYRO/wZvIZRx7pG1ZPdO7CcDN
         XOhNsyd0IrE/xIarRN51jGhFKoq2DTd2GvuDplwElcphyaKP4iriUqYHrZMuRGz9b0FW
         J7nWFA28xqRPBH3ZB+mqvfDLg4w0a2ZDsDFOcLbiXujqvfJBruQQK8yJ6P97S6rz1e8y
         wLK6xtOY8O854Cme/X3VB6csju4zcEcVbAPYHzQPrmGW5OgGXudVFaJx1oqLavFjzJcv
         4KD9mZX6rJuYTD1i9aeAVrc6fGZLyVBOP52rBLPUmfmcjC0mqdj96+Fingeye0EL4gAl
         HWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738416608; x=1739021408;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqAzzVKMehG5SuhDIkwv/5y6JXLHrq/vpSXxcFA6TbI=;
        b=QyPoZD4kie3I4q5LQjigct9Top5yZAK8MNiDKcnHyjNlAHgcltBMzk61p4Hed0g2yw
         4IMiwVouVoEwJuRrJRXbrA49ZlW462wefPVgDtUYJS5mHxAobWXr8qPA/qM/q5wA7Anu
         1YNCJrf/7dZ3OeF+jelGN/TG4YlyxAMMOl21kr54fLbzm9oaLlBYGYUNacBBl+t4DAap
         cvi6kFk++a6Oj974n6R/GKrSXlIe9B5Yw0CnGyzNAhf8nZrupd7a2FvoN/Z5kvBVJtRu
         56K36aSNHzp/9hmD+I2QtGbx5uLqOkmD8Z2kmE1tkBpP5MjUvxgg0wDDXBgKBcyVYdyu
         pfVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX53STY3N2v/i0M2Vbfe5lHCmHNJi/H2dEDYqz5UZzSpktG3idxcMjbnMR6rHo9Xw0sLqaQyZGIII5O2Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZItLenVr1IYuIv5/8UT3qm727CwdqTl7rjax7C1y1guRjHjqZ
	hUPJthbrr6ABpmHR3XSeg/uwnNbhLoMBUX2/rvZXbOwbQG8+3qYs
X-Gm-Gg: ASbGncvC68BqLTRaclu8VGjMgaRTJ44gKLBLvMPZspsO9K5nr7BRkt6f0YPFuZ1Md0b
	bAPNOQoVHVlPcAprxnESryv7INrgef6I0KEL4BDN6nmm5ni+vNtFHiowm4KGGoYnBTxXZWUpSeK
	AzPD/w+OyrbKEJiIHwZ+0LfcJz0fQAIFKapRsJCSdnWxOZWozc/YO17JVncOSqmGkLI3L8j/l9c
	83ljJcKNJNOlJYA9t7XvRDX3zYA36+S/M2vmPOuYaOOZL9SIDdm51B8DwpZK/e7uSSey5IEoOUj
	DesPp4KMbGsgyTNChXAfhRiZy22JIDumtMsZsXAk+WdRCSzx7u7YgR0i81k/UUUg
X-Google-Smtp-Source: AGHT+IHCjo/QOmXZUoTDPcYFWsXt3lWxh+F/2YzBOXeU7G2U2cHAcHk4up0qGU7oyuhwFixQ/PJ03g==
X-Received: by 2002:a05:6a20:7345:b0:1e0:d1c3:97d1 with SMTP id adf61e73a8af0-1ed7a6b178fmr27074217637.29.1738416607762;
        Sat, 01 Feb 2025 05:30:07 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec04794b1sm4749648a12.53.2025.02.01.05.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 05:30:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3275ff58-69ae-433a-ac65-d3144e7399f4@roeck-us.net>
Date: Sat, 1 Feb 2025 05:30:04 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/94] 5.4.290-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pavel Machek <pavel@denx.de>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, jonathanh@nvidia.com, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250131112114.030356568@linuxfoundation.org>
 <Z5zIZHIZxuHoymof@duo.ucw.cz> <2025020157-unsecured-map-aa0c@gregkh>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2025020157-unsecured-map-aa0c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/25 00:01, Greg Kroah-Hartman wrote:

> Anyway, are you all really caring about riscv on a 5.4.y kernel?  Last I
> checked, the riscv maintainers said not to even use that kernel for that
> architecture.  Do you all have real boards that care about this kernel
> tree that you are insisting on keeping alive?  Why not move them to a
> newer LTS kernel?
> 

That makes me wonder - is there a list of architectures and/or platforms
which should no longer be tested for older kernels ?

I am sure that could help free up test bed resources, and it would make
exchanges like this unnecessary.

Thanks,
Guenter


