Return-Path: <stable+bounces-270044-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kuIaC3IoRGovpwoAu9opvQ
	(envelope-from <stable+bounces-270044-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 22:34:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D006E7DEB
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 22:34:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UazHzzYo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270044-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270044-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54561304F402
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 20:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2232547CC6F;
	Tue, 30 Jun 2026 20:32:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70C647CC87;
	Tue, 30 Jun 2026 20:32:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851576; cv=none; b=aAl5uVjHsy2gbj3v60Irhu9jNL1PvWSbwaORQs7sSsIpHKcBNt8NDeJJj8vau5RdLKKQkH9nsUTdG6f/9DpLehQjH5TDI4XCzPTmWNsXXdmyYqe87v57l89qU2Tg/3rmJ6/qpUL7mi8UYe3ywGL+UIF8IV3RXKxzBcG22O1bbnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851576; c=relaxed/simple;
	bh=ByIBVyBM03OfrN1ZFbcXC+RBCM3Y2iRMY7d1jJmRDJ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YwT8p0a+erht4ivjJUM571AofHtks8DIJoOZQRw0JQJhE8avuhVT3/KNAyiyXjHAgDzgZozbHlx8aQycSEhnj8PDZK24Cup78eOSqdb5WDP0d9KRqpnQ2fT3fFUXFSmp2wLOnAfA4ksU9tc8RIx5o7DJPFXLSeg2X/e47aNMcM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UazHzzYo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6DF1F000E9;
	Tue, 30 Jun 2026 20:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782851575;
	bh=m+Mn34FwdBlEkYd6k+CFYNtnPQQvOr2OMuiUX/rvhcU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UazHzzYodNRxpLNL/ozozDs2HcgajjM7D7qXtUzkc5CjvxtbFfFi7Gk4JPUesYJ9y
	 wB2xES4/uFE4A5XPNdwpWdLS2tGgxBsjSkyBsI1fmoRWnGqlZi70EqA9ucOzMLqNZF
	 WYL0GTVLdF3NOYpT5jplFO4cILGg7ePKBlNawxxJ2LvUdvF4lNKYVI6d79TYpXeU45
	 bACvpyvQMqMvdWIBXdI7SUM3V1DTtnKofQSzf/uSH2jfN6/GR/8kYongAVouQjTGx1
	 S3zV+Gt/MpFfXqXGQNyfdCTVorMvyODCvLQ4Lv+zeY4tpMAlk/JW5M5XHRyPgb9pYy
	 pX+MwDf/MrbiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A7C393A951;
	Tue, 30 Jun 2026 20:32:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: fix UAF in bt_accept_dequeue()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178285155938.267316.144055219083939907.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jun 2026 20:32:39 +0000
References: <20260628002305.22823-1-alhouseenyousef@gmail.com>
In-Reply-To: <20260628002305.22823-1-alhouseenyousef@gmail.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 safa.karakus@secunnix.com, stable@vger.kernel.org,
 syzbot+674ff7e4d7fdfd572afc@syzkaller.appspotmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,vger.kernel.org,secunnix.com,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-270044-lists,stable=lfdr.de,bluetooth];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:linux-bluetooth@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:safa.karakus@secunnix.com,m:stable@vger.kernel.org,m:syzbot+674ff7e4d7fdfd572afc@syzkaller.appspotmail.com,m:luizdentz@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[stable,674ff7e4d7fdfd572afc];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84D006E7DEB

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 28 Jun 2026 02:23:05 +0200 you wrote:
> bt_accept_get() takes a temporary reference before dropping the accept
> queue lock. bt_accept_dequeue() currently drops that reference before
> bt_accept_unlink(), leaving only the queue reference.
> 
> bt_accept_unlink() drops the queue reference. The subsequent
> sock_hold() therefore accesses freed memory if it was the final
> reference, as observed by KASAN during listening L2CAP socket cleanup.
> 
> [...]

Here is the summary with links:
  - Bluetooth: fix UAF in bt_accept_dequeue()
    https://git.kernel.org/bluetooth/bluetooth-next/c/a8c481ee3819

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



