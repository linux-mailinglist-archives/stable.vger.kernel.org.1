Return-Path: <stable+bounces-220038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBM+DQNfomkX2gQAu9opvQ
	(envelope-from <stable+bounces-220038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 04:20:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C62F31C01D3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 04:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A7E330480A4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 03:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67210255E43;
	Sat, 28 Feb 2026 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf3zRnDb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FCD20297C;
	Sat, 28 Feb 2026 03:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772248804; cv=none; b=rtfa7DaHgBifo0KHPo4pEloTgVg6PbWqRZ2qLI3K3mFz7lg8s5UCN42zceJ8tKXBAikVUzFXEC0R24stPvgQjNL0niZEyqb0vR9qC7uaToYhMh2FGWnR9d4GXABcm39MtwR77AR8kwvrfZWS9db5w54qAKjeq3uKGJSUKaEEe8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772248804; c=relaxed/simple;
	bh=hM/rTiB9XyNbiwGTXzGVSnGV4+V4bj0hrZLzPWvUGqw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i5JXjKc/wUp0rcNkFFw3okT0kC+0ut5kAoHXP+o867vBfnR4ablHk4CAyEOEm/+a3w4D8AlvPt42YXviDe7waESR0AmTXEJMhJg3naEJeIjmJPFop/kWwjahRcGBkWpmKSt0INVDDG46I/dOJk2018z/cfdZxurMwuf2XZGozGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf3zRnDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF63EC116D0;
	Sat, 28 Feb 2026 03:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772248803;
	bh=hM/rTiB9XyNbiwGTXzGVSnGV4+V4bj0hrZLzPWvUGqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nf3zRnDbBolMTEglg9umA11guQP4Zca1xxvVOJo6xZkFF/tpZBorvplSThXFK6inO
	 w+a4rG/kNKXgT2gg5BT/AD/tYHnkkpNHKw9959VmohnQkrplDjWio9F8K5S97fXTtS
	 eTEMjfts6LYSdVgH0WVUKMUgyXmpW8sK4G6F6lafwcbmXODGljqlJeW8CUF8g9eqi+
	 CXC7ld2qo0tKXvNa8/F70Oeu9kwpaiDKGyAqCgXhw7zWKfLm1M9/8Dp6dDQ+savqNY
	 x78YUkoaP9KImmHXpAFwbRoRQOrNKMguKRQWC/tEIZLm7GZPc4LFzEkERuGohuzXco
	 IKRYnAkJ69owQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEEA39EF96C;
	Sat, 28 Feb 2026 03:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net/sched: Only allow act_ct to bind to
 clsact/ingress qdiscs and shared blocks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224880716.2851960.3791246704632910583.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 03:20:07 +0000
References: <20260225134349.1287037-1-victor@mojatatu.com>
In-Reply-To: <20260225134349.1287037-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org,
 taoliu828@163.com, netdev@vger.kernel.org, pctammela@mojatatu.com,
 km.kim1503@gmail.com, stable@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220038-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,163.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C62F31C01D3
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Feb 2026 10:43:48 -0300 you wrote:
> As Paolo said earlier [1]:
> 
> "Since the blamed commit below, classify can return TC_ACT_CONSUMED while
> the current skb being held by the defragmentation engine. As reported by
> GangMin Kim, if such packet is that may cause a UaF when the defrag engine
> later on tries to tuch again such packet."
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/sched: Only allow act_ct to bind to clsact/ingress qdiscs and shared blocks
    https://git.kernel.org/netdev/net/c/11cb63b0d1a0
  - [net,2/2] selftests/tc-testing: Create tests to exercise act_ct binding restrictions
    https://git.kernel.org/netdev/net/c/b14e82abf78a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



