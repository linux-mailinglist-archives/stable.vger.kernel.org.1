Return-Path: <stable+bounces-249722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPq9MeEHDWpQsQUAu9opvQ
	(envelope-from <stable+bounces-249722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:01:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DDA586728
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BF1A3037EE4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 00:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9239284682;
	Wed, 20 May 2026 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3eByz9F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E16B29AB02;
	Wed, 20 May 2026 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238796; cv=none; b=aeM6M30QIkky9aZCo9l4qcSHz8YXoyemCKLAchO29Ux0BIDwlqZCSb0jMtAr0dANK3sf/jod6R1+4ZX3f4blKoEXxsr35l/aQLxpCefI+QUMLfU0a2WDEffFUUHj34GJgv+WoBsA+7tZvbwAMUG9HdbGO8aEEz5V6xEBy/PIV+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238796; c=relaxed/simple;
	bh=Gk+zrEidxeyH8/m65U8s2CofRddr5N2qo9NAbJEoFtc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lySeViyEHsz7Cdwg477yvb1JftZouuLtDQYmFJlQj2EioV+cZH46Xglu5aKcJwvPnXR3teMSGxMUBLW2F9SNwHuK+Vn2Wpv3/SEcChRLCbZjHdqfr5MQ7zUgOf5aXRB8gMQUijRc8GtmZmn0VWMmuIZqsxbrNdEX/SRm+wVZdTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3eByz9F; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CFA1F000E9;
	Wed, 20 May 2026 00:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779238795;
	bh=LTA03XVNuI2B4/4ZJtJTbBevnemJyRqVpLCixthwgCs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F3eByz9FMv5J+9uICJjxo8nttu3TVFovs/DyLrQtM9EnGBEczlPLkgzHqfwZ3+NAP
	 l/+QsLqMRqzIsjAQT/teKVI4+Nq/hc65mpLMfuEuoEqXDrVm1hIZSPUoEipOaByLWz
	 JK6LpT2TyPGkbdF+fQBMBtVBMuqYgr5Rj5Na+mngxBGOkuC+woVTolwRNzDu0/fenU
	 NJL6RMWF14cb+dqrTJjgWJF059FNDTpfmO59d13EzzuwsiMkjZ7+OvCnQUwC5UuvpG
	 +Ss5/jtDsnGLCoRZnWKnqiuJdM1DLJYW7Daw5RgeC4N6f2auklID0pk4+gTXReJy0k
	 Bpa9uMm5sWDhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197A0383BF53;
	Wed, 20 May 2026 01:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-pf: avoid double free of pool->stack on AQ
 init
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177923880590.2938085.17920392610827952238.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 01:00:05 +0000
References: <20260515151826.1005397-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260515151826.1005397-1-dawei.feng@seu.edu.cn>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org,
 zilin@seu.edu.cn
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249722-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 21DDA586728
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 May 2026 23:18:26 +0800 you wrote:
> otx2_pool_aq_init() frees pool->stack when mailbox sync or retry
> allocation fails, but leaves the pointer unchanged. Later,
> otx2_sq_aura_pool_init() unwinds the partial setup through
> otx2_aura_pool_free(), which frees pool->stack again. The CN20K-specific
> cn20k_pool_aq_init() implementation has the same bug in
> its corresponding error path.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: avoid double free of pool->stack on AQ init failure
    https://git.kernel.org/netdev/net/c/9b244c242bec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



