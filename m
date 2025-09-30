Return-Path: <stable+bounces-182886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C5EBAEBB5
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 01:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C083C7A87F9
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 23:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AC62D23B8;
	Tue, 30 Sep 2025 23:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="qYnwYtx4"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E59433B3;
	Tue, 30 Sep 2025 23:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759273575; cv=none; b=eldSqn8wcPsvkW9IAKTZBXGBVVuEGRseeJq8Ulb0NJBR17aNEWrYr2T+JfjDAlA4jk2EiFmMGu+tLBe/SQ0zT+TL3Kq1yUlvrm/QHwEn6nheJUj0Gqpiq04Ap+qUyA+TI4CzlMY4gMZ8k4jcxJXeAx7Rjk6NYlaQE6YfSV0p78I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759273575; c=relaxed/simple;
	bh=szDdDwtgfZnLrFWVhLjFoVGQWUsLeMIC4k0JDdLabws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4d+6aT2rnPmjTaf2ele23+SDwTSAtFsYglOnT4l2pJiM41iDvsdXNP4TDSUMUais3y5fgl3GwW4WhmlZm/AGjGRNxzvrbRDGAD4ozE1xzreqArlln9oHBcnwsNO1oh50kZ4005+mdNH3ouUC7eHU7kQVAMSQkiU6LWSM79Q990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=qYnwYtx4; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8DA9E14C2D3;
	Wed,  1 Oct 2025 01:05:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1759273564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FmFeZ1v5uOZjZ7aeAHzofBoLFsltvLy7eHvIFyvV/go=;
	b=qYnwYtx4Cfg6dZdODlQ3/OI59MQkTmkgn5a8JKljlpKiDcf/1djforil4kk17e/urlv8qe
	bmR8c1Gwt7Yo96rBOrBeldeSrr/212Wx1n3tyJlZfuvFbF1835kplxx0bHN+ciEzu3DXw8
	BzpOA1vQVqNL7E94uR5qlsu8ica7m1G9U6PJ4Sis8PsS5blJUx7urfaMFPgBsrpBqtIUvS
	8Tc452/dTaGQu5arJ71ju+hRoaUezwxFVOWLQPphxBR8sNyQdStSMSh9Ylcjy7joWZfOeE
	oYad0Y3kpUrOTQpZRBCQZIsyZdu4Rg+sZ3eSgB1eqgt6MdKW4+8eh/zpoEUlBA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1008360f;
	Tue, 30 Sep 2025 23:05:57 +0000 (UTC)
Date: Wed, 1 Oct 2025 08:05:42 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 5.10 000/122] 5.10.245-rc1 review
Message-ID: <aNxiRgzpyDGMA4ec@codewreck.org>
References: <20250930143822.939301999@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250930143822.939301999@linuxfoundation.org>

Greg Kroah-Hartman wrote on Tue, Sep 30, 2025 at 04:45:31PM +0200:
> This is the start of the stable review cycle for the 5.10.245 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.245-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 9abf794d1d5c ("Linux 5.10.245-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
-- 
Dominique Martinet

