Return-Path: <stable+bounces-241794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIYgLAhk8WnhgQEAu9opvQ
	(envelope-from <stable+bounces-241794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 03:51:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 498F748E198
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 03:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E7DD3022A99
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 01:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58EF359A68;
	Wed, 29 Apr 2026 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pe1MPdgp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4E33CEB0;
	Wed, 29 Apr 2026 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777427455; cv=none; b=ToL0FdQcW3CZTowzJ/jk/1Cmlj0FqOYhTycWMMpZKUaRbjvXfzZh1kJKXQ6OUGI5KVOhPY/u+OWFlXbp7feSlmvgy2yXwriuAuSEtS+PEggWQQkftwH3GMW61gVEe/odDDgpVLhVNSsbQfhYUfTysfI14OnMvnKOxgDA3gmlQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777427455; c=relaxed/simple;
	bh=INbXNf2q6MmeJIX0oGNkmmY+3fO27A1j0CNgV9qd/tk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HP1DlxqXGj4WHmtPKvyOf4UwFfjrEIdk2PVdubTT9KBq72JKmVrrOK6DmmSUvMXIEoAapg4H0HgCDo7bQ8j+IF8d1tqz7wC0RU1wJIanyltRz613iM4nnr3cTcV4gJW95mL3KCXCFpILun562dJgKfDMAf00HpPtcw2ks+sPqsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pe1MPdgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F16C2BCB7;
	Wed, 29 Apr 2026 01:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777427454;
	bh=INbXNf2q6MmeJIX0oGNkmmY+3fO27A1j0CNgV9qd/tk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pe1MPdgpgiLhcCA6RhSfk4qrj9/fC69pI1oywMecUUdf1ru+Q2O5G52/id3L/QqmV
	 2DNGvAbqU8JWlsmwOhJinUk+usYV4rGhOuhnYa1vqcIebAhnSBpsb7a5oCmL9xa3RS
	 mlSU6/WK8dQ/LOoCutl7J50EJVWWLmF2zAkvDlv1yIjBR2c2ETzk06FwRL69Ig17jf
	 UP2/IYg3sLDeoAtmz1pEBA3fzk/992PjmF0+oP+ulsO3FlH4M3fKQmaQyjorPc2wJW
	 GghelHFi8n1dmkuFn7zCueUHBxLEps1VrHHX3zBfjm8QHknXgnV+/NsEP4ayxql5SM
	 tOpIG4nYeucQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD8639302C7;
	Wed, 29 Apr 2026 01:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mptcp: misc fixes for v7.1-rc2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177742741105.1295091.8893336213893309310.git-patchwork-notify@kernel.org>
Date: Wed, 29 Apr 2026 01:50:11 +0000
References: 
 <20260427-net-mptcp-misc-fixes-7-1-rc2-v1-0-7432b7f279fa@kernel.org>
In-Reply-To: 
 <20260427-net-mptcp-misc-fixes-7-1-rc2-v1-0-7432b7f279fa@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, yangang@kylinos.cn, stable@vger.kernel.org,
 sashiko-bot@kernel.org, lance@lance0.com
X-Rspamd-Queue-Id: 498F748E198
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241794-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Apr 2026 21:54:32 +0200 you wrote:
> Here are various unrelated fixes:
> 
> - Patches 1-2: set timestamp flags on 'ssk', not 'sk' (typo); Plus do
>   that with sleepable lock_sock/release_sock. A fix for v5.14.
> 
> - Patch 3: respect SO_LINGER(1, 0) by sending MP_FASTCLOSE at close time
>   as expected. A fix for v6.1.
> 
> [...]

Here is the summary with links:
  - [net,1/4] mptcp: sockopt: set timestamp flags on subflow socket, not msk
    https://git.kernel.org/netdev/net/c/5f95c21fc23a
  - [net,2/4] mptcp: fix scheduling with atomic in timestamp sockopt
    https://git.kernel.org/netdev/net/c/b5c52908d52c
  - [net,3/4] mptcp: fastclose msk when linger time is 0
    https://git.kernel.org/netdev/net/c/f14d6e9c3678
  - [net,4/4] mptcp: pm: kernel: reset fullmesh counter after flush
    https://git.kernel.org/netdev/net/c/1774d3cf3cf1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



