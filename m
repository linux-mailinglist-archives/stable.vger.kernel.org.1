Return-Path: <stable+bounces-242566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PduIy1B9WluJwIAu9opvQ
	(envelope-from <stable+bounces-242566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 02:11:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7F64B06FD
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 02:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AFDD3021E57
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 00:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A2478F4F;
	Sat,  2 May 2026 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJNGSbdT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD837946A;
	Sat,  2 May 2026 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777680662; cv=none; b=nsizM4+YtxHiGIUhbJvZXKzphsZvoLDx03vh7hxkTvGikNxTH4VzFyUMZp21YGrrpDSdzlu13EUNQJOzU1+eB0It2CqjjpltBv7rwZh+nvok8mx+aTC5V0d+fUlXrTQo5ypp29T6wnRtj/LrVY00tvVmvg+9curq/Y5bKBlSsiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777680662; c=relaxed/simple;
	bh=ZB1wBU/9SoybehnGYuWC7XoFpzOOyQ4uzj7+8NesIHA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kmbpIotNFhu3zf/2KzvTLV6/D80M6vw3+gIH4QDdLdhaVAtD6KVSnr/Pl5k0D3NPymgTGS+EOgTVqnzDdE6jBvxVWOOcFm8dZTrPKk4B26+VqGy23acqndAhijDMlnXm7VfjG9Rdv/cl/HN0TFRpAf35B4KlqUubsmuyiypxMoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJNGSbdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790E0C2BCB4;
	Sat,  2 May 2026 00:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777680662;
	bh=ZB1wBU/9SoybehnGYuWC7XoFpzOOyQ4uzj7+8NesIHA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AJNGSbdT0H5d4Wbr9oVu7k+Q1XQX/xHGrmv5/7Sw6o0adXEaokPT7Wu0zbWQTShXh
	 CVx6uXsOVKzWh+k59uXXFnY/kuwGRuMMSdOEeL/btWtwvQAVBpcWgkdXsgpvMTrGgo
	 Kk2kx0d5elB7hCjx4/Xz/FwIw48IfpKehmbD1O+r4pT6l+22kC5vviHo7JNoUk4kCb
	 +ypSAWL9uvcQBhcqNX1Nh0UmZ0Wufy73SE18LLyGKwlnj/bbwGcH/P6tieMpQMUxtt
	 zSMBtOeV/fAH7Pt4t74D/2IH8q5xE0d5cKCLcHy0wLPj+BnhWJwnsUDAuTatirJlUa
	 UM4AGLQK84RZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E1C380CEF5;
	Sat,  2 May 2026 00:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: rtnetlink: zero ifla_vf_broadcast to avoid
 stack
 infoleak in rtnl_fill_vfinfo
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177768061529.3667015.10371516627553686515.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 00:10:15 +0000
References: 
 <3c506e8f936e52b57620269b55c348af05d413a2.1777557228.git.kai.aizen.dev@gmail.com>
In-Reply-To: 
 <3c506e8f936e52b57620269b55c348af05d413a2.1777557228.git.kai.aizen.dev@gmail.com>
To: Kai Aizen <kai.aizen.dev@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 gregkh@linuxfoundation.org
X-Rspamd-Queue-Id: 0F7F64B06FD
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-242566-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 18:26:48 +0300 you wrote:
> rtnl_fill_vfinfo() declares struct ifla_vf_broadcast on the stack
> without initialisation:
> 
> 	struct ifla_vf_broadcast vf_broadcast;
> 
> The struct contains a single fixed 32-byte field:
> 
> [...]

Here is the summary with links:
  - [net,v3] net: rtnetlink: zero ifla_vf_broadcast to avoid stack infoleak in rtnl_fill_vfinfo
    https://git.kernel.org/netdev/net/c/4b9e32799181

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



