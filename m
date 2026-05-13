Return-Path: <stable+bounces-246728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIc6Cn70A2rKBAIAu9opvQ
	(envelope-from <stable+bounces-246728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 05:48:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A8A52CF5C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 05:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA19E3088D98
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 03:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AE83921DE;
	Wed, 13 May 2026 03:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQUx4m75"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4F7357CFD;
	Wed, 13 May 2026 03:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643963; cv=none; b=l5KCzEpV031StfiC790K480u3Qs8pZUIaLxxoKjSy+uTFqZO8KjMJ/iXxPOvImO6XG1D3GGbbaPW6QEgqEdWEtcdwLb4aGLVy0tJ60yKc1p5YDh1e2kOdoIWIwYkLluqGJ/1ulNBc9rEHgkAHpMgw/0zjfPI3yWLU2X1//eyglA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643963; c=relaxed/simple;
	bh=W+2DW89lWk0ctxlivObCdElbjDuLO/zBU+7dq31WdDo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lB9MD5BPeG/DAFJu92hr+iWJtbSVjzXJEbDBihh+BrK9AaPiPWMA0MoWl7q4StxC/RDs+KDddjLhVhUK1AbmYuf4xPMQ0puIHsUTvpPZLgQK6e2lbIDw20UyrW4QAlwfwM9WPatCbv0ytgJ+s4TnNfHM29d6lnSP9FNiAP1CLZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQUx4m75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90248C2BCC7;
	Wed, 13 May 2026 03:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643962;
	bh=W+2DW89lWk0ctxlivObCdElbjDuLO/zBU+7dq31WdDo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PQUx4m75Z6R4YBqxZX2Mca/rStukyU2uP5fArfXd0WkhYzuHSufhdqEZEU6Swc/o4
	 df2OrYI8O/ZNeWIne77zRzxhy5ee9NoVdtGVF8ONweh6NBcJc2zzdBetE4HDnp5v4O
	 +PUKfkBPiosTNFVZyVMwstx5bheE9n+pLZGklWIG1XSP924xjbgE2nVYA7XCWl+7Ly
	 3yHx/VGiJpEeFO1luEk8iM7PETRYOnZR+1ujXCQ9WIF+1fUKSBYpX8KyC9wwsLydE2
	 C5tEMaXmJNsu5HpE6B/1A8HH57IqPDpFq1iiKDgaI+Yf8K5JMN8WvegTiHNVfC8UFt
	 a8SgzGbyUOR3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE543822D60;
	Wed, 13 May 2026 03:45:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethtool: phy: avoid NULL deref when PHY driver
 is
 unbound
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177864390830.3173643.3244266251206585026.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 03:45:08 +0000
References: <20260509215046.107157-1-devnexen@gmail.com>
In-Reply-To: <20260509215046.107157-1-devnexen@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: andrew+netdev@lunn.ch, hkallweit1@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, maxime.chevallier@bootlin.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Queue-Id: D5A8A52CF5C
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
	TAGGED_FROM(0.00)[bounces-246728-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,bootlin.com,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  9 May 2026 22:50:46 +0100 you wrote:
> phydev->drv can become NULL while the phy_device is still attached to
> its net_device, namely after the PHY driver is unbound via sysfs:
> 
> 	echo <mdio_id> > /sys/bus/mdio_bus/drivers/<phy_drv>/unbind
> 
> phy_remove() clears phydev->drv but doesn't call phy_detach(), so the
> phy_device stays in the link topology xarray and ethnl_req_get_phydev()
> still hands it back. ETHTOOL_MSG_PHY_GET then oopses on:
> 
> [...]

Here is the summary with links:
  - [net] net: ethtool: phy: avoid NULL deref when PHY driver is unbound
    https://git.kernel.org/netdev/net/c/e3adf69f8eb1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



