Return-Path: <stable+bounces-100826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 809249EDE77
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 05:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C5928198B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 04:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEF915FD01;
	Thu, 12 Dec 2024 04:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahauCRda"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271DD126BEE;
	Thu, 12 Dec 2024 04:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977815; cv=none; b=gw9zDboyYr5RbtrNCQ9/12JoKjoD+/FHdtvVabls/M44vU8t5XSEJnGSP8J8sLiTau5/hN85KQgjM1NSM83cXujKPpEWL92BDx+PSzNy9IvoY5fraXLzWzIIIjHHe03LX+7X/6+JOXWS27U4b9X1sRWk1D7YLhq3pv+fVlf0cAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977815; c=relaxed/simple;
	bh=VyVWym0UcOZvSvQWz5iVZz6QF6qf+TE74PpOyTlvUSc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dt7yLPuLYimGhHdw7nq1wQmSnqPZjL4i5i5+hkV9MB8walKOF6c+Cbeep/5Hb7EeBZwE8zpx8BgkvnKvH2vi+3b3srTUfKKF4b7KkYZwFvvd0CHRF3LzQhShRIz7dJdYG4zWaLTDv2jdCfJVDwJtd22pAJ4YO8gaqVmwPhulHzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahauCRda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A264FC4CECE;
	Thu, 12 Dec 2024 04:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733977814;
	bh=VyVWym0UcOZvSvQWz5iVZz6QF6qf+TE74PpOyTlvUSc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ahauCRdaB+w25fxR4VV7wEmkW+2DLbHexQzySGhhoLHMgb9wK9gFpz256YU7/HqT/
	 MvpapZqiN7EVkT8fsmPD1I8EtsjJMZWjMJSugBBSUit41XlIMN3RxXV4zqgOMCYsQ9
	 rgAR9guLRsDlUGxXNamLI16HW1seicKtyHcYPOFM8XekgtJZH+stqXNN76B9l+58oR
	 voCEyB+2oUsGV7IohaB0znu/QcQiACeLv476x1Kc1SHK8vFcWI3WyB2UOCFUr2bHms
	 xLS8udATRtlcVHcGSoYkqXw3pq78JGLFbWFBh5khJWs7yVwKu+TG7Rhde09b9xJ392
	 u1nwcNIm6Ym5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB29F380A959;
	Thu, 12 Dec 2024 04:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] splice: do not checksum AF_UNIX sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173397783066.1847197.14863491347323512309.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 04:30:30 +0000
References: <Z1fMaHkRf8cfubuE@xiberoa>
In-Reply-To: <Z1fMaHkRf8cfubuE@xiberoa>
To: Frederik Deweerdt <deweerdt.lkml@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com,
 mhal@rbox.co, dhowells@redhat.com, linux-kernel@vger.kernel.org,
 xiyou.wangcong@gmail.com, David.Laight@ACULAB.COM, jdamato@fastly.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 9 Dec 2024 21:06:48 -0800 you wrote:
> When `skb_splice_from_iter` was introduced, it inadvertently added
> checksumming for AF_UNIX sockets. This resulted in significant
> slowdowns, for example when using sendfile over unix sockets.
> 
> Using the test code in [1] in my test setup (2G single core qemu),
> the client receives a 1000M file in:
> - without the patch: 1482ms (+/- 36ms)
> - with the patch: 652.5ms (+/- 22.9ms)
> 
> [...]

Here is the summary with links:
  - [v2,net] splice: do not checksum AF_UNIX sockets
    https://git.kernel.org/netdev/net/c/6bd8614fc2d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



