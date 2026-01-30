Return-Path: <stable+bounces-212907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJFtHe8TfWnCQAIAu9opvQ
	(envelope-from <stable+bounces-212907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 21:26:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE24CBE665
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 21:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADE10301BC37
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 20:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E84352921;
	Fri, 30 Jan 2026 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQMk6z1O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CBF33AD9F
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769804774; cv=none; b=NC7rauRzu4nBdp3Kn9ZQmwzZ2F/7KFTN1QbORv+/3n7iq+Z3W0PY2lrgU9WR6NwJvTwGEQumjrrwlKbeVzdHYAvuYoFQvdlTHNJdS0QDIVfRMi92XUTuu5R86XUZ0kDztoOr/VV1EHnSR9dT++wIQYm7++n9x1CKsSvzNeRNMCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769804774; c=relaxed/simple;
	bh=h5ewnyvlu0xsde8dH+kzKb4XaSR0fvFyJX/BP9nEfqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEMkRsBf6O4pztgGMmx5KI61qUbT/fC3pCgJ8FawfHtVvOlUiKoIVwUQCZIhV4ZmMltxcSIs/TG955mtQUV5bMNB7L/Njs736Z2SJ1iIX9QK7vjOp37AUHPYylDKImAGeQ6sW3byke+I4E03S0I47PyTZpbHr4FRZtx/alVV8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQMk6z1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46897C4AF11
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 20:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769804774;
	bh=h5ewnyvlu0xsde8dH+kzKb4XaSR0fvFyJX/BP9nEfqA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TQMk6z1OIwulNZhMPl9bEDldBgeMbhYaWhUQrD6wtJgjyvKbrrY6jFKW0HNq3d0PF
	 iAO6Ngt4LIA/60zH3UZ9UY327PJX0qfGgmdZFc5z/QFVbnEBLg0Ao1LDAkyaA3fsQK
	 Fj5GfGJNE32NRB3mCs1zKwyKajA+ZZoxhlG5AC4GIwd6SoSlfhyJt2FPqcda5oB5qS
	 RAMtJV/ocerj75Nj2Fiui/6u07yjbyP7XghbMvM0hw+uEMt7bb/yY5aQ7epDmvDcde
	 CimZLw5dkF/i2TjxwJ12eC+sEn3QRe2hTw6OAQq9TON5z/QJZVW1QftbScH1U/uq1m
	 1fq45O9Jxpk4Q==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-385cfc572f1so26106411fa.3
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 12:26:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVpFmxZ+/9ollyZ+ES0jMr+ZFX1IZg4uKdFeHoB/GR7zw4BVC0Gnna3cE5n942rZbxtZKuxfBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd+UPBZeJ2UVj/Tle/4MFqAIEXiMkYnKmMBgTxiwZtHGHVL+wG
	XIMWWNR6J88V/HfPbCFagPSsuLMFd1Tc8Y+7HsdXuDr58pWT93UmJ0TKk+CH1Ya+0emXaM86NfD
	9mL+bdCj5mYeWWbjhAcef5hHfPprVd6Q=
X-Received: by 2002:a05:651c:547:b0:383:f7:1057 with SMTP id
 38308e7fff4ca-386466b3237mr14787081fa.44.1769804772887; Fri, 30 Jan 2026
 12:26:12 -0800 (PST)
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
 <CAJ-ks9=zWmVnspkfCqPH=+-_qZ0YZVyNrs2xMvRRvEmr-mNMcQ@mail.gmail.com>
 <CAJ-ks9nMHtAaLc_LHOWqa_hTRqVcBNpGsaC49VFh2O+_3AoY+A@mail.gmail.com> <CANiq72m43pEweeWdg0qiGH8Yq6MyMJnFYsxhfYHeZu6LPxFPUQ@mail.gmail.com>
In-Reply-To: <CANiq72m43pEweeWdg0qiGH8Yq6MyMJnFYsxhfYHeZu6LPxFPUQ@mail.gmail.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Fri, 30 Jan 2026 15:25:36 -0500
X-Gmail-Original-Message-ID: <CAJ-ks9kk_zqO-7JiaWGPP8+EOsC_iutGEOW7hZtmKTF6W4oh7w@mail.gmail.com>
X-Gm-Features: AZwV_QgBZ2E4czdZQN3pQDd7z8RjIjyj4ntoIpUiDXh9c7ieEVqekmu1Wm53-bg
Message-ID: <CAJ-ks9kk_zqO-7JiaWGPP8+EOsC_iutGEOW7hZtmKTF6W4oh7w@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212907-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE24CBE665
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 3:23=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Jan 30, 2026 at 9:15=E2=80=AFPM Tamir Duberstein <tamird@kernel.o=
rg> wrote:
> >
> > Applied to rust-analyzer-next. Thanks all!
>
> Please see the other thread (and please reset the branch to e.g.
> v6.19-rc7 for now -- we should avoid giving linux-next unneeded
> conflicts).

Ack, done.

