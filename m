Return-Path: <stable+bounces-142908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0330AB00BB
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB71188BFBA
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3168428642F;
	Thu,  8 May 2025 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Np96leWR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20362857F2;
	Thu,  8 May 2025 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723093; cv=none; b=Yk4a5wTcBrPBta0WUjgtPsJReX2bH4A3/QyCzWpckTDdlnYfoNwjiWUJ/F5WLrgfRrnPgZ/cVhXp4BSpntE88w8qBfp6Yf0swSlbWDMAn/XlCsZZ8S0th+sMqxQ4qrAov4JmgZJhJI9rK7yQpMMLUZE3uO6skIFYgt85e3ePZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723093; c=relaxed/simple;
	bh=xT/fOiFfbEtx2E9bQX+adB6nV0zaucHTcEUzjfgMukA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dy94Sko4+ZUGNBYIS/wktuF1v94XCDFIEIfHlFmiKrIJGBjNRL8awaagK15Fp2B3L/KvB/1U8R9ebhOfIqxBODuEfjJXrd2SGe0ne4nPZV00CaPUQKiTLuG+gYjfFtwona6hLH4tfPi8ouyfQ8R988hbcfaNelGdZv3NH5z1zVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Np96leWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C240C4CEE7;
	Thu,  8 May 2025 16:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746723092;
	bh=xT/fOiFfbEtx2E9bQX+adB6nV0zaucHTcEUzjfgMukA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Np96leWRr61I4LefGP0vjdqRdxi/864PpjzWwbwSBS6dAz49TLeUhg9bxAhHmNkXA
	 SzRufIcOHKorUv5VcCZXXoj8JHClPQFlZc0aPWuDWbdzJ01J2mWypjztnv5O+uR4h3
	 jsxue4ZyIVukRpSxh6qUyrinbT+p+tdWRTrYnainPVR778dzAfUIFyOKYv+3rLWc9z
	 sMiUmTcm7qJwgkHEwaTk/X0xFiPISw9Ynl+dnu/sOThOOwfMlJlcUY1/OEztF2PE+P
	 LKSx3gwaeANlVBJ9g0EmNMfuBvJSXZHREhg6chJOdS9tSqntz4UlM6PcXX+vxwA/SJ
	 ESqYSGEvdWJIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C9E380AA70;
	Thu,  8 May 2025 16:52:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fix kernel crash due to PR_SET_TAGGED_ADDR_CTRL
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <174672313099.2976395.17884540800538496278.git-patchwork-notify@kernel.org>
Date: Thu, 08 May 2025 16:52:10 +0000
References: <20250504101920.3393053-1-namcao@linutronix.de>
In-Reply-To: <20250504101920.3393053-1-namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 samuel.holland@sifive.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Sun,  4 May 2025 12:19:20 +0200 you wrote:
> When userspace does PR_SET_TAGGED_ADDR_CTRL, but Supm extension is not
> available, the kernel crashes:
> 
> Oops - illegal instruction [#1]
>     [snip]
> epc : set_tagged_addr_ctrl+0x112/0x15a
>  ra : set_tagged_addr_ctrl+0x74/0x15a
> epc : ffffffff80011ace ra : ffffffff80011a30 sp : ffffffc60039be10
>     [snip]
> status: 0000000200000120 badaddr: 0000000010a79073 cause: 0000000000000002
>     set_tagged_addr_ctrl+0x112/0x15a
>     __riscv_sys_prctl+0x352/0x73c
>     do_trap_ecall_u+0x17c/0x20c
>     andle_exception+0x150/0x15c
> 
> [...]

Here is the summary with links:
  - riscv: Fix kernel crash due to PR_SET_TAGGED_ADDR_CTRL
    https://git.kernel.org/riscv/c/ae08d55807c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



