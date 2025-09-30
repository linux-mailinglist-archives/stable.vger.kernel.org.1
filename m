Return-Path: <stable+bounces-182874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB41BAE6B6
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 21:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7A816AC44
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 19:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4B826C3BD;
	Tue, 30 Sep 2025 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtuFPL3h"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79DF227EAA
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759259821; cv=none; b=CFhjFCv+YcBdtv2pJELLg+VE+NtLJrhEVch2T39ThBe1H4HWdMZIeiQcnsTqA6686uEKYYDlggUmbC+2sX8Hdo/dqAeVSViqgiPi1jXP9RoHGi3Uxw+4L1UMxhUqo4VREOdPSS8YCU7kW1dS29xwCnBMgkw/Pj8l6fFNL9XSkmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759259821; c=relaxed/simple;
	bh=TL10qIi5vjrSPsRXf1P1zHEKDMygNwBXTK7y+x5rlqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1uXc7/Gkqip3fAsM4Yfc7qHbptBDhuT0QxMfU5i1QQTVhkd8m6UiRunTXgLt3k1ZwbriF/gIun3kPdEZpOk4FZGqtA4A6Hkywl/iINI5muZ4VileRharwNyqSovMa+rLJIy4P+Xaorh0hsoEP87UkCZ8hy1jAfZVNK87CluF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtuFPL3h; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4e0302e2b69so28984091cf.0
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759259819; x=1759864619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fldU7lyCsffYvOHrWcygkgb504/OYTsYgLUlK9y6iPs=;
        b=GtuFPL3hsIl+Oem/1Wd0W2y0zawFK3RPoRD2Zy6jcb+tSPji/W49x5onCjPvozFjHf
         jsX/8/ZKSdi8iUKzqMWvpMToYC4c8D3edsJ4Fj5fE6NhUnA+l7IIt+bA4K0sEa119ZMa
         qgngYnDYPEa0G57frNKWQ0P0VaT4XDyPDsfRj7ql9gLNmq9l4umB6aReFRzCb62s8rAb
         lxBy8OOWVr/zZQ3/8MGpyJQcbws5tJc3i4LMV0NoiEmPNwO1cqq3DyGDtpyKV4X145a4
         pLk0noa+lX8rxBWm3tAD3AXYxxEfN2HB2b1tWNofjnDc/PyMd4T0tTn6vfdvMZ0Xz0t0
         l3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759259819; x=1759864619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fldU7lyCsffYvOHrWcygkgb504/OYTsYgLUlK9y6iPs=;
        b=krcON5dGR4xDcgdqyKYmHRSsSBUkrrNX+I4D8x6QXKDrZnm5YllK/9Tgxtkg9gwvRA
         4Rgk/DcApyq4nH7rqlEEWKeCH7OiWs5oHJ6OZ15fV7QJiFmSIPyCz9Qe0QcBlXHlSzIn
         3K98D7uB7O9UbV0gHCeBh15zWJf7JaK/h64w5ecT5vNQawKIFVUlAAnYS29HTjB9M1LV
         zxow+9k7AX88/+YSC2hILPeahs3WDar0JCItokYYxPdjLt4O2CXMbCyhqYfgVfM3OfWp
         +To5S903vTh6ll8Cg7QGAFl4zmBylrX/uGYjPbaR62csXU6W6vLZYZqb/cVHB5+hPcAf
         YgOg==
X-Forwarded-Encrypted: i=1; AJvYcCVQNuToj0Nq0+11sQFhuRqrkSfFyNK40YS+ZR9FerFWa4Ac6DiDBLUiE1OGgEq/pl3K29GKQow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwstVn8ps78mTON2ygi7smCqF4az65eMIOhEbMCUPImhYriViEt
	Ho4awXUAL7qcBIrEPi34GLtAw/kgqsgxmB4SnpYNeao2x8iYImCLeT9b
X-Gm-Gg: ASbGncs4hDU4DxEGn1mxmHCHPTZPsPeT+1/pWUOAw1Vtp/nMR6BlyXIlwEcmea0N1YG
	xD2lmVzq3JAyBwrH14D3uZVK7E0lzFqBBDLi8DnekeUo6DhV9a9i/Tw4g52gtQgJ8PVLHOYDFus
	HO/gPGpzGLcBWG93tW6iVmN0W+9/0XhohH4pWl75/JbyCK/LUZwl1AuapV03nAZxOd8PpR1X3dn
	4c4rNxpczwiTk6/wLVq3vuuSw1pJQpG6YC49j0RI5kX8mxZrLvNdGrP2vqtqFjyAXvBDgMI5qkQ
	Ne6VtMhC7b2q/EsTXBlnyhH179cUX/b9+PcWGggrJv98TOD62TuaE87k4/smuPlixJ52W9URD4h
	UAS5E6xQ3HnxCJpFbakvfrQ+/08La6We5RqCv4UnYLkJfm8vSK0Kk2YHc6ec6qksuv0NqiXqtDQ
	==
X-Google-Smtp-Source: AGHT+IGAixLoYK/ccLf469fUOlnxBKQc/0dR8BmBYybPUAdOplQD177YW5poZcfV4hgeb9P1tBM7ow==
X-Received: by 2002:a05:622a:18a4:b0:4b5:da5f:d9b7 with SMTP id d75a77b69052e-4e41eb11651mr10050631cf.78.1759259818502;
        Tue, 30 Sep 2025 12:16:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0b9458e1sm99203111cf.15.2025.09.30.12.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 12:16:57 -0700 (PDT)
Message-ID: <f7f7f248-20d0-4624-a412-598c278b03d0@gmail.com>
Date: Tue, 30 Sep 2025 12:16:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/143] 6.16.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143831.236060637@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 07:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.10 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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

