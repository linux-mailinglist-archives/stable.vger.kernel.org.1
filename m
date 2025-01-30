Return-Path: <stable+bounces-111282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09F9A22D62
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8848A3A7DC4
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873501E501C;
	Thu, 30 Jan 2025 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na/IuZnz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0801E47BA;
	Thu, 30 Jan 2025 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738242605; cv=none; b=DAwnp/5v92FUwh6gKy3xZuqY+vUxelj3/gA7K22S9yZy+LfLGLreFoha+Xi/Fr9HrGIQ7+cfsvC5dqc7XYXlzn4c931c/ZR3f7dip4u2zF8o6NwoqpeUfPHk3CP0dNzjXtPKqsoYjX6iTL0oOI5gQE01E8/aKoUln4Uo/Dy8d8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738242605; c=relaxed/simple;
	bh=cBceCA/xS8yHpbhHipp+y3e2MOgF35l21oMstBDuqKQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lz3j4Puo/pPaci+DlCy68tXpjqpgF9cfU0goJGewGt1tUmJWZyXxCegX6KTTKfar3Rn98igtAG4FmKHyiJum/YvB8ky9n6lovgMG/xwTd3Wb868Gh+8yyHhxD3k8h4AsWmdFpnWvYTgMSaM/H117EOm0ajm5euvVeadFED2oKX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na/IuZnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85735C4CED2;
	Thu, 30 Jan 2025 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738242604;
	bh=cBceCA/xS8yHpbhHipp+y3e2MOgF35l21oMstBDuqKQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=na/IuZnzG6iLaHJ0ekFF7NXxYd3Mq3AK2vtaFRQffsjwpd2kp5ISHfKa02MHazQ1J
	 J2H1jl3OiqyjDUbgmzPHxo0LK3Ag1YpVGy8Budp5G1VgfMUgOXmQ5ddaV0G4sU30/+
	 DLoAU8RuGuSfAniQp9oyD/rLB7QuRogjxE13xmNFJxcKKG8TGAQegPS164m9x4PYoE
	 ahO2/JydR0bfnmfr4+XN976VqAuynPc2DDCh27WAA9PZr/lbwI8OJxiugWGq3oFcK5
	 uMvhj/MQxPnWIWRMxMTITU3cTpOwnUfr+xEZlo8qui1sY8vBoTQfrBrsoz9/or9qda
	 VW6bj7IJFZqdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB7EC380AA66;
	Thu, 30 Jan 2025 13:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mptcp: blackhole only if 1st SYN retrans w/o MPC
 is accepted
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173824263075.953543.6219182517471965649.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 13:10:30 +0000
References: <20250129-net-mptcp-blackhole-fix-v1-0-afe88e5a6d2c@kernel.org>
In-Reply-To: <20250129-net-mptcp-blackhole-fix-v1-0-afe88e5a6d2c@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 29 Jan 2025 13:24:31 +0100 you wrote:
> Here are two small fixes for issues introduced in v6.12.
> 
> - Patch 1: reset the mpc_drop mark for other SYN retransmits, to only
>   consider an MPTCP blackhole when the first SYN retransmitted without
>   the MPTCP options is accepted, as initially intended.
> 
> - Patch 2: also mention in the doc that the blackhole_timeout sysctl
>   knob is per-netns, like all the others.
> 
> [...]

Here is the summary with links:
  - [net,1/2] mptcp: blackhole only if 1st SYN retrans w/o MPC is accepted
    https://git.kernel.org/netdev/net/c/e598d8981fd3
  - [net,2/2] doc: mptcp: sysctl: blackhole_timeout is per-netns
    https://git.kernel.org/netdev/net/c/18da4b5d1232

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



