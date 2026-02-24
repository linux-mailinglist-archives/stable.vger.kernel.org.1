Return-Path: <stable+bounces-217906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAQUOFeXnWnwQgQAu9opvQ
	(envelope-from <stable+bounces-217906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:19:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E03186D3D
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33F6F305A42F
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 12:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C122DB789;
	Tue, 24 Feb 2026 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJPMNiah"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA59B25A2C9;
	Tue, 24 Feb 2026 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935572; cv=none; b=Amak41/zjzjiYJ719wuNSiuFd6A/Z/cup6bp9r+2/zN1XONnkoDXg9MvVPv9ddWZLB7QmbEw2e+iwSo21OIsF9OU0geR56Gm9azWMJA0RuZ5jUw9/Jz7xtK/H6Id4jhIH3tE6KShkoLPuBHSsauXLea7hDzsjhLVVlcMNWvaSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935572; c=relaxed/simple;
	bh=PcJ8nkbO1UGzuf5J5H47QPdDNyslM/4MgHQeOSVKCEA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nnOp0ykvtG4ttEBJnA6HPiNjwLRW690ExBZJmStLVdmMGv4udqFcxIPjzwSQOOwxldGAFaLdZtB//0Wfdzry9YmFzvRFnqqoNGH+u5dnBZu9JTzEix6d9f035aL+6GdKeT9heZcvnMt+ioC4ugTpLiPRepL6//0R5hKS82fULeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJPMNiah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC64C116D0;
	Tue, 24 Feb 2026 12:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771935571;
	bh=PcJ8nkbO1UGzuf5J5H47QPdDNyslM/4MgHQeOSVKCEA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qJPMNiahLN+ZuWftld898lLuYjdTF+OH21dVf3i3om/49ZnNkAO02xjUpomDpoRbW
	 mawNBYJNCdqU76I2x2W3zLbq1lqJ6i8caHPSGeN0M+JzYeQIFMO2KeO0SOROUE9wan
	 lwXSiqqqBQg9Eusc9QRdKXITmVfBM2K/mnFFLaGyxUFtOOT/qk2lFBvTwBltV2LrBc
	 VAEekm4G4hHgIHd7apK6PnfxTYOKDXacrTe0gHZ/Z+q144rQixJwNjkZHh2IQmi6Bb
	 0LZEiCFvqq9AQcG4V3XbOgbTfJ2EumYsRWYjrzKcElmJbniKb6bcrSpfuq5d75omgT
	 FP5vz8Euwkb/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0853808200;
	Tue, 24 Feb 2026 12:19:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net] net: phy: register phy led_triggers during probe to
 avoid
 AB-BA deadlock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177193557703.3453706.12559659267751211027.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 12:19:37 +0000
References: <20260222152601.1978655-1-andrew@lunn.ch>
In-Reply-To: <20260222152601.1978655-1-andrew@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, netdev@vger.kernel.org, rmk+kernel@armlinux.org.uk,
 hkallweit1@gmail.com, pavel@ucw.cz, jacek.anaszewski@gmail.com,
 ben.whitten@gmail.com, yangshiji66@outlook.com, stable@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217906-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,davemloft.net,vger.kernel.org,armlinux.org.uk,gmail.com,ucw.cz,outlook.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90E03186D3D
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 22 Feb 2026 16:26:01 +0100 you wrote:
> There is an AB-BA deadlock when both LEDS_TRIGGER_NETDEV and
> LED_TRIGGER_PHY are enabled:
> 
> [ 1362.049207] [<8054e4b8>] led_trigger_register+0x5c/0x1fc             <-- Trying to get lock "triggers_list_lock" via down_write(&triggers_list_lock);
> [ 1362.054536] [<80662830>] phy_led_triggers_register+0xd0/0x234
> [ 1362.060329] [<8065e200>] phy_attach_direct+0x33c/0x40c
> [ 1362.065489] [<80651fc4>] phylink_fwnode_phy_connect+0x15c/0x23c
> [ 1362.071480] [<8066ee18>] mtk_open+0x7c/0xba0
> [ 1362.075849] [<806d714c>] __dev_open+0x280/0x2b0
> [ 1362.080384] [<806d7668>] __dev_change_flags+0x244/0x24c
> [ 1362.085598] [<806d7698>] dev_change_flags+0x28/0x78
> [ 1362.090528] [<807150e4>] dev_ioctl+0x4c0/0x654                       <-- Hold lock "rtnl_mutex" by calling rtnl_lock();
> [ 1362.094985] [<80694360>] sock_ioctl+0x2f4/0x4e0
> [ 1362.099567] [<802e9c4c>] sys_ioctl+0x32c/0xd8c
> [ 1362.104022] [<80014504>] syscall_common+0x34/0x58
> 
> [...]

Here is the summary with links:
  - [net] net: phy: register phy led_triggers during probe to avoid AB-BA deadlock
    https://git.kernel.org/netdev/net/c/c8dbdc6e380e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



