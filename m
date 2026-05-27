Return-Path: <stable+bounces-254466-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLAiH9dUFmpklQcAu9opvQ
	(envelope-from <stable+bounces-254466-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 04:20:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E03D35DE834
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 04:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D03BF303433F
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 02:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EA034DCE0;
	Wed, 27 May 2026 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abVSygFU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFE62F28EA;
	Wed, 27 May 2026 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779848401; cv=none; b=jIkdrNxzZ4eluHdCSKs0Qo0p5G19xnmCPOyYrdLNulcHgg3wROBXJsT+pgieVkycaiUsLEZJKf+t8f+uLWdyUtmEES1qyBwnFTiGa3j1tZc8bFaUynrNvHuBzULZzKFUYItNM9QNood6waE473PKNPivijMn9ETDxwQdp65qOqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779848401; c=relaxed/simple;
	bh=O3limjRBY5q96DMlVGKM6GbH7ogHGcKk0zCFYiZqHqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ckREgpc4YquTG5HzJMTMKRVmh9cNTGXO6ywh2Iet2hOELaowOgBnOGRzgLAsMf2OJpCTgexvVB8W2eVXUv8BHS9cD4RvRmDwDzYc5LqqMx7C5L44GTACyHPLcA+1p4D1LLC/VSK0vcjeiYSrnuyZAtnzM+ZAPQLu1SEYS26bso8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abVSygFU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E775E1F000E9;
	Wed, 27 May 2026 02:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779848400;
	bh=MOU/BOrYyullkDI/xmYTF01nrxsq/IqQxkaeGPZJFWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=abVSygFU97oqVS6AqAr+4R3/QMORWn1hlRSnc80ZXUcX14efHN++FaGZ8HQ2PySfK
	 jjx6uuDhSAUxel3nS7eXHz3+8gVZVz7nVymxj8wXuW1+RG2m+nvw52b7Dh6sON62DR
	 +EGYQQKcE4f9Cj+h9JUm93JW2eF4LsNRBKRTJyS5LMnrT9aDOAa9aDtOrR7KYV9ZHH
	 RYPYx/fKmmYNVR3wyfTtTsS+eY5+A4ouQY1m1uR2mishH5xKsqd6af5dRjTyxjs2E2
	 0qS8VH++XlTteKgHu34WsMD/z8m0OAX7fp29UOnq4j4C/ui4kXsdWhIT+0+JbEML79
	 p3jUluNDOleNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0DA8380CEED;
	Wed, 27 May 2026 02:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: thunderx: fix PTP device ref leak in nicvf_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984840564.4052990.7679584037769578328.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 02:20:05 +0000
References: <20260525082611.61817-1-lihaoxiang@isrc.iscas.ac.cn>
In-Reply-To: <20260525082611.61817-1-lihaoxiang@isrc.iscas.ac.cn>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, pombredanne@nexb.com, aleksey.makarov@cavium.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254466-lists,stable=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nexb.com,cavium.com,lists.infradead.org,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email]
X-Rspamd-Queue-Id: E03D35DE834
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 May 2026 16:26:11 +0800 you wrote:
> cavium_ptp_get() acquires a reference to the PTP PCI device
> through pci_get_device(). If any initialization step fails
> after cavium_ptp_get(), the PTP PCI device reference is leaked.
> Add a common error path to release the PTP reference before
> returning from probe failures.
> 
> Fixes: 4a8755096466 ("net: thunderx: add timestamping support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> 
> [...]

Here is the summary with links:
  - net: thunderx: fix PTP device ref leak in nicvf_probe()
    https://git.kernel.org/netdev/net-next/c/2bcf59eefb9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



