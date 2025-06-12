Return-Path: <stable+bounces-152579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE03AD7C61
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 22:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD561897D6B
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 20:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA24A2D541B;
	Thu, 12 Jun 2025 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSnqJ3WN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F388170A26;
	Thu, 12 Jun 2025 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749760232; cv=none; b=nDBobOfHN/0JdCNguVyg8MNSLv6a+JBasfkzbr6ccRIDAQmgHXMiiJUQ8UZkoGB6PxitohC5x7FaGjLttWQh3WRJXJ6OrY54XWLU75aFDHaqUXJYwgqOdeib4XP8k+EwEFbVl69eHthow8unm5Ofexuw7SQXoMqC9vxmQr5M3Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749760232; c=relaxed/simple;
	bh=P/BJsG75MoCdh1Htkk8TKsIUX8vVNvnqF6yuS+Fhh6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFclzTf4XmcyFkzD+ojOGISu/rMr6Wr3TjZL4N24yGeocIlWKIl7RfOUTTtJAD4w/8fJzZyvOY0yzBxOgOoxydwSvRIfjkbkXXJrqaHIjkokdHdizeuibhdw2EEzQLwumhOT3pHTe8HJxeMQzq8qO9eZhvIU0U7/3DD3rJyji1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSnqJ3WN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10146C4CEEA;
	Thu, 12 Jun 2025 20:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749760232;
	bh=P/BJsG75MoCdh1Htkk8TKsIUX8vVNvnqF6yuS+Fhh6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tSnqJ3WNSISf8MRUIvoYx7fHnEyGVZZadqXo1xJ23GV/WRHlHpwOy95TMkBqWJ6On
	 TAfhvVm86mXqwDwur4sWaWlm+avxMwgSIylJj+82m6zZF1XhNGT615u9eW7aKZiAvY
	 pDPUyb6Fsu4cxW7+IU1JTNplTv4AyYAfFvibvGl04oPA/y26r+0x6/8ttBry8RfCGt
	 o343E2shG+ZgeaYzzjPu8msSSubXv2YGU87j3qKkG8TZqaXz6SyaEAxDVuGNFtLchl
	 ph3GBTgDL2uL1ilOIATNGdadjyOgjUH/7rkEIBLEFq7ozqdqNMYfELUR1CJWdvF2Uu
	 y0RidNTKgORHQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.15 00/34] 6.15.2-rc1 review
Date: Thu, 12 Jun 2025 22:30:17 +0200
Message-ID: <20250612203017.1092739-1-ojeda@kernel.org>
In-Reply-To: <20250607100719.711372213@linuxfoundation.org>
References: <20250607100719.711372213@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 07 Jun 2025 12:07:41 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 09 Jun 2025 10:07:05 +0000.
> Anything received after that time might be too late.

Apologies for the delay -- 6.15.1-rc1 was also fine for Rust.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

