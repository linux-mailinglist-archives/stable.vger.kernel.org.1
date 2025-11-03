Return-Path: <stable+bounces-192242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB05BC2D40F
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 17:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27F5D4E7A67
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 16:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AF726ED48;
	Mon,  3 Nov 2025 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ahf2wRrU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F50E31A564
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188651; cv=none; b=tdRAd30TeRsI6IrF1ensATmhxZwkIEp4nTAoq5Hl+qgLNCI9V8JLF+W3A1AHacBTbxbSDh7wQCaqm81Rprk27rx/aWRPpsirCCChC5527SxS5vx3cAb/cRB564kg9eL1JoxeROmwguotKnAG7rcys/RkG69geNg6bf7514YfmkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188651; c=relaxed/simple;
	bh=r+grU7PC+G6N92zehaPAAv5rPvbu0LMva4wOUJ4SsF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIIF946GuKZBXAmgXC+ymYl2tOnsUEw6mX05iuirARbfHn01azwGgFWUOc7n42L0AsQWnl02dd9BXSiju+w4MDArrVkbQVUgUTFVVVaIKN3OpB9rPWoNZqgp1lkIN+sZFqVaCYIZuixpNtIuQRVyFo7htbfxNWhciadpvajPUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ahf2wRrU; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed0d2a949dso32644461cf.1
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 08:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762188648; x=1762793448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dtnw78k2roy5z/99UbrJhP9TDpGnLB7iULXtjAYqrvo=;
        b=Ahf2wRrU0O9HDb+5EMSrNy0YqsswKVqP6erDFCz3XGA7ugtSxy9yK07Xbt3YNW98zo
         wfqLxY78QezcIvWMG79rzUBxFUa2fIsJ+to7FPuZahXv5PDsBPooK3sxblXX4REvz1hr
         +tFScsszP900QPGdQq+l83TW5z0LGMyXkV4gg+YnONCLXJmNIo/4jxXbBE7OrrwczOvX
         eSvxSQyALC4EfYuT0QJRbsnme1I+iAgpCtd2Nw7WajVwQu9l8MuqzGzCaipcV6IMQuWT
         bUQ4aUAIczAslULVYpmDrpBU8wNH3vsHeTiIavkVxfpj53NIzSrDSO5pm7u7/K4FkONx
         SGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188648; x=1762793448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtnw78k2roy5z/99UbrJhP9TDpGnLB7iULXtjAYqrvo=;
        b=YZhtTJzY7NuA3xsaDAFOark+S21vruc8qRXxWi0iYxxCcMbeX70i04zsWh+WPF0nJ9
         moVwjkxmkDsnT7C6x8/R0Wm7wpKZN+DxLMsc6AgBkP5IVQT8FI8ilU3WBWaV+qotwbSu
         CO4fE8D2Z2g6hDmW+Dn0vX2o4JVPkkSDjNkMYvEm0Oz4srxDpAzID4M/BUPqpx+obGwM
         7/usPnBVysIngtXi51SSvM3OI0Fm6JMmPF4kCDpZgdY/yKFtunuoEhzmbJdqKkQ22QNy
         rKjOGElscQUEs83y+EzHujxh1E4Ji3VexajneoK4DrLj61oEiOza+N67TcH5TnOIIS9F
         gyoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQWbUvNBiAE/IZxdilQpF9DVwH38nczYYcdiHvmcs1PgwEekgLepFlML7Zr2jphfq2QB0W4Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4CLkyuAhw4pBW8m9tR+Eqzvld9vboZrJNKsbF6iLd+VaevRHC
	JCs2WVRUQntz8POfEdqX2WQZg/d/fp22JAMdcdg+wJdybEr9yOai/Tdb
X-Gm-Gg: ASbGncs+osBZa6AXoRjzfx8jBqSEluOKPOTkNIX5RiZnGosKuxAekMdKRL/Gig2M0qf
	rWRgtE9yiLB03+1whmG7U2OqZ+Ff6V45wM7NbsVmAU85wxlEGn9m7z0kEYcGAzO1Lv1I9Kw0gpr
	5KE0jF/5fPrLMrcxDar2BTUoBSsNdehET2gKz8806hXmzzsR6F3jwGGaSUplAXp11aeRj70fgMB
	mXLsUz3EQcBvD9XHQszoyV3j6lyR3q2HIJAM71vQ+WJPmcYQ+MAy8mQYsUgw/4xhStQ7yXImdrp
	/xEH1MrroLxeFQDCAro8UnseMsvunl46mannH/3+LdWgZrYTediNtLM+o2jDXczrWywcSGl547n
	of3Mlv88sXhKrIJcVUKwvFfQUvEZD/Mw9zmpuHMgBLdzpLizeulIuubKxJA21nSjdO1XNdeOS2i
	ucr7lRAA7n3Du+9RF7IpYnTygXYRE=
X-Google-Smtp-Source: AGHT+IGaidtdD1Dp1nbq6fggrdpMGwWINS1Q04b+SNwTiL6KnHfGQj14i1rEtQip7/fmniLspjP4Ig==
X-Received: by 2002:ac8:5fd0:0:b0:4ed:2fde:d0b3 with SMTP id d75a77b69052e-4ed30d91bbbmr155504711cf.6.1762188648327;
        Mon, 03 Nov 2025 08:50:48 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5fbdf2b1sm1644631cf.17.2025.11.03.08.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:50:45 -0800 (PST)
Message-ID: <65b0f959-7f5b-49ec-8e9a-3be884af0cbd@gmail.com>
Date: Mon, 3 Nov 2025 08:50:40 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 00/35] 6.17.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251031140043.564670400@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251031140043.564670400@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 07:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.7 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

