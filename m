Return-Path: <stable+bounces-165610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F25B16A66
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 04:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC595A4F4D
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 02:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB83623716B;
	Thu, 31 Jul 2025 02:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HY6OYDUm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D835230BF2;
	Thu, 31 Jul 2025 02:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753928990; cv=none; b=ZWJTqjJGDzwb2y/lG7b342dtKHGvV/ZyGVcENEul1jrfGhtnYBYm+2ukKSAtsGtBFPOGN6fHx7f2OASgkhXOkFRPW/TNhXXJTwTYkYy74MdlG/vMfdgkcuoeGa6nlptnYPFB7u8zZU0DzGPMuSnQZnPu3c5EmNPIjybXmJ76eHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753928990; c=relaxed/simple;
	bh=i0gTbPZvu3RX5j8puSP3ClFEEtG1bYE9IjCLTVHNC8Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZAUFz1SeKlBSzR7JpkySKBMvZsRqdtnAWHiRRv291acSwFG/gvRShDIdUNqOd2lwJWlsUi8zWXDMPxZNeOvQJRAHGHPjnmfxSm34gzudAFwd3W3vNgLXRXSG1dqG1uNmiNcHShLGXK7rkndohYc877rA8KpdbmuSkT63uGwiR8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HY6OYDUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFE3C4CEE7;
	Thu, 31 Jul 2025 02:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753928989;
	bh=i0gTbPZvu3RX5j8puSP3ClFEEtG1bYE9IjCLTVHNC8Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HY6OYDUmA5ZOfwFCeTh+fh9FGu2jpzc0PWqC9dCU7gqZMXcBDpbNtOfgpz4CCD5nE
	 EPFpRqWQmma/PuRbYv3qa05sinl5OhwuMjd1Qfsulh03fnvtTi+VZ//8FxhZhw0vY7
	 ctztviG8gx4jy7R1/cq8FCnb2ZOskXwir43cNL+5H4vbrng+Cuu4TY0t15FuX0boI9
	 I4EumwV0yk5o89P8Kbdkaz8gyOaoQlWjvsTeLMhcYcTxUVvlwykYWQC0o1RRCPdYb3
	 U5vT7SbXCBCnKbVkBDKeJJ2Ud2gWpbrC6jVxTobvhSLGRR1Ae41pGzkVK5yovSwQb6
	 SxEndaj4Uk0vA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACAB383BF5F;
	Thu, 31 Jul 2025 02:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: avoid infinite retry looping in
 netlink_unicast()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175392900576.2584771.4406793154439387342.git-patchwork-notify@kernel.org>
Date: Thu, 31 Jul 2025 02:30:05 +0000
References: <20250728080727.255138-1-pchelkin@ispras.ru>
In-Reply-To: <20250728080727.255138-1-pchelkin@ispras.ru>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 kuniyu@google.com, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Jul 2025 11:06:47 +0300 you wrote:
> netlink_attachskb() checks for the socket's read memory allocation
> constraints. Firstly, it has:
> 
>   rmem < READ_ONCE(sk->sk_rcvbuf)
> 
> to check if the just increased rmem value fits into the socket's receive
> buffer. If not, it proceeds and tries to wait for the memory under:
> 
> [...]

Here is the summary with links:
  - [net] netlink: avoid infinite retry looping in netlink_unicast()
    https://git.kernel.org/netdev/net/c/759dfc7d04ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



