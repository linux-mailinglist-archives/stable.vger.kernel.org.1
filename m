Return-Path: <stable+bounces-171842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458D4B2CE67
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 23:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D16D5C09B9
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 21:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F89343D7A;
	Tue, 19 Aug 2025 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="hWEP/lpw"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA87322540
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755637849; cv=none; b=LrZK07t7wqEZnMIDUtmuegTxnOOn4Wd/w7cpDEf5zOW2XU0H+zxuqygocgr17LtbtqSRtzAl7kLQ75bE9msR20Ju42oYpIt6P8aFnZ+L3c756l28h5yTwOe59u15eZvbpt/Iun5Zsjpnubu8jrMHN33SKVM/WsxI5ShziS8VVoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755637849; c=relaxed/simple;
	bh=txX5jr8BxDd33Eld5ynHoiTnCcdsuh04s9+CPfvKpNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e54j8Am70RJftyrvHK6Vm6ddW/NJbp2AvNhKnHppzeH9Dn8Q+7wwfMzghwe1JoXAG3dz2dmX67nvB727CfktXn1puiWEyArJ1Mkd73pvzRA7lLDYG9ZXS2t/Sci0nEzE/rsT5qlJuZamqms3Idzgig5JO7Ifo6L6ZLJcVgU3LFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=hWEP/lpw; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e56ff1f604so31725055ab.0
        for <stable@vger.kernel.org>; Tue, 19 Aug 2025 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1755637845; x=1756242645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDkKsSqVswK768y6OwV/pwm/Qgw8vqSdXXmpv1U2m9k=;
        b=hWEP/lpwCh1QIhqisD/FTFS/JEjNWSsDSEdfmP2djzR2nxyaozkjTp7PXtnJQWBFdz
         YscgFauhns9fWgeMzNmhITLLB1GFGT99P6lJntHGO6VBZReZwZlPUZkWLFkNnrNYawAn
         u65mAfpPp4H2oCqZHTz8BDOIlSyaNttlosiiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755637845; x=1756242645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDkKsSqVswK768y6OwV/pwm/Qgw8vqSdXXmpv1U2m9k=;
        b=Twhm3DYQH1XL+5QPEOLZVkjHqii4LheIzLZojUqw46qSvEMPGmU4EZYUIKi4SO9lHA
         jMcBMloCT4lI8PoCiKSIJGj47Bjxp/2qNXGebD0DBWP97Zblr2olQCuJH4fFbUCGI7F/
         flkPBjd4heKqi1FpMVmerzrOn5My3ZUEJIsiSpGqzJCFZoFiAkWRRYfQev5uJsc189B5
         y6f0qWShc6iGH6Stks3KPDX7lvYcsxdmRy4YTwS0FZgKkhBvxGwwA5sdLRU0b9A6SMDb
         HWT1TdiY67qeZ4t8njEX6SfuFYwn5LoxSCwBaP4BHu06odERKl1ppKA6w48zc/DjO5ln
         yXsA==
X-Gm-Message-State: AOJu0YxXbQaboR/RdqdV3g/8cAlD//UraKsq64tfsq07OYHdsXjYdArQ
	cGtqjubcPt8Th/zCKI+nrQF5HwlSIK3Zn18ViN+jPABcQmSGKPxdMV/JoB/c1IiURQ==
X-Gm-Gg: ASbGncsBADjzOS6Eho82UF3kALiJhUnAaBdRjim0k2WV0xnaTm74A9PUM2HGjvtoKLE
	pwN97WOytzWfK8R6PcLIVAssQhRl5hIt/StupW+Be5m11bkzAEQUXuchvQRaFbrzU2z1ko/4Ufu
	OrkdUUFVrZU0UMnaE9xyMwEKNDoe75/LAtltUo9kbIczWp9qLeD/JDj4+xk32iyndtN10ydvmlV
	UsCYC8/tcKoLxW8STNzHYD1+Dm/8uclNVIUK0Lyo6nMm6hwzwweA4hxYLLXfdxEX9/4RXA2i6cA
	ck84q83h2z2p0b+XqWfTBL1txXjY/ELBMwVoOZzzDikUF7ifJXM4+O4IWpvqIuZJ/7Y7GQFQXoP
	c3RKiF8hNgBla7gFRzm/IUv2NV5t4FJlGlaInPunn
X-Google-Smtp-Source: AGHT+IFkgVqKIKxgw+wzoUg+k46rcgWwLSYjImXVctH+FBD3hju9b7c9XVOKir802ruFQAxf9LZvrw==
X-Received: by 2002:a05:6e02:3e04:b0:3e5:29a3:b552 with SMTP id e9e14a558f8ab-3e67c9f4910mr12050375ab.3.1755637845295;
        Tue, 19 Aug 2025 14:10:45 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c9477ef32sm3638741173.19.2025.08.19.14.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 14:10:44 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 19 Aug 2025 15:10:42 -0600
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
Subject: Re: [PATCH 6.15 000/509] 6.15.11-rc2 review
Message-ID: <aKToUqhLaqzvaSUF@fedora64.linuxtx.org>
References: <20250819122834.836683687@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819122834.836683687@linuxfoundation.org>

On Tue, Aug 19, 2025 at 02:31:36PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.11 release.
> There are 509 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 21 Aug 2025 12:27:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.11-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

