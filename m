Return-Path: <stable+bounces-200696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE37CB28A8
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 10:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA8F7312A576
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 09:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76091312814;
	Wed, 10 Dec 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unzZsm74"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2722130DEB5;
	Wed, 10 Dec 2025 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358601; cv=none; b=Dj6UEUtYRuC9WoSbf65cDTE375AElyO7VFJxg2i5kKmv0AHl8FZUZMS4wLO7YuBcfqckqJxJjUHTyBzuvDqlC56MAhd5wuy6dlcs8yHhteqU5TaB4VUP/qmwd/e5T6e754IApPJBvTUdUH+XBwD4SPJgIRJLHoZS8QstmYxaNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358601; c=relaxed/simple;
	bh=fQE8Piz7TeTd5PSXjii+oX+LMW5oTzgNtn7GW5Zzx4w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FW1ekb+q75P/1/P9nFbiM3lXk1vx5zrwQZF9Ma1Td01aL+zREH4WhywgeRxqGS2GpUVs15ubAudKZFMM0xDFqFu6BH2TY3ulVFyqKIJEoJ6MwZ+7UISnT0rQfJNj7g5gKWbjkddxubJ5N7wgdAKYWOl/eTVMxnEUvp2eSfemxhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unzZsm74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BC6C4CEF1;
	Wed, 10 Dec 2025 09:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765358600;
	bh=fQE8Piz7TeTd5PSXjii+oX+LMW5oTzgNtn7GW5Zzx4w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=unzZsm74oKaQ1xYbDLy2aiBkW1E17idwIMGYJCXkCMzs603QGnnJIptlSBQzuTQEz
	 xG2IT28SxDOP8aD74l5+hJKfLW1DN8zxR+Q9tD5AMrI2IqqjTgqg8pBpMgru/vIYF2
	 DpJh5qgHwSDbyE43yDyMTiQVwjRa7RAmm/idj2dMIqp7ELYvSrngOz8wPyxoaHWycU
	 TFiNIflwTbNBmXn/cenC/ZW+vphWeoNysVZxn/2spkLGY+yLDAapyfM19kR3ipEdjg
	 ot5TiKv+Na7dKyRVBh5QdFesWTLmPBa3U2bpqF3K/OECwlZ5GpyOfoxlwtNixvzDbM
	 /P+6mCY55Obig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 788683809A18;
	Wed, 10 Dec 2025 09:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/handshake: restore destructor on submit failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176535841527.523551.15411391386973921361.git-patchwork-notify@kernel.org>
Date: Wed, 10 Dec 2025 09:20:15 +0000
References: <20251204091058.1545151-1-caoping@cmss.chinamobile.com>
In-Reply-To: <20251204091058.1545151-1-caoping@cmss.chinamobile.com>
To: caoping <caoping@cmss.chinamobile.com>
Cc: chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Dec 2025 01:10:58 -0800 you wrote:
> handshake_req_submit() replaces sk->sk_destruct but never restores it when
> submission fails before the request is hashed. handshake_sk_destruct() then
> returns early and the original destructor never runs, leaking the socket.
> Restore sk_destruct on the error path.
> 
> Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: caoping <caoping@cmss.chinamobile.com>
> 
> [...]

Here is the summary with links:
  - [v3] net/handshake: restore destructor on submit failure
    https://git.kernel.org/netdev/net/c/6af2a01d65f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



