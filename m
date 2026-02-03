Return-Path: <stable+bounces-213165-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLnCB4B3gWk0GgMAu9opvQ
	(envelope-from <stable+bounces-213165-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 05:20:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C8AD461A
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 05:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 325AE30209FE
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 04:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696281EA7DF;
	Tue,  3 Feb 2026 04:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKGh6I5Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2921943AA4;
	Tue,  3 Feb 2026 04:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770092409; cv=none; b=kghyMtYBI5AtflZUtCDvG9Mh2smG3aFWJNMgY+MN4WGTDbRbC1N8s3j6WSUX6NzOUiFX/UwhSGb8jIFbfhSWwX/5LXemzET+apCmUl/W94sw5O8koPyUIJq658cauGYUVcQhta+loG/zRFTwCN65x9jVlaK7Qhvf8UHA3EqiI+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770092409; c=relaxed/simple;
	bh=0YAWDIS+eysLPVl7yK0G0fnhNv1PM/4TCL5u/TuVNpI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tNzTm0ZKuaAR55nlBFhI/Ac7+IkfQIysIytr+xksM997z7saXHvMtsDeH4Biebuwwb/diOP5rooj+zGcNv/rUyh70qjiPNT2qqnjVrnq/rA6Mbl3CByGYuG8hB3FZc+aSUHS26jFHTYggQTOjhT2siIIXwdjHZSg8e1CAYMaJ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKGh6I5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9611C116D0;
	Tue,  3 Feb 2026 04:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770092408;
	bh=0YAWDIS+eysLPVl7yK0G0fnhNv1PM/4TCL5u/TuVNpI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UKGh6I5ZSbFuQyF6DyfPCFHB9zdBfTUzUeJCejaTBm/dpEDVsBM9akcfz3ux8mjSN
	 V1GGYH7vDQuV6SIe/LPBTMFw0tV7KFHHMj74U1Nl1DEZATxxV+Apfi1UU2R4TPvm81
	 p586sz5MMkfS8KUKTGZFF2vHVgfyJ01+ADhtSsbgPWPVUT2XYTGX8oChOUyQg4LhjC
	 fANHZLY9Px53Wst1UDYbFQNpV3xWQ+XSv+K975fxhQ5ENsHYcY7aRzFc0qzYUQPV68
	 caRRSkpontpG4cOKKEKWy/Wl2kId12Yd2BtpjqbnnxUTwhqVo8h7Qzr5O0Rqz9T7Z7
	 DG0+ZRQWAJRKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9104D3808200;
	Tue,  3 Feb 2026 04:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: spacemit: k1-emac: fix jumbo frame support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177009240524.1309272.13521907862288181709.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 04:20:05 +0000
References: <20260130102301.477514-1-tmshlvck@gmail.com>
In-Reply-To: <20260130102301.477514-1-tmshlvck@gmail.com>
To: Tomas Hlavacek <tmshlvck@gmail.com>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dlan@kernel.org, wangruikang@iscas.ac.cn,
 stable@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-213165-lists,stable=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 73C8AD461A
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
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
    https://git.kernel.org/netdev/net/c/3125fc170169

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



