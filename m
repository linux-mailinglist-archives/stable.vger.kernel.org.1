Return-Path: <stable+bounces-272189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gXHEK8uSS2oNVwEAu9opvQ
	(envelope-from <stable+bounces-272189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 13:34:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FF370FE5B
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 13:34:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=L8OC2G1b;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272189-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272189-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F3173111B1E
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 11:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9904D3F44F7;
	Mon,  6 Jul 2026 11:00:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037103E7BA4;
	Mon,  6 Jul 2026 11:00:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335631; cv=none; b=HiqIE1rzijknNNs6Z38lsRWu2+AeZNy23EYQrJwTwZCPFe5oMspAj2nKo9tsDiY7Dlz4Y6OVVlsodUeG+3GHLoZg4rvS7utdnUq9afPvsY+KW2xjcmx1PjqSVDx0aDh4CrfMwivcYGahHcH4f6c/oJsIJfnL4ozPQ5cmyfj3row=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335631; c=relaxed/simple;
	bh=oSJcizVEB2AE5qWYIy6hS6yMTz9ZS1gwNvy3ZT70Md8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mfAMdATSB3KHRz5bvAmWC7HJ/72e7Wzgmq/FJkBg/ho7msaBxL/H7+RP4h+t3J4PZZWyL5Z0hTU+ktIpoUKEcUhP3pQ/tGeZ1lolVjMsntlaYh5On8xquERrpXzT6MLs2Y5GSmvBO9mW2dy/IMIcSFEss9Sauv0RF7wmjVV1iK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8OC2G1b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837941F00A3D;
	Mon,  6 Jul 2026 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783335628;
	bh=z1Exyblzz3CqiQ4kTkKOEQNGqw6O5u89Bc9MEMUXO+I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L8OC2G1b5iLLPIYIr8g8nqarIYxcSjwRjciXCm5VurS4B5liWxKsMGqGB6yxLroS6
	 CCGA4MXhX+V97Vf95ttygRNhHW415CbYActu8/fhvzO9d+J5+onq2vkQZutiZGwbSN
	 JDH054i6/pc6ZnljlI9uhK51KTvVooIO7eBTFudGcHLxHAVO7C+STh/C1VvrZu0zTl
	 Z6hNFtzz6r2zQXnInmmuO4m2jKSzPAoKyk5tvXCTbddQk4fS/vcuAFYPj+JMyiT5l0
	 qZPYWsVGGgxw8HRrlprQsiII/OPxUnQUArqxeEbd4Fh8rYNXQOCjn74iliVKqJ2KAD
	 5BxHEtdgqJNMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5697B3ABD2A5;
	Mon,  6 Jul 2026 11:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net/sched: act_pedit: fix TOCTOU heap OOB write
 in tc
 offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178333560889.503923.6757355467613392279.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 11:00:08 +0000
References: <20260701161912.125355-1-jhs@mojatatu.com>
In-Reply-To: <20260701161912.125355-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, security@kernel.org, zdi-disclosures@trendmicro.com,
 stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272189-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jiri@resnulli.us,m:victor@mojatatu.com,m:security@kernel.org,m:zdi-disclosures@trendmicro.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,trendmicro.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12FF370FE5B

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  1 Jul 2026 12:19:12 -0400 you wrote:
> There is a TOCTOU race condition in flower lockless approach between sizing
> a flow_rule buffer and filling it.
> zdi-disclosures@trendmicro.com reports:
> The cls_flower classifier operates with TCF_PROTO_OPS_DOIT_UNLOCKED
> (fl_change runs without RTNL), while RTM_NEWACTION holds RTNL, so the
> independent locking domains make the race reachable in practice.  KASAN
> confirms:
>   BUG: KASAN: slab-out-of-bounds in tcf_pedit_offload_act_setup+0x81b/0x930
>   Write of size 4 at addr ffff888001f27520 by task poc-toctou/312
>   The buggy address is located 0 bytes to the right of
>    allocated 288-byte region [ffff888001f27400, ffff888001f27520)
>    (cache kmalloc-512)
> 
> [...]

Here is the summary with links:
  - [net,1/1] net/sched: act_pedit: fix TOCTOU heap OOB write in tc offload
    https://git.kernel.org/netdev/net/c/8b519cbcabe8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



