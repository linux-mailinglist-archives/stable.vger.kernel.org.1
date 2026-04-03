Return-Path: <stable+bounces-233242-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKGYK+dC0Gk45QYAu9opvQ
	(envelope-from <stable+bounces-233242-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 00:44:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A57398D3A
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 00:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 241E73045AAD
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 22:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D42C31B101;
	Fri,  3 Apr 2026 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXtpXNNH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDC0314D34;
	Fri,  3 Apr 2026 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775256026; cv=none; b=EuWzuV1kAR1Nr97xxqXP571RL3FJOQ5nU1ZG/pj4BPQ14BIvPUD+fM84cfef+h3nI2ekibCx46KWt1jiD7r3X/OD+F6cIW05Ipgz9pCB6NS7mgVZ32NrGIdy3xgThBjMgPctJTS30LveQxaJvdPt162Ayv2ih2BTCQTgUnMtiL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775256026; c=relaxed/simple;
	bh=NRwUQxbnX47EhQ/5fV/mrQtkLbjo3YGJ9fBU0uqRu5g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=suRyi5mGtUzUhNmKSquzkpFnYj14u2B8qhB1XQmVMfZRAnjFlanhUv21ZG4Fa9pPajocPXWUczokNR/AJap6lc/os3VMy1d3rzWBOeO+vE7FO+NCKUeViiNJLiIqQ46gHbNaCNEKqxw8M5QY2isamhhIP7MLuVGTvwkEQWsfsA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXtpXNNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE44C4CEF7;
	Fri,  3 Apr 2026 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775256026;
	bh=NRwUQxbnX47EhQ/5fV/mrQtkLbjo3YGJ9fBU0uqRu5g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rXtpXNNHLPGRO5A19k0lxxFpMjAVhc+Mk89IHPgm2NFA7NemGO6/Q7g7Mae3iqWS2
	 awy2UJbya65l4YzNSc/d9Qj5Zy4pc65/2iEIB6sBSFfUT3lwikyxJvVHjTYTgpcJ+f
	 l0L8oIla7tkGrr5ZeWMRU2RosxewavWmK2D7WSMY51Gu2tyTnjk8uXxU7D9cXWfCwC
	 U05HwZU60KR0ECWJNMdbSomui/mpKEJ6uJHykTlOIZp06ljX5is4vk86zoble24D1k
	 5rfOQ2GZbuaLrl4A7X01/sqOPmdOQ6JtqcgKM3vpCi82lA5buaPBDiRqBLVTw9LH8l
	 F+OIxrJDxX0hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DDC3809A14;
	Fri,  3 Apr 2026 22:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] tipc: fix bc_ackers underflow on duplicate
 GRP_ACK_MSG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525600728.1477337.10729716118426836101.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 22:40:07 +0000
References: <41a4833f368641218e444fdcff822039.security@1seal.org>
In-Reply-To: <41a4833f368641218e444fdcff822039.security@1seal.org>
To: Oleh Konko <security@1seal.org>
Cc: netdev@vger.kernel.org, jmaloy@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-233242-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50A57398D3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 2 Apr 2026 09:48:57 +0000 you wrote:
> The GRP_ACK_MSG handler in tipc_group_proto_rcv() currently decrements
> bc_ackers on every inbound group ACK, even when the same member has
> already acknowledged the current broadcast round.
> 
> Because bc_ackers is a u16, a duplicate ACK received after the last
> legitimate ACK wraps the counter to 65535. Once wrapped,
> tipc_group_bc_cong() keeps reporting congestion and later group
> broadcasts on the affected socket stay blocked until the group is
> recreated.
> 
> [...]

Here is the summary with links:
  - [net,v3] tipc: fix bc_ackers underflow on duplicate GRP_ACK_MSG
    https://git.kernel.org/netdev/net/c/48a5fe38772b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



