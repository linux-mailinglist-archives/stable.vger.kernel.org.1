Return-Path: <stable+bounces-202974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B862CCBAF7
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 12:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7200030169BB
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 11:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C19326929;
	Thu, 18 Dec 2025 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL2ZZUfK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BC62522A7;
	Thu, 18 Dec 2025 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766058765; cv=none; b=YDxeKyZcaNuHR6NwnCL3GDzYWXRDBd5eADNhhd+v6BrA6pvDT9LW0sLkrJR2AlFBTGeKNhXI1YgJp8UzwwYNVvg3lNKJRCJAv89QllYFp3PM9Km+qcOGDkFwvL9X0pvfeEWfYhIScjcdxxkXI2XVO3NEaoR43rdriyXJBN7O3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766058765; c=relaxed/simple;
	bh=7dqWovZQRjwtuAELkOAboUvPAMeoeIL1VxDnLEYaBN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MiY8ZrNw7e8loFzqs51xiszNjkFPsNN9dddKmxkQe6yYoF2Zar29fXqbZxCzwKomC8nMZUpvTXZZp2FlX0sIJaIcnV1f+btlP/xzzkaP4AW2GI5MeUysTzx/ehnvgmX2xSrHo5OX15zo+nhorrd4KvIeON7gLz0c0x6Xq4H0X38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL2ZZUfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E6FC4CEFB;
	Thu, 18 Dec 2025 11:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766058765;
	bh=7dqWovZQRjwtuAELkOAboUvPAMeoeIL1VxDnLEYaBN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mL2ZZUfK1ESRNTPE9UMf1jNqq1M8ZLyTlqoz7UcvrNzZELU37jnz65DKL0t9Tkssj
	 uCbwSPFZkTLWpQFYfT0uuIUdg95j1M3STNfEkuzgmfspm7/ictAchI18k98Y84HrXN
	 gAE3vFy8az2Fw0bGuSv+GZKGiobpgkd6bXPYHm1Wif4FvM3mjMw4n/bJF4aO7VxuFI
	 gDIcnTZt83eVX5dBWc3TR0Nfi2GX9SvcA8jBWIu+AjyI8Pr5APCODBF4fBUUDkyk7D
	 rmx92tULLYMK/r7UcDvpWn0PX/IAFMwc2k8NujLaH24y8V7bqO819MLRakl3+g5ZHd
	 9X4CTWdtjKHSw==
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
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.17 000/506] 6.17.13-rc2 review
Date: Thu, 18 Dec 2025 12:52:30 +0100
Message-ID: <20251218115230.74255-1-ojeda@kernel.org>
In-Reply-To: <20251216111947.723989795@linuxfoundation.org>
References: <20251216111947.723989795@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Dec 2025 12:20:58 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.13 release.
> There are 506 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Dec 2025 11:18:24 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

