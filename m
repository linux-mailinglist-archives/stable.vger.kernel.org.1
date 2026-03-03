Return-Path: <stable+bounces-222806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNB+M3OLpmnMRAAAu9opvQ
	(envelope-from <stable+bounces-222806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 08:19:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA461EA0C2
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 08:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3200B3013870
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 07:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1464E285C8B;
	Tue,  3 Mar 2026 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gITAAnzJ"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166861D86DC;
	Tue,  3 Mar 2026 07:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522352; cv=none; b=nwptHjOj51GUNKCCw4FsspP1+qRQijcEB/PcpVoQIisWTG9vj0h7F5AVVUxF4+sahkiVtAuJPDx4EZTQYO5Muibzk3Rudw9lVMJblI8prk2HnQPtQ7y9X2Ja1326H16CoVkBkV1eG7FxIDjwQbi2qC+1c1xQRfY5J6R7Uc7a+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522352; c=relaxed/simple;
	bh=DkGv8JbAOFxr5thlBAs3MPsoSFRTjviaF8v3BxFYBF0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HVP/6aDyj4XrOG/95EQgf8nK+Wxlaq9O1VSUaiCKIbloLJVF6Q6KvkW4MxOweTvVeWA95Ua1A5522xek7+lLKYXaqASApaPLYKTqdBg0SgAsryh4NfqRayEtW0Pz+v/XsO6v5G+QiX3wDT2rtojQOe2niqyBJiLwrmr6a0Dg6v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gITAAnzJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E793540E01A8;
	Tue,  3 Mar 2026 07:19:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UxauTnrrJHCH; Tue,  3 Mar 2026 07:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772522344; bh=DkGv8JbAOFxr5thlBAs3MPsoSFRTjviaF8v3BxFYBF0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gITAAnzJIXVYTNb+KWUu052a/pwkEqsYCnrFXpAiMCSWw2TwNNpLQx/q142juaa3F
	 VYiUW1EgF4ezM8EfIC75jGcoqYivdR4lSooOMO1Mq3LeGLODsSzDQyPwh3BO27LdQx
	 Uhox+zOJIDB04CJOFfti95v16txh3f9PsqXXK3BaY0PcHcRqPIrf8D+zAWv1JsAIEi
	 OnLWBrnEHTBgPLJ4S0YOw4bGyjq59RTS5Ln9KEaNOyKyufuitCs6sVqa5UHfQplZEH
	 kP6MsmLcd8zkWwsgjyDvci+1MSVbIpQb8YH86ie1Mlj/23jV14LuZTusi3r6zaX0P2
	 w3DmsP7Np1+hfH6dxt95hw5mmSHydMSPuk2iLhIzX4+FuIUqA0JOKJg0jGhFFzVR7m
	 vaFlmRAhwwlL7+QUG14Fz2SYTmM8V8hXY61by+RQE85q4GZ7GjYs4XrAtr3iPAMLLn
	 SbhVcSe21KD+nfr6BGQQR/JAOXLQdSKBurdFnTNYCfHYqHa8OiGI6Vir41MgwJpexp
	 Jn3AD+vsb0GGyHqO5OtVJoHUdCZKpbFMECcMVSDK5YnRQcQuqXLPdKvSnRotyDZhuN
	 +X86mtCS8ZLWAg6XNLHhYqmlPypueZ8SsHwDDU1iS0xzaHJwmuhne1zmuJMy2UYvC1
	 4lpA+Bp0qJA3xyGNYxTgbhB4=
Received: from ehlo.thunderbird.net (unknown [IPv6:2a02:3033:609:6566:99c8:926b:e70f:2e33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42F2740E019B;
	Tue,  3 Mar 2026 07:18:54 +0000 (UTC)
Date: Tue, 03 Mar 2026 05:59:39 +0000
From: Borislav Petkov <bp@alien8.de>
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Farrah Chen <farrah.chen@intel.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v8_1/3=5D_x86/cpu=3A_Clear_f?=
 =?US-ASCII?Q?eature_bits_disabled_at_compile-time?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aaX_EBPkvou6POYe@wieczorr-mobl1.localdomain>
References: <cover.1772453012.git.m.wieczorretman@pm.me> <cb4c2a6a0e67320b24244658b724acc1bf9686ef.1772453012.git.m.wieczorretman@pm.me> <20260302193142.GBaaXlnu86gUtPyQG6@fat_crate.local> <aaXmP1pOU_feTVu9@wieczorr-mobl1.localdomain> <20260302202504.GIaaXyIAQnaHTdzN52@fat_crate.local> <aaXz0ENy6iq2DuxX@wieczorr-mobl1.localdomain> <20260302205947.GJaaX6Q5Qx6vJMdun0@fat_crate.local> <aaX_EBPkvou6POYe@wieczorr-mobl1.localdomain>
Message-ID: <D5F67944-7C7B-4675-A495-E30CCCD4A606@alien8.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4FA461EA0C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	TAGGED_FROM(0.00)[bounces-222806-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,pm.me:email,alien8.de:dkim,alien8.de:mid]
X-Rspamd-Action: no action

On March 2, 2026 9:22:47 PM UTC, Maciej Wieczor-Retman <m=2Ewieczorretman@p=
m=2Eme> wrote:
>Maybe it could fall under the 'some "oh, that's not good" issue'? :)

More like "no one noticed/complained until now so why are we making waves =
and generating unnecessary work now" thing=2E=2E=2E

--=20
Small device=2E Typos and formatting crap

