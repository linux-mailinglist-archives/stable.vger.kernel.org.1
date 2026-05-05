Return-Path: <stable+bounces-243943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLSoJF9P+WkV7wIAu9opvQ
	(envelope-from <stable+bounces-243943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 04:01:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8CA4C5DFA
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 04:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 001823008636
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 02:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7248C3624C7;
	Tue,  5 May 2026 02:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sv+X+8YI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3414F8632B;
	Tue,  5 May 2026 02:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777946458; cv=none; b=b8TxVg2Wga0vii/RXdsHwoTtrxL2U5N49B5fHoNpFhvkvixI4ACduvkyQbk2/0jomQh47sLwUPne+Vn51f/3D4rucuw+e300fXBbHXg1uK64vRR/6y0AEDxyMlv3ZFDtJ/1FkMNXXztjdJkMl9tySw0BNE/kAtF5qkBU61o/sbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777946458; c=relaxed/simple;
	bh=mCtQBBJTBguiVZJ/fql3IKesu+8Fkk90kckPyJPD5Ks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=km/YXsoxFCqnvTtpEHX5AyjV39jbTJ6G3N6AvooU9CoEbbRDICzUPNqkaQ89H4FI/EcrsQlJusNvjJCg+eVlgBgOS9gnhaHEyr6ppFcv95H92k7uBLsGQDYixR62GwedZggOZu947prniLHUucO6xJBSV5hy2TvyN3k76BdwQVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sv+X+8YI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAE7C2BCF5;
	Tue,  5 May 2026 02:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777946458;
	bh=mCtQBBJTBguiVZJ/fql3IKesu+8Fkk90kckPyJPD5Ks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sv+X+8YI5YigCqtYvqeyplXtGd3iW2vfRpmAQH3BBRTP/Q+hb7JQHd3oyt2+N4SJc
	 nFpZWNCJYNjf9mA6/eavGSjNUJskIKNJ/tdiKWd+PEDyfEBlQ1zyociKPCzcXMgp3z
	 XhFracPzVI5LRsHtzMkty0GL2SpQgFNSIJh7RK7ZUlp2oDllDbMwe0tkAlC57ENjUp
	 TjeoCLyggRZLkHfjnTHPF77YE9A64jfAZTx+7cUEhe15A7aLApu3hvnMfuY+5lgh2D
	 l122nDwgheoL2Q0f0GU+7qiZmvEp+Ya+RTke2FkHY58rybzD3xdEMp0TmH8636ij3R
	 wesk4ZAzIKQMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D483930197;
	Tue,  5 May 2026 02:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netpoll: pass buffer size to egress_dev() to avoid
 MAC
 truncation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794640854.1386640.5844242432544883755.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:00:08 +0000
References: <20260501-netpoll_snprintf_fix-v1-1-84b0566e6597@debian.org>
In-Reply-To: <20260501-netpoll_snprintf_fix-v1-1-84b0566e6597@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ushankar@purestorage.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, clm@meta.com,
 kernel-team@meta.com, stable@vger.kernel.org
X-Rspamd-Queue-Id: EF8CA4C5DFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243943-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 01 May 2026 02:58:41 -0700 you wrote:
> egress_dev() formats np->dev_mac via snprintf() but receives buf as
> a bare char *, so it cannot derive the buffer size from the pointer. The
> size argument was hardcoded to MAC_ADDR_STR_LEN (3 * ETH_ALEN - 1 = 17),
> which is silly wrong in two ways:
> 
>  1) misleading kernel log output on the MAC-selected target path
>     (np->dev_name[0] == '\0'); for example "aa:bb:cc:dd:ee:ff doesn't
>     exist, aborting" was logged as "aa:bb:cc:dd:ee:f doesn't exist,
>     aborting".
> 
> [...]

Here is the summary with links:
  - [net] netpoll: pass buffer size to egress_dev() to avoid MAC truncation
    https://git.kernel.org/netdev/net/c/76b93a810757

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



