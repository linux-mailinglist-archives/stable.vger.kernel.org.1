Return-Path: <stable+bounces-215800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMo+KRF0jGk6ogAAu9opvQ
	(envelope-from <stable+bounces-215800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:20:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2526A124276
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A24130143C0
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AC433A6FB;
	Wed, 11 Feb 2026 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfvrVchq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA79331A73;
	Wed, 11 Feb 2026 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770812411; cv=none; b=VcUjLlB58GG8D/2lSEuYlkKIgFzHqiG81nDpDCHjqkIAgf8LaKcHtIc7jC5WeWnZK1CbXymG0OZYOkVZ/enfImaSjz1ywv94UIUG1fjsVtiOFLqiR0M2IVrNgTwE8yVIzaz7O1LO2KdM59WmIoZug9TU/4WRBfr6KJMFSuvyraM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770812411; c=relaxed/simple;
	bh=zR01tu8qtOqlsjZrEvDTStBAXi/A/arNnssfZuQkkF0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Au8G//Y7757U+fnKTQITUye4q5+ewMjB7NcFRWkaAOhih2RW4RJBbun6c/V48amNAfAcMofVdKH6CnsdxRat1d7zD5gk3C4SbvD0UTiCXetfQVI7OyG4+O+U53tQ0H7iAi4fif1vmWxRVt5XomI0A92RVUwQIJljaAaHUsHfk+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfvrVchq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08EBC4CEF7;
	Wed, 11 Feb 2026 12:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770812410;
	bh=zR01tu8qtOqlsjZrEvDTStBAXi/A/arNnssfZuQkkF0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NfvrVchqlqRw2uiGMLiRSbKQAkcLgYva7ORgdYoO4FK9V+2YFeNuosj4cMH7GlBn5
	 PMio5odQnlibrlLtrbXqLcyyKy35UPqLsR/u4GFyeZVcjYnQaFrNWWjmxojCJh/Mlw
	 JA7qCvdy1/I772bNykohZxUzg2QZ1vzeFBMjVqcubNpjQilyJw8QCXCKcSp40OXytX
	 yV6vOiH7mt8QLY7x/ppVYYAazXy/CizAJcCc4JMDeGiQ60YkUQ95fYTLmNX5TMbnBI
	 JLD+d703AGTUbPa9JPDWTHcvvhOgi8Qhkwl3TxIbLnrXork8femv4z6BYfWKyB14F1
	 QheZguq57GZVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C23DF39E9615;
	Wed, 11 Feb 2026 12:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: macb: Fix tx/rx malfunction after phy link down
 and up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177081240558.151200.5301148019351136409.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 12:20:05 +0000
References: <20260208-macb-init-ring-v1-1-939a32c14635@gmail.com>
In-Reply-To: <20260208-macb-init-ring-v1-1-939a32c14635@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 xiaolei.wang@windriver.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215800-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2526A124276
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 08 Feb 2026 16:45:52 +0800 you wrote:
> In commit 99537d5c476c ("net: macb: Relocate mog_init_rings() callback
> from macb_mac_link_up() to macb_open()"), the mog_init_rings() callback
> was moved from macb_mac_link_up() to macb_open() to resolve a deadlock
> issue. However, this change introduced a tx/rx malfunction following
> phy link down and up events. The issue arises from a mismatch between
> the software queue->tx_head, queue->tx_tail, queue->rx_prepared_head,
> and queue->rx_tail values and the hardware's internal tx/rx queue
> pointers.
> 
> [...]

Here is the summary with links:
  - [net] net: macb: Fix tx/rx malfunction after phy link down and up
    https://git.kernel.org/netdev/net/c/bf9cf80cab81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



