Return-Path: <stable+bounces-166540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC384B1B05C
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 10:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD413AA06C
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC612586C9;
	Tue,  5 Aug 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="peaxE33M"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD4D2E370A
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383375; cv=none; b=fVgfup7LdVjk6szk8qjq+YwSCEwjgqWvHfEYhGerlFYBAVz9cjD76aDV82wzwL4s0KoVyrqEyKJXBClr0LoEkKICHvGT0lgriOSU1CNrR9kxRwYLbLhZc7UOzxPxbjfE61JQvt1j8MKe6UAVPgTmR33gZrjxn63SN90a9z2D/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383375; c=relaxed/simple;
	bh=LVuuvIOXyaDckGRowOdAF0iCB3B9x3e7m6JtLCAG7og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5rvUBFv8uo7UnursGrpEzBkFp2bY/b1byfPwD4ObkA+Z68A42sLuh5vDGUxW3SOh0tUYTpo1+E8+ox9QIt6wCdWbFwWcA4wtX0ZCHjw2FWJ/xm3CQYiIvg3Y69hUra0qconnne9+8+eHwMk+x7PV/kPPIaRco0VVr+rzp6zYp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=peaxE33M; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso3073982f8f.0
        for <stable@vger.kernel.org>; Tue, 05 Aug 2025 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754383371; x=1754988171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EC3P05sIQH2f4RvTxjQQwotKae6prFyn6jtQODb9ESI=;
        b=peaxE33MPTJN+Jls3NUjEorS+6iiGcvqpYpOaieZG34JycAEjy2Po6hg6w/rI2HN1D
         VoYMsKK/6uA3SAd8QR4dP0egxuzCETB4+WjPCx+bLQRa4a8bALtSZ896er/vbtcZuLZW
         GnYZ8sh4maJVXLsMfDrgGMWISLPS/pb2md4NrHF9UtVm7/+Hh1D23I+QOoHptojdgt/t
         wGjsZEg05AWgG76/urNl9Mdrkj+HUApCnlhUvGH6mHWglqTr2Bfv/ZMx3k4tJMe+b7Yf
         j4pvhBlOzwGZ4MQMcpUEOr4y5KhzxcGTYlT30gvmRcnC0rZC5QtlzA8Zx9Nh2XLrK69t
         uCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754383371; x=1754988171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EC3P05sIQH2f4RvTxjQQwotKae6prFyn6jtQODb9ESI=;
        b=geyycjeXqpqIPjdrJqBs6ovCGm4uPNE3RIryEBje1tIuXEYz8xLdermJSHT+qTugej
         q6ySJFIjVffD4i/VizGEBfed5lJnVNcmSUYiPRlk+O6DaAU1VQ0oH2awuipqefbHl/FG
         VKGUX7AjO9V5YwgTMPVIouzAnzteqfHddZurKF4iUVbb0Ak/YE6vPTlP9EvvqgC64weC
         ho6dvsVDSvUEOdz0c8nvZFi1aRnIAlI7H/hp8vju84ItU55bMewd0z8jreSr/+uSuvdc
         dVvyCUWFjjg7g/EraFzL9aDQcMKHNWJ1Q3VFrqrUhWANldLdJxCRSZF3g0N6Qq3HVDZ1
         pvfw==
X-Forwarded-Encrypted: i=1; AJvYcCXNk5eRN3oYDoa2NLNH1b/PaZUKeDygk0iTOFiTQS4fEo9kAqombixU83bKK95ZtKDzFeNfVtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywce5IgV+2hkCD3oyEgndtAMicBj0Xh95Cdh9CN2+QQZynOXQas
	YCBU0w0f/Hh6oqxi8GFlhmKVgGHn6hOEh5RjhBkracCSScfM28V3EwghSd6FS7Ti8KFD4C/XhNv
	fHRJbkJTQdK7/oJrxiBV7Y5Qou3rMZrV0se5Pzj40
X-Gm-Gg: ASbGncvn2TPIhfNlg/bLfgAkETJTYjdt1LJFEKL8by8jKo9ZT2GpuMxIB4iUhxNTpnz
	OhVgRjQYLAz30arEznISfACGtxqTJeMuvfPhfLH9McwdsLrHvC1oexOh/BepoH6qVcxkfbCd7R9
	stO4nEiU0dYQVx2NE7r8a9GZJbfqnJQxf3h/XYthJEQoHK6IEub0dA0BrMqYrcGI+TnBpZawO77
	+DJHFRDnY9mBVrfuhIFjJuNKLpl48KFA4dHNQ9wTpMg6yZB
X-Google-Smtp-Source: AGHT+IGtAV56xPSuv3qJG0TJb6qDD4qvA7fD8oX2CreP4OCwWwwKK5eD+igWG1oRFqoLugM9orOt5fMF8aMdW05tgpQ=
X-Received: by 2002:a05:6000:2289:b0:3a5:52b2:fa65 with SMTP id
 ffacd0b85a97d-3b8d946a541mr9866566f8f.5.1754383371062; Tue, 05 Aug 2025
 01:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804171311.1186538-1-ojeda@kernel.org>
In-Reply-To: <20250804171311.1186538-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 5 Aug 2025 10:42:38 +0200
X-Gm-Features: Ac12FXx19FT9ynQWIxH_U--Fjwzz6tXLnl6QKMiOty5H-9vNPyzv9MLJrTEPKps
Message-ID: <CAH5fLgiERU2Q0+BAR2P5vb-mTeNe=wbS-b_38bjhc+WOD+bXyw@mail.gmail.com>
Subject: Re: [PATCH] rust: faux: fix C header link
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 7:13=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Starting with Rust 1.91.0 (expected 2025-10-30), `rustdoc` has improved
> some false negatives around intra-doc links [1], and it found a broken
> intra-doc link we currently have:
>
>     error: unresolved link to `include/linux/device/faux.h`
>      --> rust/kernel/faux.rs:7:17
>       |
>     7 | //! C header: [`include/linux/device/faux.h`]
>       |                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^ no item named `includ=
e/linux/device/faux.h` in scope
>       |
>       =3D help: to escape `[` and `]` characters, add '\' before them lik=
e `\[` or `\]`
>       =3D note: `-D rustdoc::broken-intra-doc-links` implied by `-D warni=
ngs`
>       =3D help: to override `-D warnings` add `#[allow(rustdoc::broken_in=
tra_doc_links)]`
>
> Our `srctree/` C header links are not intra-doc links, thus they need
> the link destination.
>
> Thus fix it.
>
> Cc: stable@vger.kernel.org
> Link: https://github.com/rust-lang/rust/pull/132748 [1]
> Fixes: 78418f300d39 ("rust/kernel: Add faux device bindings")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

