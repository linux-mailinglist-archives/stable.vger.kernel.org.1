Return-Path: <stable+bounces-227190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA3JFoVHu2kliQIAu9opvQ
	(envelope-from <stable+bounces-227190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 01:47:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB812C42D0
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 01:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEB80318E31D
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 00:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB78B246BC6;
	Thu, 19 Mar 2026 00:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTI7Yxrf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921E24169D;
	Thu, 19 Mar 2026 00:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881067; cv=none; b=WSWnrxu7No7Shr3tPmUXZK641DXjr+Zcsd+CxC1IpGLH3HfHu6Wa9HVWUoB8euXLV9GgT/V/KGjYBn+RxVscDDYBpL4OhB9nXK56lGtqoc4Vr0b0rMX95xrTVYIVQFjGPk67ciholxaLyCRLfdwDbBIeBd87G5ioY+glaQUPNiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881067; c=relaxed/simple;
	bh=OfjwWJbX7miTvmmpKF5xCTv5jKV5BQApUTvcF0QKlQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M/Om5VYNUnt+knicrg6ZNzipIAgPlzBuTedru4uEPakAY61Lt0894phHFkYzhKjsCefYe+sqzxySa7UvNDdu2DPtngZTypDhksJxTJNdR9iGJDY5+Ot/+r4FrH9ChXd+w6mWwQN0IG5t1xTmbHvmPSFvQVfK1Y8viN4wohPGnkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTI7Yxrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B0DC2BC87;
	Thu, 19 Mar 2026 00:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773881067;
	bh=OfjwWJbX7miTvmmpKF5xCTv5jKV5BQApUTvcF0QKlQ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MTI7YxrfusCOqb3tQjfUq6saumr5WjeHZyTSdykx9uoHu6ZiV75FcU3DfG44rD3/v
	 EENH6SHUuMLeTDOVZw9fH8UgrEfyUI6qLX9NN9Tw7FriViIqljLAqKrc70Q2B31eln
	 mJ2ReUoyDl/6Af46kcPqlPGoNaKfJ7j55iC10IPUFCEAPWauvS+hiRAw76mqXjrEJX
	 Yh0YetlQ68k+Mvxm53ViPKJphN7ndu+VYEH0x6CsGUCSQXyAY01WX1IhOOmWTi75IX
	 Y4fsGwzIGqF2VugflJn5jI16RXI9kfnPu2gJCp5lbxy9BqOe/DvN/aulooPlTJa0e+
	 ym0l+v0JL/Acw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0993808200;
	Thu, 19 Mar 2026 00:44:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: macb: fix use-after-free access to PTP clock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388105853.935482.1067473312108784098.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 00:44:18 +0000
References: <20260316103826.74506-1-pchelkin@ispras.ru>
In-Reply-To: <20260316103826.74506-1-pchelkin@ispras.ru>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 rafalo@cadence.com, Andrei.Pistirica@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227190-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,cadence.com,vger.kernel.org,linuxtesting.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.958];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFB812C42D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Mar 2026 13:38:24 +0300 you wrote:
> PTP clock is registered on every opening of the interface and destroyed on
> every closing.  However it may be accessed via get_ts_info ethtool call
> which is possible while the interface is just present in the kernel.
> 
> BUG: KASAN: use-after-free in ptp_clock_index+0x47/0x50 drivers/ptp/ptp_clock.c:426
> Read of size 4 at addr ffff8880194345cc by task syz.0.6/948
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: macb: fix use-after-free access to PTP clock
    https://git.kernel.org/netdev/net/c/8da13e6d63c1
  - [net,2/2] net: macb: fix uninitialized rx_fs_lock
    https://git.kernel.org/netdev/net/c/34b11cc56e43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



