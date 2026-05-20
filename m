Return-Path: <stable+bounces-249724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJEKC6oVDWq5tAUAu9opvQ
	(envelope-from <stable+bounces-249724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 04:00:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C32ED586AB0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 04:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 261843020A54
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 02:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6F02F8EAF;
	Wed, 20 May 2026 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS6hK3JM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8DB2F39B8;
	Wed, 20 May 2026 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779242404; cv=none; b=Bp8DzRXzLQxUwOgyq462cw9L2HFszT/ScZ8cxBWAYE10wkFWbyl03WeTNDHoq/d6dqyTpxno7uyBSpMIlwX9thR5Q6VlXFKdagB021nvft/W4uc+XnYu6ubOlF3YtRBkcl/dIPfRWRYgYbIxSnqC40kaaIB5WLw0avvDiQn/nZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779242404; c=relaxed/simple;
	bh=gjgh8kdA3m/flPEQToQ1NLj0A2+4fb5TUiH2kSeFCt4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gigv6zsD16Lshsv0h0UIugQboYKCpF7tAjhWKEoZDln0q5lEt9tzQjUeL9fLco+DfFjdVWBcYRHz/LF5EAMDH5BgQTv3SkbyLkqhZnMY33pIBQyXCaCQ3HJDZvzpdosy9XTN3tn1yfbIsCSvN0lm6R7mFRoL+m2uj1I8TeGbdvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS6hK3JM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF71C1F000E9;
	Wed, 20 May 2026 02:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779242402;
	bh=mDQa/S199WfXqfZtismbjSDacf9NhvAaoC6w4ISijaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IS6hK3JMuo7ESNyAKBQ0v1TYWTLCh8eDscxVMHvmt0GHw6mSY7dRFFYfEz37cBVtc
	 WMqqgVk/yHmUM/9LP8Uwt3o8iddRIrl02rZLxDeqHV6vmLQ3ksde1zQgBifywY2K+M
	 mUgb3/2oLMvK/21tE4w2pcr/u6Fmt+mKCSa1gVxOOlw/PTnwB9dWakictH2KzZ+Kxr
	 RaAY2FdzYy4yW5vkeaN6qQtePzlK0D/KI1ZWrC698DIHMK6peFa7ygfYIwquOu/KUD
	 GQG/e2eDo07ivHNF+H+ni28yqcj6UpyT/Fjt9WAiOKGlQhSk675O9nHd+I2Mmm0jZm
	 5SYoa/3YnNe/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56962383BF53;
	Wed, 20 May 2026 02:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: ioam: add NULL check for idev in
 ipv6_hop_ioam()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177924241303.2949285.7584586372366351659.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 02:00:13 +0000
References: <20260517183059.29140-1-justin.iurman@gmail.com>
In-Reply-To: <20260517183059.29140-1-justin.iurman@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-249724-lists,stable=lfdr.de,netdevbpf];
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
X-Rspamd-Queue-Id: C32ED586AB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 17 May 2026 20:30:59 +0200 you wrote:
> Reported by Sashiko:
> 
> The function ipv6_hop_ioam() accesses
> __in6_dev_get(skb->dev)->cnf.ioam6_enabled without validating the returned
> idev pointer. Because addrconf_ifdown() can concurrently clear dev->ip6_ptr
> via RCU, __in6_dev_get() can return NULL during interface teardown, which
> could cause a NULL pointer dereference when processing an IOAM Hop-by-Hop
> option.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: ioam: add NULL check for idev in ipv6_hop_ioam()
    https://git.kernel.org/netdev/net/c/d4ea0dfd7501

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



