Return-Path: <stable+bounces-215784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNyWDwxmjGkFmgAAu9opvQ
	(envelope-from <stable+bounces-215784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:20:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EF1123D0F
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 321823040223
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 11:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74CD36BCD7;
	Wed, 11 Feb 2026 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFBY8fMt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6937A23D2B1;
	Wed, 11 Feb 2026 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770808810; cv=none; b=M0k4YfIAct8kuyovVSvPvClHv1GGQenGjPQxdQZEgil0cbWXNKT/KK9DCiuISkxz/79QWl6Yvw7+/GpN4bOw+CvKjF3hRgU52nd5RJ4l1K26aR1ehPMxwaoNpalderwKcRHnagVLmMQfrOP/Ae8HvV8OxQU6TTzgs73U07Q7ZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770808810; c=relaxed/simple;
	bh=k+LlXw1C3o/u3PJNQjJdZQd9L+G36yIsBL61Zjxh/r0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t0uiaDAMGDy7jP1Rvtcx7Rv2kszA0+Ao3Nc3nhXCQn96yD7/f3yOnpGYbt1u9a39CCiNQ5cv5u/L6TGpDsqDpazkR9iL5fvx+vWnli3F4hFsmmS66kRExsIghO1XzUW4K9o1OFneqI68dYOWc/hGS9b9uOdCxAeTsbueKAxdnZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFBY8fMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0DBC19421;
	Wed, 11 Feb 2026 11:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770808809;
	bh=k+LlXw1C3o/u3PJNQjJdZQd9L+G36yIsBL61Zjxh/r0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qFBY8fMtX7nw+as48of6bugZPUqSlE70WtvenkdA1JVP4Id9fabQ/l49wWnO3fOs/
	 dfgyWwi8Td+zdlf+LHF5Nni/9SQ5wGBTZcCgKp9BbEZ8HaJr2iKtamgSTR9tdMkaeO
	 kOldR7wAidQ9Uj/kRBwRLJTrtpfa0LXgvLSVhI2BQAjabcfRI8pgomeq1IRnx9lXGO
	 obAqyO6ZzDNYltPTCR3SColZ5uDFKcmpVb0k64dTwgvwkl/i20NXdUbBP+wHHdAItB
	 gHtz2KArsp7wFor6pdi5a3tjyqy1uVjp2wIYu42kZ0847tDi6joBH3CmSiCTg8UpQe
	 hraN8Z6RCUuMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B19E39E9615;
	Wed, 11 Feb 2026 11:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Add optional dependency on
 HSR
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177080880483.132566.10272956860810169703.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 11:20:04 +0000
References: <20260207-icssg-dep-v3-1-8c47c1937f81@gmail.com>
In-Reply-To: <20260207-icssg-dep-v3-1-8c47c1937f81@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rogerq@ti.com, pmohan@couthit.com, danishanwar@ti.com, arnd@arndb.de,
 s.hauer@pengutronix.de
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215784-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8EF1123D0F
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 07 Feb 2026 14:21:46 +0800 you wrote:
> Commit 95540ad6747c ("net: ti: icssg-prueth: Add support for HSR frame
> forward offload") introduced support for offloading HSR frame forwarding,
> which relies on functions such as is_hsr_master() provided by the HSR
> module. Although HSR provides stubs for configurations with HSR
> disabled, this driver still requires an optional dependency on HSR.
> Otherwise, build failures will occur when icssg-prueth is built-in
> while HSR is configured as a module.
>   ld.lld: error: undefined symbol: is_hsr_master
>   >>> referenced by icssg_prueth.c:710 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:710)
>   >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_del_mcast) in archive vmlinux.a
>   >>> referenced by icssg_prueth.c:681 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:681)
>   >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_add_mcast) in archive vmlinux.a
>   >>> referenced by icssg_prueth.c:1812 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:1812)
>   >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(prueth_netdevice_event) in archive vmlinux.a
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ti: icssg-prueth: Add optional dependency on HSR
    https://git.kernel.org/netdev/net/c/e3998b6e90f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



