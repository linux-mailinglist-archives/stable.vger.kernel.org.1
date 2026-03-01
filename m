Return-Path: <stable+bounces-222442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDDdAcoRpGlcWQUAu9opvQ
	(envelope-from <stable+bounces-222442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:15:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5E71CF15A
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 126C8300DEE8
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 10:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8854C430BB1;
	Sun,  1 Mar 2026 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrmWfKoJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE88175A92
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772360133; cv=pass; b=tENiF+3/bQKkfq2svd6HjirOFCTAXPfqrj41VuqPeebV+mPTLoGeWK86+2cZhxHkaqOSSgO3dEIFQ7GanLQ/Zx+c9Vo4kY0yhkjjrDq++M+anGwt/Fi6y/u50JmZUcCzGxRiW3QKZ8aMDubHOwmEFiEWtlT2bVxQzWoQag6pPDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772360133; c=relaxed/simple;
	bh=JVws6GSJpK2zno2cIcBXKTh2COJC0r0bn+N62fUqSUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olY88oRnBwE+VOz9xl3e4m+SPsRe2NEJQmPN5rzxCK0Gd5fkpqEccd5/tWMKY9QUrtPFPpStH9mb9kbSTfEz+qZ/CLLHQmCwcElAjsUGO0DHirIX11+rGA0JNCqeaGz8WefVacSPYigF3jmOxSuphz4svyqzUv6sN2rnzFCNKOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrmWfKoJ; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1275750cfadso157630c88.1
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 02:15:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772360131; cv=none;
        d=google.com; s=arc-20240605;
        b=BoS/qdscoEcJBtxowC/eKgGnrN9N4z7u56xD2p2sL1meyJI1dG7rfddmRproEkPi4q
         PE40YgOgP52wrJw0m8lS2eLaaBFQx8OUk9aIi/oh0MAtuACvixz9pHWu3H0Ylyf3YZYT
         71iEOFguC4ybl8rhsLvJSBQm3c4BU1HQ34taLCmsfinRu3R2Nw+Vio7sk41zCLoPWEYl
         Pnw7SEJhGTLs9AyP7hPOaOPePq1RMTqzN73iS/BZ/AYCzwGDlOn2m9LxeprPGf4Z66+3
         Hi9QzQUZMQ5ux8gxwFgoEQEiGwnhdyf5hIIVxSpT+NYRhu6eBgwlOf8H5/Q4//Fh1ApK
         Ys6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JVws6GSJpK2zno2cIcBXKTh2COJC0r0bn+N62fUqSUs=;
        fh=Me4lvb+0TzIoUKsfdx0+5scFQ0m9HX6KbyTr2oLN9FI=;
        b=HiAj7/qrncUspasYf12wTdIprey6vipezVaplYDFduLsoHVWjpC3fF0IhMeSKRkfE/
         jpDhGxGhL8L8qNj2GA73nk4pCdWlH5EI0c7s4EEWqiFuYzzjao9cIsyTaN9jX0OqI/FU
         RuuOCRYvDBAt08pNTNxNtzuwBJpiJJS3oCvMNK4Tqg6DkMBQ3lFsGi1GOK2ooAAzyQZA
         5VxqbbZRNnbnVFHl/hZOILaEM2rNsFwN89y8XgUPonnSu2JLF2RaLKw3d8avPYX4AR41
         7YeZ2VC/vx4I269S2+BvdXtjWLuEgAUqeubi9ATTJKAetsTgxYM3oiGphRacQGaY/t/a
         N2+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772360131; x=1772964931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVws6GSJpK2zno2cIcBXKTh2COJC0r0bn+N62fUqSUs=;
        b=JrmWfKoJb+lX2xHc7HGMvVF9k1MLtUVkDzrXOCc9EEI95rcDFALzCnD6DSZ/KIRA4E
         wbo8xK+7WKBe5Z2Ge8xnxPZe1wBds6qw02/9b2weVy66ounzeuDHiWtlWxGQtdvU6WZl
         vDszUYG25A/bg+eMHTdzdRawDNZ4qMAXi4+R9qvbAmhfHDuqD3/C6DuPKOzqjWHdJ2uo
         5gXeWf81wIlekkZpClZjZo0WnoBdvRQU0VaXNT+zCvG6tfl6aR2e5jCViIKlioBBIVAb
         ocz13VA36o+HB1czU7hg75ll7FfxMfdxhTNP2e9nYnJ4MPItcyauGaUiwQBVtCkQXmqf
         /5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772360131; x=1772964931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVws6GSJpK2zno2cIcBXKTh2COJC0r0bn+N62fUqSUs=;
        b=BGrX0t4E4gLyfPOmm3GzZsPJuYlqolAAlsl/hVwL9KGvrmOo3kMU+x1V5bx7fn8j0M
         YqzLR3OovDVP3YbbRQOMSuAbgel+O2defsU3/0vUb89og89yNeVNyCm/Fu0+LyGKFT+w
         uijBiVljaFnjl21MZTaDXCR9sAN11Ck+fc3b+5iXokIk9RZ989jFTkFwOswQe4r8Xnvm
         456Ko3JUdfvM5snTdzgxUNSmg80RHtHC4xH6v3cfLX0HpMYt7WlpUY3c3bVTOjBqD5LJ
         w7XaJ68v7x30wYTsLwClM9YyYY4aNDOOqzgnj8/3J1ChbmsX1RcB0KwwNlv24W/XpUNy
         1Llg==
X-Gm-Message-State: AOJu0YyaUllE7zTmMYxNtgL4qzNJL/kUAEIcaX4Hmi8Hrsgk2F9PzbTg
	oH8poeXY09yZlBPo5uN146cBa0VgJrWh8UgcI/7ToagFd6juGhQORNY/kQwSFz0zNH7ptHRj8qc
	u/Jaaq4h3ThdChKX3nKD3LPUGrVkAsNwXzf5D
X-Gm-Gg: ATEYQzysM8hK1zKITit0zntT4AgH7CisE9NODdsec3Mc8ItyafuyX/VxQPUydKB8tne
	zicXVasJOpPeJud5dn0dECvb98WQyeVvvrkpTWeoGpcoqD6Gt1gAPdttbl/rJUmxfOYlHUI8G3l
	hbVFCMZGGHQgbsY7qf9Ekp0ZE6nrnllKXqOazlZ3PGZC4fRoeQkGUmoh31lvAOmuQaXraYrrlEt
	pEreQIppugmUdvFBx0np+8wq/F6hek2ecfUZiB7Q3anGbl9PQ3pt6w7kLzGsVxKWiYO78EqJwDs
	bz7YNEp7YiXwHtFq3QstQ387JrguPFc84mtpLhrFLQXVFom3ld5eOq+QWnHk9okewI0B/EZzEyh
	21f8mZjUX+rbBPICxNC4minMs2mlw
X-Received: by 2002:a05:7301:169b:b0:2bd:c883:5f90 with SMTP id
 5a478bee46e88-2bde1b34c6fmr1344804eec.2.1772360130992; Sun, 01 Mar 2026
 02:15:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301014640.1709697-1-sashal@kernel.org>
In-Reply-To: <20260301014640.1709697-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 1 Mar 2026 11:15:17 +0100
X-Gm-Features: AaiRm52xdwuiOcIQSI5afTqgE0VHFHSLJ6CMYdId2A09dixF9pKlBpIZH4n6RYs
Message-ID: <CANiq72kvP4in0uCQC2R82zzrZ9862R2-F1mqGYUpYBFoGLRvfg@mail.gmail.com>
Subject: Re: FAILED: Patch "rust: kbuild: pass `-Zunstable-options` for Rust
 1.95.0" failed to apply to 6.1-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, ojeda@kernel.org, David Wood <david@davidtw.co>, 
	Wesley Wiser <wwiser@gmail.com>, Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222442-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davidtw.co,gmail.com,garyguo.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D5E71CF15A
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 2:46=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

The Rust version is pinned in 6.1.y, so this is fine:

> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).

Cheers,
Miguel

