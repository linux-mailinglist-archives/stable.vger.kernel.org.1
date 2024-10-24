Return-Path: <stable+bounces-88112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D189AEE9D
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 19:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB3C1F21BD5
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 17:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076241FF05F;
	Thu, 24 Oct 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAnsUGgN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DCB1FF03B;
	Thu, 24 Oct 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792231; cv=none; b=UeGJfmxoppdxYtZMMik4UKAuFrl6zgZw9Zn/cxibaZr5mmgctEenm7P97AGO1oxnVq0K3+t2YFwex+/rF/pj7Dxc1XATsQrlU4U+Vx9mvnLPFnKv6RmUK+LVA3bmjHbd5S/3zZX7aHIflU45o9Ga9IHucF3g0oPqXiHbY30MFvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792231; c=relaxed/simple;
	bh=ptSiFDe2P85iu70FwjRoR12tixmT8CMtJdplcGQaHEY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZRNV6g5ESFNCSYbi51vZmvVqdZ7aFvyL1U6NwZO4L6ffqVhYbcXuBkVNwsdm3hQT67KiAq/4kdWueXsT7Mx9fftvb1kbs/2WThmdMmhTxSaSOL0RFGJfxZ3jC0HIDbCugh1FWdwJ2AJkMw1ntqiL6D3b50c5erlJ8pSagFqILok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAnsUGgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3FEC4CEE4;
	Thu, 24 Oct 2024 17:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729792231;
	bh=ptSiFDe2P85iu70FwjRoR12tixmT8CMtJdplcGQaHEY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mAnsUGgN6FJtIw+d9l1/gyUOeEN4rHsY24MKideem7pSGKkok1MntlshY9IJHK0DC
	 SsFaifEKtK9qyORVb+RZvjjG8Lnp2JWFJtyVqdM+U8YqNsiCsOCD/wagcVrshpVfRi
	 VDIKAbuSWAAOO3YtPpSYPsQIkrasoLA9IZx2IQLnBFmd7OIigJ01ygR7yjCDCa7Qh7
	 TwlS8toqpYvpcyIKgAN4vDhXgrGoJALKpf3VRZnhhvuW4CZQ4jfjSN8TOvbK5Is6CK
	 G+by3pgw8IoOakbhE8vpKhAd8fbLVpq2cAFT2BOZkrpssCt/bugv60C7CpJ5vSxPXG
	 9tFrJDieNhqVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D1B380DBDC;
	Thu, 24 Oct 2024 17:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 0/6] RISC-V: Detect and report speed of unaligned
 vector accesses
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172979223826.2327357.18000385603028507418.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 17:50:38 +0000
References: <20241017-jesse_unaligned_vector-v10-0-5b33500160f8@rivosinc.com>
In-Reply-To: <20241017-jesse_unaligned_vector-v10-0-5b33500160f8@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, cleger@rivosinc.com,
 evan@rivosinc.com, corbet@lwn.net, palmer@rivosinc.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, jesse@rivosinc.com,
 stable@vger.kernel.org, conor.dooley@microchip.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 17 Oct 2024 12:00:17 -0700 you wrote:
> Adds support for detecting and reporting the speed of unaligned vector
> accesses on RISC-V CPUs. Adds vec_misaligned_speed key to the hwprobe
> adds Zicclsm to cpufeature and fixes the check for scalar unaligned
> emulated all CPUs. The vec_misaligned_speed key keeps the same format
> as the scalar unaligned access speed key.
> 
> This set does not emulate unaligned vector accesses on CPUs that do not
> support them. Only reports if userspace can run them and speed of
> unaligned vector accesses if supported.
> 
> [...]

Here is the summary with links:
  - [v10,1/6] RISC-V: Check scalar unaligned access on all CPUs
    https://git.kernel.org/riscv/c/8d20a739f17a
  - [v10,2/6] RISC-V: Scalar unaligned access emulated on hotplug CPUs
    https://git.kernel.org/riscv/c/9c528b5f7927
  - [v10,3/6] RISC-V: Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED
    https://git.kernel.org/riscv/c/c05a62c92516
  - [v10,4/6] RISC-V: Detect unaligned vector accesses supported
    https://git.kernel.org/riscv/c/d1703dc7bc8e
  - [v10,5/6] RISC-V: Report vector unaligned access speed hwprobe
    https://git.kernel.org/riscv/c/e7c9d66e313b
  - [v10,6/6] RISC-V: hwprobe: Document unaligned vector perf key
    https://git.kernel.org/riscv/c/40e09ebd791f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



