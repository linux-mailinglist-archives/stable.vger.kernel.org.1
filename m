Return-Path: <stable+bounces-106088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE68D9FC28E
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 22:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 262977A065B
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 21:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8F0212D60;
	Tue, 24 Dec 2024 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="hmwJULLc"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660C614901B
	for <stable@vger.kernel.org>; Tue, 24 Dec 2024 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735076215; cv=none; b=G58wB7L+b0yFTDrVkzC9D7py/rQIRY6sqUfahSN50GkUW/pQqU/uVCXVuw5m2NvNuN8eGCu/+79SeEs0w6Ldoc9MUqUgDHba1grVTyxGgEQrwoJVXFJijYw0z+41nfEWvL/lXrCI0ITwytM++NPxXdpaU8kxnR6mrc5j3citK38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735076215; c=relaxed/simple;
	bh=Z/C4yeb04ozX1TxmiYdpEkCwU4dnpvCayOdhi0T1hsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPsSHTXRsAwQT2cAqFOV56KXFXkWttce5VTVey2fv55C1jzhXHq7KJ1AwabOjKUzKGkCou1SaQuH1Mgd6YImVmVUsjHUlVTZgYD/0JDeEUt27sRF8aFSpRqBdS8opEGzQNHjdla1NoeRcK+dqSidGqzL5K2p5f7oUbwyJ5+qVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=hmwJULLc; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a9c9f2a569so41379275ab.0
        for <stable@vger.kernel.org>; Tue, 24 Dec 2024 13:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1735076212; x=1735681012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNqO5U1WzlHShdnDjDb2XoqFLabx4/jHbSlMuTmZVMg=;
        b=hmwJULLc26gi+PxXtF0vOF/cHTiGE9aefTIxLYbRlf+pJXL3CATQ81lbuDA45uF6Nu
         8bhadSm8lx7fEKnF1fD2XkiwvxWbYzt5QxojMVCOcgfG4R06qh1SXj+ZF5yHHTk/z2kg
         qH4ennBimnRJkUKahH/P5IB46wXYTp0qlnlac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735076212; x=1735681012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNqO5U1WzlHShdnDjDb2XoqFLabx4/jHbSlMuTmZVMg=;
        b=suv2WpUA1uO3SkZZ1Fl4FBCfabPPegkThBGzuXuBZ9Xwm9+eF6d/xfmx9ps6A/FUqH
         1huKPpn4UAT/kdwo1qnEJK9afiJTLXhR/IlwrRWCqTBNie79baBwDHDR3h4OSIXy0IHz
         XVxjK4y9UhE9+d0HKmtRpwArFAmaakankWbENz6eOYsEDDMBbYfzmndPEQK3z2VEeksZ
         C/3LLMyaNWJaAmJpPsIpYzhcO+Ad/9bsa3GkAqdsDc0jBCM/OMP0WGeONIsbr/HH4axW
         EB6zKli8yZl+6Q/yoK07m2Y10nOwj0YImFKcp9IyR2WyhN7b0K1UR0Gbcdqbz1p3tcMy
         kaMw==
X-Gm-Message-State: AOJu0YzMZGbbb1nX/mywPfWpthauIr0FqhY+wJjyqCFVofs/GIZOTBx9
	ibUtOYOyIQCn5IiwHxvRU/U7YtvnPNFIXgxjKNNvEM5ayqCsmAFuCBPIPLTVMg==
X-Gm-Gg: ASbGncu12j07n9FDVBV5otPZo5VLsAldB0VpRIZdN3RybhbRrCMumcZWdkUl8sktKfD
	X3bL53wEDLEH5KUTAhg3EGOwUwSzwjKw5rKeLawGkCkIqIIvOD/9ZF7drvR8G67+LzWP+WFPSE3
	T4LhG0zJ7fVMm53fKUfE3Qyfd1eMOBpNRTSGD7erCu+fDMmXT4L8A+oD/epnFELcHeTlIl4Fn/o
	cT7ryai8ya9xB3SCXCRTVFr0wf8fnkAlhY/us3JTSC8VtgrLCkattLU8ddS91bWuQhMnJze7Q==
X-Google-Smtp-Source: AGHT+IHY2P5R+AePcGV8ct1KgQ+2uPfWkyNQjgRvyqnpymCxfEYA4Mr32SNFFzLUYrJbNemzvvdc4A==
X-Received: by 2002:a05:6e02:20e9:b0:3a3:4175:79da with SMTP id e9e14a558f8ab-3c2d2d5164bmr151609315ab.13.1735076212445;
        Tue, 24 Dec 2024 13:36:52 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3c0e411e85dsm30983275ab.60.2024.12.24.13.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 13:36:52 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 24 Dec 2024 14:36:50 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/160] 6.12.7-rc1 review
Message-ID: <Z2spcofeNaxm3RGe@fedora64.linuxtx.org>
References: <20241223155408.598780301@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>

On Mon, Dec 23, 2024 at 04:56:51PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.7 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Dec 2024 15:53:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

