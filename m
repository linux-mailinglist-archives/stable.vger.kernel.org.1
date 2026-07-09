Return-Path: <stable+bounces-272848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JJs3Oy5hT2onfgIAu9opvQ
	(envelope-from <stable+bounces-272848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 10:51:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 547B872E7F3
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 10:51:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kernel.org header.s=k20260515 header.b=KZFeq5Ih;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272848-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-272848-lists+stable=lfdr.de@vger.kernel.org";
	arc=reject ("signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30E8A3004618
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8089B3E4C94;
	Thu,  9 Jul 2026 08:50:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E002853E9;
	Thu,  9 Jul 2026 08:50:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587028; cv=none; b=Q1RjIOBxOhPsHJq7Uog4Q2rwsoLsfvxu4GLBmEeMoMJ9h5d5gQ+bOoaNdCH7wfTPBMoZG1QPN+3qnD4C6vxn/JUTqwVsLxVxvPbyNY6BONIuy26xq0TAsgOGk+TbZrSl9HFp7AglAkKd+2jKvNB7bgd3aHb/HsXCUXbjLTISIxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587028; c=relaxed/simple;
	bh=L8LJua1DxqqFV9UY+8irAffMMey+0OoAu9uwDEy2f2k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cn11meTVVIX9h0bv3yxgT7WpuyvVsOW+0unrT0p6Husf9yzDbXwzfwruFY7DlaRmNyebKRjIpr9bCJ7ut29q09rpEYbps90AE4tPe35HQ+75FA9+N1N8L7/6sNzNA+X6UmyPwvBUGxuhOjm1dyB+A7WSjxNNKueN2HAMAbuvPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZFeq5Ih; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E9B1F00A3F;
	Thu,  9 Jul 2026 08:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783587027;
	bh=+ZKhXsAhdtilMoK2puuWkLVqsDWjK3+/5l6BtNqzwb0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KZFeq5Ihsw0R5Rcn7scrOK1rfBrl2JX86ReGBjqJH2ssop+zzyw1A3pTwCKQ3tYmY
	 R5XlvblzMscpz/Tj0Aonemmt7kwNg21qsK+iTMCJhgqIzkA6L3QqWwFZDs3zJZxUTp
	 WhEGawuTehSQBXuPhG35VtXwg6jP5A9EujBFjrd2eBt2KfJzpCNc9t/f55kr/8X/qb
	 og4VJSxc4Oy589p7YyrDc5cCiuIpFQV4cJA8ws6CNLL/x3j0DuVu+5dzS/XmULTfnf
	 cFwtX4hSCZpJ+gRc/r7pX4vwrWgcT/YpgIXYJeD1fy2o3CUHPF17ecFkpKBhcLATJT
	 mvfcqM6xCFmTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09893939F14;
	Thu,  9 Jul 2026 08:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: macb: drop in-flight Tx SKBs on close
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178358700564.3339064.13535033370383188443.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 08:50:05 +0000
References: <20260702-macb-drop-tx-v4-1-1c833eebdbc8@bootlin.com>
In-Reply-To: <20260702-macb-drop-tx-v4-1-1c833eebdbc8@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun_=3Ctheo=2Elebrun=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jeff@garzik.org,
 conor.dooley@microchip.com, pvalerio@redhat.com, nb@tipi-net.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 benoit.monin@bootlin.com, tawfik.bayouk@mobileye.com,
 thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
 stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:=?utf-8?q?Th=C3=A9o_Lebrun_=3Ctheo=2Elebrun=40bootlin=2Ecom=3E?=@codeaurora.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jeff@garzik.org,m:conor.dooley@microchip.com,m:pvalerio@redhat.com,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272848-lists,stable=lfdr.de,netdevbpf];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 547B872E7F3

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 02 Jul 2026 17:37:02 +0200 you wrote:
> The MACB driver has since forever leaked the outgoing SKBs that
> have not yet been marked as completed. They live in queue->tx_skb
> which gets freed without remorse nor checking.
> 
> macb_free_consistent() gets called in a few codepaths, but only close will
> trigger the added expressions. In macb_open() and macb_alloc_consistent()
> failure cases, queues' tx_skb just got allocated and are empty.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: macb: drop in-flight Tx SKBs on close
    https://git.kernel.org/netdev/net/c/27f575836cfe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



