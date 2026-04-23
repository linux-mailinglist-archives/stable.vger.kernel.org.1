Return-Path: <stable+bounces-240458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAamMI/56WnkpwIAu9opvQ
	(envelope-from <stable+bounces-240458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 12:50:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F177450E91
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 12:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4044E301C941
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 10:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F803E0C70;
	Thu, 23 Apr 2026 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3aikQ5d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB537CD5D;
	Thu, 23 Apr 2026 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941448; cv=none; b=Zzh40RU+lUCijfDlvRwF31WJyq2WbrHZgvkttziTyZfz8VUsAy5NSAqH6ZqLr/bNDKB/p4r8mlRGOJwdpJk89GpvpgbjpzEdHFMERlBD32VknxbVfZ2q9OhZ/5FLRJLiIrLTNFtINIGR704b8CD/Ks0W154aTcywoMvGBNnv9KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941448; c=relaxed/simple;
	bh=eir+BUlfUS4e+XkD6ZVGW+TBZknqiVcFTknAokUh7KI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q+Dqv6lfqHe/rtgj0ZJpcWJCNCgqOaPh6+ZFtcLrhLI4Bj25WlrrmBdrfPCUzrYAeh+BnPGcQpwQXx56HXvKZUJ3d1ZtOKkeTF3lsovwX6mVIuIE/Jl1p6UYeDCJQaztZLD1MwQMVR6+qJb1awAbXaQethAm6RPwLE7KmKI0E14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3aikQ5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B739C2BCAF;
	Thu, 23 Apr 2026 10:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776941448;
	bh=eir+BUlfUS4e+XkD6ZVGW+TBZknqiVcFTknAokUh7KI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V3aikQ5d9ucXyuGllp6DENF7/bppQ9sGI4kZmpqWR5USGpH6OD4iELbXGyzXMUWCq
	 zZAobeN/S3vHuIxcOqYrl4F7h/p9wPq/zkdowbpWMwE356DDG0gB7nP7QTloXatHR+
	 B6eNE8S5BXbReVT8muB4VgquyB/u75xqyLKPY2IJ9IVKZYLfVLb3Vp3BfgFdRNIRd4
	 CfqN2munwaDGMBlYyBkthmm/diRVtQEVfOdVXwVzT743uO/6LEOMjckAo0LAho698V
	 PVzoaJvp+6IHJjaz6QFu+XhGjrar8SOs0WfEDCGOfLnGZKvHk602WFJYWxLSvc69CM
	 R6YgrOMg2+xdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D71380CFFD;
	Thu, 23 Apr 2026 10:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netconsole: avoid out-of-bounds access on empty
 string
 in trim_newline()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177694140981.106550.16916461614623666147.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 10:50:09 +0000
References: <20260420-netcons_trim_newline-v1-1-dc35889aeedf@debian.org>
In-Reply-To: <20260420-netcons_trim_newline-v1-1-dc35889aeedf@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, thepacketgeek@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,meta.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-240458-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F177450E91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 20 Apr 2026 03:18:36 -0700 you wrote:
> trim_newline() unconditionally dereferences s[len - 1] after computing
> len = strnlen(s, maxlen). When the string is empty, len is 0 and the
> expression underflows to s[(size_t)-1], reading (and potentially
> writing) one byte before the buffer.
> 
> The two callers feed trim_newline() with the result of strscpy() from
> configfs store callbacks (dev_name_store, userdatum_value_store).
> configfs guarantees count >= 1 reaches the callback, but the byte
> itself can be NUL: a userspace write(fd, "\0", 1) leaves the
> destination empty after strscpy() and triggers the underflow. The OOB
> write only fires if the adjacent byte happens to be '\n', so this is
> not a security issue, but the access is undefined behaviour either way.
> 
> [...]

Here is the summary with links:
  - [net] netconsole: avoid out-of-bounds access on empty string in trim_newline()
    https://git.kernel.org/netdev/net/c/7079c8c13f2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



