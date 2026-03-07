Return-Path: <stable+bounces-223404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CwqJQKCq2mwdgEAu9opvQ
	(envelope-from <stable+bounces-223404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 02:40:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5F12296B2
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 02:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2C993026150
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 01:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEA52EC54A;
	Sat,  7 Mar 2026 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEwJy3oA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE862C234B;
	Sat,  7 Mar 2026 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772847611; cv=none; b=ox8rh12bAlGkftSBaxsRZFmQ5iEGoEu35Ad/wSZvwjXKHtGIHHiFa7BwsUeDXJ0xZj9ObcIYl57by9j5tP0L5OrU0XFKrp3dn389NauXv8ojpkrFH4egNO8FwVikLQyUVq+oBAgjIaL8GOiCn9f7pjCfDPSOkd2W+Z9SQRVtTSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772847611; c=relaxed/simple;
	bh=mgMRBhHY0rQ04G43pB4XKXWyiH/QkT6t6BUb4NAq4T4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l8YwBdxpKmZxw7sKhWn1V2w63aha+RmEKvHqRQbULSIjkC+xzTO/jN3vnMvZSjtmHJwRpdCJAxT2Tov0oyefw9K8Zg4bGxcHnWoAvJJ1Y3ZdMCptuTSBJmd98QxCfFpkDFpL91hcQVb+rYbEo5oiSaNvo6f2jlyupNLvhIT4SwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEwJy3oA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33291C4CEF7;
	Sat,  7 Mar 2026 01:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772847611;
	bh=mgMRBhHY0rQ04G43pB4XKXWyiH/QkT6t6BUb4NAq4T4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZEwJy3oArxinktXVjvYFXp7h/PRX/nnavhqD6q7Ad120ICKM/mBI8H9Y4PGzCaItt
	 Z6iWe4jCl6z/P77ygJWhYTYxLzb/E9l54eui8bTZD7HKrEfdhEsN4z2jl1Bs2jhAV6
	 4kEIVhCAoDX+SvFI99GnzhC2mIkMb+GGyrJ2SMVNdondMuZmtFK2yqOSYWd52iQIT7
	 AWGXhv2koJ5rRV3bJb7LScCYaToclQeOSu1ZlwAkGUGDifBjaSXU1pCmuCqcWg9/XS
	 S7+p/6qVYpLLJh8r5fq3UO9BX97Ylj2dxmqk5r0t+nmbN1TcnpJAqd1WH5ngfQcZlI
	 xWs+ijGSHc2Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE4B3808200;
	Sat,  7 Mar 2026 01:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ncsi: fix skb leak in error paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284761030.119780.6748764252279562099.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 01:40:10 +0000
References: <20260305060656.3357250-1-zhangjian.3032@bytedance.com>
In-Reply-To: <20260305060656.3357250-1-zhangjian.3032@bytedance.com>
To: ByteDance <zhangjian.3032@bytedance.com>
Cc: sam@mendozajonas.com, fercerpav@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 joel@jms.id.au, gwshan@linux.vnet.ibm.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Queue-Id: EA5F12296B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mendozajonas.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,jms.id.au,linux.vnet.ibm.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-223404-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Mar 2026 14:06:55 +0800 you wrote:
> Early return paths in NCSI RX and AEN handlers fail to release
> the received skb, resulting in a memory leak.
> 
> Specifically, ncsi_aen_handler() returns on invalid AEN packets
> without consuming the skb. Similarly, ncsi_rcv_rsp() exits early
> when failing to resolve the NCSI device, response handler, or
> request, leaving the skb unfreed.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ncsi: fix skb leak in error paths
    https://git.kernel.org/netdev/net/c/5c3398a54266

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



