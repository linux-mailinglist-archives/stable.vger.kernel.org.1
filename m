Return-Path: <stable+bounces-211507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM0OBAbbdmnNXwEAu9opvQ
	(envelope-from <stable+bounces-211507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 04:09:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A90CA839B1
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 04:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4A4C300CC83
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 03:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCB229993F;
	Mon, 26 Jan 2026 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdZbVd3k"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2026A1CF8B
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769396975; cv=pass; b=s1lr74JoZShIKQFXEY9qC41qbmSQ3M8WPhB7IxODDvuaSE7OGkoqLxzhY5K+xIsaQ2XREQV5/CAHo49HQ6igiOaqJlSZ4o7Y8XASYviHmdsR02ZjVzA9bFFgDs+S4hJaQ1LANJHuRxSmemtejO0h25/Rsh2gLCT/Hj5HlZ8dmn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769396975; c=relaxed/simple;
	bh=K6DDw0DnPj7mvHPYtwH3BVqEUAIu+jK9lefxwZGtH7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRUcBnnz++HsmqzTEIKCW9EyKB7rZWrHXavSa4L6fRt3eXseQEProcLHuKi63MY8D5FaJgJb9MQ3I4T2AapRvTP8aJprT5m2XLI5WvGi0/EGsm0SA1W2l61rqcHGyWoZ26kSjKciaWUounwe7w7ggyNAIjxSckJAo5TSSAv5t7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdZbVd3k; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b7030e2e5fso209208eec.1
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 19:09:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769396972; cv=none;
        d=google.com; s=arc-20240605;
        b=AYnp8iGD2bOY8vZ5h4garNMZBQnM1j/Dt1lljrBDP0l1IykYO4CNYT+wk9fk26xqnB
         Pm4mS6X4uIasazEB1VUUd3sotJHi5cK6tuK7ZdPGgelqPaTjHpLaB8hmb0CbjcrWIasf
         GIiVokiSmV+FpEo9V3u6LHcGkU3NnuFCKBz1rYtwJqUsDv5ejV5MJMLeTTjSLh7LPkJj
         Lan4LD1Xe7jU2/qo+L2m8HNB4XrfdHcf8K1Y21va1F0AWSJOhWRx1NnOtg15+j6ETXnt
         rV/fOYe/4aiQY84pNjZgPGdTQ/jD5DtKZbT2Cpvh3exsYw1Rd7X+NJ2UiIYJwxXo2mgp
         STHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R1fUeALujy44mUEAZiAhmpCspOLrTsCLnopvPc5dHxI=;
        fh=qN7/LN/TeNHtZ+6wGz9zlcehsEBHiCHkCv2jlUmIfOo=;
        b=W9ZZoExWVkNxFuaZih58jhXVHmkG7GH1U1brAuZBgLioS06B1ctr93PmAyHgHfuu1r
         VhILh5l9dWfkSarM+Cw4sLfaGdvayZz8Ed8kvJIcX6kiGl+chIiLYsHJRuc/RMhNiN6Q
         POmAuouEDHbTTcqXaUVWjDI7YtgUF0FiFZYyN07VTn4GgTk8h0iQPJHbUV0WocvksdvL
         nK9IQ7BjhLtyvpDNdeNy5BSxYTeiN9M4bBcaHwx0w7dJSAjPG7n1GyWZklVcR+fl709U
         TBB/XDpicmO+8C8WWrHT5i396QzP8DO4oG/JEppPUB22c1/9DuSK/OtsVVOa5qOyAh58
         PGEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769396972; x=1770001772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1fUeALujy44mUEAZiAhmpCspOLrTsCLnopvPc5dHxI=;
        b=cdZbVd3kaWd0ioVrLpJg2AjRqA4iheKh6CQdowlBMgUxrPIb+JHiflLFfK7I3LbkVQ
         kyuFCuZXMbDUmyHIsZErJzMJbgyBNyNEvxp1Dhj0v7ZlsbjzndLJfY/HSnV8Q4YSsl91
         i0JsjgLnbjxsrSCgQabzmVaLZxeek5A0w0ddmtMVofTS30gDe/fxCJ6WfFETyX8PDMGu
         Y7iQ6icOSD7kARNQogpjhL+RoV2ceo4c2Qt4iJOPtFZudYeKqpMt0fnQ2r4Np7DLq1dv
         Kz2/6M9rlvEUA9sHLLf0xnNSUc879p8KCy/2klrwu4dwTmREYGlxGeBohyMP/3PoFTAA
         a9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769396972; x=1770001772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R1fUeALujy44mUEAZiAhmpCspOLrTsCLnopvPc5dHxI=;
        b=MgHSR1JWf2NEF03QJaoWN/sjYIYv3hPEFCewpyLVu4vTU9sPngx3ln93Q/2EIaQ8Fz
         RP9+KeDxAqDUF5GMpjuG+nbdEuh8uQs3tHbAS3vNqfbaFZlDeLJr5iifj61EFiKENOGu
         BeS5UG327UuZzupKZDLsDn8ZcrHf1CYU8Esj1ps66dC2ie2cZFaHEGgzZNMVBzd3SpSh
         T5KjnB7xyjQB0Ds25REAghcwLYk1qvCR/vgnrJ+LeUZGwA4anXBIlQCeuZMNGwah5hLz
         VRzpsdAZbFSN5o4CEY8+UOf54FPePREYsMYf3AIU0yq6M9RHTg7n7ysIV7IhxNl2Uq15
         5DFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqkGEsxXxNP5saVn9LC7ZiVYsIPvh9Eg9mTXrEDIWMYxRmxzBq7Caf1zAmSbQNKx+Mh9756HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtIxLhQtp+hIx9zRNINOHRoFhtUabrUBHRU63+hMB57xUS6H+h
	SykqCXrLdXDUChzmzyp0OmPJGjeh3Ht2f/6QMLw1j8HLjN6PTsrYqGdMeVVmwBBAipft0mZKk/D
	Qe6wY8Ojyx5gUX98F8xkbmoAj0GodyxY=
X-Gm-Gg: AZuq6aICJMUyeR+49jk1iuTj8dYXRkeyl21DnobpQpHpyxyXQiF8iVQlRml+++2hmKj
	k+IsL1cPwkctGhSJEblZjEz3WHcv/DxzWmcc0rUE6KhDXgX8dJ2rHvWNfczA6w1cDrE5doUIGcl
	tuZlJ+wUEqziCZ35RQwXq6w7tCi76USHbD2au7PEfV8siIIe95X7QSJ2TzigescdnZZguNLsmau
	n3Qc24MuwIrjb219GRXvFUIfqz3T60diY8Y17c5Rjf0hPYrVKw25mCyKT5vyk4lRPD9Upai46h1
	/Z79XwPxL7Ty3OkEXKh7c2Bpc+uHf9l6ttWzO8D9YxYl10Ew3//LHCr3ZtmjKMsHC5KTjWQpSxP
	7XoADdMshVhkp
X-Received: by 2002:a05:693c:2c0c:b0:2b7:3678:2d1a with SMTP id
 5a478bee46e88-2b7645253a2mr790352eec.6.1769396972164; Sun, 25 Jan 2026
 19:09:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123233432.22703-1-ojeda@kernel.org>
In-Reply-To: <20260123233432.22703-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Jan 2026 04:09:19 +0100
X-Gm-Features: AZwV_QhyJlwqjnxEjcnWt33KyJTo5YK6Z1Wag5jcoj96I5FuwtWe1hRjBgDDTd8
Message-ID: <CANiq72mQEeW4dN0_QvB1=F2cnOe7=56q9mG=y+g1CznASG32xA@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: atomic: Provide stub for `rusttest` 32-bit hosts
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211507-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,gmail.com,arm.com,garyguo.net,vger.kernel.org,protonmail.com,google.com,umich.edu];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A90CA839B1
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 12:35=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> For arm32, on a x86_64 builder, running the `rusttest` target yields:
>
>     error[E0080]: evaluation of constant value failed
>       --> rust/kernel/static_assert.rs:37:23
>        |
>     37 |         const _: () =3D ::core::assert!($condition $(,$arg)?);
>        |                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ the =
evaluated program panicked at 'assertion failed: size_of::<isize>() =3D=3D =
size_of::<isize_atomic_repr>()', rust/kernel/sync/atomic/predefine.rs:68:1
>        |
>       ::: rust/kernel/sync/atomic/predefine.rs:68:1
>        |
>     68 | static_assert!(size_of::<isize>() =3D=3D size_of::<isize_atomic_=
repr>());
>        | ----------------------------------------------------------------=
---- in this macro invocation
>        |
>        =3D note: this error originates in the macro `::core::assert` whic=
h comes from the expansion of the macro `static_assert` (in Nightly builds,=
 run with -Z macro-backtrace for more info)
>
> The reason is that `rusttest` runs on the host, so for e.g. a x86_64
> builder `isize` is 64 bits but it is not a `CONFIG_64BIT` build.
>
> Fix it by providing a stub for `rusttest` as usual.
>
> Fixes: 84c6d36bcaf9 ("rust: sync: atomic: Add Atomic<{usize,isize}>")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes`-- thanks everyone!

Cheers,
Miguel

