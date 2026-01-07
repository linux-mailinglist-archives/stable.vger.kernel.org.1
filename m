Return-Path: <stable+bounces-206154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B34CFF477
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 19:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67B9D31DF901
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 16:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF553451C6;
	Wed,  7 Jan 2026 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2i5ezrk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBF53446B7;
	Wed,  7 Jan 2026 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799537; cv=none; b=Sn1GvKpcGDNcj/YvMSYpUCoaZX+D/edDSSrsDflxwHqavx0g7+dj7QARJlyDhCTRwSByAKBmo7xSI+ANufFXBVyqiQdFbwtUTa8Y9TnQ0gMh27AjpkedfFJkm4Z6qQyas1OULIERPjJ0L6R2hjHMHMQRqSOvBkDPjUASuBpyaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799537; c=relaxed/simple;
	bh=WXyVHFr7w1XmoQspe6hAomP2C7C6aLBqG6zY91pUarw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DX8fBsgnhiIb8aYSCshJpHB3qUDCYWThgkPv9Vh56I+sGudxDQZL7IMTfWax6rxqZNTw3tiGzfYroXOnsCQGwwkdZsd3gM4vN+caUufGFu8/DfsXE+Z6aVEIAWBPrFk7SVD4AtRm1KpF6h78S34ZSrNb5NSxmfZXpmjac9/AyM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2i5ezrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC118C4CEF1;
	Wed,  7 Jan 2026 15:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767799537;
	bh=WXyVHFr7w1XmoQspe6hAomP2C7C6aLBqG6zY91pUarw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2i5ezrkweb2wuacE4gr4W7PsGLpbG+z7N+uuu1GgYUGcRoXhEszZNazbEclCdBuy
	 fZr5Eehp+ocXhAKzuV6DjvLrP5tTYzcGMg0uVZizxjoEwt5rJzIpze6M5DUQSYjRTz
	 KeXhT40W8A7ymhAb/4Mt8JtsLeeGV9jpN3y5wlLQTu6yaRJQKJjnfOZ1oAvMc6Hh9z
	 Yb8L/luwgzVeN48hq6vh0lerE8WPEXKjJBpYcHYxgtekrjZnFlO9RWKJ+WXtPGdkrX
	 ZdY9d4bayK6JSbdNYxaRwGTHDS4NZA/Lnk7qOj3+B/bngje4nzOIv2fmeGh3vBz6gZ
	 LqL1DXmn++E1Q==
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
Subject: Re: [PATCH 6.18 000/312] 6.18.4-rc1 review
Date: Wed,  7 Jan 2026 16:25:20 +0100
Message-ID: <20260107152520.472974-1-ojeda@kernel.org>
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
References: <20260106170547.832845344@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 06 Jan 2026 18:01:14 +0100 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.4 release.
> There are 312 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 08 Jan 2026 17:04:53 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64; built-tested
for loongarch64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

