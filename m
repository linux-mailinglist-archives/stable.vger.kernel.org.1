Return-Path: <stable+bounces-262252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sf0VOFbvJ2o35wIAu9opvQ
	(envelope-from <stable+bounces-262252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 12:47:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7059065F1B6
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 12:47:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=STZaCVOJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262252-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262252-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 366E23098056
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 10:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980053F4DF6;
	Tue,  9 Jun 2026 10:40:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813CA2F1FC7;
	Tue,  9 Jun 2026 10:40:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001608; cv=none; b=Pw6/qdJ4vdtue4GWBHPabAjdvA6aAn1//U0zZoVPvvTF217AbaAde27PZMo0g7ksGUgIs9vXNkZ0qro8CR0XaXnod8xmYgALf7n/b8gdE+4aeKrawWC+NzMWZ8UvtINVxy5PFruLQmwBklG7TmLsujqATpYErvmohCUTTiYzewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001608; c=relaxed/simple;
	bh=fAaR8R3cAieHlGYXJBgMpMfKIp2+fJkPkpO4u9kkCHQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K32Gsnmu2oN0PRrJ2wQ3s0lpcEAGn9BwXFl8h2vA4xKvQnPT3g/yDC+VOIlWzfe72RwfJzLhwXUHhMvk9HG+LqGHVaF/t7ktoZb1ffv6n/1TaPbfUyleUQzrOR6vOX9HWH/V1SmkAjLJpmOdrtBzDegJgfqnV9NsbjKt7HjbT7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STZaCVOJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649FB1F00898;
	Tue,  9 Jun 2026 10:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781001607;
	bh=Z2KPUWVg1F5kkeWTL3+0vtxYlRUZkWAlDdIjOzjEwXk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=STZaCVOJZmqIqYMw1gRzD9yRwds9Jf5nLmjtUC5nDH95Tt7h9GhArpy2oOB3aIW9v
	 6ir59QmDBxE8kh9IP1WyK58mu+nc5+6zmhYg2HOmRnjgMT7m6vhJDa0aQghhzGbOoI
	 krwYfWcvxGG6Ql2g+6eUPvbzxq9uvq7h2H7UjY6+Z6eljncHmniOKj7IZj+kDOStam
	 EnFe8zoqaA1jogq+ci+g9cq6PdHF2XkruAAWEBkX4FP/6yZRDKu8DBf24aMBBkgzjr
	 Y8mPPXjfRJEiCuAe/WMjwnVownvS6u09lLAtKKoqY2O8VHYDoacpDiFFpA8piLs1dr
	 oC7xgnUsDMc1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198463930884;
	Tue,  9 Jun 2026 10:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: fix memory leak in
 rvu_setup_hw_resources()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178100160565.1947098.11448197781614396900.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 10:40:05 +0000
References: <20260604143756.1524482-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260604143756.1524482-1-dawei.feng@seu.edu.cn>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 stable@vger.kernel.org, zilin@seu.edu.cn
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262252-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7059065F1B6

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  4 Jun 2026 22:37:56 +0800 you wrote:
> If rvu_npc_exact_init() fails in rvu_setup_hw_resources(), the function
> returns directly instead of jumping to the error handling path. This
> causes a resource leak for the previously initialized CGX, NPC, fwdata,
> and MSI-X states.
> 
> Fix this by replacing the direct return with goto cgx_err to ensure
> proper cleanup.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: fix memory leak in rvu_setup_hw_resources()
    https://git.kernel.org/netdev/net/c/09a5bf856aa7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



