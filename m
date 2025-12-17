Return-Path: <stable+bounces-202820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB11CC7B9D
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86F7F301D057
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98733587A6;
	Wed, 17 Dec 2025 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Vp4uxsZ6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD768357A3A
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975903; cv=none; b=gO7I8idugnwJ00A2qJsN3VPKrZD13YUX5VmHC7ws0iEJPguYCy/gKSbh0aoXIFDkNqeNjIaw1i+cBewc9eH7vQEnXd2Q5jmfdol2LzyRtWzmpoXhTRJ/Y0gsl8B0G6TtT+30Uow+0Ewu+pX1H/p7A0WrP9PyV9fsfKeLW+9qHhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975903; c=relaxed/simple;
	bh=Q9NfrQgzON1NuA55ZAdPznOu1JV5p8tSPAcEDlYLfws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8JQh5deml+x6fAqcSFXpNwqllaW/OhMmX7ikGurlygjf9NOVhYy2umsaYva3vbF0UfBG8sDzOOWreQcP0zzKkoG06Jp2c5oFCFnCZTArw7g4VLHCkeNIGZJLLiu8nFfl9XpNV7eMgTt4cnMn2VnUU0K/DNFDg/IB5mNldTxlms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Vp4uxsZ6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0c09bb78cso4032825ad.0
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 04:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1765975900; x=1766580700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4zvJpq7zSMNXdeKKVv8NeDTBYC9vFAr+5L+jpAMPxk=;
        b=Vp4uxsZ6OVXCqT7mw9w9JOXXp0ilus0z7JyTZv/dLsyaJJ6jq3Xhkbhj3jVNtYaGhh
         P0LmW5ZPs1jyCdX5JrDWPQFNInX3tIU31k+Hqb18e1z0ijwuMT2m2bzAF0yTJ915nLn+
         HdqB4Bcq+Z6Ggo7/OEnIsMhvIbnD5Qvm+hXgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765975900; x=1766580700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w4zvJpq7zSMNXdeKKVv8NeDTBYC9vFAr+5L+jpAMPxk=;
        b=L9+cyFpTAzVk7eil5iXznWam4u9thyiBsCpFb/9ZJxD37yl+6teUk5+pY1rM1vJJii
         0HXrju/lXFsm07+5jajBFYyXXR0j8+x4S2UL3VSSu+/lAZoW4Ez3wCWiYpNg8qavysRW
         wLxAQzTXQ6sY1O6fBbv9jcjQNMV026XnFN0k9sugPW50siI8O7+yE5m1BKgwW6EzN+A2
         ZqalASr1BGXpMjYa9wFitb4E0GD6mmiKZQNF1Pwr5AwreOCj4f29VfcP6kEUrO4Ey+yQ
         aiSYBx07Re0ARWTt34sz4HTNPP/bWqT0GXna0h7rYos/7HeQXGwJeP6t7s+yJxtE1DB4
         hIbA==
X-Gm-Message-State: AOJu0Yzv+OsMTPWpCBOkblAUqncA9gyjSPa9gxlMrywkZDpkj1S+NzDk
	N7nlvCkbi1ki/+bj9PeHpQcsouX3cPkSsZ/gY8KgFLYjfeEG44U2QAtvFk6GtwAYog==
X-Gm-Gg: AY/fxX434KKMqJ+SOs/24MY+90pSIdJ/skcTqj4ZWIk7yp685RX3jKAkMuQQ94O6mK5
	bmwPSE2sIYJO7oyxc8jjIhQCpo1fO3h6QyrnGcNQinFA2zv7q8OQNLDzOoJxr+yb7tLU3gLF0bB
	GfBy6MX6NuPdBFA3agCOwFG8yKmBkEkNISm3GqAZnCcnEcy63X30//53YfsidEbdHvKuZkEWkl7
	nHsViHlz3mlcK6EiuIrLngpqQCbYxt2rdz9NL2a05w1P+3z4md0TiPpTmS31CZ4su27al7DASze
	7J7D3xkZoZv0CIXdcassM3t9AR38cp9D1hebIIezJKe3UTUNenL7x109Xsv/Gvm0ohuJlhYVEvt
	CXPBm3dwyeR3xQAv7FYJR6WEJamYJPxLB9Dz1BLqgqyqN76Mpkx1EHM1cdQFLmGr7IeOzU+W88j
	1rKWyJLRWE9lF/6wIFv3Eo63sYuRuoZDMVrOnFAHcveg==
X-Google-Smtp-Source: AGHT+IGdmnKF+so0f4dwJeJUBGiJBJF63KwEnnu1wpi/N9ykFrnmhiL7CUwyqzjCGjHF/UYJzFv8CA==
X-Received: by 2002:a17:903:2ec3:b0:295:4d97:84f9 with SMTP id d9443c01a7336-29f24eea3b8mr187391935ad.26.1765975900147;
        Wed, 17 Dec 2025 04:51:40 -0800 (PST)
Received: from fedora64.linuxtx.org ([216.147.123.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0833e24easm143335795ad.100.2025.12.17.04.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 04:51:39 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 17 Dec 2025 05:51:36 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/614] 6.18.2-rc1 review
Message-ID: <aUKnWN55-QaIfqrB@fedora64.linuxtx.org>
References: <20251216111401.280873349@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>

On Tue, Dec 16, 2025 at 12:06:07PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.2 release.
> There are 614 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Dec 2025 11:12:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

