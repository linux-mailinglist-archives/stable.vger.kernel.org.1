Return-Path: <stable+bounces-191543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB3DC169CB
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 20:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414261899437
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 19:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BA734F24D;
	Tue, 28 Oct 2025 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IraTZj/W"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E315158857
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679671; cv=none; b=CDiWjOuathQkCXF2EVJc9fYcj4c2kv+mGLHppCQK+bsNpdCTbZNQSBavAk5MH4W5o02m0nWF/za1n3bVqhz61Fk/kvkpPwt9jbpwcYVc5pZzAnQYzrmnFfE/1sJPECUHfSEYOFYopjYlXAKTpDv+l4FFYAgqJbr43qZ++r5+mms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679671; c=relaxed/simple;
	bh=e7za67gpaMzXAAnduU0aQ85fcHm086VfI4xydx3Us9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6KmfHjV/Sby4jdYKoKzcK3kx0F9z+GvCczbIBxtuM9MoGQWJ9a233kw2+GAVNTwIkf9b2hXGwSlUTF/DhgEzuU21Su+nx6/hiORwHYISkbb+ZrSvgxUSzXSPAI1g2BojMaz6LBzgRx1B9fAx3Jj2hkcSuXIrvb31FdgpS2Qn7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IraTZj/W; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-430abca3354so59937785ab.2
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 12:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761679669; x=1762284469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PV1bENIf0l3RXjjkTJnnKUbQWBjIIJGeXOMl9S4eqCQ=;
        b=IraTZj/Wv9BoUoZuSYE4Ylut8J8Hj1DLpUzhFWE5Bmzxee5FVXzhHA1XbMdhncDrSL
         JsG/StAvHnnn8s9FaNpzvbdQUtEqH36K95X6JOvdWqfaWkf4wM3/nBk+eEVcuKY7AZKl
         gewz5yZmuShSq1rf3WDMsl8o263BCk/vu0k6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679669; x=1762284469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PV1bENIf0l3RXjjkTJnnKUbQWBjIIJGeXOMl9S4eqCQ=;
        b=PIF/N1dcRzeW2QtSYBzyuY4edr4q1yVihbCcLXTM/7SGPxnhubWZ5/Eztd/CGAMWEA
         P6jOKZI9dIryO4bDIvt/ezZJ2x3lXdYCC4ohEhptKhOw2Gjl1V+OSe1fIm6ggcXn+YMd
         jC+kxHRRnN8PrxMPl/GkBlNzGEwbxDNQgIdj191hzc7fTAETCfz9kHQEougX5Edw7EKT
         yqFDwjwoFhXEXHTBtIgM6lOFSwS5dVihJgL/LJvwz2hQ/xbNoZHK1r/YOqlxBMb1pkaX
         UHtIQqBA7gjV2i0oBoqve7Inon8TAiDL55v5uZjgfqp0CWloe4yf/lenePT6u+9HXPCc
         m2Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXbkZ6q6xzM123yxpleNLi7d5UgB06sgK86lolUw8xdbnLan/AHi5tkJzATKnJh8WTFAYc+DKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6NRcZ+Ra944CNNUALRMR9pZIVU0JiudDiY51VLhOpaUw4Es3W
	g1wSDxdoiodzkKutOncSAITnzyaxErTJa3b+R5HUBrrpQPTJqyJnqrLl911HKb0GRCk=
X-Gm-Gg: ASbGncuQXXS2++n8k0k+KbODyA3TZeAlkNWJbtD7Ux2deOK0c6ze1bR45o9yI1OvHJv
	edQ4y+WUga+2GIGrmPBUKKcM7nJrqlsLVVBgbWIZ2Gv8nn+yM5QIzy8hKjN7zbtx21Lw+gJbjq7
	6lQOvC4RiLl60IYoWKSJ6uR26S6LiIGxYfdqNl0myzpqLiGYArBILguT35/Kk1mlbDH/ER3spmX
	+smeppjT7gk2Exx3+lMj4hBdh9D7zpev0/JDmEfnJTC551Uhl6UIRDOyxKOzlNithAilxtDV47t
	w4XNfz3somAnnpZcdWrT3eynEgeKcQ0mgYHUVDCdtvI8mkGDRkmzISkOql1JIgl1ulgoJQfOuM9
	x8gVgGDsrZcGgpSlxk0SLmD0kYtcQ2tVHWNSYoQKDG4U7s4Fn3+CZ/tAWKrQi1mdn+Zc14KR6KC
	ShlJz+NLaje3b/
X-Google-Smtp-Source: AGHT+IGCnaJwEiI5H45X8uH7EHHZvYqawVyeXkrh+JuUvou4c5LieEIEgsLjfsVja/uVxA+aAgX1bA==
X-Received: by 2002:a92:cd8c:0:b0:430:ab98:7b27 with SMTP id e9e14a558f8ab-432f9064bd6mr5104435ab.20.1761679669136;
        Tue, 28 Oct 2025 12:27:49 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea73dc10bsm4734334173.7.2025.10.28.12.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:27:48 -0700 (PDT)
Message-ID: <cafe791c-5f00-43f2-85eb-f083c499f978@linuxfoundation.org>
Date: Tue, 28 Oct 2025 13:27:47 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/224] 5.4.301-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251027183508.963233542@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251027183508.963233542@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 12:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.301 release.
> There are 224 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.301-rc1.gz
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

