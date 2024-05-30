Return-Path: <stable+bounces-47744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6571B8D5457
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 23:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BDF3B25C96
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 21:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A209184130;
	Thu, 30 May 2024 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8QHWn0j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596B181BBE;
	Thu, 30 May 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103431; cv=none; b=KV4JGIXJReBlurmXk+xYB7Upd7OD1ohAoTvAPMVzkvvUX+avy9pQxLV1OSLt40gajZmVBQG9zPMhUQPnmZrIA7ER76Vt5z1kqP5hhKbr6bJS4HFY4LB4eVDJe7yZZipTJIkEMlxa37wVYvzuPaFU3F4XJNNTY7IKFwVfYTg2yBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103431; c=relaxed/simple;
	bh=zk2nrz7k0maanOnHvn/BGhqGZmMiVkfBehn19R9qQiY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qN26eH1Z9Sr6kCVEpMuzn6D699Ez2rsYjQnxsR0ah758O+Bc7bNrwZvqGGyRXyYgWRHnhfOMoC6AW20wxGriEmPulWG0aF2hsQAwFl0DkdPa/fH4YVjrc7wl+2i0FEtK69gegGobKEvCm+UMa4H5lhEKNMtpUHSnvgpK119lgqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8QHWn0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFA85C4AF08;
	Thu, 30 May 2024 21:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717103430;
	bh=zk2nrz7k0maanOnHvn/BGhqGZmMiVkfBehn19R9qQiY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i8QHWn0j+0G4EthV2coDLY8+kcfPVW53rGyw90R+yaHB6rwwskTCQh2rFLVTJrB7W
	 DK3QVX5fbv0MISHiNk9EXx3KT9ewifBgeoLTHbePsV54z+SwlIZAo2jUTN6aTQrUM0
	 0rqd7VhoRzdI1354atb7jMZev1I1cuZwlHNPrzaeUsdylriJSPvSfLLmzfnN2CGeOW
	 u0HwjsAWsGbsNZJJIJM9mOfQUSwOAQAU27bcOnSEtSmuvtfNtKBngA9Ghvg8xYKiqZ
	 nM8zFQ+yC+7ZKtQfvddleRi+V3coxNajWVlAU+w3UG9IPS4/oFQNP3wPnyDJNtQcSk
	 rrelUlzdIOA4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E5EBD84BCC;
	Thu, 30 May 2024 21:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: enable HAVE_ARCH_HUGE_VMAP for XIP kernel
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171710343064.6624.15790778712539042062.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 21:10:30 +0000
References: <20240526110104.470429-1-namcao@linutronix.de>
In-Reply-To: <20240526110104.470429-1-namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, alexghiti@rivosinc.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 26 May 2024 13:01:04 +0200 you wrote:
> HAVE_ARCH_HUGE_VMAP also works on XIP kernel, so remove its dependency on
> !XIP_KERNEL.
> 
> This also fixes a boot problem for XIP kernel introduced by the commit in
> "Fixes:". This commit used huge page mapping for vmemmap, but huge page
> vmap was not enabled for XIP kernel.
> 
> [...]

Here is the summary with links:
  - riscv: enable HAVE_ARCH_HUGE_VMAP for XIP kernel
    https://git.kernel.org/riscv/c/7bed51617401

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



