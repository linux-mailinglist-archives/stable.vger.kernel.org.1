Return-Path: <stable+bounces-184090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4F2BCFCEE
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 23:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBBFA4E150C
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 21:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C95FBF0;
	Sat, 11 Oct 2025 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Skt3jRJv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F57821770C
	for <stable@vger.kernel.org>; Sat, 11 Oct 2025 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760219951; cv=none; b=E5WJrob7JDRSVuikvKTTx+loDRfcoreYv4IoVNiizsgXaRTFJst5QLLKHFNeg+gTGEzczS/OXxENFJ2OWJnPU5oAh2FOV3Yay9merhaavlSlGRaA/eKhLz2WRZ7OXOl11TbD9TC7MZ21NsxKqO6H6QgarPtAE1ud9m+j6YMveMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760219951; c=relaxed/simple;
	bh=2huGcfbPwSh50phjR6U4KnFgcmdQ/b5O6KDcOTP5300=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6kb8Nzo4ps0cB3jHc7gx1uEPmLgpOtJCpEeJwa8Uqd3jTVp1NMaZOYNmtbA+78LFMkkSuO2kV1WoPgWQtj6e5bxCS9+1zPlH0frlZl1Lle5CSp+IW5SaQ2f6K0Uq/LN+a1y/9FgnSYvmOe5ItYw4C4cqMTNG1MHO0yJK6mUT7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Skt3jRJv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e5980471eso15885595e9.2
        for <stable@vger.kernel.org>; Sat, 11 Oct 2025 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760219947; x=1760824747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHThunLmw18bkcxxk1/kwdh40gHKEqGwgzIfI1FE8xY=;
        b=Skt3jRJvuIyUKzW9KxhIfEjoB2i+X5XOGcgx1rCruiyeEQILRADAHfKweUtJK7LZ5Q
         o/RWjr32fCZrRZeUKuFfqgHia3+mDxIvx5QW6A51OCVYg6eNg+XzKHHiLK19S35vAVTi
         usWlKG7+j88hpi0cw/QlKR6XZxc9XSECOD1p6IYU4ol5/KB8uOBvvdJ2MBvUPa/DQ0zq
         Wwx9vcvsEdjvepivbY3dKquTI2qALMgjbHHLBx+QUkYsX4NmKW5Z0GQO1OZM88LDyopD
         DMlVWsVgN6cRWMrxNx8+sR8ZH9GbetnZYJ/tjyDzxt4U9KeezD4NXE1m4xrqz8iGpCaj
         5APw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760219947; x=1760824747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHThunLmw18bkcxxk1/kwdh40gHKEqGwgzIfI1FE8xY=;
        b=Br+6c8lZBo/4A+Hz/YkbrN0qMDiTr4htubBgZ6DqhZo3NO9xLCOqnJAHL645r7yjcG
         TS9RJrdQixywr2IHFdPq17ZeIJhAXJ0cU8Q63CIg+33DupzyLplXPKQf1WPGS74eVkNv
         dzdSqLAjCqZIc/pvx/XRaEpFpBT+KPn1W1fOHkQ1ne10quvhiJcOc4UFUWlmGM3tWmaw
         HeElO3lBIvl6FZxo7NSChI/4INsYY+p+kDSqJHKDXukzAg2ZG91rLqhLO6zE3YqzizZm
         FqzpVHoAZsTRiOpDyZsn/moSu79igq224O/DND5twQwgNoNmqu1E0Kvk0M/VP0+VmZP+
         X6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWwoTKftR8c6QX7edk/ecfXnX1t+K8CFOrnhkTowTnAUKegQ/1TesfJ1JMbQx1QgBmhtLjWXLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAKD3xPZvzTKhUh1eDREgNqA88qhQZPvHgQnKK92pFyf0cKWE+
	JDh2uwGVJg0KtntAo38nIIPCuMqPAFWSKY+SAmfngDv8rpqHnvkZ7ws=
X-Gm-Gg: ASbGncuzzciClkYRKh/driS/PCjkhe+cy+WRs3JQiQyLPCynyhhwwdtCiC+XgAYKXfw
	IP3kCbsXr3vcCUfuVJxeyLmo8pKtXv3aaaEsOiTv6lpwGeSx7Xh8+gWoWdhEWSFVTctoLA3Ij7d
	y5cE3s2+69RivZtaSMS5MAzoWDEVImefLwFTHSiZlu/PlCSw634eQ3vgdF0Y3gSE7HBX5SFsgUj
	IOIhB0ff5E2E1IBg1q8Xhd2YHeNlWG9y+dGBSBAxP4riO4vMDJfAuOrL330uxN1ALmCjVxqV28x
	L8OAO/GmmHUstelgMiVEKVUQ095pGlXvAIJB31sKzIEvCmOuxRjH6Yc/9IMRKLwZxrUSs3XOrXr
	vA0K3iQpnGDGn/dQDSYfY9hEyvclO3LxOYrn+4y/FFLRzDwz6qxojNdo1Ovz8xzdnwfYe1pUPXk
	f9C/jlSy0xMPtE7IbChOQB++z8rsEmMZBkrEZ3zJw=
X-Google-Smtp-Source: AGHT+IFY8BvUEE5h0xt52mM8sCae3x2299mFEpXNCOJQAjgaAdK8tGVw0x5V3Un4+D2uFHAuzg4xjw==
X-Received: by 2002:a05:600c:4688:b0:46e:5df4:6f16 with SMTP id 5b1f17b1804b1-46fa9b1788amr111462435e9.35.1760219947277;
        Sat, 11 Oct 2025 14:59:07 -0700 (PDT)
Received: from [192.168.1.3] (p5b057b9b.dip0.t-ipconnect.de. [91.5.123.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49bd977sm108385825e9.11.2025.10.11.14.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 14:59:07 -0700 (PDT)
Message-ID: <3992ab53-474d-4031-a601-259ba3966bec@googlemail.com>
Date: Sat, 11 Oct 2025 23:59:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.17 00/26] 6.17.2-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251010131331.204964167@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251010131331.204964167@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.10.2025 um 15:15 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.17.2 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

