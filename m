Return-Path: <stable+bounces-268051-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7/XuJhA/O2qLUQgAu9opvQ
	(envelope-from <stable+bounces-268051-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 04:21:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D36BAE7B
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 04:21:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZtEszIvI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268051-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268051-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73BD8302E905
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 02:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D431F2F3C07;
	Wed, 24 Jun 2026 02:20:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC3D275B03;
	Wed, 24 Jun 2026 02:20:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782267655; cv=none; b=OMEsKErEbA4m6+rG0j1dK2lvy+NC5YA3TVO+Epkz6eSlgvR0BEkdO3VkhQ/q0StDB7I+jTkR3aeiHrrfT6IVlM4PXVFx/DOzWiOHT4NUGk9eGZwfA67pNOw4zUAYGnk5H41rriuDYCATiWtoK16/QyPKSg2G0kGKLAiBVv+htmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782267655; c=relaxed/simple;
	bh=wwn6XUbKIvCiPSBA3TSc56WDWaioUhODoV6QTWPHC3o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rrBgvPlXq1wlFwzNdHU7jCT02nAySQm6gGS1TGo+9S1m+c3qFsbx8drZkd7episaS+NK4o8Q57Rof6Ap+gQXPx/dKSIku+II4vZxleFWdl74ZLS95zS40SEv6qTblnWedMsQHCMahJt3+K2OfSAW9bk4aXyIeWXyc0qzyrPffE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtEszIvI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655B31F000E9;
	Wed, 24 Jun 2026 02:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782267654;
	bh=YOAjeMHaG6nM10AE3YqdIXVgU/k5lU1/yhqshnZ5o3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZtEszIvI5scw2JK8+1RzhbKEg7cQCdXCOOLUPn3qtkvvmdGabYIsHFmJkcxZvOoEE
	 eSJyeOt8C/MIYAozatA1KU/gXdGwRU07KLQu/k+t33k3QVju5PvIdcrFAoBAeSpWYg
	 qxX/+YkjpAVEZkooYolNaSuqJOPA9E4nZqzOHf5P6+/Jn+bpSVKUipsn2NNt4kFMs2
	 M+4AoMmjos7O0+JDwVF3uzdrVfMPc9XTMUghdzhFHyu3NYD0Q6FEDdLdjI/xTUoYz3
	 jfcFn82yqFIK1CLbSZPJ9joglfyGLmnj3E2JCdZwP/cdTI81vmxe/wehZeIENeILUn
	 dRXF/oQx4pJ4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B6D393102A;
	Wed, 24 Jun 2026 02:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: au1000: move free_irq out of the close-time
 spinlocked section
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178226764357.2513445.5024104235449335960.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jun 2026 02:20:43 +0000
References: <20260619151816.1144289-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260619151816.1144289-1-runyu.xiao@seu.edu.cn>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268051-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable,netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C0D36BAE7B

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Jun 2026 23:18:16 +0800 you wrote:
> au1000_close() calls free_irq() while aup->lock is still held with
> spin_lock_irqsave(). free_irq() can sleep because it takes the IRQ
> descriptor request mutex, so it does not belong inside the close-time
> spinlocked section.
> 
> This was found by our static analysis tool and then confirmed by manual
> review of the in-tree au1000_close() .ndo_stop path. The reviewed path
> keeps aup->lock held across the MAC reset, queue stop and
> free_irq(dev->irq, dev).
> 
> [...]

Here is the summary with links:
  - [net] net: au1000: move free_irq out of the close-time spinlocked section
    https://git.kernel.org/netdev/net/c/f48763beab4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



