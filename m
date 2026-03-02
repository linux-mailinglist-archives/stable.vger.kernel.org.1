Return-Path: <stable+bounces-222643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOGBKv69pWn8FQAAu9opvQ
	(envelope-from <stable+bounces-222643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 17:42:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EA01DD152
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 17:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E32F7303B7C8
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD653E5576;
	Mon,  2 Mar 2026 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9h+xb8e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EDC32AAA0
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468745; cv=none; b=jlsa8hEuTppBirP4l2OtwKgo/j5eZ8HsL8mQ1kS+HiptNi/ewf82PkpO+1XlzoymuCvuuja5PcMEpRM8XeVe9Oj6URav96Ri3acRTZ4+QnmpseD5iOy9VkkTG/LiYuoI4QxVaFXIVFtDCx4GUq9ZvG8hhRQgOCAn2c/o1jVRCpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468745; c=relaxed/simple;
	bh=Eb8a6VSy1LD+wZus7oxbv1V7UbuB13SEtCAWl8sK5Rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPJlf6I4A+pyzRIjIPv+B/zGsdbOkJY4zsmG9KVhiQSslxMg8+Z4kD2ypcHCU7VqC6srNjC0FOE34a7/ImTxzV/1+EEyvb1xTh83suoy3O5M5BMyMgBjwSZ/eejO9Ce+5doqtdILzwBVzWlTd2s0aBcubwR/AWtTC3NJAV+DuHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9h+xb8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A67C2BCB6
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772468745;
	bh=Eb8a6VSy1LD+wZus7oxbv1V7UbuB13SEtCAWl8sK5Rs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k9h+xb8eJhYENAoTxdOjfdmmT5H8l08A7yTozBIYdAfg9/IVHIOfww1qt7UzTA1ep
	 njDJns/J5lsGxvetLBbnj6Gfmayq5t0C0zwSWuKySxd87dvKvuI81LqVbUPtaBvOOp
	 EaYfIFzWHyZpMH17thQAn72OHw66NNN8fPzcO2saMaahPMFiTr5X3ssXVoX6cs6gUQ
	 tleo3PR7XdglI4fMLyOdW1uBtpV7EBJeevobhh9OVqa77yUiRxhUUPhOujkuN4kx9P
	 aCC0XlBTB9g1Fc3Qiuyazakt28XPdiHYlyH3dx5RsMHHE6IzDjS7TqHvHTQzr4kRt/
	 i2wiQ6MwWvMgQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-389fa352b0eso62320991fa.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 08:25:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9xcU5qbIpgBxYSWnS3yRI9BtC+ctcFB3EIs0z0VQ2lYl8j9YVrzHkwfaGm4N42dOZHKl0nq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyblWsTFVhqkyYVoaDL6PvknJJng7VrSF4HL6d/36l3AJw2g2zZ
	VIp/BngsrGnGx8bV16NmGiYJSgqOlkGG+CVmE+mY7rGYSIk2MpmaSmrTyz1nCcZQIGwwX+i0A1P
	9JTCDR8v6FcfwWk67K+ug/H/jpnjqRkM=
X-Received: by 2002:a2e:a541:0:b0:38a:27e:b91b with SMTP id
 38308e7fff4ca-38a027ebc18mr98604811fa.30.1772468743960; Mon, 02 Mar 2026
 08:25:43 -0800 (PST)
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
 <CAJ-ks9nMHtAaLc_LHOWqa_hTRqVcBNpGsaC49VFh2O+_3AoY+A@mail.gmail.com>
 <CANiq72m43pEweeWdg0qiGH8Yq6MyMJnFYsxhfYHeZu6LPxFPUQ@mail.gmail.com> <CAJ-ks9kk_zqO-7JiaWGPP8+EOsC_iutGEOW7hZtmKTF6W4oh7w@mail.gmail.com>
In-Reply-To: <CAJ-ks9kk_zqO-7JiaWGPP8+EOsC_iutGEOW7hZtmKTF6W4oh7w@mail.gmail.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Mon, 2 Mar 2026 11:25:06 -0500
X-Gmail-Original-Message-ID: <CAJ-ks9=uZLf=n9ascyU6pEr47A4mPRF-GGuJbFKkCSiC6rnQeg@mail.gmail.com>
X-Gm-Features: AaiRm50sKf-ZskhYVnsfYIbvDoXSFDPEzRiFUURdb9O4ScNGGcq5XD0_a7AS2rE
Message-ID: <CAJ-ks9=uZLf=n9ascyU6pEr47A4mPRF-GGuJbFKkCSiC6rnQeg@mail.gmail.com>
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
X-Rspamd-Queue-Id: F1EA01DD152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222643-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[collabora.com,kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org,kloenk.dev];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamird@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 3:25=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> On Fri, Jan 30, 2026 at 3:23=E2=80=AFPM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Fri, Jan 30, 2026 at 9:15=E2=80=AFPM Tamir Duberstein <tamird@kernel=
.org> wrote:
> > >
> > > Applied to rust-analyzer-next. Thanks all!
> >
> > Please see the other thread (and please reset the branch to e.g.
> > v6.19-rc7 for now -- we should avoid giving linux-next unneeded
> > conflicts).
>
> Ack, done.

This is now applied to `rust-analyzer-next` for real. Thanks all!

