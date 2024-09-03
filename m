Return-Path: <stable+bounces-72843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3EB96A0A8
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 16:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA7E1C2363E
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F80514F9D6;
	Tue,  3 Sep 2024 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY0GouET"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA1113F43A;
	Tue,  3 Sep 2024 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373841; cv=none; b=IcyoZOSkb1+Y1pbQKvNa+PFwz4WHKXm7xIRKRUGYTHgbhJF+GkVR/fcvLf8oyGqlss+J8mbmYxeOY/htZQkZFY9zkuVBV6sDaOJ125gYxBIOP7OMgz2lHOpM9gOxlYuazijUtZeESXeZAjFRFZzOzFyUaMlpI0QSnRR8LP5M4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373841; c=relaxed/simple;
	bh=gXbykwMFgquDkN8SDMxjOjIVVBU81MHk34Ikbht7mSU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bkS17V9ljJFLGRG964Qyf582D1PecjStplfudgqLV6cBrBZDGdoz/gz0jeM2XfbM6gtL2ZqgLpp7FCIBxktYu13uDR7VZVLkPjfsF2Ni7XjlivSKPfshL45yHlDgjz4NjPkhbzmGprNl2mnEgWYBGs+MAE4FUEU84NAGj+hcUuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY0GouET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4BCC4CEC7;
	Tue,  3 Sep 2024 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373840;
	bh=gXbykwMFgquDkN8SDMxjOjIVVBU81MHk34Ikbht7mSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NY0GouETMhA6ixaEs0zebQd5v7X+lytuVzWSrsX+un7J9l8MbCKFjBQ9tsj3llMIn
	 2bNW4KVWrafxBjqUy1uBWpHCYTMQO2lNRQok087HJxKgOaUsgFu0Qy6LhqbXEd2Az2
	 exFQx9qQYItrxEkjQSgvRlCOVX6ebKHflhY9EaaMIna+fJaPXHQso+o1aMlh4q6+DK
	 V/Ik3nYsoEeTElmDyRUplk/g4pwHkkRowcIwWQcK977tzMiRdOPe9RMMrwgWPRPM0/
	 jtsNV7OVJqCsb6B6Bhuk7xBHEP6WxXgDI9HMEgez8NjerpNdifVBYhFG4AVKretDIC
	 WNtGxNkrUDiYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB03822D69;
	Tue,  3 Sep 2024 14:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: misaligned: Restrict user access to kernel memory
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172537384152.320952.10274584984472776456.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 14:30:41 +0000
References: <20240815005714.1163136-1-samuel.holland@sifive.com>
In-Reply-To: <20240815005714.1163136-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 stable@vger.kernel.org, aou@eecs.berkeley.edu, ben.dooks@codethink.co.uk,
 bjorn@rivosinc.com, charlie@rivosinc.com, cleger@rivosinc.com,
 conor.dooley@microchip.com, evan@rivosinc.com, paul.walmsley@sifive.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 14 Aug 2024 17:57:03 -0700 you wrote:
> raw_copy_{to,from}_user() do not call access_ok(), so this code allowed
> userspace to access any virtual memory address.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7c83232161f6 ("riscv: add support for misaligned trap handling in S-mode")
> Fixes: 441381506ba7 ("riscv: misaligned: remove CONFIG_RISCV_M_MODE specific code")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> 
> [...]

Here is the summary with links:
  - riscv: misaligned: Restrict user access to kernel memory
    https://git.kernel.org/riscv/c/b686ecdeacf6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



