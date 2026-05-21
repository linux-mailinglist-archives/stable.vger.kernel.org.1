Return-Path: <stable+bounces-253613-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCQZK7QxD2qSHgYAu9opvQ
	(envelope-from <stable+bounces-253613-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:24:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5945A935D
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78F2730E850D
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0863371CE6;
	Thu, 21 May 2026 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW0Ej509"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8960D36F8F5;
	Thu, 21 May 2026 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378609; cv=none; b=Ylsf2Gi1phlxEPGkoCRhhDVfkQ7StqBSX4AZVy0n3nr85ur9e3IAVgrBxgusD2yKCC3WRF2dR48G5Sa0/VMuqtgasyGyhPBFtLUhPV8cOSYcbJOmyILNtSndPfndEQHb2R4JtP1pCNZ0KBXGshjqM35523guYiW3qFs4wOa+L1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378609; c=relaxed/simple;
	bh=bcmvQZHvu/Ws7AQMNeblfGkI0Q7z6yPd3IbDP/A4tJs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H2gJyZj8I4ZSjt6f5abPBXbxEwxTgzfpXh19DKoM5IkbQ5nmgWGJFC0qON8WbHPTlKY1QQblla/ZfKzMQytcv/jVRYOPdwjZRba5l2FjgKeg3//wUgA4BfkqFmVKs/kEyXaeBQKxexunwJrKQUx9Va/WqiMEVh9QP7oSdL6eUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW0Ej509; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456171F000E9;
	Thu, 21 May 2026 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779378608;
	bh=9gMaUZeh+69Zu9rCTdveH3pR4oiIBblHtld73n+ZOyc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZW0Ej509QvS8dKUpe6x3J0lrmEZ6dGsO6Tc6DzeLQWf5n52Cx/rba1f/Uc1LdA1YD
	 tt+U3sRv6dKhdCYDt+0Avg/kIG+JP5dO1cyInmt2YttdexjIWykJhaRsT59/sfzPvq
	 E/BqwdYaNg/PnsOfEbOT7A/t5MJQkypJAehCo2w9FyqNi2ZPu+13YK9164fMWOVQOa
	 fMuUxvskSIvfOQ3WxQI6Zy8JCj5Zo7I4WCNKGvMdep3vdRGACHq3DoFZpfBdyXh5Wd
	 qddy3sGcV17eSfFxx4mtPCt/J7YVjoqTupLMSSKE6yh1r90yEwLL1G5FcJ9ar93or1
	 xSGd1s2gnnPWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A253930E08;
	Thu, 21 May 2026 15:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bcmgenet: keep RBUF EEE/PM disabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937861789.394984.10118621842029368003.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:50:17 +0000
References: <20260520184320.652053-1-nb@tipi-net.de>
In-Reply-To: <20260520184320.652053-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 justin.chen@broadcom.com, phil@raspberrypi.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253613-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,raspberrypi.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3E5945A935D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 20:43:20 +0200 you wrote:
> Setting RBUF_EEE_EN | RBUF_PM_EN in RBUF_ENERGY_CTRL breaks the RX
> path on GENET hardware once MAC EEE becomes active. RX traffic stops
> flowing while the link stays up and the usual descriptor/RX error
> counters remain quiet. In that state the MAC still accepts frames
> (rbuf_ovflow_cnt keeps climbing) but RBUF no longer forwards them to
> DMA, so rx_packets is no longer incremented at the netdev level. On
> some boards the corruption ends up as a paging fault in
> skb_release_data via bcmgenet_rx_poll on an LPI exit.
> 
> [...]

Here is the summary with links:
  - [net] net: bcmgenet: keep RBUF EEE/PM disabled
    https://git.kernel.org/netdev/net/c/9a1730245e41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



