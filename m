Return-Path: <stable+bounces-125631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACF5A6A47D
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 12:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1BE481AF0
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 11:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C9021D3E9;
	Thu, 20 Mar 2025 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/Kqis2L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FFC21D3E2;
	Thu, 20 Mar 2025 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468988; cv=none; b=DIn1OpsHjTT8cWFoxsSl+i6d1ej/g7MhWuGXtnS5PyZj468FUtvyD4NaIf1e4Slp2PSwYNeQhEqSMpHP5d3ORQWhiecD0ts+uhwAXgIJse1N19zQx2uUVG1jRUrJzbFnUPa3MIVtghQCq3PQ16LuHsSKV0t/1C2D+13dle8O4RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468988; c=relaxed/simple;
	bh=ijNPgn+L3DyW8ZTuS2Hj1lgMFJRwdb+THLOIUjKKptU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbQTnwfWuOFrWwVVG/TXC0kaGG7qD7eKu5O5YiY+sJR6I3UyW1EQOBeYGr4EwH9MRLIO8GkI9OE/WdaAAH7wgldCbGgffdHn0k9B53BufA2vYJ2uhuTbhN/t0/U9ol4pS6RBBoyA33RgyLfChhnyjrO1HXrTE0Wkd2KzmYhEPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/Kqis2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF2CC4CEE8;
	Thu, 20 Mar 2025 11:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742468986;
	bh=ijNPgn+L3DyW8ZTuS2Hj1lgMFJRwdb+THLOIUjKKptU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/Kqis2LGCDg11/sytW+1eVZEyV0PT2mXiS8kpwnKtZdhgLXkbM/PzZ4sq62EJM73
	 6zCE2MoC8YMVJMSxZdMhO01FiKJsfSEIHAZVDft288ag4VohtoG7PiY7Eglwx4FFq4
	 9wAW2GisIa1a1NRijtgw+9LJV13tWE7T/c+QjfMzybIapmK4xBSNEs0SB1YcFzfhEW
	 y0zhfS0+CSbwCvjlCW/HvdGTy279xQVnS6My0D5WtOq+DQsi0duPmfJIu3MRJvYfDJ
	 keVjEf9HDeSV1Xnw9zthoD0Ytfon8XDqujIc9w8j0mS5/xVsKJX4E64trDbObJzeP0
	 /WnKNxjKNNshg==
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
Subject: Re: [PATCH 6.13 000/241] 6.13.8-rc1 review
Date: Thu, 20 Mar 2025 12:09:32 +0100
Message-ID: <20250320110932.222395-1-ojeda@kernel.org>
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
References: <20250319143027.685727358@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 19 Mar 2025 07:27:50 -0700 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.8 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Mar 2025 14:29:55 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

