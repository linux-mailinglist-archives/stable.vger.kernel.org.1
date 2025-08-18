Return-Path: <stable+bounces-171654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19189B2B258
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 22:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5681B64F47
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 20:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B9F22A4EB;
	Mon, 18 Aug 2025 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NTYJxBWV"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B08224249
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755548880; cv=none; b=V94C8NSiKafDhYaz0EceFgjK3KtnmDx3vGu2W49MlVp4ZZuIObiHIsYwhum4XIQQs2a2zOfUVdpyvIKKp/dZNwerLCmODzKkdwhMbrZ2WoSSwfpAsbUhq6vZnkAC+k70gOsODkLyf1DZ7vcFVFSTxDw3e8a64tz5pObT5OHL/lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755548880; c=relaxed/simple;
	bh=hDooSJaE5aEbmAO+pjBnSTkBESSsm0eOvdKkpZB3s5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jaqi8l/6AflakQVEuWNvtNrHphbgaKoj2zeNUHJ+1pZW6xgJWkhyDzGU9VQLULucPzQGtnx8OCrrXfq8SlBpS+IB9xhk+k1KdcH9/zSNqD2/7dJAv6pjP8yTsQzgDNO7wxDVlIt6yd6lKpXUywgq9CLQ+QcNY5tKfzD/6LUK2FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NTYJxBWV; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-88432ccd787so290628739f.0
        for <stable@vger.kernel.org>; Mon, 18 Aug 2025 13:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755548877; x=1756153677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hwb/sGg8U9KLGwojJ2PDXhY5l4YEOf/IhW5l2o/KSE=;
        b=NTYJxBWVauydObHkz8as1kw9Ed2ZawmRTcznqy83DF4+LOFXhaddZHM+JBR0SCvVxk
         GfmPSs3e6BtcPgeFaU01zcXtDOjofGplfHcYZWhypAG0Z5VJ+fpISmQeWD7dWbbpxFHB
         UaknzkpXQMSqhDB+B3Z4g19MkTe6h7IHlmmvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755548877; x=1756153677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hwb/sGg8U9KLGwojJ2PDXhY5l4YEOf/IhW5l2o/KSE=;
        b=laOHkBaXS3Km26QuEs4dOIUD2UN7RJV2nTrgqBy1uFLKfdRLbQ7088yr9p4+WK3kjG
         jahHSnJyQGWmR+pix9oGR6xYV9MAHTff2nigub4QzqmQPCva31MZrKhXj3L7fb9o4V0m
         KyH+uUW58ZjYNINN88QBl2+fMoyCBh0XWQy2r6lEcBHn+Ut1a1lcBmvKxRoa3EI4MKRS
         NjYCeiYsw88cXiN4eTYaO/lTAFdzV5FA/srZutOy3qRsrwe8dFofmUc/ZeE8W2sFRxnO
         /+SP1Wll9lxtitOhEhFgy8LSjga0IbZ5PwISFzrlO1NXA1T7+vAyTa3FEyadhsj1Afcj
         m8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXd1CUd2Bf1Q6IqtxidfLvatGdOtW8WOayOza8lTS8jenxOiUo2Qt0p9Uk8rWPlyJuFfPXFs9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwriZ/kcT5B2e37Qbah52X3pJVqq42D6hCdsPMicw8oKEvDNTFE
	1YhOtWHKs4SZVZKISigDU6J5JPMNTu2OoiEw/QjwrGwgu00G5hWMXQodPtyJPa8Aq38=
X-Gm-Gg: ASbGncs9+QqTsdT5iNYDZS0DV7A9R+JXM+KT46CchgoLPLtHrJzOtyMxsh68q0FQsSl
	vNewb0i/y3Io9zHIIGN+gYKAPKwJBU803jtMItSim+nII4PjcvA/JnC2PDVE9Ilg3h3S+rDkqIk
	oWmS3cDKedsHQmHY8xHwg8sjVy9ZWS09AvbiFzcIqbSblJum4FTRIXudGn8ppxnNGBr23dTzJNn
	FXPNpRhIxIhQuBlUdnpbPTLSDoI9eljjW38H03BxfTz5wic18jx91cV6V0FU6wppskqYe8IVzAv
	TpH4dpcSktL1uRf+2KfAGZecbKslLbsoXzxrE275pQ3RL30qSgANdHsAZ6oO53TQ7ScFspTjHAS
	tIVqUt/X3dEYScnpr1Xdj4Uh4BsNO6eJQDP8=
X-Google-Smtp-Source: AGHT+IHZEEvzNoKlVVqwlC5w6deqnH1DrBO7M/07loW+8EGXwxTGSXrkqC3Q/AULvCwD0f2HNqrD6A==
X-Received: by 2002:a05:6602:3fc1:b0:881:85cd:d08e with SMTP id ca18e2360f4ac-88467e825c4mr5673839f.3.1755548876979;
        Mon, 18 Aug 2025 13:27:56 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c949f7a37sm2823835173.78.2025.08.18.13.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 13:27:56 -0700 (PDT)
Message-ID: <e8442465-7ac2-4c1b-85d1-676ac5c8fb8b@linuxfoundation.org>
Date: Mon, 18 Aug 2025 14:27:55 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/444] 6.12.43-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 06:40, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.43 release.
> There are 444 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Aug 2025 12:43:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.43-rc1.gz
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

