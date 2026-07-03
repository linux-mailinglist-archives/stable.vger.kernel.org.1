Return-Path: <stable+bounces-271801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I9HcHprIR2r+fAAAu9opvQ
	(envelope-from <stable+bounces-271801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:35:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2B670375A
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:35:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=I0hckxku;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271801-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271801-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A247314E696
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 14:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75D63DCD99;
	Fri,  3 Jul 2026 14:20:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992C8346769;
	Fri,  3 Jul 2026 14:20:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088424; cv=none; b=qHLPm68Y2g+ezhVg6coUd0MDLI8dQlEMrWJciVTN1Z6Us0fptyHB4bVk3j+yMzw7OhYnd9ptOOKR45F4dv+yETd/NyaQB7Urr+dD4IRJbZ7SGljeCCpZm6YRbuLrzGb/cyb1/whQ1ISIVeyqF1Ku+an+jE/KtT9qzmYZGwWUO7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088424; c=relaxed/simple;
	bh=xus9xWKfDrR9VgvHtd5+1k22YCyF+L19MkAVyPvh7J0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kjvc1yY/1ihoTtGuGGkPH08l0HyJVWmDsaFxs3Fg/capmH2X46U6XXGR1IWeVgy/z/xleNRsVuDwseZystrZDhlnn14r6orHMK8CfqNkgS72AR8v7r3GH+aTF8bToC8bQdA2j9Pe/3bKIpqV2vPN/aevIUhLOHoHInPsf0idfoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0hckxku; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249B61F000E9;
	Fri,  3 Jul 2026 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783088423;
	bh=iFz38CMH9S6n3f/OwJtU5s8rcop08MmRtEUK1TMyxCQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=I0hckxkuVzyc4cDbthHf6nAbx0tDQn1vlg+aSXoN5pbZILSZEHpqp4wovyve5Dh+J
	 i1wB8WljsmsGXAmyVAQtvFdHAdbANVY7as4m6l7C4kubyU6ozlcMZA75M1SObpVyVS
	 KjUEbY/jJrYuOWl07FdXf4WQYvy9G8EM1miRQ6Y92JEGZGejFgU/vyXlH249zrG27H
	 dELd4BnsWOtTxsdRhpkKA0uUdgo+Q0pWjN993KYT1Fjm+Lj8NecIwmipspeyRt514D
	 ptFTaQ3i3o+44S9lqnobz2xPCH8P+uVGPJDDHlZumNPErtuEmiT/ojdvLoL6FqSQ5A
	 aggdZlZbtagsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AF64A3930E1A;
	Fri,  3 Jul 2026 14:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] mac802154: remove interfaces with RCU list
 deletion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178308840539.2733930.6133885525890895225.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jul 2026 14:20:05 +0000
References: <20260701164222.9094-1-alhouseenyousef@gmail.com>
In-Reply-To: <20260701164222.9094-1-alhouseenyousef@gmail.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org,
 miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, marcel@holtmann.org,
 kuniyu@google.com, linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,datenfreihafen.org,bootlin.com,davemloft.net,google.com,kernel.org,redhat.com,holtmann.org,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271801-lists,stable=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:alex.aring@gmail.com,m:stefan@datenfreihafen.org,m:miquel.raynal@bootlin.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:marcel@holtmann.org,m:kuniyu@google.com,m:linux-wpan@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+36256deb69a588e9290e@syzkaller.appspotmail.com,m:alexaring@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[stable,36256deb69a588e9290e];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C2B670375A

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  1 Jul 2026 18:42:22 +0200 you wrote:
> Queue wake, stop, and disable paths walk local->interfaces under RCU.
> The bulk hardware teardown path removes entries with list_del(), so an
> asynchronous transmit completion can follow a poisoned list node in
> ieee802154_wake_queue().
> 
> Use list_del_rcu() as in the single-interface removal path. The following
> unregister_netdevice() waits for in-flight RCU readers before freeing the
> netdevice, so no separate grace-period wait is needed.
> 
> [...]

Here is the summary with links:
  - [net,v2] mac802154: remove interfaces with RCU list deletion
    https://git.kernel.org/netdev/net/c/539dfcf69105

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



