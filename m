Return-Path: <stable+bounces-124115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2F8A5D45B
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 03:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B32189CFE7
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 02:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAB715539A;
	Wed, 12 Mar 2025 02:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="NkobOy/Z"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96761155330;
	Wed, 12 Mar 2025 02:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741746350; cv=none; b=MorpjfGUHBJG+dKQoRsHLWfnbfCXx0O4WmNK3nkczghn6yusplU+3k4Qtlwwgp57nKh5yZRxDUnm34UV0zAvOgrrZzgq6jNlEbmSSBKyRf3mwxv7V7Ds939CREkJNWNu54gC7pJwNoJks6ct38rv9MU2xFIU6N2rxd/8NnaQ1mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741746350; c=relaxed/simple;
	bh=Hr/1dHLIsfiK72NXU8O7a2kmn9+MqEJsBHS60mQomZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h12BeuE0dodw0xNyaFHuB1oN8FMUTR6HgewItZfegytP3+cFd/d2o/rrRE2RRBFayjTDylpATlSK/rzhPdUHjlAOBo1ckWSdgbcugNrkKlIUQZSGNkxDKEXZA7fwA57XtQgohuY9xNR+6P77GSxeBVZJjkUxPhkrTYrewn1DXoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=NkobOy/Z; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 861AC14C2D3;
	Wed, 12 Mar 2025 03:25:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1741746339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n0UXwm9U1+SO+FdlbueVqMzEiFAsmmq/d8t9Dl1Wxe0=;
	b=NkobOy/ZxQoxQPBrL4ueN8DEerlqkpPNDD3baNtmrA5PUbKBhSqAEWGZ+qCMHzntSy26Zu
	LQxX7/Q25wS/gOHEQlYBR2zLGHz/tx0tYHVQY6gyZ6/DnPJLQ5GXHB4jBRRmOf8CVSNQoK
	OkOPjhiocGMOzWOSkWDbN+Tlhcx8ilRdMZaGon2sIwpc+8N2QHJ9I1UCIkl1bMgG9BAbUt
	yG1KbmaafU0v86mpLPGTVhQuS2/TSyT9AFI4ziZmab1ALFxh7/YHlhaGRlmx6kqmUMJtQs
	a7CUoKXjr140hgfUCGfVKWUU79obqsBpiJelp8j4kCEaYBm0fr2jx+52xqbCUQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 644963db;
	Wed, 12 Mar 2025 02:25:32 +0000 (UTC)
Date: Wed, 12 Mar 2025 11:25:17 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/462] 5.10.235-rc1 review
Message-ID: <Z9DwjfdmtFZRZe6X@codewreck.org>
References: <20250311145758.343076290@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>

Greg Kroah-Hartman wrote on Tue, Mar 11, 2025 at 03:54:26PM +0100:
> This is the start of the stable review cycle for the 5.10.235 release.
> There are 462 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Mar 2025 14:56:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.235-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 92c950d96187 ("Linux 5.10.235-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
-- 
Dominique Martinet

