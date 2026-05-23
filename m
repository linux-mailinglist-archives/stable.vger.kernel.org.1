Return-Path: <stable+bounces-253874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD5XFJoPEWrDgwYAu9opvQ
	(envelope-from <stable+bounces-253874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 04:23:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C31FE5BC9A9
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 04:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D2B4304BF26
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 02:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD70635AC27;
	Sat, 23 May 2026 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4taf3ip"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498F92EB84E;
	Sat, 23 May 2026 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779502822; cv=none; b=lqtkDJYv2TOZ2rGki8mdTV4PKLKTjhvrpPUjG0xarIpXlr4eMJsbP0cTKCJMbe5vkOj21gh6ocERcZx9AMnh+L5o0yq/cQALqJ5Nmsnl983qZHyW6FyB6vmW24nq/29NIVS+c5KOpJMvc42dyWJQm95jBVOa2nvtPnabj2XGl8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779502822; c=relaxed/simple;
	bh=TftbvUH9N6EldBCuw32plM2I4zDKKxadrGCnuP27TJM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aoqOveR2OBJsCWcJjp8Kq1x9V9ME2KKQ7ElFj3GxeXRRg/at31O3tX44lsUbM19JSj4OdGDlKW3m0OXHc3ki1QfmXolP/c4QL7Rfs6079vguICf3nS7UeSWTZSfI2z9IUeb5UT3PuEA5AzulGOfH+4PF7S9y12V2xs+yS1tKO7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4taf3ip; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118801F00A3A;
	Sat, 23 May 2026 02:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779502821;
	bh=FCB32I04tXOU3A4ivBWnoocFg6h6DTzbS5mMPphmppE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O4taf3ip4l+MOTs9BgdWuIp8pey+Sz8LYtkp051amHYvxgcmAeBqhbJvbLMJkzgqB
	 Y4rT5yfULhJ0m2uPmfMQTSQ/zeeWBeMUHKO9sRy8oofHlCA9hJbyxqkaWcdSXp+dmi
	 rSyQsLkkYtnnRid2Fy8Ewb9/NiD6J9LdcUOkcKSM2/VEk8gEc3wgpHGw+1hCWjTMNe
	 nFqF+y065qVDHdlJiuiab3yh6wn8BdPGOrfREKOQ/VGCr/SI9Ue7Hdq5B36SFAzmlI
	 HoQg2fYPPtFTDWjanurIIVyrWI7f3Gtwvz1oLeLPJhkq8QjxQgXX7vYANXTkYvlwEm
	 hYj0OW7p77U/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198273808205;
	Sat, 23 May 2026 02:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
Date: Sat, 23 May 2026 02:20:29 +0000
References: <20260521124732.125771-1-sgarzare@redhat.com>
In-Reply-To: <20260521124732.125771-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, xuanzhuo@linux.alibaba.com, horms@kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com, pabeni@redhat.com,
 mst@redhat.com, davem@davemloft.net, jasowang@redhat.com,
 stefanha@redhat.com, edumazet@google.com, stable@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253874-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C31FE5BC9A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 14:47:32 +0200 you wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
> to 32-bit values. The multiplication can overflow before being assigned to
> the u64 skb_overhead variable, making the skb overhead check ineffective.
> 
> Cast skb_queue_len() to u64 so the multiplication is always performed in
> 64-bit arithmetic.
> 
> [...]

Here is the summary with links:
  - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
    https://git.kernel.org/netdev/net/c/4157501b9a8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



