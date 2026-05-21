Return-Path: <stable+bounces-253425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPj5M2RqDmob+gUAu9opvQ
	(envelope-from <stable+bounces-253425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 04:13:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A6159DF51
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 04:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E21F830930CC
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741843264F4;
	Thu, 21 May 2026 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjF0/8jo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D921315D5D;
	Thu, 21 May 2026 02:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329405; cv=none; b=Kibkp1Fy5XwgT/PE7S7M7tDTBmlKcZLmy1p/bgEYq1zDyFP4bqbXRhWCNjLiZY6iLIllQCD9MtAJN7dE7XI5Tp0Z6TGYlL2o2ElY2se3d2/j6GDL2mVlqs7j18VBduP3ByHCt6VI3Hy14PSXqumzDye6DAhv4YaJYBOj5gCEcME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329405; c=relaxed/simple;
	bh=UgYPH//PtIThmGBRE1rQCbe17dkIJeEgIMyoDso9+0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IqsCYtcbpN6ota3lWB2fxLmrwjowilM08JxDLHO2DBk3QBZHLt2lYUqwIOLcFsAz00I5gCOLYzDJ5UCz6RM5tMBGxSHUEPWZOXCYwPuDELYq1L5RnWqCN8A4kuPDWrHgXxQp7IlpcaW1qGPgBVkQ4aw859bZw+qczXXEUIIYHXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjF0/8jo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA55C1F000E9;
	Thu, 21 May 2026 02:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779329403;
	bh=lNNBqfilNDalwRsLUsQpgAa9WZH9o3YarCwOCqbWowU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AjF0/8jo0zDSNgtNGq+Zf63ZK8MQC4s8snyW85Vx5djgM081bRlHqpqU9YlhS5HDw
	 oBedSHGVwfZqBSiLf8OTjRKGs8kD/ams9MKxiW5fKKIda4lVx/HcViQdecTBlOll+J
	 e1XqeMpcaBy/6siT5NlodIUuIO7xux3RVLJB/DqomkYvYLqylJ+M5bOsNZ7h8GSF8B
	 qmgwVaTEYl98uS+W3WeyW7+02FpcPU4z0YXEf0UY8sCInkzA2s7/s+hPXaUwaH9+jJ
	 vXGxM+tczF0Wjn6fv5d8QguhydySDzn4pqGLV8fTcU/wyx8xIPzh24AzXrsR738mIP
	 ulEEyxwdyD6dA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4BAEB3930C38;
	Thu, 21 May 2026 02:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: devmem: reject dma-buf bind with
 non-page-aligned
 size or SG length
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932941389.3832404.9587362354062605317.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 02:10:13 +0000
References: <20260519203530.66310-1-devnexen@gmail.com>
In-Reply-To: <20260519203530.66310-1-devnexen@gmail.com>
To: David CARLIER <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 sdf@fomichev.me, sdf.kernel@gmail.com, kaiyuanz@google.com,
 almasrymina@google.com, bobbyeshleman@gmail.com, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253425-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 74A6159DF51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 21:35:30 +0100 you wrote:
> net_devmem_bind_dmabuf() trusts dmabuf->size and sg_dma_len() to be
> PAGE_SIZE multiples without checking:
> 
>   - tx_vec is sized dmabuf->size / PAGE_SIZE, and
>     net_devmem_get_niov_at() only bounds-checks virt_addr < dmabuf->size
>     before indexing tx_vec[virt_addr / PAGE_SIZE]. With size =
>     N*PAGE_SIZE + r (1 <= r < PAGE_SIZE), sendmsg() at iov_base =
>     N*PAGE_SIZE passes the bound check and reads tx_vec[N] -- one past.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: devmem: reject dma-buf bind with non-page-aligned size or SG length
    https://git.kernel.org/netdev/net/c/4eb82ba54342

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



