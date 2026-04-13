Return-Path: <stable+bounces-237626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gASRIVM03Wl9agkAu9opvQ
	(envelope-from <stable+bounces-237626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:22:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4753F1F04
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1ADD303AB65
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F951D5151;
	Mon, 13 Apr 2026 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ug4h3S7L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF0176FB1;
	Mon, 13 Apr 2026 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104434; cv=none; b=RwsTRliXBbQ+D3b3Dnt0gJ0EEtRwGM9ijyZJq2f5Xw96xH3vhzsWR10y6bL2NiBl8v41uBtHb8+sKVyn5hpnjwVaTWiKagpVvYlFy1eURFPviGzciB1Gf0TOJAg+gorpI7x52Blhx0mjef+eUhBCSW4RbhfMjmiHzOp1azMW0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104434; c=relaxed/simple;
	bh=FR9o3TgbcNBoW0c3K7lYDfILx+dcA2kt9Vi76wMXoes=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lqZtQ3xR//Xn3gOE4z44wXrC/Kl7N/gpG9IX+0TudYt7MKlye7Y672k89+QSV8xJ6/OAGOtncvzEVbzoS/ojY97Yxdm3gL0UidTt4ZfZd5PIVsHrM68Q5A7L+bBy8lHZWjDdOVuVMqoI5l5xdm1CGNmiMvdyOxUiFvShP1l3US0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ug4h3S7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C56C2BCAF;
	Mon, 13 Apr 2026 18:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776104434;
	bh=FR9o3TgbcNBoW0c3K7lYDfILx+dcA2kt9Vi76wMXoes=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ug4h3S7L1AalR2sgVjeW5MAUz1YqUB6dU15OqfJmvseSG5RzWnzhI35CpEO7wG31O
	 x55eyQpoZ8Y1SRnfxCCdKKWK7tDswctyb57gNVHpHdTXr1IWSf9ymJzIMselvmVpv5
	 f12RWl1QfOvHXLEqBY/0fGUFElSefjYHBAOQKDBGxILDk1rHnSvbZv6cmjcoUAoY11
	 I43WP6in/KNij+v+IXlCyC9pffKMTV3+SNIHAjrnVP44XJa3rdlho1StcXyOXNUIRn
	 B/0/NkMGfesr535Ac61A94tJbstBbuwXhosdQKdayHcO5O5PpTvqa2vhZ3ZiNYSq0r
	 lJSiejESf2vxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E70380A954;
	Mon, 13 Apr 2026 18:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: hci_conn: fix potential UAF in
 create_big_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177610440530.483249.14737236012912824643.git-patchwork-notify@kernel.org>
Date: Mon, 13 Apr 2026 18:20:05 +0000
References: <20260412202916.196282-1-devnexen@gmail.com>
In-Reply-To: <20260412202916.196282-1-devnexen@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, pav@iki.fi,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, luiz.von.dentz@intel.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,iki.fi,vger.kernel.org,intel.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237626-lists,stable=lfdr.de,bluetooth];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF4753F1F04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 12 Apr 2026 21:29:16 +0100 you wrote:
> Add hci_conn_valid() check in create_big_sync() to detect stale
> connections before proceeding with BIG creation. Handle the
> resulting -ECANCELED in create_big_complete() and re-validate the
> connection under hci_dev_lock() before dereferencing, matching the
> pattern used by create_le_conn_complete() and create_pa_complete().
> 
> Keep the hci_conn object alive across the async boundary by taking
> a reference via hci_conn_get() when queueing create_big_sync(), and
> dropping it in the completion callback. The refcount and the lock
> are complementary: the refcount keeps the object allocated, while
> hci_dev_lock() serializes hci_conn_hash_del()'s list_del_rcu() on
> hdev->conn_hash, as required by hci_conn_del().
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: hci_conn: fix potential UAF in create_big_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/d55d107b6fa6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



