Return-Path: <stable+bounces-114870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974E6A30757
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E2D47A2206
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD97E1F151A;
	Tue, 11 Feb 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvNOczBR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EF51F12F8;
	Tue, 11 Feb 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739266803; cv=none; b=EesOLqWIHBDweEiAn+++uNmSy2mVoFH9dQ5L4R45y2zmKE5QxAO7j5HVVVEu4fo0DixmzxrFFMfId35ZKlEKmQ79wzO7HHjfn6LLg5QVZ/b9TPu3iktrTlzvybHd4N5ld9RP+nTQ0Sa0l42EPrcskZaF0293Vtmb8Eq69uz0iJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739266803; c=relaxed/simple;
	bh=hhw/K5UBko6SO4Jnj4kHswrwWQrEhjIl651C4Att4KU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BoN3mWQVCsOxB5O2ooSgTwxvU8U4grZbwW+6quC4qwSfJSvf06dWOUiwUXIofdsPX5k8WnVXlWRSfkgSJ7et5T21LOxM1bKtndFvUEDMuZ6RDYG4i8/FpWdDfcBaFEA7/kcmSivmHiVj7VdvPp6dxk3zUU34vr4kXosxmNCPmdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvNOczBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B63DC4CEDD;
	Tue, 11 Feb 2025 09:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739266803;
	bh=hhw/K5UBko6SO4Jnj4kHswrwWQrEhjIl651C4Att4KU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TvNOczBRUD3DbIgYBezn60qvuIOO4sslW7NUc+eYiMZvxnIaMzJYnGfYlr55s8spX
	 4baEX5WCl8gKKryDYGundtlq0VfjUJjqdNinDLrMV2XGdDWmEC2T7O0UtW77fCdAy4
	 6nzUGgX+FmZQcTvhO96vfDWPwIse1uAhaCUEef8WzxZDPPEPIeHOjsjyni51PE/xVq
	 bjXCsQYPPSs5gMstk71Gqtbq40/aQpnkbGED9fjq4rbiqJTPptpgTji4MGF6U5fIXC
	 f6Eg594CUSqt8cuCnQ5mSrYKczAybeMf/dfzwjVZZCDq2+ZgH6m6qiRAJV2bzCSb34
	 6qifGpESibTjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342F5380AA7A;
	Tue, 11 Feb 2025 09:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/5] ptp: vmclock: bugfixes and cleanups for error
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173926683207.4011842.17472551825427009472.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 09:40:32 +0000
References: <20250207-vmclock-probe-v2-0-bc2fce0bdf07@linutronix.de>
In-Reply-To: <20250207-vmclock-probe-v2-0-bc2fce0bdf07@linutronix.de>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Cthomas=2Eweissschuh=40linutronix=2Ede=3E?=@codeaurora.org
Cc: dwmw2@infradead.org, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mateusz.polchlopek@intel.com, dwmw@amazon.co.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 07 Feb 2025 10:39:01 +0100 you wrote:
> Some error handling issues I noticed while looking at the code.
> 
> Only compile-tested.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
> Changes in v2:
> - Fix typo in commit message: vmclock_ptp_register()
> - Retarget against net tree
> - Include patch from David. It's at the start of the series so that all
>   bugfixes are at the beginning and the logical ordering of my patches
>   is not disrupted.
> - Pick up tags from LKML
> - Link to v1: https://lore.kernel.org/r/20250206-vmclock-probe-v1-0-17a3ea07be34@linutronix.de
> 
> [...]

Here is the summary with links:
  - [net,v2,1/5] ptp: vmclock: Add .owner to vmclock_miscdev_fops
    https://git.kernel.org/netdev/net/c/7b07b040257c
  - [net,v2,2/5] ptp: vmclock: Set driver data before its usage
    https://git.kernel.org/netdev/net/c/f7d07cd4f77d
  - [net,v2,3/5] ptp: vmclock: Don't unregister misc device if it was not registered
    https://git.kernel.org/netdev/net/c/39e926c3a21b
  - [net,v2,4/5] ptp: vmclock: Clean up miscdev and ptp clock through devres
    https://git.kernel.org/netdev/net/c/9a884c3800b2
  - [net,v2,5/5] ptp: vmclock: Remove goto-based cleanup logic
    https://git.kernel.org/netdev/net/c/b4c1fde5ced9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



