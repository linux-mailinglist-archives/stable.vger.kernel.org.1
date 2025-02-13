Return-Path: <stable+bounces-116346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00D2A351B5
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 23:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B613A4203
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 22:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2D62753EC;
	Thu, 13 Feb 2025 22:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="A3ZV8Ig4"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739AC2753E6
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487480; cv=none; b=ln5shXj9sMj2jYP2iBPcGIVuvJtcMNIEqZtmHdP+OSAIH4J5zMpCoAvAdJBa+QpucLfZyQc9a/yJt6lGk8IGRJlzel8g9B5cSHku+h8ARbo2OT9SHoAQKryTpVMIHPhCvGMJ717UJDPyza2H1pHm6D7Uaev7Yco5sFgLA4UHvP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487480; c=relaxed/simple;
	bh=Smto5Yxb6vav2wHm0QPt2rfaxx0mEaFrjpQZAsln/As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCHQOtRLfZiTBuwH+KkWTnB4aEHG7mriMCpkGGdCzPAmstkladPz8tS943b7UtAQUrURCDsZN8R8hpkBamqJKmXFnVdPAWJlsndF//+qpEHF/vM+SdxFv9VsVzj/yzLwZH5GGfDP33FAWGNS+xXSHqBhSefhRRlTSa+qfwN4mio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=A3ZV8Ig4; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d19e40a891so86345ab.3
        for <stable@vger.kernel.org>; Thu, 13 Feb 2025 14:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1739487477; x=1740092277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giMqNiydqfL6yBj4hJcOnss0/v5CTlMHhDcOLath6f0=;
        b=A3ZV8Ig4WDV5ijuWyUL2BwAU3PgJ5WHFcnrloyfl1vOYqdBTknPHqwJbH0c8RJwsGE
         /8iO1vsswiVr1EJOZAlrA9Ie6FqZHHkA8FvNlfX7chz/C0kKVzKTnbFsMZOL3N2rep0t
         mDp+uvnDuhk+coKCzgJdun7VCGR98KpoNMMns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487477; x=1740092277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giMqNiydqfL6yBj4hJcOnss0/v5CTlMHhDcOLath6f0=;
        b=JuRS9DKs9gvXW221QLy3KiDDa7KYaZw+II7x/iorQ7zi4mgwaEjS6680j5JUNgKot1
         IRA9kgPwtXsVo647/cJ5r1lW2UFG9Dz9I0yxze8tA83YoRRayIuoxqIV613dATiqaDj/
         bGPklQXfMblJqplNR8SzM3YQzNPzIB5UR+wDhhaDHfr1cykgsDnviVhgYWKbWvTaG+yE
         Uhd5QI0POt7K0Bg9hWIzeLPj9gojVPWEBH+caA1O/fiWkYd3x7W41K636BydGc6pdeeZ
         EKIpl7XddcoW0jS0u2i7mGtBiJ0s7TxZQwKZuimVZjr4UmHK8HmzSKV5BTuFMvZ90Q9W
         AOAQ==
X-Gm-Message-State: AOJu0YwEsfZqN89zFRJ1C1xuLM3E4dyJPZIXpyRyJ8VSo9PAsQH4vZ83
	a0AZo1aeuExSu2X2BCss8Q6xTZ/OKCY3PBOdTYkBB5OvOq70FvkXchFEPkvPFw==
X-Gm-Gg: ASbGncsEo8+KX7vjJCCn6UVoRZMauxvW7O32Q311KvcWXPIHFuilzA5CtqvXhTrN9FN
	jmOcuX57PWJpO6DVwbViMDMS1K1Vy3OckdjcWXQ10j/ZrrUAYG7t+j61h08xC9EBwrTNFrn6zXx
	kdxjYyVh+U/IOi+Dajc+IYPcoTfBW/y94q5DPcLzdsuA80Jk2Lb/S7NFTR9aosR3KwbwirWL0fP
	XssS9g4d7mxZcVPFHetlNRPoSfTMIB1Iq40Zv0seQ6Arnbd+0RsAZItlVzlSMhXlK9eGLez/UKR
	kDpIAO7PU4vOhVsd7xPn1jpvtbrOIr6/
X-Google-Smtp-Source: AGHT+IEzoq0TAA6AIhRAC9HUAPu5NTo0Qc2xIPZ91yk2fGKDrTwVk0kj/so8NbRnYKTQQLoBadEh9A==
X-Received: by 2002:a05:6e02:3989:b0:3ce:78e5:d36d with SMTP id e9e14a558f8ab-3d18c23b7f1mr50464215ab.12.1739487477453;
        Thu, 13 Feb 2025 14:57:57 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed2814883bsm538141173.19.2025.02.13.14.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:57:57 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 13 Feb 2025 15:57:55 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 000/443] 6.13.3-rc1 review
Message-ID: <Z6548yfCM14jmgqs@fedora64.linuxtx.org>
References: <20250213142440.609878115@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>

On Thu, Feb 13, 2025 at 03:22:45PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.3 release.
> There are 443 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.3-rc1.gz
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

