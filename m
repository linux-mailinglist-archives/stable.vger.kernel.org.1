Return-Path: <stable+bounces-270377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N5UtMIsqRmq2KwsAu9opvQ
	(envelope-from <stable+bounces-270377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 11:08:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 416156F5127
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 11:08:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Z31ohw48;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270377-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270377-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C7CC3071CE9
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 08:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0E442A7B0;
	Thu,  2 Jul 2026 08:40:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1154252AC;
	Thu,  2 Jul 2026 08:40:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981635; cv=none; b=O1JMzX5dYo/rtd4e5+qgTkx4B+jxxjukKIX0p6Qy7PPVWXHKETqrZiWmigIvqYhBp81rQxg6kV/rLjQPeqav3hZrUyXiOaF4x2X7PuHGc9dfpi1aTqFNaojw0MA3pq6qAPKFxYCvKTpG/qn32I7EL03wFhgFkaOb+M0uYpb2WXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981635; c=relaxed/simple;
	bh=yuVvnNvmdroiJgYw20TjscVBCKSeqxe8hsnlki8dNsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gD5GB+aaZN4ZsypVtk3nsTZ+ear3QsQ4ntW7MqJ1Tm3RZJfUtAEgW0sWHC0OBg4i6Z7Ubpx08V3QMvAJBWvQZ3lXbIhhQbdOyHfhk23K3UGJKbdi+5FgVu7y3p4IF1HGhw719fD93kKCtvZg8o2TDKZLL6nJmvK6vqxBlfZ+Syg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z31ohw48; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3101F00A3A;
	Thu,  2 Jul 2026 08:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782981631;
	bh=8VMSXycOlH9NOdnFXl3zUFIjdbZj01HF3XqLUjhwnBE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z31ohw480/a+WZo5w5EtGFtkYcOU1iUyJYJv7BmItjzGwbOECslT1FWeCTQ28wtrz
	 2pSTwQ/FcVhfh6FnolFmA+J6vSVec9vuIaI3Ipb0iqbgAjquqaec3K2HpaWlFRJeVj
	 h9urMOP0fijHjMVXGZh64j9UQqFCfy2A/JbFgHMmgi0VBBYxhcwynHkKlKSP1mbeK9
	 bofT7WRBT2M1UWuCqcQrLpOoAJw+6mhvgo3Ta+D6i077um3QpV9xUQXlKJ9MC5tM6B
	 JmRjicF1lA9yyLdE08SgA34efQ/2Cuv0UaQwyXm/SWN93BOL6yQ9rWee2sKaUWQv0U
	 jcnDFSDM6R2jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5688D3926664;
	Thu,  2 Jul 2026 08:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/6] batman-adv: retrieve ethhdr after potential skb
 realloc on RX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178298161396.1523446.3039520497502044353.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 08:40:13 +0000
References: <20260630134430.85786-2-sw@simonwunderlich.de>
In-Reply-To: <20260630134430.85786-2-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270377-lists,stable=lfdr.de,netdevbpf];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,narfation.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 416156F5127

Hello:

This series was applied to netdev/net.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Tue, 30 Jun 2026 15:44:25 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> pskb_may_pull() in batadv_interface_rx() could reallocate the buffer behind
> the skb. Variables which were pointing to the old buffer need to be
> reassigned to avoid an use-after-free.
> 
> This was done correctly for the VLAN header but missed for the ethernet
> header which is later used for the TT and AP isolation handling.
> 
> [...]

Here is the summary with links:
  - [net,1/6] batman-adv: retrieve ethhdr after potential skb realloc on RX
    https://git.kernel.org/netdev/net/c/035e1fed892d
  - [net,2/6] batman-adv: access unicast_ttvn skb->data only after skb realloc
    https://git.kernel.org/netdev/net/c/7141990add3f
  - [net,3/6] batman-adv: gw: acquire ethernet header only after skb realloc
    https://git.kernel.org/netdev/net/c/77880a3be88d
  - [net,4/6] batman-adv: dat: acquire ARP hw source only after skb realloc
    https://git.kernel.org/netdev/net/c/48067b2ae450
  - [net,5/6] batman-adv: bla: reacquire gw address after skb realloc
    https://git.kernel.org/netdev/net/c/cdf3b5af2bc4
  - [net,6/6] batman-adv: dat: ensure accessible eth_hdr proto field
    https://git.kernel.org/netdev/net/c/26560c4a03dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



