Return-Path: <stable+bounces-267828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eFzAOKXTOWrgxwcAu9opvQ
	(envelope-from <stable+bounces-267828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 02:30:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 514FC6B2FDA
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 02:30:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jv8nvqVC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267828-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267828-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B3B53036E93
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 00:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4D337FF6D;
	Tue, 23 Jun 2026 00:30:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8551337FF41;
	Tue, 23 Jun 2026 00:30:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174625; cv=none; b=TEtk+MhTikrOLEfJ1oZKEN8VoAxFhwIPhLhzqEcusaM48TGh0kxBPDz8GKpRqj+UKzXUA8dwwh/5Nn5LKyAT7zMfDmgM/mpSyAZZU8632Mq19zv3tA0a9fAkaItOj1Ea19Q6meVmKDttOYvuRuQzP0HJacOXTLvty1mcSk7LkZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174625; c=relaxed/simple;
	bh=tBMqPTTMZ/blwTEveTSY/DHSXD4CEv/VgroCrW1WXX4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O+apCKDvbNrQaMwwajx+YrYXbOkG1y/EP4WWVJ3YKEXHn/Q6vcVgmXJ4ljICDm+An5bSH9CI54QEFM4mcWRLzRVBlZWNu3vMI++GVUoG8gtGjNJLmvKovLLGGTkH1XQ8993vioB8jCtKCnFzs+g5oVGSGhJL8wom47jPsXZk1hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv8nvqVC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2023F1F000E9;
	Tue, 23 Jun 2026 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782174624;
	bh=jJ/FeTwB958bqT0CvT3zpI7nxDka1yEjfrGPU9SLm18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jv8nvqVCyDJ/0eFpt7G+0RlJr3IbFQZCi7j82TcAkhtGKNzE9sV+lMjrf07vkgurK
	 WvcmCGInfrdnb8M4cVdqw5EIaywf9NeJDkcun0i/+LH7Q7gM28jGBcvF/owuZLHEAG
	 ju7p6lW89sew+pgDl7K8b9rbxpTFO9112pxooEaL8sD+pBZ/Yvypt2zGTJi+h6UJiZ
	 5dD6hYi5MVdkJ0E1kYuw5wwa9OK50g9iWP+v3HxxgCzaCy/430f8ayaI0LZPDmfPgp
	 l82tp9hcBknNF1XKca+6Zu3jK1XfYwH1PI+i8xo3QUnVobpwRPzK4sbZwgcntb1PDx
	 bLT1tMA4dblMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A45393098A;
	Tue, 23 Jun 2026 00:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] Fix stale register bounds on LSM retval
 context
 load
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178217461422.1476259.13794764203016830138.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 00:30:14 +0000
References: <20260622230123.3695446-1-tristmd@gmail.com>
In-Reply-To: <20260622230123.3695446-1-tristmd@gmail.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, xukuohai@huawei.com, jolsa@kernel.org,
 john.fastabend@gmail.com, martin.lau@linux.dev, bpf@vger.kernel.org,
 stable@vger.kernel.org, tristan@talencesecurity.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,huawei.com,linux.dev,vger.kernel.org,talencesecurity.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267828-lists,stable=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:xukuohai@huawei.com,m:jolsa@kernel.org,m:john.fastabend@gmail.com,m:martin.lau@linux.dev,m:bpf@vger.kernel.org,m:stable@vger.kernel.org,m:tristan@talencesecurity.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 514FC6B2FDA

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 22 Jun 2026 23:01:21 +0000 you wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> check_mem_access() calls __mark_reg_s32_range() to narrow a register to
> the LSM hook retval range, but the intersection preserves stale bounds
> from prior instructions. Add mark_reg_unknown() before narrowing (same
> pattern as the else branch) and a selftest that catches the mismatch.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: Reset register bounds before narrowing retval range in check_mem_access()
    https://git.kernel.org/bpf/bpf/c/5e0b273e0a62
  - [bpf,v3,2/2] selftests/bpf: Add test for stale bounds on LSM retval context load
    https://git.kernel.org/bpf/bpf/c/644332f48fc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



