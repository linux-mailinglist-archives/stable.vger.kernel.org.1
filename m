Return-Path: <stable+bounces-223737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A+wGjp7r2kXZwIAu9opvQ
	(envelope-from <stable+bounces-223737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 03:00:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1731C243F18
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 03:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA7013020E9F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 02:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08494220F2D;
	Tue, 10 Mar 2026 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGS9hl2r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294982BE04F;
	Tue, 10 Mar 2026 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108013; cv=none; b=KC6hJGIRJc3468si9qmI01O4Z8kiW5CZVDE6LsRx4OhcjNhDzSiO5mc8HZUhQP4wMm4+twNQkFZvyLhxdcxzBbIl76UTw47PQgdeucyOi0z6l90D/pBKsngqYkOY8s35yhYrFC9ZIRYsUjUD70DEGC1yE1itG58H7oXgHTZ09lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108013; c=relaxed/simple;
	bh=Se+7+AEu3Jr+o8EeFBcFMgLKW/Ke1Mo28UFO0nvdEpk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L4VqI07RVKocoPZgOsd0z3cqrwW96TPqeR2lkwbEX0tiNMAySkG2IQ+s0j2uwNJGOC0NucrM5SJfHaCsJDf3KtWt6FKA/G2gmoQH8NPbWKBed5digNyzLeMxXkIWR6PKkgsIdFqNsgmVy8+fHifPYvyqj1IsO/v/yTG79PMkqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGS9hl2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27A5C2BCAF;
	Tue, 10 Mar 2026 02:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773108012;
	bh=Se+7+AEu3Jr+o8EeFBcFMgLKW/Ke1Mo28UFO0nvdEpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aGS9hl2ryEhaaeMTjmM4NUeg9pxDsXU64EGeJiE6PnOjOgkP6LuRMdo9jg8ot24g+
	 T6cYUdk3Dvh8JySqgN+GWaJYpazxJIwM2NDAGW7aaWKXg5VN+Evf4XXOc4nI4qO1XW
	 DsR2h/erEUfkrCEcUkzXgqc2YaBU29EIbhR2eQgSER1K6mMM9bKB/JIadf14RdlWIu
	 pql8yxJ2NEBkkqX/qKAxXvL5izt9xhzEiJEi0+0lkYAxS0EdDd41nD/aYBhb97q3WA
	 aMXPubNMLvz4HuODI0gwUjBJ76/rVUlM3mIlFfcmTXEXgG7SuDUVgjlDtWeiL7QkkQ
	 PLpfZR8yvEPRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D923808200;
	Tue, 10 Mar 2026 02:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: nexthop: fix percpu use-after-free in
 remove_nh_grp_entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177310800954.2022132.3786789819097611279.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 02:00:09 +0000
References: <20260306233821.196789-1-mehulrao@gmail.com>
In-Reply-To: <20260306233821.196789-1-mehulrao@gmail.com>
To: Mehul Rao <mehulrao@gmail.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, petrm@nvidia.com,
 idosch@nvidia.com, netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 1731C243F18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223737-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Mar 2026 18:38:20 -0500 you wrote:
> When removing a nexthop from a group, remove_nh_grp_entry() publishes
> the new group via rcu_assign_pointer() then immediately frees the
> removed entry's percpu stats with free_percpu(). However, the
> synchronize_net() grace period in the caller remove_nexthop_from_groups()
> runs after the free. RCU readers that entered before the publish still
> see the old group and can dereference the freed stats via
> nh_grp_entry_stats_inc() -> get_cpu_ptr(nhge->stats), causing a
> use-after-free on percpu memory.
> 
> [...]

Here is the summary with links:
  - [net] net: nexthop: fix percpu use-after-free in remove_nh_grp_entry
    https://git.kernel.org/netdev/net/c/b2662e7593e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



