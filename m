Return-Path: <stable+bounces-249726-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ON63DsEVDWq5tAUAu9opvQ
	(envelope-from <stable+bounces-249726-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 04:00:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DBD586AD8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 04:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F2493085404
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 02:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651C82F1FC7;
	Wed, 20 May 2026 02:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok6SkAvu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE002FE05C;
	Wed, 20 May 2026 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779242409; cv=none; b=m1EA2jYulTlKsB1zrht6owgDOr3VBantI0HaQ1OxXbrW5AENIbY++NDvmQN/r41lI4c2dqgi8oWYyUpLxniz8eZ+uH8mj8QOWs5cO5DJUifE3MJGwW1oYwPQMfZnV0CCswtwS3gXjO8oljfF48wMd0bIUI5BjGNPbxXrZQv303Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779242409; c=relaxed/simple;
	bh=2W9HTD8O/MOYfZ0KHiwHQ27DUtcUaYykjt5Hyzyt0Lo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u2vAgeOSkm7Gb9S7HIfobSWUeqj2vYXdVW/6D5h4S65c4WrDfqlrVhxgE9+Q3v8aFK2PbUefvUIVsV5+flBUHSaxDXNDwa10cJVcrf0r5BobVxZOTMzQgmWZEdB1Nq/+vpc1Mg+sDgQIdaVHy6b0fvPdX2KocO1INi5/m/dC+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ok6SkAvu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FC81F00893;
	Wed, 20 May 2026 02:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779242406;
	bh=EaemTVus20QpF13kkwCIb4CoIpSayKfU7ArHN+mZ7Hs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ok6SkAvuCVLR6YlhZCDaqpLFrHK/HCMgrSi8SuJzBZoHZT4CfUXzFHdMb3agfcw3S
	 9VXRenOOVLfQLkXNWuKHmt40ADRhm03qH2vvnI4POawzA0iEHsG2nr/fFdCSzgHDij
	 TDQtr/k6/xhPfSDk0hPbpoNrgX8iwr9hZbMOImRZb3RYFSE3NPFTNnZVNw9Qoenn6h
	 k/3REJpU/v3Ly8I2X5l4xzBPZeC4Afkr5B8MU2sI8GhoDOBrZVDBJf3AQJpIKCgouO
	 hJajMob6+PR2/WMwcwTwaYX5GOR3M5QZu2K5CNUu3ko097S0WlFl2aEnpMuBl+WQz6
	 qR90I4W2i6Ylg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09D9383BF53;
	Wed, 20 May 2026 02:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: skip EEE advertisement write when
 autoneg is
 disabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177924241739.2949285.10631231367774402026.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 02:00:17 +0000
References: <20260516150251.879680-1-nerijus.bendziunas@gmail.com>
In-Reply-To: <20260516150251.879680-1-nerijus.bendziunas@gmail.com>
To: =?utf-8?b?TmVyaWp1cyBCZW5kxb5pxatuYXMgPG5lcmlqdXMuYmVuZHppdW5hc0BnbWFpbC5j?=@codeaurora.org,
	=?utf-8?b?b20+?=@codeaurora.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 rmk+kernel@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	NEURAL_SPAM(0.00)[0.908];
	TAGGED_FROM(0.00)[bounces-249726-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,?=,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E4DBD586AD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 16 May 2026 18:02:51 +0300 you wrote:
> genphy_c45_an_config_eee_aneg() writes the EEE advertisement to the
> auto-negotiation device's MMD register space (MDIO_MMD_AN, register
> MDIO_AN_EEE_ADV).  These registers are read by the link partner only
> during auto-negotiation, so writing them while autoneg is disabled
> cannot influence the link.  On some PHYs (e.g. Broadcom BCM54213PE)
> the write nevertheless reaches the chip and disturbs the receive
> datapath.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: skip EEE advertisement write when autoneg is disabled
    https://git.kernel.org/netdev/net/c/960e77ce14a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



