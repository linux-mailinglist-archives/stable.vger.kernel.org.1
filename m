Return-Path: <stable+bounces-171650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3CFB2B220
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 22:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E07A3AB8D6
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBFF255F5E;
	Mon, 18 Aug 2025 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U498O8qq"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB6B25CC70
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755547925; cv=none; b=pwiuzfZAUfbyEef6d9QldawDgRVDiEZuHEGem0rvYL8q/F1LL7la5aBzw+IYsrkI9AMcwfRCBfCYd6UzOqNGgs6SJnRwScAc4bsD8DBEuODJ00Cs6M1bS4KkyD/fnadeF64eocBfNgmhzUOvy/Cx1IgE9p5Yx66O5AptHiuZNgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755547925; c=relaxed/simple;
	bh=ZTEw3v59byAbxSZgmjys08ROhmY00iv+6lSpKMPh+2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fozrOWxSuyDdtxT4du6d3VrmCsrGNoVjTX5aaGX6VmdtoKbWCF5JLWZxgK9qLDzYln869ksR7njVPvHz8DGYEclBJGYF2/PyIGZtWErdXA8Bm0rfuyPVqIEwZN/j4ryCjK9HKS/WKQDKGZrVQhC+y3TIZ9T4ko2beuraAmFLWC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U498O8qq; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3e56fe95d83so25543245ab.0
        for <stable@vger.kernel.org>; Mon, 18 Aug 2025 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755547921; x=1756152721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sfUMdozgYccOdsGAt0DPTeKUGhDvpTTBYKEk2M/luYc=;
        b=U498O8qqaRSy6gKgweaX9kN+o7fyyKupgeNm/NHZnpDimqgxVaVgsFE/hNcYS0r3g6
         Ie5Z3BwrTgCju/V/Qg/pqdHfJHV8eqwM/YOHd4cn/YftzF6htSJKUdC/GTjHSvOfB4n2
         i3vcQxFvP+w2u3DDa5WTWPlZPVHzA8gJTDg3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755547921; x=1756152721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sfUMdozgYccOdsGAt0DPTeKUGhDvpTTBYKEk2M/luYc=;
        b=eWlgJ4CDHC4DNw7PCJuZVVwtAYZVTmMZP5rSzC3DRPKphs7MnxnEilL+/n7gOYixLX
         h4RVsGtq6a3REMfOjtDTOEuDIL4R6tlTIOZFGPIN1KD8wBq+t/UHNBnlKcgsxxASh9sz
         PNY30LcctpAUkikUcNeq+t61i2Lg/aDya92jdeJrRjHBApd8Z/NaCAtaje5RRKAkSC2M
         teKvw36FUClZjn71UGU8DgvFyz6VJLN9GA4W9K4lgkgM7Fk8E4qmTh3MTPIg9797qW78
         v8OBFSAxXpxfy1NyxURFAtfwlUoCQJRSkIEJQihoSRXEOZALbmaKApdHuFrB86PBmquK
         eg7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6bjhIaRvpSYAf9j9/AcGdif7LRMA8WDo0b9M2Og+mqePJUdLIhY/yFvzfF9dpGsmhAdl6xwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa26N55ThqE9WhNqFDCA8FlavCFIvDnMvil6qp+vAlDoc0GjQJ
	esPMUH52EJHU+wfb1LMG9kBrMIkh5MupeZoh0LZNN7QUV0VrN6ZoL5UQy+hjav/syoVo4NoBcK1
	suILt
X-Gm-Gg: ASbGncsHusR2fDli8qfJFyRYYJ8kJrGc4w8QNwQscaz5YunAxIiA0fuwRO5dfi8oUKG
	s107TSHNrcb3nFyWuGkutElNMGw1dfZDXM7kJzh4GyAmXjn2wPPGy6FgCwY0bFD7kcJ3asDeNGG
	OBnRGm3Kvgp7aHu6UH45jWMQOco76gF1gMkwqjluX8T33Ts16oS6yLoWrID2uew2Y6IhS87bNqr
	u0iT9S74a62ZSBcmbs/V1ikqmwqOupFBVBXQHxe/tqGYzNiWp+EPOBYdO5+DzeWOfwgruvfQ6HK
	YUZB0FaannjJOh/fezbQlzObFWlqs1xCenkucxu+DHuOqt6iZS52XB3uLem1ILsXyK7CwfnYLfi
	e2z/POzFdSn1QRlof8NqckwMuh3mJfdO47/m7EtBXKjc6Pw==
X-Google-Smtp-Source: AGHT+IFcGP4eRLk9XuN/IRxuYbZSmR1FokdhKrwhASissjzBWd2Po9X+zsiqxt4bWrarLNWlvZDNHQ==
X-Received: by 2002:a05:6e02:3e93:b0:3e6:72e4:c5c with SMTP id e9e14a558f8ab-3e6766555d2mr930395ab.19.1755547921189;
        Mon, 18 Aug 2025 13:12:01 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c9477ef61sm2927751173.8.2025.08.18.13.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 13:12:00 -0700 (PDT)
Message-ID: <bb7f37d2-dba8-4d9a-81f3-e1125a620bc8@linuxfoundation.org>
Date: Mon, 18 Aug 2025 14:11:59 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/570] 6.16.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 06:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.2 release.
> There are 570 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Aug 2025 12:43:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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

