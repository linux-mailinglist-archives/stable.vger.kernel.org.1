Return-Path: <stable+bounces-225442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAnjDnW3tWkj4AAAu9opvQ
	(envelope-from <stable+bounces-225442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 20:31:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C627C28E9C0
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 20:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75424303466C
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 19:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCE634D3B5;
	Sat, 14 Mar 2026 19:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHh/Kztx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E0303C97;
	Sat, 14 Mar 2026 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773516614; cv=none; b=owlruiUoWaRvfowRWCxxvApgN0UJG3LJw5hus7kONil2OhtnFuJlSvDiMV7NbalIM8MZUdin73yWLHmPlOYYDk+elBCgwqxg+TteIPjXN/dJE4bh3v3+mzR3QgG5/ASl/aW6nedvkv1SxzpdPOR3XnXfJstCxEFJ8/4+m3v/v90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773516614; c=relaxed/simple;
	bh=zmDFLImBATrlY5PX+2lUXOVkdP0lQVU0kz9DlM4p4Qk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VM92lByFQn40IHg43mX8GDQe6LEpRFBo9qdK3DuWI2sSaEln1GRd3GwTeZlebCVIORQohylJ4GqBnDeLuMI80R0fYGiEkbIsy43FZD+IuObrTjYU7cIhhQiBtXQaBjvwNW1yxlh+YAUq5pLAOPAm/aC1vMtSYrwJfVNz01ZKjOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHh/Kztx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFECC116C6;
	Sat, 14 Mar 2026 19:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773516613;
	bh=zmDFLImBATrlY5PX+2lUXOVkdP0lQVU0kz9DlM4p4Qk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aHh/KztxU7iwBEtOksUZoBj0wDg9oZiP6+sw12vXDujKYB3B548tTMxG5E+SqcPlw
	 mvKHgiqB2XnsfeL68MgLlkXiQCfmGJo2NZaQ2q3V+UkeZkzRsXK3ZjA0KL/li0OW6B
	 3IRiS1RuB/IsD6iqgJF5emWUNTqANUlk2KClybyQ0CrCuq3dTf9Ak6LR5025jlP/FZ
	 dXyt+gXy5pRTdzGFMjm9fjFJDBHxgW5K0ckiXl848VuMSetE70trjldecGP0NQth5r
	 RJbM8VTKF3OWS81HWQHoD+1rktC+UU8cgm+N4kzgpncIGdbIVzOLY1czU6og4BWK1H
	 NnlSqUUUI96GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DC33808200;
	Sat, 14 Mar 2026 19:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: macb: Fix Ethernet malfunction on AMD Versal
 board after suspend
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177351660779.1763199.11769087375422491221.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 19:30:07 +0000
References: <20260312-macb-versal-v1-0-467647173fa4@gmail.com>
In-Reply-To: <20260312-macb-versal-v1-0-467647173fa4@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 quanyang.wang@windriver.com, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225442-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C627C28E9C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Mar 2026 16:13:57 +0800 you wrote:
> Hi,
> 
> On Versal boards, the tx/rx queue pointer registers are cleared after suspend,
> which causes Ethernet malfunction. This patch series addresses this issue by
> reinitializing the tx/rx queue pointer registers and the rx ring.
> 
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: macb: Introduce gem_init_rx_ring()
    https://git.kernel.org/netdev/net/c/1a7124ecd655
  - [net,2/2] net: macb: Reinitialize tx/rx queue pointer registers and rx ring during resume
    https://git.kernel.org/netdev/net/c/718d0766ce4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



