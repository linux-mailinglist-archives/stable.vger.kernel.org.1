Return-Path: <stable+bounces-163163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D552B078ED
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 17:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9313AD950
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 15:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267502727E5;
	Wed, 16 Jul 2025 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EhTr8Vin"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197BD1CAA7B
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678083; cv=none; b=EGGD4Z11KB8sVnLQ4PqJSoJql0BjEetYRMllAHpUgS0U35jj5GDaBXlC4G62xHUMy2WxM6/E+TdAFfJl0cOVzZf9FVLGrGbbHx2H0UT49SSlmgEstSn01IAqGVjb0Z8TBslYE0NvcAbjhZieXwLdauE07g+IX2SvahY0y4Abcxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678083; c=relaxed/simple;
	bh=E8bua9ms2CAifgDQWPYLUARYXuLyT8TOKHOiWf9yyqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0QzWi2oCH4VMDGB5MEsAnyuaf/fGb8K16Ei60NXoOYY7fWu54ADuqZs+qgpmvIwqSGcWjEm6oitHAX7br+gCRupgjK3Btu01GrgeTG8NEqpDwq+lwc8tv69r5nYpxFE1nNAe7kFvYp8Qs6FMBhBB7EU1sWmg9ZRoMSogUnYtUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EhTr8Vin; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3de252f75d7so63167055ab.3
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752678080; x=1753282880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/L6AVpaMRxQoagP/2U0TZvwKc8bT9msQKrHGder61Y0=;
        b=EhTr8Vinw1U8IFreOONY/1Zj6h18DckqFKiIYTIeROGXGJ+UnEn8JHGcs0VO+fsKEM
         +6GIzXmWiuQkIYGtntur+0NIh2oRpz7b2fRsl1WvJWMTH7qWIQUL1Mzb9niLlbk4OXpm
         6wjtgSTqZA+V8+b2/20AEJ7oB3QLaIMIE3S3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678080; x=1753282880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/L6AVpaMRxQoagP/2U0TZvwKc8bT9msQKrHGder61Y0=;
        b=qxW+pdcE2piSTqseu1bVUiOP2cCoL+abghSp6IpOMpynAnp3+pFJvfufceyemnBFDt
         eDzdJ0Qlxbdt+GLJanVjkoGB2KfU/G9O/ivovnpHywv0zF364OtTDw8u0+QH6AEbpAzP
         4a3nTw7Uq1JrNRD1URc5lpfCFk6dJeLbe6fv5+c4+8OujLo2atzBfH5ogLojng5B4DrV
         pQZ7kw9lXbN6sjSPjkwTmGuT16zZud1gulLtqDb8j2A5bCk0VqU9dMq5vb1/fbue1p+W
         QuM1DaBl/i4EYTssr3wEysOpkJAexQ6ZjTvAvUE8SKQJWiKr9OgvDP2M7E3Mm8gUhQ7I
         R1AQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8Py/oLibWuOc0pGVv4vPCgkawN8xvW43+FKezm6uK3zzGB+oHifBnkxHcHxL+KGEPpIprvQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Q323OGsrT/eIhhw+K2uGjhhXm22P+SLZ0mYRqFPanSJBt6JY
	+CS1IBgis9Icfex5r0f5/GfyTS9SjiX7KpJx7hJUXiX0SS04q3NnNDuksoMARvbmiAU=
X-Gm-Gg: ASbGncswk5Zibig9+iBQoAuvEwwL1tzedpwbp3Gemmn3ivvonm4wQ6yQnm0yYhcxrp/
	pR1L0+9HrZBrPys9Ipj2lNBG3oCxOJ8T0wgJtQX1E9bdOnIMxOls6oIToqiKx0cHfPZbyTGIzrX
	c8NXg72fMKNXuIAkXDCSF+4Xu7dPrMyguotuc+0wYX3e1bTtiMRb5JgrT44XJz/HiJxpVwSlvPH
	6okxhraQWhxmOKKQrdcZyY0txjyljnlb2dSMlHmkldn+rDsbz1/0obRNOoKYS9/JVGUzKflW2sI
	2HeHcyrSIvwO+iIWUc7OvT5R6iJo8uDDUJFj2ByxFcz8A7Xq82jqc1Ng3N0+5+++kauOmjXFe9C
	u9hivDOtIw7kFfyndtAs4ihhE2yW2hwgiBw==
X-Google-Smtp-Source: AGHT+IHfZQtErGT+6TyVnEo5uXoQ7tA42hG0UFbluZUKT9wY/1GsEkt0bSHRzJHzmhjhK6e2Gk4vMg==
X-Received: by 2002:a05:6e02:2288:b0:3df:47f1:bdb9 with SMTP id e9e14a558f8ab-3e282e8d3b9mr31378135ab.18.1752678080006;
        Wed, 16 Jul 2025 08:01:20 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24611e84asm44726865ab.15.2025.07.16.08.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:01:19 -0700 (PDT)
Message-ID: <a7205943-b3f2-46c9-a00b-0706eae9743e@linuxfoundation.org>
Date: Wed, 16 Jul 2025 09:01:18 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/148] 5.4.296-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250715130800.293690950@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250715130800.293690950@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 07:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.296 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.296-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

