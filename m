Return-Path: <stable+bounces-195073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E986C6836C
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 09:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10D5B34BAF2
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 08:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786D930ACEA;
	Tue, 18 Nov 2025 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MdQbUO6M"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38915667D;
	Tue, 18 Nov 2025 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763454657; cv=none; b=iNAbQq2qBhi5oyp87gaSdtfPq2E7bMCgPP27yrjIOiHi6L2VMwAqu7OD91eW5v2oAVwJckYQbWYecjrZ50b09XX6/W71r9t/um9w05tRubMKSLfdf5Iwb0fTGPwZ3V+WJzgS/RKPEpErUEG8bTBD0lz7x9/ithYL3jRPQOCpG8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763454657; c=relaxed/simple;
	bh=OPUYOYkowFC02j4zkIAR5psWwDsFS1/rLP0eNPLfyHA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=imMqjyOxyZhdxmd121X5gFCWgktmEXAhnMjxOz35wm1v18sRrhQ9GTHmK6PlY49irP++fa0FgyK+HR/QTxPolWErv48lTSZ/JVi/dHLDwRY85Zc093UFaOypVDFMTUMZ8VnRRO0WjP46OsizsoDYEp7h/g18iUrSWvViZMrcJck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MdQbUO6M; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d9d9R1SBDz9tkJ;
	Tue, 18 Nov 2025 09:30:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763454651; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OPUYOYkowFC02j4zkIAR5psWwDsFS1/rLP0eNPLfyHA=;
	b=MdQbUO6MK/5vrvt0gLNgvKvkMCSgH0Gb22F50yNgjD14iYGg+sg3AA6QoxCV6hLrg9MmTd
	imTrAJtFftfJTDEBP+ztp1ikeWtibHY4EJYXDi5rk0PpZoQp24HZJsz0LrDGtzPhO8Xit+
	DIRgpWDhUtX+99UDfGsRFXeB0BKBXaTdXx9pkX3ssspghkb+k2kqbBdv14a0mOuD7mGpYG
	hDZgbwHGGQFvBZN6ziggXFRx19WZnwCz0WGNekD764oq0OLSFC5tGCCirqDXVS3ySAUDWr
	DvuHjcg4QD3XbGZCYwY4tmgexH1/YrtUtJY/mkOfa1UEgSRwyfvntZ16ViSfCA==
Message-ID: <4db9dae5f659512146bd441cf2edf5a4aca16b93.camel@mailbox.org>
Subject: Re: [PATCH v2] rust: list: Add unsafe for container_of
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Philipp Stanner
	 <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, Christian Schrefl
 <chrisi.schrefl@gmail.com>,  rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Date: Tue, 18 Nov 2025 09:30:45 +0100
In-Reply-To: <CANiq72md+0Lerj+kqr6QiU6ySR3XjRzmuBiLjkpWWieM72wyeQ@mail.gmail.com>
References: <20251118072833.196876-3-phasta@kernel.org>
	 <CANiq72md+0Lerj+kqr6QiU6ySR3XjRzmuBiLjkpWWieM72wyeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: gdss3euaazp9ahcbr9wno9q1ffb5a9r3
X-MBO-RS-ID: 8bf6f2026d62427ef6e

On Tue, 2025-11-18 at 09:20 +0100, Miguel Ojeda wrote:
> On Tue, Nov 18, 2025 at 8:29=E2=80=AFAM Philipp Stanner <phasta@kernel.or=
g> wrote:
> >=20
> > For unknown reasons, that problem was so far not visible and only gets
> > visible once one utilizes the list implementation from within the core
> > crate:
>=20
> What do you mean by "unknown reasons"? The reason is known -- please
> refer to my message in the other thread. It should be mentioned in the
> log, including the link to the compiler issue.

OK.

>=20
> Also, I assume you meant `kernel` crate, not `core`.
>=20
> > Cc: stable@vger.kernel.org=C2=A0# v6.17+
>=20
> No need to mention the kernel version if the Fixes tags implies it. In
> fact, it is more confusing, since it looks like there is a version
> where it should not be applied to.

It's absolutely common to provide it. If you feel better without it, I
can omit it, I guess.

>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 let container =3D $crate::container_of!(
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 let container =3D unsafe { $crate::container_of!(
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 links_field, $crate::li=
st::ListLinksSelfPtr<Self, $num>, inner
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 );
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ) };
>=20
> Unsafe blocks require `// SAFETY: ...` comments.

Ah, right. Overlooked that because the other section already has one.

>=20
> Also, please double-check if this is the formatting that `rustfmt` would =
use.

I ran rustfmt.


P.

