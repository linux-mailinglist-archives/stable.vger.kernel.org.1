Return-Path: <stable+bounces-217534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L64OtLfl2n99gIAu9opvQ
	(envelope-from <stable+bounces-217534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 05:15:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEBE1649F1
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 05:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CBDE302E778
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 04:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B7733122D;
	Fri, 20 Feb 2026 04:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0PWe5C5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A7307AF0;
	Fri, 20 Feb 2026 04:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560660; cv=none; b=F4L3vOoRwN88jvtFrCSs27H1l3vmDh3irGn7E8G+OK9ZrZ3s36bb9+YsdcFHBbVNUpcReVZ36rVx593S7zOg1+wS8bnCEXmUGp/XFNEKEApYZy5tuskFKklGQt/HZ3BvTgajh8Mw52PIXkhkm6oOftkGNFE/9hkvoPxrxe1E+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560660; c=relaxed/simple;
	bh=efjNDJhM9/0diWvBdyGOzP+K21cHz4kM08BrUOfEDRQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IWO6dQF+zx6LeNT0z9NE/vTxWFxLNOhuBzhICPJqISUjNgGDaTquO9+GJO2GQ1k7J3bSZzLIPOgxWwkf+1Hbxnsx65lFBWKs0ec+UeIEsLWxPC/Nfl5Z8uxM7+yAfk1ayT362r+/oygCJUQdUPBVYIgFmpppfunqY6qv3DUneQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0PWe5C5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98269C116D0;
	Fri, 20 Feb 2026 04:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560660;
	bh=efjNDJhM9/0diWvBdyGOzP+K21cHz4kM08BrUOfEDRQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s0PWe5C5DfEFXvhOpNI7PD7CfmjfKkPnl3Er379KNRdps2JQFPoznWKtIkmcobcVj
	 nQGi5AvNQIMtqm29dzcR5JBEXVOZSjC7/ZSGvbUqAjqj6fjih/3Cdnzx4k5/VQHovv
	 ECXpPMVdp67gRv7WTlabd5cKSHZtj0ctTJFvMgi61cM01rTpuh1Is+QEtCJGhUE663
	 9hoUXMixh3D7BmD//K3rb0GT9JknVLzSS86miuq3vnneDb0PWVddPNyTDKBWT/Z6D+
	 gOTX9B5N+2k/Cw40A/fepclZYN9UHV/XHkBeirJhkb+CduzAOhngVE89qjJeVFNg1n
	 beYdy47j4zHmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE9B3809A88;
	Fri, 20 Feb 2026 04:11:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: spacemit: k1-emac: fix jumbo frame support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177156066878.189817.17095459510292198861.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 04:11:08 +0000
References: <20260130102301.477514-1-tmshlvck@gmail.com>
In-Reply-To: <20260130102301.477514-1-tmshlvck@gmail.com>
To: Tomas Hlavacek <tmshlvck@gmail.com>
Cc: linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
 spacemit@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dlan@kernel.org, wangruikang@iscas.ac.cn,
 stable@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-217534-lists,stable=lfdr.de,linux-riscv];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CAEBE1649F1
X-Rspamd-Action: no action

Hello:

This patch was applied to riscv/linux.git (fixes)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Jan 2026 11:23:01 +0100 you wrote:
> The driver never programs the MAC frame size and jabber registers,
> causing the hardware to reject frames larger than the default 1518
> bytes even when larger DMA buffers are allocated.
> 
> Program MAC_MAXIMUM_FRAME_SIZE, MAC_TRANSMIT_JABBER_SIZE, and
> MAC_RECEIVE_JABBER_SIZE based on the configured MTU. Also fix the
> maximum buffer size from 4096 to 4095, since the descriptor buffer
> size field is only 12 bits. Account for double VLAN tags in frame
> size calculations.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: spacemit: k1-emac: fix jumbo frame support
    https://git.kernel.org/riscv/c/3125fc170169

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



