Return-Path: <stable+bounces-243944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNweDGtW+WkK8AIAu9opvQ
	(envelope-from <stable+bounces-243944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 04:31:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B81E24C5FFA
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 04:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A60ED300AB2A
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 02:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664473932CC;
	Tue,  5 May 2026 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcPjOAws"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616817AE11;
	Tue,  5 May 2026 02:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777948261; cv=none; b=KXm0lsN70O5/8guKp9dwKg9k/T225u3HVndoxHulArs3jTDDt+Bge4U7Y9uJMfmAqzxmG76dA6dsRPaaMhx4ykR+tmT+EpVpGVZIitHmkX8PqMVm0OfDCwCsFYK/gAk4YJaBHhxmCSycOuRnYNFjbnCTq25tqGRHXPJ67Yvu+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777948261; c=relaxed/simple;
	bh=AA8cH8hQ3P20TZYGC9RLfTAA7leVeZMi69S2rtE2FZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sV8LMhNkHovjQaq8E7vMjlG83DYkdNTfY6/kQ9xf1u/ej+STQhEm03RU/94dEoALKOz4D6bFwlmS9CifZrWCDzwH0k51neYOUJh+gFLVaAltOkCqXwBe9LIDdw06K6dzjl9yH8WBx1/KLSmFEKOVV98aCib6Khef7u0bGQXe5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcPjOAws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94DEC2BCB8;
	Tue,  5 May 2026 02:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777948260;
	bh=AA8cH8hQ3P20TZYGC9RLfTAA7leVeZMi69S2rtE2FZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CcPjOAwsGtV2b+oHpYToX8y5hgsqILoLGLvc2YNZ5OC6krSDgxyXMpzTuC7W7NjZg
	 J8SOInSr4WwQgfAJVW35KenF1Rzsm8oiAMtko5BBAm05dYlQzjw1ONGXqmll6Ff9g5
	 LbXofClyRiBaBKTsmfVvk2AX+uwo4KTsFH+cVxrwURIElnPKVRPy7y2hABaQXsTeFh
	 hPeWCviMtkDTUMgyfSI5fWdFO7ORgFo7HcZWvIo05lNFAlFVbI5elZsOpQP2DV2F9O
	 07Y6z3w7PcIKVGpgiGiIib/dFPMme0wH05qx61znz2Jzk8SRcTA1zlFL1wbE1Zlv55
	 FnzYWKQn+Gl7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E0A39301A2;
	Tue,  5 May 2026 02:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mptcp: misc fixes for v7.1-rc3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794821155.1394832.1837410198700398471.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:30:11 +0000
References: 
 <20260501-net-mptcp-misc-fixes-7-1-rc3-v1-0-b70118df778e@kernel.org>
In-Reply-To: 
 <20260501-net-mptcp-misc-fixes-7-1-rc3-v1-0-b70118df778e@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, yangang@kylinos.cn, dmytro@shytyi.net, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 shardul.b@mpiricsoftware.com, stable@vger.kernel.org
X-Rspamd-Queue-Id: B81E24C5FFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243944-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 01 May 2026 21:35:33 +0200 you wrote:
> Here are various unrelated fixes:
> 
> - Patch 1: increment the right MIB counter. A fix for v5.7.
> 
> - Patch 2: set the right MPTCP reset reason. A fix for v5.9.
> 
> - Patch 3: fix rx timestamp corruption when on MPTCP passive fastopen. A
>   fix for v6.2.
> 
> [...]

Here is the summary with links:
  - [net,1/4] mptcp: use MPJoinSynAckHMacFailure for SynAck HMAC failure
    https://git.kernel.org/netdev/net/c/c4a99a921949
  - [net,2/4] mptcp: use MPTCP_RST_EMPTCP for ACK HMAC validation failure
    https://git.kernel.org/netdev/net/c/a6da02d4c00f
  - [net,3/4] mptcp: fix rx timestamp corruption on fastopen
    https://git.kernel.org/netdev/net/c/6254a16d6f0c
  - [net,4/4] mptcp: sockopt: increase seq in mptcp_setsockopt_all_sf
    https://git.kernel.org/netdev/net/c/70ece9d7021c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



