Return-Path: <stable+bounces-108133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 332BCA07D36
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 17:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC131881C35
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 16:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C03E223717;
	Thu,  9 Jan 2025 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iELjAewS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3555B223708;
	Thu,  9 Jan 2025 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439393; cv=none; b=NLmw9zxAlsNHl83MCKxieCbi8Dy/0lUPWO8maeE75MqOPlXKyrFsr1eOKYbI1BfBhiMnIbEWCM1mDcA3PNuYwH6LRlCJJ8NMFPN9pnd1BygS4WeT2Ld0nbLP72hqchZ7EvIXpbqaPLF7QIJyF/8eyE69o/d9krDKAmcVrLvkhZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439393; c=relaxed/simple;
	bh=N0K2fUUZiT5S8AtXybWvlF4A8ZPgxRZ683066WaK6DE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nXLevTs8PeiemRBl+BVgG48bKUrQtQycBto5Lu6Pnvmw+IEAaSyQ+34dwEdleLJMLCce0Uxla8IHPGpgaWC6h5jK2A7fZrWLAZZinZB6yyW76AtUUW4mAPvaua3L+u27SFZu56nsvSep67JQ5MQdKFt77fumtW9nEEW+BClNP2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iELjAewS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC82C4CED3;
	Thu,  9 Jan 2025 16:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736439392;
	bh=N0K2fUUZiT5S8AtXybWvlF4A8ZPgxRZ683066WaK6DE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iELjAewSOPbolsIKurxjQ7zRsA+N2qPHi7gSaBeLyJJiQvWkh0I9MHKd3j4WVqo/s
	 JS+Ly0+ZxsWgmFU/ag79zzCdF6Dbg8HC3QCtIXQ/ljm9B/Vs19ZJ/eO1XhNHDJ5TCa
	 GlVIhhyp3q3S33wpZ6Z6pvjNbPGd1h9WwfdJfL6g+l0CrQGFl2cfZRcGd+hf4QUBwg
	 TFF1hGy9ZGhe4aROuuG4I2voPOa2Erj5hB8aora04Yjwv11khkD3TeIN4HsopniXJJ
	 BRP9iSoj9vYkyJwrRNgfwJkf6M/zUEjRzzt77upUFKGm/CO/jQSNBy644zTQn/gwhK
	 hkSxRD7kEpwiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC6D380A97D;
	Thu,  9 Jan 2025 16:16:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: kprobes: Fix incorrect address calculation
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173643941449.1375203.9833257781109413385.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 16:16:54 +0000
References: <20241119111056.2554419-1-namcao@linutronix.de>
In-Reply-To: <20241119111056.2554419-1-namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, samuel.holland@sifive.com,
 bjorn@rivosinc.com, linux-kernel@vger.kernel.org, john.ogness@linutronix.de,
 stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 19 Nov 2024 12:10:56 +0100 you wrote:
> p->ainsn.api.insn is a pointer to u32, therefore arithmetic operations are
> multiplied by four. This is clearly undesirable for this case.
> 
> Cast it to (void *) first before any calculation.
> 
> Below is a sample before/after. The dumped memory is two kprobe slots, the
> first slot has
> 
> [...]

Here is the summary with links:
  - riscv: kprobes: Fix incorrect address calculation
    https://git.kernel.org/riscv/c/13134cc94914

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



