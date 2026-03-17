Return-Path: <stable+bounces-226927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BpVIzzhuWlhPAIAu9opvQ
	(envelope-from <stable+bounces-226927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 00:18:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 482A72B422B
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 00:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31B21306A1C2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF23FCB3F;
	Tue, 17 Mar 2026 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3q9VPtV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAC83F7AAA;
	Tue, 17 Mar 2026 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773789013; cv=none; b=MlLkJ5jngGvB6vWVZeSQaET1GJUphOI3e7B/glXdol1h+djmTcP7SRB/rnNzBP7KHCtEQb32L5+WuzJCctYUPJWFmJBh9ZyN+J9K29E2X6HOay4KZNu6buzPbiYwHIG81EUpAiv3cV4q24Q7CRGpp56KZS1i3Q/80HZYYumGGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773789013; c=relaxed/simple;
	bh=FRAR6S4Hyp36XlMC28mVMMAk5b3y1RKCHudTeTq665Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PTyUZTfOgSsZPGafi/eKM3cgymlivh29Fe4i3WM0alTmxkyIiE3vdRBYCO+Vt9/T1VjX3UIDmfotcCmb85ARsH7r7kR3St/z5ndVPwJAjYcET6I/CMr0Xnd4XZdJasBdhFLLb1YAK3rpB8lHYhy4vCgGV12EbxNUDJ1TNKqg9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3q9VPtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322A8C4CEF7;
	Tue, 17 Mar 2026 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773789013;
	bh=FRAR6S4Hyp36XlMC28mVMMAk5b3y1RKCHudTeTq665Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t3q9VPtV6deKsA7mefx6ca2YeiNCz+KnZ/G8V6YR/kDy7YaA9k6Av4NjVQv2Nf9UT
	 Aku79GOIblJv3wPI50WiNkTYD6yDuMOBOTBXl9EbVLsU6saFxCSwUuQB53cPJpmNJP
	 lhwOjG1IVYae3QEOrUdkF6Mmjxw80MSQ16QzU5rQh50pZVrI4ksw+wtJaHFgwJTSWo
	 9KcQrclENSFIDatrU2lcVc83UEbU35CO4cB0hxRqar8de6E2qX+H2eY5oHsAiGlE/i
	 Qqr64lsG+8+xFkrmbURMuzzgg8SoB/U3QlBSSS3qB7hPCOU1951Rvmq7gMIa8vDkgm
	 sIARGQLxJRFjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0413808200;
	Tue, 17 Mar 2026 23:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] bnxt_en: fix OOB access in DBG_BUF_PRODUCER async
 event handler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177378900504.50160.13928308847780304464.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 23:10:05 +0000
References: 
 <SYBPR01MB7881A253A1C9775D277F30E9AF42A@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To: 
 <SYBPR01MB7881A253A1C9775D277F30E9AF42A@SYBPR01MB7881.ausprd01.prod.outlook.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shruti.parab@broadcom.com,
 hongguang.gao@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, danisjiang@gmail.com, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226927-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 482A72B422B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Mar 2026 17:41:04 +0800 you wrote:
> The ASYNC_EVENT_CMPL_EVENT_ID_DBG_BUF_PRODUCER handler in
> bnxt_async_event_process() uses a firmware-supplied 'type' field
> directly as an index into bp->bs_trace[] without bounds validation.
> 
> The 'type' field is a 16-bit value extracted from DMA-mapped completion
> ring memory that the NIC writes directly to host RAM. A malicious or
> compromised NIC can supply any value from 0 to 65535, causing an
> out-of-bounds access into kernel heap memory.
> 
> [...]

Here is the summary with links:
  - [net,v3] bnxt_en: fix OOB access in DBG_BUF_PRODUCER async event handler
    https://git.kernel.org/netdev/net/c/64dcbde7f8f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



