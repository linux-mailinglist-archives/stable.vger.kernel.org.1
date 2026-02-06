Return-Path: <stable+bounces-214587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBJ5Ip1bhWnNAQQAu9opvQ
	(envelope-from <stable+bounces-214587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 04:10:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB49BF993D
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 04:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07156300623B
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 03:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37F3313264;
	Fri,  6 Feb 2026 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsXZpNWm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723392E5B05;
	Fri,  6 Feb 2026 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770347413; cv=none; b=QmRenaEv1W8tG//lxsLwTVB0GwQfzfh0NIH/1FVaLmchv1ydC0So3d4YGilKuZHFUjewb5xiLrywCAYmtEFCmHbwaLtFjPN/4YTjmLGyxt12zhWh+nOdYR4VJAs9Bd9Vh9Yv2YubfeP5nnhR8mh4qR/WepEnX5HvsfYq95f6FTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770347413; c=relaxed/simple;
	bh=/eLo0XeI1iEAxXm9gSsI46aen8LeyLruZ5g9DaJuHxo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=deZWJi8UyoHeyi2zLfJetwvoBWIJfG9dHoeTRtwOZj9/XT2t2acO88YIcsFbzXBb5Ae8quhd1x1Pa9aozNmcHafuJQRmdP/zR29WCKXXkT3nQIMf6ORJz3WnNQqc9IweQqYQEPWI53oeXilbhY9sRP97EClAY8Vmj3zeE1UmsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsXZpNWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051F3C4CEF7;
	Fri,  6 Feb 2026 03:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770347413;
	bh=/eLo0XeI1iEAxXm9gSsI46aen8LeyLruZ5g9DaJuHxo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GsXZpNWmln+YMO60LcCtZhaT3phXq5paeFQEHG5aHGWc9PaVt7jBmQVWjxw2YxtSg
	 m+VwLBnIRBl/N7ZtFFVjDoM9QwpmTv+8EYGRwpSk+MKJR8doprIPj6jSNVekom+I3+
	 GcHIOdeu18lgyAvLkqALU38aiziXDGGVeHt5I/ya1KGBzBD0g7oPSpeHiDj6V6Ywxo
	 IrTyoaLv/gy9l2iAKhFG/FjZ+t41mBCtcLzFRDVBcU0KTNA7Elq8c5syL7HF79iKu9
	 5Pna1CqKngKXRxVPLk9nmCyeU7byJXF2ecPHBe4M+AWotMySwnl+cId2UfFdFHfHHa
	 d6AlSOhfUvemw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C223B3808200;
	Fri,  6 Feb 2026 03:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: cpsw_new: Fix multiple issues in the
 cpsw_probe() error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177034741058.664781.7836575985509758726.git-patchwork-notify@kernel.org>
Date: Fri, 06 Feb 2026 03:10:10 +0000
References: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
In-Reply-To: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, s-vadapalli@ti.com, rogerq@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com,
 saeedm@nvidia.com, daniel.zahka@gmail.com, lorenzo@kernel.org,
 alexander.sverdlin@gmail.com, nicolas.dichtel@6wind.com, m-karicheri2@ti.com,
 ilias.apalodimas@linaro.org, grygorii.strashko@ti.com,
 linux-omap@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214587-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,nxp.com,nvidia.com,gmail.com,6wind.com,linaro.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,nvidia.com:email,nxp.com:email,lunn.ch:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,davemloft.net:email]
X-Rspamd-Queue-Id: BB49BF993D
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Feb 2026 10:47:01 +0800 you wrote:
> These two patches address duplicate or unnecessary netdev unregistration
> in the cpsw_probe() error handling path.
> 
> ---
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Daniel Zahka <daniel.zahka@gmail.com>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: linux-omap@vger.kernel.org
> Cc: stable@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: cpsw_new: Fix unnecessary netdev unregistration in cpsw_probe() error path
    https://git.kernel.org/netdev/net/c/62db84b7efa6
  - [net,2/2] net: cpsw_new: Fix potential unregister of netdev that has not been registered yet
    https://git.kernel.org/netdev/net/c/9d724b34fbe1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



