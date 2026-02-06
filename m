Return-Path: <stable+bounces-214733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIscAQ5WhmmlMAQAu9opvQ
	(envelope-from <stable+bounces-214733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 21:58:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8BB1034F4
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 21:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7BB7300336C
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 20:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C3130C35D;
	Fri,  6 Feb 2026 20:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tzkenpvu"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107F30F921
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 20:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770411528; cv=pass; b=MGJuTQmCdTBaNkpy4tKKxbS89CmTyI4XBv5OKaSte+D/qzOvxwRJqnPj+CJA9PWL3Xt2f3zzpRvpriaYLuWWXAsMdL0ImtrbP1emly48KjvE+D/EzgI4KrBnI1w3z2safV8PWh8UGaO+1zq8YDui9oh6C4bF4jy++c/l1QC/OrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770411528; c=relaxed/simple;
	bh=9Vj7+gNg+Rff5ch0nT6eI5MqIw2L9AbA2OQUscfwkE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hc5sfhV/LZSb4xokNEk4eGhHSxJSVMQM4akG2HhzFyFCRsn63p2Ar5nE7dekeTR506dtxSdZNFSTLv8j2ZP/2gSgGpZuLKKCA4YpKARe8OfJMhKYLhpTqLR5a8Hyw7+CRFOADmLYppttoM5AMxaDTt4tiTXV08Os1XMbTffrqaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tzkenpvu; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-124a2dc92dbso169137c88.2
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 12:58:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770411527; cv=none;
        d=google.com; s=arc-20240605;
        b=elKqizMHTpf5/Qe4oZXnkDuMysz4hXkaLtor25VGQi9g/fojJ8WE3dmXsT/0EMZ6HB
         A5H+90Xg4QZXf6YzuALei2ZKztWmJumYPCzh+6I3TnG8Wb6J0TnNyuGhKzjNp7nc/eBn
         XPp9gE4Js3o/GjYud+iIyLoJCgXn7OH+ug+07VeEZrAqgiy1xqNwZUak/SbeuGu+Sb8s
         Rl6Jn44d2q6k+WqIsdk03fHl0KbNyIY1880nGtqQyzldR1Bi5ZtFyYJvTaTBDfo56C4r
         HMdzaPImG8Pb+MayMntPb1LlAirD7mPDOWWSHPIpC8oTqCpVUYngupjN17PpRq92RMfl
         zCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XiLzMc768cl15yir/Bv2tnr2hc7r4QX37903QHVCto8=;
        fh=al6HpokzQUUsMaRG74rW/24y+PiDGpE15FBSeKznqLo=;
        b=L5vPBrneXcPz7M0hgrjQZW8f6Xjr++/jJ2W515c3EhCQIfTpncCuPGGI4y5rZPfWAo
         wUXTXr9ZHW/aO/4vUIoXbCHlEkDR3YwCFFeIQ5Zr9IF9+3Ta5mT5IfwTcTTekHbbdhBc
         L3vYLe4hMu3N5x85lRXrK5Ug6pyq8/rTP3oA16yqz/vkTfB9KNOVgetFcV5NldxsNLKx
         c+ODs164n/yyVKtqdLHBVGanNshs0EVuT2822Mc12vj0SN/n2NPZYksvbioYPoPQP5YK
         duOrNoa8IjZjbslGyxYAg2+ALhEuWdxBfobnu2caaL1UqhJcWMs7V0gMAlpkOAZqopa4
         gBgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770411527; x=1771016327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiLzMc768cl15yir/Bv2tnr2hc7r4QX37903QHVCto8=;
        b=TzkenpvuDn4cfMRbodGHRhtGOZtc1QPjvUpZtfu2KAMqE7ER/CCfYSLsbF9jeg+Ca7
         Q7ZU0qv7jDgdmujZfKtEKwU+vmnfFAzxUUDTOmnaf+81zPW0cQBjitDd4dpT30qPR73n
         j4HNuMR12JtsMQt5P/Z6OXTBiyWTcurigrrWXBz35jr9iRqEhbNkt+gbAuknP1E56Svn
         ANux+25YckW9HM41sMgqF0Z1daHUS7uTkjC2oB6jo26EUmJ0b9CzLH1q/qCOWdQz4XpS
         GQ3kuudAEuDlApJcXjco3/hiwluFm+RExKaMdWCPI305yfIpD3QPKRVuazadtWFNvALx
         sCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770411527; x=1771016327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XiLzMc768cl15yir/Bv2tnr2hc7r4QX37903QHVCto8=;
        b=Qzl+OrMKBWim8/QuZoK6ZTuAIO2Q0Uavnj6yV9JJosrJCZWntpkPnvPJixNJw5pplU
         dATAp4cF1tMrGywIrbJZ4t6lZJH0k1bf2OkPH3/06KL3B84ukQ7CMBKukP19sGMODM8l
         Gc5j55vlH5KP50BqrsxOM/d6uY4ut6qjrLs4xAx5rqNG2KtILQbwXJhcA8CFmDPdVMhh
         ar/1IVY2YemdluVBinoCwbFSzIgvEuV+BryT7D2q9Ypzbnp4rejEmdtNH7l8ZtUJZOOm
         HSzFaOO0O2bJLDTYv6cSbCo8kwOjf3dyA7GnoYT99/IfuWoAGsHA8FiFKjp1JXGttCpu
         ggZA==
X-Forwarded-Encrypted: i=1; AJvYcCXH5ojyAAXgqWuvK7z4coeVhIvZdUxJ4r4q6am6UMEocMnAm/ATwnUXyNoian8jORSZ6TBdlNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3LCBSXdve6o6BsnQ6LihlK6RRubXB92oWZRnx6OEVLZqqcWbJ
	0AnDsu8mV3R5zlnw8I2KO3c7b6b0+nqYLzwPUedM6B64yMH47sJ4AoJBn7GD0RI7Rv1rtOT85Cz
	z1jDgnvf09G4lPM/EclWFNpl1Sfpi228=
X-Gm-Gg: AZuq6aIQSHjoBQNVJi+6GM84sjjlLinBSi4hIiwbUVvX5Sptmu2hCOwIcq3qusx4jP4
	Tv2MkZf090Md72XuvYlJH4tKalKY/ce4oRPDrJwEQb4mjelJgQlgMiVnnhBOi7Uz4ZvmRjmj0Wc
	VIL44zPX3jAZTRy8HTl99+KmO+XSlN6CHiSVOlrZv9gIzEezZJTe1gu9FQimz0UM2L6ln6k19P6
	HXHgtNJ4+nQpUjl1RUKcmj4vVriuyFg+P592+bDXO15IVDlpi5A5ZZSLCbsHDmxkLDhYz2+1ldo
	/w3eCRIAszJhgGoF2dsuarYdhh86P7cS0vALEypDZDGzgnZM3Lj8YOTzGSU1bg4Q2g+cgQzvgZh
	WE14xsHWMlEEtnACv8z86eaw=
X-Received: by 2002:a05:7301:1f05:b0:2b7:fac6:a9f4 with SMTP id
 5a478bee46e88-2b856a4c965mr894233eec.4.1770411527540; Fri, 06 Feb 2026
 12:58:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206204535.39431-1-ojeda@kernel.org>
In-Reply-To: <20260206204535.39431-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Feb 2026 21:58:34 +0100
X-Gm-Features: AZwV_QjnlqMiABU0YrbzCweRFmE6MMjSKa8gYyl4g5kYhVu4C4USU974IEBp7uQ
Message-ID: <CANiq72mnw40Ha19CuoXCVncdx1N=VafuxC+ZQ-1vTNba5iorDg@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: pass `-Zunstable-options` for Rust 1.95.0
To: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, David Wood <david@davidtw.co>, 
	Wesley Wiser <wwiser@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214733-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,fjasle.eu,protonmail.com,google.com,umich.edu,vger.kernel.org,davidtw.co];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,davidtw.co:email]
X-Rspamd-Queue-Id: 9A8BB1034F4
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 9:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Custom target specifications are unstable, but starting with Rust 1.95.0,
> `rustc` requires to explicitly pass `-Zunstable-options` to use them [1]:
>
>     error: error loading target specification: custom targets are unstabl=
e and require `-Zunstable-options`
>       |
>       =3D help: run `rustc --print target-list` for a list of built-in ta=
rgets
>
> David (Rust compiler team lead), writes:
>
>    "We're destabilising custom targets to allow us to move forward with
>     build-std without accidentally exposing functionality that we'd like
>     to revisit prior to committing to. I'll start a thread on Zulip to
>     discuss with the RfL team how we can come up with an alternative
>     for them."
>
> Thus pass it.
>
> Cc: David Wood <david@davidtw.co>
> Cc: Wesley Wiser <wwiser@gmail.com>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Link: https://github.com/rust-lang/rust/pull/151534 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

For reference, this commit is the same one I gave David for the
upstream Rust CI.

Gary would like to have it in `linux-next` for Klint that uses Rust
nightly, so I think I will put it into `rust-fixes` soon-ish to help.

Cheers,
Miguel

