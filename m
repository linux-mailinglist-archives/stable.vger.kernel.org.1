Return-Path: <stable+bounces-269323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +iFMJZYsP2rsPgkAu9opvQ
	(envelope-from <stable+bounces-269323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 03:51:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F236D0C04
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 03:51:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CvjlaAfh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269323-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269323-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56333304CA47
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 01:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2D525B30D;
	Sat, 27 Jun 2026 01:50:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6739525FA05;
	Sat, 27 Jun 2026 01:50:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782525029; cv=none; b=J7Iv8jMTmKKjP6fXYrg1523f+xYvXG6iWCknSFkYqh212pAkHDBDqAu37wk2CCxfsdeGWeelHd7XzrDOj2m8/3az32ZHjKyB5QXzkVhK9roomIqTdyskPAfHPI5M49LkQ7gbGycCf+zTDsAFv/ztMtX9kIWi5pFnMfRr9LLW0LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782525029; c=relaxed/simple;
	bh=xIY9DHtYvOxWxAHyulE7GmZtkrUoH5qI0q6gO4VFjcY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OUuMtS6BeARX2Q2Uw2YOXxCbTmyg0gAkOrPFxaTcP4olG0+mF/+6XPQMV60I1CkeSM+tyYg7TINVnKAgoX7e6amVA1aBKaCN2P1j17ltEda4aC2Iz9Jyg+t0dgkiO5LGhJySTNHiCihE5Qvo70ge1t962uTzwMHmiQoOKX5DaIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvjlaAfh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E985D1F000E9;
	Sat, 27 Jun 2026 01:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782525028;
	bh=z4w+4NMb2Mo48oNE76M11upuMGxO0WosbKeZDd0uZPM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CvjlaAfhc3aq/RobnLwP2V4Tv3GUHmUagm3GgYdpFVF34iOJbT9qaboMb+hzS+KbR
	 JPWMpC2rFT3w242Rt03pe2vCK0y960Fs30yc2J1DC3LPv5FIF+wAIghPv+bX35wlq8
	 DcfFuH+v4WcQZrtqw9DKINMpaIhev0x+GE7PFmIUvjabGzYGwjaV7oJ2HBgIwvxPO4
	 n/f8i+izr4CfYyech1WTxKEchcfkCvOo+ZlIkL5bJjYzxHXvuTVrRhAVjsb18jH04k
	 1bdtvLxsXBCVHD0K8pj1/RF6t2ya2tqDsbdoxiwHJWuIemAr6xELquZ81mOicZNNsC
	 e5K+qNkeLebFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 937DA3938C76;
	Sat, 27 Jun 2026 01:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: liquidio: fix BAR resource leak on PF number
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178252501423.1164679.172899911087256804.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 01:50:14 +0000
References: <20260624064013.2809570-1-haoxiang_li2024@163.com>
In-Reply-To: <20260624064013.2809570-1-haoxiang_li2024@163.com>
To: haoxiang_li2024 <haoxiang_li2024@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ricardo.farrington@cavium.com,
 felix.manlunas@cavium.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269323-lists,stable=lfdr.de,netdevbpf];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ricardo.farrington@cavium.com,m:felix.manlunas@cavium.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1F236D0C04

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jun 2026 14:40:13 +0800 you wrote:
> If cn23xx_get_pf_num() fails, the function returns without
> unmapping either BAR. Unmap both BARs before returning from
> the error path.
> 
> Found by manual code review.
> 
> Fixes: 0c45d7fe12c7 ("liquidio: fix use of pf in pass-through mode in a virtual machine")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: liquidio: fix BAR resource leak on PF number failure
    https://git.kernel.org/netdev/net/c/c63ee62a3c4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



