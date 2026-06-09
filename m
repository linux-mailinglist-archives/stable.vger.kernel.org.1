Return-Path: <stable+bounces-262140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jJ5fEMljJ2r5vgIAu9opvQ
	(envelope-from <stable+bounces-262140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:52:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C903565B70D
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:52:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K16TcEtl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262140-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262140-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39E603034A39
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 00:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE76E24DD17;
	Tue,  9 Jun 2026 00:52:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B441E5B68
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 00:52:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966328; cv=none; b=DrKwEAp2GXlfL7uDAz6vOzsxsZ1oVlLA3E9whXHdDSA40M+jDo1M7fO5HnmsV7z2Jbz1qX9pa8hS5OJhpC16c/lM9P5d0gVfy3LTCvpXLv7vgbAYAk3zMZ0b02W9Ikvp2LCa3Aw7AWee7HTfqg9toa0TPZ0AxRve/nwRl8AScic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966328; c=relaxed/simple;
	bh=g0+5yC15dN1lPsZlckgDKhTfeod5v0kdYtEmcfiLYM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/l0nNOQDrf4y6B7dkW9Q0xM0eqNPnxJJn9U8x24RmXMZPOIL1VdMzq9OdCiEkJ5Wyks2uOW8oLrXvY2uiqiGt9zZRlDXzCadHHWf1R+B8MI2h7OCFuSPL4DYw+W4cC9fvHscYzenYwVMAPiUsPXmTn4lfnf4QaZTzjfe3JD4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K16TcEtl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA62D1F00898;
	Tue,  9 Jun 2026 00:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966327;
	bh=g0+5yC15dN1lPsZlckgDKhTfeod5v0kdYtEmcfiLYM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K16TcEtlSpatse63y+hPj20LD1GdAO/Mo8tDL0/RgbxJkS7/IjcO/gCHo9hTZzLH0
	 GhbZf/yl9mn7BnPjnqF2z1WpU71K7+gF3vRWCv25XJWxxRc/ATU5elZ4Ywe5JUH3FA
	 Fs+TX277ABbyEYXwofINylyD4/vF2k6wHznbmrkm8HgE3LAUibVVbAfqhK91LusFHq
	 HuYVq+rBS0RZ6W0Ln09JSdQYSlxLtTDCFmZi+EXhRliOSmUTQcyWAgR8VTRMRYFZnm
	 rmU0x56jmdQ54+DMKdugstNVUerqzId8HcJtEVylXnp2+VnRfBEI4CmG/w4dSwZIck
	 eLhirUk1sQEAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Taeyang Lee <0wn@theori.io>
Subject: Re: [stable] Please apply 18fc650ccd7f: bpf: Free reuseport cBPF prog after RCU grace period
Date: Mon,  8 Jun 2026 20:51:47 -0400
Message-ID: <20260608-stable-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAH-2Xv+d-xVfqEN1NRpKbGmDFX3JdVzLBF1MXWubhzhbisaoUg@mail.gmail.com>
References: <CAH-2Xv+d-xVfqEN1NRpKbGmDFX3JdVzLBF1MXWubhzhbisaoUg@mail.gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262140-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:0wn@theori.io,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C903565B70D

> Please apply 18fc650ccd7f ("bpf: Free reuseport cBPF prog after RCU
> grace period.") to the stable trees.

Queued for 7.0, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

--
Thanks,
Sasha

