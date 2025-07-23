Return-Path: <stable+bounces-164482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89769B0F817
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 18:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785331CC2F27
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 16:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25731F3FDC;
	Wed, 23 Jul 2025 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="JNotYbGf"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3174118BC3B
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288055; cv=none; b=pMaLtSjcrhK5Xc+G0j+/EVcm43EdF+ZSO2tdy+ImlbJETe4uxtFMwdNSx2xu7JWsfk/+SVz+jgx/hO2SEBwIeWS6Ri7vziVzlz82nNk3WNPNbeTwfhpiOVUZGxYB0biMaakMUCRtY47o41Wu1xXeRqoPVTOmlGuvL7I0zsw5ZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288055; c=relaxed/simple;
	bh=QHsEWJ65EKEeUAnjRO62w45lv6VLZRWBmcs6bu8I5Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9gIyuq2OUZSeDbvRi6SITSrHxEo93v1slp1PDENir3dfNuIJZPMecMaFgGRahN+UesW0oFUwY6P/nW1OGXYbevRUd7Lw4Pb1uWT8j5r84kAnnFJX5NvC/15CXABBUpfysWLXj1pXIK13XTjSHRYr74jw90odlgZUg41uhSGxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=JNotYbGf; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2ff94cc4068so49432fac.3
        for <stable@vger.kernel.org>; Wed, 23 Jul 2025 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1753288052; x=1753892852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6A0ra1sbjas+5Ydcn1mY51RGT/qA9lEFtptxsAU7TM=;
        b=JNotYbGfGtl/cbSjAfGgXMXVv4bj2rrkBdmRXliMjOiVS6sK/MSt7KOXKcjNfpwgiL
         uvF+2SUYcUGzo0elp106/u/sBOwJMl9Es12qnEZtMCFxgj8GsSuEfzxSf/Ml4KcFe3QN
         MXTxU49cfEKWJPRsyDWPibNRxECoEMeegWsZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288052; x=1753892852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6A0ra1sbjas+5Ydcn1mY51RGT/qA9lEFtptxsAU7TM=;
        b=oYgyJlIt0qV9QdE5OiCDrTS9/bO9e0HDcV/VNQ8G7uzcCtDG4gmc9RYlKIBkSCQAES
         pqtoFlGnbL+9hN6LWH/xAEtbrI3ZL3jlbR5ZtdUBrqVdgRpAOZnqOjgccq5eokWTVAry
         oMNU+5iFyQ3G0PgEouzyDOQsCLj6RHwaraeJyROgWM2GRxOqSOpufvo5M20UO6l8pg3W
         +uzZCiIglpElOAOREhUQKfnnXQQLDpQNVecHa9kz5U52nWdyuFxwkfcZuIow1RLawaPE
         iE+PrLyQlwZvG5uIxP+Y6RYTGagYKSDUWtG0wV0gNp1h0p4+dtzXSjUnvvID1b8Sj0Nk
         oIfg==
X-Gm-Message-State: AOJu0YxMV/5WoYb4AyF6MAmUYCfmwkPCYMFKoeZyg3Pb9pKqdnHL3JCN
	bQ4LPuxaNVZPWBvjyo1pXBgVx+P7gWeKl5Xvz7XCmrOkXjm65SFIzaTfZxJ7Rqzhw+ZTKQwgoU2
	dXmKGZg==
X-Gm-Gg: ASbGnctgCzLQotyA6JrEBqOsgInu60JVdCuUCJOhd8SWzYauq4lkf0PTDnV4Mce3mUg
	wvIG+djGoV0wHMBpwNo6BpxCnjUryUyR+xRsYMAf9poIExJIGCXasGu0xCCIhh+lamDsqNteL9h
	uSBerg1MXqzUUG14Y6bh8gsRwzYj9G79iqCsnzEmyj0dn/8HAzieXTlQH7tfajITHsHwDg7pAIS
	Sn5emcOCGSU2HsoKeAqsHBPonVy6dIYZTsAfbtAvRa4AAFKHTcfIHYash8gAMzj0rSz1EbSrQ95
	kNzcw3sEuMWTg+FFSCokuBCaMGlP7PNnN+5OxOf4kybKEDFOwWLPjfmfmiL2fPmDY6tettpQupI
	03wpQX1qrfogLaQoqUIJibqrMf8n0zMGnVdlCqFk=
X-Google-Smtp-Source: AGHT+IEO8bpmfpwvvlzRcmZt1Ivg71kovZ+W+IOSknlxinA5MmpXthLTgUWvuZ4sxkkWAFZMhb/IIQ==
X-Received: by 2002:a05:6871:10e:b0:2ff:9663:ca48 with SMTP id 586e51a60fabf-306c7350031mr2041806fac.39.1753288052151;
        Wed, 23 Jul 2025 09:27:32 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30103d1b601sm5150726fac.24.2025.07.23.09.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 09:27:31 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 23 Jul 2025 10:27:29 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 000/187] 6.15.8-rc1 review
Message-ID: <aIENcUTPkxpM8nlO@fedora64.linuxtx.org>
References: <20250722134345.761035548@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>

On Tue, Jul 22, 2025 at 03:42:50PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.8 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.8-rc1.gz
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

