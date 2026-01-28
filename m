Return-Path: <stable+bounces-211913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDyKLG55eWkSxQEAu9opvQ
	(envelope-from <stable+bounces-211913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 03:50:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAFF9C6B0
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 03:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3E2B300CC19
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 02:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4D82BEFFB;
	Wed, 28 Jan 2026 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfD381Ia"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED03B28D;
	Wed, 28 Jan 2026 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769568615; cv=none; b=i7xAYJ3+pEtjEFeaVAhJIBDJKVMGLqQcfkDUI/gYxS6tOtBW7rE1vMxiUyv+ej4OdbE84duFul11AHfPH6tznqg1cIuN2Jrk15JewUz8ZMqoMwXmsH8t4h4bCTfRu3SimGcXuQTFJYnP8grJCX3P181ZiJyo+SfL00h504T/RE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769568615; c=relaxed/simple;
	bh=/lJBRbUw2FgOeu9CUWj5XDqNlE5oJrvnM3fCy6xORvU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tCC7KcADTfHaBey4h1YbGGa9jgg3upwDGSplmA7QIeNAbf6mKzbv89oDasDJaAwtom+3Vpx06gOqcY2KQfyaW2k3SQY7I53dqkgyOW6tQAjSRPTejzpWuCSKS3+DHcsceFxYHisA492KB0d0MlBHS8OhaOuvzLsLWCCjt9Xz1w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfD381Ia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2947DC116C6;
	Wed, 28 Jan 2026 02:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769568615;
	bh=/lJBRbUw2FgOeu9CUWj5XDqNlE5oJrvnM3fCy6xORvU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OfD381IaIQUZjrCMbXeaxVJ+CRcD6Z9F7HmYQSjZ+B8ltOaPVcrI5axo42cl1bEQq
	 7pnaoDpBa6AKgfzmP6kuISS35Hlp8qhc9FOeslp48ZC+6o/RaOrSuRmglqDN9g9CYK
	 MQcVhcw1+Hhx6/LZQbD31bJBJrAdbyhyChWvk6oIn/d3fZGLUKxNPywg5OEfuzTD61
	 ZAWqX75NyJa8fAuIVyo4SJ0p1udb/LnSqOp7om+Ou9AJ817SVCe0dF2KUagB1PoQSx
	 m0LYDfT0LE5SmDLzP0jPSi6XRZ6Pz65ujyi7ROl3lS7ittstt/e6/8m59z7f6pgCEO
	 Oey6xKHcjp1ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 119E43809A15;
	Wed, 28 Jan 2026 02:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: fix probe failure if clock read fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176956860860.1489558.7327500062965937708.git-patchwork-notify@kernel.org>
Date: Wed, 28 Jan 2026 02:50:08 +0000
References: <20260127010210.969823-1-hramamurthy@google.com>
In-Reply-To: <20260127010210.969823-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, willemb@google.com, pkaligineedi@google.com,
 ziweixiao@google.com, jordanrhee@google.com, nktgrg@google.com,
 thostet@google.com, horms@kernel.org, yyd@google.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, shacharr@google.com
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
	TAGGED_FROM(0.00)[bounces-211913-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CAFF9C6B0
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jan 2026 01:02:10 +0000 you wrote:
> From: Jordan Rhee <jordanrhee@google.com>
> 
> If timestamping is supported, GVE reads the clock during probe,
> which can fail for various reasons. Previously, this failure would
> abort the driver probe, rendering the device unusable. This behavior
> has been observed on production GCP VMs, causing driver initialization
> to fail completely.
> 
> [...]

Here is the summary with links:
  - [net] gve: fix probe failure if clock read fails
    https://git.kernel.org/netdev/net/c/a040afa3bca4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



