Return-Path: <stable+bounces-260834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GwSYCSh4I2r+uAEAu9opvQ
	(envelope-from <stable+bounces-260834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 03:30:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E67164C1BC
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 03:30:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cr5+HxSN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260834-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-260834-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55F193018168
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 01:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ED724677B;
	Sat,  6 Jun 2026 01:30:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64722248886;
	Sat,  6 Jun 2026 01:30:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780709407; cv=none; b=QzvCDQGfzrzUAH6KgRM6cJ0Nh3aCtmqZqQAQxEW6HAQxzmIDowJTmZMsrMejZSs/aAQ3HzTR8BV4ImmQekTR1YnVzOe5ZBpMlBsWCYTeGXNxyTzyhnI5rPOvmo3BbdoS+WuxrXbDypYrkDga747NekddJDNmqXwVcyeXdpzL6PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780709407; c=relaxed/simple;
	bh=V9zdUch1RCqumX9vL7VDj7yyGBh4Yz8WOttv6lfxVFI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uveTNEfuLUkNd4aux1h4GI7SOp8VWTbtPwEJGmVrbBMwjhrYI3eWmkI3Y2VeB4ayqzTNq/znDBSM7dk59KlwKmByT20yQhidB48yoVARmCStALlXGEzCSjLsx3jPHRaa4Rt7GzIRAUkw/up16wF0SpuIS7Is9tYW87iBIIwITl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr5+HxSN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFC91F00893;
	Sat,  6 Jun 2026 01:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780709406;
	bh=ASXWK8gh0lMnAbiPph0XBp/VyyYVnUTZVyfHxjwp+Dk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cr5+HxSNHdkS8C6KkY4HwanjvCasaX+Les4bRwAKQd31rBdAVtn7epdZmKcevyDlM
	 b8+wcRmUlZO+LYG5Uq0kHwTDRmvEHSAhOWfhgH/0HAN0wdmogGYJf1RWBZqOJH2exx
	 2/ZqKBZJG1Hxmh0FR8UZbUTnyZ207I/vgAL3TLhpLuV23KjZxODpaY/OiZAHa00i11
	 xMPy5aMOlDu6luKT9oHXhW7y2UuLf75StZGSvHWg/h0IwaZbauJGsEM/1QdF35R5rj
	 +q5+AEsvCWETARD/dJYbDMWGF3Huz/B4Z/QXLq4Vk9grHvFsYnGcDKa2tt2KTReiic
	 Qy/f9B4i24vWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569293930A9C;
	Sat,  6 Jun 2026 01:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Add NULL check for
 of_reserved_mem_lookup()
 in airoha_qdma_init_hfwd_queues()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178070940590.3983833.5638172237505353100.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jun 2026 01:30:05 +0000
References: <20260604070352.2603077-1-zhaojinming@uniontech.com>
In-Reply-To: <20260604070352.2603077-1-zhaojinming@uniontech.com>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260834-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:zhaojinming@uniontech.com,m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E67164C1BC

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 15:03:52 +0800 you wrote:
> of_reserved_mem_lookup() may return NULL if the reserved memory region
> referenced by the "memory-region" phandle is not found in the reserved
> memory table (e.g. due to a misconfigured DTS or a removed
> memory-region node).  The current code dereferences the returned
> pointer without checking for NULL, leading to a kernel NULL pointer
> dereference at the following lines:
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Add NULL check for of_reserved_mem_lookup() in airoha_qdma_init_hfwd_queues()
    https://git.kernel.org/netdev/net/c/f9f25118faa4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



