Return-Path: <stable+bounces-145718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728B0ABE5D9
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 23:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0474A8149
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 21:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC09225392D;
	Tue, 20 May 2025 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bi5Mo1du"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C433C252906
	for <stable@vger.kernel.org>; Tue, 20 May 2025 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775685; cv=none; b=AZSvI34cRMmpzcSPrGM8u/oKcoeM9gGEn4fJXSGq9hLQRDrs311nsMjk5tblwwiQjGYe7l8dw6bGX8DZZt9RHjYrhRVbW0j43IMps6YvNWcPMk0P5K0VWoGw5Sb9CO3gii6RR6gFsiPyQ8iN8//i7ojES+oRhsO2tDZ75Dk167o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775685; c=relaxed/simple;
	bh=zojOLtY76gZFr763PmUNcvbsKlkE+bDQBNyoxBicd40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2RUPkMFTPfi5rptXUHEjwL80MM8yB+8vcxVdB+2rdlt6XB3KO+pbMvr5vKhM2Lq3VYjkDOo4CJpN3MWTGGv9Op1ww3q1BaVOAZtjmsePLzy41cOLYaRXUg3noWu/ijfQYohUtSRf1XUNrGfHxUaZhfuivI3Jmx2jU88BynJE7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bi5Mo1du; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85b41281b50so203314839f.3
        for <stable@vger.kernel.org>; Tue, 20 May 2025 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747775683; x=1748380483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fIN71OkdIhhPkkUBL5dzqoGGUrchQUGD2wwVLvrOvHE=;
        b=Bi5Mo1duWNgViwkgxLuX5lUZrQrsJQarCRVH7p1/4keD8qerOu0J6BoGqHzHAGxrD8
         BY5x6IPWX1rMCNpYhAmPW2quX7mI+FwEh4szt0HxXBxM4M9x/9kcoan61OLBdWTO/z2q
         HocD0MHnOZm/vjf5qMcmnb2/YjcH/c9dOGByM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747775683; x=1748380483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fIN71OkdIhhPkkUBL5dzqoGGUrchQUGD2wwVLvrOvHE=;
        b=LagryuNONk+lw1H1Ro3pOsIP0Go4B9qdV8bBbdV88+BnTJKWiz+Qh6ZIXFjK9nIxKw
         YgKELMtRxryo97wexpJkQRiAkwCBPV8BUZbTlzsR/ZBl8df0Ej7QWcN6NPqW0u2zrYMg
         QBB9R/+/yuj9O7cKMUQ97oZaBl4bPKqJijoN3cTKhp3GfyhTbSZEXMhFev5alnGisKle
         djtNSbGhEXZuSR1QKIbIIH3yr6xIjyTtgTjcRgeDpelxR6E40woYEkF0N5fvMOPpKVRr
         bdPEvl0fMtZ0qng9GHVEJ4p9PtnHw3fLc5okt5O/PPSBNuCIRFF33fLoV9o5khC3r08F
         hXpw==
X-Forwarded-Encrypted: i=1; AJvYcCUjqC0a2nTq6ErbQFbyTnizLNoPVnAWivZhLmr+t8uzY/r/CZxqfeu4GhmbUKNFbyQxuzpzKuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxygQaYStapjMG0YuXtibtatUUc+lmt14ENnlgdChKJItqq60QI
	KIoQEuWQEggQnlAVtEtin7ohDiNVzvKQj0rt5I9gOMrvP7+US2Fa4aZ0/DBKTVVEkkc=
X-Gm-Gg: ASbGncvTFfZc/xdD2ID7YENqFtgn/dFGc8YpxGJ4YK80niZ2tLKEDd7eKLQXBkavYCP
	mderGHwraXd7Xmo1XIHXXfU9yyz9pC5CCrfdAl5kV3NtZWJU7OGMbszgSnowNxmpXA1JA7fJ3GX
	vW+tiud0V7WUWeHK/4mxdSKdRiRJe3JJnHI3VDDWNP+/ApP6kg0kTuMGlXUBzJc+F3u0A4o3w3H
	gKY1ux+txmsZ+fG5kZhTbBmuYnRjTjZUz1WimiBuuGiEWhCK9FJxA9gXkKcQO7433/YIpRmivJn
	/NKKLT6ilQ8n7kn6DcjiCJ9EkUru5Mf60mQIPjApQyf+hVVmNsqTI88UxY8RQA==
X-Google-Smtp-Source: AGHT+IF5gRFWN0+dvmw2Qvtr6a2oalq16YVeLrmVGDkTHf9V1z0FLFjowunDN2PSJeB2qQecf7b4bw==
X-Received: by 2002:a05:6602:3991:b0:855:5e3a:e56b with SMTP id ca18e2360f4ac-86a23256b96mr2323304839f.12.1747775682783;
        Tue, 20 May 2025 14:14:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc4ea966sm2393379173.138.2025.05.20.14.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 14:14:42 -0700 (PDT)
Message-ID: <f9779eb7-9a73-4f1d-90be-54bcaac26bfc@linuxfoundation.org>
Date: Tue, 20 May 2025 15:14:41 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/143] 6.12.30-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250520125810.036375422@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250520125810.036375422@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/25 07:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.30 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.30-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

