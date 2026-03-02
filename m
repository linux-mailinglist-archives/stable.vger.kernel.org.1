Return-Path: <stable+bounces-222644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JaYIKO7pWnNFQAAu9opvQ
	(envelope-from <stable+bounces-222644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 17:32:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D9D1DCE3B
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 17:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D234E30464F5
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17102423A94;
	Mon,  2 Mar 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9U0WvZs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7505E423A80
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468974; cv=none; b=EqsdvyJaUb7fQyCa2KuGMZWO4gKVAPIZIXrWGFIWyk2QU2VX1/132VGQ8TJyuWglY45exyyQe+dhWmna3WkhH8gN2GaMSRaLEy63eUPgtUUsbeMPpl3TfdyhwZjARIwKY7J5dYJ4iZFZE4RntjA/Ti/rA5hnud4YN7tKuC4WNbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468974; c=relaxed/simple;
	bh=xV4ZS145hGBCUUa1t/ytg2t0onAvfezASEADcCkUiJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6a6pt/4X7sjlFZoq/EP7CCfHJF2j+8R9J2vKInmLoaD1VVU+PvO3/mw92DzgBcaZjvrx6e3vNiR+q8X3kB+Zb5YulGl9z71Rh9fIei1CdkYn81hu7GIrtNTZkz8feI0CkyMV5r9g8GTyfY2+RAxuXQm2h71OYpRel6RWxNOIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9U0WvZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18208C2BC9E
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 16:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772468974;
	bh=xV4ZS145hGBCUUa1t/ytg2t0onAvfezASEADcCkUiJA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g9U0WvZsVPLk4ADrsfSrJzEfsITRk+IuippNq8kM/rfkUBhNJtHEFRHZLqAs0PvsU
	 +cVNVWHBVRyBvL8QwTYQ+Rofh8yueSSagagdgLBk0H1d9j9c1/FaX95bmkgRE9edi0
	 7GBHLpCaJle5Ib1RcRgjYRKQn+p0/oPmkOz9niY9Xc7daapYVBsXO7/MMoLwChOQxN
	 tS4O87AiS4Mc1vJM91F09znknv3fGgIZ7NeHOQlsIoLRF49Rm/yJDi3S/wmoG74ZEh
	 ALuLeTA3Um5rhAywJJtQ0fyafcamri2Da56ZRTOvyxgm8EBcYrcRNbp9sJH54q3i8d
	 8uQCcCUFh0HAw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38706b10b3bso84010901fa.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 08:29:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5LapAhGLmTdGeI0RKW5UOETe87y2L/J76dJzpbTQX/rXk2VSj2/405BPZb0SHdPIuYyIIYRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMhSX58MYPMEQUA310KwrYxTUtU2S2GICkDmkr4U8SYLEna2c+
	nxx+OwM3Jjx4fKk+B0jOUW8i13XLb/Z1sjA6tUJscy8F3Ij0gaxBxwDGFWdWn8+gyxqb17wXY9x
	+aWdsOMd3kIrUqg9NjUVTED+CFhifWBc=
X-Received: by 2002:a05:651c:98e:b0:386:7cfd:55de with SMTP id
 38308e7fff4ca-389ff11899dmr104670501fa.13.1772468972769; Mon, 02 Mar 2026
 08:29:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-rust-analyzer-fd-leak-v2-1-1bb55b9b6822@kernel.org>
 <DFZIS0QDDD56.1ZB0WZUXPR5IZ@garyguo.net> <CAJ-ks9=hKVVa9UXFXx-aiqba7U0UHQChf-5pf1d=TdYrtC11Yw@mail.gmail.com>
In-Reply-To: <CAJ-ks9=hKVVa9UXFXx-aiqba7U0UHQChf-5pf1d=TdYrtC11Yw@mail.gmail.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Mon, 2 Mar 2026 11:28:55 -0500
X-Gmail-Original-Message-ID: <CAJ-ks9nvHUx+qHACnYjOM-BN6F8WgyZC3zMwGdywRfpQEb5kVA@mail.gmail.com>
X-Gm-Features: AaiRm53u8FUxamHR_boStthY1CgbumpReSSF-7qWvE6DWxMwfd_Xq6c4zIU3isI
Message-ID: <CAJ-ks9nvHUx+qHACnYjOM-BN6F8WgyZC3zMwGdywRfpQEb5kVA@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: generate_rust_analyzer.py: avoid FD leak
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Fiona Behrens <me@kloenk.dev>, 
	Boris-Chengbiao Zhou <bobo1239@web.de>, Kees Cook <kees@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 24D9D1DCE3B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222644-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,protonmail.com,google.com,umich.edu,kloenk.dev,web.de,vger.kernel.org,collabora.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamird@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,collabora.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,kloenk.dev:email,msgid.link:url,umich.edu:email,garyguo.net:email]
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 11:46=E2=80=AFAM Tamir Duberstein <tamird@kernel.or=
g> wrote:
>
> On Tue, Jan 27, 2026 at 11:41=E2=80=AFAM Gary Guo <gary@garyguo.net> wrot=
e:
> >
> > On Tue Jan 27, 2026 at 4:35 PM GMT, Tamir Duberstein wrote:
> > > Use `pathlib.Path.read_text()` to avoid leaking file descriptors.
> > >
> > > Fixes: 8c4555ccc55c ("scripts: add `generate_rust_analyzer.py`")
> > > Cc: stable@vger.kernel.org
> > > Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> > > Reviewed-by: Fiona Behrens <me@kloenk.dev>
> > > Reviewed-by: Trevor Gross <tmgross@umich.edu>
> > > Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> > > ---
> > > Changes in v2:
> > > - Use pathlib.Path.read_text. (Levi Zim)
> > > - Drop errant Tested-by tag. (Miguel Ojeda)
> > > - Link to v1: https://patch.msgid.link/20260122-rust-analyzer-fd-leak=
-v1-1-945577813b20@kernel.org
> > > ---
> > >  scripts/generate_rust_analyzer.py | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rus=
t_analyzer.py
> > > index 3b645da90092..152bd3705303 100755
> > > --- a/scripts/generate_rust_analyzer.py
> > > +++ b/scripts/generate_rust_analyzer.py
> > > @@ -190,9 +190,10 @@ def generate_crates(srctree, objtree, sysroot_sr=
c, external_src, cfgs, core_edit
> > >
> > >      def is_root_crate(build_file, target):
> > >          try:
> > > -            return f"{target}.o" in open(build_file).read()
> > > +            contents =3D build_file.read_text()
> >
> > Couldn't this just be
> >
> >     return f"{target.o}" in build_file.read_text()
> >
> > ?
>
> Yes, of course. I chose this form to be just a bit more explicit about
> exception handling.

Applied to `rust-analyzer-next`. Thanks all.

