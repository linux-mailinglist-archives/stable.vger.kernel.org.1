Return-Path: <stable+bounces-126763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AFEA71C97
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59260163DD8
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B221E4AE;
	Wed, 26 Mar 2025 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFVYm8VZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2881C9DE5;
	Wed, 26 Mar 2025 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743008337; cv=none; b=MjdrZUs6Hd1MCx86ZwnRLFk+8FPXlvPfw2buNYIsTGMV/KaV5hsSAm3w0n8W9L+BtLlyPSTyLD0FAbryfM+jYLgzOXjaijbAD/1Rod8xreNixQOYRkU5YepMKOdv5n1WbXma23lyOBnS36rpHa50ilvOGt9GEuTk687heN40ylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743008337; c=relaxed/simple;
	bh=7d7yZS4xo1fXp60PzB8UalJwg4J7mzJAalE9ZDZd7f4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRvB5Rc++PeApmFHSWEZa5GeA9G4D5AE5ezAXp/7zVgx+MGS6+CbqF6u44JMz1ElbM5Os+wIoZFdGSXEnXHlHNaA+kaLIaBraL8W31fhrFfYtaB1f0H/n/+KjtEIWdVUJCRB9Ac3c5ApfVEcXIpvt+1BVrPU92bJVd2gDOzo7mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFVYm8VZ; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3feb0db95e6so3943434b6e.1;
        Wed, 26 Mar 2025 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743008335; x=1743613135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8nBpYBtwKb7TURY3wvZnEQG6HvazhLDmZ9wmMqqOCx8=;
        b=NFVYm8VZIeygYm9AgpMENuPsVZr0fmq5zQAgAp9XTc9zMqNJBhwV7RWOl2Ybgz6L2g
         cqdNjWRiMxBXhu8n8TIY/g30e+VPRKFXeqF1zU71qjDhnj7KtmIIAnj5FaNW2kFud1Yy
         oEfdOptdqtTsWxvQlkMXLXowMFrkuwH4aXvb0gS5JpQRvvsTDaitvU10K4QKMV1OFNaY
         g1YvW/dDA7QA4RnWX6DLldY1ZxWm6duMmcdBLb1hsx4zFUhAOnQpXAR5kMhzVAypI67U
         49Hhn9yHzcOvVRlvyxwsKV29r2HtguB3uhEDgtSOBPmFlcBHQtzs+HoDw9+RYo1rCCYB
         iU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743008335; x=1743613135;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nBpYBtwKb7TURY3wvZnEQG6HvazhLDmZ9wmMqqOCx8=;
        b=wVEoLGU5esAVWFbnSoH0bgcneeugCXWfKKW47Za2aQmQx+o2ti1sn1VdZA9h/EuKpM
         w0UxCSXI9Ho+gpJhgcOUo8/FpqW4w2mE3HB5X8Rye7KnsrgoUXENMjkUPw8doQyymO41
         HLwRDmIDhnrZJUqg89vzlP36DCA6B6DyS+0Xw+WJwxp+SVJfJbixA3Oqc2muYaO0faOs
         Wne7+AhF66YVSFICyljigevUYf2272agmgM131eLhoZmndDAElEZ+1V8RTGjkwdVumAd
         S6C4izPpG22qWOcE5Uci1FliUR8SPclK73slW8cK8xl5c5qFjKOffvouGeQjKBLPG1Dd
         9nYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIE7jEiBrewCa0p0V9xRLVFbsAJzM5PddKxLSbVqsrSKC5LY9klO3TOvaqb6emyEGoNRyaknFlyweuNwk=@vger.kernel.org, AJvYcCXoXs3x2KpVtXjIh4YEXbYw598YzjlFJkVQW5hpvkvQ1BqH4ZiyVUXSzODimlWWzzuEzqNfHOJi@vger.kernel.org
X-Gm-Message-State: AOJu0YwdyycHwjaZznR0l5fn+JH374n1aaHDgCH8/kWD3bcz1d2RzDUW
	aWNRmSIYtKXbuSQ9tU4mfvXOEcxeqpcKlxN1kfzeFIgaAjMWE2i1nuLonQ==
X-Gm-Gg: ASbGnctahN8upucLC9u2c2ekJ47n0TkNjENwQdMo6TrBSFoJPuLL/pQpbTxsgFgy4jF
	D5+VI9Ei0N/hcN1HZyyNb26AO8XZ6UW0YY9LaIwHdhFzA9AQCll00f2odRNjWfiAWIwlzQO8s/A
	Dju8xuixsvB0o3JgU30XNk+dsuPYUj062RrNo3AT9dQ0fA7A63HxEX8/Uv84d3BRFUWrbJom1TP
	LKSNge+arIndLVHmHIPMZHqtnqg6gJ9WKC2T0fXcQpPqaChZW2dvB9f4K8V3OG0CPxdDIGUd0sB
	0xxSUcDn8spAEXj7HzKqEfGHAFIyvuc5rmTrTc5BtMZA5ULXubFj7L6RUZy/ELj61kVuu24r
X-Google-Smtp-Source: AGHT+IGHS7bbA+ifSsFMTpiUtTW+9RJ8vabr0Lz8CgszfdsX0Gi5ZLuElE60ZnNvDSvA5WM5R1jIMw==
X-Received: by 2002:a05:6808:1aa8:b0:3f9:641b:6412 with SMTP id 5614622812f47-3fefa63dd4emr134475b6e.38.1743008334703;
        Wed, 26 Mar 2025 09:58:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf79da30sm2443619b6e.45.2025.03.26.09.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 09:58:53 -0700 (PDT)
Message-ID: <5884ba8d-46b0-416f-bfa2-62d5a46afe0a@gmail.com>
Date: Wed, 26 Mar 2025 09:58:51 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/115] 6.12.21-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250326154546.724728617@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250326154546.724728617@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/25 08:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.21 release.
> There are 115 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 28 Mar 2025 15:45:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.21-rc2.gz
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

