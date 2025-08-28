Return-Path: <stable+bounces-176580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0008B397B7
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 11:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE8416BE8D
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 09:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057B530149A;
	Thu, 28 Aug 2025 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3HSDOsp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9F22F1FF9;
	Thu, 28 Aug 2025 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756371599; cv=none; b=SydMrRdrqx8ERHEFfw/huSCI71BBWFWkXDj5TlGQRvx7SJuE1E2Uf9sWeiAXoEdBk2sHNvgc7leg8zpNr7HDjKPQs8jtVZQySFrQpQP0Jj6gfE5xHLCODYpP4nsxVEfzlS10s/9TFRujd65Bg/JqT+kR8SQFolg9w226r41Juz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756371599; c=relaxed/simple;
	bh=/2oR0JZ0sBqlT4S004CEBB4E5GyP8QG3b9FnYGVMcOA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AoVxviI8sRKijRr1TzzrLJj4UEzz0vWVeaGbtB5apPSD7hG3CylXAeqDeIak3Cn6E5CvRafTAM7InY09aQd1ae9XNxPl2otN8fT0n0CJjDeO+7YFyFyiFZXPl8y/6GZ9H6LHVqACoGcXiAynPgbwqI453hgx1lAhXFGhLRJ0wKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3HSDOsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC95BC4CEF8;
	Thu, 28 Aug 2025 08:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756371599;
	bh=/2oR0JZ0sBqlT4S004CEBB4E5GyP8QG3b9FnYGVMcOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U3HSDOspoiX8MLfOHD8isHA/zdNA+QKCYeSJ7utNV5TUSkN3Kshs4A2LZ9dS8Yf8U
	 BHTqyUVNx3eZon2dD7Evj4AeEhACXAkLMnQPtbie6JgxNzp9heDUbzndyMjAsyenRd
	 P/GKD4YMj1OqEkj8knVsTCby7gv08R3ZIG1czW0jxmPKMuv1s4JTUTIv9AWk6f0kqA
	 FGbK//afB0qRBF/3oH6y8uaXn5AmbIjeudmsDO3ZmHIS87uUI8gcnXfVmAdePREQv0
	 Jz035xs3JyW66w1o+qH4l4/1OkV+8lcNtROJmUyjvP75WQGudF9hWNnzbuZmzst6SX
	 qJNplJooqDPgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC2FF383BF70;
	Thu, 28 Aug 2025 09:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/2] net: ipv4: fix regression in local-broadcast
 routes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175637160575.1370010.11456217768616601950.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 09:00:05 +0000
References: <20250827062322.4807-1-oscmaes92@gmail.com>
In-Reply-To: <20250827062322.4807-1-oscmaes92@gmail.com>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, bacs@librecast.net, brett@librecast.net,
 kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 27 Aug 2025 08:23:21 +0200 you wrote:
> Commit 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
> introduced a regression where local-broadcast packets would have their
> gateway set in __mkroute_output, which was caused by fi = NULL being
> removed.
> 
> Fix this by resetting the fib_info for local-broadcast packets. This
> preserves the intended changes for directed-broadcast packets.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: ipv4: fix regression in local-broadcast routes
    https://git.kernel.org/netdev/net/c/5189446ba995
  - [net,v3,2/2] selftests: net: add test for destination in broadcast packets
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



