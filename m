Return-Path: <stable+bounces-60374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE299335DD
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 05:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2021C21FEA
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 03:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FBD6FB6;
	Wed, 17 Jul 2024 03:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="fNmyyzfn"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D144320F;
	Wed, 17 Jul 2024 03:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721188370; cv=none; b=OvB0E0PHpUlQ5GtkUAk6NgtofjOptTxy2XrUvfxajukKBGZTBk1CGN4/vkHV3dDbe8vuRs/lOgT4oQEv0NcfY/jFhn/8NBk0e6CW3IehlQZjKkgHVSvI/GZrPZGPhEmT3lLylnmcwuTgra5DIMpYbh0+BqzJ0fjxGSgjLfa8KkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721188370; c=relaxed/simple;
	bh=190Y2A5xkCBOqBLn+NRs79sKGVhsrUJNdiw30AX0/LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TX0qb3XUYwo3B5NDRRYi4eZwfmWtDRFRpn80W9bz8JQkmW2TN2ztKHZnuqOYJlKUWA0JgtElRSt6dPsj19bu8JTMAuCBUFR/PvFsx2GrhK24EAR6m6dJker2E+5bPL3mEQP9+p0F+fjJCKYjejFALgzpG3NU1gk9rerfSqTcAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=fNmyyzfn; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id E7C5D14C1E1;
	Wed, 17 Jul 2024 05:43:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1721187837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j14M4ThIz7cvNgo7f5L+LNqEQlcj1D957zhm9JjOXec=;
	b=fNmyyzfnLABXtw7SiMBKgJBpB5dozUh27ZCC1AlTl1BguCLzxzHJ9o9vDiF4dRBCQO1FLt
	fk8Iqb2aGKPeACAX0SRDqkfsgXvRQXcP+vrGpza5E+ohE/sVh1zkA32d7SewCr0xYB8Wr1
	HexnRmTPpu0mTReZfM/nu8uFdZxzraB5Cs1ZcH48mp6+1WL9T8MgDrBRIPtGKbVENb9xSw
	snr4eMRYHCIftM0IBXzOvpMFFO2/lrjV8+2+8jZIDi3hP++y582mUedkrhHnwVBHpArBOq
	svIx9zP8aY4zsGMLf78wqkUutrjqwYJe6xUxpstVjSmWV23TF8AAYF7yCVNYFw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id fd859a0f;
	Wed, 17 Jul 2024 03:43:50 +0000 (UTC)
Date: Wed, 17 Jul 2024 12:43:35 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/108] 5.10.222-rc1 review
Message-ID: <Zpc957aQlIxd240C@codewreck.org>
References: <20240716152745.988603303@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240716152745.988603303@linuxfoundation.org>

Greg Kroah-Hartman wrote on Tue, Jul 16, 2024 at 05:30:15PM +0200:
> This is the start of the stable review cycle for the 5.10.222 release.
> There are 108 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.222-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 4ec8d630a600 ("Linux 5.10.222-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
-- 
Dominique Martinet

