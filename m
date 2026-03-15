Return-Path: <stable+bounces-225470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCJJIdmjtml4EwEAu9opvQ
	(envelope-from <stable+bounces-225470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 13:19:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A972909E0
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 13:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9226301A3A5
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 12:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966ED2F361E;
	Sun, 15 Mar 2026 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CeMhnLto"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7641B34D3A5;
	Sun, 15 Mar 2026 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577169; cv=none; b=Q8CzxdcewC7pVjHJRj3uFY8/med5UM2cxD8mxxsyR0NoZziK/Gb8ufLV16wih7yx/fJDGIOkOCY7+frr4orPlJibMUX2DBCGCX0yNU5Ah2SjdEOMISZcQDEloXvvEEAzhaIoaoIH4r1/AsRtygpOWZUBlmSkrCQPKg5spgGg+8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577169; c=relaxed/simple;
	bh=wI16MUUGzNE7fgDhSuvjmHXlxt3gvFDTZ0xJJTZhcpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwOHny45e1ugatHxGhnNMphWhBGeM+6lfaRzks+c4C1nuM8B5NVNIiQwDFmFbL1/o9WMYMw7CHPyBpnfZN92paJWVx1Dxztzoa34nWaP+HZ0zTnatN4XhvU1pcrkBsdKh2VnpnchL4q4PmluIFfDlA0WaKicErnivBGldjX/NUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CeMhnLto; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3137D40E021E;
	Sun, 15 Mar 2026 12:19:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SF1GvGwAc-e2; Sun, 15 Mar 2026 12:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1773577150; bh=8R8EEzYuWEA7Ucryb+uhEgfJaYBo+cn3iidWbX3/xoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CeMhnLtoFX8KIXO2w/vCJ7T5cuf9sCj5ygIB3+kaxb/qS/dJKIH/73I1cVsku0GjY
	 PkWcFN515jhjAypZZBJHfjI9F/hHezkNMtc1fN1cPzdhrvsBrkr5pfmb42zTsx1X3D
	 dpY+ylbq+fKzE5FAj6PQC5K+e+M5CepY0uuFGeQxqH3Y0oWuYOPTicZA2Hvaao7+TS
	 sOmH6Zp8+K+rhjYqdUMuOhTBPSsYI75Ln/g1MAFJfTDRgkT+uIyRo/c6rAwQrgdqTW
	 hbYiY5g15dhkaV/T7blwtvDIrsxHsOkYGZSnxNqSclixZ0bYgmBoS+QdFdNVztEe2t
	 ty+NKPqZLxmgTyiQi7z8YyNUpL2BAILj00BPBRP+Mog04o1KDJY9SwOSjXWj6IIiDQ
	 uE21bSarf1OK3MmIFCfx3iPeCP9YprAbKScpRD2ksWGfpaO3mp1IieSdms8PSO+6Tp
	 /mk4xtKcF3SdZeu0BcNFDR9kAwo+XaJvCcXn0UAZO25Y+P8q9fDHDFg1CIVJdO7tla
	 7OaJk85tY4LUL2vMNgeboU7QXbke1iHdgpKecuiIekLx87C6hFlXxbglkkTGGiSLq2
	 fsfqWWIgkylatvJvvkyZc0feLOUe+/YzeYQfMoKYQOwTCJM+r6AC+z0kVJu+GG3iFa
	 pR9qRJfULuPOwOfbmQPDPrCU=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5434C40E0213;
	Sun, 15 Mar 2026 12:19:02 +0000 (UTC)
Date: Sun, 15 Mar 2026 13:18:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: tglx@kernel.org, mingo@redhat.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, dvyukov@google.com,
	kasan-dev@googlegroups.com, stable@vger.kernel.org
Subject: Re: [PATCH] x86/kexec: Disable KCOV instrumentation after
 load_segments()
Message-ID: <20260315121855.GAabajrw3ajExgb7kv@fat_crate.local>
References: <20260216173716.2279847-1-nogikh@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260216173716.2279847-1-nogikh@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225470-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E1A972909E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Feb 16, 2026 at 06:37:16PM +0100, Aleksandr Nogikh wrote:
> Disabling instrumentation for the individual functions would be too
> fragile, so let's fix the bug by disabling KCOV instrumentation for
> the whole machine_kexec_64.c and physaddr.c.

Seems like a whack-a-mole thing to me. Why not make KEXEC depend on !KCOV?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

