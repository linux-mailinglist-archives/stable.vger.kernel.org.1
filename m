Return-Path: <stable+bounces-142859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AB1AAFB90
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 15:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78401BC0023
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 13:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990E122B8DB;
	Thu,  8 May 2025 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa3cHmlc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F722215F46;
	Thu,  8 May 2025 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711465; cv=none; b=kJ1ktBmSoPHkjH6Q07rwSx/1ENgs6Gfb2Yy93Ch+yivO3iveA9P7T5qNH/bCv4leg/CPG6tfGr+SFeAzzR5QtjVnal0/3io6X0GvAA8yPYv+ex70I8Y0Eoar2Qu91Xbg8wyljwMuykzdJxhuNIL6V8UrYupGr8T5dbDh/G4yBM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711465; c=relaxed/simple;
	bh=3Q5hpS4UiopFA8aTwSesQJKsipJ/7ajdIasure8u5dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqGlXRLU8CoIwatht6jIRtRmOVGabcdguuEL12sXhhFXdNAapkJnbGf/BcrbKQ1QAismd/AiEwLuMiyPvbXCi1sTGEO4DipfYXEvQkW/VEtYjQDPDomrUsXz//eE8GhNYpgXQsXZkoERB1M33CyBRTZrEDT8L07drKMp+JbtGsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xa3cHmlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA08C4CEED;
	Thu,  8 May 2025 13:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746711462;
	bh=3Q5hpS4UiopFA8aTwSesQJKsipJ/7ajdIasure8u5dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xa3cHmlcb2bhWSONIJ19feYsqWT8kTMeCwovuGA5IYhumrPd8aD5VcGYLGXGVTOJd
	 LqfJCJPjW6NEZUw4ISoN/4b8L+xLaQ8xU7ItTD86OsVN3l2bgwqXlDil29460KzwoT
	 vNh+IZNkXorRW/DJXnTyymmesRWM9NQy7f7F6sw0qmcEtTlUSWH9cExgHDWzs2LyNi
	 JYsoAM1sNDVPhOa0jY56cYMhl/sOgyeRfyhk1PrGU1rV2l09KDiI8+9URKjfLAei+c
	 1iD/cF0XHu0z/O+0pObCahbLAs1GZHVKKPDZ2mq6J+VSJWovRsyhIQVGb6z1IKkLsz
	 G3a/9sPJWOJ+g==
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
Subject: Re: [PATCH 6.14 000/183] 6.14.6-rc1 review
Date: Thu,  8 May 2025 15:37:33 +0200
Message-ID: <20250508133733.625934-1-ojeda@kernel.org>
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
References: <20250507183824.682671926@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 07 May 2025 20:37:25 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 09 May 2025 18:37:41 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

