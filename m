Return-Path: <stable+bounces-263426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k1ZnDQZAMGqiQQUAu9opvQ
	(envelope-from <stable+bounces-263426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 20:10:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE7368913D
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 20:10:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Aj1WyhWk;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263426-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263426-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A74F30434EE
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 18:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C621E30567B;
	Mon, 15 Jun 2026 18:10:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D182EB5B8;
	Mon, 15 Jun 2026 18:10:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547011; cv=none; b=ahbT4mOwIfBFa1IEPh2SKdSLr2do/oI3l4txZM8s5e1PWaj2I5bGx1/6kmYmhSVYK1J+C09SJWvett2N8BThdQNjsPNII2IKjj6bR8XpAEiTW3Nfo42wf2KfLk1Fiakn86ZTuXx7BbYytYa2R1ESQoEdNEhpr6fNZbuirtFl9Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547011; c=relaxed/simple;
	bh=9bGJPAAQWrSiefUyfK2vvzRYymLRr0ggWFXKFmaNQwk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fh368z5PZj7kwJE9ggREwy/q2Xa9qk1MObAJiO43LSBqN+dXIVU0uF/BKyYRrTzo+oel5UF3sFfnP2K/dOOke3elxDIG7JxW+IZBIaL8y1CPd5NA4qOTYAeBtdO5Sgko2NKLCEYFAp8ON3nBN5cIvyyk2hBI6deUoA45ERDhkro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj1WyhWk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD441F000E9;
	Mon, 15 Jun 2026 18:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781547010;
	bh=cIN7Q2WGpJ4nSTosWIwtbS/aqJIMSj9ILTwihRVKATE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Aj1WyhWk6c1oSzbN2H4HLBtLlQlCEmfHRCIcrTLiaJjARqwGcMMyA+w5zTtyHZApf
	 mfvn+1DuwbwyqDqhTtMIjGhoB99iiUiMZgKvKLukGGOACWkSQZKFaxhwFUQBMUH+cQ
	 ZW5yzn0+zzV5gH4jhxTDZsOMHyiO0n4SyRmpituzT3DWMk9gWPIviIoSkoOzWNG6wi
	 b3DfXiO/4zwd2y3OV+q9uKk2FkpmnYt73BZL9n7GJK3OUoYTpeooOiFihVHwh0fbIk
	 s8pCMXYn9tn/pGYzF1ji2A8YAbZ5+9lIy0p1fpQtfzg9XMh0L17hXeb142ClXCMbmh
	 fBPmZMy64MuLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9396D3839A06;
	Mon, 15 Jun 2026 18:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_uart: clear HCI_UART_SENDING when
 write_work is canceled
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178154700514.231677.2643745417902047047.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 18:10:05 +0000
References: 
 <9fdead8517c36f37c0b23b7b60f590d735792cfa.1781375875.git.pav@iki.fi>
In-Reply-To: 
 <9fdead8517c36f37c0b23b7b60f590d735792cfa.1781375875.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, 25181214217@stu.xidian.edu.cn,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com,stu.xidian.edu.cn];
	TAGGED_FROM(0.00)[bounces-263426-lists,stable=lfdr.de,bluetooth];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pav@iki.fi,m:linux-bluetooth@vger.kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:25181214217@stu.xidian.edu.cn,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EE7368913D

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 13 Jun 2026 21:43:37 +0300 you wrote:
> HCI_UART_SENDING bit in tx_state means write_work is pending and blocks
> queueing it again.  Currently this bit is not cleared when canceling the
> work in hci_uart_close(), which blocks future writes when device is
> reopened later if write_work was pending.
> 
> Fix by clearing HCI_UART_SENDING when canceling the work.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_uart: clear HCI_UART_SENDING when write_work is canceled
    https://git.kernel.org/bluetooth/bluetooth-next/c/3b7686310806

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



