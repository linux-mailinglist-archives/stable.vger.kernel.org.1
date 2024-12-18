Return-Path: <stable+bounces-105201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A6F9F6CC4
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 18:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AC0188AA60
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 17:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E180A1FA8DC;
	Wed, 18 Dec 2024 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="f8RiR1cZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E01C1FA8C2
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734544678; cv=none; b=B/+i0jjYZrjio8GAct4qgAujx0uFTGCH5tRragKG62BPoC4w1wCWJH/YcMPXJ8IlEwpZsLXornK6YY3y8d0g2Aam8kvPHzz63kkndmfJQwsdQ18ky8nLW16C9JW0vbyprxmfqnV3egXkhXq6nKPysARMlg/X7oGNvh3VuwgPHTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734544678; c=relaxed/simple;
	bh=RWrr/PILJwxt070WUEquDMpPRS2pWp97dIBVHw8/Qik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyB5fAhOVC25FtMk4cefGeJzstsPcvjL0Nel82DpeKUyVUqXsUaz3OvHGHYeUNHp/fr47iLBdbp9osGhyMzgkXw8lYP4D4r/b5jdwYgmW1pJgkl/nM4qXywvyU7xTFidHUWuiRZohAl+TS3Aug36PS81WRVHz1FdVU+cYq+PTWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=f8RiR1cZ; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a7d690479eso54615645ab.0
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 09:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1734544675; x=1735149475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PyssnXrBwQm6Ar4ydeuKDWy1xoN97D0E6DenEmIPu2k=;
        b=f8RiR1cZ6ubEPhGlULN+szIh/KyquPnJdW/hdjP3A784ju02LoTN1GqnraXmTcLN1i
         D6YV3v81mUmbrlO2j/pq3BMv0HownORsKKa3WicHJW6G5Pghtc/eMHzifnNyJSGwWgRn
         /4IIZ0fSoLnSedRJcTJ6ENJnzN94NTbV0E+cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734544675; x=1735149475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyssnXrBwQm6Ar4ydeuKDWy1xoN97D0E6DenEmIPu2k=;
        b=GMZJAZaUfthTKmPGBjX+ceZlSgN0p6Ri1RZkj9RUcupGWyZGVxmkUYeIGAtd6FLxP9
         pBscN0p0HpeSIpiftkAxRo0eMxTlAYSTTOHAdVXWKE39VeFm7jFgbIBCne7nvEY9H83T
         2Mq/jCrLGB7x5Nx8zj2ZFDVh9l6w73d4pXPH5OGQc3B3BXN70LSEj2g72Y9dTCnprDQk
         f6qrujb0RiNcQyiVdVeJ4hXEkbINlI2d96nlJ9c1+MD+rFChaRW+2bUWcUia4dG75zbJ
         PmHx01jBR54CTeDN5KbBcWT5pKWfMpVOfVGU5fDFyAJ0S7jO8DFnaO2kBt+QJRGAQG4K
         pP5w==
X-Gm-Message-State: AOJu0YwT6HeagB2Vk89a/i2wenhmOhkKW+7RCJiWRh45+xkuTRH7xR4C
	iWZUVKwgecJAa2JSfvcpBVnmpK0aCfFkXliFocLFTPRlcD2Fvls3pJN9HXxtQg==
X-Gm-Gg: ASbGnctWxFyZkVGCg/G1kcM9lUM7sN1nACNw0p1aGOmar2WusrD5XBljRlMpznzFXhV
	9ftoONtuUaymZcuDjw4r+37XXSPVWLbBxBrAU4a38O23MsA5DgxE6/MGIk9FHr2Hc8JdFaSlmJh
	2M8VDLSGuFo3hJ5cnTZnq/qOVTeY75V5Z6slYERJpdbWQDSA3ogp5unBtnH6uZjSzKGg/UsP0OJ
	csFznDkhWIDpnPrkntU61mtWR7CZeLxZ0qCM6QMfHKSORpFGkP2+tVy/pc8NtCcLLiOE58MuQ==
X-Google-Smtp-Source: AGHT+IGEtCTnlSFMk32o4qbissvyC49r2rKKEdGcxJJUvN0CPkcHEYU87NouDIua0tLZhmd0ChJDXA==
X-Received: by 2002:a05:6e02:1f08:b0:3a7:e047:733f with SMTP id e9e14a558f8ab-3bdc0133223mr45969865ab.1.1734544675287;
        Wed, 18 Dec 2024 09:57:55 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e0368794sm2324087173.25.2024.12.18.09.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 09:57:54 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 18 Dec 2024 10:57:53 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/172] 6.12.6-rc1 review
Message-ID: <Z2MNIaPQdm9KgBCP@fedora64.linuxtx.org>
References: <20241217170546.209657098@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>

On Tue, Dec 17, 2024 at 06:05:56PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.6 release.
> There are 172 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.6-rc1.gz
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

