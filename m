Return-Path: <stable+bounces-93665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49449D00E6
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 22:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63DC6B24029
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 21:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0804A1990A2;
	Sat, 16 Nov 2024 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d8XYiiNF"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAB2198A32
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731791597; cv=none; b=hc/voP0VWTyLT85hrEL2b6GDV5jBxkid6wq9sxPf5FBshwqRkJp6DIH5SJuh0DV6xPXgCOCXSvAfZ5EGTeDgh5VkDA21LT+byF+40Y9YWW/zr+aiTT6jcqQ1tot4JkHCjzIleDfch9QlHUdP4FurkkWdgh5sNyYCwhCOgbIcbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731791597; c=relaxed/simple;
	bh=YIjCJiL3NctpJ1FHcOVJI5OdXflucIydyzN1gcoqVU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBA5vIvzTkQgJTIUmHuTrz4P3si6VfkWV1SuFk+Z89OceeB/fd7Xa+EKrVaJDs8RKv9otLBCvVPVjvND3gncJKXX9xc8XYCJDaixUSJSwkdK37B6cOIVglEf9edJaWj6DRppUW0+o8dcxhV70Jgqu0grWRUSa7z444endU3t+tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d8XYiiNF; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-83aba237c03so63247239f.3
        for <stable@vger.kernel.org>; Sat, 16 Nov 2024 13:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731791595; x=1732396395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jAKrBwFw6AjN3w1/yul3Y1aZvpZYxgPpFC14Ia69JMs=;
        b=d8XYiiNFkUzDLsJczYuMZfni/yplJhNnW9BvJPTRSSgMGJWGale3XalyH2YjGUrFgv
         iJ1Y5IJMklTqVT2CjkK+oRN1glAfnnW8O0hl+gqA6QjRdFyf7PUFRvB8ZVK7RO8lIXds
         s5fOA72LiR7gqc5UvJHtbTaqLCRIlb5AAolT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731791595; x=1732396395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAKrBwFw6AjN3w1/yul3Y1aZvpZYxgPpFC14Ia69JMs=;
        b=kGhJy23Bb/Btt+F6l8dgyZEviWTNgYpsJnrCtlQwH7tFRIpZWpJOrMob+BBEtoUBGy
         8ltGKUY/fDvoiQeLbk7oahz+blU4tcjb/bwoKr27TaNTtZK//4iqXk+4mMRI363Hn+FC
         qaA5YqO2k3V0P7dF2JrqsDCQqIUtS0XA0kyvhpFmZ/ojR2DAOGVsvRE+Gyp7HjAndL3F
         vyBa5QMfwJJVq7Hko3ExPGGiJ490sPMUGRlZwn0qHPlkHGFVJl/XstDspU9IOKAC4Hwj
         dYhK+t8mtAuhVdhCITCJHncqgI1uq499BWXaKrYYs1f2+miPoNWjXoJYwdKikZ3QOpQl
         ly9w==
X-Forwarded-Encrypted: i=1; AJvYcCXfJjhBtUUgTQawNglrlJ+J0Ro4uJM9FhNjDzVJJBXuo91Fxt3YDbHvSV/Lz591oRS5QVDFZTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR0QZfF4TF1G92MvZIOR2iPtjB0OrGNic8OLmh6+L2acs23A6i
	8CGRF4+jBX1Icux9guAnAq8wid1KuMb9FJwCNPZmdD95WjHNeIYGXZ8tfZahSyk=
X-Google-Smtp-Source: AGHT+IF6IYnGCdfNBUtKzZ2Fl+6fZVHiVr4UDDDTVvD8y/wnZBu1qH2mWddE/Uoh/IxHTrLU4eWlkQ==
X-Received: by 2002:a05:6602:160e:b0:83a:ab63:20b with SMTP id ca18e2360f4ac-83e6c08a540mr836596939f.4.1731791595322;
        Sat, 16 Nov 2024 13:13:15 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e06d72d940sm1247007173.68.2024.11.16.13.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 13:13:14 -0800 (PST)
Message-ID: <699ce371-3d20-4859-bed4-2f2ccd9fa3cf@linuxfoundation.org>
Date: Sat, 16 Nov 2024 14:13:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/22] 5.15.173-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241115063721.172791419@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241115063721.172791419@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/24 23:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.173 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.173-rc1.gz
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


