Return-Path: <stable+bounces-267771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cfPlIYRqOWr9sAcAu9opvQ
	(envelope-from <stable+bounces-267771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 19:01:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8256B15A5
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 19:01:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WHCmZJm8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267771-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267771-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1616D304456B
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 17:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF72933F584;
	Mon, 22 Jun 2026 17:00:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AB433BBD7;
	Mon, 22 Jun 2026 17:00:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147636; cv=none; b=TulyItielkWLXrl5qSosozndh+jqd3zeqcFif9Dy5nt8qbreD8bMcWoJnjggwvu4yGFVY0SZBoP3O/U34af6c1tGc106wPlNdJdTFprPVta+VUQ9ukCDwwLIgmw7P4qugkqHI7RftLdzR/P3Ne5kSjmHxKRD0irBDjf3E1THqWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147636; c=relaxed/simple;
	bh=uawZCU4dKRwJpV8SxDfmjaHFYaTJIM5AyoQPv1Ujphc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QkbJIC9CqvZ6CJi4HQUoOrJ2bxxbh+5zxhyh0odLfE5qGtMK0r1pdVrZ6X4/IxNMe4mwjqDo51upSQuQt4psoaaMRoz28p5fJ8IEAy70j/9A7rm8B3Tz09pXy/KC2AG3o7IId6u4ALJ3pdWJIMN+zIZBFVBfAyNEdG/UHHpVLNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHCmZJm8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0E21F000E9;
	Mon, 22 Jun 2026 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147635;
	bh=71dBz+bpiTgHoc2XULs4mRyX7MFma4xtldFQ8t9msFw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WHCmZJm8kTypjIqQUnliHC4pvyDknYZxznA17Sh6Oi3JrlOg6HsJijlEBNEIwrQJv
	 aebWqM6eKtk6apNSuZ5r1OCivaNP+IkAQiPzrr5O2SbCW7UV8d6ErpYm1Fe84e3vTA
	 +oaiImeflI7mOqdusEj4tZXYr5xZSv4mmphRDywcPsV4JO0HUI1v4vBg1ry1BmpyTv
	 RnDCgxqM24yqA47194c58pj3ryLPjwIEr69hN7fAwjkGPUqBuVk/1l6bLAW10P+7dm
	 PwRtqLMqNY1zkOIPbEkW9jSyo7tvwMwzvfni2JcxchbM00oSUh8rc4f9klp7KLGtdF
	 x6SVGZ14LwE4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09E73930917;
	Mon, 22 Jun 2026 17:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: ISO: avoid NULL deref of conn in
 iso_conn_big_sync()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178214762553.1322955.9611658441298431960.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 17:00:25 +0000
References: <20260621162305.219763-1-meatuni001@gmail.com>
In-Reply-To: <20260621162305.219763-1-meatuni001@gmail.com>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcel@holtmann.org, luiz.dentz@gmail.com, iulia.tanasescu@nxp.com,
 stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com,nxp.com];
	TAGGED_FROM(0.00)[bounces-267771-lists,stable=lfdr.de,bluetooth];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:meatuni001@gmail.com,m:linux-bluetooth@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:iulia.tanasescu@nxp.com,m:stable@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD8256B15A5

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 21 Jun 2026 21:23:05 +0500 you wrote:
> iso_conn_big_sync() drops the socket lock to call hci_get_route() and
> then re-acquires it, but dereferences iso_pi(sk)->conn->hcon afterwards
> without re-checking that conn is still valid.
> 
> While the lock is dropped, the connection can be torn down under the
> same socket lock: iso_disconn_cfm() -> iso_conn_del() -> iso_chan_del()
> sets iso_pi(sk)->conn to NULL (and the broadcast teardown path can also
> clear conn->hcon on its own). When iso_conn_big_sync() re-acquires the
> lock and reads conn->hcon, conn may be NULL, causing a NULL pointer
> dereference (hcon is the first member of struct iso_conn).
> 
> [...]

Here is the summary with links:
  - Bluetooth: ISO: avoid NULL deref of conn in iso_conn_big_sync()
    https://git.kernel.org/bluetooth/bluetooth-next/c/a0ac2b200be1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



