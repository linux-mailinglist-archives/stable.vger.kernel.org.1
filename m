Return-Path: <stable+bounces-253376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIOUIecoDmpq6gUAu9opvQ
	(envelope-from <stable+bounces-253376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:34:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA1359B084
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92BD0314F52E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E143603D9;
	Wed, 20 May 2026 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8x019ju"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F20835AC2F;
	Wed, 20 May 2026 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307195; cv=none; b=m161CcIx1urOBg2CgwrFv4ZdpyKwhr0ty5gg21hxedzIAC/DoHBhjFkObcU8dVfIYNRwm7vUA7QXdRwVfk4mhFvrVFELzeh4NsCX+ZNi4Xsms03dl5in/6k/ykp+5FvdKGEV+C8Nd+oEtNiWJzKQ4uq/fL9zn6aL2cLFcGJRJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307195; c=relaxed/simple;
	bh=McTrFVKX2x8KAPFybNzi1OGs/LMHJIl9Ll9yzD4YlYA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OTpSrN3nqzXYoIsTDh0NNo38wOz75pYmRtGhwtQlQOpuADjeMRxtw6ZMLL7TlWIx5ZeNeouL8wRXBEkaBeOpmP47ZYC/Y6ga1s32j6WA7XapHo/7IEThP8Tl0I8eTFgHM/49rCxif70sAsxEriuLv4xgrxwBwe1+pLXgae+vrZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8x019ju; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463E31F000E9;
	Wed, 20 May 2026 19:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779307194;
	bh=ALSwCmeG8KTZ3ou1nvJKE0JLWvzFWyHMttzZnY78424=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z8x019juOUF+3jwV68OzeKBlJtNxwdXh4H82uiM9nMEJKEVQEO4wPVojF6wRENNh6
	 wgdKk933MJS1GArir07HD9tVpyOary0l2dTx00ZdMPNBd3G5eM71a0Cf2BOHHeH+oS
	 rX0we4yzec9ZorxtDVkcY3K29vkEEabYMueXBCBWibNbD+KDPM2IWP8HCsAt1/oGY6
	 wEkHcXpEoTPRELl+DbgQpLgbiSMhrqbSwz8b6dLpF4AZg2KM0qi9IwC2Xz6b3bYhi1
	 iFT97mjzCiCaepbDDSQpVKgoDsO3w4wpvqOgIxu2O38xIz4UnmlHVvvQ+NXwKT9dVZ
	 4/Io1KbEBgcsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09323930BB0;
	Wed, 20 May 2026 20:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs
 l2cap_conn_del()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177930720449.3737015.13239327454432512997.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 20:00:04 +0000
References: <20260516181504.3076260-1-safa.karakus@secunnix.com>
In-Reply-To: <20260516181504.3076260-1-safa.karakus@secunnix.com>
To: =?utf-8?q?Safa_Karaku=C5=9F_=3Csafa=2Ekarakus=40secunnix=2Ecom=3E?=@codeaurora.org
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 marcel@holtmann.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,holtmann.org];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	NEURAL_SPAM(0.00)[0.950];
	TAGGED_FROM(0.00)[bounces-253376-lists,stable=lfdr.de,bluetooth];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 8EA1359B084
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 16 May 2026 21:15:04 +0300 you wrote:
> bt_accept_dequeue() unlinks a not-yet-accepted child from the parent
> accept queue and release_sock()s it before returning, so the returned
> sk has no caller reference and is unlocked.
> 
> l2cap_sock_cleanup_listen() walks these children on listening-socket
> close.  A concurrent HCI disconnect drives hci_rx_work ->
> l2cap_conn_del() which runs l2cap_chan_del() + l2cap_sock_kill() and
> frees the child sk and its l2cap_chan; cleanup_listen() then uses both:
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()
    https://git.kernel.org/bluetooth/bluetooth-next/c/0b580042a1a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



