Return-Path: <stable+bounces-60397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CCD9337F3
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 09:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988C01F2208C
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 07:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C0F12E7F;
	Wed, 17 Jul 2024 07:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="lvdOTDkR"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1349B1BF2A;
	Wed, 17 Jul 2024 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721201075; cv=none; b=WMZpock+RIyzQuG8x/DdWLHc3Jmr3gI3KE4+DLBpSwsj5hayUiVON8lAtMBTYF6vaUYgPCS8C0kxEufkVlBYRIfK26cuk1TUeFK5gnCtPxqJZosMy0Qsf3mjIx05oLx34BVjAssYm3ZmLGaXgvRzg37CvPakf0hhcfx8TmAn9/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721201075; c=relaxed/simple;
	bh=z5MBYlG7Udg6jwHJE+vQ9//Mgm9ocI5FfN+SumzcXdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMNH2jCF4N+Tiy8JE7D8tlIHwWdtQcTd+axfeUKLFv5Kp1qT2bS52R1Igau5/wl/mqH3+yvHFknz055DSAlQ+KQG+EggW2aDu4w3qDRfI2uuS5QfScTQqxfOFIRq6lvUpoDWhPHzxbLvUCUIY7CHxhUw1xzGlDJ61ILc4cMx66Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=lvdOTDkR; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id B0DD314C2DC;
	Wed, 17 Jul 2024 09:24:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1721201071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Rg3Z3WdvS72e3JZ+zdlDbXW6BPrLhver+qd+M8zc8Q=;
	b=lvdOTDkROQbmAdwOGafVDaLtdQFUCowfzT5YHh6qa8Sd97m0+GwS5678ZGpPdidf1xnOsO
	JpryON0lgeDCtNhULOh67MNCevi2vy+1K16KG/RaTJ8iahwapwD/3bsQDOPvPZs9AKVijX
	GalgGHiqN/Ng1tK4HrsglrBGDG053/tDQv/pNrChwfS5ZvNC6Ye1GVC5OW9Pe0pgDZZf6/
	MxVDHvHnzQBocwWnTFe4slt25+OPHgdhUWI+TtTwWM33nbJsAq7KkiXFhhnAJ+IWrJWVDk
	GXNftrpTMv2x07lQH8GGjSerCXjzx9/rkJHTKf84oLOE7GSa4B6K8PU9XyiRsg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1b23f0c2;
	Wed, 17 Jul 2024 07:24:23 +0000 (UTC)
Date: Wed, 17 Jul 2024 16:24:08 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/109] 5.10.222-rc2 review
Message-ID: <ZpdxmEjmUqqERShV@codewreck.org>
References: <20240717063758.061781150@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240717063758.061781150@linuxfoundation.org>

Greg Kroah-Hartman wrote on Wed, Jul 17, 2024 at 08:39:31AM +0200:
> This is the start of the stable review cycle for the 5.10.222 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.222-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 3fac7bc30eab ("Linux 5.10.222-rc2") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
-- 
Dominique Martinet

