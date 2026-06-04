Return-Path: <stable+bounces-260361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5b/zDtZKIWq0CgEAu9opvQ
	(envelope-from <stable+bounces-260361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 11:52:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A2863EB2B
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 11:52:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=d6iP0khd;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260361-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-260361-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B643307E2E0
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 09:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C56D3CD8D7;
	Thu,  4 Jun 2026 09:50:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F43976AD;
	Thu,  4 Jun 2026 09:50:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566607; cv=none; b=MtMJksrts0S7eUHVd/5aNQqSLLF3PIbfL2km3i19fLZ1AswUAEh5yI9DWWKqbR8IjvoNkowUzFwV8JYdLqFw+y9ab6KAJcGfd4rbJeA0ywPfQQxfVuxXMDboPvRSHhDSQmhUEEe2Ah4QOFfHC2MDoy2fZ99PubrWkz1cO7C/4sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566607; c=relaxed/simple;
	bh=VjTz8+WeiUzWcBdR1Rs4zqbDM7DUGzeYknM8QM87u7g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mk9D2p2Ty/LiBKDR4+g7iqPNEdzYB9t3pR9ZmlUuOd74EYX4L8rOrqgloIfrMZvDDwDeRseJVSjCs6iYmXWCtJy1Fzk34ec1GmlNe69o0H/l+bucNtf48esXcTnjVK/f4kab0X+/wV/ONT/nFCTlM1bfQoNjN26cqRjLV9r9Y+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6iP0khd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BB01F00893;
	Thu,  4 Jun 2026 09:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780566605;
	bh=O28jlKo2Rqtk1QypQ4hf3RUWWZ+g2xqi0sDgvdKBjSU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=d6iP0khdSRO9oJ9jhpsJFigjkK4PxYrrDYsCg1mL8By1f9fJYGeHurMK2aXCWMPFX
	 gp4273JFIdC3YvcQikPPJxtTzLOBXy9nbo7tev87uFvt5qR3iVBXmz5XYRD+gflaK6
	 fG2zGXApPazkVr/ThpvCnJj8Qxf/oLbv8z01G59MlmuQL2KtpUITO9udQxpIsmJvW9
	 DYY0Vhh7LnXkGK7ixtlpGs2Ay7T8iN+pRe2xPJwE19DZFdSMkaN0eNRZYESS/DD1En
	 B41wVeHqSIUEnkiu7tkXluKxeQXTJeoMNyR0MAK5XUakjh0rCPXStR+BcYFKea8j7g
	 Q6ArEyLWhNd/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1987F393090A;
	Thu,  4 Jun 2026 09:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: bonding: fix NULL pointer dereference in
 bond_do_ioctl()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178056660688.2344782.1689826187240652656.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 09:50:06 +0000
References: <20260601085649.4029067-1-zhaojinming@uniontech.com>
In-Reply-To: <20260601085649.4029067-1-zhaojinming@uniontech.com>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jarod@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260361-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaojinming@uniontech.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jarod@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14A2863EB2B

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  1 Jun 2026 16:56:49 +0800 you wrote:
> In bond_do_ioctl(), slave_dev is obtained via __dev_get_by_name() which
> can return NULL if the requested interface name does not exist. However,
> the subsequent slave_dbg() call is placed before the NULL check:
> 
>     slave_dev = __dev_get_by_name(net, ifr->ifr_slave);
>     slave_dbg(bond_dev, slave_dev, "slave_dev=%p:\n", slave_dev); //here
>     if (!slave_dev)
>         return -ENODEV;
> 
> [...]

Here is the summary with links:
  - net: bonding: fix NULL pointer dereference in bond_do_ioctl()
    https://git.kernel.org/netdev/net/c/a764b0e8317a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



