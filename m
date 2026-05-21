Return-Path: <stable+bounces-253603-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAHvFewyD2qSHgYAu9opvQ
	(envelope-from <stable+bounces-253603-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:29:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D075A94A2
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0AF530B2C2F
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8333655C2;
	Thu, 21 May 2026 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSU+kHHO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE4364EA5;
	Thu, 21 May 2026 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377404; cv=none; b=LjruhIwBoYV+O+xpaZ7gYafbEqMKeDs83VtfU4tyKXeQ5BDIxFzJ+TI5IqwuYjEZfSENVaNCV8jybZd6eWlQq4e/RM0Pl9NYWDNsfbjuzjakCjywsc6XM83TWa1quVr1lWZx6LqjUf+a7r63Lv1TTgQB8hxlF8rkYmV+MlUwcEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377404; c=relaxed/simple;
	bh=r1mnfmvkRX9SMmDZdus6YhNreX8SnW+zV+H1XXECurA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gQUCK5gt3AMH97cUqf0R7pVztwjJNGOAWdX9oyHVhwZshCTy+QydH4rcYiuGjR2n7gPP3fe2ti2wjauZRbFsCaqg9wyj5Y32Jlm9vCmKo+68iiYyQgKwaS9UFq0iVpZOQfYarj9A35Y1Wt2yqrf4Zov5M4JOPpz3YRAXdJI4kHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSU+kHHO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8162C1F000E9;
	Thu, 21 May 2026 15:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377403;
	bh=1jU9/CSxOb6fJcznlAn59JOWJxBhSZuTZEet7wdwa/M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TSU+kHHOPQ5d+d6VKLIPOUOrx2srsJVzzS8sy7GIOUbzzTyt6HwZ9gRL8ePr1iGGx
	 RgDEDX8pW8Gk7aMszx5Vy6rKhmkXT84ZiSjB7W6SJpkNOls8Y5ilIY2I40RTW7IeGY
	 qShF+5oW5gJuiRFWdApcAv/w5NzWhEwBFF3HS6nFxw/QyVZ+oYp3YoeGdxB0S8Vbnb
	 tdbkdJ+tw8RZgC++J/KRoykynF6npIEeW8QCESYUHDXh4BF1bepyVJDA3m/7By9zCx
	 65xuHij/F5uBo3ead54zxnuvBKO7s3GsMNqEUFemRU7IocjGksR1uV/X/J6ZEHbEsU
	 6bJzrBUFT1Prg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939063930E02;
	Thu, 21 May 2026 15:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: ioam: refresh hdr pointer before ioam6_event()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937741316.384060.7911615095323709207.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:30:13 +0000
References: <20260520124242.32320-1-justin.iurman@gmail.com>
In-Reply-To: <20260520124242.32320-1-justin.iurman@gmail.com>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253603-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E1D075A94A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 14:42:42 +0200 you wrote:
> Reported by Sashiko:
> 
> In ipv6_hop_ioam(), the hdr pointer is initialized to point into the
> skb's linear data buffer. Later, the code calls skb_ensure_writable(),
> which might reallocate the buffer:
> 
> 	if (skb_ensure_writable(skb, optoff + 2 + hdr->opt_len))
> 		goto drop;
> 
> [...]

Here is the summary with links:
  - [net] ipv6: ioam: refresh hdr pointer before ioam6_event()
    https://git.kernel.org/netdev/net/c/e46e6bc97fb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



