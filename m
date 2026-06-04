Return-Path: <stable+bounces-260536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0r7cAWmjIWrFKQEAu9opvQ
	(envelope-from <stable+bounces-260536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 18:10:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E83A641B66
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 18:10:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Qu/XSKzs";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260536-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260536-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 812943115177
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC2D47DD46;
	Thu,  4 Jun 2026 16:00:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9C847B431;
	Thu,  4 Jun 2026 16:00:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588832; cv=none; b=i2r3TeIBYD/PvF514t97IIzAEjxQ5ijaKoWsdHUtGJlO9m9h/lmzRC+eNPYkM+3iFJFOt5heZt3LVzUMHpZS5i8Q4g+Qwn8N2m7WMKe81v+j8FVBio+wRPA3Erm+JWl1CLk3xZwlyFIQr35feoMZhFgBxmgC1qn1dZTg5Mb3Ups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588832; c=relaxed/simple;
	bh=/DuU/H+ePsONsMhYu4qmqPYLCf70f1/9AKu9wRqIunc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gPopnY+3BgsTwwIJ7XjfQIw9sX1kMpvpLd0c9aNeAqOSKBavIR+/vbWwNkreB40tKWnwt5WGJSS+3+d1lttEZlJ0xos4tIjzvtFzRM/JMo66Ew10S9jttDpdIkdOnHhjT6fAL4NqLWQhJOWWQJSaJKOSs7Uci6gy/6yab7gz9ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qu/XSKzs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394701F00893;
	Thu,  4 Jun 2026 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780588831;
	bh=EJEf64ZBQsNzoWifPhtZA9P/vPax0Lu5T3OxobFaaJg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Qu/XSKzs7mlytpjAQqsaZY+AWM5fEaBYftI+qI0GjzoBURUaaikPmF3NmwzcBccn/
	 BY21p4Ec78JFombHsCEdb/97ipy+RUUHykYipFJPMBdlDjQ+AdmYU9ym8EwJnEAg+j
	 ecuAu+XMGZhG0Gjg+YjZCOt1PRflY4sj+rW2MvQr+DcO7qwFPfsfJj8nVwBmkVJEXa
	 I7wB2q7mhBZzyuQwBJMP4lpJHhVJRjbtW5u4sEdeHum3oI4Q3ffuhAtaBHU1XdyD+W
	 PoX3Boq80v3inIOHZYtotFDRvHHTHzhjTR136mnwaScK09Q9CJKB/5mcT2HPe5+g6X
	 IlP3PxhQaUjSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5695039309B7;
	Thu,  4 Jun 2026 16:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] rtase: Avoid sleeping in get_stats64()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178058883188.2493857.544475254028266565.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 16:00:31 +0000
References: <20260603061816.31356-1-justinlai0215@realtek.com>
In-Reply-To: <20260603061816.31356-1-justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org, horms@kernel.org,
 aleksander.lobakin@intel.com, pkshih@realtek.com, larry.chiu@realtek.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260536-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:justinlai0215@realtek.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,m:horms@kernel.org,m:aleksander.lobakin@intel.com,m:pkshih@realtek.com,m:larry.chiu@realtek.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E83A641B66

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 3 Jun 2026 14:18:16 +0800 you wrote:
> The .ndo_get_stats64 callback must not sleep because it can be
> called when reading /proc/net/dev.
> 
> rtase_get_stats64() calls rtase_dump_tally_counter(), which polls
> the tally counter dump bit with read_poll_timeout(). This may
> sleep while waiting for the hardware counter dump to complete.
> 
> [...]

Here is the summary with links:
  - [net,v2] rtase: Avoid sleeping in get_stats64()
    https://git.kernel.org/netdev/net/c/9fc237f8d49f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



