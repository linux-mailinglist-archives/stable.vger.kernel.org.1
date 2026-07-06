Return-Path: <stable+bounces-272249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BovKLf26S2pcZQEAu9opvQ
	(envelope-from <stable+bounces-272249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 16:26:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E50711F10
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 16:26:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EkSXdDUg;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272249-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272249-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBB9631F48C9
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 14:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDBA3793BC;
	Mon,  6 Jul 2026 14:08:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19366378D76;
	Mon,  6 Jul 2026 14:08:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346912; cv=none; b=bo7S5qY+sKZ7ltDRAnql+HwoRRDluNh2sMR+V4vlduP88Zo97i1AAOfX0LqiUsVyUPWk4WXVmxfjPMO+f7hg4SbA2rurPkJD4si1lyBqn93no2lk6O8aR/pKcrTZirb+EX6LnBere3Q/N/FkRDXRnuzCXRJ1JQEQKkA4gNJTqww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346912; c=relaxed/simple;
	bh=HvQhDRGEbXASDitLcYtvHLvgKjj1+r2Z4Z4E7Eatp1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MppFb77cPMzo56wwSyl2XmGxAdgTJB7dyPF2COsgsb1ANXuXvDEpPrXB/yjJ8yJwtwbjTLs0eoQjFb02J/4rpIj3h6xrKb0TjRJVnrLT6d0YmVyrSXikJoZwVdhKyITdi6ErtiuLve54cVYPJrxSCSNOiJ7KY/Jv0ovJraJHN7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkSXdDUg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999741F000E9;
	Mon,  6 Jul 2026 14:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346910;
	bh=8M5fBpMa4WYLrMLZ7/qkHUo1NNQJNLS8VFNofstRWEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EkSXdDUguhUKIIAyXzty43yBeDvyKVFolhLybpKDmaG0XcSvdeoo20SXD6nTVAgWx
	 +XXxBnSxaaiHMPdcDsL1if48DOZWWNJBb1YsB5wsrl/6DlqaqZEiWCPG5p6Tq+TEzh
	 FF8JKG2eo/x52JipX493dgHR8cc1qHlOOnGigKqB5SPEQBLX/B8PfBxU70dRu0zk9d
	 ABGjUUJaVHnCL5ZMaDNQv5ZC1woqQk7ynHtdhDOj8tHclOdGUNt2oMzVcf7cm6VCZL
	 fzRJcFbpibM1DYjiYmLjR76P/UlQYzS7s3KnTd0u4R01EzzWjqfcuZjy/WRLL3i3Mp
	 NWHdg43dj2tqA==
From: Sasha Levin <sashal@kernel.org>
To: geert <geert@linux-m68k.org>,
	Ben Hutchings <ben@decadent.org.uk>
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	wsa+renesas <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulfh@kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10 94/96] mmc: renesas_sdhi: Add OF entry for RZ/G2H SoC
Date: Mon,  6 Jul 2026 10:08:21 -0400
Message-ID: <20260706135124.draft-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <OSCPR01MB14315350989F1BD556CA5B1E9AAF12@OSCPR01MB14315.jpnprd01.prod.outlook.com>
References: <OSCPR01MB14315350989F1BD556CA5B1E9AAF12@OSCPR01MB14315.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272249-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:geert@linux-m68k.org,m:ben@decadent.org.uk,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:wsa+renesas@sang-engineering.com,m:geert+renesas@glider.be,m:ulfh@kernel.org,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:wsa@sang-engineering.com,m:geert@glider.be,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable,renesas];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1E50711F10

> Thanks for pointing that out. We could drop this patch from stable 5.10
> and I can backport this patch and commit 71b7597c63d2ddf6 to CIP
> kernels <= 5.10.

The patch already shipped in v5.10.260. Since it's behaviorally a
no-op there, I don't plan to queue a bare revert.

Prabhakar, could you send a proper 5.10.y patch adding the
sdhi_quirks_match[] entry Geert sketched (.soc_id = "r8a774e1" - note
the missing '4' in his line), so RZ/G2H actually gets the ES3.* tap
quirks on 5.10? I'd be glad to queue that.

-- 
Thanks,
Sasha

