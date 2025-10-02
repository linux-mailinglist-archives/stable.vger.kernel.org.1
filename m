Return-Path: <stable+bounces-183009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7B0BB2AAD
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 09:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A5E3AB723
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 07:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AB82882A6;
	Thu,  2 Oct 2025 07:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="Q02HJgOb"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16ED239E81;
	Thu,  2 Oct 2025 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759389274; cv=none; b=FqX06cAQlQa5V89BfrwsXKpEY7BNx6JDRjVsEf0jLPCvxc5ew5B99S0dAyWvQ52M1b0YhMIj6e0OSF8n23IfiZ7dHbMljcTHdzhDMxFzGKNdiSJYqgXUBlKCwXGNjOSkTzCotpziiAc5bgpL5wMKuU3fFGKyjK/tK3yE4s55Ra0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759389274; c=relaxed/simple;
	bh=0WAJODxkaYC78/NXZIaEHtRUIomp/HSODLWOq7855uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2lsu1hiJNWlSMOPVpeP9F1CpVp30fJDMApHvl27OvjJlnhS6tFf2Fy9jI89FGvdeiY6mcYQFdIHMdNEfioYNficnzFhl3OhIk43rzz55AIpVERmmj43xdYo6adWsYdM0i6Dj3M7b22riRjRY9dD29u5hC6y6nGJLnzacQphq9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=Q02HJgOb; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1759388799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFSIsK6zuip8p2LTNK/t+i/Ri0Px578CxGOu8ko/byY=;
	b=Q02HJgObtFq4zjausj5FHmyhqaMaGbzHEexGa4ngJEgaEDsD78AWiCWKGGC3Z2mE5HdOMV
	4v8XRVe77keAQSBw==
Message-ID: <304181ca-daa5-4866-bf80-28653a064958@hardfalcon.net>
Date: Thu, 2 Oct 2025 09:06:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.12 00/89] 6.12.50-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143821.852512002@linuxfoundation.org>
Content-Language: en-US, de-DE, en-US-large
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[2025-09-30 16:47] Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.50 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.50-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.


Hi Greg,


I've applied all patches from the current version of stable-queue/queue-6.12 (commit id b249cb4d7eedc179382f657819c5ff4c55230b44) applied on top of kernel 6.12.49, compiled the result with GCC 15.2.0 and binutils 2.44 as part of OpenWRT images for various platforms, and booted and tested those images on the following platforms without noticing any issues:

- x86_64: Intel Haswell VM
- MIPS 4KEc V7.0: Netgear GS108T v3 (SoC: Realtek RTL8380M)
- MIPS 74Kc V5.0: TP-Link Archer C7 v4 (SoC: Qualcomm QCA956X)

Tested-by: Pascal Ernster <git@hardfalcon.net>


Regards
Pascal

