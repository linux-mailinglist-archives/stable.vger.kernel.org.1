Return-Path: <stable+bounces-245054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFGiNDW8AGpGMAEAu9opvQ
	(envelope-from <stable+bounces-245054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 19:11:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC47A50553D
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 19:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D8403001FAC
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267513B27C8;
	Sun, 10 May 2026 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgozvB4x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9493822A1;
	Sun, 10 May 2026 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433069; cv=none; b=o/gtpJdZl/eE8EbvU/LcAyOHk+FxSOjGsyeGDTyYKFfFrThqlFZoI90xYD0c6rGoOtkioHy7Hyz8S5N5MNqdSs55Y6HYrni4oVZ6O+kpoCxQwpKU3J/XVAAoiZ/kX2wUI9LL7BdsZsi7SmQRwIL2nz4PkPS5zzOSyiRifxIJyXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433069; c=relaxed/simple;
	bh=uWkCMdpb0fYzHgP/nseR1GXrOlMzTE9gaiu7Q4LlA5M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uFUELuIS/twQckxwl/LeK02Vonb6xH2sXG1JP36S1zOiiXcPU/3V2nxBTyqPT5RPeyLzSJigqFLidsw7pQcFd5qghS1y/Mc/e3nBE3zpaBc+yvdU4bvQJDst0J+SmkhVZ7TyEcTkare5f1ojEdYiqgHoEtfcmRtVDS+AZ2F8kEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgozvB4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E811C2BCB8;
	Sun, 10 May 2026 17:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778433069;
	bh=uWkCMdpb0fYzHgP/nseR1GXrOlMzTE9gaiu7Q4LlA5M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PgozvB4xMsa5xQ2J2CmGLTA7DB3MlAmS4wKfwEqbECDp2dDmW1BybGKL5KQs7OlqW
	 lWUQuX0jzq2CsG3PWLaCI0LvisMaadxc7D2kNKLQmQgfzB3Qz9AhQMxg7LY6QzzWHv
	 bCTv4TjMurOETsuy2HAXofb3CwfUvwgLmUPwYA0LWqcR7M6lrVU4Li7D68/plhu/bJ
	 1JDp7Fp2iT7PGSD8ypt6o1UgfFp3WVHWrEQWZ+SQStByri+hXkFUMddBq3AAwbddud
	 yNkWIgGRaW7Qvb4qzvDHAWixSAPFIy0ADjZaaZ4ixo7pGxeLy5sJjbhUAKLDFFvK+9
	 j9NinvjLYZ4qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CFC393001F;
	Sun, 10 May 2026 17:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/8] batman-adv: fix integer overflow on buff_pos
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177843301655.1434286.16917643691644742198.git-patchwork-notify@kernel.org>
Date: Sun, 10 May 2026 17:10:16 +0000
References: <20260508154314.12817-2-sw@simonwunderlich.de>
In-Reply-To: <20260508154314.12817-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, lbourennani@fuzzinglabs.com,
 stable@vger.kernel.org, apinson@fuzzinglabs.com, sven@narfation.org
X-Rspamd-Queue-Id: CC47A50553D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245054-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fuzzinglabs.com:email,narfation.org:email]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Fri,  8 May 2026 17:43:07 +0200 you wrote:
> From: Lyes Bourennani <lbourennani@fuzzinglabs.com>
> 
> Fixing an integer overflow present in batadv_iv_ogm_send_to_if. The size
> check is done using the int type in batadv_iv_ogm_aggr_packet whereas the
> buff_pos variable uses the s16 type. This could lead to an out-of-bound
> read.
> 
> [...]

Here is the summary with links:
  - [net,1/8] batman-adv: fix integer overflow on buff_pos
    https://git.kernel.org/netdev/net/c/0799e5943611
  - [net,2/8] batman-adv: reject new tp_meter sessions during teardown
    https://git.kernel.org/netdev/net/c/324354359242
  - [net,3/8] batman-adv: stop tp_meter sessions during mesh teardown
    https://git.kernel.org/netdev/net/c/3d3cf6a7314a
  - [net,4/8] batman-adv: stop caching unowned originator pointers in BAT IV
    https://git.kernel.org/netdev/net/c/f03e85835329
  - [net,5/8] batman-adv: tp_meter: fix tp_num leak on kmalloc failure
    https://git.kernel.org/netdev/net/c/ce425dd05d0f
  - [net,6/8] batman-adv: bla: prevent use-after-free when deleting claims
    https://git.kernel.org/netdev/net/c/4ae1709a3140
  - [net,7/8] batman-adv: bla: only purge non-released claims
    https://git.kernel.org/netdev/net/c/cf6b60401159
  - [net,8/8] batman-adv: bla: put backbone reference on failed claim hash insert
    https://git.kernel.org/netdev/net/c/ba9d20ee9076

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



