Return-Path: <stable+bounces-249594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDz9G9ZqDGo8hQUAu9opvQ
	(envelope-from <stable+bounces-249594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:51:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C3A58005A
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90950302A19E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B43371D10;
	Tue, 19 May 2026 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgEsuRVu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833382745E;
	Tue, 19 May 2026 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198603; cv=none; b=F4MP9WcmDbaDwkWLILaYPa6eWq+Eo2WgyoZ63K6s3f3l/0DmTlQUw4MC6UuRhGAh2y4IiCNfkt/vWMSZiD5aucakJVyt9DQ+arYs8jO2jJemiDJaxpsnfF6NHpfbtr9Q1tP+oSxG01Q2pX+RIFiK8mZ9Q1DvRqAujNIREzYkApk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198603; c=relaxed/simple;
	bh=m+pY3QiSglJPlMXpIGOaMIyHI2LjEnBNWUyr/O9b6ZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DC5j5+tI+lckoR3yv8lzw9UjFMSIgc06FIA7eJqFh+5GSE9crX4PV/SwktkXOx+2nw0PW2x2LpNbJVyeSzn/gQwlW7hF2zr6FJCfz5yqfHBcP40SyPmbktGArQM5pW1tOxqAuXBrBF6443cM4XVS4V8LJ174zfYIODiRH/lQR9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgEsuRVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D47C2BCB8;
	Tue, 19 May 2026 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779198603;
	bh=m+pY3QiSglJPlMXpIGOaMIyHI2LjEnBNWUyr/O9b6ZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UgEsuRVuixNoeuKu8FRw3OiOYMA24BLRy/ROCKicacU0OVqc7fgCaM4rGq/dJk2Sr
	 V6jmobj1r1phyHw0uSxTmXvLVWDyqbAmigFQgFL7qP6aHtU0x61bvN+5DFaI8wzClc
	 pmjW9+Lmg77Ywn2vUd0AR8r4aGi4LAytQ68+wywuCy8dvFObAj/p/Hp9FEHKsytZkj
	 urosy1g8zxyO9mQNh4tHUU3k+WTjID0M8tMWvMvTIWsvDZ5sWT5qZW3uvof8l2Ee7n
	 so++/J+uASkJTKmCnPHG+ZMY5dcRtI0DksIyLv24phiMllwnEyKe5DblxpM3xff6Ui
	 I6HLjhjJiynaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BC03930E1C;
	Tue, 19 May 2026 13:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/6] mptcp: misc fixes for v7.1-rc4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177919861414.2727096.18153196932164930463.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 13:50:14 +0000
References: 
 <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-0-701e96419f2f@kernel.org>
In-Reply-To: 
 <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-0-701e96419f2f@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 edumaze@google.com, shardul.b@mpiricsoftware.com, stable@vger.kernel.org,
 lixiasong1@huawei.com, yangang@kylinos.cn
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249594-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 30C3A58005A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 15 May 2026 06:27:31 +0200 you wrote:
> Here are various unrelated fixes:
> 
> - Patch 1: avoid dropping partial packets. A previous version has been
>   sent a few week ago. A fix for 5.10.
> 
> - Patches 2-3: stop ADD_ADDR timer when an ADD_ADDR can never been sent
>   due to insufficient option space. A fix for v5.10.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/6] mptcp: do not drop partial packets
    https://git.kernel.org/netdev/net/c/50c2d91c5dfa
  - [net,v2,2/6] mptcp: pm: fix ADD_ADDR timer infinite retry on option space insufficient
    https://git.kernel.org/netdev/net/c/51e398a3b896
  - [net,v2,3/6] selftests: mptcp: join: cover ADD_ADDR tx drop and list progress
    https://git.kernel.org/netdev/net/c/fc5ef4331810
  - [net,v2,4/6] mptcp: reset rcv wnd on disconnect
    https://git.kernel.org/netdev/net/c/0981f90e1a05
  - [net,v2,5/6] mptcp: update window_clamp on subflows when SO_RCVBUF is set
    https://git.kernel.org/netdev/net/c/3a543ae0e209
  - [net,v2,6/6] selftests: mptcp: drop nanoseconds width specifier
    https://git.kernel.org/netdev/net/c/01ff78e4b3d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



