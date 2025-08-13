Return-Path: <stable+bounces-169456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A261B25471
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 22:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243C8568901
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 20:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAC02D541B;
	Wed, 13 Aug 2025 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Ai90iJ9f"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17549271A71
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755116116; cv=none; b=IJbuGqPWTPPeY9eQ9HF6rkBUO4dICQGMLosVu/WVYxS2pMxKjrym9FvzYZPJIBpap4XB9AA0zniI/SUsWVbVERD2YZxFHE349wI23Kze10PF2WOCqwuR3vrqIUcgtwe4ULs8xEDLwKu6scNShypIcTIxbBmPmlkxzRN/FO22SYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755116116; c=relaxed/simple;
	bh=/DpqAeslv8bRmsN2sfqbbHvqAKqaJvH3JKfHsdO27s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av5b+n9799jqPX8sR2UM8Pn77n5dHo/u1RTvktYC/5iJdvyii8aIcqiLe4zfiJV0Sd6JZnPDPTVfGXXlp0ya5S8G/N6EoUIxSqYdtBWoKx008vgxzbZBsA69bVcfPU4W+XKnYSqn6pTnvbrdFGdeT3hREvv+XJxDbh8BqU4qbFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Ai90iJ9f; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e566327065so6065645ab.0
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1755116113; x=1755720913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcgwJo67fSdIwhf/Y1kaVkQkpR61CWnlebZ6dKIeM1Y=;
        b=Ai90iJ9fJ1yHbEda6tGc0tAtrZrca/fRRhz5yGL3SypnGDFVkmY6wsehiNEioyeK++
         AKSdnreJai/Xs7SOwIIwgKfbe8QAXJ09fyWKg7gautqyvdQl9SAuZAFn+L8NAHor6LT4
         lT1WO+/MV59UgaVZUdYIFWSOgXT8BLb2mTTzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755116113; x=1755720913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcgwJo67fSdIwhf/Y1kaVkQkpR61CWnlebZ6dKIeM1Y=;
        b=iym7RZSus/sk/Ju00nUEOYUo6ptzuvhaC3g6KZkUz2D/W4jmhdDBoa6itTRmhVogAX
         fiLuFtc4YUBoPn3t0HGTSdgqEnFpxiTxwEqT4jsNVhEnj5cu2RL9BUFXUsLi+Bt00zaL
         hBag0ZRrTppTbY3Qtl2ogGjhCXjWe7qTSgRxmMOM79twiPngqrs+pISgnN2O73Bem+Tu
         Q23bc+bwoxFK9YJi9C1a424jpe6FCnflsYOotSvQ+91WTDwzm0Vcs0SSG4BA/RQ6mFKT
         N9/hGIecVzvI68XX20LTVH9D6lNgfdydEa5+YRkKi1hLSe/6vLQu1OeNhEPh37GJzL77
         CBQg==
X-Gm-Message-State: AOJu0Yw8zHRpj9Co0xD0NEd8rqRMecci1MSCrtdplomPtrOa8vdwqwhA
	MV/KwIvVRzUj7oMJB4QemYEY1FLW/vD9lozk9GSxUgLPU2bihn+D1Y4kABFrLkn4SA==
X-Gm-Gg: ASbGncsT/EFYDn4fmLaPJKCT9S0yXLqhCOSZWTfWg7aGd5q7hMJiVtwMTLV5vEWSVIk
	nUyzJ8XBwyzBbbFcjyBlCnxE+fV/vIwsfV0gK4rtErCH6YuTJrNPemfQJg9/RHX+2tnzTY3Ezqj
	e5/op+6/bZpEe3EIKjItu3SXuNPm7cKiM1a/t08NqgFZvlkIGk6l6ruAuepS/W3Qqag62unCndX
	GjijHK6584jX/wpTOqkZWmcCx6yK1n4B4HA7YEYGR7sEaLVKCeerNPGNJe5DHWMJZ3SsmMELcXM
	9MZ2qPr88hi5XgYwPERN0Y7jK+yNwEPiADtyZYUWU+XrVXJ0I2dWyqgh6Nibhn6SBt0rtKUrsqu
	zYpm4JTBirMBi9Qz12IkpwBArUE6rlb68kxqRG8I=
X-Google-Smtp-Source: AGHT+IFIT83RK1BgW71T/A/tIXZmBd0yTKosCWQhpckCX2xdMMMQJzk4nn/G4EkvLEe5LUihAUVh8w==
X-Received: by 2002:a05:6602:7184:b0:881:8957:d55e with SMTP id ca18e2360f4ac-8843446d220mr16540339f.3.1755116112915;
        Wed, 13 Aug 2025 13:15:12 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae99cd268sm3906199173.22.2025.08.13.13.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 13:15:12 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 13 Aug 2025 14:15:10 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org
Subject: Re: [PATCH 6.15 000/480] 6.15.10-rc1 review
Message-ID: <aJzyTmxsakkQ0SCB@fedora64.linuxtx.org>
References: <20250812174357.281828096@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>

On Tue, Aug 12, 2025 at 07:43:28PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.10 release.
> There are 480 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

