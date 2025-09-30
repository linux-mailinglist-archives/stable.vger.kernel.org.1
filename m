Return-Path: <stable+bounces-182845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AF7BAE2A5
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 19:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC6D27A41B0
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C97230C0FF;
	Tue, 30 Sep 2025 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+9hjDoH"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6FD26B0AE
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253004; cv=none; b=NPGBRMmNJ1NPiqgFhG9aBdheyToLLwEitHqkH2OAbUN9h9auF4BGsLd4NwXKZCZgU+bEaZETxYcy4SHEA3AmmlQ2nEmn1nyh/BatjSbY6d4U56G+/v5uoRtb9YeBrPSxCvXSTRaJLWX9ymDfwJJgMzGgehZTZTNF8We/AW1FmyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253004; c=relaxed/simple;
	bh=Gmprb3G0hVbY/wqnk/AWfgc0XcA4SLvjCB8vCR8Kz1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATpy8RM6qk2Z1MUEtlyhJ9mis3Es065qwcPp03GDZ/Ll7zYB2Ox3D68YvXHZW1eKqNraH7kgkAb5NBze3j+XEgx1oeOWuY03aufMEx57RogCj23mGR9ki/4edINTSCD597yaVjTofIpP4whfatB5IKn+PtH5pRfAJBsew3ww1tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+9hjDoH; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4dd7233b407so54960571cf.1
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759253000; x=1759857800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNXg0KH+3u6gOVaOqmzWivNbyQ6+EgiPLfdVOQgDUu0=;
        b=J+9hjDoHRYzJQxLIASQpF85NhmT8TKvp0GMN7GlIFhHhG5RGsAXDYebJDXMr1GD6pb
         OPUVoH8SIl+E607J9M533JIRiMYO8EpRdNeCd+kKU0ZmVmsDCKh/+LesbtfjTqf7r36r
         X/FpGULbPwqgQFqo6Z0NYqRSv41yELkQYqav/rPRHr7iiNkkUqoaR9n5NamqSqp7J64l
         pRMypillSb06sU7eL73TuOfOu/LW5+ZH8/08u9zt+VhVbTiJuIEktN9wfpTYBb1i0g7G
         t9qfEDrjtDDHMeOS4yX+fs3B+w61XRTcsVBN51Rt8U0MnwMv3wGttLvImvIxWEbnJ9D4
         qO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759253000; x=1759857800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNXg0KH+3u6gOVaOqmzWivNbyQ6+EgiPLfdVOQgDUu0=;
        b=bLvyrb+qK+4u3hh0LLtRjFxmDKM90z1z0S1a6VmxBkWbPTE+grbdxM4wvA7LFAIL/8
         jevOPWiOcBeg5yb5eRHvud3YNfdFt0VRaGURtmOziBysr7Q6QQZMiTVho7uS0eqH16mX
         pU1mVTClWnQpPDr08j702G6QlO44+qC7UCBCc3pUc6T2hkUbajW9+i7/veNAlK7QUOFM
         aQl2vEQluDEfKm+/rTDvcv7k9xjxA8IfwRu3Fa7yFGsKHdq74wNC11aF+8UKSZkXjGM6
         NmpxfUyPnt3jjHz0OJGXrC+oHWKWzb0pUdNZGmqZm6Tevwyb00KquhQV36UwJh3kxp7A
         cLbw==
X-Forwarded-Encrypted: i=1; AJvYcCWznJoM5gFbg0saT0SnIQUWesNarTDmL5FBJ2Cg0R0ALdS+Az15kBLGXibIjB+lewrlrQxZNEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2x9ZpQEKDnh1fZKuOpizs4b9SvUi+TIA3Qo5os8KO6LgLcfdv
	8IlYySReM2pI2iU2QJZhbwGq0bv5KrPW+HQ+YhweEGM9EyWhKaTEd+Dh
X-Gm-Gg: ASbGncvk4tef/USdTK0rA8nd5E+1kuow5cWRmuhZIEDc2uXqSyBrcOR6M+aY0Ex3YHI
	dR5gbKHZPvleuxAXCPqBnEht30bzOftaJmickjDJDcRETbLh4xSMTHuXUK8qYKytCPoqjiOIDkJ
	y2VrTKKoRdpF2pd+hBINL9FXCrA5m5x085Mdcp9/b+BEKhDVFOV1nrd9J3bnm5zthH5CB50U8Lp
	NB/PSLrf9BMmbQAo3G4gR8fo0Uyn2YW5T5kOnGHw4Vce/p2zZWNMviFoj7XuNzAuVqyO6P7kFuY
	+ke5apar5eJE2C6ouQvGSUZozj8pggUR58rzOTKAKwE4hUeRD7dPzDx1hUlqjXgJ7rk6HDDbSIR
	uqlJGSkr/eAEwXfOkvmo34PG45rE6Ors1p+fZr5SFX4RQrhQKmm471uX1FTCTZrVu6zgHPot3Lw
	wQuxiSOKJU
X-Google-Smtp-Source: AGHT+IE6pmTMC5913viVxHCB4hjx7BlppxYkXAL1vAw+AKddbNTwcrXB5U4RHHgog0XwsfyAUet6eA==
X-Received: by 2002:ac8:5741:0:b0:4b3:4a3a:48b8 with SMTP id d75a77b69052e-4e41e827c5emr4195621cf.73.1759252999952;
        Tue, 30 Sep 2025 10:23:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db11222768sm101479241cf.37.2025.09.30.10.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 10:23:19 -0700 (PDT)
Message-ID: <3b5693e2-c63b-4977-96ba-72374832dfa4@gmail.com>
Date: Tue, 30 Sep 2025 10:23:16 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/122] 5.10.245-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143822.939301999@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250930143822.939301999@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 07:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.245 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.245-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

