Return-Path: <stable+bounces-54781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B399114CA
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 23:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213EE1C2122A
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 21:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226B513DDCC;
	Thu, 20 Jun 2024 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="La2UHS6A"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AAB13D2B2
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919545; cv=none; b=SBpoQbJKfJVizHn2MfftKR9//rSgbFd/Dpyzr3yY9VFXjs9kWnZBNK+45GnTPUQ/QU1S5MmIUj/Cm1ixHKka0obf2WF0wM/+b2xDk9LX9jAn7Te5Gus/u7o8m6sr+Hv0/DYqhLLAuZZX2kfHLpC56dI7gwwaa7Ca1FC8UQxeGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919545; c=relaxed/simple;
	bh=4eUDbUYwi0pZS4XXlB9XJEj7hUZz/ZHaKyzWK04Nkvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9+ippe7g1Y6kG1XGv/2mDSjx5kbaOwyans95OmLk+TPSmqiGYMgMwzkcNWX6g2nXaFNoIU4+LwynrYKJlcC2jsTaNwCmYc10gvU0mXtOR71BS9ilxpp7/ANoR/q3XKpAaTNIa/nRx/DVMjQmM/me8RIxzCct0w1GXODuZvPHOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=La2UHS6A; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7eb41831704so5828639f.1
        for <stable@vger.kernel.org>; Thu, 20 Jun 2024 14:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718919543; x=1719524343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqHqvsSXJkneKAj++iJItugXBOlFHRP56AEPjUJ8ns4=;
        b=La2UHS6Apu6Nnrh+vAhMZ02gMsxAqwc6jYyCN/pAlKHBnoAveFW/GnK/H/pRR/FkvG
         wH67zFAxf9RIRmSQZxhbwxTMzZYO6INAPuvWYWuS3nN2pi8bLa7ij+MiM87LJC5pmY7X
         7MRCz9ZW5hU2E5XfVCtvnVmG75PYW353iBVso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718919543; x=1719524343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqHqvsSXJkneKAj++iJItugXBOlFHRP56AEPjUJ8ns4=;
        b=jeNxVCFCGpHPXNHoHKA+7YtWHmIbi5Zh1cMI2ugCPAxD6YMjFXATMPeNj73MUr7E91
         2IiX/k77J2/HofS++F0ieNH+kyqLuCCDGWcAyRON0U7zfJp+2QW/3SuJSMtnR84cDkGD
         TyQv8fhZ8QZ/bnAuwIQfOFhduU4Y3hyyDyVTkTGeyha7S+Tv22YVtW1107fecThM+vKr
         XBUdS26fXMUMOp64k4lZmK3uuzb558gTQK/73xWgEvpeUPgrMM/nS+gxfKFs5mMB0gf6
         PX8n8emohkIkeW7X4Xh84U31WJZ1mC731brQiveaJsFtKDGejayKLKorslNBu/YFeM5L
         /4UA==
X-Forwarded-Encrypted: i=1; AJvYcCU6PeL+aOJtONRjXrhYglt3h927MSe3ANkQK3L+6jdl+oXCkP4W60IQmvbuH5pRmAj4+uri7Q4S/tlhZOe36DDoa4O+6hu4
X-Gm-Message-State: AOJu0YzSWVAKd1OZuiiKIx4RKr9/l+vYtfvlUjcOQkpTFesRXeW+TYmF
	rAgv4dzUSKxGFWZjQbp6YGne2Z9DZBRnh11ZZ1hAoANudWfgMbTEBHESr1s1GMc=
X-Google-Smtp-Source: AGHT+IG/MKrOHHu7bE0kz3/5P963pbzGNqZC6AtUsEQh8fvGhgnXsQm99vnIjQE3jJmQk8fO52HZGw==
X-Received: by 2002:a05:6602:3b84:b0:7eb:73f1:1357 with SMTP id ca18e2360f4ac-7f13eb9a591mr706580139f.0.1718919542734;
        Thu, 20 Jun 2024 14:39:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f391ff194dsm3069739f.23.2024.06.20.14.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 14:39:02 -0700 (PDT)
Message-ID: <7475d8c8-318a-4f8c-b4a7-c2a0be59d304@linuxfoundation.org>
Date: Thu, 20 Jun 2024 15:39:01 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/217] 6.1.95-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240619125556.491243678@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/24 06:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.95 release.
> There are 217 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.95-rc1.gz
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

