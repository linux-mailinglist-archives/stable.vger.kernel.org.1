Return-Path: <stable+bounces-267772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8qY4KaJqOWoMsQcAu9opvQ
	(envelope-from <stable+bounces-267772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 19:02:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 000AD6B15B1
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 19:02:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LKTsEG4w;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267772-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267772-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99C15305265A
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DA633F584;
	Mon, 22 Jun 2026 17:00:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D533F37A;
	Mon, 22 Jun 2026 17:00:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147637; cv=none; b=scxAsGSvDjuaRmd3lHiM0wRJKU+DGgmjtiZoGYTtwpbor/7Vkp6ZTSgkYpMN0Jd4vww/Xq2i3mkF2lgYKGrXLydkzBboHKTRBrZ9Eum9kS9NtvZWZotiF2aGOzJoSOkLzxfmDOyUtSklY3Ykr7HgX/BF89SvxEETvMLQJWNdeyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147637; c=relaxed/simple;
	bh=Y76B94b9hHBXWi8gLSdiewR8v6h211PzyMLJK8QtisY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W2B0twuxIQOXRqYX7C888oT0s/MoGySLGIHCXm/93YLX0jPDKyc1oYXod4kFyQA9djyyyTkzB8SZtOpf+4SCJOK8MZJiVyCUpnNdMgqs/H7quyPqet2TaGdN/Pj9ZDynmCUriPYz9LAPkTx3/X4WPhK8g73xBOMLToxGx3zlW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKTsEG4w; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863A51F00A3D;
	Mon, 22 Jun 2026 17:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147636;
	bh=bnq2SHOZ+c/0iE/Ysp2xBQWEWnq5JGbiFHR+KRgrnKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LKTsEG4w7WOWcgatbdp8yLdVULzs8Es3PIDfM8avQhaWTrUO2DDueEtf0WPxtFDpv
	 ynBAQCT4BxshVRj/ll3Woz67xGRHXZMtuh9e0nT2mlu4VE7HHn2Vz9XsfN51665rfO
	 2HN6L5RckpOrprMlA10EOyXewtGddr2dQvirkpFwKeUSTI0WQO/nQGyAq6BVrz2JET
	 VpQyl660RaSL2119ZPj4yeXB9ImEGTNJFe8Mn8aJJhMojpUQZ4A/7JL8YbXyb82d+W
	 eoXxCe/AVptB8kKzHTJApw11Rrm5YorvJvl9iJ7L4bIrp6BQrYDrMaR5cYwkqYCWoL
	 q8UOHwcduM/Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A523930917;
	Mon, 22 Jun 2026 17:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: cancel pending_rx_work before taking
 conn->lock
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178214762700.1322955.1313476336537592947.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 17:00:27 +0000
References: <20260617153613.1139031-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260617153613.1139031-1-runyu.xiao@seu.edu.cn>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 jtt@codenomicon.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,codenomicon.com,vger.kernel.org,seu.edu.cn];
	TAGGED_FROM(0.00)[bounces-267772-lists,stable=lfdr.de,bluetooth];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:marcel@holtmann.org,m:johan.hedberg@gmail.com,m:luiz.dentz@gmail.com,m:jtt@codenomicon.com,m:linux-bluetooth@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,m:johanhedberg@gmail.com,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 000AD6B15B1

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 17 Jun 2026 23:36:13 +0800 you wrote:
> l2cap_conn_del() takes conn->lock and then calls cancel_work_sync() for
> pending_rx_work.  process_pending_rx() takes the same mutex, so teardown
> can deadlock against the worker it is flushing.
> 
> This issue was found by our static analysis tool and then manually
> reviewed against the current tree.
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: cancel pending_rx_work before taking conn->lock
    https://git.kernel.org/bluetooth/bluetooth-next/c/cfa697b22dad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



