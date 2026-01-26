Return-Path: <stable+bounces-211508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPjkNBbbdmnNXwEAu9opvQ
	(envelope-from <stable+bounces-211508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 04:10:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5955B839C6
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 04:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AAA930048ED
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 03:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FA617A303;
	Mon, 26 Jan 2026 03:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hnu5lPO5"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABCF1E86E
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 03:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769397001; cv=pass; b=Nq0SZ0pjHsAkuidDMLxwu+zNHDfUTEf+IFSu4lUx1BUkHG1z07hn7qSGyKx9Yk50VzA3WlH1EFDMTUoMbKBlHh/MWe6fSxEJS1TWCQjf4C6IZDNdp23HsI5dUF8JOTMHHJK6AnHqe/5Uvl1bpb2G/Jc2r9Ky5uEuJivk6YVSkE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769397001; c=relaxed/simple;
	bh=FXuczcb9EQhfCWhWGikpLZ6MR2jhk5IsjGErDR8Lph8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjfWosgeQhCaXx/y+ub2XgA4GHs2RiqC8duFeILRgWcPt2sAjLEZxWMd6RxQPFYirVXlKaoVC1FiREzlfwa0C80vpI6q7iFRFjGbFZQCimLNG2NduaziNgxMLpR9MESlcC4OfMA3+U6k1vNI74qK5z8EzjTLF5OGcARj18n1EbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hnu5lPO5; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b70b21ce0aso131182eec.1
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 19:10:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769396999; cv=none;
        d=google.com; s=arc-20240605;
        b=aRbXFSjqpIW12hCRBDYV+ge8GYdYUX845Hb61xpRhCYrgXjb+0qKYete4jE0mAWqV8
         FLjzgwxMylmgSbDNw/JwIUBC21Dd7sTYLci2vF2rwqbvz19uRs1uEezK1+7IHBOdqL/x
         vjRmlXfvzFu3tfmJh06UFtSi9P/WNdWlOHAhmtDex+C90OaqAG5y4fa1AaV3q7lZNFvo
         GElcWF2P9XfS4qsclRDDrGFqnHeHQQtnk1SudhmT7RhDFDAsMSsDVauDLLfJ6u6c/ZNV
         fJUakWy7hdvj4CCCUXvEbGLy3R8zWwjwoOgUWpFcSnb10pACor/ctM0hCA+jrpZINaDY
         kyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aGkhlq+qSUrzulxWE4fwqd45d5ACCtLmrPVp1WG8FY0=;
        fh=fb6m5dk04yCHZQzluMmzSSHAjT3UcDTIS4WrRMJtx8g=;
        b=ExExJkdPq7GkaOuTNbQ9rmIAhw20UyeKXmD+wFUTj/ozNo3+CESSMU1jT9f83BZQoo
         9cDEBAJ5D3GBJt0RvbIPyVDdAOq3yfFL/umXq2yumTklrdE+46hPrHrBv0e1i5yRqvCD
         3R/QPpn2ncouQ9efP1ySByhRk8JWrFVZfdEHxi4JpRdkdqqnfClmtFCj7Sfx3Dy9oVTO
         mqPaQfUhcaLYnc1FvUr2On+P2Cv1TOuxovUz+HcUhIU6NYgo3gO2MkbDPIh/+GX6vf+f
         nTvBQJ6dH0Pg3yECJ2N1D9Fq8PO13nSPOlLyU+L0p3UjqZVzrvqGJTm7SXpkrlZsQa7O
         UDyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769396999; x=1770001799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGkhlq+qSUrzulxWE4fwqd45d5ACCtLmrPVp1WG8FY0=;
        b=Hnu5lPO53pHGpJnMFfr+TJyQPv+iUYrx2Cy6RqxfJWAK+HHqNJyZ5zqLUuMZfeA26U
         U6VfOKgPj1IonJRIpgvEQ4o2yUZCHXOntNTMOjVhkvi0Wuszz+dNK6GQsWx0hR1QVMKa
         J+yFd4iY6my1G8o3NbJgDszU5Sfs+Ry9CZFROEJ3/Tpq1DtE4FFH5ztyAR/x8tND3bEP
         0QX+dWnsnHlXc2bo/FgNt8MDP1+WMlFk7brl/1I1VsuhbCjD5PhTsxmIpFZ29pztZCdo
         PoAQswowOlKsKQbkWKZXB0N1hiQQQenkZikpulMVJTM+FoBLINDcUKgh8cmR1I/hnLWx
         LJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769396999; x=1770001799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aGkhlq+qSUrzulxWE4fwqd45d5ACCtLmrPVp1WG8FY0=;
        b=dZUUTiEjYhkdvO5U5AbpEW8tuAmVCyrIvzUULBaOwhwH2RCZsYedVQWa3j1CGo3Xd/
         imreo+HwpNgL8uWSwOuP+na287ycc1zlwI3tGTjm0rvGooWut3NimcLM3okeqH1Kqe5K
         uKxjjbfCrK4lupbjRuleyXvWDwsW+W4B4cuAcloB/2IsRoUM4ZU0QQo6pkBow39nHtkl
         /y1J9RNWFZdO00FGugKQ+LL8TaJJOqs+NpqgaAqCHLPb0NiuAua1BGLxIsIWUJeceyyh
         s2oDsfiHF4J1IryLHuV4fsTaqzPg/I/VB5QsnBKL5MlVLGACiqMZ7aNO5zh8OI1YKJIX
         8Frg==
X-Forwarded-Encrypted: i=1; AJvYcCUXudCGFgKBvnR03Tt5aMPEdAq0ftmW27KAJFyI/eSRXSbpQejsmclU2YEuS9v96HYT0LlADy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOdPrgr8/9uuyH0pmGk2uUhJV4007Bq+lf6ifVi1fthBQXhTL4
	PAc99g3vtQdCZqJsXF0FJ+TSzxX51vTt9NkKKhE69MHN0SUrfOM/JjH7jfIrYoYDblfffvroUWf
	OHiVRjLpuVzUUfZ0J/ndxIHXvf1d90wI=
X-Gm-Gg: AZuq6aLUjmCBGD120BoORbTuxFCanMeqloC+FaIQSOjKizqYyJ4RfCrMTqL4YqNmHpX
	5TQqLHunADgEXOZPyGReN5ZvS+Y+3o6F3AAMvzRLyoZC+KIv4v3y8xfd2VIj/iaVvQCtGtKjIIh
	I3tWLdUAYTP2lctiLqe62quq9GbpnB7va6r3DlPc1v7mDnSGY3VXYT58UlgnaUcBQVxcCRmWTy7
	/5j0zCkTzwVV/5NnK9h/MUgin/Mv5ZbUbCV34TtbdouaFx1Oea6ue/vJOIDhIS/GfWj6GJ3drzE
	4QJzvDSV0lwpMXRMpOiRYWxHezqjVhyJoICBNDZCIg89OL6nJh/kAOL2MmOsdJdVN2u/iTWhKhp
	c/Izn9hn96/C/lUMXnsDJ3IA=
X-Received: by 2002:a05:7300:c99:b0:2ae:5bd5:c241 with SMTP id
 5a478bee46e88-2b764525613mr694128eec.7.1769396999486; Sun, 25 Jan 2026
 19:09:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124160948.67508-1-ojeda@kernel.org>
In-Reply-To: <20260124160948.67508-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Jan 2026 04:09:47 +0100
X-Gm-Features: AZwV_Qj3CR4N7SBnnpnodYCqhXQ_XVvQxGRUJ728I9V7kk_y48uevULv4kIV_F8
Message-ID: <CANiq72=3+==Px50E+EA0fhe3pxVAGzRRt+6d+qze3cdeEBjyoA@mail.gmail.com>
Subject: Re: [PATCH] drm/tyr: depend on `COMMON_CLK` to fix build error
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, 
	dri-devel@lists.freedesktop.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211508-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[collabora.com,google.com,lists.freedesktop.org,gmail.com,garyguo.net,protonmail.com,kernel.org,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5955B839C6
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 5:13=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Tyr needs `CONFIG_COMMON_CLK` to build:
>
>     error[E0432]: unresolved import `kernel::clk::Clk`
>      --> drivers/gpu/drm/tyr/driver.rs:3:5
>       |
>     3 | use kernel::clk::Clk;
>       |     ^^^^^^^^^^^^^^^^ no `Clk` in `clk`
>
>     error[E0432]: unresolved import `kernel::clk::OptionalClk`
>      --> drivers/gpu/drm/tyr/driver.rs:4:5
>       |
>     4 | use kernel::clk::OptionalClk;
>       |     ^^^^^^^^^^^^^^^^^^^^^^^^ no `OptionalClk` in `clk`
>
> Thus add the dependency to fix it.
>
> Fixes: cf4fd52e3236 ("rust: drm: Introduce the Tyr driver for Arm Mali GP=
Us")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks!

Cheers,
Miguel

