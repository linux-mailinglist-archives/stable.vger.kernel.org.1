Return-Path: <stable+bounces-211815-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PKHEAjAeGn6sgEAu9opvQ
	(envelope-from <stable+bounces-211815-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:39:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4994594FF5
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82408300460D
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD83359FB6;
	Tue, 27 Jan 2026 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FATTbEIb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEA8359F90
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521148; cv=none; b=UX44+dyjGCEPB4rfVOC2suu3OG1TrZBRJOZ4lULuPAByBlWUjevIT7GP9/sVioa9XqQl8djd3GcrtWUAmr9IZUmMBOnlE2SnhfISl7sDwOQTQcU16zsx5MZA2SnURDM03DvX2MZcOxZKcVKsBk0aEF9JsYhfPyul83bug5Y7tQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521148; c=relaxed/simple;
	bh=BXBAVxyWkRwktqFoA1SWEnN3RAb2r/Avzdd8ijNHOwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsAAK3XGK9kQAfuLJ2P/e4poByvffom97WKQud/4t4Df3DRAXMPewROph3ttnv3w6O7SSYn/olVKETxQyUVTM4lcXVrr8bPjYgWxbZzjy0KZrl2OAefHXubhk9VS5m6OsmY76DScc9sxprswxQHkY9GbD1h3Ga2vlX/xjUt5530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FATTbEIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008C4C4AF0D
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769521148;
	bh=BXBAVxyWkRwktqFoA1SWEnN3RAb2r/Avzdd8ijNHOwY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FATTbEIbOuaSOo2GCX0oiETbRVNZWxMom2Z1NFsB4zFmiPDnERHM+5r74V3Su1zs9
	 qJ0f0dDPxubMqVxS40TkdWm5Zn2AzfLo5KXmhNdB5e8i6pOQ8jFbSUMjBlcSW1m1C1
	 kA2KO0ogPRn1xhgdy5tGTIxq3VcFC22V5GP/syYwnF8Wd3N+XdEKNjLo6C6Bf/gRO1
	 LU2N7FrV/JUwfDfYxjKmFDOtyhD2k9aWnhn0FxgQpmTMz7wzsf7kRKllbTkgoTmqXd
	 ijWGHMdtGCNpCHPpO82/GYKGZQiFsP+BAwhN/ISGSD1pQD9UYUbnW9pSQD75vESV3c
	 n8kG5shJUlNpA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59dd7bfeb8aso6990928e87.0
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 05:39:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDSKe5LUSbL4z8+O/r/VSboifTeuzNJIiA7ZHv/OsoKBrnUAxqOQND1byfloGwBznpaDcBx0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5mG/zm8GyY46WDcpsrN9ebaAPdPVaua8z+qcS5M0W9NbOFcp
	CELaOnT98BZE9Y209QdXO9XNou3YodH/hc+18Ao7CCo61SXWldVvAo3eUBgtnZQ465G3DzOpwjp
	vYoCEjhba+aDpz8FD7myhjtVvCDWvElU=
X-Received: by 2002:ac2:4f07:0:b0:59d:f475:40a5 with SMTP id
 2adb3069b0e04-59e0412c67cmr807071e87.28.1769521146651; Tue, 27 Jan 2026
 05:39:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122-rust-analyzer-fd-leak-v1-1-945577813b20@kernel.org>
 <CANiq72=+2s48M5imZ7tZj-0SN==f_mLmw_2cWfQYKtBhD1ROCA@mail.gmail.com> <b07a1e07-9265-4b77-9665-0bfae9b506d3@kxxt.dev>
In-Reply-To: <b07a1e07-9265-4b77-9665-0bfae9b506d3@kxxt.dev>
From: Tamir Duberstein <tamird@kernel.org>
Date: Tue, 27 Jan 2026 08:38:30 -0500
X-Gmail-Original-Message-ID: <CAJ-ks9k92BRP=3-LL-d1YZzROE0ayEH7s5ptf+xPcPYBnb-7uA@mail.gmail.com>
X-Gm-Features: AZwV_QhNhaJEiotjq3ZQI93lwlmWQGbyXYdpdDwMCzFfNiHMhq06xrewGGK3FzI
Message-ID: <CAJ-ks9k92BRP=3-LL-d1YZzROE0ayEH7s5ptf+xPcPYBnb-7uA@mail.gmail.com>
Subject: Re: [PATCH] scripts: generate_rust_analyzer.py: avoid FD leak
To: Levi Zim <i@kxxt.dev>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boris-Chengbiao Zhou <bobo1239@web.de>, Kees Cook <kees@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211815-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,web.de,vger.kernel.org,collabora.com,kloenk.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kxxt.dev:email,mail.gmail.com:mid,python.org:url]
X-Rspamd-Queue-Id: 4994594FF5
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 8:10=E2=80=AFAM Levi Zim <i@kxxt.dev> wrote:
>
>
> On 1/26/26 10:09 AM, Miguel Ojeda wrote:
> > On Thu, Jan 22, 2026 at 5:44=E2=80=AFPM Tamir Duberstein <tamird@kernel=
.org> wrote:
> >>
> >> Use a context manager to avoid leaking file descriptors.
> >
> > This may have been intentionally written like that for simplicity,
> > since I think CPython closes them immediately in practice even if it
> > does not guarantee it (and I think the kernel may be assuming CPython
> > given the version requirement?).
>
> Path.read_text from pathlib would be a better choice for keeping the simp=
licity
> while ensuring the file is closed.
>
> https://docs.python.org/3/library/pathlib.html#pathlib.Path.read_text

Thanks, I thought this would change semantics because `open` would
default to binary, but it defaults to text. I'll use read_text in v2.

>
> Best regards,
> Levi
>
> > Nevertheless, it is better to be explicit and proper, but it is not
> > urgent, so I would say let's put this in rust-analyzer after the merge
> > window even if you end up considering it a fix.
> >
> > Like in the other one, I don't see the Tested-by from Daniel, so I
> > would suggest taking the chance to double-check that meanwhile too.
> >
> > Thanks!
> >
> > Cheers,
> > Miguel
> >
>

