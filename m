Return-Path: <stable+bounces-164297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 502D3B0E56A
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 23:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D62A548192
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 21:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7658286421;
	Tue, 22 Jul 2025 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CnvWfY8q"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22A52857FA
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219617; cv=none; b=R6M39RZDoHdcHM2+dlfnU5pFynNkVTCTQIZVOo4PTFLxJ2XTcIJx9nm7v7pIdtWJjz4y6ozblnBJKAtUxafyvnAZLptsmeJWp6D/8T9crIcIs721wmCXfI7pJZAl39xYdAmeZlM3D2kuK+ZjT9IFEg9kejhBIwcpHWUcDWg+tqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219617; c=relaxed/simple;
	bh=R90sy8ga0ZZZAu0ItAJ459x0QIDCaY14qd4tQ/HifJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=St07pwzIsGvcIumoLiuFG7KzXmroBBD1FOjEqMspVjOQibrFZOUHQ9oVJO9lAjAZqj8yhw4KWYA+YC6Nt0z/4ZOenOL++puDcP+u/4W6oDcRSMV6iobDawx+NmdVoMTIUC9m+LPKXrTiDkwQZ2A7UFX6BLPfdOHkYesTcXckRWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CnvWfY8q; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-879c214fe6dso162474839f.1
        for <stable@vger.kernel.org>; Tue, 22 Jul 2025 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753219614; x=1753824414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4UuRsKYfywplWAbr3imuDGMU54u1KPSnKxc8G3B9oxs=;
        b=CnvWfY8q66Z0J3Kim8TtHfM4+W2JZHQdxp6tsvUNIOWKq3NGXzZGPee46QOxAMGWLo
         i47Xr07TR7RdKQWKhuu5hNx6aOeD/vOCmd5Q0CeX2xzIJNtA6SqJjHKug0lYIyV3ZiVc
         RkQ0OzsvP0nXsgl/XA4ZoH5y9Nkwx2WCKQi7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219614; x=1753824414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4UuRsKYfywplWAbr3imuDGMU54u1KPSnKxc8G3B9oxs=;
        b=B6mIUECES1rb9KcexWsrw3SA09viTsxQJ8wQXuaM+54A5JVE+qmpWnM9KKP0dza11V
         c+zpTA1lw73sLj1b5uQmvBqdkTS+jEx8ePYEIlIyFlGWmTBEX6xaXHSUBKF6z2bSJNlE
         h/R87j3q5nXWsMt9S7SJMR7YKUZmVuNaULUZWFBvU8BG63HGuakxTo6lzihCEaob+N1m
         k9iwVfM6GUSCNeFLEHE5svO+ZYmYs8gvtlCmevEkL2NOJwkp7xhq8X/qx9owcyYwNjwk
         mW8ZSqEsRsszZIG6laTwaavbCqJTUWATACmuOtYsKcvxmr0hQ9TErSMynMrhx4Q84WxV
         GQmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhskFqNVLNajuidF18jWT2bQOqUmEtoBPoztpW6A2XuhLMRf2PI/CgIdJ83vVuAq1/GYFrGqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY+gv12zf9dvZ0JyekSXf8CRFRSN91UXNfFuuySXvVztdCmyFV
	YVvJ0T/IMaoZDxgRRKsAI+c9TbNtvRikPvLAKXniEEZ9o7gnRtZCnqiMNpG8F6WX0cY=
X-Gm-Gg: ASbGncvLgT1EqwSyniG4f5dTBbp95WWhbNRP/E3NAwvY6PyMrL23b+nItPSVhQeur2x
	pBYiYrwbMllBfah75+nWXJ0umugsdFyQfV56iGA6f2F0WdYzRweAPcnIQjFFNZXloSo2QSXUB8K
	WRQXh9Xr0c1Abd8fpBRcDvt/+wuzrDDfHgE/0ENxL5sBBKP56nrCip2mz/S8SI95+dLtHpscKkd
	VEs/Mos9tUD/kEppXLfTxMe+NHP9VC09ZOJiRYKdWImz0fmRb982pnn0gqVWv8gK3vTVMAPBkf3
	wWjrNQtE8qNLaAJxW5GzZucVnHAYjDUZeCFJMjBn5VPG/Jy5nOr46VvjwJbqKt2LGoB2Vjehh+0
	s47zk7R6fhTTQH04eOpzTX2RRzxYUE3OdHw==
X-Google-Smtp-Source: AGHT+IEenob1JoKLFexDbIKx2AIbRh0HfTi7tgzzyJ46nb+DTSQdX6wLisZdHxDOfQgdRENh8XvLqw==
X-Received: by 2002:a05:6602:7403:b0:867:6c90:4867 with SMTP id ca18e2360f4ac-87c6504a724mr115953939f.14.1753219613813;
        Tue, 22 Jul 2025 14:26:53 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87c0e40f9efsm331649039f.1.2025.07.22.14.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 14:26:53 -0700 (PDT)
Message-ID: <27d83e9f-c2f7-4d8f-b5c2-0b23ece4ed0b@linuxfoundation.org>
Date: Tue, 22 Jul 2025 15:26:51 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/79] 6.1.147-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250722134328.384139905@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250722134328.384139905@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 07:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.147 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.147-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

