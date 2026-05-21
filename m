Return-Path: <stable+bounces-253587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJFTD2MfD2p2GAYAu9opvQ
	(envelope-from <stable+bounces-253587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:06:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FA95A7E78
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF3B9303F20A
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEA436896D;
	Thu, 21 May 2026 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oII1NBAu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3207E365A0B;
	Thu, 21 May 2026 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375009; cv=none; b=iqkw1Jw6PZCJRpaB72Jt4QjzXXTg3trCjNvl8GXLPya8jt7fL/zcQAgz+M0RgBCtMDyoXhu4gWBpuubfJ4i2pNq67Zn2T8fCkYQ9UnY2dqpT72oWmBEbEWk8Trq5dq4/Z+wkFzeLGNDR5TSdH7w1fCXgyaNL08A1JzwTB5v3mkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375009; c=relaxed/simple;
	bh=kr5DCfDLze2bL0bMq4RX8rk/tZWf0JchX0ei7zNmgtM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Elop2lhyFi4t6av7BP2k9yNK2ymjCg1fpPEH03S695D7LJ793M8IviFGhf0n6Rg7pPTiJ/DVsObUhuNH/aRLSicYityq+ETWXavbxGHJqp8CrGZiw2Ly0xeWS4eYT3jWKeDZxlOlv/tcsyD/d2wHjfxqkfOI+tW5DZVysyzIkvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oII1NBAu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92061F000E9;
	Thu, 21 May 2026 14:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375007;
	bh=3YfRdDSvMV6JRnlKEL6wB1iZXSalX1399J5l7yHyJ3o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oII1NBAuoDXfGG5kMu6uesLvs3gxeEtQKu8nFHOVu+O5EHnygAzyPZeO5o2r6B1cL
	 EkBAT3tZnrykUpi2zBl1dt/9hByBD15S1QkCKP01EtBP1KFXBJjjv+vBzZaRM/moxO
	 qges17ZOSvGtzZ5klb6zwL0fXIYzsykFuOmrsvoJD6OeHQxz+l2QfJPBlGdQQwLoeq
	 AUMfiS5lzMj2Ln0gnzeG2Bb8LwdwgWKq02ZDx6Di1B7kYz6FB4BRiVReMoti8EOQUv
	 rTgqXrl8INqVGprqJtoheiSjPQ+qysorIWkQ9CFj0HQqw5QACGxfh4AErPIz2ARrPn
	 t1h4KNMg0hUNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A6D3930DF1;
	Thu, 21 May 2026 14:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] phonet/pep: disable BH around forwarded
 sk_receive_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937501739.361786.17790917589741494228.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 14:50:17 +0000
References: <20260519172635.86304-1-yzjaurora@gmail.com>
In-Reply-To: <20260519172635.86304-1-yzjaurora@gmail.com>
To: Zijing Yin <yzjaurora@gmail.com>
Cc: courmisch@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253587-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D4FA95A7E78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 10:26:33 -0700 you wrote:
> The networking receive path is usually run from softirq context, but
> protocols that take the socket lock may have packets stored in the
> backlog and processed later from process context. In that case
> release_sock() -> __release_sock() drops the slock with spin_unlock_bh()
> and then calls sk->sk_backlog_rcv() with bottom halves enabled.
> 
> Typical sk_backlog_rcv handlers process the socket whose backlog is
> being drained, so the BH state at entry is irrelevant for the slocks
> they touch. pep_do_rcv() is different: when the inbound skb targets an
> existing PEP pipe, it forwards the skb to a different *child* socket
> via sk_receive_skb(). That helper takes the child slock with
> bh_lock_sock_nested(), which is just spin_lock_nested() and assumes BH
> is already off. The same child slock therefore ends up acquired with
> BH on (process path) and with BH off (softirq path):
> 
> [...]

Here is the summary with links:
  - [net] phonet/pep: disable BH around forwarded sk_receive_skb()
    https://git.kernel.org/netdev/net/c/dbc81608e3a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



