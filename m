Return-Path: <stable+bounces-182985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F84FBB1618
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9C8171D4F
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AEE2D2389;
	Wed,  1 Oct 2025 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVT0DnAW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369E82C3242;
	Wed,  1 Oct 2025 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759340439; cv=none; b=lIHj22GbJwPOLD+uwxLVpNNoN9TQt6FZPaoNtEOiizYRbzkicgLMix1nEAotymh5Bw4NOELRkA/+DE7T6cvZdILiguFp/6uSsHEf/Dyn6mWkB6u6XIiuQzLvudXvOCTWJ+Ie7SosVSGjdsbKQ2hxI07GxmeOflOPGJQzda9YHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759340439; c=relaxed/simple;
	bh=9iG4w4rMDCtz0Rd40z/rJlv9aNQQZx1uQlKrxqEAx8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diwFXa68TiuOUBSAdKmeqiAXH+i3Lrtshia+H69LKE00wOFDrxH9DtYV4cA2JpcvhAvKTrjsIQRjiGo/+ya9afyRJF32H9OGRFd5zv1POUBKUtXrn8jf1aM8SXSRWcVedZTjP1kcLW0nJLSgjZ+3QQBDppowuZCTkxYjP9/Qltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVT0DnAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7402CC4CEF1;
	Wed,  1 Oct 2025 17:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759340437;
	bh=9iG4w4rMDCtz0Rd40z/rJlv9aNQQZx1uQlKrxqEAx8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVT0DnAWKQQUQP9bPze45VbD/pE+LrZpdQ9ngXzOIVzOcUphdqbPvsvz8eq/Mke9j
	 aY1RZS/GGD9P1NPMKpfUPCbeBRjvsCDAk4xTMvVVMtySLYCq+Fw21NQMtSV5KH6ru5
	 ZCHergqil0DzEUw/A4ywCRFSBFusQPEN41BiXHIwFDPA+V+hPGpcvl7IJ1pFdK+xZ5
	 hO3re6ikBXTDr520NLMzlLbSO128UNoDy4HhiIzMIMCmwMmnCCeLS5nqankhcbcqX3
	 naKBZhgIncD64bv2kCmjHsYl0ji7eBKzQZKA3wvhU3YqtJgFJMxTokBqzWprsGek77
	 uW2p1wOTVKqKg==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
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
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.12 00/89] 6.12.50-rc1 review
Date: Wed,  1 Oct 2025 19:40:24 +0200
Message-ID: <20251001174024.46879-1-ojeda@kernel.org>
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
References: <20250930143821.852512002@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Sep 2025 16:47:14 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.50 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

