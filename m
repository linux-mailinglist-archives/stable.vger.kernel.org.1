Return-Path: <stable+bounces-259871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O2roFsUfH2oqhAAAu9opvQ
	(envelope-from <stable+bounces-259871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:24:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3F26310AC
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:24:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=c+yCCgyE;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259871-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259871-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69395300F118
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 18:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDAD395ACF;
	Tue,  2 Jun 2026 18:21:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329D43955E2;
	Tue,  2 Jun 2026 18:21:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424511; cv=none; b=biL2BOhO4qOMpE7VCQk3HXyzQpgdCJO2Z8LCLZDpPnK9pCCOwLMH70mIkNLcs6o+fhLa60kE/9zjpFaPSzXL9sG6AuTEoe1P7mkZ76J8H1RlqUX6QsJ3U6ijYefCtWTCXHslKoFwABJBtRcuhjnmTu0J7H4MPtlCSnQCZWsxy+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424511; c=relaxed/simple;
	bh=CulUlplfQFY6/wgqCXpaivURdbVg8z+bIOwBv9PsOQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlnvtCCOkmFO2ABVmUpgC0zwNcYreRGPYqQRX5v2iTtaLFH5YdCTV7qhfC40d2hY1i22H9DeA74cqGyGmJWCrdN4/JtQs0UH2PU0PYS9/851rdd1OtanNz+Ht9Bf2KnnLamUuIcHdXt2mQxP1A/aoAfJ7XU7bYELXsPaVdvMgAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+yCCgyE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C1E1F0089D;
	Tue,  2 Jun 2026 18:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424507;
	bh=CulUlplfQFY6/wgqCXpaivURdbVg8z+bIOwBv9PsOQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c+yCCgyESni+/fiwDqhqZCH9LQIyTyLzxl+VFWA+bWryQorDQhsSEUYzfaeItJWZN
	 TJEy6Y5nJLu+v0A4lDIZNzsF4vfKZRb3TomoXh98J8khAMEnrPE9xk2l9GDcMIn7p+
	 zd+X0Ll4Qyk2MjIa0VTpUnNle9NHN0my0iL+wtUX03fXQ+SdzMb9jSRG/JXURecdiR
	 qsWodHLr+XLFObg4Jh1ba3Ibs2cVDcU6yBaTs5eJnwynAdSWbLREM0uuinocXz3SOD
	 jz1dEAcHFmbMaCSavst3Be2seOJ2uC2Fvw7/typQ0VH4o6ItUY1FJkFi8TFAtYFVEE
	 PVPu63yxtDn9A==
From: Sasha Levin <sashal@kernel.org>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Claudiu Beznea <claudiu.beznea@kernel.org>,
	Pavel Machek <pavel@nabladev.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chris.Paterson2@renesas.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: renesas: rcar-gen3-usb2: Fix the use of msleep during spinlock
Date: Tue,  2 Jun 2026 14:21:25 -0400
Message-ID: <20260602180900.rcar-gen3-usb2-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259871-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:iwamatsu@nigauri.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:claudiu.beznea@kernel.org,m:pavel@nabladev.com,m:gregkh@linuxfoundation.org,m:Chris.Paterson2@renesas.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB3F26310AC

On Sat, May 02, 2026 at 07:58:59AM +0900, Nobuhiro Iwamatsu wrote:
> [PATCH] phy: renesas: rcar-gen3-usb2: Fix the use of msleep during spinlock

Now applied to 5.10.y.

--
Thanks,
Sasha

