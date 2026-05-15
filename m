Return-Path: <stable+bounces-247306-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJqPBBh8BmqskAIAu9opvQ
	(envelope-from <stable+bounces-247306-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 03:51:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BDD548918
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 03:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82130300B622
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 01:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CBA2E8B83;
	Fri, 15 May 2026 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKNZd/Lh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5425C7260D;
	Fri, 15 May 2026 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809861; cv=none; b=j0sSKqL4yqv2zjJzumIib+oh9IQhHSajLtpN9D8EG5CQdg+5H4q0PEi54BvoIUTdDXneDZ0XoJQ8YG7E6d+o+8z4EZXiWNo1X6HbTckojpnNdTA9Qrihl1jlrlAHt4xABqJHnFK+2ingL84nftfDmnH2S4pyLczWNo2PwrIFPJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809861; c=relaxed/simple;
	bh=lwy+Je7UuTA684S7UnzKNOTYUpSoQbkD+J2jVuPa0RQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SUPELRC+WUVwooaUZK+2lwOBHLp+aThCBrh/IYWqTIR8Qpk4lAuI30yOHNyaF5cg3m7pIs/PTNPPP7WFaoQzZ2x5E6gUC1lodiDKDlWUMz5E8KXrYnSmL2LOX941vO0GUBkjQtlOhWjayBCD3fhLi0wrOjgMyfn63gFDqcv2OUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKNZd/Lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD5EC2BCB3;
	Fri, 15 May 2026 01:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778809861;
	bh=lwy+Je7UuTA684S7UnzKNOTYUpSoQbkD+J2jVuPa0RQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gKNZd/Lhtv113JvuLaSTOA0TzVxBI3lVahnh+OMj4KINz4AF+PrgopesuKn/aEakA
	 HTSzqDCWAa6LrsV/L1+VO7gZ0fhtmJ8dy7f0EWCxrMSHoenq0PW7hQGfl0KV0rSbq8
	 XflgBpAWmVZbquHXrwzmDmsOVjh7Gl7dEyaTJju0fyEplndr1c9GXJi4pTlB2KysZY
	 i7VqrryH7rOuNDiURZagN49R4gPn3EVSE2y8Z4681Zv4DaYv6c7Pd5zhYXl9NniAWF
	 2JijnRW4YG+r5Lr4rsAt2eZE6eAe6rQA6JhxG2gwlPY6VfXMX8/MzsS57WNIA7URT4
	 A6U6FaTuMZs6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F2239E4DB8;
	Fri, 15 May 2026 01:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ifb: report ethtool stats over num_tx_queues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880980555.159407.6852919739863639604.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 01:50:05 +0000
References: <20260514013739.3549624-1-michael.bommarito@gmail.com>
In-Reply-To: <20260514013739.3549624-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, xiangxia.m.yue@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Queue-Id: 97BDD548918
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247306-lists,stable=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 21:37:39 -0400 you wrote:
> ifb_dev_init() allocates dp->tx_private to dev->num_tx_queues
> entries via kzalloc_objs(*txp, dev->num_tx_queues). Both IFB
> per-queue RX and TX stats live in those entries: ifb_xmit() updates
> txp->rx_stats using the skb queue mapping, ifb_ri_tasklet() updates
> txp->tx_stats, and ifb_stats64() aggregates both over
> dev->num_tx_queues.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ifb: report ethtool stats over num_tx_queues
    https://git.kernel.org/netdev/net/c/5db89c99566f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



