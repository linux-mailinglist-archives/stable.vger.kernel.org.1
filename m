Return-Path: <stable+bounces-245369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFSgHyB3AmpUtQEAu9opvQ
	(envelope-from <stable+bounces-245369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:41:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F5E517E95
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6928130160F2
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 00:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CCA223323;
	Tue, 12 May 2026 00:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRzyU8mM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E3E347C7;
	Tue, 12 May 2026 00:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546459; cv=none; b=div5gYGK6P6g4qCmP9BYOhWCmZPQpMndyznR8jORFsGb101umuugTyPbdu6sW3ESatxOb9t+FYIXEnqlE+VmSiS03/wdmmFpNBVt92BtzgmCjYfRJVVs7hAKqT3kTbZyRRUeG3UaGLjuCxRbKBrHad5Xt9FzMgtJ1W11S+nM5eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546459; c=relaxed/simple;
	bh=rU7UR0V1DS3Rv2KJ/XLQ412CW8ibRZJ7KU7WN+jeah0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o+T7aW7MtmwN+XJb9hcVqqU5QmrsXJY6ZLtfFSHP6J87GHLXXy7Yx4CVJaJHQLP3B6mCmS23hELKurOX0r6wZtig2jWRmWROLnfpZnBpBBWNYj25RUzQrZB/AIYrPFatoUl2lQhSq6aDBI/zRkk3MqBEWtB5deA3NSWVuKtEojA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRzyU8mM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8396C2BCB0;
	Tue, 12 May 2026 00:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778546458;
	bh=rU7UR0V1DS3Rv2KJ/XLQ412CW8ibRZJ7KU7WN+jeah0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QRzyU8mM402NlXjhlwy/TAjMDbMwmPb6JKTt1BfevWDFEw7+98GGCqowXGAMlUZ1H
	 iHIxHmj/B/mPpFlFDgbSChDYgj4AZCIWzopfOKfSl5AAF1lK63Mb1hqQAqoDXG9DqD
	 klWQKbIZkDsQZFS0IdkdbGAE/0iaUOG+gxNLRR+o55aOlPBgSYmfHIxI2alZ+uRgdY
	 FkEWA+IESlzK+QCLNr2MzeGoP9eghLv++9tElUSo9LMSovoHQI7uPdXpOmLzkxSlS3
	 yV0WSRlaIj6OHHQNUD/FLsAh9M4tJpBklSPn1dcRVOfz7SAz8BB68pH1xbtWy11ZO2
	 Trxoz06ipkSTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE4B39308CC;
	Tue, 12 May 2026 00:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ena: PHC: Check return code before setting
 timestamp
 output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177854640531.2524538.10303695435034882546.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 00:40:05 +0000
References: <20260507003518.22554-1-akiyano@amazon.com>
In-Reply-To: <20260507003518.22554-1-akiyano@amazon.com>
To: Arthur Kiyanovski <akiyano@amazon.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 richardcochran@gmail.com, edumazet@google.com, pabeni@redhat.com,
 dwmw2@infradead.org, tglx@linutronix.de, mlichvar@redhat.com,
 andrew+netdev@lunn.ch, guwen@linux.alibaba.com, xuanzhuo@linux.alibaba.com,
 dwmw@amazon.com, ysarna@amazon.com, zorik@amazon.com, matua@amazon.com,
 saeedb@amazon.com, msw@amazon.com, aliguori@amazon.com, nafea@amazon.com,
 evgenys@amazon.com, netanel@amazon.com, alisaidi@amazon.com, benh@amazon.com,
 ndagan@amazon.com, darinzon@amazon.com, evostrov@amazon.com,
 ofirt@amazon.com, amitbern@amazon.com, stable@vger.kernel.org
X-Rspamd-Queue-Id: 28F5E517E95
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
	TAGGED_FROM(0.00)[bounces-245369-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,vger.kernel.org,gmail.com,google.com,redhat.com,infradead.org,linutronix.de,lunn.ch,linux.alibaba.com,amazon.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[31];
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
	TAGGED_RCPT(0.00)[stable,netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 7 May 2026 00:35:15 +0000 you wrote:
> ena_phc_gettimex64() is setting the output parameter regardless
> of whether ena_com_phc_get_timestamp() succeeded or failed.
> 
> When ena_com_phc_get_timestamp() returns an error, the timestamp
> parameter may contain uninitialized stack memory (e.g., when PHC is
> disabled or in blocked state) or invalid hardware values. Passing
> these to userspace via the PTP ioctl is both a security issue
> (information leak) and a correctness bug.
> 
> [...]

Here is the summary with links:
  - [net] net: ena: PHC: Check return code before setting timestamp output
    https://git.kernel.org/netdev/net/c/24a08d7d6218

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



