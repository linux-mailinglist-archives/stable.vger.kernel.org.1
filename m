Return-Path: <stable+bounces-111825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7446A23F46
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 15:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD317A435D
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 14:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B891DF96A;
	Fri, 31 Jan 2025 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="FGf/FBAO"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5131C1F13
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738334880; cv=none; b=IBB1BhePxZiplPrHVPxph0cw0Zd2xUNCtdRP2JlEa74ArSoDiglcjgTeFySRB1S/SJkeGRgsuVBv7Gse9R0tUPz2PTMS0uZk/tSeHQukcPtKhzQZfUVs09sU0Z2un+lW9p4mB3g8dGY6itAK5wOiYHy/2tDk8KzoSoORNCricgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738334880; c=relaxed/simple;
	bh=139fh3fcoJ+jnV8azA9f7I0ohKYboEntB3GaFVohabA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2LKP7CDATgKvGure0zLtZgbxrY/HE/9to0BGWZ7/ogk2CTJxW9lEnUY34OLpbT3yj6a6S/BaLKCVjiTg//XJRFpTz0i5GJPY4IBitr12T4Dbhk2megvq2QRqm1jNs1tWufftJOVmbYu/8HCsnGWx7ySrWyOc5RQ4N0/a5bvGhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=FGf/FBAO; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844ce213af6so54896139f.1
        for <stable@vger.kernel.org>; Fri, 31 Jan 2025 06:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1738334877; x=1738939677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVsJW1ToeozcfsJdJXyb0ho5kmAeY8ktfdPcDsZN22g=;
        b=FGf/FBAOjNeju58M3IliN9PepKTOPegFn6/tHHL9JWyTqk+6ltbF+EPoCtNEiydThC
         tJ5WRRwz0zu96Q1ipKoKKLQ+IKxUBp+oB/y5Du9EmHi+2Nwrg6uMwL5NHybfrxDFXtPA
         hGy8AB9pzvzZZlMrZFXJuLLrmNew3wIzo8UKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738334877; x=1738939677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVsJW1ToeozcfsJdJXyb0ho5kmAeY8ktfdPcDsZN22g=;
        b=sIMfLeSwa4G1WGM0wXbSIOWkwo/gcZl3mfgOTKyd2HWHP+xzKIRhx+pw9AG4VBkolq
         WYSTLwaChYq3zxmTzvbqTNki2GzTU+BHF/Dtt9hB0VmCE1SWu+FaaulIE2yQblpJueq6
         XHuQ5mGAL1koG/8Y3KR6F5UXiCrrV7/KMUpt9m3y2+17+ZIPPEILkSJPffhhscXC/WXZ
         S5+YOpQvgr/KCZPH/LIfyKoThdIWwPskkGf1eFrk2wc0jcTfkYvRIg/TlcNegv4GDUys
         9ApgCEyQ/iNELyGlFtW8xKTPErqPH9wg3a4gRmKktPCXbtV4uCowudGusWzLmROn6K+Q
         +/KA==
X-Gm-Message-State: AOJu0YywJQnvRh6hfmkqP2U5mD7o9PUaLSOGytgMjaAB1rpohP/jzhlw
	kHFE9rwCAMIYDz6xr5wMaKkvkH0D3prTek7bYx4hrGcQj9EUKrf7lfggIT2PIg==
X-Gm-Gg: ASbGncvDKaRppm0D2FznlhbMVQDwrWYD/yYyR4ZzhVRmOrAs4JHsFFHvsFgYHsqZze3
	SZGTC9bV02em5I+TCqsFwQHUvYnyHs66CqG1MtUShIzskzr9ZMnUI0399lpsesNnicj9tc00o8J
	/Jdqh8xJNEeZu44xnWF8zfoJD4lr3MyJagu5KAjO4QbMex/l4CLVKgMnAcxRpGeTltDNpYNJ64x
	pAttmGTR98Hg2WgV+No1HMsjHhpPMUvI5u8LqCK5HJQJuyuHAPhsJv+SKLM8dvE6L9vVVrMce91
	PBt+ZXUUjdkHDezxIcyvOU1lXcWWguQO
X-Google-Smtp-Source: AGHT+IGZaDTT9EUvo1v8tlEIqj3aBpmJegYAnz4Ao4RasNP2H8e6kOMiE68F/LLfpFppWu0l0DzaOQ==
X-Received: by 2002:a05:6e02:1707:b0:3ce:6aa7:fe96 with SMTP id e9e14a558f8ab-3cffe4bf3c1mr114496615ab.22.1738334876856;
        Fri, 31 Jan 2025 06:47:56 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d00a5968f5sm8540025ab.49.2025.01.31.06.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 06:47:56 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 31 Jan 2025 07:47:54 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 00/25] 6.13.1-rc1 review
Message-ID: <Z5zimkDt3Y9ntRMZ@fedora64.linuxtx.org>
References: <20250130133456.914329400@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130133456.914329400@linuxfoundation.org>

On Thu, Jan 30, 2025 at 02:58:46PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.1 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2025 13:34:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

