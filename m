Return-Path: <stable+bounces-45309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0374F8C7A51
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 18:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0A0281810
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A86714D71A;
	Thu, 16 May 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gejhb1GP"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC63A14D719;
	Thu, 16 May 2024 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876823; cv=none; b=U/I19IeAzVm9PoBzLtAbAgEn1HRSrMCIP0cth6aK8d2YCE9IX0DBKAF3RSMEHK6AL5Rdy2Fu6Ti8AkxLYKIP445cPmReItu5sd3Y3tDYIuCSFYD2GayYG6b6F0PpA0U+KqcKxMqjv4arW8RG0WGbUy3khatpg9vkV2cGE4DMmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876823; c=relaxed/simple;
	bh=TWuCOrwRfsE/7sgVxnRfNWS8mwZphX3KUBtRSNprbzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPYf6kyBZn6CXb1f/LsnKA6oYcQUzyzRyYjaKXtP7vd2y5cqmIF2MHfN9Up2PtZYNXNL27tp8mtZYTmkxlqtF6kokHBAg9xPgAavslPQ9fSCl/OnRD5lgMq9tJdnJiycm0TNSXQEt3Zpe5ks3khmxdaUr9HIRDg5Vmn7gsfiR9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gejhb1GP; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b279e04391so267256eaf.3;
        Thu, 16 May 2024 09:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715876821; x=1716481621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PkpXYOeMxPez0BVFDxZmvaRNFBBosJL15zaQ2tgikE=;
        b=gejhb1GPcNDDPREUPoN2M4VTQzAkaCcrwUwBTrMzTlDAVyj4RJ2iOSdgLkjFClvGNz
         9U4hlfB8GCg6AsL0MtK0ILY85Ta9PU1U115XAH77oIYefXh8QndWF4fiv277Z+xsLSxJ
         1E8Q0IMAXBTDICRy9l+ZI/dC4x8U2arRB6+V9j8IPc0i7m3n0zDYr6Sztnf/aC4j1YN+
         zHosXTeg/euyHFofJu93tcYbZX/U9tUv5UJaM9FV/yD+GPtZzvRLC4hfmyFYW9TlIdQc
         ud1Fp3Nc/OrqxeEheJPwqVt8BuYAjwnyLDfcIaIHpAVRoQfAP9tIyuETi+Iy5zbPhhHi
         1Jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715876821; x=1716481621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PkpXYOeMxPez0BVFDxZmvaRNFBBosJL15zaQ2tgikE=;
        b=rbA3FyfNXea5dM4IjPWPVWq/r9YIeUaAuV3xTCWDZNbHjwMOx5UtMYbqO33tr0qvzR
         ET3xX7bLSOi4Zf0nMe45B358/fEPejkO1S4H0mXa0+V3gQjlK/xt96Mt+fo+0Ho8yZQM
         NZT51BrH2SrTSTwu3F/gnmEAEmDwFXFg93hDQOIEna12ZKcwp4qQFqV4Pii/bi0mZn3y
         FKQWL9GKURA1a2mRcz6O0yGrIaI6RVBQeMCd28tAwO72W0OPW8vMAnjAxKd0Rp/VdPEF
         W6aOdZEKiHKluQmgje22dVAoZCGyE6GCmDW1LeAso4CDbTBbzQ6Ul3kprnECJUtFaKfW
         i9VQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6g2M4YqSNJ3ah4E2g+J9NOJC9cRZToIaF/gIhYI4QpAc+W77IeqEtS7HCWYhKrnTUIkuGOjHTXL5xr5O/Cl57tdIRR5uycI2IkYccSgHI1ZI/dF2Hm0GNwNIJEpkG0+QrPDGU
X-Gm-Message-State: AOJu0YwXhPB8QYLnuZJW6daQ+dNvq/yHn8A1uiBkLRiBEePeCzTGCAQw
	LYMBywewuCvClK8v6SMfsdJWFZppV9nLZVm3OlP/mjyHZKaKVl0ZmK2aZEOv
X-Google-Smtp-Source: AGHT+IHvj2AgQ12I86jA52pef5ba8vJfLez/dY+rnEyOErhv3j6oahEuM7HfVkV8VBZQ/uVrNuQLGg==
X-Received: by 2002:a05:6870:a985:b0:22e:7390:da7 with SMTP id 586e51a60fabf-2417287ba81mr22782982fac.21.1715876820835;
        Thu, 16 May 2024 09:27:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-792bf31171esm812657285a.116.2024.05.16.09.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 09:27:00 -0700 (PDT)
Message-ID: <7e8306a7-c32e-40a1-9f99-78cfd5a49835@gmail.com>
Date: Thu, 16 May 2024 09:26:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/308] 6.6.31-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240516121335.906510573@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240516121335.906510573@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/24 05:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.31 release.
> There are 308 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 18 May 2024 12:12:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.31-rc3.gz
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


