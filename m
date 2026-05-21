Return-Path: <stable+bounces-253607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCxuA8c+D2pzIQYAu9opvQ
	(envelope-from <stable+bounces-253607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:20:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9585AA16E
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E98883432CAD
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED81F37104D;
	Thu, 21 May 2026 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8YilHv5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8836F8F5;
	Thu, 21 May 2026 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377415; cv=none; b=EcL1+gYv15bT4OvlIMGeKdK6e8KVXMp0Xx9XA+pq1vqSSCADgeFFFhSnB04LYx7vdkAZJqZmZwzzh7Kxew/rRfi62Wvhz4NBWvWERKx0TCIzzPeARRwgXI6EaGt38ELWACj/2/rMdrdVTh/xP7T5EcWNw7cmD/YzyVVA7+50lSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377415; c=relaxed/simple;
	bh=Xt1zZq3r3Y+3w9pyyBVWNbEaBEfqUzI76HeylYwNr3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r8W8PRY3c1f0T1QzNDaer6QWcUk8xCvCBpPwqrKIfVYJy3GNjIuNEVmai2dU4QQqUgJiSAt6zSAZ6zJ3C/dnblkhARHkKgg96kfLPc4vOB6rkaZ30t4YvEI9g7p5N4RFJcXqc/mbNFDV2ii9ODxpZDjyj/6U7qOcrG+zMJ1wq9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8YilHv5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3D21F000E9;
	Thu, 21 May 2026 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377414;
	bh=L8ULRN7UF+uHyi87WtkpbAsGNU/0ErFYzfMwPYqF21g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A8YilHv5j9q5YrK2eYnf+mWZ0ewMnwigD9g9QN9DcXMxg5QOctVJsAiVmcotMlfIF
	 ysIvNNdAFpZ27itgFhQw8VdsAENG5+YQWKirP5FVLiHzbAObJsSmFDzWuRHYDb8dqu
	 Xm+7Vv2B8iDpNnkKwKBfble4cpM6PEP6Yl8errJRFDO4XKPkiIuc1xt+xe8RYPY32f
	 kyQWVbXwSnRs3onwlXBEnTls5qhy4Gi1j1c/1AhCRG7i9+lLer3nZCvgPY6Iduiaaz
	 U0+X/RY8WSDV7U6WviPYdJb4FLpX1PXSNpqH6vYSvkSkOns6QOZH2zAjIAhTPMwZZL
	 ++eDZVHpqbCpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A243930E02;
	Thu, 21 May 2026 15:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_conn: Fix memory leak in
 hci_le_big_terminate()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177937742413.384060.3222345140031912120.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:30:24 +0000
References: <20260521080414.44460-1-jhapavitra98@gmail.com>
In-Reply-To: <20260521080414.44460-1-jhapavitra98@gmail.com>
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 marcel@holtmann.org, johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, yang.li@amlogic.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,holtmann.org,amlogic.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253607-lists,stable=lfdr.de,bluetooth];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1D9585AA16E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 21 May 2026 04:04:14 -0400 you wrote:
> hci_le_big_terminate() allocates iso_list_data via kzalloc_obj but
> returns 0 without freeing it when neither pa_sync_term nor big_sync_term
> flags are set after evaluating the PA and BIG sync connection state.
> 
> This early-return path was introduced when hci_le_big_terminate() was
> refactored to take struct hci_conn instead of raw u8 parameters, adding
> PA/BIG flag evaluation logic. The existing kfree() on hci_cmd_sync_queue
> failure does not cover this path.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_conn: Fix memory leak in hci_le_big_terminate()
    https://git.kernel.org/bluetooth/bluetooth-next/c/6dbf781d0885

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



