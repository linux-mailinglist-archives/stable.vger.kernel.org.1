Return-Path: <stable+bounces-212906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGqYJj4TfWnCQAIAu9opvQ
	(envelope-from <stable+bounces-212906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 21:23:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A52BE5F8
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 21:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75034300BCAD
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 20:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507A9326D53;
	Fri, 30 Jan 2026 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgqTgC83"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC8350A33
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 20:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769804586; cv=pass; b=m4izQ6gEGSVG0SIi2xqoHm+2/+MaFpj8G+8r2M7WtgKeZADxzz59mUDVgbFlDKRdYmlbjGLU5GC3e/WkV5bPYgYv5D5DMgHR848iuw/OOXrKnI2sSn/oi+gZJlqQcZXS1He3A8Fq0XgAX3E+ddyQB9gt9iHOR+PNX4CuKUBDoKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769804586; c=relaxed/simple;
	bh=WMF789FgXx2e6Y4/vq27WMByX/ZrrFaKKZtWTYUTPEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOGNbSU2pH/eDE80SEB5fg5X5Y1XgVW/x/IX8KDVc/GWLD2NXZ2TZW2jiSMn87AuNQmq/Ux5zRCwLQOD7t4ldr0bPPI3X0rrtqd85yL1G1mlgjRzAO05NoBt00eb5O+bc2W+oD5jSMtmDAhiIA7HE7ie9HMCQ+Kld+VFJWGdVLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgqTgC83; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b700c7d3c2so62284eec.2
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 12:23:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769804584; cv=none;
        d=google.com; s=arc-20240605;
        b=i1wXBqzEgp/uzhVDrc7iDHU5JlsFfaCJeSsBJKDjFj1tUnMMHXnOhiiOyOb6k2/RgD
         qvACQaDOrgdAHlocWxASJqeurCSyIkH82zn8azH3w0LuZ5FZumFtizaXDhA3YH+w7fr3
         b+eUU/O3n8yhLKMW6LLjb35J45BLD9GL07ZOADLgsm/QMlshHn+I9WE2tJYx2Vx+KR5b
         XdNzQn3jK4WynvOY9DWp+yV8s65g07KH4JS1onxT8kGEknNjkee2EG5AYESIP5d+AOd0
         NJI8nwUXdXWLnlbI+iCJBb6rvUl0UtaBnmp96vDC0RpVFSdnP8Zy3BGpcL/xIdl2+Fqb
         Yomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WMF789FgXx2e6Y4/vq27WMByX/ZrrFaKKZtWTYUTPEY=;
        fh=J962H6tGRL3op3aDBzTELGas2o4DIXeslVjQ/3PhnWU=;
        b=Jc7JNKLFcZNrRwFfGoKuoxvTmV+Lp5xZrs7EdvtThJgu5lu/CORpt0hQj+F8m++l56
         PuvZZSC4W2vZFaK9r1Yh0Uw1UxgQfRatSf6BUebmR4NkLLtPT/UknZahU1fOC9G/Nwef
         sDfIlP78Pxkj937pxd6y7h3ITpo5OHA35/XwmFc0r8PWlvicOZ4t2mpxyMqU4Wd+Eo9K
         3xXfcZATvUCOWC878HJM1n+IOftUFmW0MMvGBNCyEGGmvKlaYu6xiWGjHbJqEwlNbQIA
         Q6BFQKm4xEqjnbh4v1t7Ldns7Pi998eJCLAYGM6ty7T2AwER+MccefIQ+oSq6Wdn84CA
         t9mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769804584; x=1770409384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMF789FgXx2e6Y4/vq27WMByX/ZrrFaKKZtWTYUTPEY=;
        b=SgqTgC83O82fSspNQE1x4UziEWomgX33iHYCLE1hpgCaArkJ/phzbYBP3FxaYjwZoY
         Xw+eCFd55mEDjVISH5JchZo6ZjIEzDtmTYoIZL8dzdwGqyNGo1rTkL9IcZWj9zyrS121
         fwovYTikQZEU0JjBTqB6H4qhWu+T9GfYMJwZaYxkkJB1dEqAvHFUQBAWJfUQG6BF+JWZ
         o8WqFiO0LjT1dUT3lBFvq4vYSOZWNu2rXPIBtr6nRjoWHay+Vp7SSTBw7TlXY9PhsIW2
         Vjuj8a1hAUDYP9RB8hgGNhFTSMK3F3lylcjM36m5SfMxlzWDw9UoZNyUrdtHrWUzPFYq
         6qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769804584; x=1770409384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WMF789FgXx2e6Y4/vq27WMByX/ZrrFaKKZtWTYUTPEY=;
        b=TkJm1XpsCkkBh8DVWsUK0olxSI1wp8474cABsEXgP6iUNSZvzox50aH7fgf5aaMvpp
         kcrU+gneVi47367qzKii3R31dbM6kMk77KDnTpEdJmxgYnngPui3/ayuWhgGYOsJyE84
         +M4MtPURV93oWIc9M2BLhHiRdDcj8bAkisTu9/hohtI2KshJBdGOzhOUkavvYf59rVyl
         vNaGoSkbDFuxGaOJrALYD7iBydlnmrgVdToewBIO+VN9P0XnFL/Xx1mwUbbXqnkaNaMj
         jKD/0E9A51VMJGQTKEWTzocZTTXg23q66/L8vAEpiAO5kodI1Nl4jk3HUJ+RKmEituzK
         6Yqg==
X-Forwarded-Encrypted: i=1; AJvYcCUX4VgIhOaJYHdP4ZdEgdm7eUoX1K/KsHF9/5CwC7fqSjwhnxNWuxQ0eY3b3GAAJZv0dm7oVH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9Kq8VB8Apku8rH9cbTZac9L05BfmRQNg89iGFTEOfFXN1fvU
	HEtOCE/g4zAprDpfBAlXN4mWNq4Mq2eQV70USOIelu3E2AoWWkK8ZxN/uxzgxo84O3Hh1lRn8xB
	6RtqInMPcyNkqTrVBHSDG9nHrctwclXQ=
X-Gm-Gg: AZuq6aKRRmEgwLZt5KdU4lvs44FXtPjXYcxAJe61hshaOXZyshhfVGbqz6bmTeS04JM
	eAaJtdH2I3nqfhKegWnpqgV4JxZ9M5mnJJhXhj866hi9W/Q2Y2JgRtqszcvSUPw98pHFf5ceY9P
	GJ5nBo6ZvlufqNwk08AZBePyykpzWdaobWRpi4xP1k8eP9pAFjZtZCLwE6FM3lW/kkLNXUFKS7U
	XRotiZmRMCdYaCrlhKNOcyZTjLWkWqteFr6VCt95f56f1wZqSTt1ea3zDhR4o/A2r7RJKCXC6UW
	URhma6DFJHX60EgMxm77FPS4QQpFMDafeqbE+iQXrqgpt1T8MtN+CedCZxP4U17nb2hwzjqJsBu
	/5ATAWp5xcQCE
X-Received: by 2002:a05:7300:6da6:b0:2b7:24fc:f639 with SMTP id
 5a478bee46e88-2b7c866cfd2mr1123479eec.3.1769804583886; Fri, 30 Jan 2026
 12:23:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122-rust-analyzer-scripts-v1-1-ff6ba278170e@kernel.org>
 <CANiq72kkxS9ACvR52q03AN+WdFV96cK+tvejnnDXKZTKuKZH9g@mail.gmail.com>
 <CAJ-ks9kiWZr=82sztLfYqtp-fvsQ2QTgTYqNg5hSsZMKCsvjZA@mail.gmail.com>
 <CANiq72m8Bx=1s1+_OFxE=PFOjKrtuh_uhsomTA9VwQ4=Fz4d0g@mail.gmail.com>
 <CAJ-ks9=zWmVnspkfCqPH=+-_qZ0YZVyNrs2xMvRRvEmr-mNMcQ@mail.gmail.com> <CAJ-ks9nMHtAaLc_LHOWqa_hTRqVcBNpGsaC49VFh2O+_3AoY+A@mail.gmail.com>
In-Reply-To: <CAJ-ks9nMHtAaLc_LHOWqa_hTRqVcBNpGsaC49VFh2O+_3AoY+A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 30 Jan 2026 21:22:50 +0100
X-Gm-Features: AZwV_QgY2s756W2c2BeIdnOIPOU_dOHgt0R3PEDW_x6O8Bex19ls3-KPywJ22no
Message-ID: <CANiq72m43pEweeWdg0qiGH8Yq6MyMJnFYsxhfYHeZu6LPxFPUQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: generate_rust_analyzer.py: define scripts
To: Tamir Duberstein <tamird@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Kees Cook <kees@kernel.org>, David Gow <davidgow@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212906-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[collabora.com,kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org,kloenk.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C8A52BE5F8
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 9:15=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> Applied to rust-analyzer-next. Thanks all!

Please see the other thread (and please reset the branch to e.g.
v6.19-rc7 for now -- we should avoid giving linux-next unneeded
conflicts).

Cheers,
Miguel

