Return-Path: <stable+bounces-69368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309039553AE
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 01:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2434B21143
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 23:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DE0145B01;
	Fri, 16 Aug 2024 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfxLenQo"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6943AD7;
	Fri, 16 Aug 2024 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723849929; cv=none; b=hm/4mcMpY/f3xtXMzWbV5/eOgCgBFZO3qqrya1k07OC7s4wvMKQI3D+rV8geIXx727jPacx/2/Rp9VAdLj9qE+LFddrEPGcUgqer5/iSPty37aEXwSan+pNdmANaBWEV0Cflxu1OBi2ZndOxl2S/4Mo/oTrJ6pXCffsxaELY254=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723849929; c=relaxed/simple;
	bh=VqgeCohKwlc47KX4Zj8FiW90wMhohjXLHGiV1j2Y3so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNlX3mXGGV6csA0VGLH2qZHQTyqJ9cMzH/itc/erHTnq1jSlPzz47tVR0IEBfXPlhg5vcvwMmCcdQWc2DREES4D0NvSFixF7DNHudrDaKtXQ5Y58eQHOV5Msp3e/Aq4yFk1yv/8zxj5inTKk1oyA72dVinqWkBxl0neOxpyvunw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfxLenQo; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6bf6e17cc2bso13081176d6.1;
        Fri, 16 Aug 2024 16:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723849926; x=1724454726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuYrt97qnFeOgUr+X0/IIcLUk1twOyd4D2g5S2ojYio=;
        b=HfxLenQol6wIHv/8WcAxcWWAMqPAPAZYb+i2UzcMkxt1p9ywkxAQaTv2NCUdMfrKHh
         FjxLKr5YeiiPT+HCfIxh2xpDVn00YYTxGJ8HzRuE7+m5O3fVhJaqKP8eqVB42FfJtjXd
         4/yjbzdxT10m3CEaLYpNDWzOZjQShaSLJS3HHb6ClOSOKifghczphRZ0zOKpwJ2PlLAD
         EHYQTR/d5CUMzHmS+Vq6no/JDWvPyMivSdUFn5F/zJvVOkESi4ogPrkOKseIacl3lW4H
         vmZgjC8vDSqxg5Oq19lHleQc/iPgmRHPnNd5DAX9btUGQKNQsX4VEoF5yG8J7rWm7hLj
         b8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723849926; x=1724454726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YuYrt97qnFeOgUr+X0/IIcLUk1twOyd4D2g5S2ojYio=;
        b=P9yguDCj73qhmAMEHHodbZ0ubc4QMOlquI/iPZqiKs3h5q9hKHforuZZNMiLNCCjCt
         gaC51yeXdxh+4LRVy65aCZuCtT6pmi2zQaAo1EwSPbsLxH6+pKwrlsk0Fr9j28WgZRAN
         QkbAErEYCZTLmmmL6DH8X51ugNkTBKQ+EvMO8RQgPEEdftP3G7rkC2PWpgle68ZK24Lr
         dP4BE/palWGHyPTusV0X/xu1yDywFbDnVg1E2AZZaCT/by1l/5eOQXRwRpiPdNLf5B9I
         Zi6wuFA5BXpzPjeP6+8H53xuqJUb0ZCfpM51ZK5VCtA3+kybaYvuFrz6puwqKLR4T+ZS
         NFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd2Wd2zgb1doUWBAif4r0xyTeGWBAQ3B98+7Xn+oBG5blRgoX3CPuhSq4KaNxPDz4xxfsweZit/0RucOsHwhebHKAns2fMQ4FbOLAcJXiHC0luQ+LuYcYH352BnfTKzCs8K7Um
X-Gm-Message-State: AOJu0Yy4yZODKl/nsQCFlXuffcnr4Y7WDxxxlx6QRb2kw4GjV/cBa0Ld
	5IlGYv/Bih6QNwXze4w7Au7NBFDLm0OA3zXyuX/D0gV67iKsaON5Jz3dyA==
X-Google-Smtp-Source: AGHT+IEqF3gF79Oy2kJAgzpkiNtP4bcIr2Pg4vqiQ3djkbPGd7nGz/2WQolO/19dng/hRKHoegYp6w==
X-Received: by 2002:a05:6214:460e:b0:6b5:e60c:76dc with SMTP id 6a1803df08f44-6bf7ce2746bmr48783796d6.19.1723849926594;
        Fri, 16 Aug 2024 16:12:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6bf6fef0267sm22579886d6.113.2024.08.16.16.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 16:12:06 -0700 (PDT)
Message-ID: <b619ad4f-431f-450c-a3b8-29f48eefb8ce@gmail.com>
Date: Fri, 16 Aug 2024 16:12:02 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/350] 5.10.224-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240816101509.001640500@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240816101509.001640500@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/24 03:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.224 release.
> There are 350 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 18 Aug 2024 10:14:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.224-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernel, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


