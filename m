Return-Path: <stable+bounces-123121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCB2A5A3ED
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 20:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7486018919F4
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAC417332C;
	Mon, 10 Mar 2025 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wso8amC0"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FE8231A3F;
	Mon, 10 Mar 2025 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635676; cv=none; b=IRbCI0/kiUEUiU2NojojQaWbFyy4rrp61BNUfxX0ihg33ttpjUK81p9dAJjTLX8MJHz9LA67Qr//PesT79jqnUkq35rgFyEJK55gze4A+lZNMg93dF7VkipzwEJyU0sKkriTz/D7KADTPkNlsHZX2u7DBenEDMLk2RW3jGzUlg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635676; c=relaxed/simple;
	bh=NEcHjbJGw+ZPFq/Bi8SNJJDZksugWukJSYtK78q8neM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6Wt40mquXYxEfqbpYDGgIrRuV9LavE2nKYfkR6JxZbKvBUtwXK33IP0duyaybcXBOrv7dZkVvCu/nSDW2bhvAUJv5AsgMbVSqLeEShncsrm0EaIwEXKNdAN+Oy4A44xFHXJRx1XIe1DC/Lbc9QY2niZrOzWAY89CXHw8AzEsnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wso8amC0; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f9832f798aso514634b6e.2;
        Mon, 10 Mar 2025 12:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741635674; x=1742240474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PsaPJpYGR/JV85NCFhUCfNi1WQgYzaKdf9ISLWZYqHo=;
        b=Wso8amC0BrWhKaxgz6y8wwyfujxD9AhvzrS8HKOcZjplenmkvuB4UV/JDIaI+ap+/+
         /klEbwwqBwJgjWnG4pt3P3sec4Nr3lpCrVU1ccIRhzHhBmeJjbZBlfJHsF7K51LTIPTA
         hVT3OK/AO1Qz90lPhiutobEda/ayZ48W6OVCS33KswF5w4f1srRAAjLZXstaEGRVrrKJ
         HUCgIkNv74w6PShSaWaGUuDzb2JKjJv4LfGsc6pa6+c/fxkYk6qhpQEyCjKWkE6S5DQh
         dMYj7YuNlywMIbL7zbCUlfLWBkhdLectJoMyjQqHVSidYQSbTayPH5PebQXKLQOalFam
         nMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741635674; x=1742240474;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsaPJpYGR/JV85NCFhUCfNi1WQgYzaKdf9ISLWZYqHo=;
        b=IqnnvWFLNwSrKsfdXNEVG8cc0VrImnqx4vBNPxW4UTok7Gace1xiYVo72SYBE6iqjh
         XmeSwviCa1cSUfRP7YzXWEzhHiqK92X5pd2KiA96HU99Itqpj/bidncOppiZ8eRWR/Kg
         LEawH4UP31LhwEzZabYibhPmN73feb3LvAumKYCv1fATVuoUuc/20aNkV/Bf/4+PEjIU
         XWtL7qYUJz365cZjZ4jUi6Ta+VG8FzCjxMyuFLQGBYotEifL31VmB8BUSlOYa0Nr1LwR
         NcJ1IuA905Q0cCawkl6Pyn9zK2vetBva+B12txeWCIOOEqiFVT9z1tqKzX62zCFkHkma
         f65Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+vDuNdwg24U/fyYwehxruyu4xHWEa4ibKaKJ83gMYcGYn4RhL5zdLojTX4lYvR3JKtcMTHJF7sDpSZjY=@vger.kernel.org, AJvYcCXLJPVF1PboA+Cyr15rK1rqjwfD8bSUqunirSjwsF8XhH40NTakUsWe/yopIoPf4hWNhi2DUwb5@vger.kernel.org
X-Gm-Message-State: AOJu0YxU2jG8oRVC2jPHztrgs71ioIz5kQqLM/aSnhCBMsyyvu4/jO1X
	WPP8mC+eP36g2SReAIyBZklSZmL3FI8AumjS8EpETLu+SsaIc03EML+Vfg==
X-Gm-Gg: ASbGncuC3yQYdGFQp3nWmh6MkuIx6T2OhyDyDyj2uWtn9Nrzo4HYrrs2fw2RNE+ubQW
	3FcVrnh+z9i1MBduM/O++8XQtFcs0dMZwE5H/Dyi40EAhi9XTaZkd3szUm1NDlCz5vHHcJx3RDZ
	8i5TbK08NbxKJrD5No8t5BJ0I1LYZT4kbezJ2j+RkT7cb09FM0e4Rx4RWQtGD7At5Ka02DaVrR2
	Aga75Cv/INi4dabxzQS4+SvC+lCGdy0n2KAwSA/nV8ftTbE0iUFR9EVzwnx4iSu1J53bq6g1pMM
	MUe/ao3EHXX916y7F7xGBrCFYR5TuNtV92xkwCq+Bf+ceXTlGCwH2COZlKAejuN7MSOJnxJIjot
	i/zEDIMc=
X-Google-Smtp-Source: AGHT+IGZEmJj6Toe371GIRrbUKxALY678CuHDkqIFxqypPz92gvPBm5SYnQhonk1j4GqVLO9u8whRg==
X-Received: by 2002:a05:6808:1d21:b0:3fa:2223:1d2c with SMTP id 5614622812f47-3fa2c78e8dbmr364670b6e.37.1741635674207;
        Mon, 10 Mar 2025 12:41:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601a5508d33sm974670eaf.28.2025.03.10.12.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 12:41:13 -0700 (PDT)
Message-ID: <de292a2e-0b21-43bb-b0b9-e95a199070ca@gmail.com>
Date: Mon, 10 Mar 2025 12:41:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/145] 6.6.83-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250310170434.733307314@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250310170434.733307314@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 10:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.83 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.83-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

