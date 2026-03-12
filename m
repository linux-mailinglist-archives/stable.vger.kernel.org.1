Return-Path: <stable+bounces-224779-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAWFOX8Ssml0IQAAu9opvQ
	(envelope-from <stable+bounces-224779-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 02:10:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4980826BDA5
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 02:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF180307D4D9
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 01:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE1D2FF641;
	Thu, 12 Mar 2026 01:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWH5v7i0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B2729E114;
	Thu, 12 Mar 2026 01:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773277817; cv=none; b=i+5JvCzgWI2gXcwXovVL6bfnCLhZPfW+o1V2ygNCS6E2ohP0/MJoeFRomu84rene81wzA/Hxio/Rx/xckBwiUfzDNl+sB086SqUc6SzzxVosBxkIWaa8O1HfxQW0ugPeYqrgEPcDdhZpOjTt9yn1m5ZousmnfPu9C4OAIPlMvwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773277817; c=relaxed/simple;
	bh=2VnEX2d2kKChCsMfXVjFhEUVpPvckvqNRzWmuUKDOZU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IAuVWhQqP7n5PUZnH1zvQaSn+YqXBUxAX+kXdMFzjh4L7Afdb/CJnH0ZkA9NZBDeG639XRz9yuLmkz+SlENRu+o8bwgs003chc4wQJRfmjkndtLKzmMsKjdo6hUjxhRTaHK2vxzqt+MhBNcxFkpvznsI3c1RiQpI7Td0tXckgq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWH5v7i0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2F5C4CEF7;
	Thu, 12 Mar 2026 01:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773277816;
	bh=2VnEX2d2kKChCsMfXVjFhEUVpPvckvqNRzWmuUKDOZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MWH5v7i0GAwzWOKLOmTkbyl08UKsT7GlzcQtJe8KWr/Sn/KIPa2W9zlBlfXtCCHcg
	 59uEVMwwdGzhhVoQ0tvCqaJnly4/S1ow0fIyCVFgo3zWgWUFUXb6+vj64VSTGxtZh0
	 0QXywMMf6UmeozKWdIa28iQ5VkuypUNV7a6gq33q9LzEFDFPTbxvpRr6B/UC9OQc1d
	 +p+dLrfliEwKaWefEUqKSNFPTCN//B2bAa/EM36XlSr2FJtdNZEaWJBWwS8elz1g1k
	 sKIFqsjAvJnu+bYS/tFg2ljFLtPlke3sMcKu9gb4RCs2AyHc7FJKA/CFSdF0dNHo9L
	 J7LvC8HL/T1mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E8A3808200;
	Thu, 12 Mar 2026 01:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: microchip: Fix error path in PTP IRQ setup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177327781280.3893274.11029073930876613838.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 01:10:12 +0000
References: <20260309-ksz-ptp-irq-fix-v1-1-757b3b985955@bootlin.com>
In-Reply-To: <20260309-ksz-ptp-irq-fix-v1-1-757b3b985955@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,se.com,bootlin.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-224779-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4980826BDA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Mar 2026 14:15:43 +0100 you wrote:
> If request_threaded_irq() fails during the PTP message IRQ setup, the
> newly created IRQ mapping is never disposed. Indeed, the
> ksz_ptp_irq_setup()'s error path only frees the mappings that were
> successfully set up.
> 
> Dispose the newly created mapping if the associated
> request_threaded_irq() fails at setup.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: microchip: Fix error path in PTP IRQ setup
    https://git.kernel.org/netdev/net/c/99c8c16a4aad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



