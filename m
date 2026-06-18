Return-Path: <stable+bounces-266944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9lQPF+g5M2oG+gUAu9opvQ
	(envelope-from <stable+bounces-266944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 02:20:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C750A69CDC2
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 02:20:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UlDs+0Pz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266944-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266944-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAEFF301CC18
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 00:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA131E5018;
	Thu, 18 Jun 2026 00:20:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8740D56F;
	Thu, 18 Jun 2026 00:20:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742053; cv=none; b=pLzxQ0GPlbpUHc+GDpftVrCgGOoaiV9a9iuq45cFJJIPeu6gUjl9wS6zy5cd31bU3EttWpIPszMFMjxZ39AveVjKHuNBUU+bMXfW+gwFGpFCntE1s6If2Z7c3RVn86cGhtzbW0zpvZaqES2i3A9b61aYd/n6+EXDBKCFuR+DvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742053; c=relaxed/simple;
	bh=UyhPkMo5Y/BP63lFwoyKLSVfjlF0W+UvSyHIa+nwoM4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bX7m7QDWZagAa6yYXkm68gvtlqwqHN2vSNxqgDjebXYY+JwG5VmGdC56c9Yz4s41Pz7pOBfIRjhCA3MyGq9cRTZvlKB5xNBGa+msOVMrvh8uFwbsFaBVcOoEhrKA7NbJxTiV59r+y3cMd+qKTpymA3G3TwWWbXuGDM0gl4KfLdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlDs+0Pz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECC11F000E9;
	Thu, 18 Jun 2026 00:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781742052;
	bh=xbiTg0JHE9z1MkGTCI98wP/VzjJo4Nkx2G3Y72iNgF4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UlDs+0PzlR8GazTiOHWyLjVBHi9ykq5gu+M+kBYPWqO/yTfZA8P48AycX5LFVrNhb
	 FjIxdY7AMwybQzgwlI/I2uhXt3QuZF9xJVfPdYceC5NWf9eZ7L1fdiX+5egsim7pNx
	 +68hKPxQBGIR2rASp6h2BrlVuW5WmMa/zWb3oV1u+HTajPUQXNfErhvlke1zYOoVcz
	 o5SjAGMVvE47PJfoP7QIOfmofXv7aPagSz2jizE/elbuvV1rpeSsIXP8d8BFm1CHj+
	 cszisBoIdf8x+kmgZjuAe3VaxIo8fjNe/PRvAM86pQrj/a40FqAPjUn88Az5aCF598
	 NK6ucM3Ug/y9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B2D393102B;
	Thu, 18 Jun 2026 00:20:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v6 0/7] net: require CAP_NET_ADMIN in the device netns
 for
 tunnel changelink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178174204613.1875263.5211999687158879407.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jun 2026 00:20:46 +0000
References: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, horms@kernel.org, kuniyu@google.com,
 shaw.leon@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,secunet.com,gondor.apana.org.au,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266944-lists,stable=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixietju@gmail.com,m:shawleon@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C750A69CDC2

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 16:59:34 +0800 you wrote:
> A tunnel changelink() operates on at most two netns, dev_net(dev) and
> the tunnel link netns t->net. They differ once the device is created in
> or moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in the link netns can rewrite a tunnel
> that lives in the link netns. Commit 8b484efd5cb4 ("ip6: vti: Use
> ip6_tnl.net in vti6_siocdevprivate().") added the same check on the
> ioctl path. This series adds it on the RTM_NEWLINK path.
> 
> [...]

Here is the summary with links:
  - [net,v6,1/7] net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
    https://git.kernel.org/netdev/net/c/8165f7ff57d9
  - [net,v6,2/7] net: ipip: require CAP_NET_ADMIN in the device netns for changelink
    https://git.kernel.org/netdev/net/c/8211a2632466
  - [net,v6,3/7] net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
    https://git.kernel.org/netdev/net/c/95cceadbfd52
  - [net,v6,4/7] net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
    https://git.kernel.org/netdev/net/c/2496fa0b7d18
  - [net,v6,5/7] net: ip6_gre: require CAP_NET_ADMIN in the device netns for changelink
    https://git.kernel.org/netdev/net/c/f00a50876d28
  - [net,v6,6/7] net: ip6_vti: require CAP_NET_ADMIN in the device netns for changelink
    https://git.kernel.org/netdev/net/c/e2ac3b242c37
  - [net,v6,7/7] xfrm: xfrm_interface: require CAP_NET_ADMIN in the device netns for changelink
    https://git.kernel.org/netdev/net/c/095515d89b19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



