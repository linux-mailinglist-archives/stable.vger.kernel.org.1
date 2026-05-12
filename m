Return-Path: <stable+bounces-245375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGkpITWHAmrVtwEAu9opvQ
	(envelope-from <stable+bounces-245375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 03:49:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24246518704
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 03:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FC5F3012238
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 01:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C752528BAB9;
	Tue, 12 May 2026 01:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpXwvmom"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87107246783;
	Tue, 12 May 2026 01:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550576; cv=none; b=GGWTXxrmru0His4lnK00OAaRkl52UNhTAPuuI5ts+HR31GsQoYfX12EttRGPkFK5YZndSejDRD94f3hYN14TORCPScdFe1NGcs6FRaVNLQ1vycPTAmU4+3jMhnVRF4v7yfQztbscJMnqpmiyXgBseBL4J+r9P+txCjQURbJt2OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550576; c=relaxed/simple;
	bh=N+mG9VFd1nAHybK56YS0zxGfciWo+eOuQjecD+z9q8c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=np2K02y6+DTFJRdVkVymIA4Lc3pXtX4nIUZJe7i+mWSK9bX5EKtRXxkIadHxwtuHdTmHBRZ0fRwWW++YglLIQg+R6K/SmcxAan5V58jdCeeIQEC1Cmn5IQRs4oPPuVnIaaIHFwqifKv0kC/v8qHOCLnzPuka2c9q9BG5azU8Otc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpXwvmom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2583CC2BCB0;
	Tue, 12 May 2026 01:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778550576;
	bh=N+mG9VFd1nAHybK56YS0zxGfciWo+eOuQjecD+z9q8c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WpXwvmomJWm7adLexcQZz3ZRztF4TgcZ9JYvsuICIiPewbrCPLeD2JUwtPWtNCva9
	 mQ4jqE1qJJ9Rz2O7zCjxG3XHVa5/8Q47N001z3egzZ/TF5c6uJDUzs0tVpFazvNibR
	 Xa9+6dt/oK4sUanmp1LOYTwZz/sAQfRfbMZj4m8EFBSDO9VEtkThp3m/ZYCXbDmne6
	 KIpg/Yt76guGhufOVxfyF/at61/c+0U8wj9ZlkwLAAB6vR5O6O0LSEPpji+khwx2h6
	 jAxPE1kxmlM+1K+FHQYca3eZTUgQGSdRJ020K/aJgwpg6bOw7XQVdoyT++zWfmQ7EK
	 KzIANtciJxZKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FB139308E9;
	Tue, 12 May 2026 01:48:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] qed: fix division by zero in qed_init_wfq_param
 when
 all vports are configured
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177855052229.2567715.13167262625389092988.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 01:48:42 +0000
References: <20260507145520.23106-1-evg28bur@yandex.ru>
In-Reply-To: <20260507145520.23106-1-evg28bur@yandex.ru>
To: Evgenii Burenchev <evg28bur@yandex.ru>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, horms@kernel.org, bhelgaas@google.com, darinzon@amazon.com,
 Yuval.Mintz@qlogic.com, manish.chopra@qlogic.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
X-Rspamd-Queue-Id: 24246518704
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-245375-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yandex.ru];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 May 2026 17:55:17 +0300 you wrote:
> In qed_init_wfq_param(), variable non_requested_count can become zero
> when the number of vports with the configured flag set (including the
> current vport being configured) equals total num_vports. This happens
> when configuring the last unconfigured vport or when re-configuring
> an already configured vport.
> 
> The function then calculates left_rate_per_vp = total_left_rate /
> non_requested_count, which causes division by zero.
> 
> [...]

Here is the summary with links:
  - [net,v2] qed: fix division by zero in qed_init_wfq_param when all vports are configured
    https://git.kernel.org/netdev/net/c/be48e5fe51a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



