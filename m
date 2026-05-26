Return-Path: <stable+bounces-254274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO5VBydXFWqmUQcAu9opvQ
	(envelope-from <stable+bounces-254274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:17:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7413E5D255E
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82D82301571E
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 08:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073573B9D9E;
	Tue, 26 May 2026 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpBsoIYV"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE7A35E1BD
	for <stable@vger.kernel.org>; Tue, 26 May 2026 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779783458; cv=pass; b=W9NmbVGmqF8jGfpRY5AhKEUeyyaN9f0OcR8XrE1g0Xc6I+G7U4s2R4iFmaL9uTyJR7ThzM4jVO66kdDXEH7RzMpRJ12Rp7f7apWu8Nfo0LALgYHL8SNqgWloswJwN08C/D8Yq5CMghr5dGlDEejGoimfqL9I/AczOw/BNAWvSGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779783458; c=relaxed/simple;
	bh=Sp5ZKqrzcRrafJjgXXSBE8mJRX044NCbQJ+kvz66LME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBx8C7IZEEzZmvjffPjHU+JSBR9dyTHuPUv96iT7dEGkhJbgho3ClWDTsrsRd0Eyi7/7VZnnnOJdNtWU4zTenaH+4fX9utNKBMaLNaP6kq4sZdvbkMpQIB+kBkTPL5hCj1J39N8ek38VteDFa31CzTmDQRRjpGWl+F/kICF00Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpBsoIYV; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bda3b4318dso1017643eec.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 01:17:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779783457; cv=none;
        d=google.com; s=arc-20240605;
        b=FywKqmL8Xlx+Y/O4AQNHL9tXEUqbmVe5flpYdwNAiwB1x9CB0+IZhIOtMWirSr2ISo
         W97UjQnslvWZAvm+Q6Kd5dKSrMMHmqJUcna1JzrXWJq7ZoK4OSGQD4j9S9uPyxXJKic+
         LrJih8TlK6hspZ4hxrR3z9d7IlVNizQLXdUDWfMEkMPVrOh/ZN9XzZkYS4AfUgVjdcUK
         sKBE3MoDGBpoos6Yaq3H4x+5PLcJo8DEvWrrjVfduj5oq3szduiO6YhZA7D73DIcv+cS
         MjPXil0ZBjIuaHnEP9YkKQiRLLntZKP8IfyYYHGthaL2KZvc5edAAvAMhepjRtWVickQ
         Mg1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FuPU8upLRbELTBqt0oNJ1IC9teTLP5/yLZLMTN/L9oA=;
        fh=d2kvwtHKFNaULowvqJzjJDb1QEfp1EQLJM6rqTl02tw=;
        b=Oe0DxbNvcOtpQ8LZ2ag0u6mWI9YULQtpY99/vKIjVDg/f8NS74rR5CErSUeGJNrf/3
         cl8WVGNzY0qDJ1fX+4w6fz8MmAAS1cUHz5D/qBXdOmAt8DvyZbK2JpO1QAsINTHlGaQ7
         fZCBCbhH23HDSofgomUUDyDH6ORf9OSRFikliMBsOJnx7KyzCWr6C8NMhPanB+JZRIKq
         +aolAt3577XAA07qU2LbpjrAnrzuov5coPWNmjhykCVEhdoT9ps4PPKZ7e68mFZJp50Z
         YyYiHqyUWU3QCuLm+eY1IIU3Oin1iMAMLepNcHgRRKfZFHVMfpnB/HXX2e7dJmA6i0iW
         cllg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779783457; x=1780388257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuPU8upLRbELTBqt0oNJ1IC9teTLP5/yLZLMTN/L9oA=;
        b=JpBsoIYV+rmSJBF05BOs5dLpAYIs9vVBA6D8B6qrSWbFI84QDvTRes00yGFRUcWvgz
         8t61C7bnl2VNr3k2JUeXIl30cGYt/igU9yn/gBAfc24ACvxtN+JNm9zWiF237ywfIBvE
         UEvEx+aJl7iSKEzG3B6zHG1CYv04mXD3HSLR7P7SW565Lf77kl4wTcTcBlQJWNptSkZs
         Rt1WElG8mmYLtXfd/bhf1iWfunwUkA2xI9e4bKDki5wby9pM1vCFn+Kg0XZZrGwlKF2Y
         JO7/PAlEjza5bPGaJYC8PcoE3AeSWFK88fCiMe2M9HyQrE1uJ+UhMfWiQEz/EJdUzwi9
         a7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779783457; x=1780388257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FuPU8upLRbELTBqt0oNJ1IC9teTLP5/yLZLMTN/L9oA=;
        b=U0Ynv703BkiqyG0nQ0b+DvirBoicMfnMqfJM3I6coHDZBPEGify7dQV818D4CwLKwn
         q/kHXeoCPvzTvi6d9B9SGQUV7I+XkYiFqlu2YgsRbdihPDeRNPHZfwFmmKM5/xj7T2BI
         l4eQj+5xCiKEJvtZTsj7rKyvwtNoOdIK1KmsD6M162HF01G69KDpoE5ALdI7W4X3rDus
         V1VOj0N0jN6DBSblOl59Sj1gJkYtS6pfILo6p7rCgwJUuMaXCPhNsbtSN2SnfwWufmjV
         J6EZZ4tHQqkxiKIO/0ZQAWF9QVxZNCLJegYU9rDOqY1qkwGkAduJx4pI5ubhM2g2Uh8q
         dbdw==
X-Forwarded-Encrypted: i=1; AFNElJ/Qt3QhAWJtHJfgiGZjiuCMELP+XPyr4vYe0kpxK320chZrx1JNOump2ic24D/Z+Hl7yJPRz0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj4nM7b+gu26YY53kddTdWrKpGcG8eW/4GelfTGq+3BRdXXD29
	XVTUliBXW1No0pnlaZhZufxtrB741eSSS3UcodPT3pJRxO9WkuLlPBLGDW1JAqlZqbXQqqLE7Ig
	kpElPSVsdKXV8N5ja4NdyZDtW1WCcN3E=
X-Gm-Gg: Acq92OE+LvMu8drOeNvwW4KGGmBk9D5AIeTf4OEWrHxCOSftHOwjEKP4uYlqGfX1wtV
	ZVb1H18AfXhD8nZHm/jRFI6l8KUmFwytXwUhOSwU7eRKyu/DZUHlbpcUupRxZTADM6JJOavI4wq
	g9MCeTLB9y2ibywOAehauP0oWfvPGkpQkUk+DnFthKfnoMg2i5ne+vQfd1WmRfgr1oyRQlootWR
	ZGEX/UkiEWDJ6A4mFnaoF+g5wUuc6AO2p1UyqW1i5pjai0QQYpCechSet2khgB92xFeE0CshO4G
	uX3wykTC1N7x6lFVJkUJW+rBQkGXl7lDoPfK/ZUEeGpMflRStv4w4wIAaExn9UocO84yrgflDiJ
	urthi+dgcmNn3DxzWqlNsCEDA5gd2+A2YyrOoCwEPHtl5
X-Received: by 2002:a05:7301:2092:b0:304:4f23:4823 with SMTP id
 5a478bee46e88-3044f23c523mr2417160eec.7.1779783456513; Tue, 26 May 2026
 01:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-rustc-option-cross-v2-1-2f650a49c2b5@google.com>
In-Reply-To: <20260507-rustc-option-cross-v2-1-2f650a49c2b5@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 May 2026 10:17:24 +0200
X-Gm-Features: AVHnY4IuYyKvBZXvx8VWYwO2htqI4qYv-jYYqkX5aPD8vSpj7I2To7c2OoxiNes
Message-ID: <CANiq72kQKRoM4ATAYhP+-UHiqPr0tg67dr4EDYT+ptPUshH2ew@mail.gmail.com>
Subject: Re: [PATCH v2] rust: kasan/kbuild: fix rustc-option when cross-compiling
To: Alice Ryhl <aliceryhl@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254274-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,garyguo.net,protonmail.com,umich.edu,gmail.com,google.com,arm.com,googlegroups.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7413E5D255E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 7, 2026 at 1:14=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> The Makefile version of rustc-option currently checks whether the option
> exists for the host target instead of the target actually being compiled
> for. It was done this way in commit 46e24a545cdb ("rust: kasan/kbuild:
> fix missing flags on first build") to avoid a circular dependency on
> target.json. However, because of this, rustc-option currently does not
> function when cross-compiling from x86_64 to aarch64 if
> CONFIG_SHADOW_CALL_STACK is enabled. This is because KBUILD_RUSTFLAGS
> contains -Zfixed-x18 under this configuration. Since that flag does not
> exist on the host target, rustc-option runs into a compilation failure
> every time, leading to all flags being rejected as unsupported.
>
> To fix this, update rustc-option to pass a --target parameter so that
> the host target is not used. For targets using target.json, use a
> built-in target that is as close as possible to the target created with
> target.json to avoid the circular dependency on target.json.
>
> One scenario where this causes a boot failure:
> * Cross-compiled from x86_64 to aarch64.
> * With CONFIG_SHADOW_CALL_STACK=3Dy
> * With CONFIG_KASAN_SW_TAGS=3Dy
> * With CONFIG_KASAN_INLINE=3Dn
> Then the resulting kernel image will fail to boot when it first calls
> into Rust code with a crash along the lines of "Unable to handle kernel
> paging request at virtual address 0ffffffc08541796". This is because the
> call threshold is not specified, so rustc will inline kasan operations,
> but the kasan shadow offset is not specified, which leads to the inlined
> kasan instructions being incorrect.
>
> Note that the -Zsanitizer=3Dkernel-hwaddress parameter itself does not
> lead to a rustc-option failure despite being aarch64-specific because
> RUSTFLAGS_KASAN has not yet been added to KBUILD_RUSTFLAGS when
> rustc-option is evaluated by the kasan Makefile.
>
> Cc: stable@vger.kernel.org
> Fixes: 46e24a545cdb ("rust: kasan/kbuild: fix missing flags on first buil=
d")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-fixes` -- thanks!

    [ Edited slightly:
        - Reset variable to avoid using the environment.
        - Use a simply expanded variable flavor for simplicity.
        - Export variable so that behavior in sub-`make`s is consistent.

      This matches other variables. - Miguel ]

Sashiko points out the Kconfig case, but there we only have LLVM flags
that were the expected, original use case of these, so it is OK, at
least for now.

Any further tests and Acked-by's are appreciated of course.

Cheers,
Miguel

