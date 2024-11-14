Return-Path: <stable+bounces-92971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CEC9C815D
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 04:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC691F2261C
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 03:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270B21E9093;
	Thu, 14 Nov 2024 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0SkiN+G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0311E908A;
	Thu, 14 Nov 2024 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553820; cv=none; b=LsqseQHT98BjxUzJJAnTIqftgNt5KwHzRkU9p6a5+VRtKmovEp5X6SdN7QXLYvzvXITSkLNF6uqrdh8KH0fZrLnO9hjtwYRrTOFjL/spdFlRxsEYngV28jNy5Vn8qCTFb/0EfeTdO32M1wP+j5UeSAqNRuHrSorWTpryV7fhpAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553820; c=relaxed/simple;
	bh=xVE9ZKqGPZURWOle4+lgbkCut6C6Frr5hCEr+cRxjkc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lvWJOKOeXSU0W0KhEwSqzP3+WS2OnV6HKz/Mi/Vg16KP8DET3qFxF10GZsk4sQmAAScTZX2OikwPvgB+Uv9LzguBing3FdOqvlBS9qYxCTlwX/laJzMFerSPD/guhqqVab4XRBpH54QeLGcdLyeTwZdcwx0zg16n5NAuuNbVmk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0SkiN+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48900C4AF0B;
	Thu, 14 Nov 2024 03:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731553820;
	bh=xVE9ZKqGPZURWOle4+lgbkCut6C6Frr5hCEr+cRxjkc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T0SkiN+G0nQqyTJB+PXS3W3nbpno5R7G2Hi/InU4AkAEFOiR4sVZtV/1QL8oQpTfB
	 SDb78dEpu1OO8+avJaXLIDNwbQgmnbdi52XE7Bx1rqgjcp0eYvmXu/LHgwWqV5AlNh
	 ZJKZWGplbfo7dKs3t0HLnlKGySf8aOF14N0BJikYqcxvuCYmwAaLeJ57GMWEXMZKtL
	 SXgCBzDAED3wvbMF95EtuGMiLFvjkobuglv84d1Pfq7Hbcb1aEWqCMoCUWhFXLf2nY
	 WU8hLpXUEg/RBsPXnIz3y+RZLypjGfx+wnXhVBAgIX58W5Qtd7k9zEMMfrwjXlp1S2
	 Aur4InXuxk95g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEE43809A80;
	Thu, 14 Nov 2024 03:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mptcp: pm: a few more fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173155383073.1467456.7994386444537970996.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 03:10:30 +0000
References: <20241112-net-mptcp-misc-6-12-pm-v1-0-b835580cefa8@kernel.org>
In-Reply-To: <20241112-net-mptcp-misc-6-12-pm-v1-0-b835580cefa8@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kishen.maloor@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Nov 2024 20:18:32 +0100 you wrote:
> Three small fixes related to the MPTCP path-manager:
> 
> - Patch 1: correctly reflect the backup flag to the corresponding local
>   address entry of the userspace path-manager. A fix for v5.19.
> 
> - Patch 2: hold the PM lock when deleting an entry from the local
>   addresses of the userspace path-manager to avoid messing up with this
>   list. A fix for v5.19.
> 
> [...]

Here is the summary with links:
  - [net,1/3] mptcp: update local address flags when setting it
    https://git.kernel.org/netdev/net/c/e0266319413d
  - [net,2/3] mptcp: hold pm lock when deleting entry
    https://git.kernel.org/netdev/net/c/f642c5c4d528
  - [net,3/3] mptcp: pm: use _rcu variant under rcu_read_lock
    https://git.kernel.org/netdev/net/c/db3eab8110bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



