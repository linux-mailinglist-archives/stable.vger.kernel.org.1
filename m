Return-Path: <stable+bounces-116527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F4AA37AD9
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 06:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D8216CD46
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 05:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B35F15382E;
	Mon, 17 Feb 2025 05:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lnh6PGhL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62AC142E67;
	Mon, 17 Feb 2025 05:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739769659; cv=none; b=CoAP0ozXXHKVbH3Cpq+wjZMUw1jdBo0RjM0dvGpdm2Szd/ttFD7z3S10Hv+NgzO+5v4GEQuAk/V7STbrZ3bwTtR32IcpmxxW5JA2bcHToOZFKaXF3s9+/W4MfdQFrmCK40BQ7bgqNl09v4cMFLlUfUbWLX2kwBG6JU8+qWCOf1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739769659; c=relaxed/simple;
	bh=780ys/21EB2uK4b34lp0M9WWVnQEHcC5RvJrDaAQ5j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RK6q/pWUWodAh19fk+oXyg+74SviydehQyBaZ9ISXBZMrA9Iz3LGMGPc5C5lrnpu38pNKOr9AN6dtDX2B7gePdb10KF9Z0NK/xcMPAYe9mwPm+9ZMERTAriQIXod83B3okqz9lkPGvYlEPdh+8j+MhuOUMF4TwUvng07DfWDAdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lnh6PGhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9E7C4CED1;
	Mon, 17 Feb 2025 05:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739769658;
	bh=780ys/21EB2uK4b34lp0M9WWVnQEHcC5RvJrDaAQ5j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lnh6PGhLZP0TqK7WHZix8rgk+BM5FLzqRqefJvj6YlbxfMut3O1oUdysfCgAHiJ9t
	 ChiP2GHFPgVu9IzEHrzQIkBFsmSSE20XI5wmhhucVOau5cKTkV+nNh7ukuPLQrxlC2
	 /mLa8b/O8qWjSpr1UmEsvgtLG36DrRTfDwTFP1t1uYhVvN6uzwkgT97TfSP6X0YUhr
	 PGegUHN2OZ7vJl2NRHtkopNDg+wERAYeDA5OFzh1ftvk74+VE2UNV2fOeRyTp3B+NI
	 ZXmKBLXP3T8WRZw3aMknsE5+D9SB5/q97+YAm2u8y8WJGQfufbmjiab02m1wYpt/7K
	 xpv2tdxPvnKlg==
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
Subject: Re: [PATCH 6.13 000/442] 6.13.3-rc3 review
Date: Mon, 17 Feb 2025 06:20:40 +0100
Message-ID: <20250217052040.198190-1-ojeda@kernel.org>
In-Reply-To: <20250215075925.888236411@linuxfoundation.org>
References: <20250215075925.888236411@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 15 Feb 2025 09:00:06 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.3 release.
> There are 442 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

