Return-Path: <stable+bounces-207946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91869D0D367
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 09:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B6073009AA3
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 08:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8692D7DDF;
	Sat, 10 Jan 2026 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="g0+2GuPT"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D030E2BE7BA;
	Sat, 10 Jan 2026 08:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768033867; cv=none; b=JV/565sGp10u4jJ5/tBJhX5teX5JafWVoyxH3ZCEdyTzKjP4tzb7u6B02y5ifd7OWB8snPSjLiC8YpsnUCEt2jZVYyH5a/4NjrodgFyMtB0L43xJf1hvuoO0EUHib57+R9sGbw2g3RRt5Qe00sgCdHJf66DAjcGaVL/+5gscY3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768033867; c=relaxed/simple;
	bh=ZbUFGCZbuIoZAm+53fbW4AmaXwvq/GgRu1n/TCdj9uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyUuLTw59ACCMgv2VKAwDSdhhRVwSMdZ3pullQszAx8GuPifc6X/uYGEYR+e6wXqO2+rKNlS3Zi7HRGszlHNyyQmveE54kR/zt5zCR6O6U78il1+Btw59AZ/QXSoVcAvzvmLSybVlY7JNbXeaZyMd6wQApIA4Q4LqGXzk9Mde3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=g0+2GuPT; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id B6F601FD2A;
	Sat, 10 Jan 2026 09:30:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1768033863;
	bh=XXiK11z40EjN8UgrGIYNjukuMRbssBqvSyqSmj7WbeM=; h=From:To:Subject;
	b=g0+2GuPTB0sLUR9wy6Ywn2/AGt5iIQTWIICw6uY87mmGTh7bHFLrunlYkEB3uMTtX
	 Czl+WraHi1yCiqApkCCP5cZ4SAmi2ju32Lrp38W9aA410hCeE99FmRYIOAzOu2mU68
	 w7MuOvbRlSQemZoTNXmh4+uLq9XPcycQ3p2ocKJXdNqjTDGGGs64u+Bxvlg3RChvKm
	 0EnIoOybVo36lPmlOqXz/31Z1UlDZlmFcGQbgv00NC1H8qkEemKphLFE5FAAzvjDpy
	 qQyHp46VXC5ZMlykemNdhnZCUwOkvzJPtfeG5GkPNS7FeKlpMfXEwLCH807sCnWJnO
	 AvuGnmi3eNMHg==
Date: Sat, 10 Jan 2026 09:30:43 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 00/16] 6.12.65-rc1 review
Message-ID: <20260110083019.GA5753@francesco-nb>
References: <20260109111951.415522519@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109111951.415522519@linuxfoundation.org>

On Fri, Jan 09, 2026 at 12:43:41PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.65 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Compiled and tested on

 - Verdin AM62
 - Verdin iMX8MP
 - Toradex SMARC iMX8MP


Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco


