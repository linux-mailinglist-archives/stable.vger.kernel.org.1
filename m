Return-Path: <stable+bounces-242229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFXhEI0A9Gn99QEAu9opvQ
	(envelope-from <stable+bounces-242229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 03:23:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4134A99C8
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 03:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E38A3055829
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 01:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CF32D6E5A;
	Fri,  1 May 2026 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kxudr5Dz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A441E492D;
	Fri,  1 May 2026 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598459; cv=none; b=Y0hUWyFdkw5uF0ZWmPlcH1REw1RA7TaANWq2iK0nzZmL33A4uSpgPJPrBPa96Jtxj5xdd9uQAt5KcGDDsc/blPMO0TrSIHfjFCcv/E/l8wu2waPOIRJaABH1292xBvz4RTBp+5Y0pggtvShsckPD/xK/6eKRL5QRvJrVQNFYvXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598459; c=relaxed/simple;
	bh=fYIBD4JwlYANTmqpm3aRtaWP0pMgr+qaMmiU2WN8LWI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N0Rzzb/le1TwtcYLoAS1R5JhLTB7NgpQxNgd598o2+8puLsfO8ofL7swljdq12FG6FqdsRQdLTetOkD7mbKe2X66CwjUGGKmowDhCc1GtuYfPnd+ZmqIVk2J4Ciqch8/HI03fNhosrXYyUThxcDWJPQDcdZHV0oix46Mk/Az2ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kxudr5Dz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05C8C2BCB3;
	Fri,  1 May 2026 01:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777598458;
	bh=fYIBD4JwlYANTmqpm3aRtaWP0pMgr+qaMmiU2WN8LWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kxudr5DzG5F09H4GfGglCKCxnkuWHrGAfqhZY3qQdCeQp4U6ULTlR9OL+Pas2X9Ap
	 UT4k1fWGCAlyp6BhN+69QQynHUkM2buEmUCfavNbN+iwUDJdghMB981Sit/4svZiZP
	 h2fvI1JnkAFJsTJIKc1qmw5FVNLJeXK2UOW3arNHQHynZqARfwPBXt/mrzBLgcUQVg
	 SXY8tH3+wXT3bwn86ZZ1F3WKA4rCdPspg+H7sE3IEq6T1ndZR9ylHh4VLHGVlV/43p
	 RHEmeU90V526EszDgZuS72G9No22i9nSFib7EVdyk+sc+U+0FtljrsMfBYqxkaJO8j
	 lTsccQWDtC2ZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCED380A957;
	Fri,  1 May 2026 01:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net: libwx: fix VF illegal register access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177759841283.3278779.7739774062727913267.git-patchwork-notify@kernel.org>
Date: Fri, 01 May 2026 01:20:12 +0000
References: <4D1F4452D21DE107+20260429083743.88961-1-jiawenwu@trustnetic.com>
In-Reply-To: <4D1F4452D21DE107+20260429083743.88961-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kees@kernel.org, stable@vger.kernel.org
X-Rspamd-Queue-Id: 9C4134A99C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242229-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 16:37:42 +0800 you wrote:
> Register WX_CFG_PORT_ST is a PF restricted register. When a VF is
> initialized, attempting to read this register triggers an illegal
> register access, which lead to a system hang.
> 
> When the device is VF, the bus function ID can be obtained directly from
> the PCI_FUNC(pdev->devfn).
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: libwx: fix VF illegal register access
    https://git.kernel.org/netdev/net/c/694de316f607
  - [net,2/2] net: libwx: use request_irq for VF misc interrupt
    https://git.kernel.org/netdev/net/c/7a33345153ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



