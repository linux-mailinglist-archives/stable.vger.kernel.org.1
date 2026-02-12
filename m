Return-Path: <stable+bounces-215990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNeMFotLjmkBBgEAu9opvQ
	(envelope-from <stable+bounces-215990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 22:52:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C875D131625
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 22:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E356303A3CB
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 21:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764A22F6197;
	Thu, 12 Feb 2026 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KTXUnarw"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED9279336;
	Thu, 12 Feb 2026 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770933126; cv=none; b=omCO6zu3hAKqSXAuFLB0h73j3U2DyiH1/HQyNYCAyO8ucW4TYBDc2xexKXnXCswVHtX54ugsmpUK+XeB0cT22YVUX+2bvFhNvF626gPd6W0kzYcgUG8/yXQM1OpPh9L5aH5Kqg0WNRF1HFNPbMmClauqi4Hj+vOBU4yaBRhvydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770933126; c=relaxed/simple;
	bh=g8wduqvjk9McOLur7Ij2KlElofM3sYhcDxmZ2aKeuzQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=anU1fknfO7YKei0K6TO6Xzzy7grAUd5Qifs98P9yIvufrbhl6V1gALrmodgfS3BqzK07YMSTVeR7kZ7ySgp2PdL8ufxaxk38FAbatDEzvYbqRxwTN4wZeCP/pGTveZZYgYlHa2NFqhLJCLZ0GK7CwYyJV2FQzqhobnw6qOiCYX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KTXUnarw; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 93F3F40E036A;
	Thu, 12 Feb 2026 21:52:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NaLMpEsHMukU; Thu, 12 Feb 2026 21:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1770933114; bh=g8wduqvjk9McOLur7Ij2KlElofM3sYhcDxmZ2aKeuzQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=KTXUnarwQBNuW061a2F1PZqmigPGyzIr61zfCrW7oT3uvP+RcZzP7NMK4Vz77wYXo
	 OVryihb9uTO0XsIwpxV9xH4lAUkhwdbytFo5qO1y4CsTNOXGolsjt+DxekyucKkJus
	 WNFKSzgtCYu8xrM8P9YCL0dVXtr7P4LVSEKkVF3pBx4ls8zU8hbERjgJIi2OIbyFxL
	 h6NDCXcjYoBPXHyxsGtSZsFvijy3HuBFxb42NpLaySyJqOIklWIeL6JvFydaakbi6B
	 J+GfHjKtF6ZWjyPEcbt9MbHvi1SxHkMlr0n48hxXjaTO2zfmpg2nytY08neIQT4efS
	 AMyywUF0DQkniNfOEzgCkE4FcAbgPUd5g1dT6ThLcwRUzv/IG+oWyjSiBVBVVSbTyA
	 XvW0SqeD+9lRDuwXVapwv7dgwWZ5PfVKN7FzN6W7LRv3BNaXy5/5FAZeQLNPT1xHoy
	 3+kZ5wpG/DBQ1cFS7r+mg3Q+t/xdKFak4g4KiPUyA7Zien+pa6vZbu1U0pNrE8DB8c
	 GX94VqRy6B1VJ7RyJ/yO968QqGADwvJo8kyGkj/4eZ6wLS7TIBMnZuz82g1sVsMCTy
	 EgKd1BG+YVNyISbujfqy33anmOu/C2f7RRC0kCITS2zVWAg1mh4qMBgJDGSH/d2p3n
	 nZ8Gkh9AvPMNcVJWWT5Bzodw=
Received: from ehlo.thunderbird.net (unknown [IPv6:2a02:3038:20c:8039:b0d4:99ba:efda:b688])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9CAE840E0219;
	Thu, 12 Feb 2026 21:51:42 +0000 (UTC)
Date: Thu, 12 Feb 2026 21:51:37 +0000
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>,
 Maciej Wieczor-Retman <m.wieczorretman@pm.me>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 pawel.chmielewski@linux.intel.com, Farrah Chen <farrah.chen@intel.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_1/3=5D_x86/cpu=3A_Clear_f?=
 =?US-ASCII?Q?eature_bits_disabled_at_compile-time?=
User-Agent: K-9 Mail for Android
In-Reply-To: <E9F385CE-83B8-4088-B6FC-AB113F8DF55C@zytor.com>
References: <cover.1770908783.git.m.wieczorretman@pm.me> <32fbbfc16974cfed11e7d2651bce836ba9ceaccc.1770908783.git.m.wieczorretman@pm.me> <20260212155808.GDaY34kOTrEYHLdoyK@fat_crate.local> <aY35H-VXwoSLFXoj@wieczorr-mobl1.localdomain> <E9F385CE-83B8-4088-B6FC-AB113F8DF55C@zytor.com>
Message-ID: <A9F52EC5-EC74-43BB-BB3F-351F684BF5CE@alien8.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	TAGGED_FROM(0.00)[bounces-215990-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zytor.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alien8.de:mid,alien8.de:dkim]
X-Rspamd-Queue-Id: C875D131625
X-Rspamd-Action: no action

On February 12, 2026 9:34:31 PM UTC, "H=2E Peter Anvin" <hpa@zytor=2Ecom> w=
rote:
>As the original author of the code I'm pretty sure that bug was always th=
ere=2E

So, we don't need to backport it anywhere, we change it now in 7=2E0 or wh=
atever and so be it=2E We can backport a documentation patch if someone is =
really pounding on it beint precisely correct for whatever reason=2E=2E=2E


--=20
Small device=2E Typos and formatting crap

