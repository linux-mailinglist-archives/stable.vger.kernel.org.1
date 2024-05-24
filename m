Return-Path: <stable+bounces-46019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A768CDF07
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 02:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3199128277A
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 00:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C412C63CB;
	Fri, 24 May 2024 00:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="b63FHAbG"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF7D81F;
	Fri, 24 May 2024 00:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716512188; cv=none; b=iJ1i72895D/bpzpw9HVxMZCxhIGRUN61VJGhaKqlBCYLYnziVCf42oS8BroQ/ZT7/Zh9ZA/RkvNo7qtcsRjqpy+sHTYCLB8xu/6Gkz7WycyPSIoLy1wxOp0mLSRzR8jGzIrZexant4waB9rLQKsTtvfs5u+KJIHHTmfnrpPqAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716512188; c=relaxed/simple;
	bh=5F1z1Woqll497cd46zyP+J5EAcA55tR8OXSbU/KNAac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AafcBfypai8cC9PblTQ522h29OlvIFPhO4Gq5aXh/e2u2dlllof7YO8sHn6icCXJBuhCqqIIH/I9O6rPKwj9Yg/IeOrlq1Egq68cYOoK73UNGoA3b8WieEli6KrKlixvk81vlAAVbv8EUkw202VI2KhtDhZX41WmicA4P0TrfIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=b63FHAbG; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 4875B14C2DB;
	Fri, 24 May 2024 02:56:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1716512183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=10Rzt42s+HPACNX7hQ0Sh+1c1eQ91GOfo9jACwkRnOA=;
	b=b63FHAbGiS5pCrH8hcTwp0IyhAL3RM6UxNRm5LyOPkpaZ7+6TBjip82FKAnZZPDCvyWvtW
	ZSflcHDFZFPPv33AmFPdQe8rebTJnJNXUsOxCu0dpk+B7BBsIT6NUeGTcI48enDoOIrOoc
	EH2NhZjP0jkpmP7HzXgawVumenld1Z4FKcjfyHBnnVzBOQj8OfL8kZ0cord+NauvP2Qd3p
	iNJp6SqUoG58yTIDy9pOBfYL9d6aYRM8EonBqKY8yD56EyATI+1gaAcu/1/C5UxEwKAYkR
	JnPcVdNjrqW3s6ysz6pUZvlDwJrYY7Hn2lCm5jxg36n9K/wNInDJx83EiT13WQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 2d469f13;
	Fri, 24 May 2024 00:56:14 +0000 (UTC)
Date: Fri, 24 May 2024 09:55:59 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 00/15] 5.10.218-rc1 review
Message-ID: <Zk_lnyn3IAmRtP2X@codewreck.org>
References: <20240523130326.451548488@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523130326.451548488@linuxfoundation.org>

Greg Kroah-Hartman wrote on Thu, May 23, 2024 at 03:12:42PM +0200:
> This is the start of the stable review cycle for the 5.10.218 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.218-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested bc8c5267b8b7 ("Linux 5.10.218-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

--
Dominique Martinet | Asmadeus

