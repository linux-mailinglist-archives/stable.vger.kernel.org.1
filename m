Return-Path: <stable+bounces-60288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 547FD932FE0
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2321C220C4
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6CE1C6B7;
	Tue, 16 Jul 2024 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw7EWo3u"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E204718E28;
	Tue, 16 Jul 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154213; cv=none; b=sfrmU4V3z8sBndLpRGsEypf9DLuVN2WvC4g6IlGeyra0xU6Q2NXBYtVJgBfHnl01HM/+dB5SFTRy2ufxIyNRfvLyEN56Clgl3GZFKwpYyblgoJhIvTtbKA1t8Z6r7r610St5FVekGBT/6mvsTmo4eezNHJ4vvKlH5rU7Dfoux6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154213; c=relaxed/simple;
	bh=BKt5xsXhkdBcvCqqnMHb4pGJ9FJn/IlmyieTO4qcx4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFH/13oS+Ne6OqXNJg95YGEZJMEnx9yO6Za33y0hh/HY51+JhstltFwUEbefgqIG7RKB54oZQkeYK1Vaabt3p4w0LytbhZDi7+kytaRGbkLktD1QFtNmSZPzbUrs874cw4bLI9ZW3IDt3v8+TU0pjE1IUPRG2wpwlqDfiZ45Ew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vw7EWo3u; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70b2a0542c2so5524317b3a.3;
        Tue, 16 Jul 2024 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721154210; x=1721759010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hU2WUxOdEYMWjHVCKzeUA8Qq59FBn2+v28YS9SBj8kI=;
        b=Vw7EWo3uG/5xbl9nyYVzyLqAQeMfC8JMStMHx+EfbnGHxnwOdLTmxkVX3qgv5q3Lip
         iKG3WjyJyUUOgmKa80lwJiNPS2XXG3fe8Y1aUUmY89kYZr+aZvgCurzIxlJ7fGcREDNG
         PNFUTmNpO/JqOShF2qrW8WYEAPe3ayUvbNcebuPyac5sjAc7Uk1EJgPvdELcE4ttJhp+
         BtzhDSvPfmAaG9qAgdD4Fx70PHwBZ8Hx16R3BAdEmhj2QFvyEgwoSSmoKOkxt2qh+VpF
         L6y2BKAiELuClL5IyaUFrhdr3YWfNwWcjOrYfz+mlMAe47Bj5L9ts7Rpotuab64sEPkF
         mbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721154210; x=1721759010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hU2WUxOdEYMWjHVCKzeUA8Qq59FBn2+v28YS9SBj8kI=;
        b=UBovg8FEVF4JdSOgPVCzWE2Jd/CPy2rVMldV7DSlBeo4TueGm7VY0BbiNiw/dTAbM/
         9klwXLNnjxXbUjokzmdCWxuBfa0XUQVnmGuL/bQB/O886ieFE8lnPFNSYmqfBQMb5/9p
         7JpNTzMjhvqxk9YyQhjdNzEYLdRVqueVzeJW8NqRs5Zwxm2E61JRLpqf8zISVKpy3n49
         9JWISbEloKTJrrgX4ZGmi+txTyCU2eVjDszAW8oNmn8r/KtBqHa9QQP6tRXLqqwcgSEL
         9v/BqqoBtxOBx5Tl0+zaQxIj8zJYZZKcA0QdmoDvhh9WOfBeFgCXKBKznkT1+U84nFAL
         wEtw==
X-Forwarded-Encrypted: i=1; AJvYcCWD8De+tc1EoWJJYqhma5or2IZr61Slx1NwHqwFnKtnvwOTqw0UgTI8OKMcz0qxUzxcQYrlgYXeWr1ZGXmoChb0DbozRNaMwdqr5S8jTLD9rEzGrK6nDqurQn+3WlTq9+0y42xe
X-Gm-Message-State: AOJu0Yy9nB11TAD9zhBUnL9oQMfSX2eaYtqWvIrI2C8eIUVnL+6ZxjJn
	fNZAQRPZ4e0P5yaFJ4LsEAknQ7zDfm+MxpVKL0FYY1pmAEY5PPuj
X-Google-Smtp-Source: AGHT+IH64YZd43c5HM2OovaMMEJBUEGZWYmx6/asMW62Jc2JJR2BQvxJy2tdoJu5j83Asvb1gdgZGg==
X-Received: by 2002:a05:6a21:9985:b0:1c0:dd3d:ef3a with SMTP id adf61e73a8af0-1c3f123ea4amr3987370637.29.1721154210077;
        Tue, 16 Jul 2024 11:23:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70b7eca7545sm6651358b3a.153.2024.07.16.11.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 11:23:29 -0700 (PDT)
Message-ID: <231354c7-2480-4503-857a-12946366c1df@gmail.com>
Date: Tue, 16 Jul 2024 11:23:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/144] 5.15.163-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240716152752.524497140@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240716152752.524497140@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/24 08:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.163 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.163-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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


