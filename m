Return-Path: <stable+bounces-220039-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBlmFpxjomnI2gQAu9opvQ
	(envelope-from <stable+bounces-220039-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 04:40:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4A31C02AA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 04:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FADD306F3A8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 03:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FD92D592C;
	Sat, 28 Feb 2026 03:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGW0ijx9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0158B2D060B;
	Sat, 28 Feb 2026 03:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772250005; cv=none; b=XrmF7ZrFhbws1LvsQ+PxTqm+ggcXYOv/x/0oEakwVHa7tBFo+ZDkc3NGcza59GNDXF60nbOEzDnF2femv1sFNTlTXKHvGYcxQq1RSKp4at4i45tYTU8U3wogOEmRNJ7gSmZhpAyJ+ULqOFmJnIdfsmdcx6mfNuI6fssDCOSFxfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772250005; c=relaxed/simple;
	bh=4aLjb6jgnUvfcZ/EhtNfS22295VXzNNhfpVc/50PAoA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C4kS0v3sVjkN+AiJU+lsng201s00k/EXZ3e5lM451fdWplqRXaUHaVOUTpp/llxgrWmQO9VYp0X6bo/PuIKVt2jtZtb7BmPE71UWGDJBR57LkLShFjW1SxEGHlIDQGH6VZIdc2PDda9tovNDFdUWpmNKgWUPUu7+JVx47u9niso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGW0ijx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826C5C116D0;
	Sat, 28 Feb 2026 03:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772250004;
	bh=4aLjb6jgnUvfcZ/EhtNfS22295VXzNNhfpVc/50PAoA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BGW0ijx9LMfpp4UexrRVClCJUesW7ZJbi/DQpEKKmNqxX59fHklgEl0Ruv/uMhLa0
	 HNW/uK7MieP4dhEUXKm81KQJyUXCmkunzXAW2uVMtUF8biVsYE1YQZ5Zom6RYQY7I/
	 32bE4uEYPL0NPn+eqr3PctxmWbTU58ROdYEd+SCHy/YHF/X0fDoPY6mrKnV+MBvPPa
	 ZN/Mc0LeOnLN8gx0Y42HVmksawoHkv+j5mv4IoBpxNI4qVdtRG0EdIqm90yYDRBcWu
	 ywAJWnzM9f+yKaO6QzvRFJtlFKfVgwsQlkaMmrodCD1QfDx/gd1xjy+sOZqn/YIFxO
	 N/DNAo0ijuXMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE4339EF96C;
	Sat, 28 Feb 2026 03:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: mana: Ring doorbell at 4 CQ wraparounds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177225000804.2855218.9386044687164438073.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 03:40:08 +0000
References: <20260226192833.1050807-1-longli@microsoft.com>
In-Reply-To: <20260226192833.1050807-1-longli@microsoft.com>
To: Long Li <longli@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shradhagupta@linux.microsoft.com, ernis@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220039-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD4A31C02AA
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 11:28:33 -0800 you wrote:
> MANA hardware requires at least one doorbell ring every 8 wraparounds
> of the CQ. The driver rings the doorbell as a form of flow control to
> inform hardware that CQEs have been consumed.
> 
> The NAPI poll functions mana_poll_tx_cq() and mana_poll_rx_cq() can
> poll up to CQE_POLLING_BUFFER (512) completions per call. If the CQ
> has fewer than 512 entries, a single poll call can process more than
> 4 wraparounds without ringing the doorbell. The doorbell threshold
> check also uses ">" instead of ">=", delaying the ring by one extra
> CQE beyond 4 wraparounds. Combined, these issues can cause the driver
> to exceed the 8-wraparound hardware limit, leading to missed
> completions and stalled queues.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mana: Ring doorbell at 4 CQ wraparounds
    https://git.kernel.org/netdev/net/c/dabffd08545f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



