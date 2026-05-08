Return-Path: <stable+bounces-244838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDsPFnxf/mmppwAAu9opvQ
	(envelope-from <stable+bounces-244838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 00:11:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A25F4FC302
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 00:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10F34300D765
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 22:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F6833F59C;
	Fri,  8 May 2026 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a94oXeY5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94F33121F;
	Fri,  8 May 2026 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278261; cv=none; b=F2lbb3IXZ4E60wrUFLPmp77hlY0DPJ4JCzmby9QcHQrOg2xvtfEBU3BKaaVQfprOu/MAXHvQTLuHvlSDu3jjCcd4IiscEy7PRAV8JrEYbogMg2hpZpJJ6wDF9eLl7YG4X6VlZb5aLUQOkSh4AoaaR5Kf4Wlm2WM5vv80z3HV++o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278261; c=relaxed/simple;
	bh=ydAR8V+7zevaxXw8m1Yxudzwidzt7WxufB1JAXPlRdo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kPOjuOwq3sG+qcnPZnUH86EcoicwrG5syKtlwUYhJBpjQru7lrj3vbxLvzvUCZqoi1XiuE4kBSbWwihErhzYgIzDHMSKn3A5rjwcygfBv6kPHg5VGuzo3SLXb5snXBtnqdF8jNqfD8HUoyCIw8GnDQRms9l2z30BmvOr4j3jbgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a94oXeY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E7FC2BCB0;
	Fri,  8 May 2026 22:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278261;
	bh=ydAR8V+7zevaxXw8m1Yxudzwidzt7WxufB1JAXPlRdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a94oXeY5hW+PC0+RERYUlkB761eDdVddearB9x2dNVjco4pftkuzV3njHJsZJkgHz
	 wGGjiY4/SBp1X6lZ9BgePe6YKRyClgh5wjxvdaO5CXa4CZm5Y/ZvQj8sZp/RrJ2isX
	 Lud/tihHlFyjn+0LHS+uF7vLS2avbN+7029fjo1kTerTwPJ5+JPV8OqWhHUgeFdYsD
	 Rv0O8qyA5AuZG4qTe6mnFKI5VCdHkgDRjCjpcrZASOaUIkYS1ynr6D8R9OjKeMfGOW
	 Gqgw2Zv/BW5pDSaDTpEUp8apYf19qYK6uW1j7EsZ2sZUYMCINDvixcAe0SZt86Igy/
	 2dHSFXGJJcTQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E7CE438119CC;
	Fri,  8 May 2026 22:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v8 0/2] ipv6: flowlabel: per-netns budget for
 unprivileged
 callers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177827820980.868876.13043664849343604381.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:10:09 +0000
References: <20260506082416.2259567-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260506082416.2259567-1-maoyixie.tju@gmail.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, kuznet@ms2.inr.ac.ru,
 willemb@google.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, maoyi.xie@ntu.edu.sg
X-Rspamd-Queue-Id: 2A25F4FC302
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244838-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,ms2.inr.ac.ru,gmail.com,vger.kernel.org,ntu.edu.sg];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[13];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 16:24:14 +0800 you wrote:
> From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> 
> This series fixes the cross-tenant DoS in net/ipv6/ip6_flowlabel.c.
> v1 through v6 were single-patch postings, each in its own thread.
> v6 review pointed out that the existing fl_size read in
> mem_check() and the corresponding write in fl_intern() are not in
> the same critical section. v7 split the work into 2 patches.
> 
> [...]

Here is the summary with links:
  - [net,v8,1/2] ipv6: flowlabel: take ip6_fl_lock across mem_check and fl_intern
    https://git.kernel.org/netdev/net/c/7ce5556f255a
  - [net,v8,2/2] ipv6: flowlabel: enforce per-netns limit for unprivileged callers
    https://git.kernel.org/netdev/net/c/e68eadffb724

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



