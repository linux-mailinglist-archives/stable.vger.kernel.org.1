Return-Path: <stable+bounces-164767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D36AB1252C
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 22:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB8C4E51E9
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 20:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8622566E2;
	Fri, 25 Jul 2025 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDeRoH/F"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD76255E2F
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753474491; cv=none; b=bed1kkk7/ZlBAfuW1aMJEZmaZaURia0540ijlL7J7RpFCEhMFnmUdCyCRN9jroqNYN2CPWEWnOGGwe9KnS18zekX8PhTTU8yE0AiFood6/dCo2Xxb/u5QvLklDDUoc5j5nfaPPClD+U/mGUUG62YAfW3fDEWHvZIhjozyI1EGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753474491; c=relaxed/simple;
	bh=W8En5YVahiIqAXZRZWKikH8YlFKQLtOO33N3HvosJGc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lEqPUdmOkhcUrWYThvfk4LzsXIEp85k3HMolAoV/TYeXlghlJHlr6CyRC8vjaibpiomcFnsWZPaoPV1dL7nSRrWWL5zH/p7drpDAnMM/LI9zUtkY13EES3Vmo4+COJzIrYEOuXJguuNA19O3is1EljPa2419mlz+pwKwUMRgFUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDeRoH/F; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7642db47111so23685b3a.2
        for <stable@vger.kernel.org>; Fri, 25 Jul 2025 13:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753474489; x=1754079289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zL6E1XMML0yY50F6CnyrCMs/HMD9bRXke5UG9jzuTl0=;
        b=aDeRoH/FTJ6GWlJMvjbA0XxeprcHRRq871hAAsKTW1x543RR3iJNwTTBNB2Qvr9o4N
         8pkWkjLrNHvX/zbIIjss8nyPM18u7g0LsVg+kdsF0xk/GgwOfi9g3NR36zaNt3Qti+dO
         0F1RzFNnenkv+5PeCDDWH5eh7dyRxXWAvjclj4M+eq0vQOE9iF+q0xW8lT6SONxsbDwT
         3KYXE8MV87RizwO7M28WwzfWOQZH1U7BUOA727Tj+TTYKz4zbXXMqlvvlFwVNE4SwkiI
         Aj/hjNe7EdhNc0C7ArFRbE1BIdtNc6S+mvmLJTRFb3jQ8ZzfoWov/Y5pCTGQFIClpYhl
         ld0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753474489; x=1754079289;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zL6E1XMML0yY50F6CnyrCMs/HMD9bRXke5UG9jzuTl0=;
        b=JwwwIlgR8D2M9SJ+0D8m3fomxssvpLyzLXapDzzrJFISQRl6I7qG+uvif+XBz8e3rb
         erRn0v2ZL6cVRgvPIterGp2Ys04VarUTRN/MT2IeG2Uip/UfNCGjKUZpVv9UZeoytCJN
         ycRcR3kR4Qt6GlbRrJC0aYemjcWyZV+bSEQYZNuqxHzg251iB6a2r/2vtkOZVun81Mtr
         H4wtEbEGCxpBTij/x3FVE27bKUP+1A1zaFIkU+9VjCqTMSukF7HZ0PA7GphgC07cjeYT
         6OA3YLMlngKSsfnmv5bFwngRSXcA8AkPR1Y33lTAKSn6HzI+y0h3qGFRb6t2gqwQXsvU
         glDQ==
X-Gm-Message-State: AOJu0YzVnsgHHtspRQ4YJ/S0rw+YAr9DAx6YdSh/G+bHIGKaGfmBoSaA
	ZHyZ6DUbGVFc8RSCFO6spR40Nq8IN1lCKkf3kKtxV0Y9awoIG8uJwAUgRn7AXVKzmJN+f0ef7WV
	0To9arrhcQEadOTwoWBq6PuSA5R8BRZLsDUhTJNI=
X-Gm-Gg: ASbGnctOn3n2n86s0CmQA+rVrlbFQrxHzVR6jT6E1YuosVKj1ESm8w2JKNchSMFNUT6
	3ICUVBuyU3qZgapQ0j1rUz296I07RSiUh54gPkNLa4JPvdzUAz6d6SSPfqAqdxqWWF6X5F9ZCC1
	evIJciQBNf/JvhqMorXwvV0yQuqL0KPlAwcPcCYyPTt8HEx1KaY644/IgeYefcE+1DxxRIflVlY
	7D8gTbo9LwCEGXZzSM=
X-Google-Smtp-Source: AGHT+IEsrJ3MX7Wd5Nt82J30ckPSe/2u3GNVCE3tdLj9h7HJ5fhe9j+4BP8vimXTacLANsT5zZbbCOySCE47xuAWx7g=
X-Received: by 2002:a17:902:d2c4:b0:234:c549:da0c with SMTP id
 d9443c01a7336-23fb2ecc334mr21225735ad.0.1753474489299; Fri, 25 Jul 2025
 13:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 25 Jul 2025 22:14:37 +0200
X-Gm-Features: Ac12FXwDZJNjcK-l7H9AZNyh1_SpZmDT3abv-P0chE6UIXA86mfMOdcJrb2kuAc
Message-ID: <CANiq72koQ28Z+-gx5ZmAeGFMLSsN5PfFawRkbGvEsUskp==F2w@mail.gmail.com>
Subject: f0915acd1fc6060a35e3f18673072671583ff0be for 6.12.y
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Sasha,

Please consider commit f0915acd1fc6 ("rust: give Clippy the minimum
supported Rust version") for 6.12.y. It should cherry-pick

It will clean a lint starting with Rust 1.90.0 (expected 2025-09-18)
-- more details below [1]. Moreover, it also aligns us with 6.15.y and
mainline in terms of Clippy behavior, which also helps.

It is pretty safe, since it is just a config option for Clippy. Even
if a bug were to occur that somehow broke it only in stable, normal
kernel builds do not use Clippy to begin with.

Thanks!

Cheers,
Miguel

[1]

Starting with Rust 1.90.0 (expected 2025-09-18), Clippy detects manual
implementations of `is_multiple_of`, of which we have one in the QR
code panic code:

    warning: manual implementation of `.is_multiple_of()`
       --> drivers/gpu/drm/drm_panic_qr.rs:886:20
        |
    886 |                 if (x ^ y) % 2 == 0 && !self.is_reserved(x, y) {
        |                    ^^^^^^^^^^^^^^^^ help: replace with: `(x
^ y).is_multiple_of(2)`
        |
        = help: for further information visit
https://rust-lang.github.io/rust-clippy/master/index.html#manual_is_multiple_of
        = note: `-W clippy::manual-is-multiple-of` implied by `-W clippy::all`
        = help: to override `-W clippy::all` add
`#[allow(clippy::manual_is_multiple_of)]`

While in general `is_multiple_of` does not have the same behavior as
`b == 0` [2], in this case the suggestion is fine.

However, we cannot use `is_multiple_of` yet because it was introduced
(unstably) in Rust 1.81.0, and we still support Rust 1.78.0.

Normally, we would conditionally allow it (which is what I was going
to do in a patch for mainline), but it turns out we don't trigger it
in mainline nor 6.15.y because of the `msrv` config option which makes
Clippy avoid the lint.

Thus, instead of a custom patch, I decided to align Clippy here by
backporting the config option instead.

Link: https://github.com/rust-lang/rust-clippy/issues/15335 [2]

