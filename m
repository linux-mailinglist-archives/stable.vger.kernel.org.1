Return-Path: <stable+bounces-240462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACH3CvEC6mk/rQIAu9opvQ
	(envelope-from <stable+bounces-240462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:30:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCAF4514C4
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20A813012271
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38D33E6DC0;
	Thu, 23 Apr 2026 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKZatFvi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A7A37DEB6;
	Thu, 23 Apr 2026 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776943847; cv=none; b=eBMx32pIQOfRiCoDZ/jTqp+eXzQFuuLm9BKgslb2paJDghGLOEy+wkIYuuHxw0ZENS5ujK/OQAqta61kS8DGigJ3zG3pY5Al1G3Xjkxj3MQwjS9xgeKm3Qst8PBdFEKqaJSetKuJeiQFJVI01N7flcAjqcpvNw24oj1L/06U9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776943847; c=relaxed/simple;
	bh=NrXVaIGlP5AkCzLvvuGh+M3UJGrqHoUqwFe78v+0LcQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TVpB7j3Wk6MzUcXjMfN0g6qp4a3FvmdAXWn7fZ81fL34tlLDdfCB+PBeDstpTA5nG5BhnyxA3hKsnGt8JKguZeOxkhyCkQs18jFOcNvYevCs1+W1UMPG0QLKZ5sZAAXflmX5/r4wRBD9FIuaYTtWDrjF/5GKSmuTk7se8iwY7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKZatFvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F68EC2BCAF;
	Thu, 23 Apr 2026 11:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776943847;
	bh=NrXVaIGlP5AkCzLvvuGh+M3UJGrqHoUqwFe78v+0LcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nKZatFvinew0FRPe+p/Wi9YN1SmGcOdRhkitnNgLbfGyrLAbhBRIJVeOVuLEqxXgL
	 DGmT1MOVoEpJMla43mAJjmM0ZhAt1S5kT/3FJjD9GYUGxabqGwScF+L2+BLhUzqpVQ
	 7ZlMsvgHZ1uo1c256yJfHj+zBRPDjXRKGHYdJjktkb91Rw9t4bP0raRxH9+5OGDgm0
	 w61wmk2n7bRm1JEXUqn6hTLp0avAtyKFuFUhE9C5a/y2rafn4HJH8Go5jsLScT8Pxt
	 88OCGQAdA73+Q58ptsDSHlTwBE4hawWQvocPjSD1jpXrqfqL99k4Xp13XdAZVHi1FR
	 +tWkHSeIY05ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E85380CFFD;
	Thu, 23 Apr 2026 11:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mptcp: sync the msk->sndbuf at accept() time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177694380880.122796.15654680587804880799.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 11:30:08 +0000
References: 
 <20260420-net-mptcp-sync-sndbuf-accept-v1-0-e3523e3aeb44@kernel.org>
In-Reply-To: 
 <20260420-net-mptcp-sync-sndbuf-accept-v1-0-e3523e3aeb44@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 yangang@kylinos.cn, stable@vger.kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240462-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCCAF4514C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 20 Apr 2026 18:19:22 +0200 you wrote:
> On passive MPTCP connections, the MPTCP socket send buffer doesn't have
> the expected size at accept() time.
> 
> Patch 1 fixes the regression introduced in v6.7, while the following one
> validates the fix in the selftests.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,1/2] mptcp: sync the msk->sndbuf at accept() time
    https://git.kernel.org/netdev/net/c/fcf04b143346
  - [net,2/2] selftests: mptcp: add a check for sndbuf of S/C
    https://git.kernel.org/netdev/net/c/d0576eb8508e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



