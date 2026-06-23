Return-Path: <stable+bounces-267840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TG6BFm/nOWqaywcAu9opvQ
	(envelope-from <stable+bounces-267840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 03:54:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A226C6B36D4
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 03:54:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="joT0FP/C";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267840-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267840-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEDFE3057765
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 01:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2F2375ADE;
	Tue, 23 Jun 2026 01:50:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04A313D539;
	Tue, 23 Jun 2026 01:50:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179420; cv=none; b=qbWs/lh3g7WfoEIuwfbyGbG4BnaPCFcwjgHnA9OB7nWD/yyLLj+uUIOtIfGsVifUGswd98vSz9GwM6WGyJleyGVV1BeDiXfb51qmJOTdER6V21RcOi/xBm+qUN8ypEj48SqVptEsIPv986YY995kdfYJ7mX9UrGDewM77SPsAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179420; c=relaxed/simple;
	bh=JjpwHPkCa/5YR/LYb4oj0fFkOQyjck/WIQHTr4q/+nw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RUIl2BYJ39ngr8Rtr+SM4bH8SQL2aFgYt/BZ1KPcTPD/p5IKDhProq9CnCSE/mzPmkq7joYfNFbfAGPtNsM+0ZGFlp/V3YVFxRuR/IK6X8LtdyHRLTUb4gRqHkid6ih/JjzXwVtje/t9JSJA8yWjdHH50aDMONluCeYLXYAehKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joT0FP/C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8DA1F000E9;
	Tue, 23 Jun 2026 01:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179419;
	bh=L9o/ER0NHmE8whekACehxCdnV4FSKSbxVtU3EkoF0UY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=joT0FP/CFjXfnGz2Qs4+AYUNX8mGwAMl2dLO+JrS5Z+yk9CZJfK3yLDqUhOR9NtF5
	 YUiqW5D59z+Ze4EPrTUSuz2ehiX7GW1Vr/69brlcc9JTqRVd33pB5ZwABsjE+NmncG
	 S/nIDmFI2gJQouCsEI6YcrUFNGwznSsjADhpmiU53/qwlEEYPW+b52PLFge+jHteXc
	 DQtV+airJ5sTzNJN5RGdUTSXvH9LCFGDy0oNTm87emJFXPntTgcmusoJWNsQyNEPZh
	 xUnF6v4u/llt0Udmrp3moGgyDV5Iufsb5MvWqMY64Ylz4rwrI/snhyLgri2S9EO32b
	 inKL6BlXYi3PQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A2F3930A08;
	Tue, 23 Jun 2026 01:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnx2x: fix potential memory leak in
 bnx2x_alloc_mem_bp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178217940930.1502813.18321326300451371106.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 01:50:09 +0000
References: <20260620062402.89549-1-nihaal@cse.iitm.ac.in>
In-Reply-To: <20260620062402.89549-1-nihaal@cse.iitm.ac.in>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: skalluru@marvell.com, manishc@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, barak@broadcom.com,
 stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267840-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:nihaal@cse.iitm.ac.in,m:skalluru@marvell.com,m:manishc@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:barak@broadcom.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iitm.ac.in:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A226C6B36D4

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 Jun 2026 11:53:50 +0530 you wrote:
> If the allocation of fp[i].tpa_info fails, the error path will not free
> the struct bnx2x_fastpath allocated earlier, as it is not linked to the
> bp structure yet. Fix that by linking it immediately after allocation.
> 
> Cc: stable@vger.kernel.org
> Fixes: 15192a8cf8a8 ("bnx2x: Split the FP structure")
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> 
> [...]

Here is the summary with links:
  - [net] bnx2x: fix potential memory leak in bnx2x_alloc_mem_bp()
    https://git.kernel.org/netdev/net/c/a986fde914d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



