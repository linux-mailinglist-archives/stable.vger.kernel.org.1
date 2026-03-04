Return-Path: <stable+bounces-222963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO2IC5WMp2nliAAAu9opvQ
	(envelope-from <stable+bounces-222963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 02:36:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7721F9854
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 02:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E879331F7F54
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 01:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E924930E0E5;
	Wed,  4 Mar 2026 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nalHdQ48"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9623277C88;
	Wed,  4 Mar 2026 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587811; cv=none; b=H7FKpq2oiw3KjQTC8a7ewo4lV/N5/lFyeDBgdca18QYlVsnVwVrHYUc6uXRhin/C6b5cBITYnuL8oE7y9J/TXgh23s0L1qy7+VBQ2JXCATV04F2URAPYt8KNSb9gk1WuGShlvetuTmFxEGnwWYb435uDxizO/CKeeQZz6b34DAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587811; c=relaxed/simple;
	bh=rKREH/ZWWHdXybPmLcgvicI3opDq0i74m3QvZscbWzw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eo0FJR2FT/yJLXhevfztq9T6s3fTTs/cyV55EIeoCRED5n/dItcsYnWfoqUL09aQgbhZuv6h3JlgR8bqYT6gmGzgnT2L853GZNfpypaNWql5yIn5aeKWs9RLWDNEg4LutGZhjniNU63RJsMsBN5a85RKTO8mHyhjulxlLKqszFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nalHdQ48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C51C116C6;
	Wed,  4 Mar 2026 01:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772587811;
	bh=rKREH/ZWWHdXybPmLcgvicI3opDq0i74m3QvZscbWzw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nalHdQ48MvqFOzKKb+3nUzVl3W/NGZOYyzoa3iguvpZ3bqWQ6d2zObDTLlOFhlJJr
	 JbDp7tHH/vTn9P09XTT9XUUNZvk/4yQOU0CWzidJqlVdnQ9XoFJrMyM9avvWQvT6gv
	 +HUXnjvT148aQ2/xFsYqFrlnzKkw7AJtV5D8f5F9Nkvmk+kGg9C/gteuvloYW1P3qK
	 gSnxg9UJ6o70u0S16ExW3EjWf6wNCAW4BghJwrf68G1IhAoV9m6eZAgdQoMj4r+Mzo
	 KbnFnOYksaVhjKauTDt+/7ZyW8edK0G+NbKtQLLs0gTkeSI8QO5bSbafqSXzlzBzlj
	 0ZVUyTPJ6R3yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE8D3808200;
	Wed,  4 Mar 2026 01:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/tcp-ao: Fix MAC comparison to be constant-time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177258781230.1546050.13760298129957795669.git-patchwork-notify@kernel.org>
Date: Wed, 04 Mar 2026 01:30:12 +0000
References: <20260302203600.13561-1-ebiggers@kernel.org>
In-Reply-To: <20260302203600.13561-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 0x7f454c46@gmail.com
X-Rspamd-Queue-Id: BA7721F9854
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-222963-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Mar 2026 12:36:00 -0800 you wrote:
> To prevent timing attacks, MACs need to be compared in constant
> time.  Use the appropriate helper function for this.
> 
> Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> Cc: stable@vger.kernel.org
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net/tcp-ao: Fix MAC comparison to be constant-time
    https://git.kernel.org/netdev/net/c/67edfec516d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



