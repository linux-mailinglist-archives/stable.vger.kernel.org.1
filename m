Return-Path: <stable+bounces-179762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF430B7CA13
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94BB316D333
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 02:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCFE2F3C08;
	Wed, 17 Sep 2025 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTo0eG04"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60402DF717;
	Wed, 17 Sep 2025 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758076812; cv=none; b=e3IPwxndU4m8aAWftFQS7Rd9bweU0cZvJsjv1aSB+KahD8pm/pJ8E2vrIVovJBW4R49107Gv3XpYur99c7mYubW9qD/oNX9GioMsXvpzfgX0XvIRqlPDCn57oNL6djlruB6YU9N6X5fHU5obEP5lc2oHMQs0N33q3vZOriLODP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758076812; c=relaxed/simple;
	bh=/S2HMi3usPSz32wfGIPF+rTLYNKndealNpX9ovOTxRM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EKt3gKhHE4ToNiee8f0t/8AO6oblsApkYu+DoSxbRMLFmb1JL1+/y67zKk0OYwA4NudBrruijdC3d3lRkuCsopO7g+jpWeV9+zIOIx3wImvqf0aWSdrsswlRDwEs14Iw62r93cAaFmPWCsPuXvsEPjx2UkaeXEzfuzIHi4kJ9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTo0eG04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A204C4CEEB;
	Wed, 17 Sep 2025 02:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758076812;
	bh=/S2HMi3usPSz32wfGIPF+rTLYNKndealNpX9ovOTxRM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OTo0eG04e9twFTepVCTYzVobxe+EIJigaScEgmbcQrfCSl44NK6jgQvJrqWyq46bq
	 UU7PHRQI7K2R8k/ltzQGTEhl1cp4VAN3sgMphvR3Iowy2mudXgw+DUxOb1YSSNCNVy
	 Q/HA8sVuG4lmN2gjW1SRwVhpkQ3cnYAxd+g4qGFSZByMlfh72pVBfnTE4h/fF+1MjE
	 E1tt0zKjSSVoY2z5zj0ypYribQAEWoFpjfhU8d3a3C1dLLbsygz7oTa23UUO8GhG7x
	 DEQ9df136oEN+iAjROowKLFnubG5BVoRYyqhuRYZYU+E2BAB7lHvFChY3gN7Ekc2bg
	 gYiYlQiByDWXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D2639D0C1A;
	Wed, 17 Sep 2025 02:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Fix riscv sparse warnings
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175807681324.1444719.6787626572646476134.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 02:40:13 +0000
References: 
 <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com>
In-Reply-To: 
 <20250903-dev-alex-sparse_warnings_v1-v1-0-7e6350beb700@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, lkp@intel.com, viro@zeniv.linux.org.uk,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, cyrilbur@tenstorrent.com, jszhang@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Paul Walmsley <pjw@kernel.org>:

On Wed, 03 Sep 2025 18:53:07 +0000 you wrote:
> This series simply fixes 2 recently introduced sparse warnings.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
> Alexandre Ghiti (2):
>       riscv: Fix sparse warning in __get_user_error()
>       riscv: Fix sparse warning about different address spaces
> 
> [...]

Here is the summary with links:
  - [1/2] riscv: Fix sparse warning in __get_user_error()
    https://git.kernel.org/riscv/c/fef7ded169ed
  - [2/2] riscv: Fix sparse warning about different address spaces
    https://git.kernel.org/riscv/c/a03ee11b8f85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



