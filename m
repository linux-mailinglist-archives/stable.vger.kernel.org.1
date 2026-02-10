Return-Path: <stable+bounces-215668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PuZB74+i2mfRwAAu9opvQ
	(envelope-from <stable+bounces-215668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 15:20:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8994B11BD2E
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 15:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A734F30488CB
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 14:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC59366812;
	Tue, 10 Feb 2026 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqPjK+1w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCDB372B25;
	Tue, 10 Feb 2026 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770733212; cv=none; b=epSHWPFbeGFdzH4zCG/J4TKAmAISjJl3quX3uiplzJRQmIhOPqeUGFjkzyVinZVVvDSYM/EEWbkSJ1untbRjDheilF4l4jJuxIp7Hlj6CeknwMydzxLJBoP5YZwO+YBwHoQRfPiamDavMSA0Lmd1nEJMdCfRzlCKxKEi330rqRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770733212; c=relaxed/simple;
	bh=vlZs7oTA2pLGDTb3L/96Ms6dAA5RBCNGUkJNHKvN2AU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bJV+MMCrjc1BzZiof9BvA6dmirBFnNFy5gOJkHRvNKeG/k/iGh5OeeP+zt0HH/UEumyzFi0O0lsZzY7sUiGaYQmZPXkGvpBAv0JGc+VOGh/kkdJ69gg50UpWqfONprKCcn6hzwxvQu8s/ki5rq0puN6wz0Mfalh4AxNR3pQqIpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqPjK+1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B8FC16AAE;
	Tue, 10 Feb 2026 14:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770733212;
	bh=vlZs7oTA2pLGDTb3L/96Ms6dAA5RBCNGUkJNHKvN2AU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kqPjK+1wxipBGRPMwkgFMleC9meQRebQ8ydmVNEQxMW2UpPY0ejOXUOPlp0Iu9lm3
	 dN/1XzyDbBHQO7p7p90jA6NdWQtvknDo4Rxu/GRogSVCQCGgDnrFKQxEsPoUeuldZ+
	 FMFY9sB6DuXFX8U0kF3B/igpgkWr0DKh53uhUEETb4SExfWWQEU6MFiFWpCEeeVFS8
	 +pg11/A2o/hjEULnuwgn9nHL6pIa1ziEg8JrnC1DR/woDYzZowFzg5gD9/Avw9EXVl
	 MvXmXj3sPPO1MK/1YlUzYruKZ8JsRS00b57ezj1NN4Ab8u3SC50D247zqaKrCo0/qr
	 //nyXaZwWCbDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B22639D267E;
	Tue, 10 Feb 2026 14:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: marvell: skge: remove incorrect
 conflicting
 PCI ID
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177073320757.3529986.17946751621696975740.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 14:20:07 +0000
References: <20260206071724.15268-1-enelsonmoore@gmail.com>
In-Reply-To: <20260206071724.15268-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, mlindner@marvell.com,
 stephen@networkplumber.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, tglx@kernel.org,
 mingo@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215668-lists,stable=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8994B11BD2E
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  5 Feb 2026 23:17:14 -0800 you wrote:
> The ID 1186:4302 is matched by both r8169 and skge. The same device ID
> should not be in more than one driver, because in that case, which
> driver is used is unpredictable. I downloaded the latest drivers for
> all hardware revisions of the D-Link DGE-530T from D-Link's website,
> and the only drivers which contain this ID are Realtek drivers.
> Therefore, remove this device ID from skge.
> 
> [...]

Here is the summary with links:
  - net: ethernet: marvell: skge: remove incorrect conflicting PCI ID
    https://git.kernel.org/netdev/net/c/d01103fdcb87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



