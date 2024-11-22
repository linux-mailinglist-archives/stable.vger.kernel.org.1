Return-Path: <stable+bounces-94559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB4D9D5685
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 01:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3731F210B0
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 00:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49342A50;
	Fri, 22 Nov 2024 00:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="gCGk41Z0"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C2317C
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732233908; cv=none; b=ini2PtcAQ1QqB+mXrMj/cgMO/S0wLPF8vdEPOF1ugTDyk4Y7aUoYB1dV2d2yQi7RsaH4IL+lTzdQs2RsWB/DYd/hq4cgb1LUnJIByXru9DIXhFK82llV+t8fY4BJvQ7C0yApaI4StHAvmCVsbJmhvMCyXDanPLsmr8r4qU0RSCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732233908; c=relaxed/simple;
	bh=b8zZutAt+QIFWYnPwEoeJWUZ90wviQXtYZBmgBcpsM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q355Tzcv6d1t/dOPmLX/1utrYDGmvGJe2qky9+d6maqLnVWZf3csdPJ+CLNAzCoH9fLFs6TFuMYlTHWzPfHSeVw0ZT/PQ1HPe70y4PXzGsog01sGBdUFP6E9im6bQk78BT4CIuRxg4kto591vMsP5X2uhvBQgMonV3PQQXTdu+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=gCGk41Z0; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a7991caf7bso1941095ab.0
        for <stable@vger.kernel.org>; Thu, 21 Nov 2024 16:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1732233905; x=1732838705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNfmZ8kLGk3Aq5GrsdbwcV0OpfxOVZ8lGDQ7ouTp+RM=;
        b=gCGk41Z0gX6dNCM94jx6/moIqPBKt5Q5M8HQD1dMTRfQa2OIakXwAb0ynqvI/ebxGD
         j5oylraMMfv5jJnhpWXXbJc+qY7OQ+ByNd4FeuPjyWufjS28q8/GFUTnSdCL3N0h+Kf6
         205I9fqGWR/wczrMPVcxv+rct7nsiFaBDYXPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732233905; x=1732838705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNfmZ8kLGk3Aq5GrsdbwcV0OpfxOVZ8lGDQ7ouTp+RM=;
        b=ObH0NgDQ5Za1XTl+eii9uMrk5p0M/gtI2p+k2voU8b67bi6phDdUpIPnUei1QVt2sA
         eKrV327ulHnp5Ber/2eEkXSYDHKDvbIf5fdgRdvDnv4k9FxT5NkR7PSpC+EHrcn6DaQs
         z9ke2FG8jilHMCJIP6niysGcDToa40bxCmrPFhpJQHIDOXUQjmlz+ZPdHdfcE2yzSXar
         gNbO2hwmODG4Zkb4CTZcGBJ+jD+Ypr57POMnIVLsaoopBruSvvK+jXghWBF6T9fD6aLe
         JsvoKAoFQ+ysWQ1Ajo3EQCal+7qM0+rvmZFvKJjZ3Hq9jibR/yiI+OImuSnmFagFJWhf
         PFDQ==
X-Gm-Message-State: AOJu0Yw1h35fnnmmC+XI11xHUaRlMD1WmS/xNj0uVneXq5pSAQXoqipU
	M7NRNWkaDWOMHz1vuu8rO7+mpR9Wmk3lVZxcZdf+vnON9j6oIEsSRz07U79vYQ==
X-Gm-Gg: ASbGncsIyvqN2aH8+le5SzT1tLONfds9klMtitGe2YvbbuWtk82aXaLQgT7a1ckdAOO
	IQVlN1JmXcgz77AfngbuZQRe/laDyALnEgmBOkppcmlQoug4aFfQWyUzJVyvhkG0mABIL2KfCZq
	dLNshdcAh87FLGnXWXR3FCcs+0cUQWI1B9PR0WmGf0/QlmOb70J83biHGdJXC+yZhOofJ3C3Mdp
	tHa8B6/HtbrHVs42Ru7h0WDs00HaA6iNZpzbjPSzz9YezZpR86Imyzvdj1OCCLVwxc=
X-Google-Smtp-Source: AGHT+IHBJJmVoqdEV852lyYDSdtvwnErbqQGnpMTbpDUvDdyHZu4U830e97nzCavsnPBEQLf8xCSqg==
X-Received: by 2002:a05:6e02:1a42:b0:3a7:6636:eb3b with SMTP id e9e14a558f8ab-3a79af75f91mr8552595ab.17.1732233905230;
        Thu, 21 Nov 2024 16:05:05 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a79ab86c6bsm2352495ab.16.2024.11.21.16.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 16:05:04 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 21 Nov 2024 17:05:02 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.11 000/107] 6.11.10-rc1 review
Message-ID: <Zz_KrlE59xV3BV8I@fedora64.linuxtx.org>
References: <20241120125629.681745345@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120125629.681745345@linuxfoundation.org>

On Wed, Nov 20, 2024 at 01:55:35PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.10 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Nov 2024 12:56:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

