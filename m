Return-Path: <stable+bounces-238608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAcVMpDZ42kHLgEAu9opvQ
	(envelope-from <stable+bounces-238608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 21:20:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3534220C0
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 21:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCDAF3018613
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 19:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0607730E85C;
	Sat, 18 Apr 2026 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlqMu6ya"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC34C288C08;
	Sat, 18 Apr 2026 19:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776540043; cv=none; b=Jo0rsXhiOBpVL/EihY0JYhqVb4WNWyT1ThdVFBTphiprPWfGxlMk3PuKwm43m/OzZHZrm5eco4X0VaJdIJFFqslZkwdxzFHwuWB7NGhWPhbEEHzLecg818/cAOhdtQLyaO3WjFoaN+/+i/8LvtT3iv3Obt4M/EPQY0/zkdDTUIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776540043; c=relaxed/simple;
	bh=UbeGQ2EKoKQRoI8Lm+Eh5U17hxg/zOzKLypavlI1rpk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ndUegCHns+k2A3WlXIqBZQikSIvZlscYorNv3S1YZvyQAjk5LIktL3ZI2zYCgW1IAmB+oGJYAag6F9v6ZqWrgxeKXi5U+QMQygX0m75r/DYQYr9wG7vqq0nabuJkQoGvED+wJO1U1mWtaPH9DUIlk9d0Qu8NNA/DZS9K5IEw7Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlqMu6ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D49C19424;
	Sat, 18 Apr 2026 19:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776540043;
	bh=UbeGQ2EKoKQRoI8Lm+Eh5U17hxg/zOzKLypavlI1rpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mlqMu6ya/kfYV4LRwvEIMUSrlK1koiW616/PxJde2iFMldxevwDFbx8M5tHu9/f9Y
	 VMJTdm1tdjRGj8YwD9c7Iuj/KKmJNNGKU1gh1n4Q1QGqwIAAikE4LLYl3kfwftIY10
	 xfZpjJCKghJU3V2R2oXaSzbDao7M0hQDmgxUdo9uVbYilJOG/SZ6Q+jUY/Gib+tuDm
	 KIo1sFvJAFNz1LNdXGm73f5glqqPPssNSQJ0faijEoNJwPKUiec2lBMvLTzJp3jm0A
	 2IXte0kt6r7mPPlXp+b0fELC02F753nNZQ7nE0zFChTxVmZXfBOX7xW2SytyvfukR/
	 A+HWVcdddKPuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE5C380CEDD;
	Sat, 18 Apr 2026 19:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net,PATCH v4 1/2] net: ks8851: Reinstate disabling of BHs around
 IRQ
 handler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177654001005.508728.14647463220081065342.git-patchwork-notify@kernel.org>
Date: Sat, 18 Apr 2026 19:20:10 +0000
References: <20260415231020.455298-1-marex@nabladev.com>
In-Reply-To: <20260415231020.455298-1-marex@nabladev.com>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, bigeasy@linutronix.de, stable@vger.kernel.org,
 davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, nb@tipi-net.de, pabeni@redhat.com, ronald.wahl@raritan.com,
 yiconghui@gmail.com, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238608-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,linutronix.de,davemloft.net,lunn.ch,google.com,kernel.org,tipi-net.de,redhat.com,raritan.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F3534220C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Apr 2026 01:09:44 +0200 you wrote:
> If the driver executes ks8851_irq() AND a TX packet has been sent, then
> the driver enables TX queue via netif_wake_queue() which schedules TX
> softirq to queue packets for this device.
> 
> If CONFIG_PREEMPT_RT=y is set AND a packet has also been received by
> the MAC, then ks8851_rx_pkts() calls netdev_alloc_skb_ip_align() to
> allocate SKBs for the received packets. If netdev_alloc_skb_ip_align()
> is called with BH enabled, then local_bh_enable() at the end of
> netdev_alloc_skb_ip_align() will trigger the pending softirq processing,
> which may ultimately call the .xmit callback ks8851_start_xmit_par().
> The ks8851_start_xmit_par() will try to lock struct ks8851_net_par
> .lock spinlock, which is already locked by ks8851_irq() from which
> ks8851_start_xmit_par() was called. This leads to a deadlock, which
> is reported by the kernel, including a trace listed below.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] net: ks8851: Reinstate disabling of BHs around IRQ handler
    https://git.kernel.org/netdev/net/c/5c9fcac3c872
  - [net,v4,2/2] net: ks8851: Avoid excess softirq scheduling
    https://git.kernel.org/netdev/net/c/22230e68b2cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



