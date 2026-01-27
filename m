Return-Path: <stable+bounces-211819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFb2OHzDeGmltAEAu9opvQ
	(envelope-from <stable+bounces-211819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:54:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AA695299
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5766430182A5
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1D035B629;
	Tue, 27 Jan 2026 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWHDHtAD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F044635A95F
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769522036; cv=none; b=Yvu8jTzTG2SENbtDfnJw5VaC4V2SU2dVwHdJOhCxCYo+npJ6VZYMDZZbpqNyaEz0i1KaR4oKnQS6tAQv7vrWsW4SBMf/9a+//WZUJYTGEMFEbWp4XNuJVAyT7/y4lYRqWgRwHiQBbFkHpXV40rHDynH4BXCotUv+xEQcq30fvgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769522036; c=relaxed/simple;
	bh=D3wR+QL3e8s6K+2o7wnm+jXnQfyNc04L+7SRNlNbec0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LyHjgumgsqH9KWYxKOgtymDLVKmPphv6mqZHHZIkdU4GkvYKEgyg4x2u5XFgPOCr1cx+ORkBEzMK+AWSu2dbdmymDDOuZO94LVIcl4oYSRZHq32lpuFQZvAJ6TGlM7TYRsrqkfrr8wQ3oIu/0hv2sCCqQKVLNIYlLhe/rK+dbLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWHDHtAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73D2C2BCB1
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769522035;
	bh=D3wR+QL3e8s6K+2o7wnm+jXnQfyNc04L+7SRNlNbec0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EWHDHtADPvumvhco5ZO6P1mfedT5G+mD5erodh8xhmVmqkFWAkh0PgmWJsvl+CcEH
	 1fwhvZWyVSm0g+a2pMtpPQi1d7CkTVjJ1GHXbS9q2pRNAXgIrfYy06vNtZsgJwES3Z
	 px5TlrnoPBSL//oALG53E3fdSsl1Zl5tid0jPdEQeFJUgGuqCf9wKNrO8c8HMw9Y6v
	 vw0qgLJ16Ey4prN9tow93P+CMpVX5iv7/+VMYdpRh+EE3EG/T0WUpF9YNrAfd/2FVf
	 oPeRpVHmcZhiXP4AvQvDDHRdEKM7jpQS5bAplCGjhlRN837bpBGDRkAB3BhF1fzhX+
	 aB8uOZTvRv5Hg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59b9fee282dso5180629e87.3
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 05:53:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUg2MKH1ttOJLwqt56uENOwN4ejkuynj+KdyPtSTezyokO+siC++SAVmSoUJkhmeNC41N+DOXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgRO+qEO3FBMJeCfF4JiUrqVRlfsBi59zYovxYzIIJkcFNMuTK
	+JArb6bW4kJpc3xan1yuqPP8oFH+6kxBVTSyIqcvI9Cc+CevcowIZAkYYC3wSHoAI9kPFm7mtjA
	WCW9Vtzxsq3QE/fRkBX5PHhQX/Gb40qo=
X-Received: by 2002:a05:6512:3b99:b0:59e:359:7afd with SMTP id
 2adb3069b0e04-59e0402404cmr836765e87.19.1769522034299; Tue, 27 Jan 2026
 05:53:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122-rust-analyzer-scripts-v1-1-ff6ba278170e@kernel.org> <CANiq72kkxS9ACvR52q03AN+WdFV96cK+tvejnnDXKZTKuKZH9g@mail.gmail.com>
In-Reply-To: <CANiq72kkxS9ACvR52q03AN+WdFV96cK+tvejnnDXKZTKuKZH9g@mail.gmail.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Tue, 27 Jan 2026 08:53:17 -0500
X-Gmail-Original-Message-ID: <CAJ-ks9kiWZr=82sztLfYqtp-fvsQ2QTgTYqNg5hSsZMKCsvjZA@mail.gmail.com>
X-Gm-Features: AZwV_QiIRHv8ebfqJ0OBns2FVWPBjsU2BCs_25E4T3uIoz6fpM04LJsH9Ore_Jg
Message-ID: <CAJ-ks9kiWZr=82sztLfYqtp-fvsQ2QTgTYqNg5hSsZMKCsvjZA@mail.gmail.com>
Subject: Re: [PATCH] scripts: generate_rust_analyzer.py: define scripts
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Kees Cook <kees@kernel.org>, David Gow <davidgow@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211819-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org,kloenk.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,collabora.com:email]
X-Rspamd-Queue-Id: 47AA695299
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 9:09=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jan 22, 2026 at 5:53=E2=80=AFPM Tamir Duberstein <tamird@kernel.o=
rg> wrote:
> >
> > Generate rust-project.json entries for scripts written in Rust.
> >
> > Use `Pathlib.path.stem` for consistency.
> >
> > Fixes: 9a8ff24ce584 ("scripts: add `generate_rust_target.rs`")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Reviewed-by: Fiona Behrens <me@kloenk.dev>
> > Reviewed-by: Trevor Gross <tmgross@umich.edu>
> > Signed-off-by: Tamir Duberstein <tamird@kernel.org>
>
> Hmm... This introduces support for scripts, right? i.e. it is a
> feature, or am I misunderstanding the Fixes:/Cc: stable tags?

It depends on your perspective - I framed it as a fix of the commit
that added the first script because that script was added without RA
support. What do you think?

> Also, I don't see the Tested-by from Daniel -- he gave it on the last
> patch in v4, but not this one. Was it because it was assumed that
> testing the last patch meant testing all? Generally that shouldn't be
> assumed, e.g. he gave two Tested-by tags, so I guess he didn't mean to
> give it to all.

It was so long ago, I'm not sure. I'll remove the tag. Thanks for calling o=
ut!

> I would also suggest on apply to give it a bit more details.
>
> Anyway, this seems best suited for rust-analyzer-next after the merge
> window when the above is sorted out.

Will do.

>
> Thanks for reviving these patches and splitting them!
>
> Cheers,
> Miguel
>

