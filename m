Return-Path: <stable+bounces-235293-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Mz8EFcI12myKggAu9opvQ
	(envelope-from <stable+bounces-235293-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 04:00:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 420473C569F
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 04:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A6839300F2AF
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 02:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7DB366566;
	Thu,  9 Apr 2026 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjwvgFiB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60DF364EB6;
	Thu,  9 Apr 2026 02:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775700047; cv=none; b=RoGY0O1heR1PWOqBHDvz4F/8MAqQrkcF640CJHQckm18+SDgFHEleMYprtWP735+5Zy6/IfFIqGH/IPy44LJF61TUrRzY2Fi5XerCi7qZkVXcg/HcoFDvG0REIJEy+pYr4Ez8BqxMalqkQR1IUXBBZVwpdovfkHP/AFRKEA0lfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775700047; c=relaxed/simple;
	bh=1Ik+p3abS9OZ07JrhV9UEcCWYqEcGNXF8R5GBJ4RPVE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nF2D8jvyniSKSUwEQWSNdjU3E1NebE2i7f8sA9hOBjcZDw61Yo8+L+c8EswB6NzDeBRZ3Iw8ptoUeFYKil6WaLujs3ZoTzaUtwvZdFUbmkZ7wmXfOxOfE6V7gieIDow+8Lxf2ueALCXqQWp0CElF3fUvsCOwMdTXF2XFncUpYt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjwvgFiB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D42C19421;
	Thu,  9 Apr 2026 02:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775700047;
	bh=1Ik+p3abS9OZ07JrhV9UEcCWYqEcGNXF8R5GBJ4RPVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FjwvgFiBMyCtNwwXzcfNa6Q8Utw8WVRESvs3jnFmy1+N1crR6+PhaJMCEgUDLIBLy
	 fALZYODDBYRvnTbhuA5TDmlzrZpXzJkPs4JKCzEKqquHbYPvJmiRPaeel9Q338NLHF
	 pxRWob3QZwwNqI1phJ/hk4dbUdVCu4qzcLlbfqU33egYopt0FpSLzWGAbL4K1986xt
	 3wO5VLEwPYMghS0jJr0gw5hEkapNEkkaHs//nsidEGbA7uTPg5mW7IlJG3uh4BZsER
	 ugKGw0S+gVzvWnDylmeK2UWECtDjuDSa7TIyjcdZkM8euCHbBI6mwYBA6OuXQan+lw
	 PGn9aOVTQ0uXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030783930793;
	Thu,  9 Apr 2026 02:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] batman-adv: reject oversized global TT response
 buffers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570002357.953143.3280189136454174077.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:00:23 +0000
References: <20260408110255.976389-2-sw@simonwunderlich.de>
In-Reply-To: <20260408110255.976389-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, caoruide123@gmail.com,
 stable@vger.kernel.org, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 yuantan098@gmail.com, bird@lzu.edu.cn, enjou1224z@gmail.com,
 n05ec@lzu.edu.cn, sven@narfation.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,vger.kernel.org,lists.open-mesh.org,gmail.com,lzu.edu.cn,narfation.org];
	TAGGED_FROM(0.00)[bounces-235293-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[simonwunderlich.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 420473C569F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Wed,  8 Apr 2026 13:02:54 +0200 you wrote:
> From: Ruide Cao <caoruide123@gmail.com>
> 
> batadv_tt_prepare_tvlv_global_data() builds the allocation length for a
> global TT response in 16-bit temporaries. When a remote originator
> advertises a large enough global TT, the TT payload length plus the VLAN
> header offset can exceed 65535 and wrap before kmalloc().
> 
> [...]

Here is the summary with links:
  - [net,1/2] batman-adv: reject oversized global TT response buffers
    https://git.kernel.org/netdev/net/c/3a359bf5c61d
  - [net,2/2] batman-adv: hold claim backbone gateways by reference
    https://git.kernel.org/netdev/net/c/82d8701b2c93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



