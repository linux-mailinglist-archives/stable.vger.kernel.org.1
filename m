Return-Path: <stable+bounces-69239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A5B953A6C
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 20:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647DF1F22206
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 18:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65944433D6;
	Thu, 15 Aug 2024 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IDqP/swn"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A7B44384;
	Thu, 15 Aug 2024 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748141; cv=none; b=pr9ABBYawIig29sDF2H9JBRWFhnDOlAHp6/D5RQn8NnsrxjTM60IoAhp24BBuXGL6OC0fvUfxnu/I7XVjKXnCs5EtlrKwVRXpR7x2+gB+31fsGmGO4OxlTkL30El6KGcQriwFGBjEeXWdtAkqDlbwUtOSNbtWoYM0MIHmuibFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748141; c=relaxed/simple;
	bh=+WiC+20mb0M7izfKeq3bTC2m86+ALtg88CvFWbkwrr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNL/9YduUwQYqi/thvo21l8kb444rUS8QF8HTqwuZIEz9EO1Mh7uGtsChjKirGRl00U9NWy0NAZ8K8xmT4O5GewN8Z4tcC9SuFCMcbTc6gmHxhn+PIkqf4yEhybXESUpkAfj6gdFOSAR+0V4rF+eDi4lCyEU2bgbYKSOu4SbxW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IDqP/swn; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ed741fe46so1405816e87.0;
        Thu, 15 Aug 2024 11:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1723748138; x=1724352938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s8t4LbaqxGXXUmZDL4qWEA0g6Vmf9VaqwrZ3UrCArZ8=;
        b=IDqP/swnnYGuiLGOiWX7nmONMKLmQo4sRvJpNA3ZbDTrEXRvDvJxtgiJUqPUYD3M5Z
         KMsBicPvL9N6fdPnB1eGxEoL8EvrlfGxYjKSJKHj4/PTdGiOdNXrZjepnkE4YFENTZ3p
         6dyzthYfj/fjT1c60I7PWtINeHz0jDsUEtPojdSUBIwvb5/PQgxBvg0rPjajS+xBmAgq
         iLf/BsxKyrd2z2PPdobbTKod9bsXqYY+MnODx36kexjWWeM/q4iFy6I7AIjKO2+gAC30
         Hf6R/CZC+a2lSjorGy/HNIjMzwvFKcZantkfsvIQ4cTPqssVMkgbMBdSuRhQ4BMcn4nS
         pWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723748138; x=1724352938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8t4LbaqxGXXUmZDL4qWEA0g6Vmf9VaqwrZ3UrCArZ8=;
        b=XqEfbRN5aAEoP0pOKLT4JA16H7PlGjUZCo3Wf11UK7euDDC2RU6ZG6IW1yjUR3+uFQ
         lng57py2Jy0UBRffoNn/dKTzpRQNvTqblSm26dMXCTa2uLW4KTO1Jx3MtRhCbSS8A8+j
         8y6Cg0UILPSFJfDEBobU+zAvSYKvO3fzVyZJ5pvohvOq4p6JEn9fDSW8b4aQAUySopip
         7OkXw+FRAKq3XgLzU2/YCPX3F7OYSMx4AsN+WxMZZsR8dp/jUkynN8B0gf42+cB0Xdqz
         5APlx9v3i1z6Zf6ApWi8gJ+a9xZeFu2bxFM+tDT7sfapdraC4AfjM43hStRNdoIrcQrg
         rMWg==
X-Forwarded-Encrypted: i=1; AJvYcCXEys9aFDBmHVqeMeim928TBKQ7aB4g3FQaLDSb1TQk0nWDdzdhn+KWjmJUALfGdE9R2DTvzv0UrkFNRGXhMfiAElz9xD3kuf861c4xhRLEsBHC8wAzi37EqEKR0OtiZ7WTKyNz
X-Gm-Message-State: AOJu0Yw3pSaEmwz6PFMaDnHGuQKblj6H9Pu3Yry6gxEmrolt5qW09Lph
	eBZo/ljtTFbzRUlGxiS56weMbXKkx3PzfyhIMWQDyGv0zX3qW3c=
X-Google-Smtp-Source: AGHT+IGRhxlsxPmI6bVrs07CuCScyrJazBxE9Li8/BBgM+fNKEr4kO8v+nkm6+Orl4D9iQBYCpL4ZA==
X-Received: by 2002:a05:6512:b9d:b0:52e:7f6b:5786 with SMTP id 2adb3069b0e04-5331c6f1de2mr195791e87.61.1723748137328;
        Thu, 15 Aug 2024 11:55:37 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b41e6.dip0.t-ipconnect.de. [91.43.65.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfe70sm138944766b.75.2024.08.15.11.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 11:55:36 -0700 (PDT)
Message-ID: <49c758fd-5839-4141-bfb1-8c9157dae0e3@googlemail.com>
Date: Thu, 15 Aug 2024 20:55:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/38] 6.1.106-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240815131832.944273699@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240815131832.944273699@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.08.2024 um 15:25 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.106 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

