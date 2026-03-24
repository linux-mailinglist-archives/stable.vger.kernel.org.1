Return-Path: <stable+bounces-230145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI0uBUl7wmnqdAQAu9opvQ
	(envelope-from <stable+bounces-230145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:53:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EADB307AD5
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0C5C30867E1
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2473ECBF7;
	Tue, 24 Mar 2026 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLtWrj14"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7773EF0DC;
	Tue, 24 Mar 2026 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352418; cv=none; b=UbmelnJgFkx/NK9MFwJ/q7Aes9pB8T6LcuYnDJE6poXpquXY1XP+AFsnOx7Cy2uTjw2CKkGlmu+hIUYFCC3vCt5yIseOHnSMt6gG2HoYDSNmaj22JVKwAfc8XTcDNerlWJ99+qJHJclKkdPoMxdhxO3muNTVbUrV1eLm7s0y/Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352418; c=relaxed/simple;
	bh=wLHwxiPBn/hceRsZvgRM9wUed188hKcmMerr0il8ukM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J7BHDry1v0IncrxYMBwzIbwWoesYJBswvuoN6xHlJet5RhFWaFtVoC+k4w0BJSFCqc4W8aa7uFZQr3FdPDCBkPUJ+b3Nd1njR+479fCrqV/7NEGrvjAGy11we4alQ7M//2xI7Hk+v1zOc7/LAQKzRKLK9LN9sgP86a7Adw0qpY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLtWrj14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B79C19424;
	Tue, 24 Mar 2026 11:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774352417;
	bh=wLHwxiPBn/hceRsZvgRM9wUed188hKcmMerr0il8ukM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qLtWrj14iXuRyjouCccN7VWe/OpkmVzxZ0/ZT2uvnPVUYfexh6+lh9juAfQWLXlRn
	 fCiPmr1CJ8EGTF6Ta5Tjxt4/G+Vn7BXJ5VMzsr3aqLWcC9pSpWom9gMia4gVytlm+d
	 Z1KtIJqbF21PWYtXI0CPZUWIEhwXLAWjeysOJ03Jg8CcyGJby//3ni7uqRl7X2sNs2
	 SdyRcSqrI3ks4qh7jc4ffC3fTMt1ZE/YF4Ujjbyxo9xEXVyTB5IzhFKZwVIfbevqy5
	 SjHl81URq3LMh/Ro6HnnixCDVKW5JvsFn+SubRqKbEZvg3cLTwHdEnpksGTNXcYIdW
	 bNpP/cfXfSGhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF473808200;
	Tue, 24 Mar 2026 11:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: correctly handle tunneled traffic on IPV6_CSUM
 GSO
 fallback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177435240529.637293.1714179050353163820.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 11:40:05 +0000
References: <20260320190148.2409107-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260320190148.2409107-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 stable@vger.kernel.org, xietangxin@yeah.net
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,yeah.net];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-230145-lists,stable=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2EADB307AD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 20 Mar 2026 15:01:46 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> NETIF_F_IPV6_CSUM only advertises support for checksum offload of
> packets without IPv6 extension headers. Packets with extension
> headers must fall back onto software checksumming. Since TSO
> depends on checksum offload, those must revert to GSO.
> 
> [...]

Here is the summary with links:
  - [net] net: correctly handle tunneled traffic on IPV6_CSUM GSO fallback
    https://git.kernel.org/netdev/net/c/c4336a07eb6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



