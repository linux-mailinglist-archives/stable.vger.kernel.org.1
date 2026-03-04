Return-Path: <stable+bounces-222975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J1GKnKgp2l2iwAAu9opvQ
	(envelope-from <stable+bounces-222975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 04:01:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 480241FA2C5
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 04:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBF13305CE25
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 03:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF3E314B62;
	Wed,  4 Mar 2026 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxETMCVC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38E7354AE2;
	Wed,  4 Mar 2026 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772593208; cv=none; b=EAgcBomv9NDAgWYywMCv44Xvgu89XOhS94R6sieZgl1f8IU1Y65v98yWTXd/bVf9GW2kMe3GKCvPAHwku1E00vthfhfLNCt9b2Xs8yFltTk7wTomPvlDpjM/vjVzsktXy117Fonbu+fSD7r0SLe3eSgOcGhrlipCZjYO0Y7/j8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772593208; c=relaxed/simple;
	bh=WXshjToo/jk/D/qxqC9A6fC4JAJb1BO6OtIyI/9FCAU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=slR2wphF3czmdSK4Feut1BQKyTYvb2jPWBaantdPBYrqq99+jzUJi1srM1w9lalTLuJHEOgi871F1t0P/970PQAOJrM5q4mwqYAmKpCs0xLG9sizssjFQp6nawTuFsNWzvljpABZlcn/HFMAu/F7i3hBz0SnIZLjpKeFd7z+rWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxETMCVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40751C116C6;
	Wed,  4 Mar 2026 03:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772593207;
	bh=WXshjToo/jk/D/qxqC9A6fC4JAJb1BO6OtIyI/9FCAU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FxETMCVCDoZPm2eKN7rlFYy/i6LW0NpvU5VvrVp7S1bKoBt3z98QGQx3en6Ml9ESB
	 htSqzFD8+/VD/uEBCBX85rZjuGWep779xS9JtrgdyvdQzD9Y+Pymu483m6FxXA+7ci
	 O6SPnH8E5+M6mGHsCI/uCiyKIwV6mehqYpOzb3tdeqWeNgeJE4gHbLC0PPWx1VXfcJ
	 /AKK3rkRUBSBYANoW6b3MdS6m7lIQy53/DR9xGCZNgOaOZXhzzem9qAx205WkQQe3r
	 Hbt6LvqtUVA3jSa+gu+mbQnrGnv+ppa4IaIII4Rd/HWBVC76UW+Utq/1iDTyySoQo+
	 vs9bSObsV6gZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF033808200;
	Wed,  4 Mar 2026 03:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/tcp-md5: Fix MAC comparison to be constant-time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177259320804.1572572.11276801700271821092.git-patchwork-notify@kernel.org>
Date: Wed, 04 Mar 2026 03:00:08 +0000
References: <20260302203409.13388-1-ebiggers@kernel.org>
In-Reply-To: <20260302203409.13388-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Queue-Id: 480241FA2C5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222975-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Mar 2026 12:34:09 -0800 you wrote:
> To prevent timing attacks, MACs need to be compared in constant
> time.  Use the appropriate helper function for this.
> 
> Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")
> Fixes: 658ddaaf6694 ("tcp: md5: RST: getting md5 key from listener")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net/tcp-md5: Fix MAC comparison to be constant-time
    https://git.kernel.org/netdev/net/c/46d0d6f50dab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



