Return-Path: <stable+bounces-262817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DIH9LZ00K2r04AMAu9opvQ
	(envelope-from <stable+bounces-262817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 00:20:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2E2675950
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 00:20:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JRP1ZbsI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262817-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262817-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 878F63179E27
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 22:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A745A36A379;
	Thu, 11 Jun 2026 22:20:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5162E7BD9;
	Thu, 11 Jun 2026 22:20:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781216409; cv=none; b=ssX8Y0ADUIKsJ9guHr6RvPMRL3px6JTKfFcBKo+luiUuXSYCpe6QK8VIz+/o8etjM/MaKJCLUbM+Xwd2uEgMg4vb7O/VKdd1zpdAzOWoRP2y6LyxYL/3WgANkBIxYGBt8jwierqj4xnO8cUR3VdvZWUbffq686iqQMt3x43765Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781216409; c=relaxed/simple;
	bh=S7SPxj0+n/cAkq0Z6a7eu/C5mwhHIkKVf7s7jgoj3ZI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JIsrbtZyclo3sbH8g/TId+6GsOnCpwufOg8Pit4tXgLgAjEVJaM30FVzFzCwgr4i4QYNBpBQWAFmwCaGea1gk12Yz2wTarKAuyYKgBr7zKz+qiqIr7bAKZSJ8yiI64pgctFDrnqQ2JQzxT3NYjD025cKqiUvGhNAfBC0TSeBowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRP1ZbsI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEF31F000E9;
	Thu, 11 Jun 2026 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781216408;
	bh=6XG/CAmsc4ebZcmoGJFBRO7jKXsBEF5dekspXGO+ZoQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JRP1ZbsIncC6UyX84axEMrqtr25lo7zA4sZwzh5ubQDHNAPpY3IV3AThdEM02w8F9
	 hGWL2CrRBCRj70GLesRcGr5U8JDY7BmZn1Gq6AmRTMySawN+dKFFTkiOOReOIctsd1
	 Cv2nMAAMdgcnxstKt60A9A42wVU23wdiHpthI4L6roj9f5zyw2DbUq4qzHsoXqhmqt
	 i5fzqIMFipHhFHpSeCJr6wdnXfOXFC3MeJE/t9uOkut7on4eYPFSOmPRpgccokeR5t
	 I5qZ+U/aRC5APFeTvLbEZxFQeDSex+oXNitEx+eRVmZTB5Vz0u2cMCwDumNXu+hIRL
	 U7WvqZS2seTuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939023930FAD;
	Thu, 11 Jun 2026 22:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net/sched: cls_flow: Dont  expose folded kernel
 pointers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121640518.386394.15064694073972588687.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:20:05 +0000
References: <20260610101839.14135-1-jhs@mojatatu.com>
In-Reply-To: <20260610101839.14135-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, kylebot@openai.com, stable@vger.kernel.org,
 security@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262817-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:victor@mojatatu.com,m:kylebot@openai.com,m:stable@vger.kernel.org,m:security@kernel.org,s:lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C2E2675950

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 06:18:39 -0400 you wrote:
> The flow classifier falls back to addr_fold() for fields that are missing
> from packet headers. In map mode, userspace controls mask, xor, rshift,
> addend and divisor, and can observe the resulting classid through class
> statistics. This allows a tc classifier in a user/network namespace to
> recover the 32-bit folded value of skb->sk, skb_dst() or skb_nfct().
> 
> Align with standard kernel practices for pointer hashing and replace the
> XOR folding with a keyed siphash (which is cryptographically secure)
> 
> [...]

Here is the summary with links:
  - [net,1/1] net/sched: cls_flow: Dont expose folded kernel pointers
    https://git.kernel.org/netdev/net/c/f294fc71c4a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



