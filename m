Return-Path: <stable+bounces-145720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1BFABE5EA
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 23:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238383A9974
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 21:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BAB2586CF;
	Tue, 20 May 2025 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bilz7y8F"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683674B1E7B
	for <stable@vger.kernel.org>; Tue, 20 May 2025 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775986; cv=none; b=SaSBp9WDeRMwPUe88b3Qjg4qXrdMSYPq/5dQ52JINzuq7yGxTw8QJzE0/xt9hgFj4HsnUonsOi1AWSgkUb07E2jS5vGwjco+t0LE5qtqBS5slms7htCQ5y4T721KFfIvxBq6n8q0E0GAL7lq+Rgf4E7hZLZlZrJouG3N158g5GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775986; c=relaxed/simple;
	bh=eSdCjtp/1fPo3n/voZuF4t/69QdVtMMYeXdvN1m3saQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBGrBCrho3UM19d5Bj28NG6OOZv74iTPL5kk76Ji55pxowv0kpNhv7gyOYX8KOISdU4l2Qjwn2J56IfGpdJ1PV9b05f4uXtp/spXmscylkp22/+YVP8mytm/a2X45KW1P7CFFjP8o53OPIrK1VpSyBErNCmGPmVwuvlMYWobjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bilz7y8F; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-861525e9b0aso453794639f.3
        for <stable@vger.kernel.org>; Tue, 20 May 2025 14:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747775983; x=1748380783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1YCTd9DwztrmkYxeGkW5TVua7369Pn3fqP+RCzxS4Co=;
        b=bilz7y8FcMa0/I06KAdpC3hETZnKmT2ppzWQYYv0oOlbE5ACC2ta9mJ+yEqVwXNF+B
         4gXaSSxRg1ocSxmjgdyiO/jRRvorn5A6NBRB85BMWaXKRW8/Lf/Qso7MMuAu1XNIDEK0
         prWjVtKFl91XY/0d0qlZssdTmmYm+aLOxtrlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747775983; x=1748380783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YCTd9DwztrmkYxeGkW5TVua7369Pn3fqP+RCzxS4Co=;
        b=gY57qoWDKmdFSNmX6KuBMqLbJA9tI+a0B+c0B+ja2rPgfdmOUp8Zy1n+i8VvrdTAo3
         hKubBhD587RBJssEFgJuaI5aeLphXgq0kFM9V0ehSfaW4HMQDU9lE74oIvZRQTyRP3ZE
         LBMF81uNt4uT4iilULUOFdeqv3QHIqaEmCdXC8gEBaiUv4447rzJVq5YTkzsWJC4rJPG
         yFRgOJGrQxUFF5LISBsVCP87xTxCUlckVqEqq6ykwYED9Yg3rrIPb2PV8cXuFU+N6S82
         wuXnjbxwOalxfjnk7cGFOqTnTa1LECBy8e6/fql/EKLUbHL4KaHp+4OBu9NfuxZzJurX
         iIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxXuexlaH0U59BDuuAj3DNB4vTUX+lodb3EQ8FQNUCR1cMXIlzwGHWXQoasoxZplc5s4CpH3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw34Mo/NGIFgMfUUQpO45lewfKX8lGIJCzxL0f7AcYwDygTH8ib
	YBNecHPlYodNwzf0c0UpX81uYaOGPnA6zAkavvLDM6YzRwzGHGjig3tczEAzHXcIt4o=
X-Gm-Gg: ASbGncseTK1wMauvOLeufOKkPaksJt4l3nfLs5+682pesYHseBTrbcy8HV5JqO1jo8p
	vERRFsB52ODebOixZZ9wPFcObyl/gzgyRicRDpMeNRniP2te4wQSDb6x1mmBQNLAEuPsljoW6lk
	yWItiLY6cB6kuzn0M4CXNZY7ZTI/nB9EhNbcpxNNz3ldIB2ATTx6c93f4tE9t7l2RYdJLVQD/DS
	t1tqwf3HREjemGbt2VgUEyeZoMs7VKHXByoTFPeyS3SrPpfTWHHM4VMKENDb7AQsFZG+aWTNo6P
	ID2voQ4WyvuhtHnq6++1eJ0ogCFKaqoISX7IsIbLprp1GTT/Yi2NNGd8DBW/8Zpndh6XRvRt
X-Google-Smtp-Source: AGHT+IGHZLwTf8LjSiEncxDrt7PbnARYCjK2hr9FZIftt2iQNbyIYNrlmrCAsmfEOVXuFPxxdltMeQ==
X-Received: by 2002:a05:6e02:2592:b0:3d4:3db1:77ae with SMTP id e9e14a558f8ab-3db843313f3mr233401395ab.18.1747775983457;
        Tue, 20 May 2025 14:19:43 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc3ddea4sm2410313173.69.2025.05.20.14.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 14:19:43 -0700 (PDT)
Message-ID: <eba8ae12-eb72-4913-9983-c9d600ba41d7@linuxfoundation.org>
Date: Tue, 20 May 2025 15:19:42 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/97] 6.1.140-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250520125800.653047540@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250520125800.653047540@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/25 07:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.140 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.140-rc1.gz
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

