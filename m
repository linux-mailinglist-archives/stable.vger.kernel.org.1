Return-Path: <stable+bounces-267294-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id il9UFOeZNGoWcgYAu9opvQ
	(envelope-from <stable+bounces-267294-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 03:22:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC38E6A38AB
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 03:22:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eMTUVa1E;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267294-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267294-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CCC430DCAB2
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 01:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE98B331ED3;
	Fri, 19 Jun 2026 01:20:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982DD317158;
	Fri, 19 Jun 2026 01:20:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781832030; cv=none; b=hEMLB/x4opYbI5f72aHIeiMfhpVfZBdHyDhDp3VvCz02Be9fn0zs1Vz8+0PT+J7oUCKHrl5SJjl9s1TG0EdfLUWamXEzqlWeeJvxibRkEN9PTiCxpsrCH0Xn35oJNYnoTBEezqJV/K8xjAtYImiGtfpT3Np4SiKQskM+jonmHjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781832030; c=relaxed/simple;
	bh=9O435HB2nHcHpcJ7lpNvlQc8rPSrK6TVWxTfyZkLZ0s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KCLC6s0cf1UwMxNCZdTEUYiWmkqpC49vxLx5f3S3gIoysRiq9Gmp1xec77DsSLVEe0qjL3gKYaahXwgocmk0TscHjSiWPxCQ+eoLgXF8VkRCb9yzpmdlpXpBw5X7X8cBDfTJgqPsPPi6FeLwK+gieZ4KNEIaIV7pKZdg9AjKIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMTUVa1E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A5F1F000E9;
	Fri, 19 Jun 2026 01:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781832029;
	bh=ZPVK/Sl5RtQKBJ6Yg1YH+0BVyvCS6fX8Qf1yVRYKZHw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eMTUVa1E5985OLXAz2ypqwEkIVp3v6HNA265x5mphIUMQ8IY2sEbC8uAuFo85W2vi
	 /Z5OOIqGrNtmDb4eGUYM2v++56k2G1VnBhTItmCgQjJDbnrfNCrKKWtz6bRiQvf2ON
	 dip70eFwvemd3n4LnaEh3882/DFbLr+TJNCiKYPypN0kGCdS53SRziEI+C2TR5SnwA
	 fiVwmAO+NhcnmuPy1JTWER1XnEOTPBc54T/SF1h53qH82Oh55I9FBF0tagwwarZZ+8
	 2tlLAEwJDcQQfCLQBz6KygMoyS4dZeutsUXI0DZoVwMTkvuHwLpGhWNgn28AWiI+SY
	 OCsargfsDqc1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09F03A78A7C;
	Fri, 19 Jun 2026 01:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ena: clean up XDP TX queues when regular TX
 setup
 fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178183202238.3150917.16483912631551334888.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jun 2026 01:20:22 +0000
References: <20260616142424.4005130-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260616142424.4005130-1-dawei.feng@seu.edu.cn>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: akiyano@amazon.com, darinzon@amazon.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, sameehj@amazon.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 jianhao.xu@seu.edu.cn, stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,seu.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267294-lists,stable=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:akiyano@amazon.com,m:darinzon@amazon.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:sameehj@amazon.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC38E6A38AB

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 22:24:24 +0800 you wrote:
> create_queues_with_size_backoff() creates XDP TX queues before setting
> up the regular TX path. If the subsequent allocation or creation of
> regular TX queues fails, the error handling paths omit the teardown of the
> XDP TX queues, leading to a resource leak.
> 
> Fix this by explicitly destroying the XDP TX queue subset at the two
> missing failure points.
> 
> [...]

Here is the summary with links:
  - [net] net: ena: clean up XDP TX queues when regular TX setup fails
    https://git.kernel.org/netdev/net/c/1bd6676254b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



