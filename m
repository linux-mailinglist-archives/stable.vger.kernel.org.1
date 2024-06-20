Return-Path: <stable+bounces-54686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC4390FBBD
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 05:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59F31F216EE
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 03:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14232230F;
	Thu, 20 Jun 2024 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DlVIjtz5"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F862E3E9;
	Thu, 20 Jun 2024 03:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718855019; cv=none; b=IYSI8V0E+GRvGTOryebA54e5Ou1WZYb1mdDxkVY+mJFcBkH2L4tNlXN7oHaGpOOGxKP7xE6M20cWG2F4mAyQ5NdWTAIUmtPw7D9FY4mecOLKuKIM1JXPtLvye/e26uLM7hykyiMKZAqG+1usnsW2qwUJTmiZizU/uT7+JEVCZwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718855019; c=relaxed/simple;
	bh=NfQKEwYBCUuhsaocLirllyk6R4p3GTLvwUREQjU8PvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U617hoSCf4m5WCqzKNia+vn2wYaFzsM5XEoNrrjMUgItfPyz0pSOh9mGI7cGdyzBHSk1/I8+v0ca710mVE3hYTUkbLG+DezLw29IR/cgW2vtv8HHDueJedhYajJV6kkivUiloDYASCg2il+DFU/VoA0ZdiNVoQPou0sRbO4wSXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DlVIjtz5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1131)
	id 13BDB20B7004; Wed, 19 Jun 2024 20:43:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13BDB20B7004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718855018;
	bh=69RQTB66yhL8BneGN33gr8vcB9k8T2axvwl7oNtX3vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DlVIjtz5D83cPk1+Xx+fpADjGP9sQoDjypJ+r7O/eNaLCwmu73uKLVBAUewef1ULR
	 00rx6dn7utylhl0c+T4DDrqhxoqiXTPec7zE5ayW0f+fzRlkXIgt/jjRGUwfH+YJz6
	 8LSaIxssk32zXTbd3YsUQMJ80qs3rFFuAt820DBQ=
Date: Wed, 19 Jun 2024 20:43:38 -0700
From: Kelsey Steele <kelseysteele@linux.microsoft.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/281] 6.9.6-rc1 review
Message-ID: <20240620034338.GB2251@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240619125609.836313103@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jun 19, 2024 at 02:52:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.6 release.
> There are 281 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
> 
No regressions found on WSL (x86 and arm64).

Built, booted, and reviewed dmesg.

Thank you. :)

Tested-by: Kelsey Steele <kelseysteele@linux.microsoft.com> 

