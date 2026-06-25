Return-Path: <stable+bounces-268238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bDoDFB+APGo0owgAu9opvQ
	(envelope-from <stable+bounces-268238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 03:10:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E58B6C214E
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 03:10:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="PbZ/x6Ax";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268238-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268238-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBC99309CD66
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 01:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8292D36A022;
	Thu, 25 Jun 2026 01:09:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7222136826B;
	Thu, 25 Jun 2026 01:09:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782349757; cv=none; b=lfqzDQPJj2kaZXTLdlS3L00y39hcFUIBEFmU9DTJ0eSZLXZIk9ALQIJcGYmhFSCwf0CCu2xiQwPhAEpfvkXJj/X7F7Px+aa7WprM04khbrQPHjGUmuoUpn8Vgv4EgcUuIe6Udg+1/SvJaw40MZRnmQkbYDkj85jUYj6C8MHsWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782349757; c=relaxed/simple;
	bh=kpewF/rPWYxnFccLuqdraPbJuV36lrpciYeSlOO0RL8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AZQDImH7pu5n7a+v3TzEihF7Aw8iBxpSLOd83QwqB5sciTGYcTger/tqGrkerKwGgMhjZheBs8d9iSAJjAzecWWpurEdYw33RthLsRtWdPBFF1PegpfZMDpY0ZWC6tfmEU7mKYwe0OeYDquFQF2Sog+WQiVHXj3DcreTB+zltdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbZ/x6Ax; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554D11F00A3F;
	Thu, 25 Jun 2026 01:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782349754;
	bh=KSyb2XtjEX1eDUWv4A7qcjknp0JqfZehvr6jo6mvFpQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PbZ/x6AxRAkXBIuusdBvANE1T1Xci4UQYkbzLietEy3tEwW8JIIbSUFemeol83U9u
	 L+ZRikNvzDk75UOKiPuVc897sCx2Xudm7R+Luq9amk8LAO6dxPMYRgKGaTwUkgIlCC
	 CXCpie0saI26iqyK03XESK5xvdSjmxi/5eG0OYlgWp6Plrc6xzpiqlcTCuQSQIIa7T
	 Jp/HYmsAetYV67GMmVNIXq1EqBSwTMK0FKOZ2OoECsr4BtavZnq7YHZD0wnfg++RfU
	 ruonreID+5nIc0PfzQ4HWC+DsmFGME3wBGKnsuZnNi5AcLrDFU3OK1l3/XKKrvO9nV
	 UXvqLrD8RFTbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CD93AAA0F5;
	Thu, 25 Jun 2026 01:09:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ixp4xx_hss: fix duplicate HDLC netdev allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178234974236.3045401.8869362652520123568.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 01:09:02 +0000
References: <20260622043015.643637-1-haoxiang_li2024@163.com>
In-Reply-To: <20260622043015.643637-1-haoxiang_li2024@163.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: linusw@kernel.org, kaloz@openwrt.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 huangguangbin2@huawei.com, lipeng321@huawei.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268238-lists,stable=lfdr.de,netdevbpf];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:linusw@kernel.org,m:kaloz@openwrt.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:huangguangbin2@huawei.com,m:lipeng321@huawei.com,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E58B6C214E

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Jun 2026 12:30:15 +0800 you wrote:
> ixp4xx_hss_probe() allocates two HDLC netdevs. The first one is stored
> in ndev, initialized, and registered with register_hdlc_device(). The
> second one is stored in port->netdev and later used by the remove path
> for unregister_hdlc_device() and free_netdev().
> 
> This means that the registered netdev is not the same object that is
> unregistered and freed on remove. It also leaks the first allocation if
> the second alloc_hdlcdev() call fails, and the first allocation is not
> checked before ndev is used.
> 
> [...]

Here is the summary with links:
  - net: ixp4xx_hss: fix duplicate HDLC netdev allocation
    https://git.kernel.org/netdev/net/c/db818b0e8af7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



