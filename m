Return-Path: <stable+bounces-211875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNAbEwnxeGkCuAEAu9opvQ
	(envelope-from <stable+bounces-211875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 18:08:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 025B098322
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 18:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D711D301750E
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E93363C76;
	Tue, 27 Jan 2026 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlH+C4N1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55169363C5F
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533684; cv=none; b=rKj/RffuSBZNNDoLuBNlBc1gZhykpzbL8NFijLDxjhNymfw83sUtrAnhOQawnYIlxxH69c76russYyyWf47NNVjm6Oszt4hMpPUxjvPiuFdfxHqRjbw+EzIebkNyzebTeGTsxhS+6LXLpBOqXelm4BxXi6/zqstQtM3BO5s06Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533684; c=relaxed/simple;
	bh=Ejtz6CIjbRNKEdV0uomOsNBcHYybs/Hzdma07BXPRQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W29Txdhql4qgybe8Ii9J26ke1QAkRyWA3+6lPmhPfZKkV3shfPx84lbkhG1PtLuU/nceumwKjGut4jWzy/KPxnQnp3m9pqbZYfT1ATChzNGy9nKef0r29PsU+KqY8cxegbuBU1tsX6Oy85NFcCGpLtd6c77zKHCZm67o1UiLBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlH+C4N1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78EDC16AAE
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 17:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769533683;
	bh=Ejtz6CIjbRNKEdV0uomOsNBcHYybs/Hzdma07BXPRQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dlH+C4N12DQ4uXL0P3Y9wBB/khHYwxZ9d5OQ5JlWFhKDT5i7IpuvXkQbvUUES01u0
	 8ITxf9Rg2dqz2fzTfIfKZxe9jqxkuDo/gy9Z6Y7rANOaFAx3OOD0dQFhK3uJvpsaRh
	 k9bMkth2wuFrUJVySDKJFQZJ7aFy2V/zH3UhQ4FtA9Y7gWvC+hCXquzQjXjpPK0Qxl
	 Z94ZQP+kedgR3OkovaCY8RtjMv084Ip8qoXtY+g5uDv+l/Sn4QrltS3lV4T2JEmp8V
	 rfGGGPotDgoesfTBGs7l7AwRB2tzme7RXi4AU4HUO/lQ0ZBuU1b6dmw5hzB4zvk8V7
	 pEw2QSxKZea8g==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38319cbc8fbso51489521fa.1
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 09:08:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/tlcfW26Zrzyj2zJJYkHoulqz8s3bgqn7tWN3xpaz/n1F7Sxj3slw8jMOTvDucSH/TFuP3hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc3rM+5EMsmAEUGW1g4+wazZhROL+/1ASaMzqXoFblHLnPXUT7
	AjsNEHi1aUPwqqfW0fgiO0w8VDoCdL0hrA0hj4mEBv2ocIRHQGPCoN4KsVSlzDWpCjpuWs8U+xl
	bERm1qmjE//btUnxYJPfvt6vAZm2DfCc=
X-Received: by 2002:a05:651c:f09:b0:385:fccd:70e5 with SMTP id
 38308e7fff4ca-3861c91f541mr10369101fa.28.1769533682616; Tue, 27 Jan 2026
 09:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122-rust-analyzer-scripts-v1-1-ff6ba278170e@kernel.org>
 <CANiq72kkxS9ACvR52q03AN+WdFV96cK+tvejnnDXKZTKuKZH9g@mail.gmail.com>
 <CAJ-ks9kiWZr=82sztLfYqtp-fvsQ2QTgTYqNg5hSsZMKCsvjZA@mail.gmail.com> <CANiq72m8Bx=1s1+_OFxE=PFOjKrtuh_uhsomTA9VwQ4=Fz4d0g@mail.gmail.com>
In-Reply-To: <CANiq72m8Bx=1s1+_OFxE=PFOjKrtuh_uhsomTA9VwQ4=Fz4d0g@mail.gmail.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Tue, 27 Jan 2026 12:07:26 -0500
X-Gmail-Original-Message-ID: <CAJ-ks9=zWmVnspkfCqPH=+-_qZ0YZVyNrs2xMvRRvEmr-mNMcQ@mail.gmail.com>
X-Gm-Features: AZwV_QhthezCoKKdVwlCKzBvyCSCtd-Kb6xYsa03jBnKOyQfKq31mRTrtoDCNdM
Message-ID: <CAJ-ks9=zWmVnspkfCqPH=+-_qZ0YZVyNrs2xMvRRvEmr-mNMcQ@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-211875-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 025B098322
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 10:13=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Jan 27, 2026 at 2:53=E2=80=AFPM Tamir Duberstein <tamird@kernel.o=
rg> wrote:
> >
> > It depends on your perspective - I framed it as a fix of the commit
> > that added the first script because that script was added without RA
> > support. What do you think?
>
> Yeah, I see.
>
> So, on the implementation side, I don't think we expected scripts to
> work at all, which is why it sounds to me like a feature (neither the
> linked commit nor the one that added rust-analyzer overall support
> mentions it that I can see, though it doesn't say otherwise either).
>
> But perhaps someone out there expected it to actually work and thus
> may think of it as a fix. I don't recall someone asking for it, but I
> haven't checked. Perhaps someone would, when we use more and more Rust
> scripts.
>
> Now, for the backport part, according to the official rules, I think
> it wouldn't fit. But those rules are often relaxed and who knows what
> companies out there doing out-of-tree work on top of LTS kernels
> want... (Commits can be submitted there even if they are not fixes, by
> the way).

Thanks for the context. In that case I'll keep it as a fix and take it
through rust-analyzer-next with the backport tags since I expect it to
apply cleanly.

Cheers,
Tamir

