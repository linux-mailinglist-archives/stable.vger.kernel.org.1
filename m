Return-Path: <stable+bounces-235560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GACrFFJx2Gk5dQgAu9opvQ
	(envelope-from <stable+bounces-235560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 05:41:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F85B3D1E46
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 05:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7D5A3019386
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 03:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6054329E5A;
	Fri, 10 Apr 2026 03:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxSl24sa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97434329C7B;
	Fri, 10 Apr 2026 03:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775792442; cv=none; b=O4oSA53moCzwJZyIzweF43WlS3ixayhSA/NynQi23nj6+zbrwX1UqDveXwGrwsRpy9y9P5zEO+EenaVvt/wQgsYPkaCs6sYW74aZ8RF5nSGWZ11j8Ic4Jp7RfczAD+N8qOv0E7apTv6Qv9XDpFHRzz3mwPd4cSlhvqxwWsCkPxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775792442; c=relaxed/simple;
	bh=aXzlY695ELQLeU8wOevQrLZVVyeNKLQhpUaT173Mz/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lDICkg6q+2OdYzUUwQ8rGcKtDpq9RHVadCEy0jBQwEs1AAObuTjnXDltRcFPNiAtb7j2/VdxPtdVL0KEIPF26O9I82kCIbCVkLcUwU6771K5LL/heDkoY9OznxQPNHG6GkI046JqACMiQt1i8CBc6yKlUV+WYZ81eohPPu5k2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxSl24sa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710F4C2BCAF;
	Fri, 10 Apr 2026 03:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775792442;
	bh=aXzlY695ELQLeU8wOevQrLZVVyeNKLQhpUaT173Mz/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uxSl24saTb3LDCWbCsz21C2h45sXpJnunRGGlE8br3RIA+uXjibidFtNBlL5KdOMy
	 MdaCzJpYy6/U8NOOMLFG9zXFXk1VBefVyclSsd3iJZOip6rGyIbzl3rcP1wVRGaSPz
	 tSeTvCv5Cqvye0guLBj7K73ZkDZVNH4CTeDI7KMzpNYyRT83uhKHBkyWTaa0adYHr+
	 xrTpzB8iNZmi6Adargh6cazGbXv3VZuxBdHY8yCGKcCG/My43TTl89+RKFdnVnYDRO
	 qwzeuy6a7IZbZDU6DTDJrhBh1FN2mRnYmuQevlgu9nVr6FNMnGI5yfMyHiHTKyBUrb
	 CagM40iE445rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EFC3809A22;
	Fri, 10 Apr 2026 03:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: txgbe: fix RTNL assertion warning when remove
 module
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177579241729.1854480.1241266241288314093.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 03:40:17 +0000
References: <8B47A5872884147D+20260407094041.4646-1-jiawenwu@trustnetic.com>
In-Reply-To: <8B47A5872884147D+20260407094041.4646-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, mengyuanlou@net-swift.com, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235560-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F85B3D1E46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Apr 2026 17:40:41 +0800 you wrote:
> For the copper NIC with external PHY, the driver called
> phylink_connect_phy() during probe and phylink_disconnect_phy() during
> remove. It caused an RTNL assertion warning in phylink_disconnect_phy()
> upon module remove.
> 
> To fix this, add rtnl_lock() and rtnl_unlock() around the
> phylink_disconnect_phy() in remove function.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: txgbe: fix RTNL assertion warning when remove module
    https://git.kernel.org/netdev/net/c/e159f05e12cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



