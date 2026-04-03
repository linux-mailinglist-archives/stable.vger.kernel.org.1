Return-Path: <stable+bounces-233247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHa6M+xI0Glu5gYAu9opvQ
	(envelope-from <stable+bounces-233247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 01:10:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34445398F30
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 01:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D269F3024CBD
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 23:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782273890FE;
	Fri,  3 Apr 2026 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqxbWPyO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FCA23E320;
	Fri,  3 Apr 2026 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257829; cv=none; b=LpOKTjF0RbXfT+jiC2tWwZfuhK/Rs21H62gaop2nwEnQgty3YamW8P3BVcwRldrmXvk9ooFMzQjISCGxqByfj3qwWvqBqmQl9hv45WKkYgP5qG1/4178s5UT8Uk1Dk1ldhwtERfR1E9SGgicCM77zNbHqeY8AvBymfCaaT96bcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257829; c=relaxed/simple;
	bh=dHW2heR6p5vw6+Pt0QE9uTTUItO4MGXSvD/EFCFHJEw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cvlt4gIOkCdss3X+ZnDZqIzYsQo++RX8tHW3Q2I4izpjmJ7bX+1S3ASb/7Ql/rIXy87akka9YaM/gmLqrpN82fE+T95t056xEIxBMd74JerY7soCskPUOXcL126D6ckJ54MMg/5BaXPaPbZEnCx6UVt6A7lnYdDur6Ffkac59G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqxbWPyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ACDC19423;
	Fri,  3 Apr 2026 23:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775257828;
	bh=dHW2heR6p5vw6+Pt0QE9uTTUItO4MGXSvD/EFCFHJEw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YqxbWPyOvyxO4um/D/zqhvz6HOiCn00KDoemS/zA/M8EuRbE/l4ZetWlExTGwjnd5
	 GVk8ztWI5wdcX7rSqmpfj+1ibCMSud1geHoqeYMUb1CWXPRvJu7HEhIGBnYaplddYN
	 mTk/PZoDIU0+gaHX7pg45FTZPHjJfAeMMtwWRbf0LQW8ugBiEcyEZu1XsVVvxWt22P
	 G7g1LlSqSc/hkJsgtE+KVcGOgY386kC0pdLZniJFg9h4wCFlIPpTwD5nkzYFGcVuz+
	 VJ+sD+MUNom4n4Yb4Vswu8z1BpTUrox6WehH9A8umaFYPIwhyr94cJvnSA8E39LNBv
	 4uZ89F/O3TO3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDD13809A14;
	Fri,  3 Apr 2026 23:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nfc: s3fwrn5: allocate rx skb before consuming bytes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525781029.1484550.16067345622361730723.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 23:10:10 +0000
References: <20260402042148.65236-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260402042148.65236-1-pengpeng@iscas.ac.cn>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: krzk@kernel.org, bongsu.jeon@samsung.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233247-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
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
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34445398F30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 12:21:48 +0800 you wrote:
> s3fwrn82_uart_read() reports the number of accepted bytes to the serdev
> core. The current code consumes bytes into recv_skb and may already
> deliver a complete frame before allocating a fresh receive buffer.
> 
> If that alloc_skb() fails, the callback returns 0 even though it has
> already consumed bytes, and it leaves recv_skb as NULL for the next
> receive callback. That breaks the receive_buf() accounting contract and
> can also lead to a NULL dereference on the next skb_put_u8().
> 
> [...]

Here is the summary with links:
  - nfc: s3fwrn5: allocate rx skb before consuming bytes
    https://git.kernel.org/netdev/net/c/5c14a19d5b16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



