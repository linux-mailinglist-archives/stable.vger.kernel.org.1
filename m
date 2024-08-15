Return-Path: <stable+bounces-69225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE5E953972
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 19:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B373B1F23FC9
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 17:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6881141C64;
	Thu, 15 Aug 2024 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="be3LTV+m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251801AC8AE;
	Thu, 15 Aug 2024 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723744236; cv=none; b=Uo35oKRYWkWIT/fKsIpv6vm8Vl/0pxoho1cTAg3aKZK1RaR+xQPF894+SYWtIf8PGUlJ6dNf/YCkWPELNN9OFCLrQprW/gHnP3v2pX+mbnfDx+nGRzjoFiuFf7IevGt5hrOs1IlzM90IryeyJAouAblZedwwHhQVvzcFh6svkHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723744236; c=relaxed/simple;
	bh=mPwQMWmaE58h5WbJPFCinD0DF0R538hkvKeIfgExaZo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qVhK6pH1KWpqgf1JORLItrwc3qA8qffrYDP44A41XD58l3gmduPXHQcvZeUAWdVyApS9VWAgKWnGwkqPxa3EyNO+w3IFLsmMpRChDlfOE5HlD23cXvcg0v+ZbqAovVT4glQoYkZoQrXbnf3jZLYCeIMFwH/dZVhw16+pZNVGi7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=be3LTV+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F87C4AF11;
	Thu, 15 Aug 2024 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723744236;
	bh=mPwQMWmaE58h5WbJPFCinD0DF0R538hkvKeIfgExaZo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=be3LTV+m4+TrThyeg+AMlMFa2Sr5e6aO9C+yrL4O4bfNBD1fyCdo0GdKsHhnTu64m
	 Deh6qT5QIsOp7WOU6LGg92EN3BiP4ho9w9wDfvl10Q5WGnXmS3lyKfmVVdlR9Dp34l
	 FB8T0a2mCYWKo25HY4A8pUrRZERwuk48mYttECbGsfI+HInbL2/Sc1ddh+iHnOogWu
	 ywATzc/BdVo/em4amKowAXtEyzdtnkvIE7/yoSKx+ksZIS7l6gCo/lIMHXRDaGn4h8
	 ++wM7hoNLlpqSPUEi3agVcKBg25V7W+7vxyKff4i5c9WQWZeySPRU63vWh/pD4vDUX
	 Ye9Tzwgy+czJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 643B0382327A;
	Thu, 15 Aug 2024 17:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: entry: always initialize regs->a0 to -ENOSYS
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172374423527.2967007.4867324910866661414.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 17:50:35 +0000
References: <20240627142338.5114-2-CoelacanthusHex@gmail.com>
In-Reply-To: <20240627142338.5114-2-CoelacanthusHex@gmail.com>
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: linux-riscv@lists.infradead.org, bjorn@rivosinc.com,
 linux-kernel@vger.kernel.org, ldv@strace.io, guoren@kernel.org,
 palmer@rivosinc.com, emil.renner.berthing@canonical.com,
 felixonmars@archlinux.org, c141028@gmail.com, CoelacanthusHex@gmail.com,
 stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 27 Jun 2024 22:23:39 +0800 you wrote:
> Otherwise when the tracer changes syscall number to -1, the kernel fails
> to initialize a0 with -ENOSYS and subsequently fails to return the error
> code of the failed syscall to userspace. For example, it will break
> strace syscall tampering.
> 
> Fixes: 52449c17bdd1 ("riscv: entry: set a0 = -ENOSYS only when syscall != -1")
> Reported-by: "Dmitry V. Levin" <ldv@strace.io>
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2] riscv: entry: always initialize regs->a0 to -ENOSYS
    https://git.kernel.org/riscv/c/61119394631f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



