Return-Path: <stable+bounces-179003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD70AB49ED3
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 03:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AD6189CFB2
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 01:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CD3191493;
	Tue,  9 Sep 2025 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="ukuaZCim"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BDA189;
	Tue,  9 Sep 2025 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757382352; cv=none; b=DuynYR0vfz7rly7aa1pYS1zIakfX3uBd0eT7Dy/Oa4Tkwm2qRFi8X3uAB9XWvkGbpWGa2uEOAc5A4s4zvfRlfNLa3aeX3uRT0t27T/7xlu9obwPTmR2FWcZV4XhlIHescLFQkMfNF1WwclZwlUH+Y1BOF31WHiL3ffzSuTQ2h6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757382352; c=relaxed/simple;
	bh=ZgCqQQVVaT1tXTjoHJ8xmUkArsEXgxQem7raZ145drw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dA2bjtsC/Mn2xrH15oT28JPTLbXBQcYbQJpzMb+QjTtTuDlcFl1yMoWxZwSKtNK/bQhycruGGU2PXJ0jZjLema4d0ss/lIqs5TLoilymFKP16qZIDVepHfRoL4+8L9uOq1SsSXFFXeeFw3iLo5MAsMtWCIEp5svUhwVFNoQur4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=ukuaZCim; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 9D12614C2D3;
	Tue,  9 Sep 2025 03:45:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1757382341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Xw7SABNGPMz6aX5X+eb4rCblJuDgRXrn0YRZIePfJA=;
	b=ukuaZCim4ngin9PTttErJ8KrOrClzwECxYsrhFACzEyZ6ISdyFTMzvxvXmZl9Sf/2rkW8T
	8eD3n7bvgzQIT1ccliiO77ivBKti+q1crdZsiWIg3mqLZXEIbFbKR7DTloiasUuCKozsS+
	lMzI8h1HhL1kTpNvYWb79fnyPF65SxVS9SuTxAvG4Gqe7VylFCA+BVS5IZTk/pBaUrvehh
	+xjNa/OkyuEpobUWB8w39OhOJSdtd+NPzeJlCEJF+c1WQLK+LcLjAi1H5k/mvRFeedUSN8
	Z3RjQrsPzvdJSMG7O43ocNlT/hxMYqCT+X035A0MF20dYtUNDcdzH+UsIip5Ug==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 31cf2fdc;
	Tue, 9 Sep 2025 01:45:33 +0000 (UTC)
Date: Tue, 9 Sep 2025 10:45:18 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org
Subject: Re: [PATCH 5.10 00/52] 5.10.243-rc1 review
Message-ID: <aL-Grp-b6MvxXgl5@codewreck.org>
References: <20250907195601.957051083@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250907195601.957051083@linuxfoundation.org>

Greg Kroah-Hartman wrote on Sun, Sep 07, 2025 at 09:57:20PM +0200:
> This is the start of the stable review cycle for the 5.10.243 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.243-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 910e09235335 ("Linux 5.10.243-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
-- 
Dominique Martinet

