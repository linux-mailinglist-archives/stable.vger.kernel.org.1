Return-Path: <stable+bounces-235852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDngGKX+22luKgkAu9opvQ
	(envelope-from <stable+bounces-235852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 22:20:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C75FB3E5DEA
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 22:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEB4F300E3A8
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E29137F72E;
	Sun, 12 Apr 2026 20:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox6+DH6J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C489818B0F;
	Sun, 12 Apr 2026 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776025237; cv=none; b=R/3eoqeZx07a/VWy/TVEIaRNsL+MQI3my+24nCzCkIwWv9G5sAse60lQT3ZOsiMgYk2b2yTJYPG42Oj2fSDDE0Kwg4WqPqrXEgINjLofDLYiwwg7Thj/mwKwp+zQnrwTk7dKMNyXIuFYLayxpbpwF6dgPiSaTgHaz9Z8CWOLFcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776025237; c=relaxed/simple;
	bh=jryuqrjGAu240c9yLVNycnyI2OE92hyePx6bd/iOniI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hW/a+iTXbQznNBmCdxZyxmMUGFLJRlRUmrqIOu9o8wER5Ux2B0ApTgZJyym3JiEbQtOfhO9r7ErVchInXrvYIsH6c+/7ZRPqDIK1IFeiJMxWNk3w/rz8cyzJqlIZrDS+j5sZ58lvmuECek2U1YyUGaVDQrfZcQ6FXaV6S9bKI5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox6+DH6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68092C19424;
	Sun, 12 Apr 2026 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776025237;
	bh=jryuqrjGAu240c9yLVNycnyI2OE92hyePx6bd/iOniI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ox6+DH6JYC/EwulA9ij6sUWgR/jS5AFTeXxETcPYmdaxHPWGTqfGwA7+ue3pv3EhK
	 zpWMiegQNQ6rd9KotZtOQ1LuPN0M+QSy1DACyxhwJbrDF/8jHS56gk12r4eeXBpzFB
	 UiYwI4bHwySXyhZf7uKIH/iIPDDWHOeDiSQxEwMNLbUdBfFgCUzxFS9nYMmnf8DhJj
	 B48UQi+iSSuDAnFUV861ff8WBurnWrIPQ50Qhe4AOZv1E+NF9L48MEavTjKCpjf6tu
	 fGromhvp76QYqKLK3JIQQxre442GfHgC1kNRfxeEx2p3VraV/uJ+czj/MrOTOr8ifv
	 g6e3PXHOi6nzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D223809A8C;
	Sun, 12 Apr 2026 20:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: rose: reject truncated CLEAR_REQUEST frames in
 state
 machines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177602520954.3398432.9861431630028064654.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 20:20:09 +0000
References: <20260408172551.281486-1-mashiro.chen@mailbox.org>
In-Reply-To: <20260408172551.281486-1-mashiro.chen@mailbox.org>
To: Mashiro Chen <mashiro.chen@mailbox.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-235852-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C75FB3E5DEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Apr 2026 01:25:51 +0800 you wrote:
> All five ROSE state machines (states 1-5) handle ROSE_CLEAR_REQUEST
> by reading the cause and diagnostic bytes directly from skb->data[3]
> and skb->data[4] without verifying that the frame is long enough:
> 
>   rose_disconnect(sk, ..., skb->data[3], skb->data[4]);
> 
> The entry-point check in rose_route_frame() only enforces
> ROSE_MIN_LEN (3 bytes), so a remote peer on a ROSE network can
> send a syntactically valid but truncated CLEAR_REQUEST (3 or 4
> bytes) while a connection is open in any state.  Processing such a
> frame causes a one- or two-byte out-of-bounds read past the skb
> data, leaking uninitialized heap content as the cause/diagnostic
> values returned to user space via getsockopt(ROSE_GETCAUSE).
> 
> [...]

Here is the summary with links:
  - [net] net: rose: reject truncated CLEAR_REQUEST frames in state machines
    https://git.kernel.org/netdev/net/c/2835750dd647

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



