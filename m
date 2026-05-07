Return-Path: <stable+bounces-244477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC2ZC37r+2kaIQAAu9opvQ
	(envelope-from <stable+bounces-244477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 03:31:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 808034E1F43
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 03:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65BB63028B18
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 01:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7E3221FBB;
	Thu,  7 May 2026 01:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ss0m+OrS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2557D26AF4;
	Thu,  7 May 2026 01:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778117474; cv=none; b=rRP0p/4l8voms6BbWt0feGUdSwv5rFT9262QAFrxDuBTnJAoMgRcpOpK0zKLpWuug5jMRxkpr5MZDOvgEwfYi24ae3jZjExA28wZRjwK0lpz5hb++yNQm1eyEvDVziSzQ+EPQXuTjFY5fIwv4fEC3+kRV0JuSJQOH7EZY+6hMqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778117474; c=relaxed/simple;
	bh=KNR/1UcnqVRthTheFUaU76nP9k370T8nKog7TDR6YVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=paWfzdQ5ADHhZI0nWQWHuyO8RNK1LhEyCA5D9fB8INAip+1GgmXQmjgnGmtHCKFPv3aa1hkRuGHbUP/cWA/3IXYboSzu9mNzgpKKzS+ThrleJsVqnG5L/wzGk2XrQd4Nr8JTSzQ5r/3riV469lMslmlG8Dn79isbiMlxg4W/LD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ss0m+OrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC48AC2BCB0;
	Thu,  7 May 2026 01:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778117473;
	bh=KNR/1UcnqVRthTheFUaU76nP9k370T8nKog7TDR6YVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ss0m+OrShS5624gSh8QZDABIKiwMZsGlm/0Z4nxzaJk4sdqIJ0aQeiwweivL6QfAQ
	 MOupPZYquHMmZ835FfxQlLb0XAzoeNPIBO55GOVbtHvJaEirjyhGQ+sfl1LEcz77gf
	 ZeaJdZQ9gFn6mCfzUjBzE89cA+dKgDZEQAULGy1jEyRbIqjiUlX4MKsU+ThBJ7L0Uw
	 +1y+gZIq7fxgHOLFb7/aUpt7U+Kcqf4s8qRlgH5AhE4rqQDyrYcWRhCK9UqSt9ThpK
	 r2TR7uH+pC2Bm6+qz494v2noa52ElNsmqzW523m9VSGDaP1/DQ9Bw3KMsERooBpk4d
	 AdmBi8bFkkmVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE39393089F;
	Thu,  7 May 2026 01:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/11] mptcp: pm: misc. fixes for v7.1-rc3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177811742303.3291094.15207378562960024252.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 01:30:23 +0000
References: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-0-fca8091060a4@kernel.org>
In-Reply-To: 
 <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-0-fca8091060a4@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 cpaasch@openai.com, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
X-Rspamd-Queue-Id: 808034E1F43
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244477-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 05 May 2026 17:00:48 +0200 you wrote:
> Here are various fixes, mainly related to ADD_ADDRs:
> 
> - Patch 1: save ADD_ADDR for rtx with ID0 when needed. A fix for v6.1.
> 
> - Patch 2: remove unneeded exception for ID 0. A fix for v5.10.
> 
> - Patches 3-5: fix potential data-race and leaks during ADD_ADDR rtx. A
>   fix for v5.10.
> 
> [...]

Here is the summary with links:
  - [net,01/11] mptcp: pm: kernel: correctly retransmit ADD_ADDR ID 0
    https://git.kernel.org/netdev/net/c/b12014d2d36e
  - [net,02/11] mptcp: pm: ADD_ADDR rtx: allow ID 0
    https://git.kernel.org/netdev/net/c/03f324f3f1f7
  - [net,03/11] mptcp: pm: ADD_ADDR rtx: fix potential data-race
    https://git.kernel.org/netdev/net/c/5cd6e0ad79d2
  - [net,04/11] mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
    https://git.kernel.org/netdev/net/c/9634cb35af17
  - [net,05/11] mptcp: pm: ADD_ADDR rtx: free sk if last
    https://git.kernel.org/netdev/net/c/b7b9a4615697
  - [net,06/11] mptcp: pm: ADD_ADDR rtx: resched blocked ADD_ADDR quicker
    https://git.kernel.org/netdev/net/c/3cf12492891c
  - [net,07/11] mptcp: pm: ADD_ADDR rtx: skip inactive subflows
    https://git.kernel.org/netdev/net/c/c6d395e2de13
  - [net,08/11] mptcp: pm: ADD_ADDR rtx: return early if no retrans
    https://git.kernel.org/netdev/net/c/62a9b19dce77
  - [net,09/11] mptcp: pm: prio: skip closed subflows
    https://git.kernel.org/netdev/net/c/166b78344031
  - [net,10/11] selftests: mptcp: check output: catch cmd errors
    https://git.kernel.org/netdev/net/c/65db7b27b90e
  - [net,11/11] selftests: mptcp: pm: restrict 'unknown' check to pm_nl_ctl
    https://git.kernel.org/netdev/net/c/53705ddfa184

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



