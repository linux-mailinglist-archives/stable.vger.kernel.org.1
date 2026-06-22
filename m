Return-Path: <stable+bounces-267770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YMKAODFqOWrHsAcAu9opvQ
	(envelope-from <stable+bounces-267770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 19:00:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB93B6B155A
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 19:00:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HdvRu6dP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267770-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-267770-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2D383004D33
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 17:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FE9314B95;
	Mon, 22 Jun 2026 17:00:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B18B1C2324;
	Mon, 22 Jun 2026 17:00:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147628; cv=none; b=nB2NdtxPttdbrYHCSB6m7v8VIrO8KxtZhsAWmdMiDebPa1gBtgxAEbuII0J7Vr58ysHuAIALCRfgTYNe38u7JJzw+DARwDF/kIUG6gFyWQ573qzoZT3fJ4RKbmxiAKhyBUrlybzXWy8BYN52+LSjgqueha2Qkt1THAnGrONCiVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147628; c=relaxed/simple;
	bh=/Knyhr98Fq8IpQmtPGLtUzLMk38zu55WoCtcmdKBx9A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=clMG9IUnE+HUAW/20hI+toGAIdxEYiAIgwlBZ0hvKDeVh1jkcBebJQi7wnF6V+XOFNwHOJR5qeBBQ520LMahoEVe2SERcUYAwt/0YsjO8vE3axt4jRrKE+AaGC2qtgKVUtxKX1hRnQQU1kz/zyzyr+0EbOVcTMdQeSngscWTAS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdvRu6dP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4401F000E9;
	Mon, 22 Jun 2026 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147627;
	bh=8M6shzMzeB9IMv7X+Tp/Jz/rAkdaaO8JY3FMUqU+6eU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HdvRu6dPg7q4HRhP0Ns5hvWk18IqV+AfRUvp+HjFCvjFQ/tW4RVxsxr/475ngmqqt
	 uqZ3HD9xd2897Pgu3zLjT9Dj3h4KtkwXYMCJ/uUxF/+n4KO3jww738fqDn8CTFXw6N
	 6L5wbCKb0IIi5Zm2KZm+QpHqgFDSyDGkS84FrD9M4tMONSW1/PeENr2vYOcZ1nCCle
	 jWdTohKBD1+bLpYETiFb94QITE5g0s38ur1Zs+EOy5c9wVK4JZMZpsZTY8u5Imjkvc
	 Rn6xhupeEFAC6YDi7T7iSYQkwhHou/fInNLxJsI82cG2iXpmcScjzva66A5td7RoPs
	 sIKaGXzaY6UTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199433930917;
	Mon, 22 Jun 2026 17:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: validate option length before reading
 conf
 opt value
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178214761761.1322955.11695819958942323526.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 17:00:17 +0000
References: <20260620195635.41765-1-meatuni001@gmail.com>
In-Reply-To: <20260620195635.41765-1-meatuni001@gmail.com>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcel@holtmann.org, luiz.dentz@gmail.com, stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267770-lists,stable=lfdr.de,bluetooth];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:meatuni001@gmail.com,m:linux-bluetooth@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:stable@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB93B6B155A

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 21 Jun 2026 00:56:35 +0500 you wrote:
> l2cap_get_conf_opt() derives the option length from the
> attacker-controlled opt->len field and immediately dereferences
> opt->val (as u8, get_unaligned_le16() or get_unaligned_le32(), or a
> raw pointer for the default case) before any caller has confirmed
> that opt->len bytes are present in the buffer. The callers
> (l2cap_parse_conf_req(), l2cap_parse_conf_rsp() and
> l2cap_conf_rfc_get()) only detect a malformed option afterwards, once
> the running length has gone negative, by which point the
> out-of-bounds read has already executed.
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: validate option length before reading conf opt value
    https://git.kernel.org/bluetooth/bluetooth-next/c/64522263b6e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



