Return-Path: <stable+bounces-272852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9dsaJLpqT2pwgQIAu9opvQ
	(envelope-from <stable+bounces-272852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 11:32:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0668E72EFC1
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 11:32:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kCNUL24U;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272852-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272852-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A72553197DCC
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 09:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746CF40314E;
	Thu,  9 Jul 2026 09:20:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDD3401A3B;
	Thu,  9 Jul 2026 09:20:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588844; cv=none; b=EyDeA6b7q8/VMSuKw5w8bCGxz/8FGDWSXrZwWGzDFBgqifyslgSjwLI1PMJ3Hjru0EFnKGhuWHFS1to9okM69cwfzfZDtSbJoPTRy+pkDIfUNOKNGJhTbSlPsd9G1Zm6LNiSUUOQf7E2OrQRrfdNt6kWdOhFh2lAqbj5OCQZTTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588844; c=relaxed/simple;
	bh=FrzLWWdqcRrv5gVMZcsezR+LdPa7lbMl3s5asLemMQI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZsPw4SYgxiMO4Utb4foPQlngVjU9tB85UzUZRTdj2i0ySl8jWdYKQTn3nux02hcVy9LUnuL+kLuqngG4vxBNvDZv+YMeWc4uPCoyCYzRX25N7PVC3qvDBZwhuXTp80FEclQrOq8HACNWNKHt7O83VYXb84X5nCN3wnzezzKOSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCNUL24U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA661F000E9;
	Thu,  9 Jul 2026 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783588842;
	bh=K3oDSCq0e8fq1E3kfwxiBNJ3XGysx97IQDwhOEiZyFI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kCNUL24UMlODqSOgMyE/UcsKJA04LYuGHy1ArpYvMMQFDRq5lvSjSBuxc4UpvEw3B
	 dY0G0nqr9bdQa/rEkWk5tYJmsAx+qJbjg/nL9efqMP7CHYfwu+ESyos8IShg66DLjr
	 osoXJeAgcI54NaSBfBFLpLvCX4SPgTpD1D822y0o4OA3HPKfnPHtpb3eO77RVAeqG3
	 DKK97htGTLU3wnQ0+AH/baFwbrIeFo+1+CyhbcuoQJthICjM2F6Gap4/Em1P7JJx3g
	 VXqGU1buhU4uU9eKJzdLRG6Q+UX/oIS+jCTQmb5JYsloojheoLkcaANuKUsjGSudFv
	 2YlbQDWKo+RRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939F3393A564;
	Thu,  9 Jul 2026 09:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/9] batman-adv: ensure minimal ethernet header on TX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178358882114.3359576.16875111531041578494.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 09:20:21 +0000
References: <20260708091821.314516-2-sw@simonwunderlich.de>
In-Reply-To: <20260708091821.314516-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272852-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sw@simonwunderlich.de,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:stable@vger.kernel.org,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0668E72EFC1

Hello:

This series was applied to netdev/net.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Wed,  8 Jul 2026 11:18:13 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> As documented in commit 8bd67ebb50c0 ("net: bridge: xmit: make sure we have
> at least eth header len bytes"), it is possible by for a local user with
> eBPF TC hook access to attach a tc filter which truncates the packet and
> redirects to an batadv interface. But the code assumes that at least
> ETH_HLEN bytes are available and thus might read outside of the available
> buffer.
> 
> [...]

Here is the summary with links:
  - [net,1/9] batman-adv: ensure minimal ethernet header on TX
    https://git.kernel.org/netdev/net/c/49df66b7993c
  - [net,2/9] batman-adv: fix VLAN priority offset
    https://git.kernel.org/netdev/net/c/fdb3be00ba4d
  - [net,3/9] batman-adv: clean untagged VLAN on netdev registration failure
    https://git.kernel.org/netdev/net/c/8669a550c752
  - [net,4/9] batman-adv: tt: avoid request storms during pending request
    https://git.kernel.org/netdev/net/c/27c7d4000823
  - [net,5/9] batman-adv: tt: prevent TVLV OOB check overflow
    https://git.kernel.org/netdev/net/c/7a581d9aaba8
  - [net,6/9] batman-adv: frag: free unfragmentable packet
    https://git.kernel.org/netdev/net/c/6b628425aed4
  - [net,7/9] batman-adv: frag: fix primary_if leak on failed linearization
    https://git.kernel.org/netdev/net/c/353d2c1d5492
  - [net,8/9] batman-adv: mcast: avoid OOB read of num_dests header
    https://git.kernel.org/netdev/net/c/38eaed28e250
  - [net,9/9] batman-adv: dat: fix tie-break for candidate selection
    https://git.kernel.org/netdev/net/c/98052bdaf6ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



