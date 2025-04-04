Return-Path: <stable+bounces-128352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEEDA7C5A0
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 23:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC73189E905
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 21:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B512215075;
	Fri,  4 Apr 2025 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="HRmLs/pc"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1B4182BC
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743802755; cv=none; b=MWyF5haHLCowR7CLGbAEwUFj0+3J3UsaQQDBy25Vf1WDKrA8f8ugPAWJcWo3p1NaPE2zMahuGZ2pGpMymS0z5V6r8YWRIfOsVl+jgwqTHr/WwwwYWo41h47BlKRKJlXudyfelFhWdM1hIkvcAUyD08k4aZB6tgP0vin7puvidew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743802755; c=relaxed/simple;
	bh=QABGtXWp+PTfrHwfQTr0E/H0tw1hzN30Yy/M1wIGo/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxbwSv4ptGfw9Iz0tOB9vwzBBqEBFrnBT+HteVze/Dnkna6J+N6I7b6a3yh0FJvtfITvicLN17ZoKyaqr/Vl7aYpmDNHM/kTb4aZuajQ2hHFmY2CBluuTd308fBHdkGkBwHv6SwoqRAmMpNmxmz4qkfDqSj9jU48wr8On76sF3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=HRmLs/pc; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85e14ce87ceso79086239f.1
        for <stable@vger.kernel.org>; Fri, 04 Apr 2025 14:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1743802753; x=1744407553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENJyUpYAa//xspw6u0+Ksfea+gHqJHq1I/Onh0TI3hk=;
        b=HRmLs/pcPxX8s8c4WpG0MAsDYZPDkC+MtEFt760cgWVB4kc0RR6Vyhye5y0xjyeslk
         viB+xD1W7P4ZTJPTrK1iRC6ZPouOt1+oMA1NJpGbHjNTBB+qOAaefEFnnGV7fIbzB45a
         +KkzOcDXAFzwo2OG+0ANI1Gj3KjEq78lx8PuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743802753; x=1744407553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENJyUpYAa//xspw6u0+Ksfea+gHqJHq1I/Onh0TI3hk=;
        b=YA+/vHJvhDAbnCDwYzqAzJi05/pWH3CSMi2OfPpW3zk4t/NjRG5aPSjBPm7HPy1Lhm
         IToMP2TUdT24FS8Y5qrOnm7gY0U42pKdxOQRWiMNezW68cNLC4/Ofz9Oi9YRWFsNYTZz
         YfOQq+u2ewOnAdR6Zwpk8ssf6ZKnoy9vDIC+1QmSOzHOK20BnS5T7ubnlaOtzLR2XR77
         HUI0NRtsKqJY4MeirD1AFzCDP5PYjJLB/kEajdF1YlrIlmX3CZNRV7/rnE7XyX6vjp4i
         2BUoOSwbPzHTsnIu3VmNb07UpAKa2gaGJ2u4r56esxsNOmaPQHgv1fbVWXzZBmVIA5qT
         pcJw==
X-Gm-Message-State: AOJu0Ywhg3tNj1ezYCnsLSLhAmQPEJs6331yYyoV2j4zSB2x8wKZuFqy
	DeMTnPv8/AQWlUVXkgpJPHOWUvnQXPS5fUFCcfSP/wSxgIScRZo8soKmny4NbA==
X-Gm-Gg: ASbGncsDMIEcjE4nv+YtFw+n8/QTqetvPsj83NrZqVI6ABDgqGYmGNvFqxgX3JMMYw6
	aIHlXCXlSv/NZq6vTtQ2Yrx5TzSjFepI/vF2SxLSTSjxBB8mOTBYmP8ibnR4nCI3whE6L8N1Mcq
	9CKMToBVLszDkPoes9BKbaQMFO476yBSOTaM2v4ox3gfK06e5GmjORDg3eZzSHjQXtckLpIThj0
	kyS/u1oc0HoaqVTKJhuCwF5lxoIwvDapIQiA/HqqT0EYujU+zDU5F9Hn1+PEzVAsiAMpMzDMxVc
	CR+k15Ywe+uoNcFPf+vXLj393bW2Qc1gHlNBgO5t0P8BsOdMRRK23V0XxFjFJg==
X-Google-Smtp-Source: AGHT+IGbcf6tz83rGLyBLgsZksMjls6nLeRdxxAHiAxj22AgIjPSRs4Lq7yykuQU6PSnh2BoV0s99g==
X-Received: by 2002:a05:6602:3fd5:b0:85e:16e9:5e8d with SMTP id ca18e2360f4ac-860ef3c3fe5mr1303615639f.7.1743802752986;
        Fri, 04 Apr 2025 14:39:12 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4b5d3f057sm990829173.113.2025.04.04.14.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 14:39:12 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 4 Apr 2025 15:39:10 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 00/23] 6.13.10-rc1 review
Message-ID: <Z_BRfgnJ_6gzLlCI@fedora64.linuxtx.org>
References: <20250403151622.273788569@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403151622.273788569@linuxfoundation.org>

On Thu, Apr 03, 2025 at 04:20:17PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.10 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.10-rc1.gz
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

