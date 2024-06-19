Return-Path: <stable+bounces-53794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3667D90E67C
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C572835BB
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 09:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE5E7E11E;
	Wed, 19 Jun 2024 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="RzS3pVpY"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9141271743;
	Wed, 19 Jun 2024 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787924; cv=none; b=fkkg1LgR25pqr+oiXFTZckBGL6+0EbMgk6xoVvVm2Q1QfSFe9+Tolab+MX7eMB1CJaQDf6UlaRlE/8uSV8xLubS12lYgYAlZvizEFsu6KDEjByE9O2zA7ghvPDM8FMBhCMg40WOFILn6WTfZRJKFjCvDMlRS16FIcjfRPln7MSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787924; c=relaxed/simple;
	bh=7cuqbtTO2T0xC2U3DuHtcBcLZQ67OxZjdSsIQFlgjkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKf5Ot4d2dMGRedZrkdXQK60XO9XP1sBgVK11rTCdfNL5b+9g9Rxf1jvSdahA5vKk5sLeFGEQJPTL30bXW3JQUlzQ51DMdGu1tpgGsBCBHn4HSOgkJUt5qrWLwUB5LUfr5XLPdsf3+1w5BBHrIkdih9iyuF1+RYUkQdJUS2EqGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=RzS3pVpY; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D708114C1E1;
	Wed, 19 Jun 2024 11:05:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1718787912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=le7+/07s5UJcLTEq6XBfMrFrXj/eObiEjeEWlhza6BU=;
	b=RzS3pVpYJ25rJpX7bJttqkAKIYoA0djgl5FhrbdhJhkKB7vBdmW+J/TYY7YvrLlMq/XM5F
	TcORMS9cYRgmpfHjevaVi05BWuHrAWVsLnV7RV0mSP+A6TTgytrk3APcdiOnAFzq2m0YCN
	6u3vZFBhpSJL94TjxcZhftP1SlSdKoKxQfv+D6e1h3Ayi8T8HyB0vwF3ry3fr4Qx+QyAVj
	xGCD+0rmTo/D1MNSL2LIn0QmEF0cJxOf5OyuNeF6ShwP9fOfyEnguW6s8ngSHQ5mgu8kB/
	eEd3oFHlaOxMGBDexFd2/VJMsT4s4yef/2jrJlmWKrbphJgIAkRlOrK2vlWK5w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 8da32b40;
	Wed, 19 Jun 2024 09:05:01 +0000 (UTC)
Date: Wed, 19 Jun 2024 18:04:46 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/770] 5.10.220-rc1 review
Message-ID: <ZnKfLl8cdQR2iVK8@codewreck.org>
References: <20240618123407.280171066@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>

Greg Kroah-Hartman wrote on Tue, Jun 18, 2024 at 02:27:33PM +0200:
> This is the start of the stable review cycle for the 5.10.220 release.
> There are 770 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 20 Jun 2024 12:32:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.220-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

(that's a lot of NFS/FS patches... I normally don't test NFS, but given
the content of this cycle I tested very basic client/server code by
exporting something mounting it and reading/writing to a file, so at
least it's not exploding immediately)


Tested 7927147b02fc ("Linux 5.10.220-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

-- 
Dominique Martinet | Asmadeus

