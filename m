Return-Path: <stable+bounces-211484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHOYEoQndmlMMgEAu9opvQ
	(envelope-from <stable+bounces-211484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 15:24:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F3280F8C
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 15:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64E0B3004F44
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 14:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B3131BC9E;
	Sun, 25 Jan 2026 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isg4jQoG"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8731815D
	for <stable@vger.kernel.org>; Sun, 25 Jan 2026 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769351040; cv=pass; b=pqgeuTKiLydNqf7DcSfwp+K5YLSSNv7OWByl3k4fZD7HpsCal9ujtAuEGdrcBFAGeaizMPnezu09Hxkbwdo0jZMSyv9GsVh0t4AGVtEemkF9dwXPBU4zDh9j4H0eu8Er6MJhdu0cqRhd0O8tAHqIYSnQ2eCjBSNh6PKmJM53UZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769351040; c=relaxed/simple;
	bh=kPQvgJe28ox2CQfy547+PBRSVihKGOOiKUd5wXSYbRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2WwQ2QZBQriNScKM50Ra9IfuWa/v4jHbuNX1dZEJpcJ6LxJ/yoQXIadTQRSBwBQwScVYq+G0SlWo7rRzOPfEHZt8NiG5g/dcCEgywrN2Q7TIJEhWkGIJO8STWgF8N6P93PzaqWvJ5fhopkz7IkVdtbxiM9ZGnZvbcqaSJiyafA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isg4jQoG; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1233608c7e9so474070c88.2
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 06:23:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769351038; cv=none;
        d=google.com; s=arc-20240605;
        b=VeHiMDXwouQRGrvJRHxqU5Fcl40gz8PPPHiUf5egS2TgNN7u6JcdbeNa+yZZzQsel4
         pFWCX8LgO/spiku7eVKJRDpZDasly8B+vF8zAGM8GSWVKoLNkH2w1IjbyifMpZKeucwu
         FBHRLy5JDFxqA79PRAEDF3Q+mCaqPUqalu5Tah7N/qh/bztRfOcWERPH//HyhAhquGyW
         K7RLMrPMoaBia/ofSdVR+Jlu4Srd/WoJjRK9xS8iUQTP72eXFduO+HVf6APFyjLYLqw3
         h4I0OHbcDCELXKVzYhvx4H93jYMEwiBhQXdivhLo1nm00aBQlf5in4DoKxr6pMG8I/U7
         i8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D+Hn4KM6uwjsnUq4VCGNkFIAYOhZygARt/sBuI4xIkY=;
        fh=mf7xOUjlEThGj6Y6/3FHD4NFscEgZs4MJm92nlx8EdA=;
        b=Y4Vq95jNiSiKQih+FfzVIPr5WONzUlYkbts5VCWdWXqLpREoreFG1PiCM2oFqvH42E
         DFmupyG2+ry179wQ238ALQnz/t9Qo82uZEAHOKRFWObE4jGMJXFBnMXSXBCuvH2X50as
         MyigBz1OuSnbECyOlKWCYYasSmrjeyHPd5pJ/hO/kNzsKsErUQBhySFS5mHVf3/DHar8
         2nZ3KuqAiM8GStSEDo8f+a3+Bl3JPrA/5msXxxpqgnds/j5tgwDaBY5dY05xsOdYlR51
         WwVrp7M/2qVxRme2RVtpJE3jdAZp/HmKOn+BMhzWN537Qvb0SxOWGkRbuDxbgkq4Znlv
         Px7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769351038; x=1769955838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+Hn4KM6uwjsnUq4VCGNkFIAYOhZygARt/sBuI4xIkY=;
        b=isg4jQoGXlZTvdYc2Hqkbl1/TCWDsx3eHO2FnJMf0T3o1cJQEnNYzhK2eoWW5Fyixk
         E+JSTvBeAyZCLVvzj/rqYi0OZ6UwTnbDaFSTySzAin7SvwwktROhaV83yKHdaC/W6Cth
         7uvUy+7GFEaWdnAmggGzJu8GyjIIq93Q9W/43d9Z7ES/wAS/aowSSxdQtNZVIl12bbwU
         s7nvxMxbT+WsohZbcUuVf6vwISP4ut5E1Hv/bR7EkPkETVScMNnUC3PL13WNFEU0efmA
         g3TU/MAgNfLzUkY8glF0l6S7jOjusVMusKSHR44WR2Zd7WhsulEGDLX1xZSMv1OhGv5f
         090w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769351038; x=1769955838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D+Hn4KM6uwjsnUq4VCGNkFIAYOhZygARt/sBuI4xIkY=;
        b=hTIF1qLUJaHzoWtqDlTxzE+jIgjRRFI8Ujw/I1zzXNOp+qs7B0mbzvAuOlEnHzbU5n
         yP/pD0KT3DPdu1pgcLe/CCFTkkca2je03q9zhSCDl4KByNOsdiJvrCyecfrocjuz0oq2
         S+0TtGNSvTQYJbjlbzNorbVfSxgprBy0PoXtgSYChZ1xjOgiImVdKJxIPXpusMCFhFdm
         ZRdmVysebFqdBnsOoDrFWTdXiqgxXw+swKbCzoB3DBrpLtQB5QZCbHMJag9a3VJUm8bQ
         A7B82XM7Is5dDD4dGLoa3vpGW/Fo+b6lHijMG/29g9jn1irnSJU4S7QUdFwXWxMrT/2o
         aKhw==
X-Forwarded-Encrypted: i=1; AJvYcCVEN1iTyJme0dyCspjWMwMfXuEmcdBcsvz5HS2PEFlfTroRKDsQ34IhDt2vh5JDrzka4oNCo6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkEDoKURvtI7E6o3YRgQg/62e88XgAUUSEeTCO6SCieEjlw/c3
	HPawQ2BpyW/d80Yj4XXT2H6Q1ezxebKdGphkxwjOboCqSFZ+/iG0xdb7XTu3qOtZ7N0RlynjpAX
	JJ6aAV3GTKQAcvUJMvCt57UKAwt1Zmfw=
X-Gm-Gg: AZuq6aKpv5nHjdxlluOdqjY0/jxOTD8kYPH5D5nJpHUB1+H9CheBB2/DaBSLfcxcii0
	tmbOhhEpGHrHwXTHx6bwbEeP3Is0N65A4kIPpYM8FaH8iupUD4IrDMjNAr6ZmczkNEp/0bwcw87
	rqQ6npbYQQRATHzpjNEp6yGlWvZFHo+bJ/JDFWFPQ89DTlHRXjXL4xL3k2ZEuApl47/gnrEC7Zr
	4eijZFsZ4zrHGkBTsudkjW8lyqDW5BMhOMMGx+Aw8YZPrB0FYFGnjouxwTskMwsF/5WIu/JDnWD
	ZrgcAe9KOEZr7RfnxNqmyvtP1I2ImNECeyTwrSSRre3eVJ7h1xPHcOxXxOagCqzZF8xWJbBT2qI
	MvtwvmTsUf+j/R+jGgThebeU=
X-Received: by 2002:a05:7300:fd05:b0:2b0:4a1a:657 with SMTP id
 5a478bee46e88-2b764827c0amr395815eec.8.1769351038208; Sun, 25 Jan 2026
 06:23:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123233432.22703-1-ojeda@kernel.org>
In-Reply-To: <20260123233432.22703-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 25 Jan 2026 15:23:45 +0100
X-Gm-Features: AZwV_Qhg6eEx-UkSkKUjlOjUjy3l7sGBW9zLBuC2APMKxVRF69KWe-wXxD2MwjU
Message-ID: <CANiq72no9wwdXa0Ct0c0P+6+_4WhBZ3GChTFHth8EeuCFSzAOQ@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: atomic: Provide stub for `rusttest` 32-bit hosts
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-211484-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,arm.com,garyguo.net,vger.kernel.org,protonmail.com,google.com,umich.edu];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78F3280F8C
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

Boqun et al.: in case it helps, I will send a fixes PR early this
week, so if you happen to want me to pick this one up with the rest,
please let me know.

Cheers,
Miguel

