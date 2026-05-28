Return-Path: <stable+bounces-256447-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHmiIczUGGrSnwgAu9opvQ
	(envelope-from <stable+bounces-256447-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:50:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 256835FB861
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24B4A3046EA6
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC876367F36;
	Thu, 28 May 2026 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCZDp3/T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC42C11F1;
	Thu, 28 May 2026 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780012212; cv=none; b=IGvTlUNJM8QiRM5PabGduz9W5cTFnU1GU9WYziBdFPidBWj0lw1vOFYieS1B4AgjTqsD/AzIbaYBY4NbcAp3j2s8ZjB8O9MC0MERRZY/1/0uYnQA2Q2tALMXt0c1PbDdpvII2IOBmwP6cPdCwflmeRS5ITXoJdz1jxkJigzqSQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780012212; c=relaxed/simple;
	bh=3FV31BSp+eZqefLczGdAKfSOo39mSALwfTNRoZu5iVk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kz0y2YMbuYf7E6pAKl5Mrga5FjzFYYEv099iH2mYIqtDg6voXmGAJbyqFwQ5h1VrmHjJ06ZXOuQznPv2rtxIJFBKcn3s1xGJlxqHFU96DF/r3PgC79w0RrNwgL7jkEYMLOeIvyMFlinfnChAXxMzd9kSbkhX5TGmmrVocxJ0Hhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCZDp3/T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0541F000E9;
	Thu, 28 May 2026 23:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780012211;
	bh=sY1IZ5Apy/pfqZgdmnIxpk47YIf5ZV18RMEp+0ZQZYc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BCZDp3/TphHAvs8dLhWXG+AO85OFHAXgX0ezSuOgwD/hzlzCKNM1Mz6EYR5o4DTA4
	 hhvXdo5HTEJ8+LWO0USULD0yToQzM+oSrtKiExKDzFANsSzj6geH2SPlYRUJk9jZ+B
	 IiMgd1EiGX2n9FJfH6Ovg2be+A/JXCwhWrBi1JVaSVAbaVeww2f5h3kBS/EEVhBmHo
	 h9IOeAhjmHM9Avr3J8Hmhp7NMY8Uc+9h7Cc67Lv9MZCtWYkjU9i1K/D4HyrsT/8aA1
	 XAcf1jmrp6I3uOvGU5bLHhyCZUAFEGEOXEuNpGlHqpcqjQnr2bDHAF5PqcdLJmIqGf
	 CD0ck79EObpvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93E733811979;
	Thu, 28 May 2026 23:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] selftests: mptcp: reduce bufferbloat and cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178001221513.1560944.5184668372188033491.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 23:50:15 +0000
References: 
 <20260527-net-mptcp-sft-bufferbloat-exit-v1-0-9afc4e742090@kernel.org>
In-Reply-To: 
 <20260527-net-mptcp-sft-bufferbloat-exit-v1-0-9afc4e742090@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, fw@strlen.de, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256447-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 256835FB861
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 22:11:33 +1000 you wrote:
> Bufferbloat is baaaad, even in our selftests: let's kill it (or at least
> reduce it). By doing that, the tests (seem to) have a more stable
> transfer, and are then less unstable. That's what patches 1-2 are doing,
> and they can be backported up to 5.10.
> 
> Patch 3 is not related: a small fix in the selftests to remove temp
> files that were not deleted in some conditions, since v5.13.
> 
> [...]

Here is the summary with links:
  - [net,1/3] selftests: mptcp: simult_flows: disable GSO
    https://git.kernel.org/netdev/net-next/c/0f1fd73c2204
  - [net,2/3] selftests: mptcp: simult_flows: adapt limits
    https://git.kernel.org/netdev/net-next/c/b7c746a8eeea
  - [net,3/3] selftests: mptcp: sockopt: set EXIT trap earlier
    https://git.kernel.org/netdev/net-next/c/c8da80af2838

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



