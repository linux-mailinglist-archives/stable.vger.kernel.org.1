Return-Path: <stable+bounces-248959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH6ILfLKB2oEJAMAu9opvQ
	(envelope-from <stable+bounces-248959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 03:40:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FD5559CBA
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 03:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 620B7300BCB2
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 01:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A51233723;
	Sat, 16 May 2026 01:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqj/XKbg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DFE1F94F;
	Sat, 16 May 2026 01:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778895594; cv=none; b=GKmUY+gdhqod8KOTsmVKAU+de/nInbIeatLKsR5spcE48LemhEF+nphlJIgQ3POSOvi2pr6iI+WDEnPOUpqZ9K9WEFq1Fq+h6s3sgxLUAsRKSJbvwMf7eeFfiSGPHuyB2D33IJ+AbhtdWO5WXjH9wK+qfakPY/nBxK/s+sVDxpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778895594; c=relaxed/simple;
	bh=R8Gs9Wk6NAAhPS87TQ1iFIoLN/TOBGEAUtj1B3MohNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YXEACVzypCGAGwAiHK/bL+y5/cTnWi3qmMPb9AYRyUKQC1DLNwTO/g16V63lRp0nHQL9CFzP91ZeX+7zSfXPkO9VdctS1BfOqBqQkfMmHLt/cZUvHvkHJUan2DqGovJKydUBDN/zB6Z4FGQZKEXHnYv/D6ow0JtZL2k/2Z+e9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqj/XKbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17322C2BCB0;
	Sat, 16 May 2026 01:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778895593;
	bh=R8Gs9Wk6NAAhPS87TQ1iFIoLN/TOBGEAUtj1B3MohNY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kqj/XKbgBADtKu7XFfOD6hPA9Ho9KZd0DF/x61MY2Jp2jaTrHclK1ak7uU5m6Yf7u
	 /8a63A9rpYumIrxKlaXU1zNTYvpfJrIX2MH9pidCElv0QMcMnqr9V2/pOOJz3/mY7L
	 MVGfpl0iWnxQTFoEcw2miVK7A/cHuTFKWCItZqmGxHN9Qa7wwsZA2vLpKUN8CMaSH1
	 PObqM/Re9h3WdViCWeGGr7MK8sLQAN7rBbi1HirPPmhgtP7gcZoH7a0nWfAuh8btxv
	 p5OZroxZXdJ/s1X4FamqPhmqpt6qXJwle4BTKCfdfRdbJoRLyYGyFFxidTdrwZgWT9
	 0ybMgxSCkxASA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568263930A23;
	Sat, 16 May 2026 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/1] net: hsr: fix node-table UAF on device teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177889560589.219555.12152803144106381021.git-patchwork-notify@kernel.org>
Date: Sat, 16 May 2026 01:40:05 +0000
References: <20260513233838.3064715-1-michael.bommarito@gmail.com>
In-Reply-To: <20260513233838.3064715-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 fmaurer@redhat.com, bigeasy@linutronix.de, luka.gejak@linux.dev,
 xiyou.wangcong@gmail.com, kexinsun@smail.nju.edu.cn, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 57FD5559CBA
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
	TAGGED_FROM(0.00)[bounces-248959-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,linutronix.de,linux.dev,gmail.com,smail.nju.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
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
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 19:38:37 -0400 you wrote:
> Hi,
> 
> HSR generic-netlink node-list/status readers walk hsr->node_db under
> rcu_read_lock(), but RTM_DELLINK teardown frees the same node table
> immediately via plain list_del() + kfree(). A reader that has already
> obtained a struct hsr_node can race hsr_dellink() and dereference
> freed node memory.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: hsr: defer node table free until after RCU readers
    https://git.kernel.org/netdev/net/c/aaec7096f996

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



