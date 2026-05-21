Return-Path: <stable+bounces-253599-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L58EQIxD2pSHgYAu9opvQ
	(envelope-from <stable+bounces-253599-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:21:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9788D5A925C
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C733328E3A8
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8453655C1;
	Thu, 21 May 2026 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScOHOzKo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A78B35F165;
	Thu, 21 May 2026 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376807; cv=none; b=tElE6WL+UlUOp2b3V7/3SkPu33SaqmZtDgvSmL5vyjTaMslaOvaKe6vXWW2Nr6FG5XBxAXUPO10Hy6kPIzHUMu22PUXfVXvcjXGq+xLj2YsXNk4MSlKsi2e+Sw3X+Mi5MW9Cy4/WmWIpl4Jw6BMg4mB98QYNXVjj54vE/IfPHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376807; c=relaxed/simple;
	bh=2V14SoVMt/6oTcwUOvbDPpEbnH4r3r5k1iaUL6IKKAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pk8cdXI7c71CZAOv4Wjmp2rHz02dfurNuGMQQjBvPTaTj7XsAyocm3QpIajo7nCJfBE4GVJE/vVWwpAJSRhuuFzke5mijW4bVJqW71nuKn5g7x3z2Rmj7jVc+IoMLsm9y0SKl+c6EDOJxq/B77ggHpPYqBI3WBtiQ13+WylI6Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScOHOzKo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0375C1F000E9;
	Thu, 21 May 2026 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376806;
	bh=HRBjW6CFMCjYBV6R40qGK/bxeBfgC2GSre/1fpUBVak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ScOHOzKo9I5J5wltmBUm/ttJugKeD+YB5NjuCu+SAyjrKVwt9uD4F+GZdoZZbz+UA
	 AQUwMjNSV/Jkrbhi05vjeFdn1jx7bNrnItsRNQzS92kS642BoYjW2aLL+OUv1r6XYF
	 xgRR2NbuCQllf+pWHy1f6EmWK/TfrM29Q9SUCjfVeYZFoMZfrg5vrnCNPWLAxY347E
	 MGocnNiz3J5qrhzKPWXrmfOf6keVy6rnCicb+VhMAreFZkf9G1xb3g7a2frN3WX6+p
	 vP4Ib8eGs0bkkv6ZyDzFkjTeijpkITF7myaocU7hUOT3tGpMAiC6ns1YEv7sQKSJZS
	 pSpZC77AGzCZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1994A3930E00;
	Thu, 21 May 2026 15:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937681563.379332.9342112117202162208.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:20:15 +0000
References: <20260520075736.3415676-3-bestswngs@gmail.com>
In-Reply-To: <20260520075736.3415676-3-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 cong.wang@bytedance.com, stable@vger.kernel.org, xmei5@asu.edu
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253599-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,bytedance.com,asu.edu];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9788D5A925C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 00:57:38 -0700 you wrote:
> In the SIOCGIFHWADDR path, tap_ioctl() copies 16 bytes of an
> uninitialised on-stack struct sockaddr_storage to userspace via
> ifr_hwaddr, but netif_get_mac_address() only writes sa_family and
> dev->addr_len (6 for Ethernet) bytes, leaving sa_data[6..13] uninitialised.
> 
> Those 8 trailing bytes leak kernel stack contents; SIOCGIFHWADDR on a
> macvtap chardev returns kernel .text and direct-map pointers, defeating
> KASLR.
> 
> [...]

Here is the summary with links:
  - tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR
    https://git.kernel.org/netdev/net/c/bddc09212c24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



