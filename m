Return-Path: <stable+bounces-52253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AADA90958A
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 04:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CB78B21F39
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 02:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369C28825;
	Sat, 15 Jun 2024 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RJ8nk3dv"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB6173
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417356; cv=none; b=arBXTV+kvELLiR/6xvu332ZD9Sse6vgEwRQzZf9VYhp+PmKtuTUtKDrqAk1Hci5FqZqAkWLYpuzzOHk0OfkoAt0wUnL0lUdxWjv0gfDbyKhB+7ky7ELM0KdwUpa+IVyNi62Gms9hNO3+pmwW4g9fgz49AE2K3M+LfVE8imIovic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417356; c=relaxed/simple;
	bh=Bl1NUlVeOWuUMu6QmHn8l+0I/dzadz8WMKIVI1FfzTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMOtubv8I/zgO8WMbcLi51StI7Gj+w27wJrGKea67J4r0BU2tofSMT0BSVy8DzdhaR3eQSQzfQ4Ee3Lgucg9rjFGa/nxpMyBGSHyr8yXIfcEmZJ9jLuA8T21amLvEL4VDuH+8aaJAsHuvPUvimn2mifbIoPiqZ8M2QtpkYrlZHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RJ8nk3dv; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7e8e7306174so9221139f.2
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 19:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718417353; x=1719022153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/AVLkF2MndaOt4rbGUZ4MbY0St7TEQ+T/k21n+LVP4g=;
        b=RJ8nk3dvvKYGuTZaHfVJmeZbsJ9QX1E6NHSvqjIlP5av/3fWQ/7Ztvt5IwU2kdI5VZ
         rO1CETJlb+NohGf32o9rrCWMkE3bZeRJKmVJ03knC4L6KY5dcbbZmnxMDFasQD2J6by8
         vVa0TOEJW5EIPhgbjYsibcW4QeVJdVt+ExH9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718417353; x=1719022153;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/AVLkF2MndaOt4rbGUZ4MbY0St7TEQ+T/k21n+LVP4g=;
        b=jYbqD5WiLrUnGAKMGeQmyiX8vipb8f/huSYVJ1VqcdPjCrABL8mxemf6be0njKO3h2
         KG9MuSQ5HKc8FnCCH6o8dsuscQMK0GhVDFhfvO1gDulZSa9vMn1PGWO8qiQqteFJnPDE
         8uk6IemRqqkjoUnBNWDWQ231484mBrLtPJcQgxF4RVVFjupxjKZI8kUAGY7e+7yblOJO
         yIz+bQjIPkwABe7zaY/t9qg0JDrmEUr57yI3IFlO2ct4fNU2VJlnIh4bFlIZ4XPYv4II
         ScEIwIIfx5FIdH49OmXJZXEkgEMvt3PaiK+tUW0j1yy0oyv2a0nmOyQfcAO/z7cWzMS/
         ShQg==
X-Forwarded-Encrypted: i=1; AJvYcCVzxKuMWKnRlHWOgnyqrVDAbK0gBFmwgm7s8gcR4dufu1QRaGlKA6hqt3BptLgNlnnq0lbzYk4KUQlp9CufqfsQiu7n/sVZ
X-Gm-Message-State: AOJu0Yyh6tZAx59jB+hDFuq79ApqO1rO9EIvx/0uZrx7jZO421tsMnqX
	7Zi9Qn3284tHP49MH1W5byBkHbNCCb+Icb0AL8LLc4LT3dnH3P3E2brMSbw33KA=
X-Google-Smtp-Source: AGHT+IGtnUSCyRuHRSzlM8/24/qqOYSZbzK+R5CzvfHQKmF0Tmr39UIsf3EFxCjz4DcL+Iw1thc44A==
X-Received: by 2002:a5e:dc48:0:b0:7eb:6a6e:c830 with SMTP id ca18e2360f4ac-7ebeb627c7cmr445203339f.2.1718417352683;
        Fri, 14 Jun 2024 19:09:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956926b25sm1211310173.57.2024.06.14.19.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 19:09:12 -0700 (PDT)
Message-ID: <9af06914-b5a4-4667-9e9e-b2ad8319977d@linuxfoundation.org>
Date: Fri, 14 Jun 2024 20:09:11 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/157] 6.9.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240613113227.389465891@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 05:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.5 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
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

