Return-Path: <stable+bounces-211520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UZDMDicZd2kCcQEAu9opvQ
	(envelope-from <stable+bounces-211520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 08:35:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7733C84DDB
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 08:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96E693004F7A
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 07:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6EC2C11E2;
	Mon, 26 Jan 2026 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qpxJ20vg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394982356BE
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769412899; cv=pass; b=U22rsFFn95yUVPzzU4Yus+QAlR6+cqvpkAE9Sydak+3+U0pSLwU9hWXETMmzj/thQ3qThHGqm9XTDKdT1d0BJfzbmy/nGreEbPFw1f8LnzTnGuCGpdNFZAvrTfbSy6qvEqwpsX+8dBri7/p1k1B7dNRx1YbO0hSI9KncnznxXek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769412899; c=relaxed/simple;
	bh=THFcxiM29iAxgbEd4iDhi2mIwhQRXAH4YxKo/5qMUGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6ny24GC7zbWMAKVOstA6q+hOXcsVjGzScRL2N9cApqt+ctZZyBM9XEMt8wbehZgfKRYFdYgLztUpOV2Px/r7im3Tltb8vzN3QGQG+ASJD8PvW693SCBVLyY2ptp9rS5TFsK6RRtha67Ds2X92tMHp/MF75NhKn6HbI3jEBB+E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qpxJ20vg; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4358fb60802so2374132f8f.1
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 23:34:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769412896; cv=none;
        d=google.com; s=arc-20240605;
        b=P57uqHBNVZr/Ywl2pl5mkB6zUpogfQX9zAKmmqIHBtsZY7wVYLw7JfqXHjPxayKXw+
         QA7AvGNqPAUVFVLk/BVD5G3ZE6F94hk7P2Z0VwfDAMFfyLALahIIE6ZDi8BVcYO7jvSK
         yi9Ne2X6Cgh5t73CpA/xRY5TtprBgOpyW3i9lk02qSQ4VWHTINffcpdWHMw6mcaSFiBy
         ERUK5mW6H1VCprpJunYokgx0JF5c9QwB//yDagIlo+afC+LhUITAKyZAXUt7ExaqUo3E
         h+5ElPE+fSsxNVCfrGr/iHTo/fBEoQQWpysHa+bkGTywI/Gnh9VgDSnNsrjaIuF4nqoJ
         VDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TW8SDHm4wY+72pZI5lkyEknmq1cQQbn7gnfEPgF9Cow=;
        fh=WuD+6Mjct1UqtVkkodO+QfMUy8LM635nMY8Bk8hDLGM=;
        b=ZgudaTHT/r4AXbbppgWshyMzT36swXtzeZHA48HXNzbfDgbV/aGCjGVI4IGQRsdO72
         xemaY+nOGOi1fwwWN+He8Rh5NDR7lhNrB9n6dzRQ1yqq+ep5lJvDXmGNzjgt53SE1GHA
         OSLz5CVMxu/emV5bqRPVtPfajMGJQs8H4Qxl/HJkYTiks7JH6VuBHlvpV2jKk5GESpel
         eo6j0HT5a1QFK8vxK/ufyOZhkvrWPhp+y/BOSMFD37tc3diX9Y+0el6znz087nfDO1Hi
         lG0JDUhpP0yZ9SnEhu95Ld6jyUVUPu5EEGMEp9jvzf940kGFrOmINph6DFC3f+AfvspF
         +gFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769412896; x=1770017696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TW8SDHm4wY+72pZI5lkyEknmq1cQQbn7gnfEPgF9Cow=;
        b=qpxJ20vgtN50a+Br1oIWFXebWiWG0+esShJwAhPhcY3Klm3GKpq+sbcPifr5F8aMYe
         2IEN6F6Bb4q+dO8BWW/fZZeDrlNbtbjDvKDNfiS28uO9yxZ/qXA5vrux0xAQjW7U9jGn
         XgS9/EGqqAQO+5I2KSradkuLe8ZcwFTTRy+1C7/Ar+HSKv4R24axgAnEQ7zeI5XM9yR8
         Z19rhs8kOIIkmsGwp1i6XceUn9FwIck1xSrlW8FisYSG1NnNCvc3nzbs9Eo/fm87qOq6
         GHk0jbA+eH3VCHw2aRL2VqnGJOlfiH/6tZVPMYLlYRP89e+MWG8rkTNIwGaqVI/yZ3Wz
         UadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769412896; x=1770017696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TW8SDHm4wY+72pZI5lkyEknmq1cQQbn7gnfEPgF9Cow=;
        b=G040ex1akImrb4wxNU2Vt4okCEcL3mXMMxFQlx4MwzCZ3E0faldZM1b6/ioBjiKUhc
         6ES5Bl1biSdn8QfBFln2OTISXFgWFc/9gSgzsYIyCLHN7VhVCpre5pFTytp4Jv85wHip
         HoLb3gdsE2LOqE5sOb7Cn3t9VprnVGM5EfciZcwjZaSwBelszm/Ol/AXDJm818yAzIbi
         CmQiNVhUipcQxDugfD1S18nR9Dg2ZUCVA1pSf+HmuS2kXJjPOL52kaHnx2WOMpocON7X
         VTj1pz539Gp4jhVS44J0v/6lJHijIsmHr6InoinQivRkGmnEM+fL2mtEo2c8NWdCFU4t
         H61A==
X-Forwarded-Encrypted: i=1; AJvYcCWbcOjc8U1ldSEiuTBvZbbwAgQfyhu9yaSQ8KcmIh1h5QKsF1myiCev3ogEovzL4xIQ3F6PZXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySmR2muj1VtR89le2EH1P3ylAcfhd/w1PUx+sEnqvDyg3qCD/U
	DXuFoV4q5UyU3v3C1muK31TGHsBqbqnjOLJJvdkgP1BHDoMXdHqYjBqME8Zwcs5ZhCa+edGfe7d
	ASimngHrIS0ntL5vRTD0oD3SiYHDCSFdzdRlK94r/
X-Gm-Gg: AZuq6aI8nI/nf8AlUvS7JLJvRBXgJje605xkE+5bIgygmdXqeeRlfZI4HEIbHIyG0Yo
	mj3O0CW7QQiTRK3T+TwJnTzpXZl9GpEimhbJUjbYVzQjTL+f+2m+g1dIsbeSoiAkcp8tNn7O8oi
	vYG+ioJWPt/ecLcpz9k4rKmNSJ8y1eyu7WYOuYpwUc6p9Q8t6zQ7fIvdlkakL3QipjrjZ67/9yC
	2bJOLS4GyLljGqzTgg0HeeAavfec57G212iztJ6LJfchY4ggWkBnp0SoYnCdl730yA4F713R6n2
	PKd48oT98tSI1qEwyHTclFiBag==
X-Received: by 2002:a05:6000:1acd:b0:430:f2ee:b21f with SMTP id
 ffacd0b85a97d-435c9b29d89mr6070418f8f.22.1769412896418; Sun, 25 Jan 2026
 23:34:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124160948.67508-1-ojeda@kernel.org> <CANiq72=3+==Px50E+EA0fhe3pxVAGzRRt+6d+qze3cdeEBjyoA@mail.gmail.com>
In-Reply-To: <CANiq72=3+==Px50E+EA0fhe3pxVAGzRRt+6d+qze3cdeEBjyoA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 26 Jan 2026 08:34:43 +0100
X-Gm-Features: AZwV_Qj9ldnC_uCDqYFEUEUQ3iDRZ5FCfEYSggcx9Mg02uPkev3eBUfDJsHByaM
Message-ID: <CAH5fLgiRvAvoJkpLmkSZwo82=VwQZUjZxCROc_0LZ0YkzZhj5w@mail.gmail.com>
Subject: Re: [PATCH] drm/tyr: depend on `COMMON_CLK` to fix build error
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	dri-devel@lists.freedesktop.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211520-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,collabora.com,lists.freedesktop.org,gmail.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7733C84DDB
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 4:10=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Jan 24, 2026 at 5:13=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> w=
rote:
> >
> > Tyr needs `CONFIG_COMMON_CLK` to build:
> >
> >     error[E0432]: unresolved import `kernel::clk::Clk`
> >      --> drivers/gpu/drm/tyr/driver.rs:3:5
> >       |
> >     3 | use kernel::clk::Clk;
> >       |     ^^^^^^^^^^^^^^^^ no `Clk` in `clk`
> >
> >     error[E0432]: unresolved import `kernel::clk::OptionalClk`
> >      --> drivers/gpu/drm/tyr/driver.rs:4:5
> >       |
> >     4 | use kernel::clk::OptionalClk;
> >       |     ^^^^^^^^^^^^^^^^^^^^^^^^ no `OptionalClk` in `clk`
> >
> > Thus add the dependency to fix it.
> >
> > Fixes: cf4fd52e3236 ("rust: drm: Introduce the Tyr driver for Arm Mali =
GPUs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>
> Applied to `rust-fixes` -- thanks!

Thanks!

