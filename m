Return-Path: <stable+bounces-233135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFIkI4waz2ndswYAu9opvQ
	(envelope-from <stable+bounces-233135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 03:40:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 365193901BE
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 03:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B2EB301061B
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 01:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C3533CEA8;
	Fri,  3 Apr 2026 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5bYJ0jb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651CE248F62;
	Fri,  3 Apr 2026 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775180423; cv=none; b=iri2Oqiz+q8OVmvJOFDZPP4zyGz/4jbZbpVIIpjXgzgBa5FmgYSwLagkvv9/1buNwRP9dgF256wq6U6A98wGEfFuXlvPfXitUvGFinoHpMEM0zM5KX13kptO70IqrdyurbTIelE7BffbK+oaifdRFFJt/ZOjjM7mkz54dPmGAfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775180423; c=relaxed/simple;
	bh=fsLYb4Ud5XTwC6TrojQFLPZuTJroc9T0vlmJ/ao7dPE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZzoMitZxcscaV3K8B91J46I1TJEevVdWO2uoWZ3nhENBKk2/e60ivc4ukGWlw76MH9bxsiz3OieRSpGpUgnsis7agg7c+Q5c+KZ3YR1tu5ynn+xJEo0/cJx7PhHKzUIms8e5PaG18R7tbVxPnG3DUiau07FPTOjcahWFDYVE36E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5bYJ0jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F98C116C6;
	Fri,  3 Apr 2026 01:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775180422;
	bh=fsLYb4Ud5XTwC6TrojQFLPZuTJroc9T0vlmJ/ao7dPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L5bYJ0jbXrCV1eIw4jwXNy7Cs0nzdJwX2EO3NAyj7DaD+dyaWE6HXLiVMdBdEEHq7
	 pcN5zZ6nQqvOyc9sO1+liFxbA0oWhmvXuEQjW6dS3zip9viaJZU5Z0LUGPVb7LUJM0
	 TfXzVnwmxIYBBEEm3eGJJVUz2wuXjDftZ1lyOk3WYd4sQX+TcqTAfa+TD7czyo4CYq
	 Yw9ZmL5B9HDAQVxEW+Wi7BCPPrXCvUhHm10+G1Kdaw7Pe7tQOtvN2k+zbKdcfm9Bgk
	 /pzDlYQp7xkto+b7ZeQfxo5xr2rv83YaHdP9FhJaQRzg7/YtcW/3eIKN1QF37F56tP
	 4oKFXzigr6NSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEBF3809A09;
	Fri,  3 Apr 2026 01:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: stmmac: fix integer underflow in chain mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177518040504.695500.16991408792529734649.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 01:40:05 +0000
References: <20260401044708.1386919-1-LivelyCarpet87@gmail.com>
In-Reply-To: <20260401044708.1386919-1-LivelyCarpet87@gmail.com>
To: Tyllis Xu <livelycarpet87@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 peppe.cavallaro@st.com, rayagond@vayavyalabs.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, danisjiang@gmail.com, ychen@northwestern.edu,
 LivelyCarpet87@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233135-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,st.com,vayavyalabs.com,gmail.com,northwestern.edu];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 365193901BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 31 Mar 2026 23:47:07 -0500 you wrote:
> The jumbo_frm() chain-mode implementation unconditionally computes
> 
>     len = nopaged_len - bmax;
> 
> where nopaged_len = skb_headlen(skb) (linear bytes only) and bmax is
> BUF_SIZE_8KiB or BUF_SIZE_2KiB.  However, the caller stmmac_xmit()
> decides to invoke jumbo_frm() based on skb->len (total length including
> page fragments):
> 
> [...]

Here is the summary with links:
  - [net,v2] net: stmmac: fix integer underflow in chain mode
    https://git.kernel.org/netdev/net/c/51f4e090b9f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



