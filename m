Return-Path: <stable+bounces-158209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03497AE58CD
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 02:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9386F4C11F6
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641FE1A83F5;
	Tue, 24 Jun 2025 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWUMDohE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D3519D080;
	Tue, 24 Jun 2025 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750726182; cv=none; b=g5YdWTXmRgTsf9GWEjobgSIWNFZLKm4VoOkkXlttgkpsHDm63R3HLg4joaThcXkRSlMPHR0XsFqs4hK/5ioVdKr0QYw68r5B1TQLkn4cbim1JsEXwdlNquNqDxYY3JA3itzvLHFhBLf22dwTkAMIGMgb8M8vj4nbJba/TOCCK6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750726182; c=relaxed/simple;
	bh=oZx4kiMTZ7OFx470+Dr/BC+poOIjM3y43rIaqC5bYSU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bA9309tc6NmBXcnvGy7hZRgVSHc3ZQKYojnKk8qOnf3YIKKWoWvc0sig4R5cIu00m0NgjoEA6lM10alZvh985U1wXBL1+cjJUn38PVYM1h/1MibeyImu+1PGX8wDPB8Pf1bMBhmeACEP6xaZuVMK1YKAZ1FgFwj0IGay19l8zFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWUMDohE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB1DC4CEEA;
	Tue, 24 Jun 2025 00:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750726182;
	bh=oZx4kiMTZ7OFx470+Dr/BC+poOIjM3y43rIaqC5bYSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tWUMDohETfbJkqNFsEtYj3C1Dq923Me8JwaTDk1fyrZ119ihuV/yknGDP5ADArYNz
	 b+XYKWn442TvccaAGf2UoXuce+AssxuN6p00VwuXQ/AuLnTll3FoMEzTZ8zLF4Xjxh
	 9KU6DO5DnKY2vusz1O9KiP5x5+lsYeXqX0fjh9pHtzMSDiivbkklUsBD2nmbYaUJ9b
	 FFXdPyM4BZoSrDmd5HGbFKOqUc1l4Jha8xv04KW+fgmGUakENEe4pKmQqBHUwNA4Fv
	 6ZcUhrw+dsAJpfv5vpXMDgmC5NBo4fH3gN3pT40xR5/3fXJfoTeB2yLN2jPCKnckYA
	 GvwQvFp98E9kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E3D39FEB7D;
	Tue, 24 Jun 2025 00:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Revert "riscv: misaligned: fix sleeping function called
 during misaligned access handling"
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175072620874.3349808.15747931060584353769.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 00:50:08 +0000
References: <20250620110939.1642735-1-namcao@linutronix.de>
In-Reply-To: <20250620110939.1642735-1-namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 cleger@rivosinc.com, nylon.chen@sifive.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@dabbelt.com>:

On Fri, 20 Jun 2025 13:09:39 +0200 you wrote:
> This reverts commit 61a74ad25462 ("riscv: misaligned: fix sleeping function
> called during misaligned access handling"). The commit addresses a sleeping
> in atomic context problem, but it is not the correct fix as explained by
> Clément:
> 
> "Using nofault would lead to failure to read from user memory that is paged
> out for instance. This is not really acceptable, we should handle user
> misaligned access even at an address that would generate a page fault."
> 
> [...]

Here is the summary with links:
  - Revert "riscv: misaligned: fix sleeping function called during misaligned access handling"
    https://git.kernel.org/riscv/c/2f73c62d4e13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



