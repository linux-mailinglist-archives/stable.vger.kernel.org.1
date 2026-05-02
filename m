Return-Path: <stable+bounces-242619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gM7ULMBA9mlYTQIAu9opvQ
	(envelope-from <stable+bounces-242619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 20:21:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F9C4B32E2
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 20:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE2B5300DE35
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 18:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9903876B7;
	Sat,  2 May 2026 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyVEWj/p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A636327C1D;
	Sat,  2 May 2026 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777746065; cv=none; b=nnUiEi4Epo7WR6MvZNoaV4Tf+WQJwQQBCwBbEdAUfv8OUGuGx3rajkNIQDJLKD5BlLgI7suRcKoO0xeIaNTxeAkOJ65KuizigB4iT0sdifVU4Sffn9VLRfYg+VgB9TGIcCT32KwHLVd9YPJLVnhbt2A4jc2J2ArR0sjiYBNR6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777746065; c=relaxed/simple;
	bh=6rOLeEhDeZfSlZVg6PHAM2vbYkjw5wGxTdBXEUWomGg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N6XWib3eyTC8aB6c49CsVSvfOJAI8bjoBXrWv1jJTRXLl2Rx3osqt52QjCOprxTtHrizb+yMlElEOz1dOfjmY0qIDWdmQKKxfSgOllJcpKKWBmG6Cda46nIUMNnC+VvOpCbyk2Da6JqgDBa1sU2QqX4v3ZU4ucdFWl0vzuCMUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyVEWj/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B940C2BCC7;
	Sat,  2 May 2026 18:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777746065;
	bh=6rOLeEhDeZfSlZVg6PHAM2vbYkjw5wGxTdBXEUWomGg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dyVEWj/pAB5/y02lSbiTkRmrN1q8GI0VOlPVgeuePx3rZeSQA7q2EgcYLrTseEcVo
	 /BWOHY8Vof0puVTsEY1SzUYJZBoFJSMxiE7lI3VXo5fzIXNCj419iTtBgnYBizmCuz
	 W2Ni4djnq6UbeDxNeUDGvLye1okkeWOgzRgHl7XO0xKmKH0+cQeh3J0XKth0gH2KXN
	 K+8sMxK4gHolCCVvoQlYzMoUANcnWq+AG2jEH+fvW+/7I2gV7vfsE+aewLZQcGwfUZ
	 iqH0psGiMvEuKRgi20C4dLk1/bo9aonXQ4gKeSIQbuCnlw/kP4wM5OkpUYnN/qkSBY
	 2bzZ/2nISx/pQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DD4380CEFF;
	Sat,  2 May 2026 18:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ip6_gre: Use cached t->net in
 ip6erspan_changelink().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177774601754.3903048.11239187630768514134.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 18:20:17 +0000
References: <20260430103318.3206018-1-maoyi.xie@ntu.edu.sg>
In-Reply-To: <20260430103318.3206018-1-maoyi.xie@ntu.edu.sg>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 willemb@google.com, kuniyu@google.com, shaw.leon@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Queue-Id: 57F9C4B32E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242619-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com,gmail.com];
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
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 18:33:18 +0800 you wrote:
> After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
> rtnl_link_ops"), ip6erspan_newlink() correctly resolves the per-netns
> ip6gre hash via link_net. ip6erspan_changelink() was not converted in
> that series and still uses dev_net(dev), which diverges from the
> device's creation netns after IFLA_NET_NS_FD migration.
> 
> This re-inserts the tunnel into the wrong per-netns hash. The
> original netns keeps a stale entry. When that netns is later
> destroyed, ip6gre_exit_rtnl_net() walks the stale entry, producing a
> slab-use-after-free reported by KASAN, followed by a kernel BUG at
> net/core/dev.c (LIST_POISON1) in unregister_netdevice_many_notify().
> 
> [...]

Here is the summary with links:
  - [net,v2] ip6_gre: Use cached t->net in ip6erspan_changelink().
    https://git.kernel.org/netdev/net/c/1d324c2f43f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



