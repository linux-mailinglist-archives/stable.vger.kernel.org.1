Return-Path: <stable+bounces-80649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C4D98F1AD
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 16:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA89BB21911
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C651A08B5;
	Thu,  3 Oct 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM4WINcl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C9319E971;
	Thu,  3 Oct 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966431; cv=none; b=HIkF3/WT/1+CeiYFl0UBAorv2xq0gw7MJ9Amr8fshwDY5Z5bmhLLxiIiuAzehw6zZnbvpKmRBdIPCr6FzHbHRZIN4PGbXtBDS7SYUkswMaNqmp/wW6ym6EgHKR/9c2p/vLTAXRZsGKthiNSXjtZepB1oIDmMDMeAGCVhOPcNg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966431; c=relaxed/simple;
	bh=V1XuERiBmSes0N5Yl/WUuKxBEijQFuC9DkaNNu3ZSeg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BguT3cL7IRfnXHMuNbW3l3Brm3WET8jXZQ2/eLv2737VmrZ5I21XRFF/Q1A8ca1HHyIkpqm1wXYQ9LyjCpOl+W1CZRE876phyrAA4J0J1sOytr7Ei0YQW4i8b8IDPmU/4D13GhohWsHnUt5A2cG2wDvNhQhIBZcByDLkvrV9gHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM4WINcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD75C4CEC5;
	Thu,  3 Oct 2024 14:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727966430;
	bh=V1XuERiBmSes0N5Yl/WUuKxBEijQFuC9DkaNNu3ZSeg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fM4WINcl1EUGbOjJ4iHhfoA/xDYxNFw7OXXrvXhBuq9LHJcLx2r3DZk8UDPPY+uXc
	 Kg/pqMr4lTnPR1sGW5gKMr7Z+wFQP+mT2lN7jPQAoof5opj6sQgQ9B1iaxEprtlBfk
	 qj21Atys6+j1mzi/iIgj1BGF6PuWL1v2bEZG710GvBNhvCbzFqxyXAvpnUe8FCRmuP
	 d4qaQPTuXa9mP5eixK583sOlNJIG5QL/VRWTLkyRxHvItT9afWjf+4hNggt6eZi0FY
	 Q4naOq2Dpgr+vzDv0Q0S7vw6Z1tk+wpNfssVYk9Dv/STbmZxlHjWL5dsFtBppWlTn7
	 6XQUsEH4eW9IQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7105E3803263;
	Thu,  3 Oct 2024 14:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Fix kernel stack size when KASAN is enabled
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172796643428.1879887.15358585146308905046.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 14:40:34 +0000
References: <20240917150328.59831-1-alexghiti@rivosinc.com>
In-Reply-To: <20240917150328.59831-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+ba9eac24453387a9d502@syzkaller.appspotmail.com, stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 17 Sep 2024 17:03:28 +0200 you wrote:
> We use Kconfig to select the kernel stack size, doubling the default
> size if KASAN is enabled.
> 
> But that actually only works if KASAN is selected from the beginning,
> meaning that if KASAN config is added later (for example using
> menuconfig), CONFIG_THREAD_SIZE_ORDER won't be updated, keeping the
> default size, which is not enough for KASAN as reported in [1].
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: Fix kernel stack size when KASAN is enabled
    https://git.kernel.org/riscv/c/cfb10de18538

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



