Return-Path: <stable+bounces-272475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UVhbA7o3TWoIxAEAu9opvQ
	(envelope-from <stable+bounces-272475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 19:30:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 501A771E50F
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 19:30:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LMm9uCmj;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272475-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272475-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A7263019FE5
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 17:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8D3352033;
	Tue,  7 Jul 2026 17:30:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909BF35898;
	Tue,  7 Jul 2026 17:30:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783445427; cv=none; b=DtsDfYvu4vM5z3in3RE65ah1SWSSZFuNnYwj9wfJcjCsQaTJVT7OmcucV/S4aEoPm+4ua5Jwprz2wnbPXZVjiNkgecDLBwexNJekmRGw3Lvi8nErUdmhv5slMIOVk3YPe0XUL3i8ha90NqfMGI2oxuo7BwXXrwTagwmgTOMqQuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783445427; c=relaxed/simple;
	bh=pjSbzPfqWWlibgOXumm1uZESRU4gCOOGC/F/fhF+FVw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g8Zq7Y5ddBVtM+RFi4rJP1V/AJf7XeKBjsan218e6Sd+7Zt0Oh4z2wd3FfDFWZ8e/jmRJg2bB4765+eOzCIZwPxqJRcuWU0NjHu5veoyQRazXEoR0f0YaDu+kUnYmlx2R4fmeJmINv5MEjXPr2OBm1wXMJRWCbxJTdUg8ZVZTr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMm9uCmj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2E81F000E9;
	Tue,  7 Jul 2026 17:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783445426;
	bh=yTxPIBxBTCojvF3ySohbMmEX4VHb0ZBBPu2wZmzCFfA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LMm9uCmjYifAUG+T0OqOSTZlaKFywSs+ZL1sbZvfOgv0qtybBlAxyjk2QNfp7qvjX
	 yr4TYlapO24xpnQmtIrhz4DiuWudzVZ3Xgie4fU0/tDvFOSvQ2SVHWaWRnFr8k8/wJ
	 TX0X89eptkQYBMj4Hr1PDhandJOSNH4cBBqneHbJQKFlTkCQIN+YEUQ6wgHDAIvIS0
	 Y7TZGQgnaaFNRiqny6m+o+BUKthaJ7v+qjY2gzVE84gtOUrwesAKc8u03RexhrCwUF
	 FcgRezRWl+PBb6sDb2/M4pxHrUNar8sdidwm5BfTllhtCz3eRzPoftqMd87v583IK7
	 i1qVvP4jzmoBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568D039253FD;
	Tue,  7 Jul 2026 17:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add ASUS USB-BT540 and USB-BT600 for
 Realtek 8761CU
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178344540614.2101608.6818912304609485751.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 17:30:06 +0000
References: <20260704231312.340274-1-cito@online.de>
In-Reply-To: <20260704231312.340274-1-cito@online.de>
To: None <cito@online.de>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-272475-lists,stable=lfdr.de,bluetooth];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cito@online.de,m:linux-bluetooth@vger.kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 501A771E50F

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  5 Jul 2026 01:13:12 +0200 you wrote:
> From: Christoph Zwerschke <cito@online.de>
> 
> Add the vendor/product IDs (0x0b05, 0x1bef) and (0x0b05, 0x1d70) to the
> usb_device_id table for the Realtek RTL8761CU-based ASUS USB-BT540 and
> USB-BT600 adapters. Both bind via the generic Bluetooth class today, so
> BTUSB_REALTEK is never set and the rtl8761cu firmware is not loaded,
> leaving the controller non-functional. With the entries the driver loads
> rtl_bt/rtl8761cu_fw.bin (already shipped by linux-firmware) and the
> adapters work (tested: A2DP and ASHA).
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add ASUS USB-BT540 and USB-BT600 for Realtek 8761CU
    (no matching commit)
  - [v2,2/2] Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU
    https://git.kernel.org/bluetooth/bluetooth-next/c/3928fa44107d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



