Return-Path: <stable+bounces-192388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1172C313FB
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 14:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7B9461B4C
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 13:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFE4327215;
	Tue,  4 Nov 2025 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMXR0jAr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B13271E3
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762263265; cv=none; b=jCJvbbuzWigQhKIsjVe/ICIt61koH7AFE3TMl7XjSH1YtKsLyQNlKZfJj2X2cN04332PVZ4M750UDk+hjoSv/I68iyRW8ZhOQFhcFapml9ha5lngAwKYkqjoL6QEG7J2KbPUUyzlS//SdFQ2HOvHJlhMZrjCgG8OOceAvNGm170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762263265; c=relaxed/simple;
	bh=fgXjreU/d6B4wT9czYd6r1mnrrDdEzd+sPet3bhyD1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJ1j6SrpxbYJz6HHEou1F9ES36cHfmAgUZE9AtYojH4+L2T2RP65LtoSBRDgZGxQgH07r5Gg9ChaY/V215yavW5e6KRGpLg/26bDX3rweXhpH5vkiO8E50NR2ZdHOlmDWuxHW55KvbPw2WEKgwt74WqkNMnnK9eW6uc/pOQIIXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMXR0jAr; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-340ad724ea4so541970a91.0
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 05:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762263263; x=1762868063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1b1+G19W5c9SO+X3X+h5Vdbtb4Mq0xgTVAQSLdiNp04=;
        b=ZMXR0jArt4T4iGOyuk4x9KHCzLkMcDJXaBKQt7nS8NQc7+3NHxdmfmcXb0qco7fIHz
         LdF5SOmCK5SqXgsh+CnU3KvjeO18cYEqZ13yR4BopdOwEIgp0Lre5niNXA/9r8DBbo3X
         NbyU/wumWA8s1Shn/SeIFtYMyvRp3Sy3rZ7bl0mNJHzc3P0Nklbi9im25LqSk04z7rtj
         QZJhbeP/g6RsG3OCR5uAk/Yok13UUlDP7NtqeY5qZlhpWrwh28FeFugmTkBnUVdwX1Fk
         XmNj27a0PWlZnJd6ITMDfkF7nNsIPph29rBlf8qk8fHqMvDyQJsDMX1Ebqaq1m+2k0l1
         d5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762263263; x=1762868063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1b1+G19W5c9SO+X3X+h5Vdbtb4Mq0xgTVAQSLdiNp04=;
        b=UfzISaDtOo9+eMa9ZIty8WdTQPS5DH6cEq+VNEBWI+n8rBG79Qq8dERzDrjAomcayQ
         8tqW82fM46qPgdqPE1qYX0q1e9ZxEEtl/ts9deb034G2DE71r1suUu/vRdYQ2X4I0Ekq
         EeGaLLS/yIMb6fhoY4s0/f/udbhIcMHCnv9xeTsF77Hfp8ZZbUdm5BQlQ7A1llVBprry
         pE/Rc10AdYJ2Lt+HRwaU1O/p5MRp5RWuq3awiu8muUnOx4QpoEyotlTcuqrgrT2pSfEy
         8FFXbxjTTtqshBoIITTtmi4BuniJGzi2W0LRNTsc+T2tX+7Fs50Zsk78fkQGO0I3o+gz
         Xl2A==
X-Gm-Message-State: AOJu0YzjOW3ST/rHWnsUXNB2a/jkw8SX0bFp2P/tRZ/oMyUYpgK4O+z8
	wcuuUJLCGwnuCezOsSAKN1RmypdtwbdkJWILXhjrXmx+cWUF73gi8xUUQqBZRa3r4/07NxYG9BL
	m8q0XrWC4qhW+yKOg3T5AIe9BNZVUS/rIp7Q6
X-Gm-Gg: ASbGncvpLyn8gBtveATnuZqtULIspZv/P5yy900OEBzJou86oJbUaSRlqX9a0B/1LKr
	ATfr8+qE5icpinWn5Y3Rx7LAyo059nr46hmABWfrEuOhyixf0/MLDKfx/p1+9lxHtW0Q5kgjMit
	VAxKC0nfUiIVgk5NVj85wJHL4wSOfXjQrIRp85WAqQrUq1x2/Be+Bv1w7BfxnmSeD3WBtoY3VEA
	p/KD860tkFuechkkTmTbZdDuZDPCgavU3/RVOnhBeD3Hhv/8J1TgtdJNVgWtlS76MH7zqCv5CnS
	F7g9+LqBLEXG/KrPt3JK/B5E+yASHlG4VGC15y3g3TitZIjzoicMRiB9EmDmtm7Vo9DKc1Bhiqd
	Oj4+4CeA+lZSyRg==
X-Google-Smtp-Source: AGHT+IGq8mPszldRNGy3uhJ4m6ZAHmBdaOTWdagO3oJB/0r81NAg5yEEsYzY0+PsE/hQHwARmPvIreshnF8WQ67X1K0=
X-Received: by 2002:a17:903:2346:b0:295:586a:764f with SMTP id
 d9443c01a7336-295586a790emr80351095ad.11.1762263262840; Tue, 04 Nov 2025
 05:34:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104131650.98549-1-sashal@kernel.org>
In-Reply-To: <20251104131650.98549-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 4 Nov 2025 14:34:09 +0100
X-Gm-Features: AWmQ_bklogXmpPR0_4YGOr6oLtd25Dk1DVGEoaJA1siysMTqPWHljghxNts1i80
Message-ID: <CANiq72m+bKD7gF7JY_xzTAPHoy06NSwKf16XTOK2nrNzJ3e1mw@mail.gmail.com>
Subject: Re: Patch "rust: kunit: allow `cfg` on `test`s" has been added to the
 6.17-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, ent3rm4n@gmail.com, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <raemoar63@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 2:16=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> This is a note to let you know that I've just added the patch titled
>
>     rust: kunit: allow `cfg` on `test`s
>
> to the 6.17-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      rust-kunit-allow-cfg-on-test-s.patch
> and it can be found in the queue-6.17 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

It probably doesn't hurt, but if we don't have any test that needs it,
then we could skip it, i.e. it is essentially a feature.

Thanks!

Cheers,
Miguel

