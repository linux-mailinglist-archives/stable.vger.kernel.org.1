Return-Path: <stable+bounces-224868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGcaIxrLsmlUPwAAu9opvQ
	(envelope-from <stable+bounces-224868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:18:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FAA2732B2
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 15:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2F363013FF4
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 14:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2B236BCDD;
	Thu, 12 Mar 2026 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZZlLvnj"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B3A367F58
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325043; cv=pass; b=qkzRuVUR2OTPaTbhpOB898pyPLnm1ZAlXWJs0AnqV355AXkbV1sp7Jw2+nP5arHo5fmfc40JIDEXkGlHlxh8WoHocCcwkBweldiiRAcv8yxrJTiXhtfQBmWUitUO2AUxbtdcmopw+RIH0TpTwJ5qMputxOZlF2Lw6cE+e3Gbo7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325043; c=relaxed/simple;
	bh=uNv6kIxa3sBonyIAZsWJ/1YYALDiUWo1uHouUO7Kot0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXUaY9df0AIdfwD9dDMPoqNOdGEb/D3mOl5HdpcxJzEakVX1w8UpZ8PMgOwiBND1GEdGZRNAF6Jj9pDkg4woqUFH/oX8d49d7IQY9TSQEjzZIMPoP9vlBoalww5Z8DgXEdm91wAV8eT5+32AlUdUL70S/jTr3f0Fk3HZCdAySzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZZlLvnj; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-128eb45835cso13771c88.1
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 07:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773325040; cv=none;
        d=google.com; s=arc-20240605;
        b=QnguI6sZMtSVPTsvUaUdjxNKO1tv5Q3gHleglk3+RznUDtcQzgTLeFQoAts9Er+ngx
         0RSKMRCiO2thyDbu92cm6RniUBfO1PT0dnVC5/G7b6wAFiOppTWUs/vUR3WCZiw1MfJ+
         F592UJDsXagPDoADRL1D0BCUsu05eZFAMI/c5FdmqixCwOVwulFJXCobWE6sL2AxoLyr
         D35pwKVr69gVW/+wp79/qjLtmULcx+1usBjWmi8g3Qd2YOvD86z1hs9oe9p7jWSq+rdw
         UiX2jXa59nwDsCfmW9BfLMYOmFxOD7nuX1Vzn7cYNWCxAQA+KC0BECxVPip01rN8akA/
         CpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vbPtKH2motvwMAB0mbkvP4G0RyN0OeH5dUu3v1J2yss=;
        fh=gwjEmsJd8/Zl03IlrzaR6S90PwrN08ugsqOp5NoNcY0=;
        b=K5rbnhxSb3lTgSICAWIw8xQrjzdtCeEaPrmuRQG3ONlytWe/lzG/TIVMNC7ExBvEin
         xWXO33yj5cJIbFzdKXZoZ/qaSUTqCKisdI6d4vqTEVnVNtaYOL7T2YUobqIn/tGoIjoU
         bqyMKXv7R7+v9QD7SRc/BJtq88mGHZzQHRgNhXH5qFq6F28xg8NKoEeuHGjCAKnWauz7
         elvdaL45wSl9oIGH2TaqIE05QG96xPRFzwYcr9sXVdewybwMLCGu0aZ1LlmJBvsWf7xO
         tE3n57Yk1EOoQMLh99aOcGTqKe5koIClk7tjiBwxDmgNEOUba3Ip5e6FJfj6zVCL02Hl
         nHXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773325040; x=1773929840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbPtKH2motvwMAB0mbkvP4G0RyN0OeH5dUu3v1J2yss=;
        b=kZZlLvnj5JpJvZTz/OpdlK7G2eRopSYkAUj5YLrcQMoaoaQIBQ6gF5rAcYzmVJN+6k
         hVAoz5quGRnrd5tEPIU3a+wFNOtdKi1H1g0h60eKElw+HLtLtrDurYQVpWlq5qMsqKAD
         cFfvTtD9xApIKpE39qnnmIq7ZemGewGZoBXfxer0Tw0Z/pDNaJm8RWl+On1O6PnW4103
         N8MrREuTpA/DpOAyYw+ziCa7jRW21oFJqGg0L3m6V2HwXoVDCStc5RYtanFWXdFRJQ64
         fjSKWOL4nP3TY8e2L27LCwdG1ZOZCC0gGvSoMODi8zs5CXuEFNGM1bQyntjS85VqsxCE
         jaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773325040; x=1773929840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vbPtKH2motvwMAB0mbkvP4G0RyN0OeH5dUu3v1J2yss=;
        b=ed/Pb0PYzOHQ7NLRMLyPeWCTuIf1J/p7cIXVWzw00cQzOdGY46bzJT4RIDKeI6Ep1i
         FYeKDE9lJUmdvpM40u22BkdbIfbDz1bF0B2xnW1EicllP16E6yVl8EZ+cWhosVnvixFX
         YK2QmhcE6xfNVhxcGyheAvUK64IZBw1u3LvtsTNZzi0/I7jMIz4CKQVohPwf4MBqNfnL
         8F2kESYFcbJ1jxjqmUnbTE7ZrrPOgm26eNVjcoqXa8kmGe8QMiTsjfF160eDt8wEEmOP
         BxDHnqFnrfwAMOnIX9KkEjJTro2kB6Q/cfv7Cd23IlZEYPo1QxTAIhfX+/BSZImRWkWG
         HyCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUun4TtetddDWwfpuISVhSJI3lU6yKXxacElT5JafPYn4rycq7PiBTkEBnsds8Qnz8BkpjldNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMyVym9gse8pJVBfgedksewag7q/5i10QliDhkf1oCIDu8jac8
	4raWp3hNBT9nahNJ85SQsc/asCpOi7cjExFLrWTvstL+WVstdt27uVgHRP+FWTeySfQXlxaVSjJ
	xcyq3KqA+MMX4MPoo8wzcFSlJfDNb7vA=
X-Gm-Gg: ATEYQzz3yWLnAwbe/3+Qgta4QM0aLYjCqJUsAYYf5J/PiM+Cov/qWGsChI7t9SUf5XL
	u+1/oOXQH537YUZcTPxYhNY2v67qTtwNbbYSFTBWx1eFzTZ5iOsIo8IbPhI3hRbm3P00d9tcbeB
	eNgGk/Nau/dTleQorAAm4szG6CrJNkL6PVjfe6qSa88PPsPr5uxPUdLDynhKFXbm2jvl4eaIMCM
	xBjBvF2ahfuqOJDAOdU9bmPQG02gvFeC10TUziz6lHqk3w2FPatzlpqeTylN9p6fDYqFE/oBgX/
	XsbMSoeQ2rOmESjHU2K4SQz7+W3DHTHgvDa1kBU+k7EeuHCf1qmV69p7WP+NMtyvmsoqYvhriKa
	fNRJ5lPO7uAcKu6JVUQgF2kM=
X-Received: by 2002:a05:7022:3f88:b0:11b:ad6a:6e39 with SMTP id
 a92af1059eb24-128ee50db45mr394830c88.5.1773325040019; Thu, 12 Mar 2026
 07:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312111014.74198-1-ojeda@kernel.org>
In-Reply-To: <20260312111014.74198-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Mar 2026 15:17:06 +0100
X-Gm-Features: AaiRm52IlgB3f2dqIvdLqxC0QGpjGXWHGqE4d9SxnSDtWii_yfdUEsYKET0WFVM
Message-ID: <CANiq72m=cYe8td_z1t-FLbmhwAaVLjUS1mvg3RS+J65onxzRAg@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: allow `unused_features`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224868-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87FAA2732B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 12:10=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Starting with the upcoming Rust 1.96.0 (to be released 2026-05-28),
> `rustc` introduces the new lint `unused_features` [1], which warns [2]:
>
>     warning: feature `used_with_arg` is declared but not used
>      --> <crate attribute>:1:93
>       |
>     1 | #![feature(asm_const,asm_goto,arbitrary_self_types,lint_reasons,o=
ffset_of_nested,raw_ref_op,used_with_arg)]
>       |                                                                  =
                           ^^^^^^^^^^^^^
>       |
>       =3D note: `#[warn(unused_features)]` (part of `#[warn(unused)]`) on=
 by default
>
> The original goal of using `-Zcrate-attr` automatically was that there
> is a consistent set of features enabled and managed globally for all
> Rust kernel code (modulo exceptions like the `rust/` crated).
>
> While we could require crates to enable features manually (even if we
> still keep the `-Zallow-features=3D` list, i.e. removing the `-Zcrate-att=
r`
> list), it is not really worth making all developers worry about it just
> for a new lint.
>
> The features are expected to eventually become stable anyway (most alread=
y
> did), and thus having to remove features in every file that may use them
> is not worth it either.
>
> Thus just allow the new lint globally.
>
> The lint actually existed for a long time, which is why `rustc` does
> not complain about an unknown lint in the stable versions we support,
> but it was "disabled" years ago [3], and now it was made to work again.
>
> For extra context, the new implementation of the lint has already been
> improved to avoid linting about features that became stable thanks to
> Benno's report and the ensuing discussion [4] [5], but while that helps,
> it is still the case that we may have features enabled that are not used
> for one reason or another in a particular crate.
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Link: https://github.com/rust-lang/rust/pull/152164 [1]
> Link: https://github.com/Rust-for-Linux/pin-init/pull/114 [2]
> Link: https://github.com/rust-lang/rust/issues/44232 [3]
> Link: https://github.com/rust-lang/rust/issues/153523 [4]
> Link: https://github.com/rust-lang/rust/pull/153610 [5]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks everyone!

We were already discussing this in the links above, and it is fairly
trivial on our side, so I am putting it in already so that it goes
into the next fixes PR.

Cheers,
Miguel

