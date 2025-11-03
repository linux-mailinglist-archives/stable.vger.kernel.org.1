Return-Path: <stable+bounces-192177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BC4C2B0BA
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 11:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6A504F2295
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 10:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D692FD7DA;
	Mon,  3 Nov 2025 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t3psV4M8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20AF2FDC24
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165651; cv=none; b=DSOF3WELLYb6vG5qlk28TJXvZ+AAAdx/2onyI5y91rlOQXSgK845+erN3u/N5DbnD8ICBFSmPpCamPnJqJWTfbXRr3kt7LqLJr5m80Vr0ImkH9xK/25CBis4+zvYkil086/AjOun7hh7Xp/Bk/g9WF82nlgyY5/7VuY2dsqGOj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165651; c=relaxed/simple;
	bh=7d+yejdsrlH3QQoIfQu3T9oGfryOAb9jPCpBbY/QV74=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kpzvR6E5P3Ay7gofa/0Iu51wJjRq9aJivBkOmSLD4YY8mg6fcysrcg0G7IsOZHyaM9ZZuq5gJudVo1vbmY8qWZC3xeIy1hsfMD2jCTm6Vwm6xlJ0+reu4foOFsaFP5Nk57MekX+TvRnTCRYvu0k1pW0BATAhO0ZBAj4rs18PwHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t3psV4M8; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-471001b980eso28559065e9.1
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 02:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762165647; x=1762770447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4JHB89kHBneKoONN1Bve8Z56wcJWNGQNkd4dI7+uRh8=;
        b=t3psV4M8sBiC5wL0AKipN6A3IrlFy0APywoz2aiucWz2VlZzGGW62hvg1om5xxf1Fd
         jkpcPT+k36GmhFs5gVUIHAS+fIGtZK5uYYAt3Hm3ZiIN7a1wBNICHYAu7+0zsAWcFpbQ
         H+rkZLZMdKms592MzVJbfytz/8YOK65QQK6XBDrKDxBgdR8nEYA2ZMV2cPEQ90hL7OBt
         QRcPM2LKD9SIiD3hiaoD1uyOwe5f2+kLhk0bczMPORe8pWHX6/nQ1qC517fFB1jr2ipz
         vfCJzyilaeUPK4zXEc5S7pld8HT/FBKVhFd7tmU25nC2f/MdR1JPDBzTUBlHTJfQIf9J
         7o9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165647; x=1762770447;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JHB89kHBneKoONN1Bve8Z56wcJWNGQNkd4dI7+uRh8=;
        b=WtURgl0/P0nAfoNoTrp03GtjBCetJdhtL3Qcu5tI5sc5BR76/m3Z5FonzJU9aESeUg
         bCNppvbyW34gZGIbNYsQzFoLVhLD0hyupOA+24H6u/lHv+ZYE3bY6tUBv28wEw06+C0A
         Tx1Ij8GO1KN99iUA8xJCPH4o+QZhDJbCw2c2Yh2Z1sbCiEFAl8bsc/O2eKqvOfZJQaKT
         FX72OOVBWrQJ/7BXf7ApsyHTB/bodvSgxRMDZZMB9mMTX5qPyq6spV51jWWGHzLffdl3
         ALXN++cZA9PTXCbuV58qAxTpWYd9wcptlzwIHQj1gLrRspbJWae0EcBFvbkFhnrfWG0w
         /FyA==
X-Forwarded-Encrypted: i=1; AJvYcCUZBOAXeGmBbZS7D4T3KG432nbmaMokgcD59hoJdV8eJSzVh6Vsl0z6rN1xBwC+Ib+yZAeq26Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhiE+l3kVG3C35rnmv+coORZIwpL76XjN2/7vTcZFI8kNz7P0g
	pZj16GJZw5FLKqD4Tuhf/Ay0M8B4ISToJ0A8X7+WoYeEsUljs1Iu1IoilLD6YUYuwZ4pu+M2aWB
	87LJyOdOXf128myr/Qw==
X-Google-Smtp-Source: AGHT+IEOG3seXsKMf1FLja+ssKrdPSGK1FgK6Bcd/d5/Kurpa+pvamoJuJNwVwnI8+e1f24CsMe+Xpt2EsZzMZQ=
X-Received: from wmlf12.prod.google.com ([2002:a7b:c8cc:0:b0:477:d21:4a92])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:538e:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-47730890e99mr120076125e9.32.1762165647584;
 Mon, 03 Nov 2025 02:27:27 -0800 (PST)
Date: Mon, 3 Nov 2025 10:27:26 +0000
In-Reply-To: <20251102212853.1505384-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251102212853.1505384-1-ojeda@kernel.org>
Message-ID: <aQiDjuHK0qpgmj1J@google.com>
Subject: Re: [PATCH 1/2] rust: kbuild: treat `build_error` and `rustdoc` as
 kernel objects
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Sun, Nov 02, 2025 at 10:28:52PM +0100, Miguel Ojeda wrote:
> Even if normally `build_error` isn't a kernel object, it should still
> be treated as such so that we pass the same flags. Similarly, `rustdoc`
> targets are never kernel objects, but we need to treat them as such.
> 
> Otherwise, starting with Rust 1.91.0 (released 2025-10-30), `rustc`
> will complain about missing sanitizer flags since `-Zsanitizer` is a
> target modifier too [1]:
> 
>     error: mixing `-Zsanitizer` will cause an ABI mismatch in crate `build_error`
>      --> rust/build_error.rs:3:1
>       |
>     3 | //! Build-time error.
>       | ^
>       |
>       = help: the `-Zsanitizer` flag modifies the ABI so Rust crates compiled with different values of this flag cannot be used together safely
>       = note: unset `-Zsanitizer` in this crate is incompatible with `-Zsanitizer=kernel-address` in dependency `core`
>       = help: set `-Zsanitizer=kernel-address` in this crate or unset `-Zsanitizer` in `core`
>       = help: if you are sure this will not cause problems, you may use `-Cunsafe-allow-abi-mismatch=sanitizer` to silence this error
> 
> Thus explicitly mark them as kernel objects.
> 
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
> Link: https://github.com/rust-lang/rust/pull/138736 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

