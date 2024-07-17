Return-Path: <stable+bounces-60470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580679341F8
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 20:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83585B237B5
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 18:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764F91836EC;
	Wed, 17 Jul 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eL7vubkz"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB9718308C;
	Wed, 17 Jul 2024 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239732; cv=none; b=YCjcE9eKMlDpXUuSEs2/OTW01wKc0XtWccCXwZG5Z6QiBoplQOj6qC1llzms6L51crgSoQFlRgpKZQXt5+lfjpPdgnzqYJqu2lWsx3mGiA+Z7c13aCSDb4VJ5zLYS+s9sfllPI+Kt92+DqN9CGO+5oDZ6tmwmRKTMk0RGKQmQp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239732; c=relaxed/simple;
	bh=jfEbLwRzbR+AO47MR26vocJVJ/6XK/TedgE18kMAe38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsYK/8mcwwtIPqfJuBNbUpQdBUFz3lu+l+5LkcbBi9OwQj1jIfM9zmRH3tabFAJ8MG0fEoJcqeBxudHN0HpdFG83liV9PvAMZC3dzTtBVnkNVLSwmCM9no7oXZJU8vkKR1E+vMc8pHFUYi4h8LlXoWRtZFuYbboytx6fyX9BfL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eL7vubkz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id E4EC920B7165; Wed, 17 Jul 2024 11:08:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E4EC920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721239729;
	bh=G0VEVN2SRHtPLntxZ9hRSv/0U/PE7pyDny9m53mBDnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eL7vubkzF5jg+ol/xpqXaylGTv+pIjkZF70+AN5N8keBZ80b2Hj+fldlGta2ANpF7
	 5tYwGxRuNPyqpoMDjoUkzN3TgrO4buLdKnpAS0W8QTxyUeEXeWA87DcquWXr/xR7Wx
	 gZVeVWqUgfamvnU6KIn6iPB93kMHv+IcPpESeW+E=
Date: Wed, 17 Jul 2024 11:08:49 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.15 000/145] 5.15.163-rc2 review
Message-ID: <20240717180849.GD7194@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240717063804.076815489@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717063804.076815489@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jul 17, 2024 at 08:39:16AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.163 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
> 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

