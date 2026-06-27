Return-Path: <stable+bounces-269421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bv3GMDhUQGpWewkAu9opvQ
	(envelope-from <stable+bounces-269421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 00:52:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1111E6D2C8C
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 00:52:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lugLdlzx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269421-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269421-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42AF3303CA7C
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 22:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A456A3546C3;
	Sat, 27 Jun 2026 22:50:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B183812DA;
	Sat, 27 Jun 2026 22:50:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782600650; cv=none; b=mMbe9SOKSVkgkAResHjyFHPBtzEgcIEX/pp2hIs902hiIjOWtOEVvdZAt0OcOZcoYe5DjK8ILdjXW6LDLBMlIkC/yTbSlvJa4Ey3dQXPUv7/kQRNybaZeJ8qQpCV9NrYS9j7F0XSJ74xq5jGWK0+rFmmNLswsyczbtbGwIEmMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782600650; c=relaxed/simple;
	bh=C+NG5QQa4hOLhinEOftJWLkyUGE6/PCuJbIe+d6jj88=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ghkGmKIermQqgERCa+olj0aJS8ESuT0V7oyQ5PEaSxNkr7X5k9e1elr6tUdmOtyq5v5Di2hHUeixgEhXHdz1d1iV800Yd7dzqN3+3uq9VucPqAQjvkNu4pGdyclrCVMlPtgl/os60kOrnKAPHhMiYzQzKzy1MwJOFwwww6dGFvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lugLdlzx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146841F000E9;
	Sat, 27 Jun 2026 22:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782600646;
	bh=kZWjOiSImPrfh80sKo7yeGE91rVFd7WvXtigqP3CJC4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lugLdlzxZ9Aosx77zfBgZmZ7ReTImSIcanXbGjA93UdeuxF1rUYqGyWXRMVMR7Ca3
	 gKB46qN+JWKd54frifVcgbS6NqmO9zRXhEIKMBY9CrdRPFyO2+hZy9z11XD6oEdtI+
	 j6rGFrIZ0XpepY+xemRol5xUNrUrOPVFT+pK7kKwseQyow6/1jzE8ZNetQNQEK3Tfi
	 /1JYMhIjZVdLrMlGr/wSU7kqDnT9p3RvS7ArRUZVaVimK6/X4x6BQrIYRWxGozJa6P
	 7V/NufDb3O9YDbdl+huOGaY2Rw/WKZJXA94dD+s4hbc8745RTQQbZfTjPieNVHJW1M
	 duBQj7wPPGpnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198673938452;
	Sat, 27 Jun 2026 22:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] netpoll: fix a use-after-free on shutdown path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178260063154.1451849.16906699436504289458.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 22:50:31 +0000
References: <20260625-netpoll_rcu_fix-v2-1-0748ffac1e98@debian.org>
In-Reply-To: <20260625-netpoll_rcu_fix-v2-1-0748ffac1e98@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, amwang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, vlad.wing@gmail.com,
 asantostc@gmail.com, paulmck@kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org, pavan.chebbi@broadcom.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,meta.com,broadcom.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269421-lists,stable=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:amwang@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vlad.wing@gmail.com,m:asantostc@gmail.com,m:paulmck@kernel.org,m:kernel-team@meta.com,m:stable@vger.kernel.org,m:pavan.chebbi@broadcom.com,m:vladwing@gmail.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1111E6D2C8C

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jun 2026 05:03:18 -0700 you wrote:
> There is a use-after-free error on netpoll, which is clearly detected by
> KASAN.
> 
>       BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x3b/0x80
>       Read of size 1 at addr ... by task kworker/9:1
>       Workqueue: events queue_process
>       Call Trace:
>        skb_dequeue+0x1e/0xb0
>        queue_process+0x2c/0x600
>        process_scheduled_works+0x4b6/0x850
>        worker_thread+0x414/0x5a0
>       Allocated by task 242:
>        __netpoll_setup+0x201/0x4a0
>        netpoll_setup+0x249/0x550
>        enabled_store+0x32f/0x380
>       Freed by task 0:
>        kfree+0x1b7/0x540
>        rcu_core+0x3f8/0x7a0
> 
> [...]

Here is the summary with links:
  - [net,v2] netpoll: fix a use-after-free on shutdown path
    https://git.kernel.org/netdev/net/c/45f1458a8501

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



