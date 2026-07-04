Return-Path: <stable+bounces-271899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s/otHudqSGpVqAAAu9opvQ
	(envelope-from <stable+bounces-271899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:07:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A061706736
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:07:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UniFhK3a;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271899-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-271899-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D06D304A66A
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 02:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9535B374A0A;
	Sat,  4 Jul 2026 02:05:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6081237268A;
	Sat,  4 Jul 2026 02:05:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130745; cv=none; b=sEJu6/SCJG5o5wN28auRPPozAS1dIl2Wytdzo6hWnqQkpSmzMC2zszPWNLl/iJTjbU9FAGUPWAKBo+mnBQ749oD8Fb6aM1MTRwJkNTIMYiiuVVb9S2h1lGLW9AKK+JLPfm584BD/BQMvKGyX6Rrm3HjAeB3uUqAuLPTvGl1QUbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130745; c=relaxed/simple;
	bh=Gh7zPtnoU6n2C2fISk3f0t2N8UYzRiVrBf/AWbw9cFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YzAnJgCJjnnjlj0a6BNjDOxv1vHhWCkdjJHFh2XtyETLXW2X8g9FBhzZeP9eHg5oVxiccbaftorAl4wta3MgsTkPf+8v+KE59oUTgQdKlUXt2NbdWqQBbmRwhv+rnSSulFzmHnLirH+trBqQE1rchS83VjxSfPaPkdI8Dnn9ns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UniFhK3a; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF9B1F000E9;
	Sat,  4 Jul 2026 02:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130744;
	bh=FuKFRC2UMqfTB32HTYGSrvKzMcxyhi40to9kRReBfSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UniFhK3azUSfHEIXglQprci6Ifz3s4z7OleDAidUoWHhd7c+FFUtkTWLgpsBEQ6g3
	 PHrQI7fu5j+4q41WsD9qizzjGSXLcqLQgqdSrUt4GNn29QvtB84CZ+Utx62OmYZY1w
	 Tdj0r7TKnXZOBkkz6p4UZobeblF6/LUnXlZTPrE3xUmIs6Glqk3j0OhXRYmQ38cRL3
	 yeKOTcRq6cKLcTiTOcgIWyDIf4/kYKC6JBSkRz0bR3aO2p92Cd5S/eigerZ02chJVx
	 o0ijzLYuAq4D+Ailg82Ln+lAwPiKYEF6czejUbI3I+mQBZAZ81YzAamLHQkAD9T6m2
	 8mTybduwHYb5A==
From: Sasha Levin <sashal@kernel.org>
To: Chris Lu <chris.lu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-mediatek <linux-mediatek@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	stable@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: btmtk: regression in 6.6.142: NULL pointer dereference in btmtk_usb_hci_wmt_sync during resume from S4
Date: Fri,  3 Jul 2026 22:05:10 -0400
Message-ID: <2026070315-stable-reply-0016@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <7ea1c4a0-d38f-413b-993b-7846b2b7debd@leemhuis.info>
References: <7ea1c4a0-d38f-413b-993b-7846b2b7debd@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271899-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chris.lu@mediatek.com,m:sean.wang@mediatek.com,m:sashal@kernel.org,m:regressions@lists.linux.dev,m:linux-mediatek@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:stable@vger.kernel.org,m:regressions@leemhuis.info,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A061706736

On Thu, Jul 03, 2026 at 08:34:04AM +0200, Thorsten Leemhuis wrote:
> Hi Chris & Sean! I noticed a report about a regression with btmtk that
> happens in 6.6.y series. This strictly speaking is the domain of the
> stable team, but maybe you want to take a look nevertheless:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=221696

Thanks for the report!

I've queued the missing part of the upstream chain for 6.6.y: 5c5e8c52e3caf
plus its follow-up fixes 67dba2c28fe0af ("Bluetooth: btmtk: Fix failed to send
func ctrl for MediaTek devices."), 099799fa9b76c5 ("Bluetooth: btmtk: Fix
wait_on_bit_timeout interruption during shutdown"), and f0c83a23fcbb42
("Bluetooth: btmtk: Fix btmtk.c undefined reference build error").

-- 
Thanks,
Sasha

