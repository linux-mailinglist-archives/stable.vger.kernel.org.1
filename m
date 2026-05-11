Return-Path: <stable+bounces-245291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOyhE3cFAmpEnQEAu9opvQ
	(envelope-from <stable+bounces-245291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:36:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4B35124B4
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2B72305F785
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5DD43CEDF;
	Mon, 11 May 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtsWHop0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3C943CECA;
	Mon, 11 May 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517057; cv=none; b=qrCLZpTqKQS5XjJ0ILLH4qaaLs37CsI49O0tpXr+Az3FgOpAxy/iiylZEdw+evI6nTT6xojD10291rBKcYDeaLPMHeVRllPLqUzm121aXaF6z5N/NQYK7Y5/5iL77PKzpB3QlYshCCfN+w7P2psASvIQUcinE7y8t7dPlKfWOC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517057; c=relaxed/simple;
	bh=TU8kdulPflsf04KhGhCSZ/o25soe3K9BuV8q+p9DzDE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a5371RdO0Hvc7hRysXw+8DNhi8z/XzXHVyzsVlBJWXAwz/K2WCrVzAB8I+rDU+tAN2wLfU5tmr3IXrdjFVRGZr9D2vDpLIFcCrxg3REQ4OYWFysHm9o/2R5Wpj+vIFlgIF7t+Lzxoqo3z2cU/qFqvdE+COyfvBprBaoHhtQ8YaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtsWHop0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4FFC2BCC9;
	Mon, 11 May 2026 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778517057;
	bh=TU8kdulPflsf04KhGhCSZ/o25soe3K9BuV8q+p9DzDE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JtsWHop0IwdhQEhNFeyqiAfH2nutm8Cl7quAqaTydRi1PK4tQ8ikHHKb/41RR7Pcz
	 MTb2VpPVxlaynQcIm3klbQ/r1Nim/W3VMe7unXRkDmY5ei/QaVpkqddYtgx8SHV02u
	 C7sebkvyXwFowuyZNS2t+QFYPic7I1VP1CMrcoIKb797HVlqUsf/5EZqevxHR/IRkP
	 W9tFMivTUHg7QEhR2QEJLo/juV8FzhyKiMgFwEhkJdoO0QZfiBnKDzIPlEGMGPYLX+
	 M+ycx6edJ9X/zkvGNzzD0kh0j4KscBZ61BGcoCaA5vZU1gTnY0X8R/O33yPWQiGSx9
	 w3BQtVTtFc+Ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0973930781;
	Mon, 11 May 2026 16:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: ecred_reconfigure: send packed pdu,
 not stack pointer
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177851700405.2324731.8694479011940333354.git-patchwork-notify@kernel.org>
Date: Mon, 11 May 2026 16:30:04 +0000
References: <20260511122641.437434-1-michael.bommarito@gmail.com>
In-Reply-To: <20260511122641.437434-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, gustavoars@kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: DD4B35124B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,vger.kernel.org,kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245291-lists,stable=lfdr.de,bluetooth];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 May 2026 08:26:41 -0400 you wrote:
> Commit 1c08108f3014 ("Bluetooth: L2CAP: Avoid -Wflex-array-member-not-at-end
> warnings") converted the on-stack request PDU in l2cap_ecred_reconfigure()
> from an explicit packed struct to DEFINE_RAW_FLEX(), but did not adjust the
> size and source-pointer arguments to l2cap_send_cmd():
> 
>   -    struct {
>   -            struct l2cap_ecred_reconf_req req;
>   -            __le16 scid;
>   -    } pdu;
>   +    DEFINE_RAW_FLEX(struct l2cap_ecred_reconf_req, pdu, scid, 1);
>        ...
>        l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_RECONF_REQ,
>                       sizeof(pdu), &pdu);
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: ecred_reconfigure: send packed pdu, not stack pointer
    https://git.kernel.org/bluetooth/bluetooth-next/c/82b794a4b4df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



