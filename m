Return-Path: <stable+bounces-211864-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIKFMCDseGkCuAEAu9opvQ
	(envelope-from <stable+bounces-211864-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:47:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAF097ED2
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4A433012CAF
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758B9361657;
	Tue, 27 Jan 2026 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlGJ2yGW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700035F8A1
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769532442; cv=none; b=rI30HDyOujRqK0tdaHht0V2YIGSnKuNSzOimA0GH2wwei0nB1SDAh/BeVx8KGW52f7INyHP73CAuRhK4RQhppBZnhF/wRQ6UnX46QM7vpyU7OV9dWMPYGcaKuNP//IZ5U6NlBT2pNnxZwzZ9ymXrno8kZQd2bQXu/wmszrftw3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769532442; c=relaxed/simple;
	bh=Dn+FGftJrugUUlu2nkUafFid8rSUEu4lJqfhzEDlOMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7TqA272ybbjPnKa8A/zE5z1e6edyAqTri9OxIU6cDRYqaMUxzlstpLhL6+JdKyEDOPvFyzaMPNOMUFT/2fHckDz2EM57mFZ+WLQDxzqxiBHKVW+BbCG3YocNHjcSkf4ZG16O4+ol7uw36FhZP5ZnyGnapuVNLFaIL/GQUSqKTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlGJ2yGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05469C2BCB5
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 16:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769532442;
	bh=Dn+FGftJrugUUlu2nkUafFid8rSUEu4lJqfhzEDlOMY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PlGJ2yGWFVL5NQwJSgBHO16hmp4imtb3BBrz6Qut0NxOaGsPUDUuFgVF9EGn3nFpy
	 ZpPSuxd/KnWblueB1SeHX5xRsIja1lQVwYtc+5ShfRjlwWL4x4TK0i+3VkU7GXRtMB
	 hMHKIdKD66qzCdr633fux1fjS4TQSMUJo9BiL4rauZoXs2Qpobfyy6geMmpv4SF9U0
	 3LVmsSEB6enCdoqDjdqM4ex5ObEiDu+f4OQaJ7WdH+ZdDHjQVDCvR0WWETUmaAcm+q
	 lFrgLP065ZW8IgdIs5xUHWFmAVtnqdMiIsVr73B0bauwez+8iNMDj9mPwn91BcFUlm
	 zsKmgGCrH69FQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-385c23b88e8so59732811fa.3
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 08:47:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEy25D2bRNnbSFdE09ex2+7YIaW/FhZGSB7d6jSk0IKEgG7Y6IhjF8TdFnDNwb6p6OBudZO44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtc2IUaIV/MRwDtcSJ6u+Un+hPTWvC67KxZ66mGxPQDUS3wnUg
	8jNk+jM/4euk13rVXpzVyWj0wH/MxSDSg5o2efw/PJpgLcfBKIFiDUtpnF8W8ErUf4aD8LOnr3G
	K1J56cqM9Jmy30vXX+fQM7u9aZIGkwvk=
X-Received: by 2002:a2e:a581:0:b0:385:9b50:91a2 with SMTP id
 38308e7fff4ca-3861c832ac5mr10143091fa.10.1769532440619; Tue, 27 Jan 2026
 08:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-rust-analyzer-fd-leak-v2-1-1bb55b9b6822@kernel.org> <DFZIS0QDDD56.1ZB0WZUXPR5IZ@garyguo.net>
In-Reply-To: <DFZIS0QDDD56.1ZB0WZUXPR5IZ@garyguo.net>
From: Tamir Duberstein <tamird@kernel.org>
Date: Tue, 27 Jan 2026 11:46:44 -0500
X-Gmail-Original-Message-ID: <CAJ-ks9=hKVVa9UXFXx-aiqba7U0UHQChf-5pf1d=TdYrtC11Yw@mail.gmail.com>
X-Gm-Features: AZwV_QgeoGbfCOU3jUEvobmD0YCHd7Aj6bunTM3WiQXjl37fWCLVd3-CqRgroW4
Message-ID: <CAJ-ks9=hKVVa9UXFXx-aiqba7U0UHQChf-5pf1d=TdYrtC11Yw@mail.gmail.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211864-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,mail.gmail.com:mid,umich.edu:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,garyguo.net:email,msgid.link:url,kloenk.dev:email]
X-Rspamd-Queue-Id: 3FAF097ED2
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 11:41=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> On Tue Jan 27, 2026 at 4:35 PM GMT, Tamir Duberstein wrote:
> > Use `pathlib.Path.read_text()` to avoid leaking file descriptors.
> >
> > Fixes: 8c4555ccc55c ("scripts: add `generate_rust_analyzer.py`")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Reviewed-by: Fiona Behrens <me@kloenk.dev>
> > Reviewed-by: Trevor Gross <tmgross@umich.edu>
> > Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> > ---
> > Changes in v2:
> > - Use pathlib.Path.read_text. (Levi Zim)
> > - Drop errant Tested-by tag. (Miguel Ojeda)
> > - Link to v1: https://patch.msgid.link/20260122-rust-analyzer-fd-leak-v=
1-1-945577813b20@kernel.org
> > ---
> >  scripts/generate_rust_analyzer.py | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_=
analyzer.py
> > index 3b645da90092..152bd3705303 100755
> > --- a/scripts/generate_rust_analyzer.py
> > +++ b/scripts/generate_rust_analyzer.py
> > @@ -190,9 +190,10 @@ def generate_crates(srctree, objtree, sysroot_src,=
 external_src, cfgs, core_edit
> >
> >      def is_root_crate(build_file, target):
> >          try:
> > -            return f"{target}.o" in open(build_file).read()
> > +            contents =3D build_file.read_text()
>
> Couldn't this just be
>
>     return f"{target.o}" in build_file.read_text()
>
> ?

Yes, of course. I chose this form to be just a bit more explicit about
exception handling.

