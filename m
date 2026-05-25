Return-Path: <stable+bounces-254189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOoYNNiSFGowOgcAu9opvQ
	(envelope-from <stable+bounces-254189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 20:20:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CEF5CD995
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 20:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E474C30158A7
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 18:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B558C28A3FA;
	Mon, 25 May 2026 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTEE1tw/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D461347C7;
	Mon, 25 May 2026 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733202; cv=none; b=KlxQ6S+DRaxxp0LdCP1JofMxjxyEHNw3U+TXjfD4f5E7GEGF2l1sMvq6qdzSNd848e+G7UgIAUZo9jSQKi1/UTYcsZcvv9nr6VddoG7ofgzkHqZ7i1MCIuEY8iDCXjpP0E1nhHKon+PJaKWuYPNiJlQLwdtG/fXxQUjCwgCmKR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733202; c=relaxed/simple;
	bh=l3imiVuGizwazstTT/mRyD4YG96IGdkrBo45fCxE14g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cEqCU9ttfV4rRKtpFjN9aXL1JNrfA0hu2piw/tnjMAp9lmJS3KfJwOrd5oPt84FSk9w8osAbnpnl56iQgAhrFDl/AyR1ClKFnK0HthvNdIVQC+a4oV0PxZLpGt33O2/XrxO/r3kxLPlhyWXhLGdf4/PWSBuxf8JsCaLQLjvfru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTEE1tw/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0A71F000E9;
	Mon, 25 May 2026 18:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779733201;
	bh=6ITC+zEEN34TmiLIR2gIp03tICotVOjsoUKQxYR5SEU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gTEE1tw/K6IQ/JHWSjnkTP5Uq0RgoIwj2QRwN+kX0GPDgv7losm26o+PqrJYLNum3
	 rhgyT4xMZda2pXsJUFRRLzPcN6NSkRP6fETviou7koYMBPlffEMVSpARodp4TJ5Lsa
	 3FYV9HoRheZZPsgcYeGgoPMJi7KUBb5hIZyOtoi4TfG/6oYyUwOrhPWBK8PCYVyiMj
	 F95GgyhdmjjkN1UbnlE/UdBsHkbvcGKMvrd+H4kk1etoQG87UKrKwO43LVHhEZ3PWe
	 yHBN8lSTFR8a0HGTczOqyIOJYEcL8Zdg27m0jlF1TiPwnyegfcDuS+8W5nNlH/Q4ZT
	 TnuIehipwfFyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A51380AA75;
	Mon, 25 May 2026 18:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: exthdrs: refresh nh pointer after
 ipv6_hop_jumbo()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177973320767.3076487.12955128816285380522.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 18:20:07 +0000
References: <20260522112013.12342-1-justin.iurman@gmail.com>
In-Reply-To: <20260522112013.12342-1-justin.iurman@gmail.com>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254189-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 35CEF5CD995
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 May 2026 13:20:13 +0200 you wrote:
> ipv6_hop_jumbo() calls pskb_trim_rcsum(), which can change skb pointers.
> Let's recompute nh pointer to make sure any change won't mess things up.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Justin Iurman <justin.iurman@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] ipv6: exthdrs: refresh nh pointer after ipv6_hop_jumbo()
    https://git.kernel.org/netdev/net/c/d47548a36639

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



