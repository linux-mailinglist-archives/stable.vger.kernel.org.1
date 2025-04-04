Return-Path: <stable+bounces-128325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B729A7BFC5
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 16:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D6C18982A6
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 14:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4C81F4169;
	Fri,  4 Apr 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZC3eerwY"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C4B1F2C5B
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777864; cv=none; b=Om0ClrkKOOnYDOZgmFXB0+L6SUZK7gyWcLIQBfUVLfAAidtdr0jUKTpnQfh92fMvRhvoJFBSLMSauLh0HCdzpqAKQea3mv0+89vOMEZkrpfZMhKriht2Hb+tU4N/mpnfMp4My5LAuRT6s8vaiDD7jU1dRMJwXi5/chZs1QMjDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777864; c=relaxed/simple;
	bh=E6utw/gDQf+fI4uGLBdnXPibG1fX3thq787NQIaKJ5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzymzss9eUdTZdfcVwV5OpCZcWOIVa6dri2TFVYk1qiH5QYZ3DKx9m9Mrd8hfhNM4ZwQ1x8xAdfJIn/VjviG/rrjmefNAPitCPZ/Ii0vWj9Y3Pcoj+4aVVHdpic3PiqaQqb+QX2yec8EQDySn9nL3mXJOz2aT7YS8/BkypEXd5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZC3eerwY; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d45503af24so18909335ab.2
        for <stable@vger.kernel.org>; Fri, 04 Apr 2025 07:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743777861; x=1744382661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q7j6X65sUf/Y74e3CXgX1WG8fpjUk7SSrlyn4gxiEzw=;
        b=ZC3eerwYx39T5BfKtQb39p6wikDB4pcOM2T9SzXdyMu4WIMZerTvetQgc2EzVSwLK8
         cRuE816czvho7qunitzWT7nTpvAj7LccFp6C/HwGK89nrActqujBgtfEW+VSCVXOtKsR
         YNVKz67w3CX6MVTXw7y/7QPu6CLizYtYKjTpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743777861; x=1744382661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7j6X65sUf/Y74e3CXgX1WG8fpjUk7SSrlyn4gxiEzw=;
        b=Iy1x6r2HKdBOESj45ySYOJVhOqPpB59FrXqbOi7O1vvV/NS67RzYvsa/M1Y6S8wq9J
         7DZnel5rjMnQNA3CfF22vXSdMhzeAnoCc5d9MWiknKnGph1VANsY1YSLbKIx5lDTBSwq
         E8cqxxi0gdE2C35zF2c9yhlduhF+bfWfMc8Inrv0rMgl+Q0sErJ3cEMfIEZUzyqvihBf
         5Piv8UkbYhQw09DKLnfYssHpQ9H8QED9Mq5kxqd+1eNB9hg0mrY9pimb1jUSnexXXP3x
         la9WM2mfBU62VBwMdVZBsYispE1sOKS8WBia6rbBetdFfYHKbrlec7voztv3ZecGHdGQ
         IYcw==
X-Forwarded-Encrypted: i=1; AJvYcCXXGU2GzMnRatKlXZRgS/waDys1aJNHXx87OFjnMlwu1KCejWZdYoIDPjPVlUNSdbFvfjzbafg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmBBtvZogvryR8jqKxF3jgJGHrx7f+jIZpk9egN111vysmNyBW
	tGHnX4Dq02HebN7odhr6ZjTzqmF92EwcXGYnT2L1xqUvagWHpNUuSSDs/LMR/ZE=
X-Gm-Gg: ASbGnctyWrGiZ/Gzba1nDLgayT8INH9rtwZR4duD8zNysc5XuLD1cxOfGJB6NFZPBb4
	LsOCvkk6mW4AAPW5SbcY2YRoAQrNYOlsi5eH5+rlhJcTaRpfARk3pBcYcxzaJGFk2Gka0jU6sC5
	t8S8EjqsMvom5vzmPDtWDqHCedS9uhZewirBhs95w49xBsxQN8NvKaaz54GjG5s8lqy9sBqUlTu
	X/kaZPLKqGosfL7PTGiE+5TBKocuT/zP4qxTtIyzJsnj6/1T3sgvLVjQfU1MzOuozZisuebhSU8
	nf0vbReEo3y0VYGjc9X4/6YUru6mjXpca+iSy6eODjgabO/OAsu95hA=
X-Google-Smtp-Source: AGHT+IEHkqDh9oJa2S3GGKDi+GP2V7X1hMJDHi7lwm71y2eKrCoA2PqIlJS9fMSkYj3RVmu94fwG0A==
X-Received: by 2002:a05:6e02:1d9b:b0:3ce:8ed9:ca94 with SMTP id e9e14a558f8ab-3d6e3f6573dmr40989205ab.14.1743777860986;
        Fri, 04 Apr 2025 07:44:20 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d6de79f070sm8236735ab.12.2025.04.04.07.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 07:44:20 -0700 (PDT)
Message-ID: <3936bdd4-b776-49a5-b997-a7c6139c5f85@linuxfoundation.org>
Date: Fri, 4 Apr 2025 08:44:19 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 00/21] 6.14.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250403151621.130541515@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250403151621.130541515@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/25 09:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.1 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
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

