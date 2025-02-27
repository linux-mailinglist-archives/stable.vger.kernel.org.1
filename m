Return-Path: <stable+bounces-119774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0527FA4701C
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 01:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC771885320
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 00:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCBD2563;
	Thu, 27 Feb 2025 00:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="W+ypF5sZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F7322B
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615604; cv=none; b=pk/45+l/s0kRkWq1FcjR6P993HwPplGukyWbl91pMb4rvxiqcTwHgz6TgqGZ4MmxLtv9kavr4WjHwhtu6vh5ntaqhWvFt/IfKKF0LKg23lURk+TiKGiPa6ObADDkK/EZYzC5fNg5Vl/DEmg3Khb5yGlZuArknfCNcjN/LF60Al8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615604; c=relaxed/simple;
	bh=/Uv2ZSNL0GBBewIm+5nlyMexuc3dwuC1Fvb/0p08ebU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UajhjceaErIq7FSvwsikHk+pwCS8+3V+MqQGXNlKEw8dIndKGkV1Wq5ZJw2FQxJfTBR9my0Ca4tNknEUSgTFg6nB1iCb5pSMOl3OIF20Es4sbL8ho/T4K5luz1Z3qfFyFiWCY8HRYUWk94oAvv0p5SAP2iKcsH7jcq/u665tYls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=W+ypF5sZ; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-852050432a8so14169139f.1
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 16:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1740615602; x=1741220402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8wC1L3gj87WwcLGHPjzIsYmr9ioVfbKFSRwg/VgMwU=;
        b=W+ypF5sZf82AHqtQx/Y7sPKyoY/MT4p/O5q3pStTdPmNteAEnIYu8IafezOOELzaEt
         6bGunrP5Y3MWe14bWInVQljnS6k7jE8wYz36ZOqjZyPqxa4QrFqDm6/NInPov5zENejP
         hmuvpmWxs2D1etdVwQ5H31clADY3JQ6YbSP1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740615602; x=1741220402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8wC1L3gj87WwcLGHPjzIsYmr9ioVfbKFSRwg/VgMwU=;
        b=I/B+SjoBuXek5Scrg4jSQOM3l8iw1StBMAFkBiyGVwiXT0LvH/rsg1uByIjWTHmkpt
         AZfgMZ9MFk1SDCtIlpSLPP9JPVNaWmnB2XBUkpOMO7tdPfVqJhIP/kdk0r7O48Oihw5i
         FvUS7C99ICmepFD15W1tyN5UFiveEVPV1QfJXxhuPD76s3h5CGph+VzNj3YRANrB1Jfl
         fDKxQ6j9dzNky6H8TX4i68QxGJYLTd3PnenxcEeokq52uIEXh9GBWhRkM9eim0vwJ+KJ
         pfE9jQHWoqr3ltNXct80EP2j5Xit0E5/JXjPbcMsqnHl0d6ly6ihzx8JrLvoD6ogQook
         2uPQ==
X-Gm-Message-State: AOJu0YxWEy69X7uWj8EoONnn6Fc/clngePDBx+ddS3eKsVso7I88vS11
	OPk+U9/KzgLr+NlGAk1+MAL/itSBzN4zEvBXnwEwys3lwEXwcnN6w1boZHiOPg==
X-Gm-Gg: ASbGncumPMygkBDFDG7OqHCxRUca+O6srjZ3+gYOPEG7jfkkTkSRqXQGjQmiu7nL+6n
	GjdJI2TnFrOUdTyE5x3/lr4BUNCnWwS8QHbVWSqScswUKiaQtoDXmXPUKEyK3ChA1FOJJ45eehV
	TnM1zF9qK7eNHUpeNSbbR4aFoeP1vt838WHDzFh8RBsUhh0hFpqbvRAp6x+7y4uise7LICFfYw2
	P2kTpS2bqd1H+IyoJpO/BrBiaZ0FSNydGw2JlI5UtbY3zNef7WcN0T6MSytobGCA4TgSe0gM1Pa
	X7ZuQICko/wzxMbXV35czaDAJ3pxnsZ4jpvlUxZoeR4=
X-Google-Smtp-Source: AGHT+IFeShw3DzaW8FTTd4sEqD29fXvWlqwVnm5ezdkhi0VJ/bgUsO778wJVEgo8LhzCUlbtIxXpxw==
X-Received: by 2002:a6b:7e4d:0:b0:841:99cb:776f with SMTP id ca18e2360f4ac-85870eee265mr151794739f.6.1740615601682;
        Wed, 26 Feb 2025 16:20:01 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061c0bafcsm98732173.24.2025.02.26.16.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 16:20:01 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 26 Feb 2025 17:19:59 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 000/137] 6.13.5-rc2 review
Message-ID: <Z7-vr9gSWIsBuSZ6@fedora64.linuxtx.org>
References: <20250225064750.953124108@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225064750.953124108@linuxfoundation.org>

On Tue, Feb 25, 2025 at 07:49:18AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.5 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Feb 2025 06:47:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

