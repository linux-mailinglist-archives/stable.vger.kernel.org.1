Return-Path: <stable+bounces-271649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wxtUJl5ZR2pdWgAAu9opvQ
	(envelope-from <stable+bounces-271649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 08:40:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D52636FF236
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 08:40:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="er1z/1kG";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271649-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271649-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75FB43020A45
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 06:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD503806C4;
	Fri,  3 Jul 2026 06:40:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8821624A078;
	Fri,  3 Jul 2026 06:40:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060824; cv=none; b=JgNT9qP8/opgF6JQZDMOI5fdruVHzHP+wND3Il+ztNHIh1CigA6bmEpYMD9JEWLCqVTZBpn4mc/FYL90Z8+8664ou+7sRqPpHuYnImXBejyk0pRzW/G0QFIboK9dbHJATNT6IHhTfkTCERVS0GJMYfcfFKUrzomhqJJQdekPaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060824; c=relaxed/simple;
	bh=nOSmHGPL19da4Ba4E+HjmMvi/1OuD8/OfFLMu6Ebr/4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hhJeeKwM+5/kzsuVxwTPGNvEh6w6Bocy2BctldXH/izQC2aERuHEEjF1w3sP9MER5sKWlG9B9u+CuR6MDTgqpT1Ab1+o1Qazwt+mQ/5mNYiNY8vVfjSJAM4he8TS/WwoGIQD1wJ6BsJ2ZqEi9kFRe6jtuySotBsMqCSOfb5c7Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=er1z/1kG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D561F000E9;
	Fri,  3 Jul 2026 06:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783060823;
	bh=eZEoZHnNr4XcyAWt/zRqViytkHIio5GOCNw6NACpGx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=er1z/1kG9ktQnTbuPG15zElmYdGirJFDBA60+1dL3Nzkub3RaCoEylJ5Ly2Y4Mk6O
	 smfFn/uI3P1Vhb16vCEDYc2KTSCvjbHhLl5Jo/buMLWx4gtUOKrDKbo5XJoXm1XGId
	 U1EIkODWbxgBR27aOwM4FAsJH3LtipkQB4mXqjJ227UASDwYz7ZFIlMTPe/Eq4Rw0J
	 F0T6LIOYGhxtIM/j7vYyoCLjEkdU+U4v+1RtJ3t2DUtnGPQDmHzGwQ4Fhcw304a+1Z
	 5nV8JtffCGQ4NobL++73f7EdCcAelJkcK9/ezsWNvZdLI5ILNlaz4MqiNPvMIdZnMO
	 N7s0/TA9GLL2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0964393878E;
	Fri,  3 Jul 2026 06:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] octeontx2-pf: fix SQB pointer leak on init failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178306080539.2485127.11987414191189060501.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jul 2026 06:40:05 +0000
References: <20260630071625.349996-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260630071625.349996-1-dawei.feng@seu.edu.cn>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: sgoutham@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, hkelam@marvell.com, bbhushan2@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jbrandeb@kernel.org,
 richardcochran@gmail.com, amakarov@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, jianhao.xu@seu.edu.cn,
 zilin@seu.edu.cn
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
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,seu.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271649-lists,stable=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:sgoutham@marvell.com,m:rkannoth@marvell.com,m:gakula@marvell.com,m:sbhatta@marvell.com,m:hkelam@marvell.com,m:bbhushan2@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jbrandeb@kernel.org,m:richardcochran@gmail.com,m:amakarov@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:zilin@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[stable,netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D52636FF236

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 15:16:25 +0800 you wrote:
> otx2_init_hw_resources() initializes SQ aura and pool resources before
> several later setup steps. On failure, err_free_sq_ptrs only frees SQB
> pages, leaving the per-SQ sqb_ptrs arrays behind.
> 
> Use otx2_free_sq_res() for the SQ unwind path and let it free sqb_ptrs
> even when sq->sqe has not been allocated yet.
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-pf: fix SQB pointer leak on init failure
    https://git.kernel.org/netdev/net/c/62e7df6d042a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



