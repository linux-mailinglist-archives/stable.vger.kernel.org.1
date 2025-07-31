Return-Path: <stable+bounces-165611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 319AEB16A6C
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 04:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A07257AAF40
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 02:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7AF2367AF;
	Thu, 31 Jul 2025 02:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="LxAp9XhU"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A021C23AB85
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753929044; cv=none; b=HQCLO0HWhmK2JynEhZH3ls6VY2qRdaKaV14XuTbmmDe0rpLQkw28MRltuVIlQbT8xwbg82u/dWuTCDc2NNXW91HTSVXQGhX6S+hs/HmyN43XM7E1wbf/csvSQ1DOXQEb7fHduIiMp6ekaQN5A3ysy0gWZnMvh1wtHT9XeFCXUkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753929044; c=relaxed/simple;
	bh=BGP4l7+uPxiYh3sDyFOdJBPQva2qULDdcMFHkX14DB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2sI1YapL+faiC54O63GORQKH4p73JRL3dFih5HtZmlTGbYgCba4cRXZvCIDGLSjNB3zqZrfoeQpUiP6CSeSxuTwoFQvvdfWMZThBXJtgoROm00Kw1q88wYqcc5lk4t8pXep5TdpVJxs7R1eWbbhh/yE+Ol1jLDas5ia1Q2OdP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=LxAp9XhU; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e40050551bso4407875ab.2
        for <stable@vger.kernel.org>; Wed, 30 Jul 2025 19:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1753929041; x=1754533841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ushCqJt1jxq6Hv7PpAxgFKijmgypw1mO/90AreCqXA=;
        b=LxAp9XhUBzulWpS4y+BOE+qWvyRrPT6R7CuNcl6fWGw0sk9z35BuNyD8Yr5RoR29Cm
         28OI4PGKmr/o0aSEHmvZDPkXeKnIld4FXrnJ9IaHKlD0Xvs5FR3xTVnvLQHC8HOZxTea
         eAJZA1kNM9soIyNWEaKtC2fjzPusVGBfNoiPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753929041; x=1754533841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ushCqJt1jxq6Hv7PpAxgFKijmgypw1mO/90AreCqXA=;
        b=FX48x6FbWdOokFM/7j361NeeKv6BAZGWwBYXKR56kzu0KobyApko56qlY1Br7lw+OO
         LknALlo9uOiuCKJP34D4mn+NhJC9UVlIusHtG+M+RnRIZkQYfPvR2uBAx1Wt6z1HSTMY
         sEQ7qB20clAFLi61kTXC33j7GM7O2U7YzklP8i+NpNYt5xVKh/GwiImmGsoaqImCuyx0
         IE7lkwvVZuVVKwp+M0A/V2UBM587SKOM2+IOagh5WHfitWWxRsfvmO+gU0lMQtYVjU/V
         ZdDDy4aU6VI7IJ6i3BcPSOvh6yAOxg9RYgAEgASZNVVU7M6g9qESanQimEszUyqXNN1s
         6ppg==
X-Gm-Message-State: AOJu0YyvPomhfrKfw44Tsybt5gu+6w6hQLQV7eFFEegL8COLiOCV5C7P
	+a1otxl3mVoowe46tp5n0OfyJPHrq8P1HGMBJ3HGh/OZ1lI7HusJuf55tFZMZVegOA==
X-Gm-Gg: ASbGncv/1avsEQ/EJaSspFOpORPrw1M9gUUDJMcgDTHE9L63fgWpe/7FdUQoUo9Rt7O
	TlqM4IY3aBG4nufmEGXUuXUthITsTPzJcQe5iZCiTFgpEYIl7vZ2E/4Wxa8QvtdQ6IhPNSolY71
	N2aFTeoytG8kKXTXP1LBckrvjSpVUqDlEwoh4HL1zNU5MHYQJPcNFrzTXXjhJbyQisCU8bpg644
	8m67H2k0+EPghN8wBmRy6RlYJYxgO/ilZGzW4kqOlBu0F0q7sRZBMMhvVg/SxPdo+U5zx1ddmjZ
	woWj01pHOjbScpSZwtkhHdXB+rfwvEd919Cp7Xrhtl26K0X1CBJB5pgF5rETrO/EgIRuq+W/XM5
	fhzxVNePCW8aMjl/ZZ6TLyj1L99Gq2OKArAIauZ8=
X-Google-Smtp-Source: AGHT+IEpDkOSfzGioCL1XlJHEiBvLDgHoxybZGActJKiPQtp5q7HYKT7qH3LFaZFNhuA+F7wTTjKVw==
X-Received: by 2002:a05:6e02:216a:b0:3e0:4f66:310a with SMTP id e9e14a558f8ab-3e3f624ff19mr92076215ab.16.1753929041210;
        Wed, 30 Jul 2025 19:30:41 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e402b018f7sm2521125ab.43.2025.07.30.19.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 19:30:40 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 30 Jul 2025 20:30:38 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 00/92] 6.15.9-rc1 review
Message-ID: <aIrVTm6WHKLbiThw@fedora64.linuxtx.org>
References: <20250730093230.629234025@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730093230.629234025@linuxfoundation.org>

On Wed, Jul 30, 2025 at 11:35:08AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.9 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.9-rc1.gz
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

