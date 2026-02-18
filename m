Return-Path: <stable+bounces-217204-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ClNAIQYlWmiLAIAu9opvQ
	(envelope-from <stable+bounces-217204-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 02:40:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFDC1528DF
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 02:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D94E302D517
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 01:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37A828002B;
	Wed, 18 Feb 2026 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGRMRqbE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85645270ED7;
	Wed, 18 Feb 2026 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771378813; cv=none; b=URJ/oy+PBP37xxcavHL4cKozy6Vbrbwqepuo00ZuvW/fHDBEDliYNV/nEEGDmyibIOj/e80nImzaV+mwUVkLCg0wVFVPhnq3hbngDnwZWwYi2fEH994h7wxt/AUrbD1RC1mK73LoQtZH+zpNK1GseShKe2naoNX8otDko3tBl+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771378813; c=relaxed/simple;
	bh=xDMU6xe/gvXUM3uzPRrZLpCMCm6eyCNOCpnh6A8pi5w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hfoVpGtVrxBKu3STgSlIlogRV7lDfG1UhEFFMpgwSU+KVxmaK5kxDQKuv+bcGD1DXVhv/QWUFjkQHkhgPFQZqQEEGd0folE2UiW+gVxgcXFzHFjYmnjlzjUqP5H6odCidJ9G6tFMkBMQEtMQx7xnAl1T16DtqMuOPa7Db8zG0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGRMRqbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CF8C4CEF7;
	Wed, 18 Feb 2026 01:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771378813;
	bh=xDMU6xe/gvXUM3uzPRrZLpCMCm6eyCNOCpnh6A8pi5w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oGRMRqbE254X1+qUOH7KhyxoqW9Qm7Lg0haDcH4a/nlPxiINkKPbQDVXAHv7KOAzs
	 glUBsGVrtMlzBgJS8sKEXaWAJnOL3kXwBqs8aUKJapOklVPF2Y6+4GrAniWKodJJji
	 Laah9biJn2N6rZrJU1PwmNnsimUf/L9e5m2PzBtW4A2Oi/qAodxHcYv2kdeUBdXXt2
	 pIhEZ5EDTmzPeKxv7/LEcmeqUGq/qk4rGfguQuk5NzREJXRoeq3H9E+fAD1NROqwAW
	 ArG0bQQ5Qwg3bm0K7L/t1HrJe706RS+MipqvVGCUEFCwQTwr5yS/3/Va1Tr3QEOtr4
	 RCIek0HXxtJsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 482333806667;
	Wed, 18 Feb 2026 01:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net/sched: act_skbedit: fix divide-by-zero in
 tcf_skbedit_hash()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177137880508.770724.8992862496888446687.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 01:40:05 +0000
References: <20260213175948.1505257-1-cnitlrt@gmail.com>
In-Reply-To: <20260213175948.1505257-1-cnitlrt@gmail.com>
To: Ruitong Liu <cnitlrt@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, L0x1c3r@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217204-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CFDC1528DF
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Feb 2026 01:59:48 +0800 you wrote:
> Commit 38a6f0865796 ("net: sched: support hash selecting tx queue")
> added SKBEDIT_F_TXQ_SKBHASH support. The inclusive range size is
> computed as:
> 
> mapping_mod = queue_mapping_max - queue_mapping + 1;
> 
> The range size can be 65536 when the requested range covers all possible
> u16 queue IDs (e.g. queue_mapping=0 and queue_mapping_max=U16_MAX).
> That value cannot be represented in a u16 and previously wrapped to 0,
> so tcf_skbedit_hash() could trigger a divide-by-zero:
> 
> [...]

Here is the summary with links:
  - [v3] net/sched: act_skbedit: fix divide-by-zero in tcf_skbedit_hash()
    https://git.kernel.org/netdev/net/c/be054cc66f73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



