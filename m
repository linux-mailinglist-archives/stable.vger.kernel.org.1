Return-Path: <stable+bounces-262988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2Xw2ACjRLGrBWgQAu9opvQ
	(envelope-from <stable+bounces-262988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 05:40:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 867D467DA05
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 05:40:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hhMgmJ2X;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262988-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262988-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6220631824B0
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 03:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D1E390985;
	Sat, 13 Jun 2026 03:40:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA08734CFAE;
	Sat, 13 Jun 2026 03:40:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781322014; cv=none; b=Mp0uVHGLf38P/YCBULqN1eZ4/cuN203WEeoxLLItlF4ZlwAxddIJp5SJH4r801/YRSGoZsY0g0bXenijWLdDyfl4Y2+EhrLEHK60d5TIyWEwVnQM8G1UkmiU5FpGuj7JW/I9kGj+6BP0AbCxh6mVPUJCOH9/WJMigVGa5mQrIsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781322014; c=relaxed/simple;
	bh=Lq21wIM56w9HfyIvTLO5z+z2EIzb2SXwqDHDGMw/Mfw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TIZJVb3biwY3jAXvFbgWlkYFdDWKd6HdzVejQEIl9ssvysfm4dQbVlR1vYiL78byU/L993J/ZRw9ZU5xuJvXBT81dfgtGB8/6t++JS6ktZy+n/xsijFMNu9yKaIqHCE+nTyNpAuR/iDurZ5OnTSK3ivzMHi/rcxFVwzwmWKnNvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhMgmJ2X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5561F1F000E9;
	Sat, 13 Jun 2026 03:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781322013;
	bh=aYuy15x6KO2rtbQXDqEbCb9o6x1rqOg6AItC6qlucVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hhMgmJ2XN5O6ijqPIpy7rlE+/EpEWYrMxToQrl+uIMTjWH/OUfAuHN/uaVU6UBslz
	 os62czplvICakw64gfBgblpkDjofFDG30+R8HMyRQexHo44gzA2/CagUoOWMxj/4kS
	 zEM0NOOjF7N6zHprPitqkjnneBm/3X90S7tVLBrk8qQJkNJVFtceEAxjTZBuw9r9TO
	 QfIiamfa7/u1rs5vQoCqprFOtSxcHfV0t+R/ccwlE4NRs5LhGCTnLOnhhK/0BXql/A
	 U+5d+d2dOw5S8+j4Pk0gKWDymsUzs/9WcaIw/xCzht23m+Wzi0SRkNA+g+p4GKW3Y9
	 KyQx1VvDClaJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A2939E9607;
	Sat, 13 Jun 2026 03:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] rqspinlock: Fix order in
 raw_res_spin_(un)lock_irq
 to allow schedule
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178132200990.1349961.11715126199517712462.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 03:40:09 +0000
References: <20260610090431.32427-1-gmonaco@redhat.com>
In-Reply-To: <20260610090431.32427-1-gmonaco@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, arnd@arndb.de, bpf@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, longman@redhat.com
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
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,arndb.de,vger.kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-262988-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gmonaco@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:arnd@arndb.de,m:bpf@vger.kernel.org,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:longman@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 867D467DA05

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 10 Jun 2026 11:04:29 +0200 you wrote:
> raw_res_spin_unlock_irqrestore() calls raw_res_spin_unlock() and then
> restores interrupts, this means preemption is enabled when interrupts
> are still disabled (as part of raw_res_spin_unlock()) so this cannot
> trigger an actual preemption.
> This is inconsistent with other spinlock implementations
> (raw_spin_unlock_irqrestore() and bpf_res_spin_unlock_irqrestore()
> itself).
> 
> [...]

Here is the summary with links:
  - [bpf-next] rqspinlock: Fix order in raw_res_spin_(un)lock_irq to allow schedule
    https://git.kernel.org/bpf/bpf-next/c/b48bd16eb9fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



