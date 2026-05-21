Return-Path: <stable+bounces-253427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJLmObJsDmob+gUAu9opvQ
	(envelope-from <stable+bounces-253427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 04:23:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8567B59E095
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 04:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CB4530AAA91
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7DA360EEA;
	Thu, 21 May 2026 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+qMr8Yn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523703655E5;
	Thu, 21 May 2026 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330019; cv=none; b=k8GgBJyOBeoQEAk7wZ9bQbdsGnkroAhrmVuk/fs1raVD842/tfvmUWKiM0tS13ERQcR0+/HMYLrFtET6cqpcV047EfDJzOnu0JgHk7FWX+Y/lZpRyrwNZrk34pXSK7Zwv6+hCRk4cSyPI3TYeLO6iqMJE9w/PpaTCKd0CkdNiVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330019; c=relaxed/simple;
	bh=BjlukyP5bTQHvs0L2QCUfZaNLjb0pmJmzWqNyPaH4x8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FYufTrqNLKpuKPDgIHd774X0A0ZtFqwvr2ZlN8z2gvQ+jJX8DPYJ0ab6ojLQ77mJFFMZuNHgr2B72DQuHjbJat1PXke0EfKzOn0vv37JnQBez+I9vyUQQND0BAx+WskoSageO6vnqGc23qhuTypplzsMOUCmSWXotK1axsn/4Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+qMr8Yn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F101F00A3B;
	Thu, 21 May 2026 02:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329996;
	bh=oxGAPtkWo6+OlSRC8RjNsfV13vDMRjGxMBTahMYmMYM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c+qMr8Yn8HYJbW/OjWYlXsWHr7hZ9p2k9OaCW0c8ykfn5HxUDGsEKyZPmDDcWemUC
	 XkOGMjxPVzC+87W4pelYHsLKyHaaCjrZXRwaEYBVhHZBkkElLjtJadp/yx+pgXUniF
	 RcZrHDU1e5yyQColjQ7PfYfPXQBR34kpbZRX+tYMlcDhc0VIiNaAv3OBvSLFBHHQfi
	 Ee4V58Ae4FXzZ3Zx39k9HWGnYlwFGnLUzhFcSwE9Nv+5jLiGzDBV2qXTMYwiJ664Zn
	 0tFMU4QRGXQXjA0kzn3svXEze0vdUjUMSqioUncQciImvWIn5D0uuQqHtgqOkzSZL9
	 PsdCMj90IocNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569183930C38;
	Thu, 21 May 2026 02:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] vsock/vmci: fix UAF when peer resets connection
 during
 handshake
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177933000715.3834961.4605675753542747762.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 02:20:07 +0000
References: <20260519102310.237181-1-minhnguyen.080505@gmail.com>
In-Reply-To: <20260519102310.237181-1-minhnguyen.080505@gmail.com>
To: Minh Nguyen <minhnguyen.080505@gmail.com>
Cc: pabeni@redhat.com, bryan-bt.tan@broadcom.com, sgarzare@redhat.com,
 vishnu.dasa@broadcom.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253427-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8567B59E095
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 17:23:10 +0700 you wrote:
> vmci_transport_recv_connecting_server() returned err = 0 for a peer
> RST in its default switch arm:
> 
> 	err = pkt->type == VMCI_TRANSPORT_PACKET_TYPE_RST ? 0 : -EINVAL;
> 
> That made vmci_transport_recv_listen() skip vsock_remove_pending(),
> leaving the pending socket on the listener's pending_links with
> sk_state = TCP_CLOSE while destroy: still dropped the explicit
> reference taken before schedule_delayed_work().
> 
> [...]

Here is the summary with links:
  - [net,v4] vsock/vmci: fix UAF when peer resets connection during handshake
    https://git.kernel.org/netdev/net/c/99e22ddf4edb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



