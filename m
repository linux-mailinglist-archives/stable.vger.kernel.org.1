Return-Path: <stable+bounces-159263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C39AF61DB
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 20:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8CB1C46506
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 18:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D777D2D540B;
	Wed,  2 Jul 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h13kiYuq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925762BE658;
	Wed,  2 Jul 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482326; cv=none; b=oHk4EP90k5/NlXGBcGdyNW5EohrYE5wu9hJ+HOhlCjvAGNoHE+4aaslWYkTxlOnHTuuKis/F+exdc4aqcww3RCoGLibJqLO9+LWIwgaCu3M/0pvSBKTD0kBqWXjWQeKiw9JfIB/l/Nd+hF+IWjO02/W9Og94isE/jFIXcGG2rHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482326; c=relaxed/simple;
	bh=SGyeQlibR1BxJUiKs8Y3RHmbhvqdYbs9YQezGtbJUF0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hBQ8JLQXEqRgCzsKFsShw4sSquJGqgu5c/LLTDc0TngfUrgi47X9mqd8dyg+ZkXiBVLjJqXNVy5dYv+qxTLzFnutcqLf3ErTpARldrHuZb4LyqGkkKQi10lfIIB5Vh5mrqn/ixFOiFh29DiSCNj/R292VNVqGiMsv5BRRxgWKNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h13kiYuq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9AFC4CEE7;
	Wed,  2 Jul 2025 18:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751482326;
	bh=SGyeQlibR1BxJUiKs8Y3RHmbhvqdYbs9YQezGtbJUF0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h13kiYuqSnh82zieUjhHSdEouxLX44BEeA0ySmnp9JDXpj33nyfp311XK3rf/Fe78
	 /G7oAzfRKSyN6lQpAlvdVxDn0sA0+gb68Tru2my4x9pboDfeNAELEyL1kQdbJChha+
	 6X20edkJsOliLp2herjFfowxsExIy7hsNGbyFsrP2i2PeX7UriHxe5atJNsQ/tM+Fm
	 82woA3Zr+LCMrf3grYKFZurV53ze6a7Vh5FZrtWA659bL3HKJ9mCwSXL5eoo+wbAVz
	 2t+jPW00OGmccSMv7QbZKudlc94xgiq4+AZsXcb8dME4wHl+m61jxEdKErqLyYn8vh
	 ph/TMUH0MUBpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE31383B273;
	Wed,  2 Jul 2025 18:52:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: cpu_ops_sbi: Use static array for boot_data
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175148235075.828808.9774709298630060770.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 18:52:30 +0000
References: <20250624-riscv-hsm-boot-data-array-v1-1-50b5eeafbe61@iscas.ac.cn>
In-Reply-To: 
 <20250624-riscv-hsm-boot-data-array-v1-1-50b5eeafbe61@iscas.ac.cn>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 alexghiti@rivosinc.com, atishp@rivosinc.com, anup@brainfault.org,
 uwu@dram.page, rabenda.cn@gmail.com, ziyao@disroot.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Tue, 24 Jun 2025 16:04:46 +0800 you wrote:
> Since commit 6b9f29b81b15 ("riscv: Enable pcpu page first chunk
> allocator"), if NUMA is enabled, the page percpu allocator may be used
> on very sparse configurations, or when requested on boot with
> percpu_alloc=page.
> 
> In that case, percpu data gets put in the vmalloc area. However,
> sbi_hsm_hart_start() needs the physical address of a sbi_hart_boot_data,
> and simply assumes that __pa() would work. This causes the just started
> hart to immediately access an invalid address and hang.
> 
> [...]

Here is the summary with links:
  - riscv: cpu_ops_sbi: Use static array for boot_data
    https://git.kernel.org/riscv/c/2b29be967ae4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



