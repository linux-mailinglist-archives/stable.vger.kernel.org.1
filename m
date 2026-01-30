Return-Path: <stable+bounces-212905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DiaN2ARfWmiQAIAu9opvQ
	(envelope-from <stable+bounces-212905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 21:15:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45596BE589
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 21:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9130A3018BD1
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 20:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF116302742;
	Fri, 30 Jan 2026 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXRR1P1e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF552F83A1
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 20:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769804124; cv=none; b=Nn2dSfESyCtF7gVpjGbspNbm2MjrraxZuTaxroKkh+5jD32ryPey+JtHWYveshkyL0sr/WF7YtFaleNkhtO7vs484hXH/Y8BZZNM4atRrP2Gva5gPQ1psSPegtwyKYAW1L9s78EZcmJ7dq4Oee3fj6Aqb2Ico19ABi5DB0BzNYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769804124; c=relaxed/simple;
	bh=rDxpBa2wQbBmAcOx3wZdYI5yW3Gufe5SwgazwffXj5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQOqIR63F1dd8bYDp+WWtIsHUM90aZDPHEY9EvFdtqpPlYvItJZMyGRaWs90iAIG+3DXZDZuHRpHvz4AbMXLV4EDn1qgX5C2RmeXYsiN5FQrtNmXer5TZfJG7VB9whtwTD/lCbIaUfec5m3AMd2hbwLNEcUQwDFsxNHpea5v19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXRR1P1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E9DC2BC86
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 20:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769804124;
	bh=rDxpBa2wQbBmAcOx3wZdYI5yW3Gufe5SwgazwffXj5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QXRR1P1elSoPSRoPWCjHLjHHkt3Lgl/1Fr0Ot8ggOenQwvgbMoga9DVY88BTtJZy4
	 xyqVfIk96W1cuRDtQUbl3QxdNdjm7FwkRXbuIpdTC4JRgcghoYyzKSI02AGdplTFRY
	 Z8LzJ1Ho/e+sJ0dJwEjHrG8M3ZZkF1G/jNF5E9N2oXJpKMMCMwh1SO3Xe7S/8ooLSY
	 DNiJ5bX8XZcTNZfaWHv12IISR5vME3IgcbI8WIQLhBqRrn4N/8afBc8H9B8h77m68m
	 OLgt1Qnxp1gJSlytXrsviS8umSML0FkbfCaXAZLSbSOLYsyE5vD9t65GUaFJk3fupd
	 0aBa4NkQlD4+Q==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-385c23b88e8so23756231fa.3
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 12:15:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNA3zd+k9LQorKugX1bQiVtD2d2iPR6z4vkaBvdUF/widGPPk1+UM6nfrnCot6NuElTc2nUM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7N/NGv3MjdOgf2hTdvZGrNFKlTUZtWZojCcYPxwLPv4yI2gvX
	ZMy/ZH5JVmOnX+9T6mfQuyN5YPtA1qIxge14rcI+d/dkhN4SYNwPuTl6yGXOkSCzuuLdTPOI5uS
	YB5LKbPKphsYH8GsrCcv7zpTgk3/1/1s=
X-Received: by 2002:a05:651c:a0a:b0:383:5ea:e9c1 with SMTP id
 38308e7fff4ca-386464e0997mr14206801fa.2.1769804123007; Fri, 30 Jan 2026
 12:15:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122-rust-analyzer-scripts-v1-1-ff6ba278170e@kernel.org>
 <CANiq72kkxS9ACvR52q03AN+WdFV96cK+tvejnnDXKZTKuKZH9g@mail.gmail.com>
 <CAJ-ks9kiWZr=82sztLfYqtp-fvsQ2QTgTYqNg5hSsZMKCsvjZA@mail.gmail.com>
 <CANiq72m8Bx=1s1+_OFxE=PFOjKrtuh_uhsomTA9VwQ4=Fz4d0g@mail.gmail.com> <CAJ-ks9=zWmVnspkfCqPH=+-_qZ0YZVyNrs2xMvRRvEmr-mNMcQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9=zWmVnspkfCqPH=+-_qZ0YZVyNrs2xMvRRvEmr-mNMcQ@mail.gmail.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Fri, 30 Jan 2026 15:14:46 -0500
X-Gmail-Original-Message-ID: <CAJ-ks9nMHtAaLc_LHOWqa_hTRqVcBNpGsaC49VFh2O+_3AoY+A@mail.gmail.com>
X-Gm-Features: AZwV_QhncK0We1zFUkHB-_4kfr0Qvxn-w4b_0QxwXlk2gLz6yBBl0VkZfg9wrck
Message-ID: <CAJ-ks9nMHtAaLc_LHOWqa_hTRqVcBNpGsaC49VFh2O+_3AoY+A@mail.gmail.com>
Subject: Re: [PATCH] scripts: generate_rust_analyzer.py: define scripts
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212905-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org,kloenk.dev];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamird@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45596BE589
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 12:07=E2=80=AFPM Tamir Duberstein <tamird@kernel.or=
g> wrote:
>
> On Tue, Jan 27, 2026 at 10:13=E2=80=AFAM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Tue, Jan 27, 2026 at 2:53=E2=80=AFPM Tamir Duberstein <tamird@kernel=
.org> wrote:
> > >
> > > It depends on your perspective - I framed it as a fix of the commit
> > > that added the first script because that script was added without RA
> > > support. What do you think?
> >
> > Yeah, I see.
> >
> > So, on the implementation side, I don't think we expected scripts to
> > work at all, which is why it sounds to me like a feature (neither the
> > linked commit nor the one that added rust-analyzer overall support
> > mentions it that I can see, though it doesn't say otherwise either).
> >
> > But perhaps someone out there expected it to actually work and thus
> > may think of it as a fix. I don't recall someone asking for it, but I
> > haven't checked. Perhaps someone would, when we use more and more Rust
> > scripts.
> >
> > Now, for the backport part, according to the official rules, I think
> > it wouldn't fit. But those rules are often relaxed and who knows what
> > companies out there doing out-of-tree work on top of LTS kernels
> > want... (Commits can be submitted there even if they are not fixes, by
> > the way).
>
> Thanks for the context. In that case I'll keep it as a fix and take it
> through rust-analyzer-next with the backport tags since I expect it to
> apply cleanly.
>
> Cheers,
> Tamir

Applied to rust-analyzer-next. Thanks all!

