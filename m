Return-Path: <stable+bounces-154718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6741FADFAC2
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 03:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED8717BB70
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 01:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1597D18FC92;
	Thu, 19 Jun 2025 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="bNHlXLUx"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D787083C
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750296969; cv=none; b=JNpttGrMkoyd1B0gByS1PMaDuISWX16anlcNayZ2e5WqbOXH8UT0SfVFSrhbhzkFrLLPbLhK2YQSZapcD7NOC8sQkFnsq76SolngfqN9Yu91oIL6e2R60c4pPtTqhrP03QgHd1gKma2DYZFOE8mXMjDSztCBOghCHhz4ffKMOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750296969; c=relaxed/simple;
	bh=a7LKI9yVxE3ykJg1bgsYmWUbSOo/xy/ycf6LqSydAZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCw+XycRqlsrY3CzbS/Ajynt33bQ9lIoKLT/ZfWr8GTXgonMK1xCJyFPB0j0zOKfpoLzhNKEjYikngJ7mseOYq7XskGqjDDjhrxlWOmPJB2m20QyLvkUoi7LWShZqXjjtwiUDHj7D1iRtqoVLWd8DhLlz+iP3NeBXpTtKvoRHNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=bNHlXLUx; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-610cbca60cdso222974eaf.0
        for <stable@vger.kernel.org>; Wed, 18 Jun 2025 18:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1750296967; x=1750901767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYxzGeW3SeKobvt5hVr2NPD7d0ZSxse5WH45fraPlic=;
        b=bNHlXLUx3Glu9X3rIaCgz2i927+V9mYpu5RfTW89nYyKjYFrNeC99HImFkV4+bzZgI
         M2L0s5FIB10ZEc/bNMcaiGt1UxCRtvpKLFpaQ+uL7w187ptoRVG+heg0aAe84whvT55f
         F/BOSZUnFLYH9440c8TZe3MVrNCK+KFAJv4Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750296967; x=1750901767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYxzGeW3SeKobvt5hVr2NPD7d0ZSxse5WH45fraPlic=;
        b=efnlrFSKVNechHeeZQNu31kgr5hs+oilJ3e8n7BDWgr3z0olCCjWmqxTMAwONG+uZ2
         0S0ojy6p66y/Z7/O91D1tps/pzZpSozIZchvbGFaL7KN1W6yCsXdeHljkdK5WTrffnBx
         QW7R7rbe9QJUxltN2BboLN4JlR1RXoV6jkQk6sg6pDId6EDGl8QgMvDVi8nMnBtnAvM2
         8kJCC9nwebYAC1fouLdUk8Va5EVcVYVWXwwBL9CMfc/GnldWnL5FPvWUJ0TjGM9DgWnr
         3eioTjeY+iiJivYUhWWrRd7LOGjg/sWmu7lXtTqedIU/hWSoziV1eCXk9w2UZ5BiQS1U
         Z7Ug==
X-Gm-Message-State: AOJu0Yxth1HMb5hY9upx9B6JuKF1mc4fIfu7fXkfehVqGI+BlA+fSdxL
	lVisQ15cvyfGiJPSmAMhqDTeamihSCYfKXaZCZ4QI6in4nsTzRquAli6QaLEbnhq8w==
X-Gm-Gg: ASbGncvUY1P8H5DLHKPuQsZHzr6CnuNGo+w/t5FCvuGFMD3Foy3pibaWzyubBCMZIHv
	6VVcC5ZRBppxaQOdE9ZoxRovJa6RAIa5qpUizm8znD4airT+bcuZagz8qAeCnK9M68tmIZUt62I
	VzefquJHVik3+qhPKsqZ5AkSUS0iNKsQzIu9lf5f3lk88AxlNRvwTu8+ewYAV8LauVLv10khIjj
	xM4QaX+BcKFFpEDKcW/tGdfygyyJNngPFTBgGYPAUitbJFTnO5ngoNlZcolp8GB0LbHyuCXSmM7
	R4MJyVOJI/Qqa0RkLRzXj1MkURUC7zMlrJth8i/1Kr/EQ8GSbB74Rf4r3vx+UHTUx0ceY93Pm1a
	XeIQ=
X-Google-Smtp-Source: AGHT+IFEailJ6g9LRTn3NG+4TGjZYtEMqCWW4yTLocUVb0EB4IywFCgdkoef2GnudjaCn24BHwV0KQ==
X-Received: by 2002:a05:6820:1628:b0:609:dd17:795 with SMTP id 006d021491bc7-61110ee3dccmr12281943eaf.6.1750296966909;
        Wed, 18 Jun 2025 18:36:06 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a4fa8a054sm1285463a34.51.2025.06.18.18.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 18:36:06 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 18 Jun 2025 19:36:04 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 000/780] 6.15.3-rc1 review
Message-ID: <aFNphCnmG57JMriZ@fedora64.linuxtx.org>
References: <20250617152451.485330293@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>

On Tue, Jun 17, 2025 at 05:15:08PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.3 release.
> There are 780 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Jun 2025 15:22:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

After dropping
revert-mm-execmem-unify-early-execmem_cache-behaviour.patch:

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

