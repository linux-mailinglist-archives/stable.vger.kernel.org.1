Return-Path: <stable+bounces-83281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE4A99787D
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 00:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF02AB20ECB
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 22:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D561E2858;
	Wed,  9 Oct 2024 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="aZw0gybI"
X-Original-To: stable@vger.kernel.org
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F5516BE3A
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.217.248.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728512722; cv=none; b=WyhC/HnVtN3LjQIK1xQqhPmodouQVYCRVW9+iaNgtknOiHYG3putNmLDC4+5tUWYTe2s9T3SYZ2DFG1LGtv0xIMvMsylwoObrRgQCQxNlKaufoSdtBird6lxIhMOiUHepHdQyCRYU+fAhA8Q2Vuk4y1x5gt6fmGjeyDvIve2IHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728512722; c=relaxed/simple;
	bh=80eeEg2xSs7xURt0sN26ObYfrQq0SyVAybULuxaJVBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LOrwyJH5ry0Gv+it0xIjw/LbZFM4k3z8pU/hTnj/SE0+iaB9Y4NERWs68rwiQdnR1tX0kOI8CoOpSFL7ph3OjDIJRHmM6CwEMAAeh2r1rcMsSWd4uYSraB9NUh183s63okFy37X28IWNjue9EjpLysR48qV3LMCVT/bmsqDaOAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=aZw0gybI; arc=none smtp.client-ip=144.217.248.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id B6D463E92F;
	Wed,  9 Oct 2024 22:25:18 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id B78EE40078;
	Wed,  9 Oct 2024 22:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1728512717; bh=80eeEg2xSs7xURt0sN26ObYfrQq0SyVAybULuxaJVBg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=aZw0gybIYloMFuXxas8+0hhn440UjAKAvnIntetO4EYwXCbKGKYgEl4e/YiPDy4Aa
	 4lfisAAQlfS0qXrrNQ7ixXH+J1ir59c1Pi1pvc43Ylmid1qRQCEDTV8HyR2IE8yNma
	 nvQwiaVX/K1BFnbk4hbfjmLJcg3CA1CuGHw9ieRM=
Received: from [198.18.0.1] (unknown [58.32.43.121])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id A297640AD7;
	Wed,  9 Oct 2024 22:25:16 +0000 (UTC)
Message-ID: <948d698e-b662-4994-a253-ccea706c03a5@aosc.io>
Date: Thu, 10 Oct 2024 06:25:14 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH 6.6 000/386] 6.6.55-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241008115629.309157387@linuxfoundation.org>
Content-Language: en-US
From: Kexy Biscuit <kexybiscuit@aosc.io>
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B78EE40078
X-Rspamd-Server: nf1.mymailcheap.com
X-Spamd-Result: default: False [-0.21 / 10.00];
	BAYES_HAM(-0.12)[66.67%];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 10/8/2024 8:04 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.55 release.
> There are 386 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.55-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Building passed on amd64, arm64, loongarch64, ppc64el, and riscv64. 
Smoke testing passed on 9 amd64 and 1 arm64 test systems.

Tested-by: Kexy Biscuit <kexybiscuit@aosc.io>

https://github.com/AOSC-Dev/aosc-os-abbs/pull/8223
-- 
Best Regards,
Kexy Biscuit

