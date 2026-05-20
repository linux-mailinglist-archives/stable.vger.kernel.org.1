Return-Path: <stable+bounces-249725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHg6BcMVDWq5tAUAu9opvQ
	(envelope-from <stable+bounces-249725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 04:00:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBC9586ADF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 04:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D473303205C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 02:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0332FBDE0;
	Wed, 20 May 2026 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nv7yLkGr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BACB2EF653;
	Wed, 20 May 2026 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779242405; cv=none; b=F2UTQp4qgJmosP2eRizPIqKybWd60A/FdfCx15nfzCDkEgrkoisZBGV26LLz9LQVCJswDlHF03pg3B8Zen+UlohnaR8WstPIbB896X4jMhKkWP9eY64PXrhsfQhwgRDFgkjX07/QOe5qyevgJOKuDsoK0YtBImXNhHHAd3sP+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779242405; c=relaxed/simple;
	bh=hKBEjkBeMstZ1c6Gd/LoUWXY9tNVRCfCjbXJBLjXIuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JM2gySh0hmlJtF56ZwMG8bO/9Dt/Mo3O2iNrum5Cm9pEd9eEbVrxYQXHHveuyR4+wWGL9lptWixOfuJ4sTZU+g6H1gQViIKbxLADMfAlSLevTj1n30VKvsUKh+ZIUh5VVx4+CHZFAMk9Q7Ss/5ABecLocFf5JNaDIV+oyKKcoPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv7yLkGr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58141F00893;
	Wed, 20 May 2026 02:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779242403;
	bh=dR/8v3e09UhAOIRZ3hglRVOtYohxPzpuknZycuXiDak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nv7yLkGrLIotlnFTB03VueCyXYawMtkpjjTFVjk9B0/qbo/mYnhr5QPpLAu/j1VQ7
	 q4NQNysnp9F4S2H/zJZNHipzcVaNv6VaJlj5+rK8w3IaaS3X9SJ75yE21IR4G7lpbs
	 aT3yzRjmcnxix+ZvzNGUNwRgEqG8ABWFuzp/6XRuBnXg3nca1jE6oTKlmsfeVVL9Nx
	 Poga8OQtdlm8Ztk4U+ELdUtQ0E+n1uWSdTsW3uEVfjQlggKQKfem4e74rvqnfPqlnN
	 D5lKyQT+pq3EiEN7NuZpwNk/IkhViQJ2vuEkEBI4joXe/4JI+ml3GQmmJA0IPMBdYg
	 bcKrRO7Lq1ujA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0958383BF53;
	Wed, 20 May 2026 02:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] af_unix: Fix UAF read of tail->len in
 unix_stream_data_wait()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177924241439.2949285.2336931812292012916.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 02:00:14 +0000
References: <20260518-b4-unix-recv-wait-hotfix-v2-1-83e29ce8ad31@google.com>
In-Reply-To: <20260518-b4-unix-recv-wait-hotfix-v2-1-83e29ce8ad31@google.com>
To: Jann Horn <jannh@google.com>
Cc: kuniyu@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 hannes@stressinduktion.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-249725-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9DBC9586ADF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 May 2026 18:51:30 +0200 you wrote:
> unix_stream_data_wait() does skb_peek_tail(&sk->sk_receive_queue) without
> holding any lock that prevents SKBs on that queue from being dequeued and
> freed.
> This has been the case since commit 79f632c71bea ("unix/stream: fix
> peeking with an offset larger than data in queue").
> The first consequence of this is that the pointer comparison
> `tail != last` can be false even if `last` semantically refers to an
> already-freed SKB while `tail` is a new SKB allocated at the same address;
> which can cause unix_stream_data_wait() to wrongly keep blocking after new
> data has arrived, but only in a weird scenario where a peeking recv() and
> a normal recv() on the same socket are racing, which is probably not a
> real problem.
> 
> [...]

Here is the summary with links:
  - [net,v2] af_unix: Fix UAF read of tail->len in unix_stream_data_wait()
    https://git.kernel.org/netdev/net/c/be309f8eae8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



