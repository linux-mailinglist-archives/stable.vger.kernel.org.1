Return-Path: <stable+bounces-269322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3W31GHIsP2rkPgkAu9opvQ
	(envelope-from <stable+bounces-269322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 03:50:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C6C6D0BEB
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 03:50:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OPjKBw7d;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269322-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269322-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC20303A262
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 01:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D4C25B0AC;
	Sat, 27 Jun 2026 01:50:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A770836;
	Sat, 27 Jun 2026 01:50:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782525027; cv=none; b=LofUuVRirIkc/l+alXj8sOfdsbdd2rlBQnhJxF7jCbFHA+nsJU3xKBNys6edy4/K4TSFEGVQDGsE8xmdLAcMA4i8Elivr4wZFlhmGUa1NMyt73U8F0h8bGVZ2w6tN10mGYM4sVJn3iDlQaMqIiGdDEHzo9gTDWAP23RJW9pXxP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782525027; c=relaxed/simple;
	bh=G58EgNrcpZUfSYoK4o3L0lpfFnDgyFvICuW4mDmOVzE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EORF2QFp0qgIFxD91USGyIkC+IUJBRsJz61lZ6i4lI9GVGkq8PvR5fdC+64xON17EYT+vgzK6hle5D0FDC2CxIXqLxGu2BXS0VBefI4tzXubEGzhsHBpR93faUCBKKXhzu8PZyb3uZPoioboAsWeJEQRA/tm4tH4Rif8vknyOZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPjKBw7d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF901F000E9;
	Sat, 27 Jun 2026 01:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782525026;
	bh=mQiiIhFV/ARXUNyGYP0/EIYCz0UP+z2qwf/qpNzZD90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OPjKBw7dNDQUgKvlQS4lb/rMhmPuZPwUSkw7lYtdU0wpoVZtx7JkwlkUHVV5OgS2Z
	 TK0EjzHXdmMQVyLN9FqE8xxzi5CSWmQQWg7AT3Ed8CGcQDgIONMPSPIHKbonawz/Wc
	 fhfk4Jeia+/w9zloXwkHfK6sLflMnfG1p/yipAUjHp7vNzXxHEzSwHJCrjwKMeIao0
	 ZUPGPXjZQt9peQYrPgfRGpK3pqj+3q8BZX07n9JyLD+FXEzCpWpjpCFkvZQ4RJpXmo
	 L8l3g5PWsL7IlfMUGUQ45w7OkI5Po1SmlvuCC+Pud8gLU+pLdoHqLmnQ56TZtxnCAp
	 LYe2vITRFwdIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B2F3938C76;
	Sat, 27 Jun 2026 01:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ipa: fix SMEM state handle leaks in SMP2P
 init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178252501255.1164679.2346571927021694863.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 01:50:12 +0000
References: <20260624065955.2822765-1-haoxiang_li2024@163.com>
In-Reply-To: <20260624065955.2822765-1-haoxiang_li2024@163.com>
To: haoxiang_li2024 <haoxiang_li2024@163.com>
Cc: elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269322-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5C6C6D0BEB

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jun 2026 14:59:55 +0800 you wrote:
> ipa_smp2p_init() acquires two Qualcomm SMEM state handles with
> qcom_smem_state_get(). However, neither the init error paths
> nor ipa_smp2p_exit() release them.
> 
> Release both handles with qcom_smem_state_put() in the init
> error paths and in ipa_smp2p_exit().
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ipa: fix SMEM state handle leaks in SMP2P init
    https://git.kernel.org/netdev/net/c/96ca1e658ae4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



