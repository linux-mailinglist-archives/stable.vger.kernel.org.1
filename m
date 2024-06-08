Return-Path: <stable+bounces-50023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88279900F21
	for <lists+stable@lfdr.de>; Sat,  8 Jun 2024 03:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8A31C20C0F
	for <lists+stable@lfdr.de>; Sat,  8 Jun 2024 01:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB8C28E7;
	Sat,  8 Jun 2024 01:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jra7IUHE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6258465;
	Sat,  8 Jun 2024 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717811127; cv=none; b=M/gTaB5P/ANlD/MBtCpa2FAS7rroF9kntVS9mmUcqbCHkVvkCoTinRA1cJ0/xepOkDlAseFNYgJNbYDHKInCwmxp1Io+B62r9pGh4L3lK9xzT5AmL8rWiMhYHuVySitU8/MiURYHETxrfYvTBzivFOBU6spO+y1xdEFMEeVQkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717811127; c=relaxed/simple;
	bh=UN6q3g+9Dz4/hjzQmqjAEEyYcqjaGtBx/GKcyf0LG30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njEXFljG3Jg/fi2k6em3K0ikUNq5snbTAs41UlUJR5IbZXq+LFqE/eaDslg95G3ybcuN6RhFHlLxaBJUswA//loOj5kwCnALsolKxVLT+GBmofPBsnlI0ZPVN6hpEC17sXri6/hnN8WLrgQnGdHCmNY1LqGteyUWuJY3Zy27BQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=jra7IUHE; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so3128790a12.0;
        Fri, 07 Jun 2024 18:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1717811124; x=1718415924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Hx0XsA+WMrNCJ2gQvfTLdJ/oldDhKZcwHjNsGDQ/qE=;
        b=jra7IUHEOgUX3pYT3UFJEaSZImcUaed9un24MhA/eLcXNGr9cOMMWS0YT27inlmTxI
         nDEj44sugbaehXnoL0Ad2J2lOPJI5/X5fJJGMvQpSn2iL/S408XdLmkp1EQCuyQcLBfw
         V345PiV0KSswGSFb4wXaFCGa+Gy9jvV4teOMPqL0K/C3b5yo3MTbN8kAEAg7qe4oTy3C
         HE9EpqbbemVstXsJyhqtYGI2az2J+zsALt/sMHVqc4cqMcibmE5GIexentiqeF21lgdC
         3bP+xsxJHAWj4MPFIMGMPjlO+kqMz9bjHRBoIlHprBdEAG0cDdyyT5k7q6ZNV58+6qt2
         6dMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717811124; x=1718415924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Hx0XsA+WMrNCJ2gQvfTLdJ/oldDhKZcwHjNsGDQ/qE=;
        b=mOx7KrDZjfeoeJGRmzj/3dxV+zwTS/+gMRDzigHe3MVrbdimrU/ufWEAZemPt4XPvu
         UffG0MbYn1Yt+A5nrviQmUpNcPJP15NvL+FUjoFRufBdGx+V5hR2ulFkOJ84G7soGkQv
         tUxIk2OovOHE34xJHPUYURgcAjYJ5iKnpbhvD8BxAkdj8rl17BQ5nCWXoPHxNGCMhEY4
         tkzEuVr4q4MHRqQfc391Jdx7dOwETzeMg4vf370QCqK0sCCtsnm2Cfitqxc7aDiY4ptC
         ADjRucWHm6niPsUuJu9w1mYKJc4pV245Hb0rz54mnwue3rSqrQ7yRxKqznT/2RxQ1Pal
         Ogzg==
X-Forwarded-Encrypted: i=1; AJvYcCVkof9egtFPEooExfBsj8oiG1Tf1yf51fC99b5w+5YmBZBe4Nrpha+gVNY8IDUZCM1bI2uHFF5R8QSiP6XPr7K5ziuGgP/7oM+65NNHuwExAtei1DEzlKxiE4t+ui1CJbCwmIMj
X-Gm-Message-State: AOJu0YxAb+BI5I2KeMarg4Ejb4iNgg7t0lw0o0WSAqDi7a74Zd5scecl
	5KkmnfXaMLWy9NAoznV9g9q6JVqvdzPSLbQhN1W/0Rz9lSX+k3c=
X-Google-Smtp-Source: AGHT+IEn+M+mmJhzhk83b+UnFQZL1b9885lzfYJfv3PYzK1Ds7Gda+BjdcA/yOXBMm2vMdDqX2t/YQ==
X-Received: by 2002:a50:d5c1:0:b0:579:fd26:2ece with SMTP id 4fb4d7f45d1cf-57aa55aee6fmr6610174a12.13.1717811124013;
        Fri, 07 Jun 2024 18:45:24 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4840.dip0.t-ipconnect.de. [91.43.72.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae2366a4sm3544140a12.92.2024.06.07.18.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 18:45:23 -0700 (PDT)
Message-ID: <de7db93e-1042-4417-a8a2-346c836ba1d2@googlemail.com>
Date: Sat, 8 Jun 2024 03:45:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.9 000/374] 6.9.4-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240606131651.683718371@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.06.2024 um 15:59 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.9.4 release.
> There are 374 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Builds, boots and works w/o regressions on my good old 2-socket Ivy Bridge Xeon E5-2697 v2 
server machine and runs 15 QEMU/KVM virtual machines for some hours now, no hiccups.

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

